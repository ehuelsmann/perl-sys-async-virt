####################################################################
#
#     This file was generated using XDR::Parse version v0.3.1
#                   and LibVirt version v10.3.0
#
#      Don't edit this file, use the source template instead
#
#                 ANY CHANGES HERE WILL BE LOST !
#
####################################################################


use v5.20;
use warnings;
no warnings qw(void);
use experimental 'signatures';
use Feature::Compat::Try;
use Future::AsyncAwait;

package Sys::Async::Virt v10.3.0;

use parent qw(IO::Async::Notifier);

use Carp qw(croak);
use Future::Queue;
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

use Sys::Async::Virt::Callback v10.3.0;

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
    shift; # $client
    return @_;
}

sub _translate_remote_nonnull_domain {
    $_[0]->_domain_instance( $_[1] );
}

sub _translate_remote_nonnull_domain_checkpoint {
    $_[0]->_domain_checkpoint_instance( $_[1] );
}

sub _translate_remote_nonnull_domain_snapshot {
    $_[0]->_domain_snapshot_instance( $_[1] );
}

sub _translate_remote_nonnull_network {
    $_[0]->_network_instance( $_[1] );
}

sub _translate_remote_nonnull_network_port {
    $_[0]->_network_port_instance( $_[1] );
}

sub _translate_remote_nonnull_nwfilter {
    $_[0]->_network_nwfilter_instance( $_[1] );
}

sub _translate_remote_nonnull_nwfilter_binding {
    $_[0]->_network_nwfilter_binding_instance( $_[1] );
}

sub _translate_remote_nonnull_interface {
    $_[0]->_network_interface_instance( $_[1] );
}

sub _translate_remote_nonnull_storage_pool {
    $_[0]->storage_pool_instance( $_[1] );
}

sub _translate_remote_nonnull_storage_vol {
    $_[0]->_storage_vol_instance( $_[1] );
}

sub _translate_remote_nonnull_node_device {
    $_[0]->_node_device_instance( $_[1] );
}

sub _translate_remote_nonnull_secret {
    $_[0]->secret_instance( $_[1] );
}

