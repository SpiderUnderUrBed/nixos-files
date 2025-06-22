{ stdenv, lib, fetchFromGitHub, kernel, kmod }:
stdenv.mkDerivation rec {
  name = "acer-predator-turbo-and-rgb-keyboard-linux-module-${version}-${kernel.modDirVersion}";
  version = "main";

  src = fetchFromGitHub {
    owner = "JafarAkhondali";
    repo = "acer-predator-turbo-and-rgb-keyboard-linux-module";
    rev = version;
    sha256 = "sha256-RKqe3kHZ32Pv+6skP4x+sB+c4dlyES0Bu2C73LvkgqQ=";
    #sha256 = "sha256-8Wa01nB3Peor0GkstetPf8pljY6chYp+GyoA/pqbpuM=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  # Use a writable build directory for temporary files
  preBuild = ''
    export buildRoot="$PWD/build"
    mkdir -p "$buildRoot"
  '';

  makeFlags = [
    "-C" "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(PWD)"
    "O=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" # Point to kernel build output
    "BUILD_TMP_DIR=$buildRoot" # Redirect temp files
  ];

  buildFlags = [ "modules" ];

  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];

  meta = with lib; {
    description = "Improved Linux driver for Acer RGB Keyboards";
    homepage = "https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
