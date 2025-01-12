{ lib, pkgs, ... }:
  with lib lib.types;
{

  autostart = lib.mkOption {
    description = "Programs to be autostarted when the session starts.";
    type = nullOr listOf str;
    default = null;
    example = ''
      [
        "fcitx5"
        "\${pkgs.discord}/bin/discord"
      ]
    '';
  };

  userDefaults = {

    documentReader = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.kdePackages.okular}/bin/okular"
    };

    editor = mkOption {
      default = "${pkgs.nvim}/bin/nvim";
      type = nullOr str;
      example = "\${inputs.nixvimRice.packages.x86_64-linux.default}/bin/nvim";
    };

    emailClient = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.thunderbird}/bin/thunderbird";
    };

    fileManager = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.pcmanfm-qt}/bin/pcmanfm-qt";
    };

    imageViewer = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.qimgv}/bin/qimgv";
    };

    messenger = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.simplex-chat-desktop}/bin/simplex-chat-desktop";
    };
    
    musicPlayer = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.kdePackages.elisa}/bin/elisa";
    };

    notes = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.notesnook}/bin/notesnook";
    };

    office = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.libreoffice}/bin/libreoffice";
    };

    terminal = mkOption {
      default = "${pkgs.kitty}/bin/kitty";
      type = nullOr str;
      example = "\${pkgs.alacritty}/bin/alacritty"
    };

    webBrowser = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.firefox}/bin/firefox";
    };

    videoPlayer = mkOption {
      default = null;
      type = nullOr str;
      example = "\${pkgs.mpv}/bin/mpv";
    };

  };

}
