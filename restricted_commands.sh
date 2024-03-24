#!/run/current-system/sw/bin/bash
case $1 in
    "sleep")
        systemctl suspend
        ;;
    "rebuild")
        nixos-rebuild switch
        ;;
    *)
        echo "Unsupported or no command provided"
        ;;
esac