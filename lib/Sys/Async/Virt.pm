####################################################################
#
#     This file was generated using XDR::Parse version v0.3.1
#                   and LibVirt version v11.5.0
#
#      Don't edit this file, use the source template instead
#
#                 ANY CHANGES HERE WILL BE LOST !
#
####################################################################


use v5.26;
use warnings;
no warnings qw(void);
use experimental 'signatures';
use Feature::Compat::Try;
use Future::AsyncAwait;
use Object::Pad 0.821;
use Sublike::Extended 0.29 'method', 'sub'; # From XS-Parse-Sublike, used by Future::AsyncAwait

class Sys::Async::Virt v0.1.3;

# inheriting from IO::Async::Notifier (a non-Object::Pad base class) implies ':repr(HASH)'
inherit IO::Async::Notifier;


use Carp qw(croak);
use Future;
use Future::Queue;
use Log::Any qw($log);
use Scalar::Util qw(reftype weaken);

use Protocol::Sys::Virt::Remote::XDR v11.5.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use Protocol::Sys::Virt::KeepAlive v11.5.0;
use Protocol::Sys::Virt::Remote v11.5.0;
use Protocol::Sys::Virt::Transport v11.5.0;
use Protocol::Sys::Virt::URI v11.5.0; # imports parse_url

use Sys::Async::Virt::Connection::Factory v0.1.3;
use Sys::Async::Virt::Domain v0.1.3;
use Sys::Async::Virt::DomainCheckpoint v0.1.3;
use Sys::Async::Virt::DomainSnapshot v0.1.3;
use Sys::Async::Virt::Network v0.1.3;
use Sys::Async::Virt::NetworkPort v0.1.3;
use Sys::Async::Virt::NwFilter v0.1.3;
use Sys::Async::Virt::NwFilterBinding v0.1.3;
use Sys::Async::Virt::Interface v0.1.3;
use Sys::Async::Virt::StoragePool v0.1.3;
use Sys::Async::Virt::StorageVol v0.1.3;
use Sys::Async::Virt::NodeDevice v0.1.3;
use Sys::Async::Virt::Secret v0.1.3;

use Sys::Async::Virt::Callback v0.1.3;
use Sys::Async::Virt::Stream v0.1.3;

use constant {
    CLOSE_REASON_ERROR                                  => 0,
    CLOSE_REASON_EOF                                    => 1,
    CLOSE_REASON_KEEPALIVE                              => 2,
    CLOSE_REASON_CLIENT                                 => 3,
    TYPED_PARAM_INT                                     => 1,
    TYPED_PARAM_UINT                                    => 2,
    TYPED_PARAM_LLONG                                   => 3,
    TYPED_PARAM_ULLONG                                  => 4,
    TYPED_PARAM_DOUBLE                                  => 5,
    TYPED_PARAM_BOOLEAN                                 => 6,
    TYPED_PARAM_STRING                                  => 7,
    TYPED_PARAM_STRING_OKAY                             => 1 << 2,
    TYPED_PARAM_FIELD_LENGTH                            => 80,
    GET_DOMAIN_CAPABILITIES_DISABLE_DEPRECATED_FEATURES => (1 << 0),
    DOMAIN_DEFINE_VALIDATE                              => (1 << 0),
    LIST_DOMAINS_ACTIVE                                 => 1 << 0,
    LIST_DOMAINS_INACTIVE                               => 1 << 1,
    LIST_DOMAINS_PERSISTENT                             => 1 << 2,
    LIST_DOMAINS_TRANSIENT                              => 1 << 3,
    LIST_DOMAINS_RUNNING                                => 1 << 4,
    LIST_DOMAINS_PAUSED                                 => 1 << 5,
    LIST_DOMAINS_SHUTOFF                                => 1 << 6,
    LIST_DOMAINS_OTHER                                  => 1 << 7,
    LIST_DOMAINS_MANAGEDSAVE                            => 1 << 8,
    LIST_DOMAINS_NO_MANAGEDSAVE                         => 1 << 9,
    LIST_DOMAINS_AUTOSTART                              => 1 << 10,
    LIST_DOMAINS_NO_AUTOSTART                           => 1 << 11,
    LIST_DOMAINS_HAS_SNAPSHOT                           => 1 << 12,
    LIST_DOMAINS_NO_SNAPSHOT                            => 1 << 13,
    LIST_DOMAINS_HAS_CHECKPOINT                         => 1 << 14,
    LIST_DOMAINS_NO_CHECKPOINT                          => 1 << 15,
    GET_ALL_DOMAINS_STATS_ACTIVE                        => 1 << 0,
    GET_ALL_DOMAINS_STATS_INACTIVE                      => 1 << 1,
    GET_ALL_DOMAINS_STATS_PERSISTENT                    => 1 << 2,
    GET_ALL_DOMAINS_STATS_TRANSIENT                     => 1 << 3,
    GET_ALL_DOMAINS_STATS_RUNNING                       => 1 << 4,
    GET_ALL_DOMAINS_STATS_PAUSED                        => 1 << 5,
    GET_ALL_DOMAINS_STATS_SHUTOFF                       => 1 << 6,
    GET_ALL_DOMAINS_STATS_OTHER                         => 1 << 7,
    GET_ALL_DOMAINS_STATS_NOWAIT                        => 1 << 29,
    GET_ALL_DOMAINS_STATS_BACKING                       => 1 << 30,
    GET_ALL_DOMAINS_STATS_ENFORCE_STATS                 => 1 << 31,
    DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_CONNECTED        => 1,
    DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_DISCONNECTED     => 2,
    DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_UNKNOWN         => 0,
    DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_DOMAIN_STARTED  => 1,
    DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_CHANNEL         => 2,
    DOMAIN_EVENT_ID_LIFECYCLE                           => 0,
    DOMAIN_EVENT_ID_REBOOT                              => 1,
    DOMAIN_EVENT_ID_RTC_CHANGE                          => 2,
    DOMAIN_EVENT_ID_WATCHDOG                            => 3,
    DOMAIN_EVENT_ID_IO_ERROR                            => 4,
    DOMAIN_EVENT_ID_GRAPHICS                            => 5,
    DOMAIN_EVENT_ID_IO_ERROR_REASON                     => 6,
    DOMAIN_EVENT_ID_CONTROL_ERROR                       => 7,
    DOMAIN_EVENT_ID_BLOCK_JOB                           => 8,
    DOMAIN_EVENT_ID_DISK_CHANGE                         => 9,
    DOMAIN_EVENT_ID_TRAY_CHANGE                         => 10,
    DOMAIN_EVENT_ID_PMWAKEUP                            => 11,
    DOMAIN_EVENT_ID_PMSUSPEND                           => 12,
    DOMAIN_EVENT_ID_BALLOON_CHANGE                      => 13,
    DOMAIN_EVENT_ID_PMSUSPEND_DISK                      => 14,
    DOMAIN_EVENT_ID_DEVICE_REMOVED                      => 15,
    DOMAIN_EVENT_ID_BLOCK_JOB_2                         => 16,
    DOMAIN_EVENT_ID_TUNABLE                             => 17,
    DOMAIN_EVENT_ID_AGENT_LIFECYCLE                     => 18,
    DOMAIN_EVENT_ID_DEVICE_ADDED                        => 19,
    DOMAIN_EVENT_ID_MIGRATION_ITERATION                 => 20,
    DOMAIN_EVENT_ID_JOB_COMPLETED                       => 21,
    DOMAIN_EVENT_ID_DEVICE_REMOVAL_FAILED               => 22,
    DOMAIN_EVENT_ID_METADATA_CHANGE                     => 23,
    DOMAIN_EVENT_ID_BLOCK_THRESHOLD                     => 24,
    DOMAIN_EVENT_ID_MEMORY_FAILURE                      => 25,
    DOMAIN_EVENT_ID_MEMORY_DEVICE_SIZE_CHANGE           => 26,
    DOMAIN_EVENT_ID_NIC_MAC_CHANGE                      => 27,
    SUSPEND_TARGET_MEM                                  => 0,
    SUSPEND_TARGET_DISK                                 => 1,
    SUSPEND_TARGET_HYBRID                               => 2,
    SECURITY_LABEL_BUFLEN                               => (4096 + 1),
    SECURITY_MODEL_BUFLEN                               => (256 + 1),
    SECURITY_DOI_BUFLEN                                 => (256 + 1),
    CPU_STATS_FIELD_LENGTH                              => 80,
    CPU_STATS_ALL_CPUS                                  => -1,
    CPU_STATS_KERNEL                                    => "kernel",
    CPU_STATS_USER                                      => "user",
    CPU_STATS_IDLE                                      => "idle",
    CPU_STATS_IOWAIT                                    => "iowait",
    CPU_STATS_INTR                                      => "intr",
    CPU_STATS_UTILIZATION                               => "utilization",
    MEMORY_STATS_FIELD_LENGTH                           => 80,
    MEMORY_STATS_ALL_CELLS                              => -1,
    MEMORY_STATS_TOTAL                                  => "total",
    MEMORY_STATS_FREE                                   => "free",
    MEMORY_STATS_BUFFERS                                => "buffers",
    MEMORY_STATS_CACHED                                 => "cached",
    MEMORY_SHARED_PAGES_TO_SCAN                         => "shm_pages_to_scan",
    MEMORY_SHARED_SLEEP_MILLISECS                       => "shm_sleep_millisecs",
    MEMORY_SHARED_PAGES_SHARED                          => "shm_pages_shared",
    MEMORY_SHARED_PAGES_SHARING                         => "shm_pages_sharing",
    MEMORY_SHARED_PAGES_UNSHARED                        => "shm_pages_unshared",
    MEMORY_SHARED_PAGES_VOLATILE                        => "shm_pages_volatile",
    MEMORY_SHARED_FULL_SCANS                            => "shm_full_scans",
    MEMORY_SHARED_MERGE_ACROSS_NODES                    => "shm_merge_across_nodes",
    SEV_PDH                                             => "pdh",
    SEV_CERT_CHAIN                                      => "cert-chain",
    SEV_CPU0_ID                                         => "cpu0-id",
    SEV_CBITPOS                                         => "cbitpos",
    SEV_REDUCED_PHYS_BITS                               => "reduced-phys-bits",
    SEV_MAX_GUESTS                                      => "max-guests",
    SEV_MAX_ES_GUESTS                                   => "max-es-guests",
    RO                                                  => (1 << 0),
    NO_ALIASES                                          => (1 << 1),
    CRED_USERNAME                                       => 1,
    CRED_AUTHNAME                                       => 2,
    CRED_LANGUAGE                                       => 3,
    CRED_CNONCE                                         => 4,
    CRED_PASSPHRASE                                     => 5,
    CRED_ECHOPROMPT                                     => 6,
    CRED_NOECHOPROMPT                                   => 7,
    CRED_REALM                                          => 8,
    CRED_EXTERNAL                                       => 9,
    UUID_BUFLEN                                         => (16),
    UUID_STRING_BUFLEN                                  => (36+1),
    IDENTITY_USER_NAME                                  => "user-name",
    IDENTITY_UNIX_USER_ID                               => "unix-user-id",
    IDENTITY_GROUP_NAME                                 => "group-name",
    IDENTITY_UNIX_GROUP_ID                              => "unix-group-id",
    IDENTITY_PROCESS_ID                                 => "process-id",
    IDENTITY_PROCESS_TIME                               => "process-time",
    IDENTITY_SASL_USER_NAME                             => "sasl-user-name",
    IDENTITY_X509_DISTINGUISHED_NAME                    => "x509-distinguished-name",
    IDENTITY_SELINUX_CONTEXT                            => "selinux-context",
    CPU_COMPARE_ERROR                                   => -1,
    CPU_COMPARE_INCOMPATIBLE                            => 0,
    CPU_COMPARE_IDENTICAL                               => 1,
    CPU_COMPARE_SUPERSET                                => 2,
    COMPARE_CPU_FAIL_INCOMPATIBLE                       => (1 << 0),
    COMPARE_CPU_VALIDATE_XML                            => (1 << 1),
    BASELINE_CPU_EXPAND_FEATURES                        => (1 << 0),
    BASELINE_CPU_MIGRATABLE                             => (1 << 1),
    ALLOC_PAGES_ADD                                     => 0,
    ALLOC_PAGES_SET                                     => (1 << 0),
    LIST_INTERFACES_INACTIVE                            => 1 << 0,
    LIST_INTERFACES_ACTIVE                              => 1 << 1,
    INTERFACE_DEFINE_VALIDATE                           => 1 << 0,
    LIST_NETWORKS_INACTIVE                              => 1 << 0,
    LIST_NETWORKS_ACTIVE                                => 1 << 1,
    LIST_NETWORKS_PERSISTENT                            => 1 << 2,
    LIST_NETWORKS_TRANSIENT                             => 1 << 3,
    LIST_NETWORKS_AUTOSTART                             => 1 << 4,
    LIST_NETWORKS_NO_AUTOSTART                          => 1 << 5,
    NETWORK_CREATE_VALIDATE                             => 1 << 0,
    NETWORK_DEFINE_VALIDATE                             => 1 << 0,
    NETWORK_EVENT_ID_LIFECYCLE                          => 0,
    NETWORK_EVENT_ID_METADATA_CHANGE                    => 1,
    LIST_NODE_DEVICES_CAP_SYSTEM                        => 1 << 0,
    LIST_NODE_DEVICES_CAP_PCI_DEV                       => 1 << 1,
    LIST_NODE_DEVICES_CAP_USB_DEV                       => 1 << 2,
    LIST_NODE_DEVICES_CAP_USB_INTERFACE                 => 1 << 3,
    LIST_NODE_DEVICES_CAP_NET                           => 1 << 4,
    LIST_NODE_DEVICES_CAP_SCSI_HOST                     => 1 << 5,
    LIST_NODE_DEVICES_CAP_SCSI_TARGET                   => 1 << 6,
    LIST_NODE_DEVICES_CAP_SCSI                          => 1 << 7,
    LIST_NODE_DEVICES_CAP_STORAGE                       => 1 << 8,
    LIST_NODE_DEVICES_CAP_FC_HOST                       => 1 << 9,
    LIST_NODE_DEVICES_CAP_VPORTS                        => 1 << 10,
    LIST_NODE_DEVICES_CAP_SCSI_GENERIC                  => 1 << 11,
    LIST_NODE_DEVICES_CAP_DRM                           => 1 << 12,
    LIST_NODE_DEVICES_CAP_MDEV_TYPES                    => 1 << 13,
    LIST_NODE_DEVICES_CAP_MDEV                          => 1 << 14,
    LIST_NODE_DEVICES_CAP_CCW_DEV                       => 1 << 15,
    LIST_NODE_DEVICES_CAP_CSS_DEV                       => 1 << 16,
    LIST_NODE_DEVICES_CAP_VDPA                          => 1 << 17,
    LIST_NODE_DEVICES_CAP_AP_CARD                       => 1 << 18,
    LIST_NODE_DEVICES_CAP_AP_QUEUE                      => 1 << 19,
    LIST_NODE_DEVICES_CAP_AP_MATRIX                     => 1 << 20,
    LIST_NODE_DEVICES_CAP_VPD                           => 1 << 21,
    LIST_NODE_DEVICES_CAP_CCWGROUP_DEV                  => 1 << 22,
    LIST_NODE_DEVICES_CAP_CCWGROUP_MEMBER               => 1 << 23,
    LIST_NODE_DEVICES_PERSISTENT                        => 1 << 28,
    LIST_NODE_DEVICES_TRANSIENT                         => 1 << 29,
    LIST_NODE_DEVICES_INACTIVE                          => 1 << 30,
    LIST_NODE_DEVICES_ACTIVE                            => 1 << 31,
    NODE_DEVICE_CREATE_XML_VALIDATE                     => 1 << 0,
    NODE_DEVICE_DEFINE_XML_VALIDATE                     => 1 << 0,
    NODE_DEVICE_EVENT_ID_LIFECYCLE                      => 0,
    NODE_DEVICE_EVENT_ID_UPDATE                         => 1,
    NWFILTER_DEFINE_VALIDATE                            => 1 << 0,
    NWFILTER_BINDING_CREATE_VALIDATE                    => 1 << 0,
    SECRET_USAGE_TYPE_NONE                              => 0,
    SECRET_USAGE_TYPE_VOLUME                            => 1,
    SECRET_USAGE_TYPE_CEPH                              => 2,
    SECRET_USAGE_TYPE_ISCSI                             => 3,
    SECRET_USAGE_TYPE_TLS                               => 4,
    SECRET_USAGE_TYPE_VTPM                              => 5,
    LIST_SECRETS_EPHEMERAL                              => 1 << 0,
    LIST_SECRETS_NO_EPHEMERAL                           => 1 << 1,
    LIST_SECRETS_PRIVATE                                => 1 << 2,
    LIST_SECRETS_NO_PRIVATE                             => 1 << 3,
    SECRET_DEFINE_VALIDATE                              => 1 << 0,
    SECRET_EVENT_ID_LIFECYCLE                           => 0,
    SECRET_EVENT_ID_VALUE_CHANGED                       => 1,
    STORAGE_POOL_CREATE_NORMAL                          => 0,
    STORAGE_POOL_CREATE_WITH_BUILD                      => 1 << 0,
    STORAGE_POOL_CREATE_WITH_BUILD_OVERWRITE            => 1 << 1,
    STORAGE_POOL_CREATE_WITH_BUILD_NO_OVERWRITE         => 1 << 2,
    LIST_STORAGE_POOLS_INACTIVE                         => 1 << 0,
    LIST_STORAGE_POOLS_ACTIVE                           => 1 << 1,
    LIST_STORAGE_POOLS_PERSISTENT                       => 1 << 2,
    LIST_STORAGE_POOLS_TRANSIENT                        => 1 << 3,
    LIST_STORAGE_POOLS_AUTOSTART                        => 1 << 4,
    LIST_STORAGE_POOLS_NO_AUTOSTART                     => 1 << 5,
    LIST_STORAGE_POOLS_DIR                              => 1 << 6,
    LIST_STORAGE_POOLS_FS                               => 1 << 7,
    LIST_STORAGE_POOLS_NETFS                            => 1 << 8,
    LIST_STORAGE_POOLS_LOGICAL                          => 1 << 9,
    LIST_STORAGE_POOLS_DISK                             => 1 << 10,
    LIST_STORAGE_POOLS_ISCSI                            => 1 << 11,
    LIST_STORAGE_POOLS_SCSI                             => 1 << 12,
    LIST_STORAGE_POOLS_MPATH                            => 1 << 13,
    LIST_STORAGE_POOLS_RBD                              => 1 << 14,
    LIST_STORAGE_POOLS_SHEEPDOG                         => 1 << 15,
    LIST_STORAGE_POOLS_GLUSTER                          => 1 << 16,
    LIST_STORAGE_POOLS_ZFS                              => 1 << 17,
    LIST_STORAGE_POOLS_VSTORAGE                         => 1 << 18,
    LIST_STORAGE_POOLS_ISCSI_DIRECT                     => 1 << 19,
    STORAGE_POOL_DEFINE_VALIDATE                        => 1 << 0,
    STORAGE_VOL_CREATE_PREALLOC_METADATA                => 1 << 0,
    STORAGE_VOL_CREATE_REFLINK                          => 1 << 1,
    STORAGE_VOL_CREATE_VALIDATE                         => 1 << 2,
    STORAGE_POOL_EVENT_ID_LIFECYCLE                     => 0,
    STORAGE_POOL_EVENT_ID_REFRESH                       => 1,
};



