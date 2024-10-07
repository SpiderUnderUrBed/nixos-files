{ stdenv, lib, fetchFromGitHub, kernel, kmod }:
stdenv.mkDerivation rec {
  name = " acer-predator-turbo-and-rgb-keyboard-linux-module-${version}-${kernel.modDirVersion}";
  version = "main";

  src = fetchFromGitHub {
    owner = "JafarAkhondali";
    repo = "acer-predator-turbo-and-rgb-keyboard-linux-module";
    rev = "${version}";
#    sha256 = "sha256-xwwQGeswpkvEn/gGObFwt2wgPeeRIa4PhXbWue5hqGQ=";
#    sha256 = "sha256-1U/UnMI1laE9ZEcftnby39qBdj/fOwTIUG7t1wW892c=";
#     sha256 = "sha256-VzirQUCjDHa/6W1nVVuNrUBoUp5AtDmRCpXwDQ+3DOA=";
     sha256 = "sha256-Aj+1zBiG/aemCzzUpmw4P+VlfjC0d0SOILMwmzqj1tc=";
  };

   setSourceRoot = ''
    export sourceRoot=$(pwd)/source
  '';
  nativeBuildInputs = kernel.moduleBuildDependencies;
  makeFlags = kernel.makeFlags ++ [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
  ];
  buildFlags = [ "modules" ];

#  preInstall = ''
#    mkdir -p $out/bin
#    cp $src/facer.py $out/bin/facer
#    chmod +x $out/bin/facer
#  ''; 

  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ]; 


  meta = with lib; {
    description = "Improved Linux driver for Acer RGB Keyboards ";
    homepage = "https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

