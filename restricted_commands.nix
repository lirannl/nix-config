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
      authorizedKeys.keys = [
        ''command="sudo ${restricted}/bin/restricted_commands" ${(import ./local_variables.nix).ha_key}''
      ];
    };
  };
  security.sudo.extraConfig = ''ALL ALL = (root) NOPASSWD: ${restricted}/bin/restricted_commands'';
}