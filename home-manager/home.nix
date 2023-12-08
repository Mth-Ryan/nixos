{ config, pkgs, nix-colors, ... }:

{
  imports = [
    nix-colors.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "black";
  home.homeDirectory = "/home/black";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  colorScheme = {
    slug = "oxocarbon";
    name = "Oxocarbon";
    author = "Nyoom Engineering (https://github.com/nyoom-engineering)";
    colors = {
      base00 = "#161616";
      base01 = "#262626";
      base02 = "#393939";
      base03 = "#525252";
      base04 = "#dde1e6";
      base05 = "#f2f4f8";
      base06 = "#ffffff";
      base07 = "#08bdba";
      base08 = "#3ddbd9";
      base09 = "#78a9ff";
      base0A = "#ee5396";
      base0B = "#33b1ff";
      base0C = "#ff7eb6";
      base0D = "#42be65";
      base0E = "#be95ff";
      base0F = "#82cfff";

      # extra for terminal theme
      yellow = "#ffe97b";
      blue = "#33b1ff";
    };
  };

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" "FiraCode" ]; })
  ];

  programs.tmux = {
    enable = true;
    prefix = "C-x";
    customPaneNavigationAndResize = true;
    mouse = true;
    extraConfig = ''
      set -s escape-time 0
      set -g default-terminal "tmux-256color" # true colors mode
      set -ag terminal-overrides ",xterm-256color:RGB"

      unbind %
      unbind '"'
      bind '/' split-window -h
      bind '-' split-window -v

      set -g status-position bottom
      set -g status-style bg="#${config.colorScheme.colors.base00}"
      set -g status-left "#[fg=#${config.colorScheme.colors.base00},bold,bg=#${config.colorScheme.colors.base0F}] λ #[fg=#${config.colorScheme.colors.base0F},bold,bg=#${config.colorScheme.colors.base02}] #S #[bg=#${config.colorScheme.colors.base00}] "
      setw -g window-status-current-format "#[fg=#${config.colorScheme.colors.base06},bold]#I:#W"
      setw -g window-status-format "#[fg=#${config.colorScheme.colors.base03}]#I:#W"
      set -g status-right "#[fg=#${config.colorScheme.colors.base04},bold,bg=#${config.colorScheme.colors.base03}]  #[fg=#${config.colorScheme.colors.base04},bg=#${config.colorScheme.colors.base02}] %d/%m #[bg=#${config.colorScheme.colors.base00}] #[fg=#${config.colorScheme.colors.base04},bold,bg=#${config.colorScheme.colors.base03}]  #[fg=#${config.colorScheme.colors.base04},bg=#${config.colorScheme.colors.base02}] %H:%M:%S "
    '';
  };

  programs.git = {
    enable = true;
    userName = "Mateus Ryan";
    userEmail = "mthryan@protonmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-syntax-highlighting"; tags = [ defer:2 ]; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "geometry-zsh/geometry"; }
      ];
    };
    initExtra = ''
      export GOPATH="$HOME/.go"
      export GOBIN="$GOPATH/bin"
      export PATH="$PATH:$GOBIN"

      export DEVELOP="$HOME/.develop"
      export PATH="$PATH:$DEVELOP/bin"
    '';
  };

  programs.kitty = {
    enable = true;
    settings = {
      #font_family = "Iosevka Nerd Font";
      cursor_shape = "block";
      background_opacity = "0.94";
      enable_audio_bell = "no";
      window_padding_width = "5";
      confirm_os_window_close = "0";
      foreground = "#${config.colorScheme.colors.base05}";
      background = "#${config.colorScheme.colors.base00}";
      color0 = "#${config.colorScheme.colors.base00}";
      color8 = "#${config.colorScheme.colors.base03}";
      color1 = "#${config.colorScheme.colors.base0A}";
      color9 = "#${config.colorScheme.colors.base0A}";
      color2 = "#${config.colorScheme.colors.base0D}";
      color10 = "#${config.colorScheme.colors.base0D}";
      color3 = "#${config.colorScheme.colors.yellow}";
      color11 = "#${config.colorScheme.colors.yellow}";
      color4 = "#${config.colorScheme.colors.blue}";
      color12 = "#${config.colorScheme.colors.blue}";
      color5 = "#${config.colorScheme.colors.base0C}";
      color13 = "#${config.colorScheme.colors.base0C}";
      color6 = "#${config.colorScheme.colors.base08}";
      color14 = "#${config.colorScheme.colors.base08}";
      color7 = "#${config.colorScheme.colors.base04}";
      color15 = "#${config.colorScheme.colors.base05}";
    };
  };

  home.file = {
    ".config/helix" = {
      source = ./helix;
      recursive = true;
    };

    ".config/hypr" = {
      source = ./hypr;
      recursive = true;
    };

    ".config/rofi" = {
      source = ./rofi;
      recursive = true;
    };

    ".config/eww" = {
      source = ./eww;
      recursive = true;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
