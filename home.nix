#ln -s ~/Insync/pierrez1984@gmail.com/Dropbox/mac_config/home-manager ~/.config
{
  config,
  pkgs,
  lib,
  ...
}:
{
  #}: let
  #inherit (pkgs.lib) mkIf optionals;
  #tex = (pkgs.texlive.combine {
  #inherit (pkgs.texlive) scheme-full;
  #});
  #in {
  home.username = "py";
  home.homeDirectory = "/home/py";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    #nixos only
    fusuma
    firefox
    google-chrome
    tor-browser
    wechat-uos
    calibre
    nomacs
    gimp
    peazip
    libsForQt5.kio-extras
    libsForQt5.konsole
    libreoffice-qt6
    speedcrunch
    photoqt
    qview
    viewnior
    krusader
    xxdiff
    kdePackages.okular
    mupdf
    llpp
    zathura
    qpdfview
    telegram-desktop
    skypeforlinux
    gparted
    ventoy-full
    galculator
    qalculate-gtk
    playerctl
    bluetooth_battery
    texliveFull
    bar
    pv
    mediainfo-gui
    trashy
    maestral
    keepassxc
    #appimage-run
    #insync
    #zoom-us
    #rustdesk
    #goldendict-ng

    #share
    mc
    krename
    eza
    lsof
    tldr
    bandwhich
    octaveFull
    sagetex
    openblas
    exfatprogs
    progress
    calcurse
    hunspell
    #cava
    dmenu
    xsel
    libheif
    imagemagick
    powerstat
    lm_sensors
    nix-du
    nix-tree
    nix-index
    #unzip
    #unar
    graphviz
    gh
    yt-dlp
    bitcomet
    wordnet
    btop
    htop
    neofetch
    fastfetch
    du-dust
    fd
    ripgrep
    bat
    delta
    fontconfig
    glances
    bottom
    aria
    thefuck
    rclone
    syncthing
    nil
    nixfmt-rfc-style
    pyright
    ruff
    ruff-lsp
    luajitPackages.luacheck
    lua-language-server
    marksman
    tree-sitter
    tree-sitter-grammars.tree-sitter-python
    texlab
    obsidian
    spotify
    spotify-qt
    librespot
    spotifyd
    spotube
    vlc
    smplayer
    ffmpeg-full
    conda
    zotero_7
    netcdf
    netcdffortran
    mpich
    jasper
    libpng
    zlib
    gfortran
    libgcc
    tcsh
    sshfs

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    #(python314.withPackages (
    #p: with p; [
    #extractcode
    #]
    #))

    (python313.withPackages (
      p: with p; [
        py-cpuinfo
        pip
        numpy
        qtconsole
        sympy
        requests
        pandas
        matplotlib
        pytz
        tenacity
        timeout-decorator
        ipdb
        ipython
        pysnooper
        debugpy
        pynvim
        send2trash
        openpyxl
        jupyter
        pytest
        python-lsp-server
        python-lsp-ruff
        torch
        #extractcode
      ]
    ))
  ];

  services.fusuma = {
    # 97
    enable = true;
    extraPackages = with pkgs; [ xdotool ];
    #settings = ''
    #${builtins.readFile ./dotfiles/fusuma/settingconfig.yml}
    #'';
    #settings = builtins.readFile ./dotfiles/fusuma/config.yml;
    settings = {
      #threshold = { swipe = 0.1; };
      #interval = { swipe = 0.7; };
      swipe = {
        "4" = {
          left = {
            #command = "xdotool key ctrl+Right";
            #command = "xte 'keydown Control_L' 'key Right' 'keyup Control_L'";
            command = "ydotool key 29:1 106:1 106:0 29:0";
            threshold = 0.5;
            #interval = 0.75;
            interval = 0.8;
          };
          right = {
            #command = "xdotool key ctrl+Left";
            #command = "xte 'keydown Control_L' 'key Left' 'keyup Control_L'";
            command = "ydotool key 29:1 105:1 105:0 29:0";
            threshold = 0.5;
            #interval = 0.75;
            interval = 0.8;
          };
          up = {
            command = "xdotool key ctrl+alt+m";
            threshold = 0.2;
          };
        };
        "3" = {
          begin = {
            command = "ydotool click 40";
            interval = 0.0;
          };
          update = {
            command = "ydotool mousemove -- $move_x, $move_y";
            accel = 2;
            interval = 0.1;
          };
          end = {
            command = "ydotool click 80";
            interval = 0.0;
          };
        };
        #"3" = {
        #begin = {
        #command = "xdotool mousedown 1";
        #interval = 0.0;
        #};
        #update = {
        #command = "xdotool mousemove_relative -- $move_x, $move_y";
        #accel = 2;
        #interval = 0.01;
        #};
        #end = {
        #command = "xdotool mouseup 1";
        #interval = 0.0;
        #};
        #};
      };
      pinch = {
        "4" = {
          "in" = {
            command = "xdotool key ctrl+alt+d";
            threshold = 0.5;
          };
          out = {
            command = "xdotool key ctrl+alt+d";
            threshold = 0.5;
          };
        };
        "2" = {
          "in" = {
            command = "xdotool keydown ctrl click 5 keyup ctrl";
            threshold = 2.0e-2;
          };
          out = {
            command = "xdotool keydown ctrl click 4 keyup ctrl";
            threshold = 2.0e-2;
          };
        };
      };
      plugin = {
        inputs = {
          libinput_command_input = {
            enable-tap = true;
            enable-dwt = true;
            show-keycodes = true;
          };
        };
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/mpv".source = dotfiles/mpv;
    #".config/wezterm/wezterm.lua".source = dotfiles/wezterm.lua;
    #".config/fusuma/config.yml".source = dotfiles/fusuma/config.yml;
    ".config/systemd/user/maestral.service".source = dotfiles/maestral.service;
    ".config/lf/lfcd.sh".source = dotfiles/lf-config/lfcd.sh;
    ".config/lf/lf.bash".source = dotfiles/lf-config/lf.bash;
    ".config/openbox/rc.xml".source = dotfiles/openbox/rc.xml;
    ".config/libinput-gestures.conf".source = dotfiles/libinput-gestures.conf;
    #".jupyter/jupyter_qtconsole_config.py".source = dotfiles/jupyter_qtconsole_config.py;
    #".config/calcurse/caldav/config".source = dotfiles/calcurse-caldav/config; #git doesn't allow, so manually copy
    #".config/lf".source = dotfiles/lf-config;
    #".config/lf/icons".source = dotfiles/lf-config/icons;
    #".Xmodmap".source = dotfiles/.Xmodmap;
    #".xkb".source = dotfiles/.xkb;
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/py/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  #programs.sagemath.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  services.mpris-proxy.enable = true;
  programs.mpv = {
    # mkdir /var/log/mpv && sudo chmod -R u=rwx,g=rwx,o=rwx /var/log/mpv    ### for recent.lua history.log
    enable = true;
    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          #uosc
          sponsorblock
          mpris
          thumbfast
        ];
        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
          ffmpeg = pkgs.ffmpeg-full;
        };
      }
    );
  };


  #programs.tint2 = {
  #enable = true;
  #extraConfig = builtins.readFile ./dotfiles/tint2rc;
  #};

  #programs.tofi = {
  #enable = true;
  #settings = {
  #};
  #};

  programs.lf = {
    enable = true;
    settings = {
      number = true;
      relativenumber = true;
      hidden = true;
      icons = false;
    };
    keybindings = {
      gh = "cd ~";
      gd = "cd ~/Downloads";
      gc = "cd ~/.config";
      gn = "cd /etc/nixos/";
      DD = "trash";
      md = "mkdir";
      i = "$less $f";
      oo = "extractcode";
      sp = "usage";
      Q = "quit-and-cd";
    };
    extraConfig = ''
      #!/bin/sh
      #https://github.com/gokcehan/lf/wiki/Tips
      cmd trash $IFS="$(printf '\n\t')"; trash $fx
      cmd extractcode $IFS="$(printf '\n\t')"; extractcode $fx
      cmd usage $du -h -d1 | less
      cmd quit-and-cd &{{
        pwd > $LF_CD_FILE
        lf -remote "send $id quit"
      }}
      #cmd open &{{
        #case $(file --mime-type -Lb $f) in
          #text/*) lf -remote "send $id \$$EDITOR \$fx";;
          #*) for f in $fx; do $OPENER $f > /dev/null 2> /dev/null & done;;
        #esac
      #}}
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "pierrez1984@gmail.com";
    userName = "zh-py";
    extraConfig = {
      core = {
        editor = "nvim";
        pager = "delta --dark";
        whitespace = "trailing-space,space-before-tab";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;
        light = false;
        side-by-side = true;
        line-numbers = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };

  programs.fzf = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    historyLimit = 100000;
    #newSession = true;
    #escapeTime = 0;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'frappe'
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"
        '';
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
          set -g @vim_navigator_mapping_right "C-Right C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
        '';
      }
    ];
    extraConfig = ''
      set-option -g mouse on
    '';
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font.name = "Terminus (TTF)";
    font.size = 12;
    themeFile = "SpaceGray_Eighties";
    extraConfig = ''
      shell_integration enabled
      shell zsh
      editor .
      tab_bar_edge top
      tab_bar_style powerline
      tab_switch_strategy right
      #tab_title_template " {index}: {f'{title[:6]}…{title[-6:]}' if title.rindex(title[-1]) + 1 > 13 else title.center(7)}"
      #tab_title_template "{index}: {title[title.rfind('/')+1:]}"
      tab_title_template " {index}: {f'…{title[-14:]}' if title.rindex(title[-1]) + 1 > 15 else title.center(10)}"
      active_tab_font_style bold
      tab_bar_margin_width 6
      tab_powerline_style round
      tab_separator " ┇"
      macos_option_as_alt yes
      map alt+1 goto_tab 1
      map alt+2 goto_tab 2
      map alt+3 goto_tab 3
      map alt+4 goto_tab 4
      map alt+5 goto_tab 5
      map alt+6 goto_tab 6
      map alt+7 goto_tab 7
      map alt+8 goto_tab 8
      map alt+9 goto_tab 9
      map ctrl+shift+t new_tab_with_cwd
      map cmd+shift+h previous_tab
      map cmd+shift+l next_tab
      #map cmd+c copy_to_clipboard
      map ctrl+insert copy_and_clear_or_interrupt
      #map cmd+v paste_from_clipboard
      map shift+insert paste_from_clipboard
    '';
  };

  #programs.wezterm = { #62 lines
  #enable = true;
  #enableZshIntegration = true;
  #extraConfig = ''
  #local wezterm = require 'wezterm'
  #local my_framer = wezterm.color.get_builtin_schemes()['Framer (base16)']
  #my_framer.cursor_fg = '#181818'
  #my_framer.cursor_bg = '#EEEEEE'
  #my_framer.compose_cursor = '#20BCFC'
  #local mux = wezterm.mux
  #wezterm.on('gui-startup', function()
  #local tab, pane, window = mux.spawn_window(cmd or {})
  #window:gui_window():maximize()
  #end)
  #local gpus = wezterm.gui.enumerate_gpus()
  #local act = wezterm.action
  #return {
  #font_size = 12,
  #--font = wezterm.font('FiraCode Nerd Font Mono', { weight = 'Light', }),
  #--font = wezterm.font('FiraCode Nerd Font Mono'),
  #--font = wezterm.font('Terminus'),
  #--font = wezterm.font("MesloLGS NF"),
  #font = wezterm.font('Ttyp0'),
  #--font = wezterm.font('System'),
  #webgpu_preferred_adapter = gpus[1],
  #--front_end = "WebGpu",
  #front_end = "OpenGL",
  #enable_wayland = false,
  #webgpu_force_fallback_adapter = true,
  #webgpu_power_preference = "HighPerformance",
  #window_background_opacity = 1,
  #hide_tab_bar_if_only_one_tab = true,
  #default_cursor_style = "SteadyBar",
  #cursor_blink_rate = 600,
  #default_prog = { "zsh" },
  #window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  #window_decorations = "NONE",
  #use_fancy_tab_bar = false,
  #adjust_window_size_when_changing_font_size = false,
  #inactive_pane_hsb = { saturation = 1, brightness = 1 }, -- s0.9, b0.8
  #color_schemes = { ['My Framer'] = my_framer, },
  #color_scheme = 'My Framer',
  #keys = {
  #{ key = 't', mods = 'CMD|SHIFT', action = act.SpawnTab 'CurrentPaneDomain', },
  #--{ key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain', },
  #{ key = 'l', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  #{ key = 'h', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  #{ key = '1', mods = 'ALT',       action = act.ActivateTab(0) },
  #{ key = '2', mods = 'ALT',       action = act.ActivateTab(1) },
  #{ key = '3', mods = 'ALT',       action = act.ActivateTab(2) },
  #{ key = '4', mods = 'ALT',       action = act.ActivateTab(3) },
  #{ key = '5', mods = 'ALT',       action = act.ActivateTab(4) },
  #{ key = '6', mods = 'ALT',       action = act.ActivateTab(5) },
  #{ key = '7', mods = 'ALT',       action = act.ActivateTab(6) },
  #{ key = '8', mods = 'ALT',       action = act.ActivateTab(7) },
  #{ key = '9', mods = 'ALT',       action = act.ActivateTab(8) },
  #--{ key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
  #--{ key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
  #}
  #}
  #'';
  #};

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      y7 = "(){ yt-dlp -f 137+140 --no-mtime $1. ;}";
      y6 = "(){ yt-dlp -f 136+140 --no-mtime $1. ;}";
      y67 = "(){ yt-dlp -f '137+140/136+140' --no-mtime $1. ;}";
      yfm = "(){ yt-dlp --list-formats $1. ;}";
      yf = "(){ yt-dlp --write-auto-sub --write-sub --sub-lang en --convert-subtitles srt -f '137+140/136+140/135+140/134+140/137+140-8/137+140-7/137+140-6/137+140-5/137+140-4/137+140-3/137+140-2/137+140-1/136+140-8/136+140-7/136+140-6/136+140-5/136+140-4/136+140-3/136+140-2/136+140-1' --no-mtime $1. ;}";
      #bl = "sudo python3 ~/Downloads/osx_battery_charge_limit/main.py -s 42";
      #bh = "sudo python3 ~/Downloads/osx_battery_charge_limit/main.py -s 77";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./dotfiles/p10k-config;
        file = ".p10k.zsh";
      }
    ];
    initExtra = builtins.readFile ./dotfiles/.zshrc;
    #envExtra= builtins.readFile ./dotfiles/.zshenv;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "thefuck"
        "z"
        "command-not-found"
        "poetry"
        "sudo"
        "terraform"
        "systemadmin"
      ];
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withPython3 = true;
    extraConfig = ''
      colorscheme gruvbox
      filetype plugin indent on
      syntax enable
      set mouse=a
      set number
      set wrap
      set linebreak
      set clipboard=unnamed
      set nu rnu
      let &scrolloff = 5
      nn <F7> :setlocal spell! spell?<CR>
      nn <A-s> :setlocal spell! spell?<CR>
      autocmd Filetype lua setlocal tabstop=4
      autocmd Filetype lua setlocal shiftwidth=4
      cnoremap <C-a> <Home>
      cnoremap <C-e> <End>
      cnoremap <C-p> <Up>
      cnoremap <C-n> <Down>
      cnoremap <C-b> <Left>
      cnoremap <C-f> <Right>
      cnoremap <C-d> <Del>
      cnoreabbrev <expr> tn getcmdtype() == ":" && getcmdline() == 'tn' ? 'tabnew' : 'tn'
      cnoreabbrev <expr> th getcmdtype() == ":" && getcmdline() == 'th' ? 'tabp' : 'th'
      cnoreabbrev <expr> tl getcmdtype() == ":" && getcmdline() == 'tl' ? 'tabn' : 'tl'
      cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'
      lua vim.opt.signcolumn = "yes"
      lua vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
      lua vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
      lua vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
      lua vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])
      autocmd Filetype python map <silent> <A-r> :w<CR>:terminal python3 % -m pdb<CR>:startinsert<CR>
      autocmd Filetype python map! <silent> <A-r> <ESC> :w<CR>:terminal python3 % -m pdb<CR>:startinsert<CR>
      autocmd Filetype python map <silent> <F5> :w<CR>:terminal python3 % -m pdb<CR>:startinsert<CR>
      autocmd Filetype python map! <silent> <F5> <ESC> :w<CR>:terminal python3 % -m pdb<CR>:startinsert<CR>
      autocmd FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
      autocmd FileType python map <silent> <leader>B obreakpoint()<esc>
      autocmd Filetype tex,latex map <A-r> :w <Enter> <localleader>lk<localleader>ll
      autocmd Filetype tex,latex map! <A-r> <ESC> :w <Enter> <localleader>lk<localleader>ll
      autocmd Filetype tex,latex map <F5> :w <Enter> <localleader>lk<localleader>ll
      autocmd Filetype tex,latex map! <F5> <ESC> :w <Enter> <localleader>lk<localleader>ll
      autocmd Filetype tex,latex map <A-e> <localleader>le
      autocmd Filetype tex,latex map! <A-e> <ESC> <localleader>le
      autocmd Filetype tex,latex map <F4> <localleader>le
      autocmd Filetype tex,latex map! <F4> <ESC> <localleader>le
      autocmd Filetype tex,latex set shiftwidth=4
      autocmd Filetype markdown map <silent> <A-r> :w<CR>:MarkdownPreview<CR>
      autocmd Filetype markdown map! <silent> <A-r> <ESC> :w<CR>:MarkdownPreview<CR>
      autocmd Filetype markdown map <silent> <F5> :w<CR>:MarkdownPreview<CR>
      autocmd Filetype markdown map! <silent> <F5> <ESC> :w<CR>:MarkdownPreview<CR>
      map [b :bprevious<CR>
      map ]b :bnext<CR>
      map qb :Bdelete<CR>
      lua vim.keymap.set("n", "H", [[<cmd>bprevious<cr>]])
      lua vim.keymap.set("n", "L", [[<cmd>bnext<cr>]])
      if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
      endif
      autocmd FileType css setlocal tabstop=2 shiftwidth=2
      autocmd FileType haskell setlocal tabstop=2 shiftwidth=2
      autocmd FileType nix setlocal tabstop=2 shiftwidth=2
      autocmd FileType json setlocal tabstop=2 shiftwidth=2
      autocmd FileType cpp setlocal tabstop=2 shiftwidth=2
      autocmd FileType c setlocal tabstop=2 shiftwidth=2
      autocmd FileType java setlocal tabstop=4 shiftwidth=4
      autocmd FileType markdown setlocal spell
      autocmd FileType markdown setlocal tabstop=2 shiftwidth=2
      au BufRead,BufNewFile *.wiki setlocal textwidth=80 spell tabstop=2 shiftwidth=2
      autocmd FileType xml setlocal tabstop=2 shiftwidth=2
      autocmd FileType help wincmd L
      autocmd FileType gitcommit setlocal spell
    '';
    #let g:airline#extensions#tabline#enabled = 1
    #let g:airline#extensions#tabline#switch_buffers_and_tabs = 0
    #if !exists('g:airline_symbols')
    #let g:airline_symbols = {}
    #endif
    #let g:airline_left_sep = ''
    #let g:airline_left_alt_sep = ''
    #let g:airline_right_sep = ''
    #let g:airline_right_alt_sep = ''
    #let g:airline_symbols.branch = ''
    #let g:airline_symbols.colnr = ' ℅:'
    #let g:airline_symbols.readonly = ''
    #let g:airline_symbols.linenr = ' :'
    #let g:airline_symbols.maxlinenr = '☰ '
    #let g:airline_symbols.dirty='⚡'
    plugins = with pkgs.vimPlugins; [
      #copilot-vim
      vim-visual-multi
      gruvbox
      trouble-nvim
      vim-nix
      nerdcommenter
      markdown-preview-nvim
      vim-bbye
      tmux-nvim
      #{
      #plugin = zk-nvim;
      #type = "lua";
      #config = ''
      #require("zk").setup({
      #-- can be "telescope", "fzf", "fzf_lua" or "select" (`vim.ui.select`)
      #-- it's recommended to use "telescope", "fzf" or "fzf_lua"
      #picker = "telescope",
      #lsp = {
      #-- `config` is passed to `vim.lsp.start_client(config)`
      #config = {
      #cmd = { "zk", "lsp" },
      #name = "zk",
      #-- on_attach = ...
      #-- etc, see `:h vim.lsp.start_client()`
      #},
      #-- automatically attach buffers in a zk notebook that match the given filetypes
      #auto_attach = {
      #enabled = true,
      #filetypes = { "markdown" },
      #},
      #},
      #})
      #'';
      #}
      #vim-airline
      #vim-airline-themes
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup({
            highlight = {
              enable = true,
              --disable = { "latex" },
            },
            indent = { enable = true},
          })
        '';
      }
      #nui-nvim
      #nvim-notify
      #{
      #plugin = noice-nvim;
      #type = "lua";
      #config = builtins.readFile(./neovim/noice.lua);
      #}
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require("nvim-web-devicons").setup()
        '';
      }
      {
        plugin = fzf-lua;
        type = "lua";
        config = ''
          -- require("fzf-lua").setup({})
          -- require('fzf-lua').setup({'fzf-native'})
          -- vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
          -- require"fzf-lua".setup({"telescope",winopts={preview={default="bat"}}})
          require('fzf-lua').setup({'fzf-vim'})
        '';
      }
      #{
      #plugin = nvim-tree-lua;
      #type = "lua";
      #config = builtins.readFile(./neovim/nvimtree.lua);
      #}
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile (./neovim/lualine.lua);
      }
      #{
      #plugin = bufferline-nvim;
      #type = "lua";
      #config = ''
      #vim.opt.termguicolors = true
      #require("bufferline").setup{}
      #'';
      #}
      {
        plugin = vimtex;
        config = # vim
          ''
            "let g:vimtex_view_general_method='qpdfview'
            let g:vimtex_view_method = 'mupdf'
            let g:vimtex_view_mupdf_send_keys = 'shift+h'
            "let g:vimtex_view_general_options = '-reuse-instance u/pdf'
            "let g:vimtex_view_general_viewer = 'okular'
            "let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
            "let g:vimtex_view_skim_activate=0
            "let g:vimtex_view_skim_reading_bar=1
            let g:vimtex_syntax_enabled=0
          '';
      }
      markdown-preview-nvim
      {
        plugin = vim-markdown;
        config = # vim
          ''
            let g:vim_markdown_folding_disabled = 1
            let g:vim_markdown_conceal = 0
            let g:vim_markdown_frontmatter = 1
            let g:vim_markdown_toml_frontmatter = 1
            let g:vim_markdown_json_frontmatter = 1
          '';
      }
      {
        plugin = nvim-lastplace;
        type = "lua";
        config = ''
          require('nvim-lastplace').setup()
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile (./neovim/lspconfig.lua);
      }
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lua
      cmp-vsnip
      vim-vsnip
      #friendly-snippets
      cmp-nvim-lsp
      lspkind-nvim
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require("nvim-surround").setup()
        '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile (./neovim/completion.lua);
      }
      plenary-nvim
      {
        plugin = mini-nvim;
        type = "lua";
        config = ''
          require('mini.trailspace').setup()
        '';
      }
      {
        plugin = harpoon2;
        type = "lua";
        config = builtins.readFile (./neovim/harpoon.lua);
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile (./neovim/telescope.lua);
      }
      telescope-file-browser-nvim
      telescope-ui-select-nvim
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require('ibl').setup({
            indent = {
              char = "┊",
            },
            scope = {
              enabled = true,
              show_start = true,
              show_end = true,
            },
          })
        '';
      }
      {
        plugin = treesj;
        type = "lua";
        config = ''
          require('treesj').setup{
            lang = {
                lua = require('treesj.langs.lua'),
                typescript = require('treesj.langs.typescript'),
                python = require('treesj.langs.python'),
              },
            use_default_keymaps = true,
            check_syntax_error = true,
            max_join_length = 120,
            cursor_behavior = 'hold',
            notify = true,
            dot_repeat = true,
            on_error = nil,
            }
        '';
      }
      nvim-dap
      #{
      #plugin = nvim-dap-python;
      #type = "lua";
      #config = builtins.readFile(./neovim/debuggerpy.lua);
      #}
      telescope-dap-nvim
      nvim-dap-ui
      neodev-nvim
      nvim-dap-virtual-text
    ];
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };
      window = {
        #padding.x = 10;
        #padding.y = 10;
        dynamic_padding = true;
        opacity = 0.96;
        decorations = "None";
        startup_mode = "Maximized";
      };
      font = {
        size = 14;
        #normal.family = "JetbrainsMono Nerd Font";
        #bold.family = "JetbrainsMono Nerd Font";
        #italic.family = "JetbrainsMono Nerd Font";
        #normal.family = "Hack Nerd Font Mono";
        #bold.family = "Hack Nerd Font Mono";
        #italic.family = "Hack Nerd Font Mono";
        #normal.family = "terminus";
        #bold.family = "terminus";
        #italic.family = "terminus";
        #normal.family = "gohufont";
        #bold.family = "gohufont";
        #italic.family = "gohufont";
        normal.family = "Ttyp0";
        bold.family = "Ttyp0";
        italic.family = "Ttyp0";
      };
      cursor = {
        style.shape = "Beam";
        style.blinking = "On";
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      terminal = {
        shell = {
          program = "zsh";
          args = [
            "-l"
          ];
        };
      };
      colors = {
        primary = {
          background = "0x1b182c";
          foreground = "0xcbe3e7";
        };
        normal = {
          black = "0x100e23";
          red = "0xff8080";
          green = "0x95ffa4";
          yellow = "0xffe9aa";
          blue = "0x91ddff";
          magenta = "0xc991e1";
          cyan = "0xaaffe4";
          white = "0xcbe3e7";
        };
        bright = {
          black = "0x565575";
          red = "0xff5458";
          green = "0x62d196";
          yellow = "0xffb378";
          blue = "0x65b2ff";
          magenta = "0x906cff";
          cyan = "0x63f2f1";
          white = "0xa6b3cc";
        };
      };
      keyboard = {
        bindings = [
          {
            key = "Q";
            mods = "Control";
            action = "Quit";
          }
        ];
      };
    };
  };

  #home.activation = mkIf pkgs.stdenv.isDarwin {
  #copyApplications = let
  #apps = pkgs.buildEnv {
  #name = "home-manager-applications";
  #paths = config.home.packages;
  #pathsToLink = "/Applications";
  #};
  #in
  #lib.hm.dag.entryAfter ["writeBoundary"] ''
  #baseDir="$HOME/Applications/Home Manager Apps"
  #if [ -d "$baseDir" ]; then
  #rm -rf "$baseDir"
  #fi
  #mkdir -p "$baseDir"
  #for appFile in ${apps}/Applications/*; do
  #target="$baseDir/$(basename "$appFile")"
  #$DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
  #$DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
  #done
  #'';
  #};
}
