{ config, pkgs, ... }:
{

  imports = [
    ./alacritty.nix
    ./aliases.nix
    ./environment.nix
    ./fish.nix
    ./git.nix
    ./hyprland.nix
    ./mako.nix
    ./waybar.nix
  ]; 
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "risus";
  home.homeDirectory = "/home/risus";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.fzf = {
    enable = true;
  };

  programs.eza = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  xdg.configFile."tofi/config".source = ./config/tofi/config;
  xdg.configFile."lvim/config.lua".source = ./config/lvim/config.lua;
  xdg.configFile."hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf;

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
    
  # https://discourse.nixos.org/t/virt-manager-cannot-create-vm/38894/2
  # virt-manager doesn't work without it
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
  };

  dconf = {
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
    lazydocker
    podman-compose
    pavucontrol

    # Web access
    brave
    wget
    curl

    # Capture
    grim
    slurp
    wl-clipboard

    # Desktop environment
    tofi
    zathura
    libnotify
    hyprpaper
    imv

    # Console and text-based UI apps
    lf
    lazygit
    btop

    # Tools
    arp-scan
    httpie
    ripgrep

    # Editors and IDEs
    lunarvim

    #jetbrains.pycharm-professional
    # https://search.nixos.org/packages?channel=23.11&show=github-copilot-intellij-agent&from=0&size=50&sort=relevance&type=packages&query=Copilot
    # The GitHub copilot IntelliJ plugin’s native component. bin/copilot-agent must be symlinked into the plugin directory, replacing the existing binary.
    # For example:
    # ln -fs /run/current-system/sw/bin/copilot-agent ~/.local/share/JetBrains/IntelliJIdea2022.2/github-copilot-intellij/copilot-agent/bin/copilot-agent-linux
    # ln -fs /nix/store/1sl4g8xbcpn8whmihy4ns60kgdc5hhha-github-copilot-intellij-agent-1.2.18.2908/bin/copilot-agent ~/.local/share/JetBrains/PyCharm2023.2/github-copilot-intellij/copilot-agent/bin/copilot-agent-linux
    #github-copilot-intellij-agent

    # Dev
    #slack
  ];

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
  #  /etc/profiles/per-user/risus/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
