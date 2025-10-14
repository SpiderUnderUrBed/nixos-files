{ lib
, stdenv
, fetchFromGitHub
, fetchurl
, makeWrapper
, electron
, gcc
, glibc
, freerdp3
, usbutils
, libusb1
}:

let
  version = "0.8.7";
  
  # Clone the repository for icons and data files
  winboatSrc = fetchFromGitHub {
    owner = "TibixDev";
    repo = "winboat";
    rev = "v${version}";
    sha256 = "sha256-30WzvdY8Zn4CAj76bbC0bevuTeOSfDo40FPWof/39Es="; # Replace with actual hash after first build
  };
  
  usb_ids = builtins.toFile "usb.ids" (builtins.readFile "${winboatSrc}/data/usb.ids");
  iconFile = "${winboatSrc}/icons/icon.png";
in
stdenv.mkDerivation {
  pname = "winboat";
  inherit version;

  src = fetchurl {
    url = "https://github.com/TibixDev/winboat/releases/download/v${version}/winboat-${version}-x64.tar.gz";
    sha256 = "0wnbdnm1w59xyhw55bqac0jak16nvcs91qixnxyrnq2b46gpvmg0";
  };

  nativeBuildInputs = [
    makeWrapper
    freerdp3
    usbutils
    libusb1
  ];

  buildInputs = [
    electron
    gcc
    glibc
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share/winboat
    (cd . && tar cf - .) | (cd $out/share/winboat && tar xf -)

    cat > $out/bin/winboat <<EOF
#!/bin/sh
export LD_LIBRARY_PATH=${gcc}/lib:${glibc}/lib:${electron}/lib:${stdenv.cc.cc.lib}/lib:\$LD_LIBRARY_PATH
exec ${electron}/bin/electron $out/share/winboat/resources/app.asar "\$@"
EOF
    chmod +x $out/bin/winboat

    mkdir -p $out/share/icons/hicolor/256x256/apps
    mkdir -p $out/share/winboat

    cp ${iconFile} $out/share/icons/hicolor/256x256/apps/winboat.png
    cp ${iconFile} $out/share/winboat/icon.png

    # desktop entry
    mkdir -p $out/share/applications
    cat > $out/share/applications/winboat.desktop <<EOF
[Desktop Entry]
Name=WinBoat
Exec=$out/bin/winboat %U
Type=Application
Terminal=false
Icon=winboat
Categories=Utility;
EOF

    mkdir -p $out/share/winboat/data
    mkdir -p $out/share/winboat/resources/data
    cp ${usb_ids} $out/share/winboat/data/usb.ids
    cp ${usb_ids} $out/share/winboat/resources/data/usb.ids

    mkdir -p $out/lib/guest_server
    if [ -d guest_server ]; then
      cp -a guest_server/. $out/share/winboat/resources/guest_server/
      cp -a guest_server/. $out/share/winboat/guest_server/
      cp -a guest_server/. $out/lib/guest_server/
    elif [ -d resources/guest_server ]; then
      cp -a resources/guest_server/. $out/share/winboat/resources/guest_server/
      cp -a resources/guest_server/. $out/share/winboat/guest_server/
      cp -a resources/guest_server/. $out/lib/guest_server/
    else
      ls -la
      exit 1
    fi
  '';

  meta = with lib; {
    description = "WinBoat - Run Windows apps on Linux with seamless integration";
    homepage = "https://github.com/TibixDev/winboat";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}
