{ pkgs, lib, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting     # Disable greeting
        fish_vi_key_bindings  # Enable vi mode
      '';
      plugins = [
        {
          name = "tide";
          src = pkgs.fetchFromGitHub {
            owner = "IlanCosman";
            repo = "tide";
            rev = "v6.1.1";
            hash = "sha256-ZyEk/WoxdX5Fr2kXRERQS1U1QHH3oVSyBQvlwYnEYyc=";
          };
        }
      ];
    };
}
