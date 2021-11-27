#
#
here=$(dirname $0)
vm_iso=${1:?Need location of iso file for arch installation}

$here/start-vm.sh "testing-efi" "$vm_iso"
