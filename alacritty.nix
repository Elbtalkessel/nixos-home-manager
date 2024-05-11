{ lib, ... }: {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "JetBrainsMono NF";
            style = "Regular";
          };
          size = 15;
          offset = {
            x = 0;
            y = 10;
          };
          cursor = {
            style = {
              shape = "Beam";
              blinking = "always";
            };
            vi_mode_style = {
              shape = "Beam";
            };
          };
          keyboard = {
            bindings = [
              {
                key = "V";
                mods = "Control";
                action = "Paste";
              }
              {
                key = "C";
                mods = "Control";
                action = "Copy";
              }
              {
                key = "C";
                mods = "Control|Shift";
                action = "\u0003";
              }
            ];
          };
          window = {
            decorations = "full";
            opacity = "0.96";
            padding = {
              x = 0;
              y = 0;
            };
          };
        };
      };
    };
}
