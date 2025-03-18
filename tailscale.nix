{ lib,
  stdenv,
  buildGo124Module,
  fetchFromGitHub,
  fetchpatch,
  makeWrapper,
  getent,
  iproute2,
  iptables,
  lsof,
  shadow,
  procps,
  nixosTests,
  installShellFiles,
  tailscale-nginx-auth,
}:

let
  version = "1.80.3";
in
buildGo124Module rec {
  pname = "tailscale";
  inherit version;

  outputs = [
    "out"
    "derper"
  ];

  src = fetchFromGitHub {
    owner = "tailscale";
    repo = "tailscale";
    rev = "3a4b62227654029384006b264ee21a9ab0e2d54b";
    hash = "sha256-5xzhD6KRbx4aPBohwd+k/6GO2O2vFP+/EHZVDcMEZb0=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/tailscale/tailscale/commit/327ea19746e7b0431a17562496dd0e708ab99abc.patch";
      hash = "sha256-QWnx92ANpbdtcP0y9s7Q8nJ/Zmqadw5kXAvw3/JXvu8=";
    })
  ];

  vendorHash = "sha256-SiUkN6BQK1IQmLfkfPetzvYqRu9ENK6+6txtGxegF5Y=";

  nativeBuildInputs = [
    makeWrapper
    installShellFiles
  ];

  env.CGO_ENABLED = 0;

  subPackages = [
    "cmd/derper"
    "cmd/derpprobe"
    "cmd/tailscaled"
    "cmd/tsidp"
  ];

  ldflags = [
    "-w"
    "-s"
    "-X tailscale.com/version.longStamp=${version}"
    "-X tailscale.com/version.shortStamp=${version}"
  ];

  tags = [
    "ts_include_cli"
  ];

  doCheck = false;

 postInstall =
  ''
    ln -s $out/bin/tailscaled $out/bin/tailscale
    moveToOutput "bin/derper" "$derper"
    moveToOutput "bin/derpprobe" "$derper"

    # Create environment file in the Nix store
    install -D -m 0644 /dev/null $out/etc/default/tailscaled
    echo "TS_DISABLE_RECENT_NOISE_DIAL_HEURISTIC=true" >> $out/etc/default/tailscaled
    echo "PORT=41641" >> $out/etc/default/tailscaled

    # Modify systemd service to use correct paths
    sed -i -e "s#/usr/sbin#$out/bin#" -e "/^EnvironmentFile/d" ./cmd/tailscaled/tailscaled.service
    sed -i '/^\[Service\]/a EnvironmentFile=$out/etc/default/tailscaled' ./cmd/tailscaled/tailscaled.service

    # Replace $out placeholder with the actual output path
    sed -i "s|\$out|$out|g" ./cmd/tailscaled/tailscaled.service

    # Install systemd service file
    install -D -m0444 -t $out/lib/systemd/system ./cmd/tailscaled/tailscaled.service

    # Completion installation
    installShellCompletion --cmd tailscale \
      --bash <($out/bin/tailscale completion bash) \
      --fish <($out/bin/tailscale completion fish) \
      --zsh <($out/bin/tailscale completion zsh)
  '';

  passthru.tests = {
    inherit (nixosTests) headscale;
    inherit tailscale-nginx-auth;
  };

  meta = with lib; {
    homepage = "https://tailscale.com";
    description = "Node agent for Tailscale, a mesh VPN built on WireGuard";
    changelog = "https://github.com/tailscale/tailscale/releases/tag/v${version}";
    license = licenses.bsd3;
    mainProgram = "tailscale";
    maintainers = with maintainers; [
      mbaillie
      jk
      mfrw
      pyrox0
    ];
  };
}
