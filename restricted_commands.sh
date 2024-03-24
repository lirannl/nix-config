#!/run/current-system/sw/bin/bash
args=($SSH_ORIGINAL_COMMAND)
case ${args[0]} in
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