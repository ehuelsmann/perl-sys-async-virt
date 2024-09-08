####################################################################
#
#     This file was generated using XDR::Parse version ,
#        XDR::Gen version __XDR_GEN_VERSION__ and LibVirt version v10.3.0
#
#      Don't edit this file, use the source template instead
#
#                 ANY CHANGES HERE WILL BE LOST !
#
####################################################################


use v5.14;
use warnings;
use Future::AsyncAwait;

package Sys::Async::Virt v10.3.0;

use parent qw(IO::Async::Notifier);

use Carp qw(croak);
use Log::Any qw($log);
use Scalar::Util qw(reftype weaken);

use Protocol::Sys::Virt::Remote::XDR v10.3.3;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use Sys::Async::Virt::Domain v10.3.0;
use Sys::Async::Virt::DomainCheckpoint v10.3.0;
use Sys::Async::Virt::DomainSnapshot v10.3.0;
use Sys::Async::Virt::Network v10.3.0;
use Sys::Async::Virt::NetworkPort v10.3.0;
use Sys::Async::Virt::NwFilter v10.3.0;
use Sys::Async::Virt::NwFilterBinding v10.3.0;
use Sys::Async::Virt::Interface v10.3.0;
use Sys::Async::Virt::StoragePool v10.3.0;
use Sys::Async::Virt::StorageVol v10.3.0;
use Sys::Async::Virt::NodeDevice v10.3.0;
use Sys::Async::Virt::Secret v10.3.0;

