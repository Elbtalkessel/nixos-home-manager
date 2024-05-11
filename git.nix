{ lib, ... }: {
    programs.git = {
      enable = true;
      userName = "Elbtalkessel";
      userEmail = "rtfsc@pm.me";
      aliases = {
        m = "merge --no-ff";
      };
    };
}
