{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, autoAddDriverRunpath
, zlib
, zstd
, xorg
, linuxPackages
}:

stdenv.mkDerivation rec {
  pname = "ollama-cuda-bin";
  version = "0.33.2";

  src = fetchurl {
    url = "https://github.com/ollama/ollama/releases/download/v${version}/ollama-linux-amd64.tar.zst";
    sha256 = "sha256-l4UkfeomTZBy8J9snA60uOZmiSgmo9g4jro+j7ntHbk=";
  };

  nativeBuildInputs = [ autoPatchelfHook autoAddDriverRunpath zstd ];

  buildInputs = [
    stdenv.cc.cc.lib
    zlib
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libcuda.so.1"
    "libvulkan.so.1"
  ];

  sourceRoot = ".";

  unpackPhase = ''
    runHook preUnpack
    zstd -d --stdout $src | tar -xf -
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/lib
    cp -r bin/* $out/bin/
    cp -r lib/* $out/lib/ 2>/dev/null || true
    runHook postInstall
  '';

  meta = with lib; {
    description = "Ollama (official prebuilt binary, CUDA via system driver)";
    homepage = "https://ollama.com";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "ollama";
  };
}
