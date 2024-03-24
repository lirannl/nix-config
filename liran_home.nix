{pkgs, ...}:
let nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
in {
  home = {
    stateVersion = "18.09";
    packages = [
      
    ];
};
  dconf.settings = {
      "org/gnome/desktop/screensaver" = {
        lock-enabled = false;
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/shell" = {
        enabled-extensions = [ "gsconnect@andyholmes.github.io" "appindicatorsupport@rgcjonas.gmail.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" ];
      };
  };
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number
    '';
  coc.enable = true;
    coc.settings = {
      languageserver = {
        nix = {
          command = "nixd";
          filetypes = ["nix"];
        };
      };
    };
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  };
  programs.nushell = {
    enable = true;
  extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
       '';
    shellAliases = {
    vi = "hx";
    vim = "hx";
    nano = "hx";
    };       
  };
  programs.carapace = {enable = true;
   enableNushellIntegration = true;};
  programs.git = {
    enable = true;
    userName  = "Liran Piade";
    userEmail = "liranpiade@gmail.com";
  };
  nixpkgs.config.allowUnfree = true;
}
