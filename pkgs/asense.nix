{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  pkg-config,
  wrapGAppsHook3,
  gtk3,
  webkitgtk_4_1,
  libsoup_3,
  glib-networking,
  xdotool,
  openssl,
  libayatana-appindicator,
  kmod,
  udev,
}:

rustPlatform.buildRustPackage rec {
  pname = "asense";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "fladirm";
    repo = "asense";
    rev = "v${version}";
    hash = "sha256-EfsCAOTaBmpxyK0CCItSqGGEhDr5/rvLq63CX+ZvsDw=";
  };

  cargoHash = "sha256-SWRNKT2TNHeWW/UVCtFhyan6VJbWVdEh9WaHIVBODTk=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook3
  ];

  buildInputs = [
    gtk3
    webkitgtk_4_1
    libsoup_3
    glib-networking
    xdotool
    openssl
    libayatana-appindicator
    udev
  ];

  buildNoDefaultFeatures = true;
  buildFeatures = [ "gui" ];
  cargoBuildFlags = [ "--bin" "asense" ];

  postBuild = ''
    cargo build --release --locked --offline \
      --target ${stdenv.hostPlatform.rust.rustcTargetSpec} \
      --bin asensed --no-default-features
  '';

  doCheck = false;

  postInstall = ''
    if [ -d assets ]; then
      install -Dm644 -t $out/share/asense assets/* 2>/dev/null || true
    fi
  '';

  meta = {
    description = "Native Linux control center for Acer Predator and Nitro laptops";
    homepage = "https://github.com/fladirm/asense";
    license = lib.licenses.gpl2Only;
    mainProgram = "asense";
    platforms = [ "x86_64-linux" ];
  };
}
