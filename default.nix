{ lib
, llvmPackages_11
, cmake
, spdlog
, abseil-cpp
, ncurses #tput
}:

llvmPackages_11.stdenv.mkDerivation rec {
  pname = "cpp-examples";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ spdlog abseil-cpp ncurses ];

  cmakeFlags = [
    "-DENABLE_TESTING=OFF"
    "-DENABLE_INSTALL=ON"
  ];

  meta = with lib; {
    description = ''
      A template for Nix based C++ project setup.";
    '';
    licencse = licenses.mit;
    platforms = with platforms; linux ++ darwin;
    maintainers = [ maintainers.breakds ];
  };
}
