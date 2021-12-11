# Creates and starts testing-xxx VM
#
#
here=$(dirname $0)
. $here/parse-args.sh

vm_name=${1:?Need name of ansible-arch-testing VM}
vm_iso=${2:?Need location of iso file for arch installation}

echo vm_name is:     $vm_name
echo vm_iso is:      $vm_iso
echo vm_memsize is:  $vm_memsize
echo vm_disksize is: $vm_disksize

# If the vm name has "bios" in it, then we're doing BIOS
# Otherwise we're doing EFI
if [[ $vm_name =~ "bios" ]]
then
    boottype=""
else
    boottype="--boot uefi"
fi

virt-install $connect                         \
             --name "$vm_name"                \
             --memory $vm_memsize             \
             --vcpus=2,maxvcpus=4             \
             --cpu host                       \
             --cdrom "$vm_iso"                \
             --disk size=${vm_disksize},format=qcow2 \
             --virt-type kvm                  \
             --console pty,target.type=virtio \
             $boottype                        \
             --noautoconsole

# Using the '--wait' flag for virt-install never returns

echo Waiting for the VM to come up
sleep 20
while true
do
    sleep 1
    addr=$($here/get-ip-addr.sh "$vm_name")
    if [[ -n $addr ]]
    then
        break
    fi
done

echo IP address of $vm_name is $addr

$here/update-ip-addr.sh $addr "$vm_name"

exec virsh $connect console "$vm_name"