my @reply_translators = (
    undef,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 4; my $client = shift; _translated($client, 'hv_ver', {  }, @_) },
    sub { 5; my $client = shift; _translated($client, 'max_vcpus', {  }, @_) },
    \&_no_translation,
    sub { 7; my $client = shift; _translated($client, 'capabilities', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 10; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 11; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 14; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 15; my $client = shift; _translated($client, 'autostart', {  }, @_) },
    \&_no_translation,
    sub { 17; my $client = shift; _translated($client, 'memory', {  }, @_) },
    sub { 18; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 19; my $client = shift; _translated($client, 'type', {  }, @_) },
    \&_no_translation,
    sub { 21; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 22; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 23; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 24; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 25; my $client = shift; _translated($client, 'num', {  }, @_) },
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
    sub { 36; my $client = shift; _translated($client, 'names', {  }, @_) },
    \&_no_translation,
    sub { 38; my $client = shift; _translated($client, 'names', {  }, @_) },
    \&_no_translation,
    sub { 40; my $client = shift; _translated($client, 'net', { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 41; my $client = shift; _translated($client, 'net', { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    sub { 43; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 44; my $client = shift; _translated($client, 'autostart', {  }, @_) },
    sub { 45; my $client = shift; _translated($client, 'name', {  }, @_) },
    sub { 46; my $client = shift; _translated($client, 'net', { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 47; my $client = shift; _translated($client, 'net', { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 50; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 51; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 52; my $client = shift; _translated($client, 'num', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 57; my $client = shift; _translated($client, 'params', {  }, @_) },
    \&_no_translation,
    sub { 59; my $client = shift; _translated($client, 'hostname', {  }, @_) },
    sub { 60; my $client = shift; _translated($client, 'supported', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 63; my $client = shift; _translated($client, 'ddom', { ddom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 71; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 72; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 73; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 74; my $client = shift; _translated($client, 'names', {  }, @_) },
    \&_no_translation,
    sub { 76; my $client = shift; _translated($client, 'pool', { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 77; my $client = shift; _translated($client, 'pool', { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 84; my $client = shift; _translated($client, 'pool', { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 85; my $client = shift; _translated($client, 'pool', { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 86; my $client = shift; _translated($client, 'pool', { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    sub { 88; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 89; my $client = shift; _translated($client, 'autostart', {  }, @_) },
    \&_no_translation,
    sub { 91; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 92; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 93; my $client = shift; _translated($client, 'vol', { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    \&_no_translation,
    sub { 95; my $client = shift; _translated($client, 'vol', { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 96; my $client = shift; _translated($client, 'vol', { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 97; my $client = shift; _translated($client, 'vol', { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    \&_no_translation,
    sub { 99; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 100; my $client = shift; _translated($client, 'name', {  }, @_) },
    \&_no_translation,
    sub { 102; my $client = shift; _translated($client, 'freeMem', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 107; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 109; my $client = shift; _translated($client, 'ddom', { ddom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 111; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 112; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 113; my $client = shift; _translated($client, 'dev', { dev => \&_translate_remote_nonnull_node_device }, @_) },
    sub { 114; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 115; my $client = shift; _translated($client, 'parentName', {  }, @_) },
    sub { 116; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 117; my $client = shift; _translated($client, 'names', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 123; my $client = shift; _translated($client, 'dev', { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { 125; my $client = shift; _translated($client, 'vol', { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 126; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 127; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 128; my $client = shift; _translated($client, 'iface', { iface => \&_translate_remote_nonnull_interface }, @_) },
    sub { 129; my $client = shift; _translated($client, 'iface', { iface => \&_translate_remote_nonnull_interface }, @_) },
    sub { 130; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 131; my $client = shift; _translated($client, 'iface', { iface => \&_translate_remote_nonnull_interface }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 135; my $client = shift; _translated($client, 'domainXml', {  }, @_) },
    sub { 136; my $client = shift; _translated($client, 'nativeConfig', {  }, @_) },
    sub { 137; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 138; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 139; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 140; my $client = shift; _translated($client, 'uuids', {  }, @_) },
    sub { 141; my $client = shift; _translated($client, 'secret', { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { 142; my $client = shift; _translated($client, 'secret', { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { 143; my $client = shift; _translated($client, 'xml', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 147; my $client = shift; _translated($client, 'secret', { secret => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 150; my $client = shift; _translated($client, 'active', {  }, @_) },
    sub { 151; my $client = shift; _translated($client, 'persistent', {  }, @_) },
    sub { 152; my $client = shift; _translated($client, 'active', {  }, @_) },
    sub { 153; my $client = shift; _translated($client, 'persistent', {  }, @_) },
    sub { 154; my $client = shift; _translated($client, 'active', {  }, @_) },
    sub { 155; my $client = shift; _translated($client, 'persistent', {  }, @_) },
    sub { 156; my $client = shift; _translated($client, 'active', {  }, @_) },
    sub { 157; my $client = shift; _translated($client, 'lib_ver', {  }, @_) },
    sub { 158; my $client = shift; _translated($client, 'result', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 162; my $client = shift; _translated($client, 'cpu', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 169; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 170; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 171; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 172; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 173; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 175; my $client = shift; _translated($client, 'nwfilter', { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 176; my $client = shift; _translated($client, 'nwfilter', { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 177; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 178; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 179; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 180; my $client = shift; _translated($client, 'nwfilter', { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 183; my $client = shift; _translated($client, 'result', {  }, @_) },
    \&_no_translation,
    sub { 185; my $client = shift; _translated($client, 'snap', { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 186; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 187; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 188; my $client = shift; _translated($client, 'names', {  }, @_) },
    sub { 189; my $client = shift; _translated($client, 'snap', { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 190; my $client = shift; _translated($client, 'result', {  }, @_) },
    sub { 191; my $client = shift; _translated($client, 'snap', { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 195; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 196; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 200; my $client = shift; _translated($client, 'num', {  }, @_) },
    \&_no_translation,
    sub { 202; my $client = shift; _translated($client, 'updated', {  }, @_) },
    sub { 203; my $client = shift; _translated($client, 'sysinfo', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 211; my $client = shift; _translated($client, 'mime', {  }, @_) },
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
    sub { 223; my $client = shift; _translated($client, 'params', {  }, @_) },
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
    sub { 235; my $client = shift; _translated($client, 'xml', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    undef,
    sub { 242; my $client = shift; _translated($client, 'bandwidth', {  }, @_) },
    \&_no_translation,
    sub { 244; my $client = shift; _translated($client, 'snap', { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    sub { 246; my $client = shift; _translated($client, 'num', {  }, @_) },
    sub { 247; my $client = shift; _translated($client, 'names', {  }, @_) },
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
    sub { 265; my $client = shift; _translated($client, 'metadata', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 268; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 269; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 270; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 271; my $client = shift; _translated($client, 'current', {  }, @_) },
    sub { 272; my $client = shift; _translated($client, 'metadata', {  }, @_) },
    sub { 273; my $client = shift; _translated($client, 'domains', { domains => \&_translate_remote_nonnull_domain }, @_) },
    sub { 274; my $client = shift; _translated($client, 'snapshots', { snapshots => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 275; my $client = shift; _translated($client, 'snapshots', { snapshots => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 276; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 277; my $client = shift; _translated($client, 'hostname', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 281; my $client = shift; _translated($client, 'pools', { pools => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 282; my $client = shift; _translated($client, 'vols', { vols => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 283; my $client = shift; _translated($client, 'nets', { nets => \&_translate_remote_nonnull_network }, @_) },
    sub { 284; my $client = shift; _translated($client, 'ifaces', { ifaces => \&_translate_remote_nonnull_interface }, @_) },
    sub { 285; my $client = shift; _translated($client, 'devices', { devices => \&_translate_remote_nonnull_node_device }, @_) },
    sub { 286; my $client = shift; _translated($client, 'filters', { filters => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 287; my $client = shift; _translated($client, 'secrets', { secrets => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 292; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 297; my $client = shift; _translated($client, 'dev', { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { 299; my $client = shift; _translated($client, 'cacheSize', {  }, @_) },
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
    sub { 311; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 315; my $client = shift; _translated($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 318; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 319; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 320; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 321; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 322; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 323; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 324; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 325; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 326; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 327; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 328; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 329; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 330; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 331; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 332; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 333; my $client = shift; _translated($client, undef, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    \&_no_translation,
    sub { 335; my $client = shift; _translated($client, 'filesystems', {  }, @_) },
    sub { 336; my $client = shift; _translated($client, 'filesystems', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    undef,
    \&_no_translation,
    \&_no_translation,
    sub { 342; my $client = shift; _translated($client, 'capabilities', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 346; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 348; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 350; my $client = shift; _translated($client, 'dom', { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 354; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 359; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    undef,
    sub { 363; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 367; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 370; my $client = shift; _translated($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 371; my $client = shift; _translated($client, 'params', {  }, @_) },
    \&_no_translation,
    sub { 373; my $client = shift; _translated($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 376; my $client = shift; _translated($client, undef, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    sub { 377; my $client = shift; _translated($client, undef, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { 379; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 382; my $client = shift; _translated($client, undef, { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { 383; my $client = shift; _translated($client, undef, { secret => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    sub { 385; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 387; my $client = shift; _translated($client, 'downtime', {  }, @_) },
    sub { 388; my $client = shift; _translated($client, 'xml', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 391; my $client = shift; _translated($client, 'pool', { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    sub { 393; my $client = shift; _translated($client, 'result', {  }, @_) },
    sub { 394; my $client = shift; _translated($client, 'cpu', {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 397; my $client = shift; _translated($client, 'nwfilter', { nwfilter => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    sub { 398; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 399; my $client = shift; _translated($client, 'nwfilter', { nwfilter => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    \&_no_translation,
    sub { 401; my $client = shift; _translated($client, 'bindings', { bindings => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    \&_no_translation,
    sub { 403; my $client = shift; _translated($client, 'capabilities', {  }, @_) },
    sub { 404; my $client = shift; _translated($client, 'ports', { ports => \&_translate_remote_nonnull_network_port }, @_) },
    sub { 405; my $client = shift; _translated($client, 'port', { port => \&_translate_remote_nonnull_network_port }, @_) },
    sub { 406; my $client = shift; _translated($client, 'port', { port => \&_translate_remote_nonnull_network_port }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 409; my $client = shift; _translated($client, 'xml', {  }, @_) },
    \&_no_translation,
    sub { 411; my $client = shift; _translated($client, 'checkpoint', { checkpoint => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 412; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 413; my $client = shift; _translated($client, 'checkpoints', { checkpoints => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 414; my $client = shift; _translated($client, 'checkpoints', { checkpoints => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 415; my $client = shift; _translated($client, 'checkpoint', { checkpoint => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 416; my $client = shift; _translated($client, 'parent', { parent => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 420; my $client = shift; _translated($client, 'result', {  }, @_) },
    \&_no_translation,
    sub { 422; my $client = shift; _translated($client, 'xml', {  }, @_) },
    sub { 423; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 428; my $client = shift; _translated($client, 'dev', { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 431; my $client = shift; _translated($client, 'nwfilter', { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 432; my $client = shift; _translated($client, 'net', { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 433; my $client = shift; _translated($client, 'autostart', {  }, @_) },
    \&_no_translation,
    sub { 435; my $client = shift; _translated($client, 'persistent', {  }, @_) },
    sub { 436; my $client = shift; _translated($client, 'active', {  }, @_) },
    sub { 437; my $client = shift; _translated($client, 'net', { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 438; my $client = shift; _translated($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 445; my $client = shift; _translated($client, 'metadata', {  }, @_) },
    sub { 446; my $client = shift; _translated($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation
);


sub _map( $client, $unwrap, $argmap, $data) {
    for my $key (keys %{ $argmap }) {
        my $val = $data->{$key};

        if (ref $argmap->{$key} and reftype $argmap->{$key} eq 'HASH') {
            use Data::Dumper;
            $data->{$key} = _map( $client, undef, $argmap->{$key}, $val );
        }
        elsif (ref $val and reftype $val eq 'ARRAY') {
            $data->{$key} = [ map { $argmap->{$key}->( $client, $_ ) } @{ $val } ];
        }
        else {
            $data->{$key} = $argmap->{$key}->( $client, $val );
        }
    }

    return $data;
}

sub _translated($client, $unwrap, $argmap, %args) {
    return (%args, ) unless $args{data};
    my $data = $args{data};
    $args{data} = _map($client, $unwrap, $argmap, $data);
    if ($unwrap) {
        $args{data} = $args{data}->{$unwrap};
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

sub _domain_instance {
    my ($self, $id) = @_;
    my $c = $self->{_domains}->{$id->{uuid}}
       //= $self->{domain_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_domains}->{$id->{uuid}};
    return $c;
}

sub _domain_checkpoint_instance {
    my ($self, $id) = @_;
    my $key = "$id->{dom}->{uuid}/$id->{name}";
    my $c = $self->{_domain_checkpoints}->{$key}
       //= $self->{domain_checkpoint_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_domain_checkpoints}->{$key};
    return $c;
}

sub _domain_snapshot_instance {
    my ($self, $id) = @_;
    my $key = "$id->{dom}->{uuid}/$id->{name}";
    my $c = $self->{_domain_snapshots}->{$id->{uuid}}
       //= $self->{domain_snapshot_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_domain_snapshots}->{$id->{uuid}};
    return $c;
}

sub _network_instance {
    my ($self, $id) = @_;
    my $c = $self->{_networks}->{$id->{uuid}}
       //= $self->{network_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_networks}->{$id->{uuid}};
    return $c;
}

sub _network_port_instance {
    my ($self, $id) = @_;
    my $c = $self->{_network_ports}->{$id->{uuid}}
       //= $self->{network_port_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_network_ports}->{$id->{uuid}};
    return $c;
}

sub _nwfilter_instance {
    my ($self, $id) = @_;
    my $c = $self->{_nwfilters}->{$id->{uuid}}
       //= $self->{nwfilter_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_nwfilters}->{$id->{uuid}};
    return $c;
}

sub _nwfilter_binding_instance {
    my ($self, $id) = @_;
    my $key = "$id->{portdev}/$id->{filtername}";
    my $c = $self->{_nwfilter_bindings}->{$key}
       //= $self->{nwfilter_binding_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_nwfilter_bindings}->{$key};
    return $c;
}

sub _interface_instance {
    my ($self, $id) = @_;
    my $key = "$id->{mac}/$id->{name}";
    my $c = $self->{_interfaces}->{$key}
       //= $self->{interface_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_interfaces}->{$key};
    return $c;
}

sub _storage_pool_instance {
    my ($self, $id) = @_;
    my $c = $self->{_storage_pools}->{$id->{uuid}}
       //= $self->{storage_pool_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_storage_pools}->{$id->{uuid}};
    return $c;
}

sub _storage_vol_instance {
    my ($self, $id) = @_;
    my $c = $self->{_storage_vols}->{$id->{key}}
       //= $self->{storage_vol_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_storage_vols}->{$id->{key}};
    return $c;
}

sub _node_device_instance {
    my ($self, $id) = @_;
    my $c = $self->{_node_devices}->{$id->{name}}
       //= $self->{node_device_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_node_devices}->{$id->{name}};
    return $c;
}

sub _secret_instance {
    my ($self, $id) = @_;
    my $c = $self->{_secrets}->{$id->{uuid}}
       //= $self->{secret_factory}->( client => $self, remote => $self->{remote}, id => $id );
    weaken $self->{_secrets}->{$id->{uuid}};
    return $c;
}

async sub _call($self, $proc, $args = {}) {
    my $serial = await $self->{remote}->call( $proc, $args );
    my $f = $self->loop->new_future;
    $log->trace( "Setting serial $serial future" );
    $self->{_replies}->{$serial} = $f;
    ### Return a stream somehow...
    return await $f;
}

async sub _typed_param_string_okay($self) {
    return $self->{_typed_param_string_okay} //=
        ((await $self->supports_feature(
              $self->{remote}->DRV_FEATURE_TYPED_PARAM_STRING ))
         ? $self->TYPED_PARAM_STRING_OKAY : 0);
}

async sub _filter_typed_param_string($self, $params) {
    return await $self->_typed_param_string_okay
        ? $params
        : [ grep {
               $params->{value}->{type} != $remote->VIR_TYPED_PARAM_STRING
            } @$params ];
}

sub _dispatch_closed {
    my $self = shift;

    $self->{on_closed}->( @_ );
}

sub _dispatch_message($self, %args) {
    if ($args{data}
        and defined $args{data}->{callbackID}
        and my $cb = $self->{_callbacks}->{$args{data}->{callbackID}}) {

        my %cbargs =
            $reply_translators[$args{header}->{proc}]->( $self, %args );
        $cb->_dispatch_event($cbargs{data});
    }
    else {
        my %cbargs =
            $reply_translators[$args{header}->{proc}]->( $self, %args );
        $self->{on_message}->( $cbargs{data} );
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

async sub domain_event_register_any($self, $eventID, $domain = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_DOMAIN_EVENT_CALLBACK_REGISTER_ANY,
        { eventID => $eventID, dom => $domain });
    my $dereg = $remote->PROC_CONNECT_DOMAIN_EVENT_CALLBACK_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $self->{_callbacks}->{$rv->{callbackID}} = $cb;

    return $cb;
}

async sub network_event_register_any($self, $eventID, $network = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_NETWORK_EVENT_REGISTER_ANY,
        { eventID => $eventID, net => $network });
    my $dereg = $remote->PROC_CONNECT_NETWORK_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $self->{_callbacks}->{$rv->{callbackID}} = $cb;

    return $cb;
}

async sub storage_pool_event_register_any($self, $eventID, $pool = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_STORAGE_POOL_EVENT_REGISTER_ANY,
        { eventID => $eventID, pool => $pool });
    my $dereg = $remote->PROC_CONNECT_STORAGE_POOL_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $self->{_callbacks}->{$rv->{callbackID}} = $cb;

    return $cb;
}

async sub node_device_event_register_any($self, $eventID, $dev = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_NODE_DEVICE_EVENT_REGISTER_ANY,
        { eventID => $eventID, dev => $dev });
    my $dereg = $remote->PROC_CONNECT_NODE_DEVICE_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $self->{_callbacks}->{$rv->{callbackID}} = $cb;

    return $cb;
}

async sub secret_event_register_any($self, $eventID, $secret = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_SECRET_EVENT_REGISTER_ANY,
        { eventID => $eventID, secret => $secret });
    my $dereg = $remote->PROC_CONNECT_SECRET_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $self->{_callbacks}->{$rv->{callbackID}} = $cb;

    return $cb;
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


async sub open {
    my ($self, $url, $flags) = @_;
    await $self->_call( $remote->PROC_CONNECT_OPEN,
                        { name => $url, flags => $flags // 0 } );
    if (await $self->supports_feature(
            $self->{remote}->DRV_FEATURE_REMOTE_CLOSE_CALLBACK )) {
        await $self->_call( $remote->PROC_CONNECT_REGISTER_CLOSE_CALLBACK );
    }
    if (not await $self->supports_feature(
            $self->{remote}->DRV_FEATURE_REMOTE_EVENT_CALLBACK )) {
        die "Remote not supported: REMOTE_EVENT_CALLBACK feature not available";
    }
}

sub close {
    my ($self) = @_;
    $self->_call( $remote->PROC_CONNECT_CLOSE, {} );
}


sub baseline_cpu($self, $xmlCPUs, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_BASELINE_CPU,
        { xmlCPUs => $xmlCPUs, flags => $flags // 0 } );
}

sub baseline_hypervisor_cpu($self, $emulator, $arch, $machine, $virttype, $xmlCPUs, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_BASELINE_HYPERVISOR_CPU,
        { emulator => $emulator, arch => $arch, machine => $machine, virttype => $virttype, xmlCPUs => $xmlCPUs, flags => $flags // 0 } );
}

sub compare_cpu($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_COMPARE_CPU,
        { xml => $xml, flags => $flags // 0 } );
}

sub compare_hypervisor_cpu($self, $emulator, $arch, $machine, $virttype, $xmlCPU, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_COMPARE_HYPERVISOR_CPU,
        { emulator => $emulator, arch => $arch, machine => $machine, virttype => $virttype, xmlCPU => $xmlCPU, flags => $flags // 0 } );
}

sub domain_create_xml($self, $xml_desc, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_CREATE_XML,
        { xml_desc => $xml_desc, flags => $flags // 0 } );
}

sub domain_define_xml($self, $xml) {
    return $self->_call(
        $remote->PROC_DOMAIN_DEFINE_XML,
        { xml => $xml } );
}

sub domain_define_xml_flags($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub domain_lookup_by_id($self, $id) {
    return $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_ID,
        { id => $id } );
}

sub domain_lookup_by_name($self, $name) {
    return $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_NAME,
        { name => $name } );
}

sub domain_lookup_by_uuid($self, $uuid) {
    return $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub domain_migrate_finish($self, $dname, $cookie, $uri, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_FINISH,
        { dname => $dname, cookie => $cookie, uri => $uri, flags => $flags // 0 } );
}

sub domain_migrate_finish2($self, $dname, $cookie, $uri, $flags, $retcode) {
    return $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_FINISH2,
        { dname => $dname, cookie => $cookie, uri => $uri, flags => $flags // 0, retcode => $retcode } );
}

sub domain_migrate_prepare_tunnel($self, $flags, $dname, $resource, $dom_xml) {
    return $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_PREPARE_TUNNEL,
        { flags => $flags // 0, dname => $dname, resource => $resource, dom_xml => $dom_xml } );
}

sub domain_restore($self, $from) {
    return $self->_call(
        $remote->PROC_DOMAIN_RESTORE,
        { from => $from } );
}

sub domain_restore_flags($self, $from, $dxml, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_RESTORE_FLAGS,
        { from => $from, dxml => $dxml, flags => $flags // 0 } );
}

async sub domain_restore_params($self, $params, $flags = 0) {
    $params = await $self->_filter_typed_param_string( $params );
    return await $self->_call(
        $remote->PROC_DOMAIN_RESTORE_PARAMS,
        { params => $params, flags => $flags // 0 } );
}

sub domain_save_image_define_xml($self, $file, $dxml, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_SAVE_IMAGE_DEFINE_XML,
        { file => $file, dxml => $dxml, flags => $flags // 0 } );
}

sub domain_save_image_get_xml_desc($self, $file, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_SAVE_IMAGE_GET_XML_DESC,
        { file => $file, flags => $flags // 0 } );
}

sub domain_xml_from_native($self, $nativeFormat, $nativeConfig, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_DOMAIN_XML_FROM_NATIVE,
        { nativeFormat => $nativeFormat, nativeConfig => $nativeConfig, flags => $flags // 0 } );
}

sub domain_xml_to_native($self, $nativeFormat, $domainXml, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_DOMAIN_XML_TO_NATIVE,
        { nativeFormat => $nativeFormat, domainXml => $domainXml, flags => $flags // 0 } );
}

sub get_capabilities($self) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_CAPABILITIES,
        {  } );
}

sub get_domain_capabilities($self, $emulatorbin, $arch, $machine, $virttype, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_DOMAIN_CAPABILITIES,
        { emulatorbin => $emulatorbin, arch => $arch, machine => $machine, virttype => $virttype, flags => $flags // 0 } );
}

sub get_hostname($self) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_HOSTNAME,
        {  } );
}

sub get_lib_version($self) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_LIB_VERSION,
        {  } );
}

sub get_max_vcpus($self, $type) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_MAX_VCPUS,
        { type => $type } );
}

sub get_storage_pool_capabilities($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_STORAGE_POOL_CAPABILITIES,
        { flags => $flags // 0 } );
}

sub get_sysinfo($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_SYSINFO,
        { flags => $flags // 0 } );
}

sub get_version($self) {
    return $self->_call(
        $remote->PROC_CONNECT_GET_VERSION,
        {  } );
}

sub interface_change_begin($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_BEGIN,
        { flags => $flags // 0 } );
}

sub interface_change_commit($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_COMMIT,
        { flags => $flags // 0 } );
}

sub interface_change_rollback($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_ROLLBACK,
        { flags => $flags // 0 } );
}

sub interface_define_xml($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_INTERFACE_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub interface_lookup_by_mac_string($self, $mac) {
    return $self->_call(
        $remote->PROC_INTERFACE_LOOKUP_BY_MAC_STRING,
        { mac => $mac } );
}

sub interface_lookup_by_name($self, $name) {
    return $self->_call(
        $remote->PROC_INTERFACE_LOOKUP_BY_NAME,
        { name => $name } );
}

sub list_all_domains($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_DOMAINS,
        { need_results => $remote->DOMAIN_LIST_MAX, flags => $flags // 0 } );
}

sub list_all_interfaces($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_INTERFACES,
        { need_results => $remote->INTERFACE_LIST_MAX, flags => $flags // 0 } );
}

sub list_all_networks($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NETWORKS,
        { need_results => $remote->NETWORK_LIST_MAX, flags => $flags // 0 } );
}

sub list_all_node_devices($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NODE_DEVICES,
        { need_results => $remote->NODE_DEVICE_LIST_MAX, flags => $flags // 0 } );
}

sub list_all_nwfilter_bindings($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NWFILTER_BINDINGS,
        { need_results => $remote->NWFILTER_BINGING_LIST_MAX, flags => $flags // 0 } );
}

sub list_all_nwfilters($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NWFILTERS,
        { need_results => $remote->NWFILTER_LIST_MAX, flags => $flags // 0 } );
}

sub list_all_secrets($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_SECRETS,
        { need_results => $remote->SECRET_LIST_MAX, flags => $flags // 0 } );
}

sub list_all_storage_pools($self, $flags = 0) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_STORAGE_POOLS,
        { need_results => $remote->STORAGE_POOL_LIST_MAX, flags => $flags // 0 } );
}

sub list_defined_domains($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_DOMAINS,
        { maxnames => $remote->DOMAIN_LIST_MAX } );
}

sub list_defined_interfaces($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_INTERFACES,
        { maxnames => $remote->INTERFACE_LIST_MAX } );
}

sub list_defined_networks($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_NETWORKS,
        { maxnames => $remote->NETWORK_LIST_MAX } );
}

sub list_defined_storage_pools($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_STORAGE_POOLS,
        { maxnames => $remote->STORAGE_POOL_LIST_MAX } );
}

sub list_interfaces($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_INTERFACES,
        { maxnames => $remote->INTERFACE_LIST_MAX } );
}

sub list_networks($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_NETWORKS,
        { maxnames => $remote->NETWORK_LIST_MAX } );
}

sub list_nwfilters($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_NWFILTERS,
        { maxnames => $remote->NWFILTER_LIST_MAX } );
}

sub list_secrets($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_SECRETS,
        { maxuuids => $remote->SECRET_LIST_MAX } );
}

sub list_storage_pools($self) {
    return $self->_call(
        $remote->PROC_CONNECT_LIST_STORAGE_POOLS,
        { maxnames => $remote->STORAGE_POOL_LIST_MAX } );
}

sub network_create_xml($self, $xml) {
    return $self->_call(
        $remote->PROC_NETWORK_CREATE_XML,
        { xml => $xml } );
}

sub network_create_xml_flags($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_NETWORK_CREATE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub network_define_xml($self, $xml) {
    return $self->_call(
        $remote->PROC_NETWORK_DEFINE_XML,
        { xml => $xml } );
}

sub network_define_xml_flags($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_NETWORK_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub network_lookup_by_name($self, $name) {
    return $self->_call(
        $remote->PROC_NETWORK_LOOKUP_BY_NAME,
        { name => $name } );
}

sub network_lookup_by_uuid($self, $uuid) {
    return $self->_call(
        $remote->PROC_NETWORK_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub node_get_free_memory($self) {
    return $self->_call(
        $remote->PROC_NODE_GET_FREE_MEMORY,
        {  } );
}

sub node_get_info($self) {
    return $self->_call(
        $remote->PROC_NODE_GET_INFO,
        {  } );
}

sub node_list_devices($self, $cap, $flags = 0) {
    return $self->_call(
        $remote->PROC_NODE_LIST_DEVICES,
        { cap => $cap, maxnames => $remote->NODE_DEVICE_LIST_MAX, flags => $flags // 0 } );
}

sub node_num_of_devices($self, $cap, $flags = 0) {
    return $self->_call(
        $remote->PROC_NODE_NUM_OF_DEVICES,
        { cap => $cap, flags => $flags // 0 } );
}

async sub node_set_memory_parameters($self, $params, $flags = 0) {
    $params = await $self->_filter_typed_param_string( $params );
    return await $self->_call(
        $remote->PROC_NODE_SET_MEMORY_PARAMETERS,
        { params => $params, flags => $flags // 0 } );
}

sub node_suspend_for_duration($self, $target, $duration, $flags = 0) {
    return $self->_call(
        $remote->PROC_NODE_SUSPEND_FOR_DURATION,
        { target => $target, duration => $duration, flags => $flags // 0 } );
}

sub num_of_defined_domains($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_DOMAINS,
        {  } );
}

sub num_of_defined_interfaces($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_INTERFACES,
        {  } );
}

sub num_of_defined_networks($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_NETWORKS,
        {  } );
}

sub num_of_defined_storage_pools($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_STORAGE_POOLS,
        {  } );
}

sub num_of_domains($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DOMAINS,
        {  } );
}

sub num_of_interfaces($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_INTERFACES,
        {  } );
}

sub num_of_networks($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_NETWORKS,
        {  } );
}

sub num_of_nwfilters($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_NWFILTERS,
        {  } );
}

sub num_of_secrets($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_SECRETS,
        {  } );
}

sub num_of_storage_pools($self) {
    return $self->_call(
        $remote->PROC_CONNECT_NUM_OF_STORAGE_POOLS,
        {  } );
}

sub nwfilter_binding_create_xml($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_NWFILTER_BINDING_CREATE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub nwfilter_binding_lookup_by_port_dev($self, $name) {
    return $self->_call(
        $remote->PROC_NWFILTER_BINDING_LOOKUP_BY_PORT_DEV,
        { name => $name } );
}

sub nwfilter_define_xml($self, $xml) {
    return $self->_call(
        $remote->PROC_NWFILTER_DEFINE_XML,
        { xml => $xml } );
}

sub nwfilter_define_xml_flags($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_NWFILTER_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 } );
}

sub nwfilter_lookup_by_name($self, $name) {
    return $self->_call(
        $remote->PROC_NWFILTER_LOOKUP_BY_NAME,
        { name => $name } );
}

sub nwfilter_lookup_by_uuid($self, $uuid) {
    return $self->_call(
        $remote->PROC_NWFILTER_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub secret_define_xml($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_SECRET_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub secret_lookup_by_usage($self, $usageType, $usageID) {
    return $self->_call(
        $remote->PROC_SECRET_LOOKUP_BY_USAGE,
        { usageType => $usageType, usageID => $usageID } );
}

sub secret_lookup_by_uuid($self, $uuid) {
    return $self->_call(
        $remote->PROC_SECRET_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

async sub set_identity($self, $params, $flags = 0) {
    $params = await $self->_filter_typed_param_string( $params );
    return await $self->_call(
        $remote->PROC_CONNECT_SET_IDENTITY,
        { params => $params, flags => $flags // 0 } );
}

sub storage_pool_create_xml($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_STORAGE_POOL_CREATE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub storage_pool_define_xml($self, $xml, $flags = 0) {
    return $self->_call(
        $remote->PROC_STORAGE_POOL_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 } );
}

sub storage_pool_lookup_by_name($self, $name) {
    return $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_NAME,
        { name => $name } );
}

sub storage_pool_lookup_by_target_path($self, $path) {
    return $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_TARGET_PATH,
        { path => $path } );
}

sub storage_pool_lookup_by_uuid($self, $uuid) {
    return $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_UUID,
        { uuid => $uuid } );
}

sub storage_vol_lookup_by_key($self, $key) {
    return $self->_call(
        $remote->PROC_STORAGE_VOL_LOOKUP_BY_KEY,
        { key => $key } );
}

sub storage_vol_lookup_by_path($self, $path) {
    return $self->_call(
        $remote->PROC_STORAGE_VOL_LOOKUP_BY_PATH,
        { path => $path } );
}

sub supports_feature($self, $feature) {
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


=head1 CLIENT EVENTS

=head2 on_reply

  $on_reply->( @@@TODO );

=head2 on_message

  $on_message->( @@@TODO );

Receives all messages which either don't classify as a callback invocation
(i.e. the return value structure doesn't have a C<callbackID> member), or
for which no callback has been registered through one of the callback
registration functions.

=head2 on_stream

  $on_stream->( @@@TODO );

Receives all messages for which no stream has been registered through
L</register_stream>.

=head2 on_open

  $on_open->();

=head2 on_close

  $on_close->();

=head1 LIBVIRT EVENTS

=head2 domain_event_register_any

=head2 network_event_register_any

=head2 node_device_event_register_any

=head2 secret_event_register_any

=head2 storage_pool_event_register_any

=head1 CONSTRUCTOR

=head2 new

  $client = Sys::Async::Virt->new( remote => $remote, ... );

Creates a new client instance.  The constructor supports the following arguments:

=over 8

=item * C<remote> (optional)

=item * C<keepalive> (optional)

=back

=head1 METHODS

=head2 configure

=head2 register

  $client->register( $remote );

=head2 register_stream

  $client->register_stream( $serial, $stream );

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

  $cpu = await $client->baseline_cpu( $xmlCPUs, $flags = 0 );

=head2 baseline_hypervisor_cpu

  $cpu = await $client->baseline_hypervisor_cpu( $emulator, $arch, $machine, $virttype, $xmlCPUs, $flags = 0 );

=head2 compare_cpu

  $result = await $client->compare_cpu( $xml, $flags = 0 );

=head2 compare_hypervisor_cpu

  $result = await $client->compare_hypervisor_cpu( $emulator, $arch, $machine, $virttype, $xmlCPU, $flags = 0 );

=head2 domain_create_xml

  $dom = await $client->domain_create_xml( $xml_desc, $flags = 0 );

=head2 domain_define_xml

  $dom = await $client->domain_define_xml( $xml );

=head2 domain_define_xml_flags

  $dom = await $client->domain_define_xml_flags( $xml, $flags = 0 );

=head2 domain_lookup_by_id

  $dom = await $client->domain_lookup_by_id( $id );

=head2 domain_lookup_by_name

  $dom = await $client->domain_lookup_by_name( $name );

=head2 domain_lookup_by_uuid

  $dom = await $client->domain_lookup_by_uuid( $uuid );

=head2 domain_migrate_finish

  $ddom = await $client->domain_migrate_finish( $dname, $cookie, $uri, $flags = 0 );

=head2 domain_migrate_finish2

  $ddom = await $client->domain_migrate_finish2( $dname, $cookie, $uri, $flags, $retcode );

=head2 domain_migrate_prepare_tunnel

  await $client->domain_migrate_prepare_tunnel( $flags, $dname, $resource, $dom_xml );
  # -> (* no data *)

=head2 domain_restore

  await $client->domain_restore( $from );
  # -> (* no data *)

=head2 domain_restore_flags

  await $client->domain_restore_flags( $from, $dxml, $flags = 0 );
  # -> (* no data *)

=head2 domain_restore_params

  await $client->domain_restore_params( $params, $flags = 0 );
  # -> (* no data *)

=head2 domain_save_image_define_xml

  await $client->domain_save_image_define_xml( $file, $dxml, $flags = 0 );
  # -> (* no data *)

=head2 domain_save_image_get_xml_desc

  $xml = await $client->domain_save_image_get_xml_desc( $file, $flags = 0 );

=head2 domain_xml_from_native

  $domainXml = await $client->domain_xml_from_native( $nativeFormat, $nativeConfig, $flags = 0 );

=head2 domain_xml_to_native

  $nativeConfig = await $client->domain_xml_to_native( $nativeFormat, $domainXml, $flags = 0 );

=head2 get_capabilities

  $capabilities = await $client->get_capabilities;

=head2 get_domain_capabilities

  $capabilities = await $client->get_domain_capabilities( $emulatorbin, $arch, $machine, $virttype, $flags = 0 );

=head2 get_hostname

  $hostname = await $client->get_hostname;

=head2 get_lib_version

  $lib_ver = await $client->get_lib_version;

=head2 get_max_vcpus

  $max_vcpus = await $client->get_max_vcpus( $type );

=head2 get_storage_pool_capabilities

  $capabilities = await $client->get_storage_pool_capabilities( $flags = 0 );

=head2 get_sysinfo

  $sysinfo = await $client->get_sysinfo( $flags = 0 );

=head2 get_version

  $hv_ver = await $client->get_version;

=head2 interface_change_begin

  await $client->interface_change_begin( $flags = 0 );
  # -> (* no data *)

=head2 interface_change_commit

  await $client->interface_change_commit( $flags = 0 );
  # -> (* no data *)

=head2 interface_change_rollback

  await $client->interface_change_rollback( $flags = 0 );
  # -> (* no data *)

=head2 interface_define_xml

  $iface = await $client->interface_define_xml( $xml, $flags = 0 );

=head2 interface_lookup_by_mac_string

  $iface = await $client->interface_lookup_by_mac_string( $mac );

=head2 interface_lookup_by_name

  $iface = await $client->interface_lookup_by_name( $name );

=head2 list_all_domains

  $domains = await $client->list_all_domains( $flags = 0 );

=head2 list_all_interfaces

  $ifaces = await $client->list_all_interfaces( $flags = 0 );

=head2 list_all_networks

  $nets = await $client->list_all_networks( $flags = 0 );

=head2 list_all_node_devices

  $devices = await $client->list_all_node_devices( $flags = 0 );

=head2 list_all_nwfilter_bindings

  $bindings = await $client->list_all_nwfilter_bindings( $flags = 0 );

=head2 list_all_nwfilters

  $filters = await $client->list_all_nwfilters( $flags = 0 );

=head2 list_all_secrets

  $secrets = await $client->list_all_secrets( $flags = 0 );

=head2 list_all_storage_pools

  $pools = await $client->list_all_storage_pools( $flags = 0 );

=head2 list_defined_domains

  $names = await $client->list_defined_domains;

=head2 list_defined_interfaces

  $names = await $client->list_defined_interfaces;

=head2 list_defined_networks

  $names = await $client->list_defined_networks;

=head2 list_defined_storage_pools

  $names = await $client->list_defined_storage_pools;

=head2 list_interfaces

  $names = await $client->list_interfaces;

=head2 list_networks

  $names = await $client->list_networks;

=head2 list_nwfilters

  $names = await $client->list_nwfilters;

=head2 list_secrets

  $uuids = await $client->list_secrets;

=head2 list_storage_pools

  $names = await $client->list_storage_pools;

=head2 network_create_xml

  $net = await $client->network_create_xml( $xml );

=head2 network_create_xml_flags

  $net = await $client->network_create_xml_flags( $xml, $flags = 0 );

=head2 network_define_xml

  $net = await $client->network_define_xml( $xml );

=head2 network_define_xml_flags

  $net = await $client->network_define_xml_flags( $xml, $flags = 0 );

=head2 network_lookup_by_name

  $net = await $client->network_lookup_by_name( $name );

=head2 network_lookup_by_uuid

  $net = await $client->network_lookup_by_uuid( $uuid );

=head2 node_get_free_memory

  $freeMem = await $client->node_get_free_memory;

=head2 node_get_info

  await $client->node_get_info;
  # -> { cores => $cores,
  #      cpus => $cpus,
  #      memory => $memory,
  #      mhz => $mhz,
  #      model => $model,
  #      nodes => $nodes,
  #      sockets => $sockets,
  #      threads => $threads }

=head2 node_list_devices

  $names = await $client->node_list_devices( $cap, $flags = 0 );

=head2 node_num_of_devices

  $num = await $client->node_num_of_devices( $cap, $flags = 0 );

=head2 node_set_memory_parameters

  await $client->node_set_memory_parameters( $params, $flags = 0 );
  # -> (* no data *)

=head2 node_suspend_for_duration

  await $client->node_suspend_for_duration( $target, $duration, $flags = 0 );
  # -> (* no data *)

=head2 num_of_defined_domains

  $num = await $client->num_of_defined_domains;

=head2 num_of_defined_interfaces

  $num = await $client->num_of_defined_interfaces;

=head2 num_of_defined_networks

  $num = await $client->num_of_defined_networks;

=head2 num_of_defined_storage_pools

  $num = await $client->num_of_defined_storage_pools;

=head2 num_of_domains

  $num = await $client->num_of_domains;

=head2 num_of_interfaces

  $num = await $client->num_of_interfaces;

=head2 num_of_networks

  $num = await $client->num_of_networks;

=head2 num_of_nwfilters

  $num = await $client->num_of_nwfilters;

=head2 num_of_secrets

  $num = await $client->num_of_secrets;

=head2 num_of_storage_pools

  $num = await $client->num_of_storage_pools;

=head2 nwfilter_binding_create_xml

  $nwfilter = await $client->nwfilter_binding_create_xml( $xml, $flags = 0 );

=head2 nwfilter_binding_lookup_by_port_dev

  $nwfilter = await $client->nwfilter_binding_lookup_by_port_dev( $name );

=head2 nwfilter_define_xml

  $nwfilter = await $client->nwfilter_define_xml( $xml );

=head2 nwfilter_define_xml_flags

  $nwfilter = await $client->nwfilter_define_xml_flags( $xml, $flags = 0 );

=head2 nwfilter_lookup_by_name

  $nwfilter = await $client->nwfilter_lookup_by_name( $name );

=head2 nwfilter_lookup_by_uuid

  $nwfilter = await $client->nwfilter_lookup_by_uuid( $uuid );

=head2 secret_define_xml

  $secret = await $client->secret_define_xml( $xml, $flags = 0 );

=head2 secret_lookup_by_usage

  $secret = await $client->secret_lookup_by_usage( $usageType, $usageID );

=head2 secret_lookup_by_uuid

  $secret = await $client->secret_lookup_by_uuid( $uuid );

=head2 set_identity

  await $client->set_identity( $params, $flags = 0 );
  # -> (* no data *)

=head2 storage_pool_create_xml

  $pool = await $client->storage_pool_create_xml( $xml, $flags = 0 );

=head2 storage_pool_define_xml

  $pool = await $client->storage_pool_define_xml( $xml, $flags = 0 );

=head2 storage_pool_lookup_by_name

  $pool = await $client->storage_pool_lookup_by_name( $name );

=head2 storage_pool_lookup_by_target_path

  $pool = await $client->storage_pool_lookup_by_target_path( $path );

=head2 storage_pool_lookup_by_uuid

  $pool = await $client->storage_pool_lookup_by_uuid( $uuid );

=head2 storage_vol_lookup_by_key

  $vol = await $client->storage_vol_lookup_by_key( $key );

=head2 storage_vol_lookup_by_path

  $vol = await $client->storage_vol_lookup_by_path( $path );

=head2 supports_feature

  $supported = await $client->supports_feature( $feature );


=head1 CONSTANTS

=over 8

=item CLOSE_REASON_ERROR

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

=head1 BUGS AND LIMITATIONS

=over 8

=item * Talking to servers without the REMOTE_EVENT_CALLBACK (since v1.3.3) feature
  is not - currently - supported

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

