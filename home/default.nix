{ config, lib, ... }:
{
  imports = [
  ] ++ lib.optional (config.nix-ricer.enable && config.nix-ricer.riceHome != null) config.nix-ricer.riceHome;

  options.nix-ricer = {
    
    enable = lib.mkOption {
      default = false;
      description = "Enable nix-ricer to manage input rices.";
      example = true;
    };

    riceHome = lib.mkOption {
      default = null;
      type = lib.types.path;
      description = ''
        This option determines what home-manager rice module will be used by
        nix-ricer. Ideally this should be set by rice authors using an enable
        option.

        If set directly by the user and home-manager is being used as a NixOS
        module this should probably be using a module from the same flake input
        as riceNixos.
      '';
      example = ''
        lib.mkIf config.myRice.enable self.homeManagerModules.default
          or
        inputs.myRice.homeManagerModules.default
      ''
    };

    applications = import ./applications.nix;
    keybinds = import ./keybinds.nix;

  };
}
