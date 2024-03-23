{pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [
    yuzu
  ];
}