field $_domains            = {};
field $_domain_checkpoints = {};
field $_domain_snapshots   = {};
field $_networks           = {};
field $_network_ports      = {};
field $_nwfilters          = {};
field $_nwfilter_bindings  = {};
field $_interfaces         = {};
field $_storage_pools      = {};
field $_storage_vols       = {};
field $_node_devices       = {};
field $_secrets            = {};
field $_callbacks          = {};
field $_streams            = {};

# cached host data:
field $_maplen                  = 0; # length of the cpu map in bytes
field $_cpus                    = 0; # number of cpus in the hypervisor
field $_typed_param_string_okay = undef;


field $_url           :param = $ENV{LIBVIRT_DEFAULT_URI};
field $_readonly      :param = undef;
field $_connection    :param = undef;
field $_transport     :param = undef;
field $_remote        :param = undef;
field $_factory       :param = undef;
field $_keepalive     :param = undef;
field $_ping_interval :param = 60;

field $_on_close      :param = sub {};
field $_on_stream     :param = undef;
field $_on_message    :param = sub {};

field $_keepalive_future = undef;
field $_pump_future      = undef;
field $_state            = 'DISCONNECTED'; # state machine
field $_substate         = ''; # when _state=='CONNECTED'
field $_replies          = {};


method _no_translation(@args) {
    return @args;
}

method _translate_remote_nonnull_domain($dom, @) {
    $self->_domain_instance( $dom );
}

method _translate_remote_nonnull_domain_checkpoint($checkpoint, @) {
    $self->_domain_checkpoint_instance( $checkpoint );
}

method _translate_remote_nonnull_domain_snapshot($snapshot, @) {
    $self->_domain_snapshot_instance( $snapshot );
}

method _translate_remote_nonnull_network($network, @) {
    $self->_network_instance( $network );
}

method _translate_remote_nonnull_network_port($network_port, @) {
    $self->_network_port_instance( $network_port );
}

method _translate_remote_nonnull_nwfilter($nwfilter, @) {
    $self->_network_nwfilter_instance( $nwfilter );
}

method _translate_remote_nonnull_nwfilter_binding($binding, @) {
    $self->_network_nwfilter_binding_instance( $binding );
}

method _translate_remote_nonnull_interface($interface, @) {
    $self->_network_interface_instance( $interface );
}

method _translate_remote_nonnull_storage_pool($pool, @) {
    $self->_storage_pool_instance( $pool );
}

method _translate_remote_nonnull_storage_vol($vol, @) {
    $self->_storage_vol_instance( $vol );
}

method _translate_remote_nonnull_node_device($device, @) {
    $self->_node_device_instance( $device );
}

method _translate_remote_nonnull_secret($secret, @) {
    $self->_secret_instance( $secret );
}