use constant {
    CLOSE_REASON_ERROR                                 => 0,
    CLOSE_REASON_EOF                                   => 1,
    CLOSE_REASON_KEEPALIVE                             => 2,
    CLOSE_REASON_CLIENT                                => 3,
    TYPED_PARAM_INT                                    => 1,
    TYPED_PARAM_UINT                                   => 2,
    TYPED_PARAM_LLONG                                  => 3,
    TYPED_PARAM_ULLONG                                 => 4,
    TYPED_PARAM_DOUBLE                                 => 5,
    TYPED_PARAM_BOOLEAN                                => 6,
    TYPED_PARAM_STRING                                 => 7,
    TYPED_PARAM_STRING_OKAY                            => 1 << 2,
    TYPED_PARAM_FIELD_LENGTH                           => 80,
    DOMAIN_DEFINE_VALIDATE                             => (1 << 0),
    LIST_DOMAINS_ACTIVE                                => 1 << 0,
    LIST_DOMAINS_INACTIVE                              => 1 << 1,
    LIST_DOMAINS_PERSISTENT                            => 1 << 2,
    LIST_DOMAINS_TRANSIENT                             => 1 << 3,
    LIST_DOMAINS_RUNNING                               => 1 << 4,
    LIST_DOMAINS_PAUSED                                => 1 << 5,
    LIST_DOMAINS_SHUTOFF                               => 1 << 6,
    LIST_DOMAINS_OTHER                                 => 1 << 7,
    LIST_DOMAINS_MANAGEDSAVE                           => 1 << 8,
    LIST_DOMAINS_NO_MANAGEDSAVE                        => 1 << 9,
    LIST_DOMAINS_AUTOSTART                             => 1 << 10,
    LIST_DOMAINS_NO_AUTOSTART                          => 1 << 11,
    LIST_DOMAINS_HAS_SNAPSHOT                          => 1 << 12,
    LIST_DOMAINS_NO_SNAPSHOT                           => 1 << 13,
    LIST_DOMAINS_HAS_CHECKPOINT                        => 1 << 14,
    LIST_DOMAINS_NO_CHECKPOINT                         => 1 << 15,
    GET_ALL_DOMAINS_STATS_ACTIVE                       => 1 << 0,
    GET_ALL_DOMAINS_STATS_INACTIVE                     => 1 << 1,
    GET_ALL_DOMAINS_STATS_PERSISTENT                   => 1 << 2,
    GET_ALL_DOMAINS_STATS_TRANSIENT                    => 1 << 3,
    GET_ALL_DOMAINS_STATS_RUNNING                      => 1 << 4,
    GET_ALL_DOMAINS_STATS_PAUSED                       => 1 << 5,
    GET_ALL_DOMAINS_STATS_SHUTOFF                      => 1 << 6,
    GET_ALL_DOMAINS_STATS_OTHER                        => 1 << 7,
    GET_ALL_DOMAINS_STATS_NOWAIT                       => 1 << 29,
    GET_ALL_DOMAINS_STATS_BACKING                      => 1 << 30,
    GET_ALL_DOMAINS_STATS_ENFORCE_STATS                => 1 << 31,
    DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_CONNECTED       => 1,
    DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_DISCONNECTED    => 2,
    DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_UNKNOWN        => 0,
    DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_DOMAIN_STARTED => 1,
    DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_CHANNEL        => 2,
    DOMAIN_EVENT_ID_LIFECYCLE                          => 0,
    DOMAIN_EVENT_ID_REBOOT                             => 1,
    DOMAIN_EVENT_ID_RTC_CHANGE                         => 2,
    DOMAIN_EVENT_ID_WATCHDOG                           => 3,
    DOMAIN_EVENT_ID_IO_ERROR                           => 4,
    DOMAIN_EVENT_ID_GRAPHICS                           => 5,
    DOMAIN_EVENT_ID_IO_ERROR_REASON                    => 6,
    DOMAIN_EVENT_ID_CONTROL_ERROR                      => 7,
    DOMAIN_EVENT_ID_BLOCK_JOB                          => 8,
    DOMAIN_EVENT_ID_DISK_CHANGE                        => 9,
    DOMAIN_EVENT_ID_TRAY_CHANGE                        => 10,
    DOMAIN_EVENT_ID_PMWAKEUP                           => 11,
    DOMAIN_EVENT_ID_PMSUSPEND                          => 12,
    DOMAIN_EVENT_ID_BALLOON_CHANGE                     => 13,
    DOMAIN_EVENT_ID_PMSUSPEND_DISK                     => 14,
    DOMAIN_EVENT_ID_DEVICE_REMOVED                     => 15,
    DOMAIN_EVENT_ID_BLOCK_JOB_2                        => 16,
    DOMAIN_EVENT_ID_TUNABLE                            => 17,
    DOMAIN_EVENT_ID_AGENT_LIFECYCLE                    => 18,
    DOMAIN_EVENT_ID_DEVICE_ADDED                       => 19,
    DOMAIN_EVENT_ID_MIGRATION_ITERATION                => 20,
    DOMAIN_EVENT_ID_JOB_COMPLETED                      => 21,
    DOMAIN_EVENT_ID_DEVICE_REMOVAL_FAILED              => 22,
    DOMAIN_EVENT_ID_METADATA_CHANGE                    => 23,
    DOMAIN_EVENT_ID_BLOCK_THRESHOLD                    => 24,
    DOMAIN_EVENT_ID_MEMORY_FAILURE                     => 25,
    DOMAIN_EVENT_ID_MEMORY_DEVICE_SIZE_CHANGE          => 26,
    SUSPEND_TARGET_MEM                                 => 0,
    SUSPEND_TARGET_DISK                                => 1,
    SUSPEND_TARGET_HYBRID                              => 2,
    SECURITY_LABEL_BUFLEN                              => (4096 + 1),
    SECURITY_MODEL_BUFLEN                              => (256 + 1),
    SECURITY_DOI_BUFLEN                                => (256 + 1),
    CPU_STATS_FIELD_LENGTH                             => 80,
    CPU_STATS_ALL_CPUS                                 => -1,
    CPU_STATS_KERNEL                                   => "kernel",
    CPU_STATS_USER                                     => "user",
    CPU_STATS_IDLE                                     => "idle",
    CPU_STATS_IOWAIT                                   => "iowait",
    CPU_STATS_INTR                                     => "intr",
    CPU_STATS_UTILIZATION                              => "utilization",
    MEMORY_STATS_FIELD_LENGTH                          => 80,
    MEMORY_STATS_ALL_CELLS                             => -1,
    MEMORY_STATS_TOTAL                                 => "total",
    MEMORY_STATS_FREE                                  => "free",
    MEMORY_STATS_BUFFERS                               => "buffers",
    MEMORY_STATS_CACHED                                => "cached",
    MEMORY_SHARED_PAGES_TO_SCAN                        => "shm_pages_to_scan",
    MEMORY_SHARED_SLEEP_MILLISECS                      => "shm_sleep_millisecs",
    MEMORY_SHARED_PAGES_SHARED                         => "shm_pages_shared",
    MEMORY_SHARED_PAGES_SHARING                        => "shm_pages_sharing",
    MEMORY_SHARED_PAGES_UNSHARED                       => "shm_pages_unshared",
    MEMORY_SHARED_PAGES_VOLATILE                       => "shm_pages_volatile",
    MEMORY_SHARED_FULL_SCANS                           => "shm_full_scans",
    MEMORY_SHARED_MERGE_ACROSS_NODES                   => "shm_merge_across_nodes",
    SEV_PDH                                            => "pdh",
    SEV_CERT_CHAIN                                     => "cert-chain",
    SEV_CPU0_ID                                        => "cpu0-id",
    SEV_CBITPOS                                        => "cbitpos",
    SEV_REDUCED_PHYS_BITS                              => "reduced-phys-bits",
    SEV_MAX_GUESTS                                     => "max-guests",
    SEV_MAX_ES_GUESTS                                  => "max-es-guests",
    RO                                                 => (1 << 0),
    NO_ALIASES                                         => (1 << 1),
    CRED_USERNAME                                      => 1,
    CRED_AUTHNAME                                      => 2,
    CRED_LANGUAGE                                      => 3,
    CRED_CNONCE                                        => 4,
    CRED_PASSPHRASE                                    => 5,
    CRED_ECHOPROMPT                                    => 6,
    CRED_NOECHOPROMPT                                  => 7,
    CRED_REALM                                         => 8,
    CRED_EXTERNAL                                      => 9,
    UUID_BUFLEN                                        => (16),
    UUID_STRING_BUFLEN                                 => (36+1),
    IDENTITY_USER_NAME                                 => "user-name",
    IDENTITY_UNIX_USER_ID                              => "unix-user-id",
    IDENTITY_GROUP_NAME                                => "group-name",
    IDENTITY_UNIX_GROUP_ID                             => "unix-group-id",
    IDENTITY_PROCESS_ID                                => "process-id",
    IDENTITY_PROCESS_TIME                              => "process-time",
    IDENTITY_SASL_USER_NAME                            => "sasl-user-name",
    IDENTITY_X509_DISTINGUISHED_NAME                   => "x509-distinguished-name",
    IDENTITY_SELINUX_CONTEXT                           => "selinux-context",
    CPU_COMPARE_ERROR                                  => -1,
    CPU_COMPARE_INCOMPATIBLE                           => 0,
    CPU_COMPARE_IDENTICAL                              => 1,
    CPU_COMPARE_SUPERSET                               => 2,
    COMPARE_CPU_FAIL_INCOMPATIBLE                      => (1 << 0),
    COMPARE_CPU_VALIDATE_XML                           => (1 << 1),
    BASELINE_CPU_EXPAND_FEATURES                       => (1 << 0),
    BASELINE_CPU_MIGRATABLE                            => (1 << 1),
    ALLOC_PAGES_ADD                                    => 0,
    ALLOC_PAGES_SET                                    => (1 << 0),
    LIST_INTERFACES_INACTIVE                           => 1 << 0,
    LIST_INTERFACES_ACTIVE                             => 1 << 1,
    INTERFACE_DEFINE_VALIDATE                          => 1 << 0,
    LIST_NETWORKS_INACTIVE                             => 1 << 0,
    LIST_NETWORKS_ACTIVE                               => 1 << 1,
    LIST_NETWORKS_PERSISTENT                           => 1 << 2,
    LIST_NETWORKS_TRANSIENT                            => 1 << 3,
    LIST_NETWORKS_AUTOSTART                            => 1 << 4,
    LIST_NETWORKS_NO_AUTOSTART                         => 1 << 5,
    NETWORK_CREATE_VALIDATE                            => 1 << 0,
    NETWORK_DEFINE_VALIDATE                            => 1 << 0,
    NETWORK_EVENT_ID_LIFECYCLE                         => 0,
    NETWORK_EVENT_ID_METADATA_CHANGE                   => 1,
    LIST_NODE_DEVICES_CAP_SYSTEM                       => 1 << 0,
    LIST_NODE_DEVICES_CAP_PCI_DEV                      => 1 << 1,
    LIST_NODE_DEVICES_CAP_USB_DEV                      => 1 << 2,
    LIST_NODE_DEVICES_CAP_USB_INTERFACE                => 1 << 3,
    LIST_NODE_DEVICES_CAP_NET                          => 1 << 4,
    LIST_NODE_DEVICES_CAP_SCSI_HOST                    => 1 << 5,
    LIST_NODE_DEVICES_CAP_SCSI_TARGET                  => 1 << 6,
    LIST_NODE_DEVICES_CAP_SCSI                         => 1 << 7,
    LIST_NODE_DEVICES_CAP_STORAGE                      => 1 << 8,
    LIST_NODE_DEVICES_CAP_FC_HOST                      => 1 << 9,
    LIST_NODE_DEVICES_CAP_VPORTS                       => 1 << 10,
    LIST_NODE_DEVICES_CAP_SCSI_GENERIC                 => 1 << 11,
    LIST_NODE_DEVICES_CAP_DRM                          => 1 << 12,
    LIST_NODE_DEVICES_CAP_MDEV_TYPES                   => 1 << 13,
    LIST_NODE_DEVICES_CAP_MDEV                         => 1 << 14,
    LIST_NODE_DEVICES_CAP_CCW_DEV                      => 1 << 15,
    LIST_NODE_DEVICES_CAP_CSS_DEV                      => 1 << 16,
    LIST_NODE_DEVICES_CAP_VDPA                         => 1 << 17,
    LIST_NODE_DEVICES_CAP_AP_CARD                      => 1 << 18,
    LIST_NODE_DEVICES_CAP_AP_QUEUE                     => 1 << 19,
    LIST_NODE_DEVICES_CAP_AP_MATRIX                    => 1 << 20,
    LIST_NODE_DEVICES_CAP_VPD                          => 1 << 21,
    LIST_NODE_DEVICES_PERSISTENT                       => 1 << 28,
    LIST_NODE_DEVICES_TRANSIENT                        => 1 << 29,
    LIST_NODE_DEVICES_INACTIVE                         => 1 << 30,
    LIST_NODE_DEVICES_ACTIVE                           => 1 << 31,
    NODE_DEVICE_CREATE_XML_VALIDATE                    => 1 << 0,
    NODE_DEVICE_DEFINE_XML_VALIDATE                    => 1 << 0,
    NODE_DEVICE_EVENT_ID_LIFECYCLE                     => 0,
    NODE_DEVICE_EVENT_ID_UPDATE                        => 1,
    NWFILTER_DEFINE_VALIDATE                           => 1 << 0,
    NWFILTER_BINDING_CREATE_VALIDATE                   => 1 << 0,
    SECRET_USAGE_TYPE_NONE                             => 0,
    SECRET_USAGE_TYPE_VOLUME                           => 1,
    SECRET_USAGE_TYPE_CEPH                             => 2,
    SECRET_USAGE_TYPE_ISCSI                            => 3,
    SECRET_USAGE_TYPE_TLS                              => 4,
    SECRET_USAGE_TYPE_VTPM                             => 5,
    LIST_SECRETS_EPHEMERAL                             => 1 << 0,
    LIST_SECRETS_NO_EPHEMERAL                          => 1 << 1,
    LIST_SECRETS_PRIVATE                               => 1 << 2,
    LIST_SECRETS_NO_PRIVATE                            => 1 << 3,
    SECRET_DEFINE_VALIDATE                             => 1 << 0,
    SECRET_EVENT_ID_LIFECYCLE                          => 0,
    SECRET_EVENT_ID_VALUE_CHANGED                      => 1,
    STORAGE_POOL_CREATE_NORMAL                         => 0,
    STORAGE_POOL_CREATE_WITH_BUILD                     => 1 << 0,
    STORAGE_POOL_CREATE_WITH_BUILD_OVERWRITE           => 1 << 1,
    STORAGE_POOL_CREATE_WITH_BUILD_NO_OVERWRITE        => 1 << 2,
    LIST_STORAGE_POOLS_INACTIVE                        => 1 << 0,
    LIST_STORAGE_POOLS_ACTIVE                          => 1 << 1,
    LIST_STORAGE_POOLS_PERSISTENT                      => 1 << 2,
    LIST_STORAGE_POOLS_TRANSIENT                       => 1 << 3,
    LIST_STORAGE_POOLS_AUTOSTART                       => 1 << 4,
    LIST_STORAGE_POOLS_NO_AUTOSTART                    => 1 << 5,
    LIST_STORAGE_POOLS_DIR                             => 1 << 6,
    LIST_STORAGE_POOLS_FS                              => 1 << 7,
    LIST_STORAGE_POOLS_NETFS                           => 1 << 8,
    LIST_STORAGE_POOLS_LOGICAL                         => 1 << 9,
    LIST_STORAGE_POOLS_DISK                            => 1 << 10,
    LIST_STORAGE_POOLS_ISCSI                           => 1 << 11,
    LIST_STORAGE_POOLS_SCSI                            => 1 << 12,
    LIST_STORAGE_POOLS_MPATH                           => 1 << 13,
    LIST_STORAGE_POOLS_RBD                             => 1 << 14,
    LIST_STORAGE_POOLS_SHEEPDOG                        => 1 << 15,
    LIST_STORAGE_POOLS_GLUSTER                         => 1 << 16,
    LIST_STORAGE_POOLS_ZFS                             => 1 << 17,
    LIST_STORAGE_POOLS_VSTORAGE                        => 1 << 18,
    LIST_STORAGE_POOLS_ISCSI_DIRECT                    => 1 << 19,
    STORAGE_POOL_DEFINE_VALIDATE                       => 1 << 0,
    STORAGE_VOL_CREATE_PREALLOC_METADATA               => 1 << 0,
    STORAGE_VOL_CREATE_REFLINK                         => 1 << 1,
    STORAGE_VOL_CREATE_VALIDATE                        => 1 << 2,
    STORAGE_POOL_EVENT_ID_LIFECYCLE                    => 0,
    STORAGE_POOL_EVENT_ID_REFRESH                      => 1,
};



sub _no_translation {
    shift;
    return @_;
}

sub _translate_remote_nonnull_domain {
    $_[0]->domain_instance( $_[1] );
}

