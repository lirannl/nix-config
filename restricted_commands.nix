{pkgs, ...}: 
let restricted = pkgs.stdenv.mkDerivation {
  name = "restricted_commands";
  dontUnpack = true;
  installPhase = "install -Dm755 ${./restricted_commands.sh} $out/bin/restricted_commands";
  buildInputs = [ pkgs.bash ];
};
in {
  users.users.ha = {
    isNormalUser = true;
    description = "Home assistant restricted commands";
    
    extraGroups = [ ];
    openssh = {
      authorizedKeys.keys = map 
      (key: ''command="sudo ${restricted}/bin/restricted_commands" ${key}'') 
      (import ./local_variables.nix).ha_keys;
    };
  };
  security.sudo.extraConfig = ''
  Defaults!${restricted}/bin/restricted_commands env_keep=SSH_ORIGINAL_COMMAND
  ha ALL=(root) NOPASSWD:${restricted}/bin/restricted_commands
  '';
}