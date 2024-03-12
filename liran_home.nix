{pkgs, lib, ...}: 
let nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
in {
 home = {
    packages = [pkgs.firefox nur.repos.rutherther.firefoxpwa pkgs.vscode];
    stateVersion = "18.09";
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
  programs.git = {
    enable = true;
    userName  = "my_git_username";
    userEmail = "my_git_username@gmail.com";
  };
  nixpkgs.config.allowUnfree = true;
}
