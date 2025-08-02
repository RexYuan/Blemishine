
# usage: uvm {up [--gui] | down | status [--full]}
function uvm
{
  local vmname="ubuntu22"

  case "$1" in
    up)
      if [[ "$2" == "--gui" ]]; then
        vboxmanage startvm "$vmname"
      else
        vboxmanage startvm "$vmname" --type headless
      fi
      ;;
    down)
      vboxmanage controlvm "$vmname" poweroff
      ;;
    status)
      if [[ "$2" == "--full" ]]; then
        vboxmanage showvminfo "$vmname"
      else
        vboxmanage showvminfo "$vmname" | awk '
          /^Name:/ ||
          /^Guest OS:/ ||
          /^State:/ ||
          /Host path: .*machine mapping/
        '
      fi
      ;;
    *)
      echo "Usage: uvm {up [--gui] | down | status [--full]}"
      return 1
      ;;
  esac
}
