# home.nix
{ lib, ... }:
inherit (inputs) sober;
soberPatchedPath = pkgs.writeText "sober.flatpakrepo" (
    builtins.replaceStrings ["[Flatpak Ref]"] ["[Flatpak Repo]"] (builtins.readFile sober.outPath)    
);
{

  # nix-flatpak setup
  services.flatpak.enable = true;
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
	{
        name = "sober";  location = "file://${soberPatchedPath}";
        }
        #{
        #name = "kdeapps"; location = "https://distribute.kde.org/kdeapps.flatpakrepo";
        #}
#       {
#       name = "kdeapps"; location = "https://cdn.kde.org/flatpak/kde-runtime-nightly/org.kde.Platform.flatpakref";
#       }
#        ];
];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanagedPackages = true;
  services.flatpak.packages = [
	{ appId = "org.vinegarhq.Sober"; origin = "sober"; }
	{ appId = "moe.launcher.the-honkers-railway-launcher"; origin = "gol"; }
	#{ appId = "moe.launcher.an-anime-game-launcher"; origin = "gol"; }
#	"org.emilien.Password"
	"io.gitlab.idevecore.Pomodoro"
	"org.inkscape.Inkscape"
#	"com.github.eneshecan.WhatsAppForLinux"
	"org.signal.Signal"
	"org.kde.knights"
#	"org.gnome.Chess"
	"com.opera.Opera"
#c	"org.gnome.Calendar"
	"org.nickvision.tubeconverter"
	"org.freedesktop.Platform.VulkanLayer.MangoHud"
	"io.kapsa.drive"
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
	"com.system76.Popsicle"
	"xyz.xclicker.xclicker"
        "com.github.tchx84.Flatseal"
        "com.obsproject.Studio" 
        "org.gimp.GIMP"
	"com.visualstudio.code"
#	"net.brinkervii.grapejuice"
#	"org.vinegarhq.Vinegar"
	"org.qbittorrent.qBittorrent"
	"org.nickvision.tubeconverter"
	"de.haeckerfelix.Shortwave"
    #{ appId = "com.brave.Browser"; origin = "flathub"; }
    #"com.obsproject.Studio"
    #"im.riot.Riot"
  ];

}
