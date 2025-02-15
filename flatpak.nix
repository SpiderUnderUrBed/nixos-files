# home.nix
#<<<<<<< HEAD
#{ lib, ... }: {

  # nix-flatpak setup
#  services.flatpak.enable = true;

#=======
{ lib, pkgs, inputs, ... }:
let
inherit (inputs) sober;
#soberPatchedPath = pkgs.writeText "sober.flatpakrepo" (
#    builtins.replaceStrings ["[Flatpak Ref]"] ["[Flatpak Repo]"] (builtins.readFile sober.outPath)    
#);
in
{

  # nix-flatpak setup
  services.flatpak.enable = true;
#>>>>>>> cdcb124 (Initial commit)
  services.flatpak.remotes = lib.mkOptionDefault [
        {
        name = "gol"; location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
        } 
        {
        name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
        {
        name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; 
        }
#<<<<<<< HEAD
#=======
       #{
       # name = "sober";  location = "file://${soberPatchedPath}";
       # }
#>>>>>>> cdcb124 (Initial commit)
        #{
        #name = "kdeapps"; location = "https://distribute.kde.org/kdeapps.flatpakrepo";
        #}
#       {
#       name = "kdeapps"; location = "https://cdn.kde.org/flatpak/kde-runtime-nightly/org.kde.Platform.flatpakref";
#       }
#        ];
];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = true;
  #services.flatpak.uninstallUnmanagedPackages = true;
  services.flatpak.packages = [
#<<<<<<< HEAD
	#{ appId = "moe.launcher.the-honkers-railway-launcher"; origin = "gol"; }
	#{ appId = "moe.launcher.an-anime-game-launcher"; origin = "gol"; }
#=======
	{ flatpakref = "file:///home/spiderunderurbed/sober.flatpakref"; sha256="54546f6e843b219c180d0bc47168a63ae9e8eef223fb9133b4ebf1087bf048de"; }
	#{ flatpakref = "file:///home/spiderunderurbed/org.gnome.Snapshot.flatpakref"; sha256="7f989f68294ccd11ec61c53872092e2bf7fbb6cef9fcb7ac453ca8f62398da9a"; }
#	{ appId = "org.vinegarhq.Sober"; origin = "sober"; }
#	{ appId = "moe.launcher.the-honkers-railway-launcher"; origin = "gol"; }
	#{ appId = "moe.launcher.an-anime-game-launcher"; origin = "gol"; }
#>>>>>>> cdcb124 (Initial commit)
#	"org.emilien.Password"
	#"com.bktus.gpgfrontend"
	#"net.ankiweb.Anki"
	"org.openscad.OpenSCAD"
	"org.gnome.Snapshot"
	#"org.gnome.Cheese"
	"io.appflowy.AppFlowy"
	"org.vinegarhq.Vinegar"
	"chat.simplex.simplex"
	"net.minetest.Minetest"
	"io.github.mpobaschnig.Vaults"
#	"io.github.david_swift.Flashcards"
	#"com.github.phase1geo.minder"
	"com.belmoussaoui.Decoder"
	#"io.gitlab.librewolf-community"
	"dev.vencord.Vesktop"
	"com.rafaelmardojai.Blanket"
	"io.gitlab.idevecore.Pomodoro"
	"org.inkscape.Inkscape"
	"com.github.eneshecan.WhatsAppForLinux"
	"org.signal.Signal"
	"org.kde.knights"
#	"org.gnome.Chess"
	"com.opera.Opera"
#c	"org.gnome.Calendar"
#	"org.nickvision.tubeconverter"
	#"org.freedesktop.Platform.VulkanLayer.MangoHud"
#	"io.kapsa.drive"
#	S3 ^
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
	#"sa.sy.bluerecorder"
	"org.kde.kdenlive"
	"im.fluffychat.Fluffychat"
	"org.kde.krita"
#	"com.system76.Popsicle"
	"xyz.xclicker.xclicker"
        "com.github.tchx84.Flatseal"
        "com.obsproject.Studio" 
        "org.gimp.GIMP"
	"com.visualstudio.code"
#<<<<<<< HEAD
#	"net.brinkervii.grapejuice"
#	"org.vinegarhq.Vinegar"
#	"org.qbittorrent.qBittorrent"
#=======
#	"net.brinkervii.grapejuice"
#	"org.vinegarhq.Vinegar"
	"org.kde.kclock"
	"io.appflowy.AppFlowy"
	"org.kde.kcolorchooser"
	"org.wireshark.Wireshark"
	"org.gnome.Calculator"
	"org.gnome.Calendar"
	"org.qbittorrent.qBittorrent"
	"org.nickvision.tubeconverter"
	"de.haeckerfelix.Shortwave"
#>>>>>>> cdcb124 (Initial commit)
    #{ appId = "com.brave.Browser"; origin = "flathub"; }
    #"com.obsproject.Studio"
    #"im.riot.Riot"
  ];

}
