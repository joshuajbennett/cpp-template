{
  description = "A template for Nix based C++ project setup.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/21.11";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"
  ] (system: let pkgs = import nixpkgs {
                   inherit system;

                   overlays = [];
                 };
             in {
               devShell = pkgs.mkShell rec {
                 name = "cpp-template";

                 packages = with pkgs; [
                   # Development Tools
                   llvmPackages_11.clang
                   cmake
                   cmakeCurses

                   # Development time dependencies
                   gtest

                   # Build time and Run time dependencies
                   spdlog
                   abseil-cpp
                 ];

                 # Setting up the environment variables you need during
                 # development.
                 shellHook = let
                   icon = "2744";
                 in ''
                    export PS1="$(echo -e '\u${icon}') \[$(tput sgr0)\]\[\033[38;5;27m\]\w\[$(tput sgr0)\]\[\033[38;1;32m\] [${name}] \\$ \[$(tput sgr0)\]"
                 '';
               };

               defaultPackage = pkgs.callPackage ./default.nix {};
             });
}
