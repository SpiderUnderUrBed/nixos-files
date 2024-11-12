{ gitCredentialManager ? {}, options ? {}, specialArgs ? {}, modulesPath ? {}, config, lib, pkgs }:
let
   hyprlandConfig = {
#     enable = true;
#     package = pkgs.hyprland;
     settings = {  
     "$terminal" = "konsole";
     "$dropterm"="kitty-dropdown";
      "exec-once" = [
      #  "[workspace special silent] foot -a quake"
        #"[workspace special; size 75% 20%;move 12.5% 40] kitty"
        (lib.getExe pkgs.waybar)
 	"${lib.getExe pkgs.copyq} --start-server"	
#	${lib.getExe pkgs.copyq} --start-server
	#(lib.getExe pkgs.copyq) --start-server
	#(lib.getExe pkgs.blue
        "${pkgs.blueman}/bin/blueman-applet"
        "${pkgs.networkmanagerapplet}/bin/nm-applet"
        "${pkgs.pasystray}/bin/pasystray"
        #[workspace special; size 75% 20%;move 12.5% 40] kitty
        "[workspace special; size 75% 20%;move 12.5% 40] kitty --class=kitty-dropdown"
      ];
        #[workspace special; size 75% 20%;move 12.5% 40] kitty
      #"$dropterm"="kitty-dropdown"
     "windowrule" = [
        "workspace 1,$dropterm"
        "float,$dropterm"
        "size 75% 20%,$dropterm"
        "move 12.5% -469,$dropterm"
     ];
 #    debug = { 
#       suppress_errors = true;
   #  };
    #bindsym XF86MonBrightnessUp exec swayosd-client --brightness raise
    #bindsym XF86MonBrightnessUp exec swayosd-client --brightness lower
     binde = [
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness lower"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
     ];
     bindle = [
        ",XF86AudioMute, exec, swayosd --output-volume mute-toggle"
     ];
     bind = [
#Super+C = kill window
        #"SUPER+SHIFT+LEFT,movewindow,mon:eDP-1"
        #"SUPER+SHIFT+RIGHT,movewindow,mon:HDMI-A-1"
        
        #"SUPER+tab,v,layoutmsg,preselect r"
        #"SUPER+tab,h,layoutmsg,preselect d"
        #[workspace special; size 75% 20%;move 12.5% 40] kitty
        #"SUPER+alt,k,[workspace special; size 75% 20%;move 12.5% 40] kitty --class=kitty-dropdown"
	"SUPER+alt,F1,killactive"
	#"SUPER+alt,F1,exec,bash ~/home-manager/silenceactive.sh"
        "SUPER+shift,v,exec,code"
        "SUPER+shift,s,exex,steam"
        "SUPER+ESCAPE,s,exec,systemctl suspend"
        "SUPER+alt,k,exec,konsole"
        "SUPER+alt,s,exec,hyprshot -m region --freeze"
        "SUPER,grave,exec,bash ~/home-manager/quake.sh"
        "SUPER+alt,m,exec,flatpak run im.fluffychat.Fluffychat"
        "SUPER+alt,right,movewindow,mon:r"
        "SUPER+alt,left,movewindow,mon:l"
        "SUPER+alt,V,exec,flatpak run dev.vencord.Vesktop"
        "SUPER,K,exec,hyprctl kill"
        "SUPER,L,exec,librewolf"
        "SUPER+F,1,fullscreen"
        "SUPER,F,fullscreen,1"  
     ];
     extraConfig = (builtins.readFile /etc/nixos/hyprland.conf);
     };
   }; 
in 
  hyprlandConfig
