{ config, lib, ... }:
  with lib lib.types;
let

  # A submodule which takes a key and a list of modifier keys.
  keybind = submodule {

    options.key = mkOption {
      description = "Non-modifier key needed to activate keybind.";
      type = str;
    };

    options.modifiers = mkOption {
      description = "Modifier keys needed to activate keybind.";
      type = listOf str;
    };

  };

  # A submodule which takes a cardinal direction and associates it with a keybind.
  directions = submodule {

    options.left = mkOption {
      description = "Left";
      type = nullOr keybind;
    };

    options.right = mkOption {
      description = "Right";
      type = nullOr keybind;
    };

    options.up = mkOption {
      description = "Up";
      type = nullOr keybind;
    };

    options.down = mkOption {
      description = "Down";
      type = nullOr keybind;
    };

  };

  # A submodule which associates an enumerated workspace number with a keybind
  workspace = submodule {

    options.enumerator = mkOption {
      description = "The enumerated workspace the keybind is associated with.";
      type = int;
    };

    options.bind = mkOption {
      description = "Keybind to be associated with the enumerated workspace.";
      type = nullOr keybind;
    };

  };

  # A function which enumerates workspaces 1 through 10 using the number keys 1 through 0 and an input modifier list as its keybind.
  workspaces = modifiers: (builtins.concatLists (builtins.genList (x:
    let ws = let c = (x + 1) / 10;
    in builtins.toString (x + 1 - (c * 10)); in [
      { enumerator = ws; bind.key = (x + 1); bind.modifiers = modifiers; }
    ]
  ) 10));

