# CentOS 7 x86_64

# Default scripts for all Fedora base disks
: ${BASE_INSTALL_SCRIPTS:=scripts.centos_base}

#-------------------------------------------------------------------------------
# Booting the operating system installer
#-------------------------------------------------------------------------------

readonly ISO_URL=https://buildlogs.centos.org/rolling/7/isos/x86_64/CentOS-7-x86_64-DVD-1511.iso
readonly ISO_MD5=8c5fc24894394035402f66f3824beb7234b757dd2b5531379cb310cedfdf0996

readonly _KS_ssh=https://opendev.org/openstack/training-labs/raw/branch/master/labs/osbash/lib/osbash/netboot/ks-ssh-v2.cfg
readonly _KS_vbadd=https://opendev.org/openstack/training-labs/raw/branch/master/labs/osbash/lib/osbash/netboot/ks-vbadd.cfg
readonly _KS_all=https://opendev.org/openstack/training-labs/raw/branch/master/labs/osbash/lib/osbash/netboot/ks-all-v2.cfg

readonly _BOOT_ARGS="linux ks=%s"

# ostype used by VirtualBox to choose icon and flags (64-bit, IOAPIC)
VBOX_OSTYPE=RedHat_64

function distro_start_installer {
    local vm_name=$1

    # pick a _KS_* file
    local kickstart=_KS_$VM_ACCESS

    echo "Using $kickstart ${!kickstart}"

    local boot_args=$(printf "$_BOOT_ARGS" "${!kickstart}")

    keyboard_send_escape "$vm_name"

    conditional_sleep 1

    echo -e "${CStatus:-}Pushing boot command line${CReset:-}"
    keyboard_send_string "$vm_name" "$boot_args"

    echo "Initiating boot sequence"
    keyboard_send_enter "$vm_name"
}

# vim: set ai ts=4 sw=4 et ft=sh:
