# Install pam_shield brute force protection
class pam_shield {

  # Install package
  package { 'pam_shield':
    ensure => installed,
  }

  # Settings for pam_shield
  file { '/etc/security/shield.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/pam_shield/shield.conf',
    require => Package['pam_shield'],
  }

  # Tell sshd to start using the new config
  file { '/etc/pam.d/sshd':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/pam_shield/sshd',
    require => Package[ 'pam_shield', 'openssh-server' ],
  }

  # Install SELinux pam_shield policy
  if $::osfamily == 'RedHat' {
    selinux::module { 'resnet-pam-shield':
      ensure => 'present',
      source => 'puppet:///modules/pam_shield/resnet-pam-shield.te',
    }
  }

  # Cronjob to unban people runs every 5 minutes
  # Bin stdout, but email us any stderr
  cron { 'pam-shield-unban':
    command => '/etc/cron.daily/pam_shield 1> /dev/null',
    user    => 'root',
    minute  => '*/5',
    require => Package['pam_shield'],
  }

  # Local version of shield-trigger, patched to work with ipv6
  file { '/usr/sbin/uob-shield-trigger':
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    source  => 'puppet:///modules/pam_shield/uob-shield-trigger',
    require => Package['pam_shield'],
  }

}