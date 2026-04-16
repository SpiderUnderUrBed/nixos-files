{ lib, fetchurl, stdenvNoCC }:

let
  version = "10.0-19";
in stdenvNoCC.mkDerivation {
  pname = "dwproton";
  inherit version;

  src = fetchurl {
    url = "https://dawn.wine/dawn-winery/dwproton/releases/download/dwproton-${version}/dwproton-${version}-x86_64.tar.xz";
    hash = "sha256-XN9nx+tcHa9puXktkNXwIWwSQDCnz7bk+17ovW9zzWk=";
  };

  installPhase = ''
    mkdir -p $out/share/steam/compatibilitytools.d
    cp -r . $out/share/steam/compatibilitytools.d/dwproton-${version}
  '';

  meta = {
    description = "Dawn Winery's custom Proton fork with fixes for various games";
    homepage = "https://dawn.wine/dawn-winery/dwproton";
    license = lib.licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    maintainers = [];
  };
}
