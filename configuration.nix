# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
#let
  #compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    #${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./path/to/layout.xkb} $out
  #'';
#in
let
 customKeyboardLayout = pkgs.writeText "custom-keyboard-layout" ''
    xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
	xkb_types     { include "complete"	};
	xkb_compat    { include "complete"	};
        partial
        xkb_symbols "swap" {
            include "pc+us+inet(evdev)+altwin(ctrl_win)"
            replace key <RTRN> { [ backslash, bar ] };
            replace key <BKSL> { [ Return, Return ] };
            replace key <LSGT> { [ Shift_L, Super_L ] };
        };
    };
  '';
  # Help catch errors in the custom keyboard layout at build time
  compiledKeyboardLayout = pkgs.runCommand "compiled-keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $out
  '';
in



{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Dar_es_Salaam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sw_TZ";
    LC_IDENTIFICATION = "sw_TZ";
    LC_MEASUREMENT = "sw_TZ";
    LC_MONETARY = "sw_TZ";
    LC_NAME = "sw_TZ";
    LC_NUMERIC = "sw_TZ";
    LC_PAPER = "sw_TZ";
    LC_TELEPHONE = "sw_TZ";
    LC_TIME = "sw_TZ";
  };

  #options = {
  #+    services.xserver.windowManager.fvwm3 = {
  #+      enable = mkEnableOption "Fvwm3 window manager";
  #+    };
  #+  };
  #services.xserver.windowManager.fvwm3.enable = true
  #services.xserver.desktopManager.default = "fvwm3";
  #services.xserver.desktopManager.session =
    #[ { manage = "desktop";
      #name = "fvwm3";
      #start =
        #''
          ##xmodmap ~/.Xmodmap
          #${pkgs.fvwm3}/bin/fvwm3 &
          #waitPID=$!
        #'';
      #}
    #];
  #services.xserver.displayManager.defaultSession = "fvwm3";
  #services.xserver.windowManager.fvwm3.enable = true;
  #services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY";

  # Configure keymap in X11 37
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    #displayManager = {
      #lightdm = {
        #enable = true;
        #greeters.slick = {
          #enable = true;
          #theme.name = "Zukitre-dark";
        #};
      #};
    #};
    desktopManager.lxqt.enable = true;
    #windowManager.icewm.enable = true;
    #windowManager.i3.enable = true;
    #xkb.layout = "us";
    #xkb.variant = "";
    #displayManager.sessionCommands = "xkbcomp dotfiles/mylayout.xkb $DISPLAY";
    #displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
    #displayManager.sessionCommands =
      #${pkgs.xorg.xmodmap}/bin/xmodmap "${pkgs.writeText  "xkb-layout" ''
          #keycode 51 = Return
          #keycode 36 = backslash bar
      #''}"
    #xkb.extraLayouts.mylayout = {
      #description = "swap Return and Backslash";
      #languages   = [ "eng" ];
      #symbolsFile = /etc/nixos/dotfiles/mylayout;
    #};

    # Load custom keyboard layout on boot/resume
    #displayManager.sessionCommands = "sleep 8 && ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY";
    #displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY && xmodmap /etc/nixos/dotfiles/.Xmodmap";
    #displayManager.sessionCommands = "sleep 5 && xmodmap -e 'keycode 51 = Return'";
    #displayManager.sessionCommands = "sleep 5 && xkbcomp mylayout.xkb ${customKeyboardLayout} $DISPLAY";
    #displayManager.defaultSession = "cinnamon-wayland";
    #displayManager.sessionCommands = "xkbcomp ${customKeyboardLayout} $DISPLAY";
    #displayManager.sessionCommands = "xmodmap -e 'keycode 51 = Return'";


#displayManager.sessionCommands =
  #${pkgs.xorg.xmodmap}/bin/xmodmap "${pkgs.writeText  "xkb-layout" ''
      #keycode 51 = Return
      #keycode 36 = backslash bar
  #''}"


    libinput = {
      enable = true;
      touchpad.tapping = true;
      touchpad.naturalScrolling = true;
      touchpad.scrollMethod = "twofinger";
      touchpad.disableWhileTyping = true;
      touchpad.clickMethod = "clickfinger";
      touchpad.tappingDragLock = true;
    };
    displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY && /etc/profiles/per-user/py/bin/fusuma -d"; #use which to find out the path.
  };

  #services.xserver.desktopManager.session =
    #[ { manage = "desktop";
        #start = ''
          #xmodmap /etc/nixos/dotfiles/.Xmodmap
        #'';
      #}
    #];



  ## Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.system76.power-daemon.enable = true;

  services.blueman.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0="60";
      STOP_CHARGE_THRESH_BAT0="80";
    };
  };

  services.mbpfan = {
    enable = true;
    settings = {
      general = {
        low_temp = 67;
        high_temp = 77;
        max_temp = 85;
        polling_interval = 7;
      };
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = false;
      support32Bit = false;
    };
    jack.enable = false;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 1024;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
    #wireplumber.enable = true;
    wireplumber = {
      enable = true;
      configPackages = [
	(pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
            ["bluez5.default.rate"] = 44100,
            ["bluez5.enable-sbc-xq"] = true,
            ["bluez5.enable-msbc"] = false,
            ["bluez5.enable-hw-volume"] = true,
            ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
	'')
      ];
      #extraLuaConfig.bluetooth."52-bluez-config" = ''
	#bluez_monitor.properties = {
          #["bluez5.default.rate"] = 44100,
          #["bluez5.enable-sbc-xq"] = true,
          #["bluez5.enable-msbc"] = false,
          #["bluez5.enable-hw-volume"] = true,
          #["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
	#}
      #'';
    };
  };


  #environment.etc = {
    #"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      #bluez_monitor.properties = {
        #["bluez5.default.rate"] = 44100,
        #["bluez5.enable-sbc-xq"] = true,
        #["bluez5.enable-msbc"] = false,
        #["bluez5.enable-hw-volume"] = true,
        #["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      #}
    #'';
  #};


  fonts.packages = with pkgs; [
    meslo-lgs-nf
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-han-sans-vf-ttf
    source-han-serif-vf-ttf
    source-han-sans
    source-han-serif
    #ark-pixel-font
    #zpix-pixel-font
    wqy_microhei
    helvetica-neue-lt-std
    aileron
    ubuntu_font_family
    fira
    #maple-mono
    jetbrains-mono
    paratype-pt-sans
    uw-ttyp0
    #tamsyn
    vistafonts
    #unscii
    gohufont
    xorg.xbitmaps
    #ucs-fonts
    #profont
    cozette
    terminus_font
    terminus_font_ttf
    roboto
    dina-font
    unscii
    tamzen
    envypn-font
    efont-unicode
    spleen
    ucs-fonts
    google-fonts
    corefonts
    wineWowPackages.fonts
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.py = {
    isNormalUser = true;
    description = "py";
    extraGroups = [ "input" "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "py";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    gsimplecal
    #linuxKernel.packages.linux_6_7.perf
    wmctrl
    xorg.xprop
    xdotool
    libinput-gestures
    libinput
    inxi
    linuxKernel.packages.linux_6_8.system76-power
    #coreboot-utils #ectool
    #xorg.xmodmap
    xorg.xev
    xorg.setxkbmap
    xorg.xkbcomp
    #xkeysnail
    #xfce.xfce4-dict
    #xfce.xfce4-panel
    #xfce.xfce4-appfinder
    #xfce.xfce4-settings
    #xfce.xfwm4
    #xfce.xfce4-dict
    #xfce.xfce4-pulseaudio-plugin
    lxqt.lxqt-runner
    nm-tray
    playerctl
    qpwgraph
    pavucontrol
    font-manager
    #fontmatrix
    fontpreview
  ];

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
           /run/current-system "$systemConfig"
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  #services.logind.lidSwitch = "ignore";

}