my @reply_translators = (
    undef,
    \&_no_translation,
    \&_no_translation,
    sub { 3; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 4; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 5; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 7; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 10; my $client = shift; _translated_reply($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 11; my $client = shift; _translated_reply($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 14; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 15; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 17; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 18; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 19; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 21; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 22; my $client = shift; _translated_reply($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 23; my $client = shift; _translated_reply($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 24; my $client = shift; _translated_reply($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 25; my $client = shift; _translated_reply($client, undef, {  }, @_) },
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
    sub { 36; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 37; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 38; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 40; my $client = shift; _translated_reply($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 41; my $client = shift; _translated_reply($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    sub { 43; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 44; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 45; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 46; my $client = shift; _translated_reply($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 47; my $client = shift; _translated_reply($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 50; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 51; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 52; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 56; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 57; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 59; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 60; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 63; my $client = shift; _translated_reply($client, undef, { ddom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 71; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 72; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 73; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 74; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 75; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 76; my $client = shift; _translated_reply($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 77; my $client = shift; _translated_reply($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 84; my $client = shift; _translated_reply($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 85; my $client = shift; _translated_reply($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 86; my $client = shift; _translated_reply($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    sub { 88; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 89; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 91; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 92; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 93; my $client = shift; _translated_reply($client, undef, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    \&_no_translation,
    sub { 95; my $client = shift; _translated_reply($client, undef, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 96; my $client = shift; _translated_reply($client, undef, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 97; my $client = shift; _translated_reply($client, undef, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    \&_no_translation,
    sub { 99; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 100; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 102; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 103; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 104; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 107; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 109; my $client = shift; _translated_reply($client, undef, { ddom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 110; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 111; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 112; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 113; my $client = shift; _translated_reply($client, undef, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    sub { 114; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 115; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 116; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 117; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 123; my $client = shift; _translated_reply($client, undef, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { 125; my $client = shift; _translated_reply($client, undef, { vol => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 126; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 127; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 128; my $client = shift; _translated_reply($client, undef, { iface => \&_translate_remote_nonnull_interface }, @_) },
    sub { 129; my $client = shift; _translated_reply($client, undef, { iface => \&_translate_remote_nonnull_interface }, @_) },
    sub { 130; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 131; my $client = shift; _translated_reply($client, undef, { iface => \&_translate_remote_nonnull_interface }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 135; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 136; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 137; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 138; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 139; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 140; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 141; my $client = shift; _translated_reply($client, undef, { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { 142; my $client = shift; _translated_reply($client, undef, { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { 143; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 145; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 147; my $client = shift; _translated_reply($client, undef, { secret => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 150; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 151; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 152; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 153; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 154; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 155; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 156; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 157; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 158; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 159; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 162; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 169; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 170; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 171; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 172; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 173; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 175; my $client = shift; _translated_reply($client, undef, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 176; my $client = shift; _translated_reply($client, undef, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 177; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 178; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 179; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 180; my $client = shift; _translated_reply($client, undef, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 183; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 185; my $client = shift; _translated_reply($client, undef, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 186; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 187; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 188; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 189; my $client = shift; _translated_reply($client, undef, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 190; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 191; my $client = shift; _translated_reply($client, undef, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 195; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 196; my $client = shift; _translated_reply($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 198; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 200; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 202; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 203; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 206; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 211; my $client = shift; _translated_reply($client, undef, {  }, @_) },
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
    sub { 223; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    undef,
    \&_no_translation,
    \&_no_translation,
    sub { 227; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 228; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 235; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    undef,
    sub { 242; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 243; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 244; my $client = shift; _translated_reply($client, undef, { snap => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    \&_no_translation,
    sub { 246; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 247; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    undef,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 253; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 255; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 257; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 262; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 263; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 265; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 268; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 269; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 270; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 271; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 272; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 273; my $client = shift; _translated_reply($client, undef, { domains => \&_translate_remote_nonnull_domain }, @_) },
    sub { 274; my $client = shift; _translated_reply($client, undef, { snapshots => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 275; my $client = shift; _translated_reply($client, undef, { snapshots => \&_translate_remote_nonnull_domain_snapshot }, @_) },
    sub { 276; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 277; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 281; my $client = shift; _translated_reply($client, undef, { pools => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 282; my $client = shift; _translated_reply($client, undef, { vols => \&_translate_remote_nonnull_storage_vol }, @_) },
    sub { 283; my $client = shift; _translated_reply($client, undef, { nets => \&_translate_remote_nonnull_network }, @_) },
    sub { 284; my $client = shift; _translated_reply($client, undef, { ifaces => \&_translate_remote_nonnull_interface }, @_) },
    sub { 285; my $client = shift; _translated_reply($client, undef, { devices => \&_translate_remote_nonnull_node_device }, @_) },
    sub { 286; my $client = shift; _translated_reply($client, undef, { filters => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 287; my $client = shift; _translated_reply($client, undef, { secrets => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    sub { 289; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 292; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 297; my $client = shift; _translated_reply($client, undef, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { 299; my $client = shift; _translated_reply($client, undef, {  }, @_) },
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
    sub { 311; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 312; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 315; my $client = shift; _translated_msg($client, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 318; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 319; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 320; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 321; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 322; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 323; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 324; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 325; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 326; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 327; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 328; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 329; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 330; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 331; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 332; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    sub { 333; my $client = shift; _translated_msg($client, { msg => { dom => \&_translate_remote_nonnull_domain } }, @_) },
    \&_no_translation,
    sub { 335; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 336; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    undef,
    \&_no_translation,
    sub { 341; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 342; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 344; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 346; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 348; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 349; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 350; my $client = shift; _translated_reply($client, undef, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 353; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 354; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 358; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 359; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    undef,
    sub { 363; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 365; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 367; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 370; my $client = shift; _translated_msg($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    sub { 371; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 373; my $client = shift; _translated_msg($client, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 376; my $client = shift; _translated_msg($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    sub { 377; my $client = shift; _translated_msg($client, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    sub { 379; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 382; my $client = shift; _translated_msg($client, { secret => \&_translate_remote_nonnull_secret }, @_) },
    sub { 383; my $client = shift; _translated_msg($client, { secret => \&_translate_remote_nonnull_secret }, @_) },
    \&_no_translation,
    sub { 385; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    sub { 387; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 388; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 391; my $client = shift; _translated_reply($client, undef, { pool => \&_translate_remote_nonnull_storage_pool }, @_) },
    \&_no_translation,
    sub { 393; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 394; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 395; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 396; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 397; my $client = shift; _translated_reply($client, undef, { nwfilter => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    sub { 398; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 399; my $client = shift; _translated_reply($client, undef, { nwfilter => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    \&_no_translation,
    sub { 401; my $client = shift; _translated_reply($client, undef, { bindings => \&_translate_remote_nonnull_nwfilter_binding }, @_) },
    \&_no_translation,
    sub { 403; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 404; my $client = shift; _translated_reply($client, undef, { ports => \&_translate_remote_nonnull_network_port }, @_) },
    sub { 405; my $client = shift; _translated_reply($client, undef, { port => \&_translate_remote_nonnull_network_port }, @_) },
    sub { 406; my $client = shift; _translated_reply($client, undef, { port => \&_translate_remote_nonnull_network_port }, @_) },
    sub { 407; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 409; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 411; my $client = shift; _translated_reply($client, undef, { checkpoint => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 412; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 413; my $client = shift; _translated_reply($client, undef, { checkpoints => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 414; my $client = shift; _translated_reply($client, undef, { checkpoints => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 415; my $client = shift; _translated_reply($client, undef, { checkpoint => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    sub { 416; my $client = shift; _translated_reply($client, undef, { parent => \&_translate_remote_nonnull_domain_checkpoint }, @_) },
    \&_no_translation,
    sub { 418; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 420; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 422; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 423; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    sub { 424; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 426; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 428; my $client = shift; _translated_reply($client, undef, { dev => \&_translate_remote_nonnull_node_device }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 431; my $client = shift; _translated_reply($client, undef, { nwfilter => \&_translate_remote_nonnull_nwfilter }, @_) },
    sub { 432; my $client = shift; _translated_reply($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 433; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    sub { 435; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 436; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 437; my $client = shift; _translated_reply($client, undef, { net => \&_translate_remote_nonnull_network }, @_) },
    sub { 438; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 445; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    sub { 446; my $client = shift; _translated_msg($client, { net => \&_translate_remote_nonnull_network }, @_) },
    \&_no_translation,
    \&_no_translation,
    sub { 449; my $client = shift; _translated_reply($client, undef, {  }, @_) },
    \&_no_translation,
    \&_no_translation,
    \&_no_translation,
    sub { 453; my $client = shift; _translated_msg($client, { dom => \&_translate_remote_nonnull_domain }, @_) }
);


sub _map( $client, $unwrap, $argmap, $data) {
    for my $key (keys $argmap->%*) {
        my $val = $data->{$key};

        if (ref $argmap->{$key} and reftype $argmap->{$key} eq 'HASH') {
            $data->{$key} = _map( $client, undef, $argmap->{$key}, $val );
        }
        elsif (ref $val and reftype $val eq 'ARRAY') {
            $data->{$key} = [
                map { $argmap->{$key}->( $client, $_ ) } $val->@* ];
        }
        else {
            $data->{$key} = $argmap->{$key}->( $client, $val );
        }
    }

    return $data;
}

sub _translated_msg($client, $argsmap, %args) {
    return (%args, ) unless $args{data};
    my $data = _map($client, undef, $argsmap, $args{data});
    my $msg = delete $data->{msg};
    delete $data->{callbackID};
    if ($msg) {
        $args{data} = {
            $data->%*, $msg->%*
        };
    }
    return (%args, );
}

sub _translated_reply($client, $unwrap, $argmap, %args) {
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

method _domain_instance($id) {
    # Use $id->{id} as part of the cache key so we return a different domain
    # instance between the cases where the server includes an 'id' and where
    # it does not, such as:
    #   my ($off_dom) = $virt->list_all_domains->@*;
    #   my $on_dom = $off_dom->create;
    #
    # Here, $off_dom does not have an 'id' value. $on_dom has been assigned
    # an 'id' because it's running.
    my $dom_id = $id->{id} // '';
    my $key = "$dom_id/$id->{uuid}";
    my $c = $_domains->{$key};
    unless ($c) {
        $c = $_domains->{$key} = _domain_factory(
            client => $self,
            remote => $_remote,
            id => $id );
        weaken $_domains->{$key};
    }
    return $c;
}

method _domain_checkpoint_instance($id) {
    my $key = "$id->{dom}->{uuid}/$id->{name}";
    my $c = $_domain_checkpoints->{$key};
    unless ($c) {
        $c = $_domain_checkpoints->{$key} =
            _domain_checkpoint_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_domain_checkpoints->{$key};
    }
    return $c;
}

method _domain_snapshot_instance($id) {
    my $key = "$id->{dom}->{uuid}/$id->{name}";
    my $c = $_domain_snapshots->{$id->{uuid}};
    unless ($c) {
        $c = $_domain_snapshots->{$id->{uuid}} =
            _domain_snapshot_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_domain_snapshots->{$id->{uuid}};
    }
    return $c;
}

method _network_instance($id) {
    my $c = $_networks->{$id->{uuid}};
    unless ($c) {
        $c = $_networks->{$id->{uuid}} =
            network_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_networks->{$id->{uuid}};
    }
    return $c;
}

method _network_port_instance($id) {
    my $c = $_network_ports->{$id->{uuid}};
    unless ($c) {
        $c = $_network_ports->{$id->{uuid}} =
            network_port_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_network_ports->{$id->{uuid}};
    }
    return $c;
}

method _nwfilter_instance($id) {
    my $c = $_nwfilters->{$id->{uuid}};
    unless ($c) {
        $c = $_nwfilters->{$id->{uuid}} =
            nwfilter_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_nwfilters->{$id->{uuid}};
    }
    return $c;
}

method _nwfilter_binding_instance($id) {
    my $key = "$id->{portdev}/$id->{filtername}";
    my $c = $_nwfilter_bindings->{$key};
    unless ($c) {
        $c = $_nwfilter_bindings->{$key} =
            nwfilter_binding_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_nwfilter_bindings->{$key};
    }
    return $c;
}

method _interface_instance($id) {
    my $key = "$id->{mac}/$id->{name}";
    my $c = $_interfaces->{$key};
    unless ($c) {
        $c = $_interfaces->{$key} =
            interface_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_interfaces->{$key};
    }
    return $c;
}

method _storage_pool_instance($id) {
    my $c = $_storage_pools->{$id->{uuid}};
    unless ($c) {
        $c = $_storage_pools->{$id->{uuid}} =
            storage_pool_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_storage_pools->{$id->{uuid}};
    }
    return $c;
}

method _storage_vol_instance($id) {
    my $c = $_storage_vols->{$id->{key}};
    unless ($c) {
        $c = $_storage_vols->{$id->{key}} =
            storage_vol_factory->(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_storage_vols->{$id->{key}};
    }
    return $c;
}

method _node_device_instance($id) {
    my $c = $_node_devices->{$id->{name}};
    unless ($c) {
        $c = $_node_devices->{$id->{name}} =
            node_device_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_node_devices->{$id->{name}};
    }
    return $c;
}

method _secret_instance($id) {
    my $c = $_secrets->{$id->{uuid}};
    unless ($c) {
        $c = $_secrets->{$id->{uuid}} =
            secret_factory(
                client => $self,
                remote => $_remote,
                id => $id );
        weaken $_secrets->{$id->{uuid}};
    }
    return $c;
}

async method _call($proc, $args = {}, :$unwrap = '', :$stream = '', :$empty = '') {
    die $log->fatal( "RPC call without remote connection (proc: $proc)" )
        unless $self->is_connected;
    my $serial = await $_remote->call( $proc, $args );
    my $f = $self->loop->new_future;
    $log->trace( "Setting serial $serial future (proc: $proc)" );
    $_replies->{$serial} = $f;
    ### Return a stream somehow...
    my @rv = await $f;
    $rv[0] = $rv[0]->{$unwrap} if $unwrap;
    shift @rv if $empty;
    if ($stream) {
        my $s = Sys::Async::Virt::Stream->new(
            id => $serial,
            proc => $proc,
            client => $self,
            direction => ($stream eq 'write' ? 'send' : 'receive'),
            );
        $_streams->{$serial} = $s;
        weaken $_streams->{$serial};
        $self->add_child( $s );

        push @rv, $s;
    }
    return @rv;
}

async method _from_cpumap($cpumap, $offset = 0) {
    my $cpus = await $self->_cpus;
    return [ map { vec( $cpumap, $offset+$_, 1 ) } 0 .. ($cpus - 1) ];
}

async method _to_cpumap($cpuarray) {
    my $maplen = await $self->_maplen;
    my $map = "\0" x $maplen;
    vec( $map, $cpuarray->[$_] ? 1 : 0, 1 )
        for ( 0 .. scalar($cpuarray->@*) );

    return $map
}

async method _cpus() {
    return $_cpus if $_cpus;

    await $self->get_cpu_map;
    return $_cpus;
}

async method _maplen() {
    return $_maplen if $_maplen;

    await $self->get_cpu_map;
    return $_maplen;
}

async method _send($proc, $serial, :$data = undef, :$hole = undef, %rest) {
    await $_remote->stream(
        $proc, $serial,
        data => $data,
        hole => $hole);
}

async method _send_finish($proc, $serial, $abort) {
    await $_remote->stream_end($proc, $serial, $abort);
}

async method _typed_param_string_okay() {
    return $_typed_param_string_okay //=
        ((await $self->_supports_feature(
              $_remote->DRV_FEATURE_TYPED_PARAM_STRING ))
         ? $self->TYPED_PARAM_STRING_OKAY : 0);
}

async method _filter_typed_param_string($params) {
    return await $self->_typed_param_string_okay
        ? $params
        : [ grep {
               $params->{value}->{type} != $remote->VIR_TYPED_PARAM_STRING
            } @$params ];
}

method _dispatch_closed(@args) {
    $_on_close->( $self, @args );
    # dispatch only once, on first-come-first-serve basis:
    $_on_close = sub { };
}

method _dispatch_message(:$data = undef, :$header = undef, %args) {
    if ($_keepalive) {
        $_keepalive->mark_active;
    }
    if ($data
        and defined $data->{callbackID}
        and my $cb = $_callbacks->{$data->{callbackID}}) {

        my %cbargs = $reply_translators[$header->{proc}]->(
            $self, data => $data, header => $header, %args
            );
        $cb->_dispatch_event($cbargs{data});
    }
    else {
        my %cbargs = $reply_translators[$header->{proc}]->( $self, %args );
        $_on_message->( $cbargs{data} );
    }
}

method _dispatch_reply(:$header, %args) {
    $log->trace( "Dispatching serial $header->{serial}" );
    if ($_keepalive) {
        $_keepalive->mark_active;
    }
    my $f = delete $_replies->{$header->{serial}};

    if (exists $args{data}) {
        my %cbargs = $reply_translators[$header->{proc}]->( $self, header => $header, %args );
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

method _dispatch_stream(:$header, %args) {
    if ($_keepalive) {
        $_keepalive->mark_active;
    }
    if (my $stream = $_streams->{$header->{serial}}) {
        if ($args{error}) {
            return $stream->_dispatch_error($args{error});
        }
        else {
            return $stream->_dispatch_receive($args{data}, $args{final});
        }
    }
    else {
        return $_on_stream->( $self, header => $header, %args );
    }
}

method configure(%args) {
    for my $key (keys %args) {
        $self->{$key} = $args{$key} // sub {};
    }
}

method register($r) {
    $r->configure(
        on_closed  => sub { $self->_dispatch_closed( @_ ) },
        on_message => sub { $self->_dispatch_message( @_ ) },
        on_reply   => sub { $self->_dispatch_reply( @_ ) },
        on_stream  => sub { $self->_dispatch_stream( @_ ) }
        );
    $_remote = $r;
}


async sub _pump($conn, $transport) {
    my $eof;
    my $data;
    while (not $eof) {
        my ($len, $type) = $transport->need;
        $log->trace( "Reading data from connection: initiated (len: $len)" );
        ($data, $eof) = await $conn->read( $type, $len );
        last if length($data) == 0 and $eof;
        $log->trace( 'Reading data from connection: completed' );

        await Future->wait_all( $transport->receive($data) );
        $log->trace( 'Processed input data from connection' );
    }
    $log->info( 'EOF' );
}

method is_connected() {
    return $_state eq 'CONNECTED';
}

method is_opened() {
    return ($_state eq 'CONNECTED'
            and $_substate eq 'OPENED');
}

method _remove_stream($id) {
    delete $_streams->{$id};
    return;
}

# ENTRYPOINT: REMOTE_PROC_CONNECT_IS_SECURE
async method is_secure() {
    return ($self->is_opened
        and $_connection->is_secure
        and await $self->_call( $remote->PROC_CONNECT_IS_SECURE,
                                {}, unwrap => 'secure' ));
}

async method connect(:$pump //= \&_pump) {
    return if $_state ne 'DISCONNECTED';

    unless ($_connection) {
        $_factory    //= Sys::Async::Virt::Connection::Factory->new;
        $_connection = $_factory->create_connection( $_url,
                                                     readonly => $_readonly );
        $self->add_child( $_connection );
    }

    unless ($_transport) {
        $_transport = Protocol::Sys::Virt::Transport->new(
            role => 'client',
            on_send => async sub($opaque, @data) {
                await $_connection->write( @data );
                return $opaque;
            });
    }

    $_remote //= Protocol::Sys::Virt::Remote->new( role => 'client' );
    $_remote->register( $_transport );
    $self->register( $_remote );

    $_state = 'CONNECTING';
    await $_connection->connect;
    $_state    = 'CONNECTED';
    $_substate = 'NONE';
    $log->trace( "Connected" );

    my $f = $pump->( $_connection, $_transport );
    $self->adopt_future( $f );
    $f->on_done(
        sub {
            $self->_close( $self->CLOSE_REASON_EOF );
        });
    $f->on_fail(
        sub {
            $self->_close( $self->CLOSE_REASON_ERROR );
        });
    $_pump_future = $f;

    $_substate = 'AUTHENTICATING';
    await $self->auth();
    $_substate = 'AUTHENTICATED';
    $log->trace( "Authenticated" );
    # auth( $auth_type )
    #  --> clients take the selected auth mechanism from the
    #      connection URL: auth='sasl[.<mech>]" / auth='none' / auth='polkit'
    # in order to be able to handle SASL AUTH, we'll need an Authen::SASL
    # authentication parameter to be passed in though...

    if (await $self->_supports_feature(
            $_remote->DRV_FEATURE_PROGRAM_KEEPALIVE )) {
        $_keepalive //= Protocol::Sys::Virt::KeepAlive->new(
            max_inactive => 5,
            on_ack       => sub { $log->trace('KeepAlive PING ACK'); return; },
            on_ping      => sub {
                $log->trace('KeepAlive ACK-ing PING');
                $self->adopt_future( $_[0]->pong );
                return;
            },
            on_fail      => sub {
                $log->fatal('KeepAlive time out - closing connection');
                $self->adopt_future(
                    $self->_close( $self->CLOSE_REASON_KEEPALIVE ) );
                return;
            });

        $_keepalive->register( $_transport );
        my $keep_pump = async sub {
            while (1) {
                await $self->loop->delay_future(
                    after => $_ping_interval
                    );
                $log->trace('Sending PING');
                if (my $f = $_keepalive->ping ) {
                    $self->adopt_future( $f );
                }
            }
        };
        my $f = $keep_pump->();
        $self->adopt_future( $f );
        $_keepalive_future = $f;
    }

    $_substate = 'OPENING';
    await $self->open();
    $_substate = 'OPENED';

    return;
}


# ENTRYPOINT: REMOTE_PROC_CONNECT_DOMAIN_EVENT_CALLBACK_REGISTER_ANY
# ENTRYPOINT: REMOTE_PROC_CONNECT_DOMAIN_EVENT_CALLBACK_DEREGISTER_ANY
async method domain_event_register_any($eventID, $domain = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_DOMAIN_EVENT_CALLBACK_REGISTER_ANY,
        { eventID => $eventID, dom => $domain->id });
    my $dereg = $remote->PROC_CONNECT_DOMAIN_EVENT_CALLBACK_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $_callbacks->{$rv->{callbackID}} = $cb;
    weaken $_callbacks->{$rv->{callbackID}};

    return $cb;
}

# ENTRYPOINT: REMOTE_PROC_CONNECT_NETWORK_EVENT_REGISTER_ANY
# ENTRYPOINT: REMOTE_PROC_CONNECT_NETWORK_EVENT_DEREGISTER_ANY
async method network_event_register_any($eventID, $network = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_NETWORK_EVENT_REGISTER_ANY,
        { eventID => $eventID, net => $network->id });
    my $dereg = $remote->PROC_CONNECT_NETWORK_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $_callbacks->{$rv->{callbackID}} = $cb;

    return $cb;
}

# ENTRYPOINT: REMOTE_PROC_CONNECT_STORAGE_POOL_EVENT_REGISTER_ANY
# ENTRYPOINT: REMOTE_PROC_CONNECT_STORAGE_POOL_EVENT_DEREGISTER_ANY
async method storage_pool_event_register_any($eventID, $pool = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_STORAGE_POOL_EVENT_REGISTER_ANY,
        { eventID => $eventID, pool => $pool->id });
    my $dereg = $remote->PROC_CONNECT_STORAGE_POOL_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $_callbacks->{$rv->{callbackID}} = $cb;

    return $cb;
}

# ENTRYPOINT: REMOTE_PROC_CONNECT_NODE_DEVICE_EVENT_REGISTER_ANY
# ENTRYPOINT: REMOTE_PROC_CONNECT_NODE_DEVICE_EVENT_DEREGISTER_ANY
async method node_device_event_register_any($eventID, $dev = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_NODE_DEVICE_EVENT_REGISTER_ANY,
        { eventID => $eventID, dev => $dev->id });
    my $dereg = $remote->PROC_CONNECT_NODE_DEVICE_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $_callbacks->{$rv->{callbackID}} = $cb;

    return $cb;
}

# ENTRYPOINT: REMOTE_PROC_CONNECT_SECRET_EVENT_REGISTER_ANY
# ENTRYPOINT: REMOTE_PROC_CONNECT_SECRET_EVENT_DEREGISTER_ANY
async method secret_event_register_any($eventID, $secret = undef) {
    my $rv = await $self->_call(
        $remote->PROC_CONNECT_SECRET_EVENT_REGISTER_ANY,
        { eventID => $eventID, secret => $secret->id });
    my $dereg = $remote->PROC_CONNECT_SECRET_EVENT_DEREGISTER_ANY;
    my $cb = Sys::Async::Virt::Callback->new(
        id => $rv->{callbackID},
        client => $self,
        deregister_call => $dereg,
        factory => sub { $self->loop->new_future }
        );
    $_callbacks->{$rv->{callbackID}} = $cb;

    return $cb;
}

# ENTRYPOINT: REMOTE_PROC_AUTH_LIST
# ENTRYPOINT: REMOTE_PROC_AUTH_POLKIT
# ENTRYPOINT: REMOTE_PROC_AUTH_SASL_INIT
async method auth($auth_type = undef) {
    my $auth_types = await $self->_call( $remote->PROC_AUTH_LIST, {},
                                         unwrap => 'types' );

    my $selected;
    if (defined $auth_type) {
        my $want;
        if ($auth_type eq 'sasl') {
            $want = $remote->AUTH_SASL;
        }
        elsif ($auth_type eq 'polkit') {
            $want = $remote->AUTH_POLKIT;
        }
        elsif ($auth_type eq 'none') {
            $want = $remote->AUTH_NONE;
        }
        else {
            die "Unknown authentication method $auth_type requested";
        }

        for my $type ( $auth_types->@* ) {
            if ($want == $type) {
                $selected = $type;
                last;
            }
        }
        die "Requested authentication method $auth_type not supported by the server"
            if not defined $selected;
    }
    else {
        $selected = shift $auth_types->@*;
    }

    $log->trace( "Selected auth method: $selected" );
    if ($selected == $remote->AUTH_POLKIT) {
        await $self->_call( $remote->PROC_AUTH_POLKIT );
        return;
    }
    if ($selected == $remote->AUTH_SASL) {
        my $mechs = await $self->_call( $remote->PROC_AUTH_SASL_INIT, {},
                                        unwrap => 'mechlist' );
        ...
    }
    return;
}


# ENTRYPOINT: REMOTE_PROC_CONNECT_OPEN
# ENTRYPOINT: REMOTE_PROC_CONNECT_REGISTER_CLOSE_CALLBACK
async method open() {
    my %parsed_url = parse_url( $_url );
    my $flags = $_readonly ? RO : 0;
    await $self->_call( $remote->PROC_CONNECT_OPEN,
                        { name => $parsed_url{name}, flags => $flags } );
    if (await $self->_supports_feature(
            $_remote->DRV_FEATURE_REMOTE_CLOSE_CALLBACK )) {
        await $self->_call( $remote->PROC_CONNECT_REGISTER_CLOSE_CALLBACK );
    }
    if (not await $self->_supports_feature(
            $_remote->DRV_FEATURE_REMOTE_EVENT_CALLBACK )) {
        die "Remote does not support REMOTE_EVENT_CALLBACK feature";
    }
}

# ENTRYPOINT: REMOTE_PROC_CONNECT_CLOSE
# ENTRYPOINT: REMOTE_PROC_CONNECT_UNREGISTER_CLOSE_CALLBACK
async method _close($reason) {
    return unless $_state eq 'CONNECTED';
    return if ($_substate eq 'CLOSING'
               or $_substate eq 'CLEANING UP');

    $_substate = 'CLEANING UP';
    unless ($_connection->is_read_eof
            or $_connection->is_write_eof) {
        # when orderly connected both for reading and writing,
        # clean up all resources the server allocated for us
        try {
            await Future->wait_all(
                (map { $_->cancel }
                 grep values $_callbacks->%*),
                (map { $_->abort }
                 grep values $_streams->%*)
                );
            $log->debug( 'Unregistering CLOSE CALLBACK' );
            await $self->_call(
                $remote->PROC_CONNECT_UNREGISTER_CLOSE_CALLBACK );

            $log->debug( 'Closing session' );
            $_substate = 'CLOSING';
            await $self->_call( $remote->PROC_CONNECT_CLOSE );

            # stop loops reading from and writing to the connection
            $_keepalive_future->cancel;
            my $timeout = $self->loop->delay_future( at => 60 ); # 60s timeout
            $timeout->on_done(
                sub {
                    $log->info( 'Server failed to close connection timely; '
                                . 'forcibly closing client socket' );
                });
            await Future->await_any( $timeout, $_pump_future );
            $_connection->close;
        }
        catch ($e) {
            $log->error( "Error during release of server resources: $e" );
        }
    }
    else {
        # stop loops reading from and writing to the connection
        $_keepalive_future->cancel;
        my $timeout = $self->loop->delay_future( at => 60 ); # 60s timeout
        $timeout->on_done(
            sub {
                $log->info( 'Server failed to close connection timely; '
                            . 'forcibly closing client socket' );
            });
        await Future->await_any( $timeout, $_pump_future );
        $_connection->close;
    }

    # These *should* have been de-allocated above; however,
    # when the connection to the server doesn't work properly
    # anymore, we want to simply discard the client side resources
    # ... the server is on its own
    if (my @callbacks = values $_callbacks->%*) {
        $log->debug( 'Cleaning up callbacks not deregistered from the server' );
        for my $cb (@callbacks) {
            # 'cleanup' cleans the items from the array
            $cb->cleanup;
        }
    }
    if (my @streams = grep values $_streams->%*) {
        $log->debug( 'Cleaning up streams not deregistered from the server' );
        for my $stream (@streams) {
            # 'cleanup' cleans the items from the array
            $stream->cleanup;
        }
    }
    if (my @replies = grep keys $_replies->%*) {
        $log->debug( 'Cleaning up (failing) on-going RPC calls' );
        for my $serial (@replies) {
            my $reply = delete $_replies->{$serial};
            $reply->fail( 'Closed before reply received' );
        }
    }

    $_state = 'DISCONNECTED';
    $_substate = '';
    $self->_dispatch_closed( $reason );
    return;
}

async method close() {
    return if $_state ne 'CONNECTED';
    await $self->_close( $self->CLOSE_REASON_CLIENT );
}

# ENTRYPOINT: REMOTE_PROC_NODE_ALLOC_PAGES
async method alloc_pages($page_counts, $start_cell, $cell_count, $flags ) {
    my $rv = await $self->_call(
        $remote->PROC_NODE_ALLOC_PAGES,
        { pageSizes  => [ map { $_->{size} } $page_counts->@* ],
          pageCounts => [ map { $_->{count} } $page_counts->@* ],
          startCell  => $start_cell,
          cellCount  => $cell_count,
          flags      => $flags } );

    return $rv->{ret};
}

# ENTRYPOINT: REMOTE_PROC_NODE_GET_CELLS_FREE_MEMORY
async method get_cells_free_memory($start_cell, $max_cells) {
    my $rv = await $self->_call(
        $remote->PROC_NODE_GET_CELLS_FREE_MEMORY,
        { startCell => $start_cell, maxcells => $max_cells } );

    return $rv->{cells};
}

# ENTRYPOINT: REMOTE_PROC_NODE_GET_CPU_MAP
async method get_cpu_map() {
    my $rv = await $self->_call(
        $remote->PROC_NODE_GET_CPU_MAP,
        { need_map => 1, need_online => 1, flags => 0 } );

    $self->{_cpus} = $rv->{ret};
    $self->{_maplen} = length($rv->{cpumap});

    return {
        totcpus => $rv->{ret},
        totonline => $rv->{online},
        maplen    => length($rv->{cpumap}),
        onlinemap => $self->_from_cpumap( $rv->{cpumap} )
    };
}

# ENTRYPOINT: REMOTE_PROC_NODE_GET_FREE_PAGES
async method get_free_pages($pages, $start_cell, $cell_count, $flags = 0) {
    my $rv = await $self->_call(
        $remote->PROC_NODE_GET_FREE_PAGES,
        { pages => $pages, startCell => $start_cell,
          cellCount => $cell_count, flags => $flags // 0 } );

    my @rv;
    my $cell_counts = [];
    while (1) {
        my $count = shift $rv->{counts}->@*;
        push $cell_counts->@*, $count;

        if (scalar($cell_counts->@*) == scalar($pages->@*)) {
            push @rv, $cell_counts;
            $cell_counts = [];
        }
        if (scalar($rv->{counts}->@*) == 0) {
            last;
        }
    }

    return \@rv;
}

async method _domain_migrate_finish($dname, $cookie, $uri, $flags = 0) {
    return await $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_FINISH,
        { dname => $dname, cookie => $cookie, uri => $uri, flags => $flags // 0 }, unwrap => 'ddom' );
}

async method _domain_migrate_finish2($dname, $cookie, $uri, $flags, $retcode) {
    return await $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_FINISH2,
        { dname => $dname, cookie => $cookie, uri => $uri, flags => $flags // 0, retcode => $retcode }, unwrap => 'ddom' );
}

method _domain_migrate_prepare_tunnel($flags, $dname, $resource, $dom_xml) {
    return $self->_call(
        $remote->PROC_DOMAIN_MIGRATE_PREPARE_TUNNEL,
        { flags => $flags // 0, dname => $dname, resource => $resource, dom_xml => $dom_xml }, stream => 'write', empty => 1 );
}

async method _supports_feature($feature) {
    return await $self->_call(
        $remote->PROC_CONNECT_SUPPORTS_FEATURE,
        { feature => $feature }, unwrap => 'supported' );
}

async method baseline_cpu($xmlCPUs, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_BASELINE_CPU,
        { xmlCPUs => $xmlCPUs, flags => $flags // 0 }, unwrap => 'cpu' );
}

async method baseline_hypervisor_cpu($emulator, $arch, $machine, $virttype, $xmlCPUs, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_BASELINE_HYPERVISOR_CPU,
        { emulator => $emulator, arch => $arch, machine => $machine, virttype => $virttype, xmlCPUs => $xmlCPUs, flags => $flags // 0 }, unwrap => 'cpu' );
}

async method compare_cpu($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_COMPARE_CPU,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'result' );
}

async method compare_hypervisor_cpu($emulator, $arch, $machine, $virttype, $xmlCPU, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_COMPARE_HYPERVISOR_CPU,
        { emulator => $emulator, arch => $arch, machine => $machine, virttype => $virttype, xmlCPU => $xmlCPU, flags => $flags // 0 }, unwrap => 'result' );
}

async method domain_create_xml($xml_desc, $flags = 0) {
    return await $self->_call(
        $remote->PROC_DOMAIN_CREATE_XML,
        { xml_desc => $xml_desc, flags => $flags // 0 }, unwrap => 'dom' );
}

async method domain_define_xml($xml) {
    return await $self->_call(
        $remote->PROC_DOMAIN_DEFINE_XML,
        { xml => $xml }, unwrap => 'dom' );
}

async method domain_define_xml_flags($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_DOMAIN_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'dom' );
}

async method domain_lookup_by_id($id) {
    return await $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_ID,
        { id => $id }, unwrap => 'dom' );
}

async method domain_lookup_by_name($name) {
    return await $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_NAME,
        { name => $name }, unwrap => 'dom' );
}

async method domain_lookup_by_uuid($uuid) {
    return await $self->_call(
        $remote->PROC_DOMAIN_LOOKUP_BY_UUID,
        { uuid => $uuid }, unwrap => 'dom' );
}

method domain_restore($from) {
    return $self->_call(
        $remote->PROC_DOMAIN_RESTORE,
        { from => $from }, empty => 1 );
}

method domain_restore_flags($from, $dxml, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_RESTORE_FLAGS,
        { from => $from, dxml => $dxml, flags => $flags // 0 }, empty => 1 );
}

async method domain_restore_params($params, $flags = 0) {
    $params = await $self->_filter_typed_param_string( $params );
    return await $self->_call(
        $remote->PROC_DOMAIN_RESTORE_PARAMS,
        { params => $params, flags => $flags // 0 }, empty => 1 );
}

method domain_save_image_define_xml($file, $dxml, $flags = 0) {
    return $self->_call(
        $remote->PROC_DOMAIN_SAVE_IMAGE_DEFINE_XML,
        { file => $file, dxml => $dxml, flags => $flags // 0 }, empty => 1 );
}

async method domain_save_image_get_xml_desc($file, $flags = 0) {
    return await $self->_call(
        $remote->PROC_DOMAIN_SAVE_IMAGE_GET_XML_DESC,
        { file => $file, flags => $flags // 0 }, unwrap => 'xml' );
}

async method domain_xml_from_native($nativeFormat, $nativeConfig, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_DOMAIN_XML_FROM_NATIVE,
        { nativeFormat => $nativeFormat, nativeConfig => $nativeConfig, flags => $flags // 0 }, unwrap => 'domainXml' );
}

async method domain_xml_to_native($nativeFormat, $domainXml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_DOMAIN_XML_TO_NATIVE,
        { nativeFormat => $nativeFormat, domainXml => $domainXml, flags => $flags // 0 }, unwrap => 'nativeConfig' );
}

async method find_storage_pool_sources($type, $srcSpec, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_FIND_STORAGE_POOL_SOURCES,
        { type => $type, srcSpec => $srcSpec, flags => $flags // 0 }, unwrap => 'xml' );
}

async method get_all_domain_stats($doms, $stats, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_ALL_DOMAIN_STATS,
        { doms => $doms, stats => $stats, flags => $flags // 0 }, unwrap => 'retStats' );
}

async method get_capabilities() {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_CAPABILITIES,
        {  }, unwrap => 'capabilities' );
}

async method get_cpu_model_names($arch, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_CPU_MODEL_NAMES,
        { arch => $arch, need_results => $remote->CPU_MODELS_MAX, flags => $flags // 0 }, unwrap => 'models' );
}

async method get_domain_capabilities($emulatorbin, $arch, $machine, $virttype, $flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_DOMAIN_CAPABILITIES,
        { emulatorbin => $emulatorbin, arch => $arch, machine => $machine, virttype => $virttype, flags => $flags // 0 }, unwrap => 'capabilities' );
}

async method get_hostname() {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_HOSTNAME,
        {  }, unwrap => 'hostname' );
}

async method get_lib_version() {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_LIB_VERSION,
        {  }, unwrap => 'lib_ver' );
}

async method get_max_vcpus($type) {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_MAX_VCPUS,
        { type => $type }, unwrap => 'max_vcpus' );
}

async method get_storage_pool_capabilities($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_STORAGE_POOL_CAPABILITIES,
        { flags => $flags // 0 }, unwrap => 'capabilities' );
}

async method get_sysinfo($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_SYSINFO,
        { flags => $flags // 0 }, unwrap => 'sysinfo' );
}

async method get_type() {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_TYPE,
        {  }, unwrap => 'type' );
}

async method get_uri() {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_URI,
        {  }, unwrap => 'uri' );
}

async method get_version() {
    return await $self->_call(
        $remote->PROC_CONNECT_GET_VERSION,
        {  }, unwrap => 'hv_ver' );
}

method interface_change_begin($flags = 0) {
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_BEGIN,
        { flags => $flags // 0 }, empty => 1 );
}

method interface_change_commit($flags = 0) {
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_COMMIT,
        { flags => $flags // 0 }, empty => 1 );
}

method interface_change_rollback($flags = 0) {
    return $self->_call(
        $remote->PROC_INTERFACE_CHANGE_ROLLBACK,
        { flags => $flags // 0 }, empty => 1 );
}

async method interface_define_xml($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_INTERFACE_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'iface' );
}

async method interface_lookup_by_mac_string($mac) {
    return await $self->_call(
        $remote->PROC_INTERFACE_LOOKUP_BY_MAC_STRING,
        { mac => $mac }, unwrap => 'iface' );
}

async method interface_lookup_by_name($name) {
    return await $self->_call(
        $remote->PROC_INTERFACE_LOOKUP_BY_NAME,
        { name => $name }, unwrap => 'iface' );
}

async method list_all_domains($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_DOMAINS,
        { need_results => $remote->DOMAIN_LIST_MAX, flags => $flags // 0 }, unwrap => 'domains' );
}

async method list_all_interfaces($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_INTERFACES,
        { need_results => $remote->INTERFACE_LIST_MAX, flags => $flags // 0 }, unwrap => 'ifaces' );
}

async method list_all_networks($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NETWORKS,
        { need_results => $remote->NETWORK_LIST_MAX, flags => $flags // 0 }, unwrap => 'nets' );
}

async method list_all_node_devices($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NODE_DEVICES,
        { need_results => $remote->NODE_DEVICE_LIST_MAX, flags => $flags // 0 }, unwrap => 'devices' );
}

async method list_all_nwfilter_bindings($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NWFILTER_BINDINGS,
        { need_results => $remote->NWFILTER_BINGING_LIST_MAX, flags => $flags // 0 }, unwrap => 'bindings' );
}

async method list_all_nwfilters($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_NWFILTERS,
        { need_results => $remote->NWFILTER_LIST_MAX, flags => $flags // 0 }, unwrap => 'filters' );
}

async method list_all_secrets($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_SECRETS,
        { need_results => $remote->SECRET_LIST_MAX, flags => $flags // 0 }, unwrap => 'secrets' );
}

async method list_all_storage_pools($flags = 0) {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_ALL_STORAGE_POOLS,
        { need_results => $remote->STORAGE_POOL_LIST_MAX, flags => $flags // 0 }, unwrap => 'pools' );
}

async method list_defined_domains() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_DOMAINS,
        { maxnames => $remote->DOMAIN_LIST_MAX }, unwrap => 'names' );
}

async method list_defined_interfaces() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_INTERFACES,
        { maxnames => $remote->INTERFACE_LIST_MAX }, unwrap => 'names' );
}

async method list_defined_networks() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_NETWORKS,
        { maxnames => $remote->NETWORK_LIST_MAX }, unwrap => 'names' );
}

async method list_defined_storage_pools() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_DEFINED_STORAGE_POOLS,
        { maxnames => $remote->STORAGE_POOL_LIST_MAX }, unwrap => 'names' );
}

async method list_domains() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_DOMAINS,
        { maxids => $remote->DOMAIN_LIST_MAX }, unwrap => 'ids' );
}

async method list_interfaces() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_INTERFACES,
        { maxnames => $remote->INTERFACE_LIST_MAX }, unwrap => 'names' );
}

async method list_networks() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_NETWORKS,
        { maxnames => $remote->NETWORK_LIST_MAX }, unwrap => 'names' );
}

async method list_nwfilters() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_NWFILTERS,
        { maxnames => $remote->NWFILTER_LIST_MAX }, unwrap => 'names' );
}

async method list_secrets() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_SECRETS,
        { maxuuids => $remote->SECRET_LIST_MAX }, unwrap => 'uuids' );
}

async method list_storage_pools() {
    return await $self->_call(
        $remote->PROC_CONNECT_LIST_STORAGE_POOLS,
        { maxnames => $remote->STORAGE_POOL_LIST_MAX }, unwrap => 'names' );
}

async method network_create_xml($xml) {
    return await $self->_call(
        $remote->PROC_NETWORK_CREATE_XML,
        { xml => $xml }, unwrap => 'net' );
}

async method network_create_xml_flags($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_NETWORK_CREATE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'net' );
}

async method network_define_xml($xml) {
    return await $self->_call(
        $remote->PROC_NETWORK_DEFINE_XML,
        { xml => $xml }, unwrap => 'net' );
}

async method network_define_xml_flags($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_NETWORK_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'net' );
}

async method network_lookup_by_name($name) {
    return await $self->_call(
        $remote->PROC_NETWORK_LOOKUP_BY_NAME,
        { name => $name }, unwrap => 'net' );
}

async method network_lookup_by_uuid($uuid) {
    return await $self->_call(
        $remote->PROC_NETWORK_LOOKUP_BY_UUID,
        { uuid => $uuid }, unwrap => 'net' );
}

async method node_get_cpu_stats($cpuNum, $flags = 0) {
    my $nparams = await $self->_call(
        $remote->PROC_NODE_GET_CPU_STATS,
        { cpuNum => $cpuNum, nparams => 0, flags => $flags // 0 }, unwrap => 'nparams' );
    return await $self->_call(
        $remote->PROC_NODE_GET_CPU_STATS,
        { cpuNum => $cpuNum, nparams => $nparams, flags => $flags // 0 }, unwrap => 'params' );
}

async method node_get_free_memory() {
    return await $self->_call(
        $remote->PROC_NODE_GET_FREE_MEMORY,
        {  }, unwrap => 'freeMem' );
}

method node_get_info() {
    return $self->_call(
        $remote->PROC_NODE_GET_INFO,
        {  } );
}

async method node_get_memory_parameters($flags = 0) {
    $flags |= await $self->_typed_param_string_okay();
    my $nparams = await $self->_call(
        $remote->PROC_NODE_GET_MEMORY_PARAMETERS,
        { nparams => 0, flags => $flags // 0 }, unwrap => 'nparams' );
    return await $self->_call(
        $remote->PROC_NODE_GET_MEMORY_PARAMETERS,
        { nparams => $nparams, flags => $flags // 0 }, unwrap => 'params' );
}

async method node_get_memory_stats($cellNum, $flags = 0) {
    my $nparams = await $self->_call(
        $remote->PROC_NODE_GET_MEMORY_STATS,
        { nparams => 0, cellNum => $cellNum, flags => $flags // 0 }, unwrap => 'nparams' );
    return await $self->_call(
        $remote->PROC_NODE_GET_MEMORY_STATS,
        { nparams => $nparams, cellNum => $cellNum, flags => $flags // 0 }, unwrap => 'params' );
}

method node_get_security_model() {
    return $self->_call(
        $remote->PROC_NODE_GET_SECURITY_MODEL,
        {  } );
}

async method node_get_sev_info($flags = 0) {
    $flags |= await $self->_typed_param_string_okay();
    my $nparams = await $self->_call(
        $remote->PROC_NODE_GET_SEV_INFO,
        { nparams => 0, flags => $flags // 0 }, unwrap => 'nparams' );
    return await $self->_call(
        $remote->PROC_NODE_GET_SEV_INFO,
        { nparams => $nparams, flags => $flags // 0 }, unwrap => 'params' );
}

async method node_list_devices($cap, $flags = 0) {
    return await $self->_call(
        $remote->PROC_NODE_LIST_DEVICES,
        { cap => $cap, maxnames => $remote->NODE_DEVICE_LIST_MAX, flags => $flags // 0 }, unwrap => 'names' );
}

async method node_num_of_devices($cap, $flags = 0) {
    return await $self->_call(
        $remote->PROC_NODE_NUM_OF_DEVICES,
        { cap => $cap, flags => $flags // 0 }, unwrap => 'num' );
}

async method node_set_memory_parameters($params, $flags = 0) {
    $params = await $self->_filter_typed_param_string( $params );
    return await $self->_call(
        $remote->PROC_NODE_SET_MEMORY_PARAMETERS,
        { params => $params, flags => $flags // 0 }, empty => 1 );
}

method node_suspend_for_duration($target, $duration, $flags = 0) {
    return $self->_call(
        $remote->PROC_NODE_SUSPEND_FOR_DURATION,
        { target => $target, duration => $duration, flags => $flags // 0 }, empty => 1 );
}

async method num_of_defined_domains() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_DOMAINS,
        {  }, unwrap => 'num' );
}

async method num_of_defined_interfaces() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_INTERFACES,
        {  }, unwrap => 'num' );
}

async method num_of_defined_networks() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_NETWORKS,
        {  }, unwrap => 'num' );
}

async method num_of_defined_storage_pools() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DEFINED_STORAGE_POOLS,
        {  }, unwrap => 'num' );
}

async method num_of_domains() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_DOMAINS,
        {  }, unwrap => 'num' );
}

async method num_of_interfaces() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_INTERFACES,
        {  }, unwrap => 'num' );
}

async method num_of_networks() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_NETWORKS,
        {  }, unwrap => 'num' );
}

async method num_of_nwfilters() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_NWFILTERS,
        {  }, unwrap => 'num' );
}

async method num_of_secrets() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_SECRETS,
        {  }, unwrap => 'num' );
}

async method num_of_storage_pools() {
    return await $self->_call(
        $remote->PROC_CONNECT_NUM_OF_STORAGE_POOLS,
        {  }, unwrap => 'num' );
}

async method nwfilter_binding_create_xml($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_NWFILTER_BINDING_CREATE_XML,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'nwfilter' );
}

async method nwfilter_binding_lookup_by_port_dev($name) {
    return await $self->_call(
        $remote->PROC_NWFILTER_BINDING_LOOKUP_BY_PORT_DEV,
        { name => $name }, unwrap => 'nwfilter' );
}

async method nwfilter_define_xml($xml) {
    return await $self->_call(
        $remote->PROC_NWFILTER_DEFINE_XML,
        { xml => $xml }, unwrap => 'nwfilter' );
}

async method nwfilter_define_xml_flags($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_NWFILTER_DEFINE_XML_FLAGS,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'nwfilter' );
}

async method nwfilter_lookup_by_name($name) {
    return await $self->_call(
        $remote->PROC_NWFILTER_LOOKUP_BY_NAME,
        { name => $name }, unwrap => 'nwfilter' );
}

async method nwfilter_lookup_by_uuid($uuid) {
    return await $self->_call(
        $remote->PROC_NWFILTER_LOOKUP_BY_UUID,
        { uuid => $uuid }, unwrap => 'nwfilter' );
}

async method secret_define_xml($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_SECRET_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'secret' );
}

async method secret_lookup_by_usage($usageType, $usageID) {
    return await $self->_call(
        $remote->PROC_SECRET_LOOKUP_BY_USAGE,
        { usageType => $usageType, usageID => $usageID }, unwrap => 'secret' );
}

async method secret_lookup_by_uuid($uuid) {
    return await $self->_call(
        $remote->PROC_SECRET_LOOKUP_BY_UUID,
        { uuid => $uuid }, unwrap => 'secret' );
}

async method set_identity($params, $flags = 0) {
    $params = await $self->_filter_typed_param_string( $params );
    return await $self->_call(
        $remote->PROC_CONNECT_SET_IDENTITY,
        { params => $params, flags => $flags // 0 }, empty => 1 );
}

async method storage_pool_create_xml($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_STORAGE_POOL_CREATE_XML,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'pool' );
}

async method storage_pool_define_xml($xml, $flags = 0) {
    return await $self->_call(
        $remote->PROC_STORAGE_POOL_DEFINE_XML,
        { xml => $xml, flags => $flags // 0 }, unwrap => 'pool' );
}

async method storage_pool_lookup_by_name($name) {
    return await $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_NAME,
        { name => $name }, unwrap => 'pool' );
}

async method storage_pool_lookup_by_target_path($path) {
    return await $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_TARGET_PATH,
        { path => $path }, unwrap => 'pool' );
}

async method storage_pool_lookup_by_uuid($uuid) {
    return await $self->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_UUID,
        { uuid => $uuid }, unwrap => 'pool' );
}

async method storage_vol_lookup_by_key($key) {
    return await $self->_call(
        $remote->PROC_STORAGE_VOL_LOOKUP_BY_KEY,
        { key => $key }, unwrap => 'vol' );
}

async method storage_vol_lookup_by_path($path) {
    return await $self->_call(
        $remote->PROC_STORAGE_VOL_LOOKUP_BY_PATH,
        { path => $path }, unwrap => 'vol' );
}


1;

__END__

=head1 NAME

Sys::Async::Virt - LibVirt protocol implementation for clients

=head1 VERSION

v0.1.3

Based on LibVirt tag v11.5.0

=head1 SYNOPSIS

  use IO::Async::Loop;
  use Sys::Async::Virt;

  my $loop = IO::Async::Loop->new;
  my $client = Sys::Async::Virt->new(url => 'qemu:///system');

  $loop->add( $client );
  await $client->connect;
  my $domains = await $client->list_all_domains;


=head1 DESCRIPTION

This module manages access to a LibVirt service through its remote protocol.

The API documentation of this module and the related modules
C<Sys::Async::Virt::*> is meant to be used in conjunction with the
documentation found at L<LibVirt's API
reference|https://libvirt.org/html/index.html>.  Since the C API is procedural
whereas the Perl API is object oriented, the mapping of API entry points isn't
one-to-one.  Each entry point links to its C API equivalent on the libvirt.org
site, enabling users to quickly find documentation.  (Please report any
broken links.)

An important difference with the C API is that this API only lists the
C<INPUT> and C<INPUT|OUTPUT (as input)> arguments for its functions.  The
C<OUTPUT> and C<INPUT|OUTPUT (as output)> arguments will be returned in the
C<on_reply> event.

=head2 Data type differences between C and Perl API

=head3 cpumap

In the C API, C<cpumap> and C<cpumaps> parameters are bitmap fields. In the
Perl API, these bitmap fields are converted to arrays of booleans:

  # use:
  $cpumap->[$cpu_index]

  # to achieve this from the C API:
  cpumap & (1 << cpu_index)

=head3 Typed parameter values

The C API returns (arrays of) typed parameters in several places. The Perl API
represents typed parameters as a hash with two keys: C<field> (a string, the
name of the parameter) and C<value>. The C<value> is itself a hash with two
keys: C<type> (indicating the type, from L<virTypedParameterType|https://libvirt.org/html/libvirt-libvirt-common.html#virTypedParameterType>)
and one of C<i>, C<ui>, C<l>, C<ul>, C<d>, C<b> or C<s>, the actual typed
value.

=head2 RUNNING AGAINST OLDER SERVERS

The reference LibVirt version of this module is v11.5.0. This means
all API entry points have been implemented as they are declared in the
protocol of that version (except for the ones listed in the section
L</UNIMPLEMENTED ENTRYPOINTS>).  The consequence of a server being of a lower
version is that some entry points will throw errors when being used, if not
supported by the server.

=head2 RUNNING AGAINST NEWER SERVERS

The module can run against any version of LibVirt newer than v11.5.0;
any new entry points in the API will not be available, but all existing APIs
can be used as per the stability guarantees.

=head2 STABILITY GUARANTEES

The modules in this distribution are considered B<experimental>, meaning that
no interface guarantees are made at this time.  However, since the protocol
description from which most of the code is generated, changes are anticipated
to be minimal.  The more feedback the project receives, the sooner the project
will be able to commit to the API as it is.

=head2 ASYNCHRONOUS INVOCATIONS

The API calls in these modules invoke remote procedure calls (RPC) on a
LibVirt server (which may run locally). The return values are L<Future>s
which can be C<await>ed using L<Future::AsyncAwait>.  Many calls start a
process on the server without awaiting the result.  One example is the
C<$domain->shutdown()> invocation: it returns when shut down has been
initiated, not when the domain is actually shut off. Other calls query
the server for state (such as C<$domain->get_state()>) and return the
state when the server replies to the invocation.

The LibVirt protocol and server support concurrent requests: requests
issued before earlier requests have finished. The server responds as soon
as the result is available. This means that server replies may come back
out-of-order, resolving futures as results become available. The use of
C<async> and C<await> help to await results from the server and continue
processing as soon as results become available.

=head1 CLIENT EVENTS

=head2 on_message

  $on_message->( @@@TODO );

Receives all messages which either don't classify as a callback invocation
(i.e. the return value structure doesn't have a C<callbackID> member), or
for which no callback has been registered through one of the callback
registration functions.

=head2 on_close

  $on_close->( $client, $reason );

=head1 LIBVIRT EVENTS

=head2 domain_event_register_any

  $cb = await $client->domain_event_register_any( $event_id, $dom = undef );

Subscribes to events of type C<$event_id>. Restricts events to a specific
domain by passing a value into C<$dom>. Please refer to the LibVirt
documentation for the L<list of available domain related
events|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainEventID>.

Returns a L<Sys::Async::Virt::Callback> instance.

Example:

  my $cb = $client->domain_event_register_any( $client->DOMAIN_EVENT_ID_LIFECYCLE );
  my $event_data = await $cb->next_event;
  # { dom => $dom, event => $event, detail => $detail }

The domain event id documentation refers to various callbacks, which are
called (in the C API) with a list of arguments. C<$event_data> will generally
contain the same values, except the C<conn> (which is
available through C<dom>) and the C<opaque> parameters. Refer to
L<virConnectDomainEventGenericCallback|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectDomainEventGenericCallback>
to compare the definition of the callback function and the returned
C<$event_data> above.

=head2 network_event_register_any

  $cb = await $client->network_event_register_any( $event_id, $net = undef );

Subscribes to events of type C<$event_id>. Restricts events to a specific
network by passing a value into C<$net>. Similar to
C<domain_event_register_any>; please refer to the LibVirt
documentation for the L<list of available network related
events|https://libvirt.org/html/libvirt-libvirt-network.html#virNetworkEventID>.

Returns a L<Sys::Async::Virt::Callback> instance.

=head2 node_device_event_register_any

  $cb = await $client->node_device_event_register_any( $event_id, $dev = undef );

Subscribes to events of type C<$event_id>. Restricts events to a specific
device by passing a value into C<$dev>. Similar to
C<domain_event_register_any>; please refer to the LibVirt
documentation for the L<list of available node device related
events|https://libvirt.org/html/libvirt-libvirt-nodedev.html#virNodeDeviceEventID>.

Returns a L<Sys::Async::Virt::Callback> instance.

=head2 secret_event_register_any

  $cb = await $client->secret_event_register_any( $event_id, $secret = undef);

Subscribes to events of type C<$event_id>. Restricts events to a specific
secret by passing a value into C<$secret>. Similar to
C<domain_event_register_any>; please refer to the LibVirt
documentation for the L<list of available secret related
events|https://libvirt.org/html/libvirt-libvirt-secret.html#virSecretEventID>.

Returns a L<Sys::Async::Virt::Callback> instance.

=head2 storage_pool_event_register_any

  $cb = await $client->storage_pool_event_register_any( $event_id, $pool = undef );

Subscribes to events of type C<$event_id>. Restricts events to a specific
storage pool by passing a value into C<$pool>. Similar to
C<domain_event_register_any>; please refer to the LibVirt
documentation for the L<list of available storage (pool) related
events|https://libvirt.org/html/libvirt-libvirt-storage.html#virStoragePoolEventID>.

Returns a L<Sys::Async::Virt::Callback> instance.

=head1 CONSTRUCTOR

=head2 new

  $client = Sys::Async::Virt->new( url => $url, ... );

Creates a new client instance.  The constructor supports these parameters:

=over 8

=item * C<factory> (optional)

An instance of L<Sys::Async::Virt::Connection::Factory> or derived class. Not
required when the C<connection> parameter is supplied.

=item * C<connection> (optional)

An instance of L<Sys::Async::Virt::Connection> or derived class.  The
C<connect> method will be called to establish the actual connection.

=item * C<transport> (optional)

An instance of L<Protocol::Sys::Virt::Transport> or derived class configured
to send the output through the C<connection> passed in.

=item * C<remote> (optional)

An instance of L<Protocol::Sys::Virt::Remote> or derived class configured
in a C<client> role.  The C<remote> will be registered with the C<tranport>
as part of the C<connect> procedure.

=item * C<keepalive> (optional)

An instance of L<Protocol::Sys::Virt::KeepAlive> or derived class configured
to reply to PING messages using a PONG message as well as closing the
C<connection> when the keepalive threshold is exceeded.

=item * C<ping_interval> (optional)

Interval in seconds between PING messages sent. Please keep in mind that the
keepalive threshold is in number of messages not responded to, meaning that
with a C<ping_interval> of 60 and a threshold of 5, it will take 5 minutes
before a dead connection will be killed, if the operating system doesn't throw
an error before it.

When not supplied, defaults to C<60>.

=item * C<url> (optional)

The URL of the hypervisor to connect to as per L<https://libvirt.org/uri.html>.

When not supplied, defaults to the environment variable C<LIBVIRT_DEFAULT_URI>.

=back

=head1 METHODS

=head2 configure

=head2 register

  $client->register( $remote );

=head2 connect

  await $client->connect( async sub pump($connection, $transport) { ... } );

Sets up the transport connection to the server, including authentication
keep alive monitoring and close callback registration.

Calls C<pump> to receive data from the C<$connection>, sending the received
data into C<$transport>. The function should throw an exception in case of
error or return in case of an C<End-Of-File (EOF)> condition.

=head2 auth

  await $client->auth( $auth_type = undef );
  # -> (* no data *)

Authenticates against the server. C<$auth_type> can be any of:

=over 8

=item * C<none>

=item * C<sasl>

=item * C<polkit>

=back

When no C<$auth_type> is passed, the first authentication method announced
by the server, is used.

=head2 is_connected

  my $bool = $client->is_connected;


=head2 is_opened

  my $bool = $client->is_opened;


=head2 is_secure

  my $bool = await $client->is_secure;


=head2 open

  await $client->open();
  # -> (* no data *)

This function opens the connection to the remote driver C<< $client->{url} >>
as passed to C< new > and documented in
L<LibVirt's Connection URIs|https://libvirt.org/uri.html>.  Note that the value
is to be the B<local> hypervisor URI as applicable to the remote end of the
connection.

=head2 close

  await $client->close;
  # -> (* no data *)

Announces to the remote the intent to close the connection. The client will
receive a confirmation message from the server after which the server will
close the connection.

=head2 alloc_pages

  $adjusted_cells = await $client->alloc_pages( $page_counts, $start_cell, $cell_count, $flags );

The C<pageSizes> and C<pageCounts> parameters of the C API have been combined into the C<$page_counts>
parameter, which is an array of hashes with a C<size> and C<count> key:

  $page_counts = [ { size => 4,    count => 800 },
                   { size => 2048, count => 400 } ];

Also see documentation of L<virNodeAllocPages|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeAllocPages>.

=head2 get_cells_free_memory

  $cell_free_mem = await $client->get_cells_free_memory( $start_cell_no, $max_cells );

Returns an array of available memory per NUMA cell starting at number C<$start_cell_no>;
returns data of at most C<$max_cells> NUMA cells.

Also see documentation of L<virNodeGetCellsFreeMemory|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetCellsFreeMemory>.

=head2 get_cpu_map

  await $client->get_cpu_map;
  # -> { maplen => $numbytes, totcpus => $cpu_count, totonline => $onl_count, onlinemap => \@online }

Returns the total number of CPUs C<$cpu_count> in the hypervisor, where the number of online
CPUs is C<$onl_count>. C<@online> is an array of length C<$cpu_count>, indicating for each CPU number
whether or not it is online.

In addition to the LibVirt and Sys::Virt APIs, this API returns C<maplen>: the length (in bytes) of CPU
maps on this hypervisor.

Also see documentation of L<virNodeGetCPUMap|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetCPUMap>.

=head2 get_free_pages

  $pages = [ 4, 2048 ];
  $free_cell_pages = await $client->get_free_pages( $pages, $start_cell, $cell_count );

Returns a reference to an array (one element per NUMA cell) of arrays with the number of
free pages of the sizes listed in C<$pages>.

Also see documentation of L<virNodeGetFreePages|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetFreePages>.

=head2 baseline_cpu

  $cpu = await $client->baseline_cpu( $xmlCPUs, $flags = 0 );

See documentation of L<virConnectBaselineCPU|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectBaselineCPU>.


=head2 baseline_hypervisor_cpu

  $cpu = await $client->baseline_hypervisor_cpu( $emulator, $arch, $machine, $virttype, $xmlCPUs, $flags = 0 );

See documentation of L<virConnectBaselineHypervisorCPU|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectBaselineHypervisorCPU>.


=head2 compare_cpu

  $result = await $client->compare_cpu( $xml, $flags = 0 );

See documentation of L<virConnectCompareCPU|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectCompareCPU>.


=head2 compare_hypervisor_cpu

  $result = await $client->compare_hypervisor_cpu( $emulator, $arch, $machine, $virttype, $xmlCPU, $flags = 0 );

See documentation of L<virConnectCompareHypervisorCPU|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectCompareHypervisorCPU>.


=head2 domain_create_xml

  $dom = await $client->domain_create_xml( $xml_desc, $flags = 0 );

See documentation of L<virDomainCreateXML|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainCreateXML>.


=head2 domain_define_xml

  $dom = await $client->domain_define_xml( $xml );

See documentation of L<virDomainDefineXML|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainDefineXML>.


=head2 domain_define_xml_flags

  $dom = await $client->domain_define_xml_flags( $xml, $flags = 0 );

See documentation of L<virDomainDefineXMLFlags|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainDefineXMLFlags>.


=head2 domain_lookup_by_id

  $dom = await $client->domain_lookup_by_id( $id );

See documentation of L<virDomainLookupByID|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainLookupByID>.


=head2 domain_lookup_by_name

  $dom = await $client->domain_lookup_by_name( $name );

See documentation of L<virDomainLookupByName|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainLookupByName>.


=head2 domain_lookup_by_uuid

  $dom = await $client->domain_lookup_by_uuid( $uuid );

See documentation of L<virDomainLookupByUUID|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainLookupByUUID>.


=head2 domain_restore

  await $client->domain_restore( $from );
  # -> (* no data *)

See documentation of L<virDomainRestore|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainRestore>.


=head2 domain_restore_flags

  await $client->domain_restore_flags( $from, $dxml, $flags = 0 );
  # -> (* no data *)

See documentation of L<virDomainRestoreFlags|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainRestoreFlags>.


=head2 domain_restore_params

  await $client->domain_restore_params( $params, $flags = 0 );
  # -> (* no data *)

See documentation of L<virDomainRestoreParams|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainRestoreParams>.


=head2 domain_save_image_define_xml

  await $client->domain_save_image_define_xml( $file, $dxml, $flags = 0 );
  # -> (* no data *)

See documentation of L<virDomainSaveImageDefineXML|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSaveImageDefineXML>.


=head2 domain_save_image_get_xml_desc

  $xml = await $client->domain_save_image_get_xml_desc( $file, $flags = 0 );

See documentation of L<virDomainSaveImageGetXMLDesc|https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSaveImageGetXMLDesc>.


=head2 domain_xml_from_native

  $domainXml = await $client->domain_xml_from_native( $nativeFormat, $nativeConfig, $flags = 0 );

See documentation of L<virConnectDomainXMLFromNative|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectDomainXMLFromNative>.


=head2 domain_xml_to_native

  $nativeConfig = await $client->domain_xml_to_native( $nativeFormat, $domainXml, $flags = 0 );

See documentation of L<virConnectDomainXMLToNative|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectDomainXMLToNative>.


=head2 find_storage_pool_sources

  $xml = await $client->find_storage_pool_sources( $type, $srcSpec, $flags = 0 );

See documentation of L<virConnectFindStoragePoolSources|https://libvirt.org/html/libvirt-libvirt-storage.html#virConnectFindStoragePoolSources>.


=head2 get_all_domain_stats

  $retStats = await $client->get_all_domain_stats( $doms, $stats, $flags = 0 );

See documentation of L<virConnectGetAllDomainStats|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectGetAllDomainStats>.


=head2 get_capabilities

  $capabilities = await $client->get_capabilities;

See documentation of L<virConnectGetCapabilities|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetCapabilities>.


=head2 get_cpu_model_names

  $models = await $client->get_cpu_model_names( $arch, $flags = 0 );

See documentation of L<virConnectGetCPUModelNames|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetCPUModelNames>.


=head2 get_domain_capabilities

  $capabilities = await $client->get_domain_capabilities( $emulatorbin, $arch, $machine, $virttype, $flags = 0 );

See documentation of L<virConnectGetDomainCapabilities|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectGetDomainCapabilities>.


=head2 get_hostname

  $hostname = await $client->get_hostname;

See documentation of L<virConnectGetHostname|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetHostname>.


=head2 get_lib_version

  $lib_ver = await $client->get_lib_version;

See documentation of L<virConnectGetLibVersion|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetLibVersion>.


=head2 get_max_vcpus

  $max_vcpus = await $client->get_max_vcpus( $type );

See documentation of L<virConnectGetMaxVcpus|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetMaxVcpus>.


=head2 get_storage_pool_capabilities

  $capabilities = await $client->get_storage_pool_capabilities( $flags = 0 );

See documentation of L<virConnectGetStoragePoolCapabilities|https://libvirt.org/html/libvirt-libvirt-storage.html#virConnectGetStoragePoolCapabilities>.


=head2 get_sysinfo

  $sysinfo = await $client->get_sysinfo( $flags = 0 );

See documentation of L<virConnectGetSysinfo|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetSysinfo>.


=head2 get_type

  $type = await $client->get_type;

See documentation of L<virConnectGetType|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetType>.


=head2 get_uri

  $uri = await $client->get_uri;

See documentation of L<virConnectGetURI|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetURI>.


=head2 get_version

  $hv_ver = await $client->get_version;

See documentation of L<virConnectGetVersion|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectGetVersion>.


=head2 interface_change_begin

  await $client->interface_change_begin( $flags = 0 );
  # -> (* no data *)

See documentation of L<virInterfaceChangeBegin|https://libvirt.org/html/libvirt-libvirt-interface.html#virInterfaceChangeBegin>.


=head2 interface_change_commit

  await $client->interface_change_commit( $flags = 0 );
  # -> (* no data *)

See documentation of L<virInterfaceChangeCommit|https://libvirt.org/html/libvirt-libvirt-interface.html#virInterfaceChangeCommit>.


=head2 interface_change_rollback

  await $client->interface_change_rollback( $flags = 0 );
  # -> (* no data *)

See documentation of L<virInterfaceChangeRollback|https://libvirt.org/html/libvirt-libvirt-interface.html#virInterfaceChangeRollback>.


=head2 interface_define_xml

  $iface = await $client->interface_define_xml( $xml, $flags = 0 );

See documentation of L<virInterfaceDefineXML|https://libvirt.org/html/libvirt-libvirt-interface.html#virInterfaceDefineXML>.


=head2 interface_lookup_by_mac_string

  $iface = await $client->interface_lookup_by_mac_string( $mac );

See documentation of L<virInterfaceLookupByMACString|https://libvirt.org/html/libvirt-libvirt-interface.html#virInterfaceLookupByMACString>.


=head2 interface_lookup_by_name

  $iface = await $client->interface_lookup_by_name( $name );

See documentation of L<virInterfaceLookupByName|https://libvirt.org/html/libvirt-libvirt-interface.html#virInterfaceLookupByName>.


=head2 list_all_domains

  $domains = await $client->list_all_domains( $flags = 0 );

See documentation of L<virConnectListAllDomains|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectListAllDomains>.


=head2 list_all_interfaces

  $ifaces = await $client->list_all_interfaces( $flags = 0 );

See documentation of L<virConnectListAllInterfaces|https://libvirt.org/html/libvirt-libvirt-interface.html#virConnectListAllInterfaces>.


=head2 list_all_networks

  $nets = await $client->list_all_networks( $flags = 0 );

See documentation of L<virConnectListAllNetworks|https://libvirt.org/html/libvirt-libvirt-network.html#virConnectListAllNetworks>.


=head2 list_all_node_devices

  $devices = await $client->list_all_node_devices( $flags = 0 );

See documentation of L<virConnectListAllNodeDevices|https://libvirt.org/html/libvirt-libvirt-nodedev.html#virConnectListAllNodeDevices>.


=head2 list_all_nwfilter_bindings

  $bindings = await $client->list_all_nwfilter_bindings( $flags = 0 );

See documentation of L<virConnectListAllNWFilterBindings|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virConnectListAllNWFilterBindings>.


=head2 list_all_nwfilters

  $filters = await $client->list_all_nwfilters( $flags = 0 );

See documentation of L<virConnectListAllNWFilters|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virConnectListAllNWFilters>.


=head2 list_all_secrets

  $secrets = await $client->list_all_secrets( $flags = 0 );

See documentation of L<virConnectListAllSecrets|https://libvirt.org/html/libvirt-libvirt-secret.html#virConnectListAllSecrets>.


=head2 list_all_storage_pools

  $pools = await $client->list_all_storage_pools( $flags = 0 );

See documentation of L<virConnectListAllStoragePools|https://libvirt.org/html/libvirt-libvirt-storage.html#virConnectListAllStoragePools>.


=head2 list_defined_domains

  $names = await $client->list_defined_domains;

See documentation of L<virConnectListDefinedDomains|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectListDefinedDomains>.


=head2 list_defined_interfaces

  $names = await $client->list_defined_interfaces;

See documentation of L<virConnectListDefinedInterfaces|https://libvirt.org/html/libvirt-libvirt-interface.html#virConnectListDefinedInterfaces>.


=head2 list_defined_networks

  $names = await $client->list_defined_networks;

See documentation of L<virConnectListDefinedNetworks|https://libvirt.org/html/libvirt-libvirt-network.html#virConnectListDefinedNetworks>.


=head2 list_defined_storage_pools

  $names = await $client->list_defined_storage_pools;

See documentation of L<virConnectListDefinedStoragePools|https://libvirt.org/html/libvirt-libvirt-storage.html#virConnectListDefinedStoragePools>.


=head2 list_domains

  $ids = await $client->list_domains;

See documentation of L<virConnectListDomains|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectListDomains>.


=head2 list_interfaces

  $names = await $client->list_interfaces;

See documentation of L<virConnectListInterfaces|https://libvirt.org/html/libvirt-libvirt-interface.html#virConnectListInterfaces>.


=head2 list_networks

  $names = await $client->list_networks;

See documentation of L<virConnectListNetworks|https://libvirt.org/html/libvirt-libvirt-network.html#virConnectListNetworks>.


=head2 list_nwfilters

  $names = await $client->list_nwfilters;

See documentation of L<virConnectListNWFilters|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virConnectListNWFilters>.


=head2 list_secrets

  $uuids = await $client->list_secrets;

See documentation of L<virConnectListSecrets|https://libvirt.org/html/libvirt-libvirt-secret.html#virConnectListSecrets>.


=head2 list_storage_pools

  $names = await $client->list_storage_pools;

See documentation of L<virConnectListStoragePools|https://libvirt.org/html/libvirt-libvirt-storage.html#virConnectListStoragePools>.


=head2 network_create_xml

  $net = await $client->network_create_xml( $xml );

See documentation of L<virNetworkCreateXML|https://libvirt.org/html/libvirt-libvirt-network.html#virNetworkCreateXML>.


=head2 network_create_xml_flags

  $net = await $client->network_create_xml_flags( $xml, $flags = 0 );

See documentation of L<virNetworkCreateXMLFlags|https://libvirt.org/html/libvirt-libvirt-network.html#virNetworkCreateXMLFlags>.


=head2 network_define_xml

  $net = await $client->network_define_xml( $xml );

See documentation of L<virNetworkDefineXML|https://libvirt.org/html/libvirt-libvirt-network.html#virNetworkDefineXML>.


=head2 network_define_xml_flags

  $net = await $client->network_define_xml_flags( $xml, $flags = 0 );

See documentation of L<virNetworkDefineXMLFlags|https://libvirt.org/html/libvirt-libvirt-network.html#virNetworkDefineXMLFlags>.


=head2 network_lookup_by_name

  $net = await $client->network_lookup_by_name( $name );

See documentation of L<virNetworkLookupByName|https://libvirt.org/html/libvirt-libvirt-network.html#virNetworkLookupByName>.


=head2 network_lookup_by_uuid

  $net = await $client->network_lookup_by_uuid( $uuid );

See documentation of L<virNetworkLookupByUUID|https://libvirt.org/html/libvirt-libvirt-network.html#virNetworkLookupByUUID>.


=head2 node_get_cpu_stats

  $params = await $client->node_get_cpu_stats( $cpuNum, $flags = 0 );

See documentation of L<virNodeGetCPUStats|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetCPUStats>.


=head2 node_get_free_memory

  $freeMem = await $client->node_get_free_memory;

See documentation of L<virNodeGetFreeMemory|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetFreeMemory>.


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

See documentation of L<virNodeGetInfo|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetInfo>.


=head2 node_get_memory_parameters

  $params = await $client->node_get_memory_parameters( $flags = 0 );

See documentation of L<virNodeGetMemoryParameters|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetMemoryParameters>.


=head2 node_get_memory_stats

  $params = await $client->node_get_memory_stats( $cellNum, $flags = 0 );

See documentation of L<virNodeGetMemoryStats|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetMemoryStats>.


=head2 node_get_security_model

  await $client->node_get_security_model;
  # -> { doi => $doi, model => $model }

See documentation of L<virNodeGetSecurityModel|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetSecurityModel>.


=head2 node_get_sev_info

  $params = await $client->node_get_sev_info( $flags = 0 );

See documentation of L<virNodeGetSEVInfo|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeGetSEVInfo>.


=head2 node_list_devices

  $names = await $client->node_list_devices( $cap, $flags = 0 );

See documentation of L<virNodeListDevices|https://libvirt.org/html/libvirt-libvirt-nodedev.html#virNodeListDevices>.


=head2 node_num_of_devices

  $num = await $client->node_num_of_devices( $cap, $flags = 0 );

See documentation of L<virNodeNumOfDevices|https://libvirt.org/html/libvirt-libvirt-nodedev.html#virNodeNumOfDevices>.


=head2 node_set_memory_parameters

  await $client->node_set_memory_parameters( $params, $flags = 0 );
  # -> (* no data *)

See documentation of L<virNodeSetMemoryParameters|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeSetMemoryParameters>.


=head2 node_suspend_for_duration

  await $client->node_suspend_for_duration( $target, $duration, $flags = 0 );
  # -> (* no data *)

See documentation of L<virNodeSuspendForDuration|https://libvirt.org/html/libvirt-libvirt-host.html#virNodeSuspendForDuration>.


=head2 num_of_defined_domains

  $num = await $client->num_of_defined_domains;

See documentation of L<virConnectNumOfDefinedDomains|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectNumOfDefinedDomains>.


=head2 num_of_defined_interfaces

  $num = await $client->num_of_defined_interfaces;

See documentation of L<virConnectNumOfDefinedInterfaces|https://libvirt.org/html/libvirt-libvirt-interface.html#virConnectNumOfDefinedInterfaces>.


=head2 num_of_defined_networks

  $num = await $client->num_of_defined_networks;

See documentation of L<virConnectNumOfDefinedNetworks|https://libvirt.org/html/libvirt-libvirt-network.html#virConnectNumOfDefinedNetworks>.


=head2 num_of_defined_storage_pools

  $num = await $client->num_of_defined_storage_pools;

See documentation of L<virConnectNumOfDefinedStoragePools|https://libvirt.org/html/libvirt-libvirt-storage.html#virConnectNumOfDefinedStoragePools>.


=head2 num_of_domains

  $num = await $client->num_of_domains;

See documentation of L<virConnectNumOfDomains|https://libvirt.org/html/libvirt-libvirt-domain.html#virConnectNumOfDomains>.


=head2 num_of_interfaces

  $num = await $client->num_of_interfaces;

See documentation of L<virConnectNumOfInterfaces|https://libvirt.org/html/libvirt-libvirt-interface.html#virConnectNumOfInterfaces>.


=head2 num_of_networks

  $num = await $client->num_of_networks;

See documentation of L<virConnectNumOfNetworks|https://libvirt.org/html/libvirt-libvirt-network.html#virConnectNumOfNetworks>.


=head2 num_of_nwfilters

  $num = await $client->num_of_nwfilters;

See documentation of L<virConnectNumOfNWFilters|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virConnectNumOfNWFilters>.


=head2 num_of_secrets

  $num = await $client->num_of_secrets;

See documentation of L<virConnectNumOfSecrets|https://libvirt.org/html/libvirt-libvirt-secret.html#virConnectNumOfSecrets>.


=head2 num_of_storage_pools

  $num = await $client->num_of_storage_pools;

See documentation of L<virConnectNumOfStoragePools|https://libvirt.org/html/libvirt-libvirt-storage.html#virConnectNumOfStoragePools>.


=head2 nwfilter_binding_create_xml

  $nwfilter = await $client->nwfilter_binding_create_xml( $xml, $flags = 0 );

See documentation of L<virNWFilterBindingCreateXML|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virNWFilterBindingCreateXML>.


=head2 nwfilter_binding_lookup_by_port_dev

  $nwfilter = await $client->nwfilter_binding_lookup_by_port_dev( $name );

See documentation of L<virNWFilterBindingLookupByPortDev|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virNWFilterBindingLookupByPortDev>.


=head2 nwfilter_define_xml

  $nwfilter = await $client->nwfilter_define_xml( $xml );

See documentation of L<virNWFilterDefineXML|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virNWFilterDefineXML>.


=head2 nwfilter_define_xml_flags

  $nwfilter = await $client->nwfilter_define_xml_flags( $xml, $flags = 0 );

See documentation of L<virNWFilterDefineXMLFlags|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virNWFilterDefineXMLFlags>.


=head2 nwfilter_lookup_by_name

  $nwfilter = await $client->nwfilter_lookup_by_name( $name );

See documentation of L<virNWFilterLookupByName|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virNWFilterLookupByName>.


=head2 nwfilter_lookup_by_uuid

  $nwfilter = await $client->nwfilter_lookup_by_uuid( $uuid );

See documentation of L<virNWFilterLookupByUUID|https://libvirt.org/html/libvirt-libvirt-nwfilter.html#virNWFilterLookupByUUID>.


=head2 secret_define_xml

  $secret = await $client->secret_define_xml( $xml, $flags = 0 );

See documentation of L<virSecretDefineXML|https://libvirt.org/html/libvirt-libvirt-secret.html#virSecretDefineXML>.


=head2 secret_lookup_by_usage

  $secret = await $client->secret_lookup_by_usage( $usageType, $usageID );

See documentation of L<virSecretLookupByUsage|https://libvirt.org/html/libvirt-libvirt-secret.html#virSecretLookupByUsage>.


=head2 secret_lookup_by_uuid

  $secret = await $client->secret_lookup_by_uuid( $uuid );

See documentation of L<virSecretLookupByUUID|https://libvirt.org/html/libvirt-libvirt-secret.html#virSecretLookupByUUID>.


=head2 set_identity

  await $client->set_identity( $params, $flags = 0 );
  # -> (* no data *)

See documentation of L<virConnectSetIdentity|https://libvirt.org/html/libvirt-libvirt-host.html#virConnectSetIdentity>.


=head2 storage_pool_create_xml

  $pool = await $client->storage_pool_create_xml( $xml, $flags = 0 );

See documentation of L<virStoragePoolCreateXML|https://libvirt.org/html/libvirt-libvirt-storage.html#virStoragePoolCreateXML>.


=head2 storage_pool_define_xml

  $pool = await $client->storage_pool_define_xml( $xml, $flags = 0 );

See documentation of L<virStoragePoolDefineXML|https://libvirt.org/html/libvirt-libvirt-storage.html#virStoragePoolDefineXML>.


=head2 storage_pool_lookup_by_name

  $pool = await $client->storage_pool_lookup_by_name( $name );

See documentation of L<virStoragePoolLookupByName|https://libvirt.org/html/libvirt-libvirt-storage.html#virStoragePoolLookupByName>.


=head2 storage_pool_lookup_by_target_path

  $pool = await $client->storage_pool_lookup_by_target_path( $path );

See documentation of L<virStoragePoolLookupByTargetPath|https://libvirt.org/html/libvirt-libvirt-storage.html#virStoragePoolLookupByTargetPath>.


=head2 storage_pool_lookup_by_uuid

  $pool = await $client->storage_pool_lookup_by_uuid( $uuid );

See documentation of L<virStoragePoolLookupByUUID|https://libvirt.org/html/libvirt-libvirt-storage.html#virStoragePoolLookupByUUID>.


=head2 storage_vol_lookup_by_key

  $vol = await $client->storage_vol_lookup_by_key( $key );

See documentation of L<virStorageVolLookupByKey|https://libvirt.org/html/libvirt-libvirt-storage.html#virStorageVolLookupByKey>.


=head2 storage_vol_lookup_by_path

  $vol = await $client->storage_vol_lookup_by_path( $path );

See documentation of L<virStorageVolLookupByPath|https://libvirt.org/html/libvirt-libvirt-storage.html#virStorageVolLookupByPath>.



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

=item GET_DOMAIN_CAPABILITIES_DISABLE_DEPRECATED_FEATURES

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

=item DOMAIN_EVENT_ID_NIC_MAC_CHANGE

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

=item LIST_NODE_DEVICES_CAP_CCWGROUP_DEV

=item LIST_NODE_DEVICES_CAP_CCWGROUP_MEMBER

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
wrapper allows for tracking all calls allowing to set up handling of the
replies.

=head2 _send

=head2 _send_end

=head2 _dispatch_message

=head2 _dispatch_reply

=head2 _dispatch_stream

=head2 _domain_migrate_finish

=head2 _domain_migrate_finish2

=head2 _domain_migrate_prepare_tunnel

=head2 _supports_feature



=head1 BUGS AND LIMITATIONS

=over 8

=item * Talking to servers without the MIGRATION_PARAM feature
 (v1.1.0 - 2013-07-01) is not - currently - supported

=begin fill-templates

# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PREPARE
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_BEGIN
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PERFORM
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_CONFIRM
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_FINISH

# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PREPARE2
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_BEGIN2
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PERFORM2
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_CONFIRM2
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_FINISH2

# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PREPARE3
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_BEGIN3
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PERFORM3
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_CONFIRM3
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_FINISH3

# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PREPARE_TUNNEL
# ENTRYPOINT: REMOTE_PROC_DOMAIN_MIGRATE_PREPARE_TUNNEL3

=end fill-templates

=item * Talking to servers without the REMOTE_EVENT_CALLBACK feature
 (v1.3.3 - 2016-04-06) is not - currently - supported

=begin fill-templates

# ENTRYPOINT: REMOTE_PROC_CONNECT_DOMAIN_EVENT_DEREGISTER
# ENTRYPOINT: REMOTE_PROC_CONNECT_DOMAIN_EVENT_DEREGISTER_ANY
# ENTRYPOINT: REMOTE_PROC_CONNECT_DOMAIN_EVENT_REGISTER
# ENTRYPOINT: REMOTE_PROC_CONNECT_DOMAIN_EVENT_REGISTER_ANY

=end fill-templates

=back

=head2 TODO

=over 8

=item * Sort interaction between C<connect> and C<auth> methods

Currently, C<connect> always calls C<auth>, which makes having a public
C<auth> method rather pointless.

=item * Modules implementing connections for various protocols (tcp, tls, etc)

=item * C<@generate: none> entrypoints review (and implement relevant ones)

=item * libvirt client configuration (C</etc/libvirt/libvirt.conf> (for C<root>)
 or C<$XDG_CONFIG_HOME/libvirt/libvirt.conf> (for other users))

=back

=head2 UNIMPLEMENTED ENTRYPOINTS

The following entrypoints have not been implemented yet; contributions
towards implementation are greatly appreciated.

=over 8

=over 8

=item * @generate: none

=over 8

=item * REMOTE_PROC_AUTH_SASL_START

=item * REMOTE_PROC_AUTH_SASL_STEP

=back



=item * @generate: none (include/libvirt/libvirt-domain.h)

=over 8

=item * REMOTE_PROC_DOMAIN_CREATE_WITH_FILES

=item * REMOTE_PROC_DOMAIN_CREATE_XML_WITH_FILES

=item * REMOTE_PROC_DOMAIN_FD_ASSOCIATE

=item * REMOTE_PROC_DOMAIN_OPEN_GRAPHICS

=item * REMOTE_PROC_DOMAIN_OPEN_GRAPHICS_FD

=back



=item * @generate: none (src/libvirt_internal.h)

=over 8

=item * REMOTE_PROC_DOMAIN_MIGRATE_BEGIN3_PARAMS

=item * REMOTE_PROC_DOMAIN_MIGRATE_CONFIRM3_PARAMS

=item * REMOTE_PROC_DOMAIN_MIGRATE_FINISH3_PARAMS

=item * REMOTE_PROC_DOMAIN_MIGRATE_PERFORM3_PARAMS

=item * REMOTE_PROC_DOMAIN_MIGRATE_PREPARE3_PARAMS

=back



=back

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

  Copyright (C) 2024-2025 Erik Huelsmann

All rights reserved. This program is free software;
you can redistribute it and/or modify it under the same terms as Perl itself.
