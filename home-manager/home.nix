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

  home.packages = [
    # pkgs.dotnet-sdk_8
    # pkgs.nodejs_20
    # pkgs.go
    # pkgs.rustup
    pkgs.sbcl

    (pkgs.nerdfonts.override { fonts = [ "Iosevka" "FiraCode" ]; })
  ];

  programs.git = {
    enable = true;
    userName = "Mateus Ryan";
    userEmail = "mthryan@protonmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      lisp = "rlwrap sbcl";
    };
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

  home.file = {
    ".config/helix" = {
      source = ./helix;
      recursive = true;
    };

    ".config/tmux" = {
      source = ./tmux;
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

    ".config/kitty" = {
      source = ./kitty;
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
