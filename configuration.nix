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
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
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
    displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY";
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.py = {
    isNormalUser = true;
    description = "py";
    extraGroups = [ "networkmanager" "wheel" ];
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
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    xorg.xmodmap
    xorg.xev
    xorg.setxkbmap
    xorg.xkbcomp
    xfce.xfce4-dict
    xfce.xfce4-panel
    xfce.xfce4-appfinder
    xfce.xfce4-settings
    xfce.xfwm4
    xfce.xfce4-dict
    xfce.xfce4-pulseaudio-plugin
    #ncpamixer
    pavucontrol
    #fvwm3
  ];

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
