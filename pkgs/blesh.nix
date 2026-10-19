{
  lib,
  stdenvNoCC,
  fetchgit,
  runtimeShell,
  bashInteractive,
  glibcLocales,
  gnumake,
  gawk,
  git,
}:
stdenvNoCC.mkDerivation rec {
  pname = "blesh";
  version = "unstable-2025-01-09";
  
  src = fetchgit {
    url = "https://github.com/akinomyoga/ble.sh.git";
    rev = "refs/heads/master";
    fetchSubmodules = true;
    leaveDotGit = true;
    sha256 = "sha256-cKpw+5Xdsdy3UtxOw7bQz8h1ehiYbFcQobUGWXn5+Y4=";
#    sha256 = "sha256-/CQ3L2mt8OTsleMNWpZcFql6e8/+4nj+VGBt204wusQ=";
  };
  
  nativeBuildInputs = [
    gnumake
    gawk
    git
  ];
  
  postPatch = ''
    patchShebangs make_command.sh
  '';
  
  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';
  
  doCheck = true;
  nativeCheckInputs = [
    bashInteractive
    glibcLocales
  ];
  preCheck = "export LC_ALL=en_US.UTF-8";
  
  installPhase = ''
    runHook preInstall
    
    mkdir -p "$out/share/blesh/lib"
    cat <<EOF >"$out/share/blesh/lib/_package.sh"
    _ble_base_package_type=nix
    function ble/base/package:nix/update {
      echo "Ble.sh is installed by Nix. You can update it there." >&2
      return 1
    }
    EOF
    
    make install INSDIR="$out/share/blesh"
    
    runHook postInstall
  '';
  
  postInstall = ''
    mkdir -p "$out/bin"
    cat <<EOF >"$out/bin/blesh-share"
    #!${runtimeShell}
    echo "$out/share/blesh"
    EOF
    chmod +x "$out/bin/blesh-share"
  '';
  
  meta = {
    homepage = "https://github.com/akinomyoga/ble.sh";
    description = "Bash Line Editor -- a full-featured line editor written in pure Bash";
    mainProgram = "blesh-share";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [
      aiotter
      matthiasbeyer
    ];
    platforms = lib.platforms.unix;
  };
}