in {


  window = {

    focus = mkOption {
      description = "Changes which window is currently focused.";
      type = directions;
      default = {
        left = { key = "h"; modifiers = [ "Super" ]; };
        right = { key = "l"; modifiers = [ "Super" ]; };
        up = { key = "j"; modifiers = [ "Super" ]; };
        down = { key = "k"; modifiers = [ "Super" ]; };
      };
    };

    move = mkOption {
      description = "Moves the currently focused window.";
      type = directions;
      default = {
        left = { key = "h"; modifiers = [ "Super" "Control" ]; };
        right = { key = "l"; modifiers = [ "Super" "Control" ]; };
        up = { key = "j"; modifiers = [ "Super" "Control" ]; };
        down = { key = "k"; modifiers = [ "Super" "Control" ]; };
      };
    };

    resize = mkOption {
      description = "Resize the currently focused window.";
      type = directions;
      default = {
        left = { key = "h"; modifiers = [ "Super" "Shift" ]; };
        right = { key = "l"; modifiers = [ "Super" "Shift" ]; };
        up = { key = "j"; modifiers = [ "Super" "Shift" ]; };
        down = { key = "k"; modifiers = [ "Super" "Shift" ]; };
      };
    };

    close = mkOption {
      description = "Close the currently focused window.";
      type = nullOr keybind;
      default = {
        key = "q";
        modifiers = [ "Super" ];
      };
    };

    float = mkOption {
      description = "Set the currently focused window to floating.";
      type = nullOr keybind;
      default = {
        key = "c";
        modifiers = [ "Super" ];
      };
    };

    fullscreen = mkOption {
      description = "Fullscreen the currently focused window.";
      type = nullOr keybind;
      default = {
        key = "f";
        modifiers = [ "Super" ];
      };
    };

    maximize = mkOption {
      description = "Maximize the currently focused window.";
      type = nullOr keybind;
      default = {
        key = "m";
        modifiers = [ "Super" ];
      };
    };

    minimize = mkOption {
      description = "Minimize the currently focused window.";
      type = nullOr keybind;
      default = {
        key = "n";
        modifiers = [ "Super" ];
      };
    };

  };


  monitor = {

    focus = mkOption {
      description = "Change the currently focused monitor";
      type = nullOr listOf workspace;
      default = null;
      example = ''
        [
          {
            enumerator = 1;
            bind.key = "1";
            bind.modifiers = [ "Alt" ];
          }
          {
            enumerator = 2;
            bind.key = "2";
            bind.modifiers = [ "Alt" ];
          }
        ];
      '';
    };

    move = mkOption {
      description = "Move the currently focused window to the specified monitor.";
      type = nullOr listOf workspace;
      default = null;
      example = ''
        [
          {
            enumerator = 1;
            bind.key = "1";
            bind.modifiers = [ "Alt" "Shift ];
          }
          {
            enumerator = 2;
            bind.key = "2";
            bind.modifiers = [ "Alt" "Shift" ];
          }
        ];
      '';
    };

    send = mkOption {
      description = "Send the currently focused window to the specified monitor without changing focus to that monitor.";
      type = nullOr listOf workspace;
      default = null;
      example = ''
        [
          {
            enumerator = 1;
            bind.key = "1";
            bind.modifiers = [ "Alt" "Control" ];
          }
          {
            enumerator = 2;
            bind.key = "2";
            bind.modifiers = [ "Alt" "Control" ];
          }
        ];
      '';
    };

    next = mkOption {
      description = "Change the currently focused monitor to the next enumerated monitor.";
      type = nullOr keybind;
      default = null;
      example = ''
        {
          key = "l";
          modifiers = [ "Alt" ];
        };
      '';
    };

    previous = mkOption {
      description = "Change the currently focused monitor to the previous enumerated monitor.";
      type = nullOr keybind;
      default = null;
      example = ''
        {
          key = "h";
          modifiers = [ "Alt" ];
        };
      '';
    };

    moveToNext = mkOption {
      description = "Move the currently focused window to the next enumerated monitor.";
      type = nullOr keybind;
      default = null;
      example = ''
        {
          key = "l";
          modifiers = [ "Alt" "Shift" ];
        };
      '';
    };

    moveToPrevious = mkOption {
      description = "Move the currently focused window to the previous enumerated monitor.";
      type = nullOr keybind;
      default = null;
      example = ''
        {
          key = "h";
          modifiers = [ "Alt" "Shift" ];
        };
      '';
    };

    sendToNext = mkOption {
      description = "Send the currently focused window to the next enumerated monitor without changing focus.";
      type = nullOr keybind;
      default = null;
      example = ''
        {
          key = "l";
          modifiers = [ "Alt" "Control" ];
        };
      '';
    };

    sendToPrevious = mkOption {
      description = "Send the currently focused window to the previous enumerated monitor without changing focus.";
      type = nullOr keybind;
      example = null;
      default = ''
        {
          key = "h";
          modifiers = [ "Alt" "Control" ];
        };
      '';
    };

  };


  workspace = {

    focus = mkOption {
      description = "Change the currently focused workspace";
      type = nullOr listOf workspace;
      default = workspaces [ "Super" ];
    };

    move = mkOption {
      description = "Move the currently focused window to the specified workspace.";
      type = nullOr listOf workspace;
      default = workspaces [ "Super" "Shift" ];
    };

    send = mkOption {
      description = "Send the currently focused window to the specified workspace without changing focus to that workspace";
      type = nullOr listOf workspace;
      default = workspaces [ "Super" "Control" ];
    };

    next = mkOption {
      description = "Change the currently focused workspace to the next enumerated workspace.";
      type = nullOr keybind;
      default = {
        key = "j";
        modifiers = [ "Alt" "Super" ];
      };
    };

    previous = mkOption {
      description = "Change the currently focused workspace to the previous enumerated workspace.";
      type = nullOr keybind;
      default = {
        key = "k";
        modifiers = [ "Alt" "Super" ];
      };
    };

    moveToNext = mkOption {
      description = "Move the currently focused window to the next enumerated workspace.";
      type = nullOr keybind;
      default = {
        key = "j";
        modifiers = [ "Alt" "Shift" ];
      };
    };

    moveToPrevious = mkOption {
      description = "Move the currently focused window to the previous enumerated workspace.";
      type = nullOr keybind;
      default = {
        key = "k";
        modifiers = [ "Alt" "Shift" ];
      };
    };

    sendToNext = mkOption {
      description = "Send the currently focused window to the next enumerated workspace without changing focus to that workspace.";
      type = nullOr keybind;
      default = {
        key = "j";
        modifiers = [ "Alt" "Control" ];
      };
    };

    sendToPrevious = mkOption {
      description = "Send the currently focused window to the previous enumerated workspace without changing focus to that workspace.";
      type = nullOr keybind;
      default = {
        key = "k";
        modifiers = [ "Alt" "Control" ];
      };
    };

  };


  layout = {

    manual = {

      changeDirection = mkOption {
        description = "Change the direction in which windows should be tiled.";
        type = nullOr keybind;
        default = {
          key = "i";
          modifiers = [ "Super" ];
        };
      };

    };

    automatic = {

      cycle = mkOption {
        description = "Cycle through tiling layouts.";
        type = nullOr keybind;
        default = null;
      };

      masterStack = {

        setMaster = mkOption {
          description = "Set the currently focused window as the master window, and push the old master onto the stack.";
          type = nullOr keybind;
          default = null;
        };

        focusMaster = mkOption {
          description = "Changes the focus to the master window.";
          type = nullOr keybind;
          default = null;
        };

        newIsMaster = mkOption {
          description = "Create new windows on the master node, and push the old master window to the top of the stack.";
          type = nullOr keybind;
          default = null;
        };

        newIsSlave = mkOption {
          description = "Create new windows at the bottom of the stack.";
          type = nullOr keybind;
          default = null;
        };

      }; 

      scrolling = {

        consume = mkOption {
          description = "Consume the currently focused window into the column to its left.";
          type = nullOr keybind;
          default = null;
        };

        expel = mkOption {
          description = "Expel the currently focused window from the column, creating its own column.";
          type = nullOr keybind;
          default = null;
        };

        tryLeft = mkOption {
          description = "Consume window to the left if in its own column, otherwise expel it.";
          type = nullOr keybind;
          default = null;
        };

        tryRight = mkOption {
          description = "Consume window to the right if in its own column, otherwise expel it.";
          type = nullOr keybind;
          default = null;
        };

        cycleWidth = mkOption {
          description = "Cycle through preset window widths.";
          type = nullOr keybind;
          default = null;
        };

        cycleHeight = mkOption {
          description = "Cycle through preset window heights.";
          type = nullOr keybind;
          default = null;
        };

        centreColumn = mkOption {
          description = "Centre the column on the screen.";
          type = nullOr keybind;
          default = null;
        };

      };

    };

  };


  launch = {

    terminal = mkOption {
      description = "Open a new instance of the user's terminal.";
      type = nullOr keybind;
      default = {
        key = "Return";
        modifiers = [ "Super" ];
      };
    };

    launcher = mkOption {
      description = "Open the application launcher.";
      type = nullOr keybind;
      default = {
        key = "Return";
        modifiers = [ "Super" "Control" ];
      };
    };

    runner = mkOption {
      description = "Open the runner.";
      type = nullOr keybind;
      default = null;
    };

    power = mkOption {
      description = "Open the power menu";
      type = nullOr keybind;
      default = {
        key = "Delete";
        modifiers = [ "Control" "Alt" ];
      };
    };

    lock = mkOption {
      description = "Lock the screen";
      type = nullOr keybind;
      default = null;
    };

  };

}
