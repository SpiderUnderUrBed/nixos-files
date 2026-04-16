{ lib, pkgs, inputs, ... }:
let
  inherit (inputs) sober;
in {

  # nix-flatpak setup
  services.flatpak.enable = true;
  
  services.flatpak.remotes = lib.mkOptionDefault [
    {
      name = "gol";
      location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
    }
    {
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;
  
  services.flatpak.packages = [
#   "chat.revolt.RevoltDesktop"
    "us.zoom.Zoom"
    "md.obsidian.Obsidian"
    "org.kde.kclock"
    "org.godotengine.Godot"
    "com.discordapp.Discord"
    "rocks.shy.VacuumTube"
    "org.luanti.luanti"
    "org.kde.kmymoney"
    "com.prusa3d.PrusaSlicer"
    "com.ultimaker.cura"
    "org.freefilesync.FreeFileSync"
    "org.vinegarhq.Sober"
    "org.prismlauncher.PrismLauncher"
    "org.openscad.OpenSCAD"
    "io.appflowy.AppFlowy"  # Removed duplicate
    "chat.simplex.simplex"
    "io.github.mpobaschnig.Vaults"
    "com.belmoussaoui.Decoder"
    "dev.vencord.Vesktop"
    "com.rafaelmardojai.Blanket"
    "io.gitlab.idevecore.Pomodoro"
    "org.inkscape.Inkscape"
    "com.rtosta.zapzap"
    "org.signal.Signal"
    "org.kde.knights"
    "me.proton.Mail"
    "com.opera.Opera"
    "org.blender.Blender"
    "com.rawtherapee.RawTherapee"
    "org.eclipse.Java"
    "org.rncbc.qpwgraph"
    "com.google.Chrome"
    "net.lutris.Lutris"
    "com.valvesoftware.Steam"
    "org.gnome.Notes"
    "io.github.seadve.Mousai"
    "org.torproject.torbrowser-launcher"
    "org.kde.kdenlive"
    "im.fluffychat.Fluffychat"
    "org.kde.krita"
    "net.codelogistics.clicker"
    "xyz.xclicker.xclicker"
    "com.github.tchx84.Flatseal"
    "com.obsproject.Studio"
    "org.gimp.GIMP"
    "com.visualstudio.code"
    "app.zen_browser.zen"
    "org.cubocore.CoreTime"
    "org.kde.kcolorchooser"
    "org.wireshark.Wireshark"
    "org.kde.kalk"
    "org.gnome.Calendar"
    "org.qbittorrent.qBittorrent"
    "org.nickvision.tubeconverter"
    "de.haeckerfelix.Shortwave"
  ];
}