sub _translate_remote_nonnull_domain_checkpoint {
    $_[0]->domain_checkpoint_instance( $_[1] );
}

sub _translate_remote_nonnull_domain_snapshot {
    $_[0]->domain_snapshot_instance( $_[1] );
}

sub _translate_remote_nonnull_network {
    $_[0]->network_instance( $_[1] );
}

sub _translate_remote_nonnull_network_port {
    $_[0]->network_port_instance( $_[1] );
}

sub _translate_remote_nonnull_nwfilter {
    $_[0]->network_nwfilter_instance( $_[1] );
}

sub _translate_remote_nonnull_nwfilter_binding {
    $_[0]->network_nwfilter_binding_instance( $_[1] );
}

sub _translate_remote_nonnull_interface {
    $_[0]->network_interface_instance( $_[1] );
}

sub _translate_remote_nonnull_storage_pool {
    $_[0]->storage_pool_instance( $_[1] );
}

sub _translate_remote_nonnull_storage_vol {
    $_[0]->storage_vol_instance( $_[1] );
}

sub _translate_remote_nonnull_node_device {
    $_[0]->node_device_instance( $_[1] );
}

sub _translate_remote_nonnull_secret {
    $_[0]->secret_instance( $_[1] );
}

my @reply_translators = (
    undef,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 10; my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 11; my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 22; my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 23; my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 24; my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 40; my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 41; my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 46; my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 47; my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 63; my $client = shift; _translated($client, { ddom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 76; my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 77; my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 84; my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 85; my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 86; my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 93; my $client = shift; _translated($client, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    \&_no_translation,
    sub { 95; my $client = shift; _translated($client, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 96; my $client = shift; _translated($client, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 97; my $client = shift; _translated($client, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 109; my $client = shift; _translated($client, { ddom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 113; my $client = shift; _translated($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 123; my $client = shift; _translated($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { 125; my $client = shift; _translated($client, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 128; my $client = shift; _translated($client, { iface => \&_translate_remote_nonnull_interface }, @_) },
    sub { 129; my $client = shift; _translated($client, { iface => \&_translate_remote_nonnull_interface }, @_) },
    \&_no_translation,
    sub { 131; my $client = shift; _translated($client, { iface => \&_translate_remote_nonnull_interface }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 141; my $client = shift; _translated($client, { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { 142; my $client = shift; _translated($client, { secret => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 147; my $client = shift; _translated($client, { secret => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 175; my $client = shift; _translated($client, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 176; my $client = shift; _translated($client, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 180; my $client = shift; _translated($client, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 185; my $client = shift; _translated($client, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 189; my $client = shift; _translated($client, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    sub { 191; my $client = shift; _translated($client, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 196; my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    undef,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    undef,
    \&_no_translation,
    \&_no_translation,
    sub { 244; my $client = shift; _translated($client, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    undef,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 273; my $client = shift; _translated($client, { domains => \&_translate_remote_nonnull_domain }, @_) },
    sub { 274; my $client = shift; _translated($client, { snapshots => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 275; my $client = shift; _translated($client, { snapshots => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 281; my $client = shift; _translated($client, { pools => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 282; my $client = shift; _translated($client, { vols => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 283; my $client = shift; _translated($client, { nets => \&_translate_remote_nonnull_network }, @_) },
    sub { 284; my $client = shift; _translated($client, { ifaces => \&_translate_remote_nonnull_interface }, @_) },
    sub { 285; my $client = shift; _translated($client, { devices => \&_translate_remote_nonnull_node_device }, @_) },
    sub { 286; my $client = shift; _translated($client, { filters => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 287; my $client = shift; _translated($client, { secrets => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 297; my $client = shift; _translated($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { my $client = shift; _translated($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    undef,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 350; my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    undef,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    sub { my $client = shift; _translated($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { my $client = shift; _translated($client, { secret => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 391; my $client = shift; _translated($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 397; my $client = shift; _translated($client, { nwfilter => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    \&_no_translation,
    sub { 399; my $client = shift; _translated($client, { nwfilter => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    \&_no_translation,
    sub { 401; my $client = shift; _translated($client, { bindings => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 404; my $client = shift; _translated($client, { ports => \&_translate_remote_nonnull_network_port }, @_) },
    sub { 405; my $client = shift; _translated($client, { port => \&_translate_remote_nonnull_network_port }, @_) },
    sub { 406; my $client = shift; _translated($client, { port => \&_translate_remote_nonnull_network_port }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 411; my $client = shift; _translated($client, { checkpoint => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    \&_no_translation,
    sub { 413; my $client = shift; _translated($client, { checkpoints => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 414; my $client = shift; _translated($client, { checkpoints => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 415; my $client = shift; _translated($client, { checkpoint => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 416; my $client = shift; _translated($client, { parent => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 428; my $client = shift; _translated($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 431; my $client = shift; _translated($client, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 432; my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 437; my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    sub { my $client = shift; _translated($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { my $client = shift; _translated($client, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation
);


sub _translated {
    my $client = shift;
    my $argmap = shift;
    my %args = @_;

    return @_ unless $args{data};
    my $data = $args{data};
    for my $key (keys %{ $argmap }) {
        my $val = $data->{$key};

        if (ref $argmap->{$key} and reftype $argmap->{$key} eq 'HASH') {
            $data->{$key} = { _translated( $client, $argmap->{$key}, %{ $val } ) };
        }
        elsif (ref $val and reftype $val eq 'ARRAY') {
            $data->{$key} = [ map { $argmap->{$key}->( $client, $_ ) } @{ $val } ];
        }
        else {
            $data->{$key} = $argmap->{$key}->( $client, $val );
        }
    }

    return (%args, );
}

sub _domain_factory {
    return Sys::Async::Virt::Domain->new( @_ );
}

sub _domain_checkpoint_factory {
    return Sys::Async::Virt::DomainCheckpoint->new( @_ );
}

sub _domain_snapshot_factory {
    return Sys::Async::Virt::DomainSnapshot->new( @_ );
}

sub _network_factory {
    return Sys::Async::Virt::Network->new( @_ );
}

sub _network_port_factory {
    return Sys::Async::Virt::NetworkPort->new( @_ );
}

sub _nwfilter_factory {
    return Sys::Async::Virt::NwFilter->new( @_ );
}

sub _nwfilter_binding_factory {
    return Sys::Async::Virt::NwFilterBinding->new( @_ );
}

sub _interface_factory {
    return Sys::Async::Virt::Interface->new( @_ );
}

sub _storage_pool_factory {
    return Sys::Async::Virt::StoragePool->new( @_ );
}

sub _storage_vol_factory {
    return Sys::Async::Virt::StorageVol->new( @_ );
}

sub _node_device_factory {
    return Sys::Async::Virt::NodeDevice->new( @_ );
}

sub _secret_factory {
    return Sys::Async::Virt::Secret->new( @_ );
}

sub new {
    my ($class, %args) = @_;
    my $self = bless {
        _domains => {},
        _domain_checkpoints => {},
        _domain_snapshots   => {},
        _networks => {},
        _network_ports => {},
        _nwfilters => {},
        _nwfilter_bindings => {},
        _interfaces => {},
        _storage_pools => {},
        _storage_vols => {},
        _node_devices => {},
        _secrets => {},
        _callbacks => {},

        _replies => {},
        _streams => {},

        domain_factory            => \&_domain_factory,
        domain_checkpoint_factory => \&_domain_checkpoint_factory,
        domain_snapshot_factory   => \&_domain_snapshot_factory,
        network_factory           => \&_network_factory,
        network_port_factory      => \&_network_port_factory,
        nwfilter_factory          => \&_nwfilter_factory,
        nwfilter_binding_factory  => \&_nwfilter_binding_factory,
        interface_factory         => \&_interface_factory,
        storage_pool_factory      => \&_storage_pool_factory,
        storage_vol_factory       => \&_storage_vol_factory,
        node_device_factory       => \&_node_device_factory,
        secret_factory            => \&_secret_factory,
    }, $class;

    $self->register( $args{remote} ) if $args{remote};
    return $self;
}

sub domain_instance {
    my ($self, $id) = @_;
    my $c = $self->{_domains}->{$id->{uuid}}
       //= $self->{domain_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_domains}->{$id->{uuid}};
    return $c;
}

sub domain_checkpoint_instance {
    my ($self, $id) = @_;
    my $key = "$id->{dom}->{uuid}/$id->{name}";
    my $c = $self->{_domain_checkpoints}->{$key}
       //= $self->{domain_checkpoint_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_domain_checkpoints}->{$key};
    return $c;
}

sub domain_snapshot_instance {
    my ($self, $id) = @_;
    my $key = "$id->{dom}->{uuid}/$id->{name}";
    my $c = $self->{_domain_snapshots}->{$id->{uuid}}
       //= $self->{domain_snapshot_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_domain_snapshots}->{$id->{uuid}};
    return $c;
}

sub network_instance {
    my ($self, $id) = @_;
    my $c = $self->{_networks}->{$id->{uuid}}
       //= $self->{network_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_networks}->{$id->{uuid}};
    return $c;
}

sub network_port_instance {
    my ($self, $id) = @_;
    my $c = $self->{_network_ports}->{$id->{uuid}}
       //= $self->{network_port_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_network_ports}->{$id->{uuid}};
    return $c;
}

sub nwfilter_instance {
    my ($self, $id) = @_;
    my $c = $self->{_nwfilters}->{$id->{uuid}}
       //= $self->{nwfilter_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_nwfilters}->{$id->{uuid}};
    return $c;
}

sub nwfilter_binding_instance {
    my ($self, $id) = @_;
    my $key = "$id->{portdev}/$id->{filtername}";
    my $c = $self->{_nwfilter_bindings}->{$key}
       //= $self->{nwfilter_binding_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_nwfilter_bindings}->{$key};
    return $c;
}

sub interface_instance {
    my ($self, $id) = @_;
    my $key = "$id->{mac}/$id->{name}";
    my $c = $self->{_interfaces}->{$key}
       //= $self->{interface_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_interfaces}->{$key};
    return $c;
}

sub storage_pool_instance {
    my ($self, $id) = @_;
    my $c = $self->{_storage_pools}->{$id->{uuid}}
       //= $self->{storage_pool_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_storage_pools}->{$id->{uuid}};
    return $c;
}

sub storage_vol_instance {
    my ($self, $id) = @_;
    my $c = $self->{_storage_vols}->{$id->{key}}
       //= $self->{storage_vol_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_storage_vols}->{$id->{key}};
    return $c;
}

sub node_device_instance {
    my ($self, $id) = @_;
    my $c = $self->{_node_devices}->{$id->{name}}
       //= $self->{node_device_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_node_devices}->{$id->{name}};
    return $c;
}

sub secret_instance {
    my ($self, $id) = @_;
    my $c = $self->{_secrets}->{$id->{uuid}}
       //= $self->{secret_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_secrets}->{$id->{uuid}};
    return $c;
}

async sub _call {
    my $self = shift;
    my $serial = await $self->{remote}->call( @_ );
    my $f = $self->loop->new_future;
    $log->trace( "Setting serial $serial future" );
    $self->{_replies}->{$serial} = $f;
    return await $f;
}

sub _dispatch_closed {
    my $self = shift;

    $self->{on_closed}->( @_ );
}

sub _dispatch_message {
    my $self = shift;
    my %args = @_;

    if ($args{data}
        and defined $args{data}->{callbackID}
        and my $cb = $self->{_callbacks}->{$args{data}->{callbackID}}) {
        my %cbargs = $reply_translators[$args{header}->{proc}]->( @_ );
        $cb->( %{ $cbargs{data}->{msg} } );
    }
    else {
        $self->{on_message}->( $reply_translators[$args{header}->{proc}]->( @_ ) );
    }
}

sub _dispatch_reply {
    my ($self, %args) = @_;
    my $f = delete $self->{_replies}->{$args{header}->{serial}};

    if (exists $args{data}) {
        my %cbargs = $reply_translators[$args{header}->{proc}]->( @_ );
        $f->done( $cbargs{data} );
    }
    elsif (exists $args{error}) {
        $f->fail( $args{error}->{message}, undef, $args{error} );
    }
    else {
        die 'Unhandled reply';
    }

    return;
}

sub _dispatch_stream {
    my $self = shift;
    my %args = @_;

    if (my $stream = $self->{_streams}->{$args{header}->{serial}}) {
       $stream->process_protocol_message( @_ );
    }
    else {
        $self->{on_stream}->( @_ );
    }
}

sub configure {
    my $self = shift;
    my %args = @_;
    for my $key (keys %args) {
        $self->{$key} = $args{$key} // sub {};
    }
}

sub register {
    my $self = shift;
    my $r = shift;

    $r->configure(
        on_closed  => sub { $self->_dispatch_closed( @_ ) },
        on_message => sub { $self->_dispatch_message( @_ ) },
        on_reply   => sub { $self->_dispatch_reply( @_ ) },
        on_stream  => sub { $self->_dispatch_stream( @_ ) }
        );
    $self->{remote} = $r;
}

sub register_callback {
    my ($self, $callbackID, $callback) = @_;
    $self->{_callbacks}->{$callbackID} = $callback;
}

sub unregister_callback {
    my ($self, $callbackID) = @_;
    delete $self->{_callbacks}->{$callbackID};
}

sub register_stream {
    my ($self, $serial, $stream) = @_;
    $self->{_streams}->{$serial} = $stream;
    weaken $self->{_streams}->{$serial};
    $stream->configure( parent => $self );
}

sub unregister_stream {
    my ($self, $serial) = @_;
    delete $self->{_streams}->{$serial};
}

async sub auth {
    my ($self, $auth_type) = @_;

    my $rv = await $self->_call( $remote->PROC_AUTH_LIST );
    my $auth_types = $rv->{types};
    my $selected = $remote->AUTH_NONE;
    for my $type ( @{ $auth_types } ) {
        if ($auth_type == $type) {
            $selected = $type;
            last;
        }
    }
    return if $selected == $remote->AUTH_NONE;

    if ($selected == $remote->AUTH_POLKIT) {
        await $self->_call( $remote->PROC_AUTH_POLKIT );
        return;
    }
    if ($selected == $remote->AUTH_SASL) {
        $rv = await $self->_call( $remote->PROC_AUTH_SASL_INIT );
        my $mechs = $rv->{mechlist};
        ...
    }
    return;
}


sub open {
    my ($self, $url, $flags) = @_;
    $self->_call( $remote->PROC_CONNECT_OPEN,
                  { name => $url, flags => $flags // 0 } );
}

sub close {
    my ($self) = @_;
    $self->_call( $remote->PROC_CONNECT_CLOSE, {} );
}


sub baseline_cpu {
    my ($self, $xmlCPUs, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_BASELINE_CPU,
        { xmlCPUs => $xmlCPUs, flags => $flags // 0 } );
}

sub baseline_hypervisor_cpu {
    my ($self, $emulator, $arch, $machine, $virttype, $xmlCPUs, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_BASELINE_HYPERVISOR_CPU,
        { emulator => $emulator, arch => $arch, machine => $machine, virttype => $virttype, xmlCPUs => $xmlCPUs, flags => $flags // 0 } );
}

sub compare_cpu {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_COMPARE_CPU,
        { xml => $xml, flags => $flags // 0 } );
}

sub compare_hypervisor_cpu {
    my ($self, $emulator, $arch, $machine, $virttype, $xmlCPU, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_COMPARE_HYPERVISOR_CPU,
        { emulator => $emulator, arch => $arch, machine => $machine, virttype => $virttype, xmlCPU => $xmlCPU, flags => $flags // 0 } );
}

sub domain_create_xml {
    my ($self, $xml_desc, $flags) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_CREATE_XML,
        { xml_desc => $xml_desc, flags => $flags // 0 } );
}

sub domain_define_xml {
    my ($self, $xml) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_DEFINE_XML,
        { xml => $xml } );
}

sub domain_define_xml_flags {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub domain_lookup_by_id {
    my ($self, $id) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_ID,
        { id => $id } );
}

sub domain_lookup_by_name {
    my ($self, $name) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_NAME,
        { name => $name } );
}

sub domain_lookup_by_uuid {
    my ($self, $uuid) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub domain_migrate_finish {
    my ($self, $dname, $cookie, $uri, $flags) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_FINISH,
        { dname => $dname, cookie => $cookie, uri => $uri, flags => $flags // 0 } );
}

sub domain_migrate_finish2 {
    my ($self, $dname, $cookie, $uri, $flags, $retcode) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_FINISH2,
        { dname => $dname, cookie => $cookie, uri => $uri, flags => $flags // 0, retcode => $retcode } );
}

sub domain_migrate_prepare_tunnel {
    my ($self, $flags, $dname, $resource, $dom_xml) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_PREPARE_TUNNEL,
        { flags => $flags // 0, dname => $dname, resource => $resource, dom_xml => $dom_xml } );
}

sub domain_restore {
    my ($self, $from) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_RESTORE,
        { from => $from } );
}

sub domain_restore_flags {
    my ($self, $from, $dxml, $flags) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_RESTORE_FLAGS,
        { from => $from, dxml => $dxml, flags => $flags // 0 } );
}

sub domain_restore_params {
    my ($self, $params, $flags) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_RESTORE_PARAMS,
        { params => $params, flags => $flags // 0 } );
}

sub domain_save_image_define_xml {
    my ($self, $file, $dxml, $flags) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_SAVE_IMAGE_DEFINE_XML,
        { file => $file, dxml => $dxml, flags => $flags // 0 } );
}

sub domain_save_image_get_xml_desc {
    my ($self, $file, $flags) = @_;
    return $self->_call(
        $remote->PROC_DOMAIN_SAVE_IMAGE_GET_XML_DESC,
        { file => $file, flags => $flags // 0 } );
}

sub domain_xml_from_native {
    my ($self, $nativeFormat, $nativeConfig, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_DOMAIN_XML_FROM_NATIVE,
        { nativeFormat => $nativeFormat, nativeConfig => $nativeConfig, flags => $flags // 0 } );
}

sub domain_xml_to_native {
    my ($self, $nativeFormat, $domainXml, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_DOMAIN_XML_TO_NATIVE,
        { nativeFormat => $nativeFormat, domainXml => $domainXml, flags => $flags // 0 } );
}

sub get_capabilities {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_CAPABILITIES,
        {  } );
}

sub get_domain_capabilities {
    my ($self, $emulatorbin, $arch, $machine, $virttype, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_DOMAIN_CAPABILITIES,
        { emulatorbin => $emulatorbin, arch => $arch, machine => $machine, virttype => $virttype, flags => $flags // 0 } );
}

sub get_hostname {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_HOSTNAME,
        {  } );
}

sub get_lib_version {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_LIB_VERSION,
        {  } );
}

sub get_max_vcpus {
    my ($self, $type) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_MAX_VCPUS,
        { type => $type } );
}

sub get_storage_pool_capabilities {
    my ($self, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_STORAGE_POOL_CAPABILITIES,
        { flags => $flags // 0 } );
}

sub get_sysinfo {
    my ($self, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_SYSINFO,
        { flags => $flags // 0 } );
}

sub get_version {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_GET_VERSION,
        {  } );
}

sub interface_change_begin {
    my ($self, $flags) = @_;
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_BEGIN,
        { flags => $flags // 0 } );
}

sub interface_change_commit {
    my ($self, $flags) = @_;
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_COMMIT,
        { flags => $flags // 0 } );
}

sub interface_change_rollback {
    my ($self, $flags) = @_;
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_ROLLBACK,
        { flags => $flags // 0 } );
}

sub interface_define_xml {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_INTERFACE_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub interface_lookup_by_mac_string {
    my ($self, $mac) = @_;
    return $self->_call(
        $remote->PROC_INTERFACE_LOOKUP_BY_MAC_STRING,
        { mac => $mac } );
}

sub interface_lookup_by_name {
    my ($self, $name) = @_;
    return $self->_call(
        $remote->PROC_INTERFACE_LOOKUP_BY_NAME,
        { name => $name } );
}

sub list_all_domains {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_DOMAINS,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_all_interfaces {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_INTERFACES,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_all_networks {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NETWORKS,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_all_node_devices {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NODE_DEVICES,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_all_nwfilter_bindings {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NWFILTER_BINDINGS,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_all_nwfilters {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NWFILTERS,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_all_secrets {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_SECRETS,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_all_storage_pools {
    my ($self, $need_results, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_STORAGE_POOLS,
        { need_results => $need_results, flags => $flags // 0 } );
}

sub list_defined_domains {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_DOMAINS,
        { maxnames => $maxnames } );
}

sub list_defined_interfaces {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_INTERFACES,
        { maxnames => $maxnames } );
}

sub list_defined_networks {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_NETWORKS,
        { maxnames => $maxnames } );
}

sub list_defined_storage_pools {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_STORAGE_POOLS,
        { maxnames => $maxnames } );
}

sub list_interfaces {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_INTERFACES,
        { maxnames => $maxnames } );
}

sub list_networks {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_NETWORKS,
        { maxnames => $maxnames } );
}

sub list_nwfilters {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_NWFILTERS,
        { maxnames => $maxnames } );
}

sub list_secrets {
    my ($self, $maxuuids) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_SECRETS,
        { maxuuids => $maxuuids } );
}

sub list_storage_pools {
    my ($self, $maxnames) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_LIST_STORAGE_POOLS,
        { maxnames => $maxnames } );
}

sub network_create_xml {
    my ($self, $xml) = @_;
    return $self->_call(
        $remote->PROC_NETWORK_CREATE_XML,
        { xml => $xml } );
}

sub network_create_xml_flags {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_NETWORK_CREATE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub network_define_xml {
    my ($self, $xml) = @_;
    return $self->_call(
        $remote->PROC_NETWORK_DEFINE_XML,
        { xml => $xml } );
}

sub network_define_xml_flags {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_NETWORK_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub network_lookup_by_name {
    my ($self, $name) = @_;
    return $self->_call(
        $remote->PROC_NETWORK_LOOKUP_BY_NAME,
        { name => $name } );
}

sub network_lookup_by_uuid {
    my ($self, $uuid) = @_;
    return $self->_call(
        $remote->PROC_NETWORK_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub node_get_free_memory {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_NODE_GET_FREE_MEMORY,
        {  } );
}

sub node_get_info {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_NODE_GET_INFO,
        {  } );
}

sub node_list_devices {
    my ($self, $cap, $maxnames, $flags) = @_;
    return $self->_call(
        $remote->PROC_NODE_LIST_DEVICES,
        { cap => $cap, maxnames => $maxnames, flags => $flags // 0 } );
}

sub node_num_of_devices {
    my ($self, $cap, $flags) = @_;
    return $self->_call(
        $remote->PROC_NODE_NUM_OF_DEVICES,
        { cap => $cap, flags => $flags // 0 } );
}

sub node_set_memory_parameters {
    my ($self, $params, $flags) = @_;
    return $self->_call(
        $remote->PROC_NODE_SET_MEMORY_PARAMETERS,
        { params => $params, flags => $flags // 0 } );
}

sub node_suspend_for_duration {
    my ($self, $target, $duration, $flags) = @_;
    return $self->_call(
        $remote->PROC_NODE_SUSPEND_FOR_DURATION,
        { target => $target, duration => $duration, flags => $flags // 0 } );
}

sub num_of_defined_domains {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_DOMAINS,
        {  } );
}

sub num_of_defined_interfaces {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_INTERFACES,
        {  } );
}

sub num_of_defined_networks {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_NETWORKS,
        {  } );
}

sub num_of_defined_storage_pools {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_STORAGE_POOLS,
        {  } );
}

sub num_of_domains {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DOMAINS,
        {  } );
}

sub num_of_interfaces {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_INTERFACES,
        {  } );
}

sub num_of_networks {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_NETWORKS,
        {  } );
}

sub num_of_nwfilters {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_NWFILTERS,
        {  } );
}

sub num_of_secrets {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_SECRETS,
        {  } );
}

sub num_of_storage_pools {
    my ($self, ) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_STORAGE_POOLS,
        {  } );
}

sub nwfilter_binding_create_xml {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_NWFILTER_BINDING_CREATE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub nwfilter_binding_lookup_by_port_dev {
    my ($self, $name) = @_;
    return $self->_call(
        $remote->PROC_NWFILTER_BINDING_LOOKUP_BY_PORT_DEV,
        { name => $name } );
}

sub nwfilter_define_xml {
    my ($self, $xml) = @_;
    return $self->_call(
        $remote->PROC_NWFILTER_DEFINE_XML,
        { xml => $xml } );
}

sub nwfilter_define_xml_flags {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_NWFILTER_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub nwfilter_lookup_by_name {
    my ($self, $name) = @_;
    return $self->_call(
        $remote->PROC_NWFILTER_LOOKUP_BY_NAME,
        { name => $name } );
}

sub nwfilter_lookup_by_uuid {
    my ($self, $uuid) = @_;
    return $self->_call(
        $remote->PROC_NWFILTER_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub secret_define_xml {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_SECRET_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub secret_lookup_by_usage {
    my ($self, $usageType, $usageID) = @_;
    return $self->_call(
        $remote->PROC_SECRET_LOOKUP_BY_USAGE,
        { usageType => $usageType, usageID => $usageID } );
}

sub secret_lookup_by_uuid {
    my ($self, $uuid) = @_;
    return $self->_call(
        $remote->PROC_SECRET_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub set_identity {
    my ($self, $params, $flags) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_SET_IDENTITY,
        { params => $params, flags => $flags // 0 } );
}

sub storage_pool_create_xml {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_STORAGE_POOL_CREATE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub storage_pool_define_xml {
    my ($self, $xml, $flags) = @_;
    return $self->_call(
        $remote->PROC_STORAGE_POOL_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub storage_pool_lookup_by_name {
    my ($self, $name) = @_;
    return $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_NAME,
        { name => $name } );
}

sub storage_pool_lookup_by_target_path {
    my ($self, $path) = @_;
    return $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_TARGET_PATH,
        { path => $path } );
}

sub storage_pool_lookup_by_uuid {
    my ($self, $uuid) = @_;
    return $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub storage_vol_lookup_by_key {
    my ($self, $key) = @_;
    return $self->_call(
        $remote->PROC_STORAGE_VOL_LOOKUP_BY_KEY,
        { key => $key } );
}

sub storage_vol_lookup_by_path {
    my ($self, $path) = @_;
    return $self->_call(
        $remote->PROC_STORAGE_VOL_LOOKUP_BY_PATH,
        { path => $path } );
}

sub supports_feature {
    my ($self, $feature) = @_;
    return $self->_call(
        $remote->PROC_CONNECT_SUPPORTS_FEATURE,
        { feature => $feature } );
}


1;

__END__

=head1 NAME

Sys::Async::Virt - LibVirt protocol implementation for clients

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

  use Sys::Async::Virt;
  use Protocol::Sys::Virt::Remote;
  use Protocol::Sys::Virt::Transport;

  open my $fh, 'rw', '/run/libvirt/libvirt.sock';
  my $transport = Protocol::Sys::Virt::Transport->new(
       role => 'client',
       on_send => sub { syswrite( $fh, $_ ) for @_ }
  );

  my $remote = Protocol::Sys::Virt::Remote->new(
       role => 'client',
       on_reply => sub { say 'Reply handled!'; },
  );
  $remote->register( $transport );

  my $client = Sys::Async::Virt->new();
  $client->register( $remote );

  $client->auth( $remote->AUTH_NONE, sub {
      $client->open( 'qemu:///system', on_opened => sub { say "Opened!"; } );
  });

=head1 DESCRIPTION

This module manages access to a LibVirt service through its remote protocol.

The API documentation of this module and the related modules C<Sys::Async::Virt::*>
is meant to be used in conjunction with the documentation found at L<LibVirt's API
reference|https://libvirt.org/html/index.html>.  Since the C API is procedural
whereas the Perl API is object oriented; to look up a function from e.g.
C<Sys::Async::Virt::Domain>, translate the function to CamelCase and
add the prefix C<virDomain>.  The functions in this module may need to be prefixed
with either C<virConnect> or C<virNode>.  An important difference with the C API
is that this API only lists the C<INPUT> and C<INPUT|OUTPUT (as input)> arguments for its
functions.  The C<OUTPUT> and C<INPUT|OUTPUT (as output)> arguments will be returned in the
C<on_reply> event.


=head1 EVENTS

=head2 on_reply

  $on_reply->( @@@TODO );

=head2 on_message

  $on_message->( @@@TODO );

Receives all messages which either don't classify as a callback invocation
(i.e. the return value structure doesn't have a C<callbackID> member), or
for which no callback has been registered through L</register_callback>

=head2 on_stream

  $on_stream->( @@@TODO );

Receives all messages for which no stream has been registered through
L</register_stream>.

=head2 on_open

  $on_open->();

=head2 on_close

  $on_close->();

=head1 CONSTRUCTOR

=head2 new

  $client = Sys::Async::Virt->new( remote => $remote, ... );

Creates a new client instance.  The constructor supports the following arguments:

=over 8

=item * C<remote> (optional)

=item * C<keepalive> (optional)

=back

=head1 METHODS

=head2 register

  $client->register( $remote );

=head2 register_callback

  $client->register_callback( $callbackID, sub { say 'Called back!' });

=head2 register_stream

  $client->register_stream( $serial, $stream );

=head2 unregister_callback

  $client->unregister_callback( $callbackID );

=head2 unregister_stream

  $client->unregister_stream( $serial );

=head2 auth

  $client->auth( $auth_type, $on_completed );

Authenticates the client with the server.

=head2 open

  $serial = $client->open( $url, $flags = 0 );

This function opens the connection to the remote driver C<$url> as documented in
L<LibVirt's Connection URIs|https://libvirt.org/uri.html>.  Note that the value
is to be the B<local> hypervisor URI as applicable to the remote end of the
connection.

=head2 close

  $serial = $client->close;

Announces to the remote the intent to close the connection. The client will receive
a confirmation message from the server after which the server will close the connection.

=head2 baseline_cpu

  $serial = $client->baseline_cpu( $xmlCPUs, $flags = 0 );
  # -> { cpu => $cpu }

=head2 baseline_hypervisor_cpu

  $serial = $client->baseline_hypervisor_cpu( $emulator, $arch, $machine, $virttype, $xmlCPUs, $flags = 0 );
  # -> { cpu => $cpu }

=head2 compare_cpu

  $serial = $client->compare_cpu( $xml, $flags = 0 );
  # -> { result => $result }

=head2 compare_hypervisor_cpu

  $serial = $client->compare_hypervisor_cpu( $emulator, $arch, $machine, $virttype, $xmlCPU, $flags = 0 );
  # -> { result => $result }

=head2 domain_create_xml

  $serial = $client->domain_create_xml( $xml_desc, $flags = 0 );
  # -> { dom => $dom }

=head2 domain_define_xml

  $serial = $client->domain_define_xml( $xml );
  # -> { dom => $dom }

=head2 domain_define_xml_flags

  $serial = $client->domain_define_xml_flags( $xml, $flags = 0 );
  # -> { dom => $dom }

=head2 domain_lookup_by_id

  $serial = $client->domain_lookup_by_id( $id );
  # -> { dom => $dom }

=head2 domain_lookup_by_name

  $serial = $client->domain_lookup_by_name( $name );
  # -> { dom => $dom }

=head2 domain_lookup_by_uuid

  $serial = $client->domain_lookup_by_uuid( $uuid );
  # -> { dom => $dom }

=head2 domain_migrate_finish

  $serial = $client->domain_migrate_finish( $dname, $cookie, $uri, $flags = 0 );
  # -> { ddom => $ddom }

=head2 domain_migrate_finish2

  $serial = $client->domain_migrate_finish2( $dname, $cookie, $uri, $flags, $retcode );
  # -> { ddom => $ddom }

=head2 domain_migrate_prepare_tunnel

  $serial = $client->domain_migrate_prepare_tunnel( $flags, $dname, $resource, $dom_xml );
  # -> (* no data *)

=head2 domain_restore

  $serial = $client->domain_restore( $from );
  # -> (* no data *)

=head2 domain_restore_flags

  $serial = $client->domain_restore_flags( $from, $dxml, $flags = 0 );
  # -> (* no data *)

=head2 domain_restore_params

  $serial = $client->domain_restore_params( $params, $flags = 0 );
  # -> (* no data *)

=head2 domain_save_image_define_xml

  $serial = $client->domain_save_image_define_xml( $file, $dxml, $flags = 0 );
  # -> (* no data *)

=head2 domain_save_image_get_xml_desc

  $serial = $client->domain_save_image_get_xml_desc( $file, $flags = 0 );
  # -> { xml => $xml }

=head2 domain_xml_from_native

  $serial = $client->domain_xml_from_native( $nativeFormat, $nativeConfig, $flags = 0 );
  # -> { domainXml => $domainXml }

=head2 domain_xml_to_native

  $serial = $client->domain_xml_to_native( $nativeFormat, $domainXml, $flags = 0 );
  # -> { nativeConfig => $nativeConfig }

=head2 get_capabilities

  $serial = $client->get_capabilities;
  # -> { capabilities => $capabilities }

=head2 get_domain_capabilities

  $serial = $client->get_domain_capabilities( $emulatorbin, $arch, $machine, $virttype, $flags = 0 );
  # -> { capabilities => $capabilities }

=head2 get_hostname

  $serial = $client->get_hostname;
  # -> { hostname => $hostname }

=head2 get_lib_version

  $serial = $client->get_lib_version;
  # -> { lib_ver => $lib_ver }

=head2 get_max_vcpus

  $serial = $client->get_max_vcpus( $type );
  # -> { max_vcpus => $max_vcpus }

=head2 get_storage_pool_capabilities

  $serial = $client->get_storage_pool_capabilities( $flags = 0 );
  # -> { capabilities => $capabilities }

=head2 get_sysinfo

  $serial = $client->get_sysinfo( $flags = 0 );
  # -> { sysinfo => $sysinfo }

=head2 get_version

  $serial = $client->get_version;
  # -> { hv_ver => $hv_ver }

=head2 interface_change_begin

  $serial = $client->interface_change_begin( $flags = 0 );
  # -> (* no data *)

=head2 interface_change_commit

  $serial = $client->interface_change_commit( $flags = 0 );
  # -> (* no data *)

=head2 interface_change_rollback

  $serial = $client->interface_change_rollback( $flags = 0 );
  # -> (* no data *)

=head2 interface_define_xml

  $serial = $client->interface_define_xml( $xml, $flags = 0 );
  # -> { iface => $iface }

=head2 interface_lookup_by_mac_string

  $serial = $client->interface_lookup_by_mac_string( $mac );
  # -> { iface => $iface }

=head2 interface_lookup_by_name

  $serial = $client->interface_lookup_by_name( $name );
  # -> { iface => $iface }

=head2 list_all_domains

  $serial = $client->list_all_domains( $need_results, $flags = 0 );
  # -> { domains => $domains, ret => $ret }

=head2 list_all_interfaces

  $serial = $client->list_all_interfaces( $need_results, $flags = 0 );
  # -> { ifaces => $ifaces, ret => $ret }

=head2 list_all_networks

  $serial = $client->list_all_networks( $need_results, $flags = 0 );
  # -> { nets => $nets, ret => $ret }

=head2 list_all_node_devices

  $serial = $client->list_all_node_devices( $need_results, $flags = 0 );
  # -> { devices => $devices, ret => $ret }

=head2 list_all_nwfilter_bindings

  $serial = $client->list_all_nwfilter_bindings( $need_results, $flags = 0 );
  # -> { bindings => $bindings, ret => $ret }

=head2 list_all_nwfilters

  $serial = $client->list_all_nwfilters( $need_results, $flags = 0 );
  # -> { filters => $filters, ret => $ret }

=head2 list_all_secrets

  $serial = $client->list_all_secrets( $need_results, $flags = 0 );
  # -> { ret => $ret, secrets => $secrets }

=head2 list_all_storage_pools

  $serial = $client->list_all_storage_pools( $need_results, $flags = 0 );
  # -> { pools => $pools, ret => $ret }

=head2 list_defined_domains

  $serial = $client->list_defined_domains( $maxnames );
  # -> { names => $names }

=head2 list_defined_interfaces

  $serial = $client->list_defined_interfaces( $maxnames );
  # -> { names => $names }

=head2 list_defined_networks

  $serial = $client->list_defined_networks( $maxnames );
  # -> { names => $names }

=head2 list_defined_storage_pools

  $serial = $client->list_defined_storage_pools( $maxnames );
  # -> { names => $names }

=head2 list_interfaces

  $serial = $client->list_interfaces( $maxnames );
  # -> { names => $names }

=head2 list_networks

  $serial = $client->list_networks( $maxnames );
  # -> { names => $names }

=head2 list_nwfilters

  $serial = $client->list_nwfilters( $maxnames );
  # -> { names => $names }

=head2 list_secrets

  $serial = $client->list_secrets( $maxuuids );
  # -> { uuids => $uuids }

=head2 list_storage_pools

  $serial = $client->list_storage_pools( $maxnames );
  # -> { names => $names }

=head2 network_create_xml

  $serial = $client->network_create_xml( $xml );
  # -> { net => $net }

=head2 network_create_xml_flags

  $serial = $client->network_create_xml_flags( $xml, $flags = 0 );
  # -> { net => $net }

=head2 network_define_xml

  $serial = $client->network_define_xml( $xml );
  # -> { net => $net }

=head2 network_define_xml_flags

  $serial = $client->network_define_xml_flags( $xml, $flags = 0 );
  # -> { net => $net }

=head2 network_lookup_by_name

  $serial = $client->network_lookup_by_name( $name );
  # -> { net => $net }

=head2 network_lookup_by_uuid

  $serial = $client->network_lookup_by_uuid( $uuid );
  # -> { net => $net }

=head2 node_get_free_memory

  $serial = $client->node_get_free_memory;
  # -> { freeMem => $freeMem }

=head2 node_get_info

  $serial = $client->node_get_info;
  # -> { cores => $cores, cpus => $cpus, memory => $memory, mhz => $mhz, model => $model, nodes => $nodes, sockets => $sockets, threads => $threads }

=head2 node_list_devices

  $serial = $client->node_list_devices( $cap, $maxnames, $flags = 0 );
  # -> { names => $names }

=head2 node_num_of_devices

  $serial = $client->node_num_of_devices( $cap, $flags = 0 );
  # -> { num => $num }

=head2 node_set_memory_parameters

  $serial = $client->node_set_memory_parameters( $params, $flags = 0 );
  # -> (* no data *)

=head2 node_suspend_for_duration

  $serial = $client->node_suspend_for_duration( $target, $duration, $flags = 0 );
  # -> (* no data *)

=head2 num_of_defined_domains

  $serial = $client->num_of_defined_domains;
  # -> { num => $num }

=head2 num_of_defined_interfaces

  $serial = $client->num_of_defined_interfaces;
  # -> { num => $num }

=head2 num_of_defined_networks

  $serial = $client->num_of_defined_networks;
  # -> { num => $num }

=head2 num_of_defined_storage_pools

  $serial = $client->num_of_defined_storage_pools;
  # -> { num => $num }

=head2 num_of_domains

  $serial = $client->num_of_domains;
  # -> { num => $num }

=head2 num_of_interfaces

  $serial = $client->num_of_interfaces;
  # -> { num => $num }

=head2 num_of_networks

  $serial = $client->num_of_networks;
  # -> { num => $num }

=head2 num_of_nwfilters

  $serial = $client->num_of_nwfilters;
  # -> { num => $num }

=head2 num_of_secrets

  $serial = $client->num_of_secrets;
  # -> { num => $num }

=head2 num_of_storage_pools

  $serial = $client->num_of_storage_pools;
  # -> { num => $num }

=head2 nwfilter_binding_create_xml

  $serial = $client->nwfilter_binding_create_xml( $xml, $flags = 0 );
  # -> { nwfilter => $nwfilter }

=head2 nwfilter_binding_lookup_by_port_dev

  $serial = $client->nwfilter_binding_lookup_by_port_dev( $name );
  # -> { nwfilter => $nwfilter }

=head2 nwfilter_define_xml

  $serial = $client->nwfilter_define_xml( $xml );
  # -> { nwfilter => $nwfilter }

=head2 nwfilter_define_xml_flags

  $serial = $client->nwfilter_define_xml_flags( $xml, $flags = 0 );
  # -> { nwfilter => $nwfilter }

=head2 nwfilter_lookup_by_name

  $serial = $client->nwfilter_lookup_by_name( $name );
  # -> { nwfilter => $nwfilter }

=head2 nwfilter_lookup_by_uuid

  $serial = $client->nwfilter_lookup_by_uuid( $uuid );
  # -> { nwfilter => $nwfilter }

=head2 secret_define_xml

  $serial = $client->secret_define_xml( $xml, $flags = 0 );
  # -> { secret => $secret }

=head2 secret_lookup_by_usage

  $serial = $client->secret_lookup_by_usage( $usageType, $usageID );
  # -> { secret => $secret }

=head2 secret_lookup_by_uuid

  $serial = $client->secret_lookup_by_uuid( $uuid );
  # -> { secret => $secret }

=head2 set_identity

  $serial = $client->set_identity( $params, $flags = 0 );
  # -> (* no data *)

=head2 storage_pool_create_xml

  $serial = $client->storage_pool_create_xml( $xml, $flags = 0 );
  # -> { pool => $pool }

=head2 storage_pool_define_xml

  $serial = $client->storage_pool_define_xml( $xml, $flags = 0 );
  # -> { pool => $pool }

=head2 storage_pool_lookup_by_name

  $serial = $client->storage_pool_lookup_by_name( $name );
  # -> { pool => $pool }

=head2 storage_pool_lookup_by_target_path

  $serial = $client->storage_pool_lookup_by_target_path( $path );
  # -> { pool => $pool }

=head2 storage_pool_lookup_by_uuid

  $serial = $client->storage_pool_lookup_by_uuid( $uuid );
  # -> { pool => $pool }

=head2 storage_vol_lookup_by_key

  $serial = $client->storage_vol_lookup_by_key( $key );
  # -> { vol => $vol }

=head2 storage_vol_lookup_by_path

  $serial = $client->storage_vol_lookup_by_path( $path );
  # -> { vol => $vol }

=head2 supports_feature

  $serial = $client->supports_feature( $feature );
  # -> { supported => $supported }


=head1 CONSTANTS

=over 8

CLOSE_REASON_ERROR

=item CLOSE_REASON_EOF

=item CLOSE_REASON_KEEPALIVE

=item CLOSE_REASON_CLIENT

=item TYPED_PARAM_INT

=item TYPED_PARAM_UINT

=item TYPED_PARAM_LLONG

=item TYPED_PARAM_ULLONG

=item TYPED_PARAM_DOUBLE

=item TYPED_PARAM_BOOLEAN

=item TYPED_PARAM_STRING

=item TYPED_PARAM_STRING_OKAY

=item TYPED_PARAM_FIELD_LENGTH

=item DOMAIN_DEFINE_VALIDATE

=item LIST_DOMAINS_ACTIVE

=item LIST_DOMAINS_INACTIVE

=item LIST_DOMAINS_PERSISTENT

=item LIST_DOMAINS_TRANSIENT

=item LIST_DOMAINS_RUNNING

=item LIST_DOMAINS_PAUSED

=item LIST_DOMAINS_SHUTOFF

=item LIST_DOMAINS_OTHER

=item LIST_DOMAINS_MANAGEDSAVE

=item LIST_DOMAINS_NO_MANAGEDSAVE

=item LIST_DOMAINS_AUTOSTART

=item LIST_DOMAINS_NO_AUTOSTART

=item LIST_DOMAINS_HAS_SNAPSHOT

=item LIST_DOMAINS_NO_SNAPSHOT

=item LIST_DOMAINS_HAS_CHECKPOINT

=item LIST_DOMAINS_NO_CHECKPOINT

=item GET_ALL_DOMAINS_STATS_ACTIVE

=item GET_ALL_DOMAINS_STATS_INACTIVE

=item GET_ALL_DOMAINS_STATS_PERSISTENT

=item GET_ALL_DOMAINS_STATS_TRANSIENT

=item GET_ALL_DOMAINS_STATS_RUNNING

=item GET_ALL_DOMAINS_STATS_PAUSED

=item GET_ALL_DOMAINS_STATS_SHUTOFF

=item GET_ALL_DOMAINS_STATS_OTHER

=item GET_ALL_DOMAINS_STATS_NOWAIT

=item GET_ALL_DOMAINS_STATS_BACKING

=item GET_ALL_DOMAINS_STATS_ENFORCE_STATS

=item DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_CONNECTED

=item DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_DISCONNECTED

=item DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_UNKNOWN

=item DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_DOMAIN_STARTED

=item DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_CHANNEL

=item DOMAIN_EVENT_ID_LIFECYCLE

=item DOMAIN_EVENT_ID_REBOOT

=item DOMAIN_EVENT_ID_RTC_CHANGE

=item DOMAIN_EVENT_ID_WATCHDOG

=item DOMAIN_EVENT_ID_IO_ERROR

=item DOMAIN_EVENT_ID_GRAPHICS

=item DOMAIN_EVENT_ID_IO_ERROR_REASON

=item DOMAIN_EVENT_ID_CONTROL_ERROR

=item DOMAIN_EVENT_ID_BLOCK_JOB

=item DOMAIN_EVENT_ID_DISK_CHANGE

=item DOMAIN_EVENT_ID_TRAY_CHANGE

=item DOMAIN_EVENT_ID_PMWAKEUP

=item DOMAIN_EVENT_ID_PMSUSPEND

=item DOMAIN_EVENT_ID_BALLOON_CHANGE

=item DOMAIN_EVENT_ID_PMSUSPEND_DISK

=item DOMAIN_EVENT_ID_DEVICE_REMOVED

=item DOMAIN_EVENT_ID_BLOCK_JOB_2

=item DOMAIN_EVENT_ID_TUNABLE

=item DOMAIN_EVENT_ID_AGENT_LIFECYCLE

=item DOMAIN_EVENT_ID_DEVICE_ADDED

=item DOMAIN_EVENT_ID_MIGRATION_ITERATION

=item DOMAIN_EVENT_ID_JOB_COMPLETED

=item DOMAIN_EVENT_ID_DEVICE_REMOVAL_FAILED

=item DOMAIN_EVENT_ID_METADATA_CHANGE

=item DOMAIN_EVENT_ID_BLOCK_THRESHOLD

=item DOMAIN_EVENT_ID_MEMORY_FAILURE

=item DOMAIN_EVENT_ID_MEMORY_DEVICE_SIZE_CHANGE

=item SUSPEND_TARGET_MEM

=item SUSPEND_TARGET_DISK

=item SUSPEND_TARGET_HYBRID

=item SECURITY_LABEL_BUFLEN

=item SECURITY_MODEL_BUFLEN

=item SECURITY_DOI_BUFLEN

=item CPU_STATS_FIELD_LENGTH

=item CPU_STATS_ALL_CPUS

=item CPU_STATS_KERNEL

=item CPU_STATS_USER

=item CPU_STATS_IDLE

=item CPU_STATS_IOWAIT

=item CPU_STATS_INTR

=item CPU_STATS_UTILIZATION

=item MEMORY_STATS_FIELD_LENGTH

=item MEMORY_STATS_ALL_CELLS

=item MEMORY_STATS_TOTAL

=item MEMORY_STATS_FREE

=item MEMORY_STATS_BUFFERS

=item MEMORY_STATS_CACHED

=item MEMORY_SHARED_PAGES_TO_SCAN

=item MEMORY_SHARED_SLEEP_MILLISECS

=item MEMORY_SHARED_PAGES_SHARED

=item MEMORY_SHARED_PAGES_SHARING

=item MEMORY_SHARED_PAGES_UNSHARED

=item MEMORY_SHARED_PAGES_VOLATILE

=item MEMORY_SHARED_FULL_SCANS

=item MEMORY_SHARED_MERGE_ACROSS_NODES

=item SEV_PDH

=item SEV_CERT_CHAIN

=item SEV_CPU0_ID

=item SEV_CBITPOS

=item SEV_REDUCED_PHYS_BITS

=item SEV_MAX_GUESTS

=item SEV_MAX_ES_GUESTS

=item RO

=item NO_ALIASES

=item CRED_USERNAME

=item CRED_AUTHNAME

=item CRED_LANGUAGE

=item CRED_CNONCE

=item CRED_PASSPHRASE

=item CRED_ECHOPROMPT

=item CRED_NOECHOPROMPT

=item CRED_REALM

=item CRED_EXTERNAL

=item UUID_BUFLEN

=item UUID_STRING_BUFLEN

=item IDENTITY_USER_NAME

=item IDENTITY_UNIX_USER_ID

=item IDENTITY_GROUP_NAME

=item IDENTITY_UNIX_GROUP_ID

=item IDENTITY_PROCESS_ID

=item IDENTITY_PROCESS_TIME

=item IDENTITY_SASL_USER_NAME

=item IDENTITY_X509_DISTINGUISHED_NAME

=item IDENTITY_SELINUX_CONTEXT

=item CPU_COMPARE_ERROR

=item CPU_COMPARE_INCOMPATIBLE

=item CPU_COMPARE_IDENTICAL

=item CPU_COMPARE_SUPERSET

=item COMPARE_CPU_FAIL_INCOMPATIBLE

=item COMPARE_CPU_VALIDATE_XML

=item BASELINE_CPU_EXPAND_FEATURES

=item BASELINE_CPU_MIGRATABLE

=item ALLOC_PAGES_ADD

=item ALLOC_PAGES_SET

=item LIST_INTERFACES_INACTIVE

=item LIST_INTERFACES_ACTIVE

=item INTERFACE_DEFINE_VALIDATE

=item LIST_NETWORKS_INACTIVE

=item LIST_NETWORKS_ACTIVE

=item LIST_NETWORKS_PERSISTENT

=item LIST_NETWORKS_TRANSIENT

=item LIST_NETWORKS_AUTOSTART

=item LIST_NETWORKS_NO_AUTOSTART

=item NETWORK_CREATE_VALIDATE

=item NETWORK_DEFINE_VALIDATE

=item NETWORK_EVENT_ID_LIFECYCLE

=item NETWORK_EVENT_ID_METADATA_CHANGE

=item LIST_NODE_DEVICES_CAP_SYSTEM

=item LIST_NODE_DEVICES_CAP_PCI_DEV

=item LIST_NODE_DEVICES_CAP_USB_DEV

=item LIST_NODE_DEVICES_CAP_USB_INTERFACE

=item LIST_NODE_DEVICES_CAP_NET

=item LIST_NODE_DEVICES_CAP_SCSI_HOST

=item LIST_NODE_DEVICES_CAP_SCSI_TARGET

=item LIST_NODE_DEVICES_CAP_SCSI

=item LIST_NODE_DEVICES_CAP_STORAGE

=item LIST_NODE_DEVICES_CAP_FC_HOST

=item LIST_NODE_DEVICES_CAP_VPORTS

=item LIST_NODE_DEVICES_CAP_SCSI_GENERIC

=item LIST_NODE_DEVICES_CAP_DRM

=item LIST_NODE_DEVICES_CAP_MDEV_TYPES

=item LIST_NODE_DEVICES_CAP_MDEV

=item LIST_NODE_DEVICES_CAP_CCW_DEV

=item LIST_NODE_DEVICES_CAP_CSS_DEV

=item LIST_NODE_DEVICES_CAP_VDPA

=item LIST_NODE_DEVICES_CAP_AP_CARD

=item LIST_NODE_DEVICES_CAP_AP_QUEUE

=item LIST_NODE_DEVICES_CAP_AP_MATRIX

=item LIST_NODE_DEVICES_CAP_VPD

=item LIST_NODE_DEVICES_PERSISTENT

=item LIST_NODE_DEVICES_TRANSIENT

=item LIST_NODE_DEVICES_INACTIVE

=item LIST_NODE_DEVICES_ACTIVE

=item NODE_DEVICE_CREATE_XML_VALIDATE

=item NODE_DEVICE_DEFINE_XML_VALIDATE

=item NODE_DEVICE_EVENT_ID_LIFECYCLE

=item NODE_DEVICE_EVENT_ID_UPDATE

=item NWFILTER_DEFINE_VALIDATE

=item NWFILTER_BINDING_CREATE_VALIDATE

=item SECRET_USAGE_TYPE_NONE

=item SECRET_USAGE_TYPE_VOLUME

=item SECRET_USAGE_TYPE_CEPH

=item SECRET_USAGE_TYPE_ISCSI

=item SECRET_USAGE_TYPE_TLS

=item SECRET_USAGE_TYPE_VTPM

=item LIST_SECRETS_EPHEMERAL

=item LIST_SECRETS_NO_EPHEMERAL

=item LIST_SECRETS_PRIVATE

=item LIST_SECRETS_NO_PRIVATE

=item SECRET_DEFINE_VALIDATE

=item SECRET_EVENT_ID_LIFECYCLE

=item SECRET_EVENT_ID_VALUE_CHANGED

=item STORAGE_POOL_CREATE_NORMAL

=item STORAGE_POOL_CREATE_WITH_BUILD

=item STORAGE_POOL_CREATE_WITH_BUILD_OVERWRITE

=item STORAGE_POOL_CREATE_WITH_BUILD_NO_OVERWRITE

=item LIST_STORAGE_POOLS_INACTIVE

=item LIST_STORAGE_POOLS_ACTIVE

=item LIST_STORAGE_POOLS_PERSISTENT

=item LIST_STORAGE_POOLS_TRANSIENT

=item LIST_STORAGE_POOLS_AUTOSTART

=item LIST_STORAGE_POOLS_NO_AUTOSTART

=item LIST_STORAGE_POOLS_DIR

=item LIST_STORAGE_POOLS_FS

=item LIST_STORAGE_POOLS_NETFS

=item LIST_STORAGE_POOLS_LOGICAL

=item LIST_STORAGE_POOLS_DISK

=item LIST_STORAGE_POOLS_ISCSI

=item LIST_STORAGE_POOLS_SCSI

=item LIST_STORAGE_POOLS_MPATH

=item LIST_STORAGE_POOLS_RBD

=item LIST_STORAGE_POOLS_SHEEPDOG

=item LIST_STORAGE_POOLS_GLUSTER

=item LIST_STORAGE_POOLS_ZFS

=item LIST_STORAGE_POOLS_VSTORAGE

=item LIST_STORAGE_POOLS_ISCSI_DIRECT

=item STORAGE_POOL_DEFINE_VALIDATE

=item STORAGE_VOL_CREATE_PREALLOC_METADATA

=item STORAGE_VOL_CREATE_REFLINK

=item STORAGE_VOL_CREATE_VALIDATE

=item STORAGE_POOL_EVENT_ID_LIFECYCLE

=item STORAGE_POOL_EVENT_ID_REFRESH

=back

=head1 INTERNAL METHODS

=head2 _call

This method forwards protocol "calls" to the C<remote> instance.  Using this
wrapper allows for tracking all calls allowing to set up handling of the replies.

=head2 _dispatch_message

=head2 _dispatch_reply

=head2 _dispatch_stream

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT


