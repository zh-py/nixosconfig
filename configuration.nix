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
  #boot.extraModprobeConfig = ''
    #options hid_apple fnmode=1
  #'';

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Dar_es_Salaam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [libpinyin];
    #type = "fcitx5";
    #fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
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

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "py";
  services.displayManager.sddm.enable = true;

  # Configure keymap in X11 37
  services.xserver = {
    enable = true;
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

    #displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY && /etc/profiles/per-user/py/bin/fusuma -d"; #use which to find out the path.
    displayManager.sessionCommands = "/etc/profiles/per-user/py/bin/fusuma -d"; #use which to find out the path.
  };


  #services.xremap = {
    #yamlConfig = ''
      ##nothing for now
    #'';
  #};

  environment.variables = {
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
  #users.groups.keyd.name = "keyd";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            "102nd" = "leftshift";
          };
        };
        extraConfig = ''
          \=enter
          enter=\
          leftmeta = layer(meta_mac)
          rightmeta = layer(meta_mac)
          [meta_mac:C]
          1 = A-1
          2 = A-2
          3 = A-3
          4 = A-4
          5 = A-5
          6 = A-6
          7 = A-7
          8 = A-8
          9 = A-9
          space = M-space
          backspace = delete
          # Copy
          c = C-insert
          # Paste
          v = S-insert
          # Cut
          x = S-delete

          ## Move cursor to beginning of line
          #left = home
          ## Move cursor to end of Line
          #right = end
          left=A-left
          right=A-right
          up=A-up
          down=A-down

          # As soon as tab is pressed (but not yet released), we switch to the
          # "app_switch_state" overlay where we can handle Meta-Backtick differently.
          # Also, send a 'M-tab' key tap before entering app_switch_sate.
          tab = swapm(app_switch_state, M-tab)

          # Meta-Backtick: Switch to next window in the application group
          # - A-f6 is the default binding for 'cycle-group' in gnome
          # - keybinding: `gsettings get org.gnome.desktop.wm.keybindings cycle-group`
          ` = A-f6

          # app_switch_state modifier layer; inherits from 'Meta' modifier layer
          [app_switch_state:M]

          # Meta-Tab: Switch to next application
          # - keybinding: `gsettings get org.gnome.desktop.wm.keybindings switch-applications`
          tab = M-tab
          right = M-tab

          # Meta-Backtick: Switch to previous application
          # - keybinding: `gsettings get org.gnome.desktop.wm.keybindings switch-applications-backward`
          ` = M-S-tab
          left = M-S-tab

          # https://github.com/canadaduane/my-nixos-conf/blob/main/system/keyd/keyd.conf#L80C1-L83C14
          #shift = layer(meta_mac_shift)
          #[meta_mac_shift:C-S]
          ## Highlight to beginning of line
          #left = S-home
          ## Highlight to end of Line
          #right = S-end
          [meta_mac+shift]
          h=M-S-h
          l=M-S-l
          c=C-S-c
          v=C-S-v
        '';
      };
    };
  };

          #[meta]
          #f=C-f
          #q=C-q
          #w=C-w
          #r=C-r
          #t=C-t
          #x=C-x
          #v=C-v
          #c=C-c
          #l=C-l
          #-=C--
          #==C-=
          #[meta+shift]
          #t=C+S+t
          #[meta_mac+shift]
          #h=M-S-h
          #l=M-S-l
  #services.input-remapper = {
    #enable = true;
  #};

  #systemd.user.services.set-xhost = { #114
    #description = "Run a one-shot command upon user login";
    #path = [ pkgs.xorg.xhost ];
    #wantedBy = [ "default.target" ];
    #script = "xhost +SI:localuser:root";
    #environment.DISPLAY = ":0.0"; # NOTE: This is hardcoded for this flake
  #};
  #services.xremap = {
    #withX11 = true;
    ##yamlConfig = ''
      ##keymap:
        ##- name: Google
          ##application:
            ##only: Google-chrome
          ##remap:
            ##Super-1: C-1
            ##Super-2: C-2
    ##'';
    #config = {
      #modmap = [
        #{
          #name = "Global";
          #remap = { "KEY_ENTER" = "KEY_BACKSLASH"; };
          #remap = { "KEY_BACKSLASH" = "KEY_ENTER"; };
          ##remap = { "KEY_LSGT" = "KEY_LEFTSHIFT"; };
        #}
        #{
          #name = "Chrome";
          #remap = { "Super_L" = "Ctrl_L"; };
          #application.only = [ "Google-chrome" ];
        #}
      #];

      #keymap = [
        #{
          #name = "Global";
          #remap = {
            #"Super-Shift-T" = "C-Shift-T";
            #"Super-w" = "C-w";
            #"Super-q" = "C-q";
            #"Super-f" = "C-f";
            #"Super-t" = "C-t";
            #"Super-c" = "C-c";
            #"Super-x" = "C-x";
            #"Super-v" = "C-v";
            #"Super-r" = "C-r";
            #"Super-l" = "C-l";
            #"Super-Equal" = "C-Equal";
            #"Super-Minus" = "C-Minus";
            ##"Super-0" = ["C-0" "M-0"];
            ##"Super-1" = ["C-1" "M-1"];
            ##"Super-2" = ["C-2" "M-2"];
            ##"Super-3" = ["C-3" "M-3"];
            ##"Super-4" = ["C-4" "M-4"];
            ##"Super-5" = ["C-5" "M-5"];
            ##"Super-6" = ["C-6" "M-6"];
            ##"Super-7" = ["C-7" "M-7"];
            ##"Super-8" = ["C-8" "M-8"];
            ##"Super-9" = ["C-9" "M-9"];
            ##"Super-1" = "M-1";
            ##"Super-2" = "M-2";
            ##"Super-3" = "M-3";
            ##"Super-4" = "M-4";
            ##"Super-5" = "M-5";
            ##"Super-6" = "M-6";
            ##"Super-7" = "M-7";
            ##"Super-8" = "M-8";
            ##"Super-9" = "M-9";
            ##"Super-BTN_LEFT" = "C-BTN_LEFT";
          #};
        #}
        #{
          #name = "Chrome";
          #remap = {
            #"Super-1" = "C-1";
            #"Super-2" = "C-2";
            #"Super-3" = "C-3";
            #"Super-4" = "C-4";
            #"Super-5" = "C-5";
            #"Super-6" = "C-6";
            #"Super-7" = "C-7";
            #"Super-8" = "C-8";
            #"Super-9" = "C-9";
            #"Super-0" = "C-0";
          #};
          #application.only = [ "Google-chrome" ];
        #}
        #{
          #name = "Firefox";
          #remap = {
            #"Super-1" = "M-1";
            #"Super-2" = "M-2";
            #"Super-3" = "M-3";
            #"Super-4" = "M-4";
            #"Super-5" = "M-5";
            #"Super-6" = "M-6";
            #"Super-7" = "M-7";
            #"Super-8" = "M-8";
            #"Super-9" = "M-9";
            #"Super-0" = "M-0";
          #};
          #application.only = [ "firefox" ];
        #}
      #];
    #};
  #};


  ### Modmap for single key rebinds
  ##services.xremap.config.modmap = [
    ##{
      ##name = "Global";
      ##remap = { "KEY_ENTER" = "KEY_BACKSLASH"; };
      ##remap = { "KEY_BACKSLASH" = "KEY_ENTER"; };
      ##name = "Chrome";
      #remap = { "LEFTMETA" = "LEFTCTRL"; };
      #application.only = [ "Google-chrome" ];
    #}
  #];

  ## Keymap for key combo rebinds
  #services.xremap.config.keymap = [
    #{
      #name = "CMD";
      #remap = { "Super-tab" = "c-tab"; };
      #remap = { "Super-w" = "c-w"; };
      #remap = { "Super-q" = "c-q"; };
      #remap = { "Super-t" = "c-t"; };
      #remap = { "Super-c" = "c-c"; };
      #remap = { "Super-x" = "c-x"; };
      #remap = { "Super-v" = "c-v"; };
      ## NOTE: no application-specific remaps work without features (see configuration)
    #}
  #];


  services.libinput = {
    enable = true;
    touchpad.tapping = true;
    touchpad.naturalScrolling = true;
    touchpad.scrollMethod = "twofinger";
    touchpad.disableWhileTyping = true;
    touchpad.clickMethod = "clickfinger";
    touchpad.tappingDragLock = true;
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

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

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
        low_temp = 68;
        high_temp = 78;
        max_temp = 85;
        polling_interval = 9;
      };
    };
  };


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
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/bluez.conf" ''
          monitor.bluez.properties = {
            bluez5.default.rate = 44100
            bluez5.enable-sbc-xq = true
            bluez5.enable-hw-volume = true
            }
        '')
      ];
    };
  };


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" "Hack" ]; })
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
    #google-fonts
    corefonts
    wineWowPackages.fonts
  ];


  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.py = {
    isNormalUser = true;
    description = "py";
    extraGroups = [ "input" "networkmanager" "wheel" "docker" "keyd" ];
    packages = with pkgs; [
      firefox
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #nur.repos.wolfangaukang.vdhcoapp
    brightnessctl
    libimobiledevice
    ifuse
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
    #xorg.setxkbmap
    #xorg.xkbcomp
    #xorg.xhost # for gparted
    #xkeysnail
    #xfce.xfce4-dict
    xfce.xfce4-panel
    #xfce.xfce4-appfinder
    #xfce.xfce4-settings
    #xfce.xfwm4
    #xfce.xfce4-dict
    #xfce.xfce4-pulseaudio-plugin
    lxqt.lxqt-runner
    nm-tray
    playerctl
    qpwgraph
    #pavucontrol
    #pamixer
    #pw-volume
    font-manager
    #fontmatrix
    fontpreview
    keyd
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [

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
  networking.nftables.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 2283 ];
  networking.firewall.allowedUDPPorts = [ 2283 ]; # 2283:immich
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  services.v2raya.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  #services.logind.lidSwitch = "ignore";

}
