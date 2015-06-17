# Manage NTP server
class ntp($server='UNSET') {
	package { 'ntp':
		ensure => installed,
	}

	file { '/etc/ntp.conf':
		content => template('ntp/ntp.conf.erb'),
		notify => Service['ntp'],
	}

	service { 'ntp':
		name => 'ntpd',
		ensure => running,
		enable => true,
		require => [ Package['ntp'], File['/etc/ntp.conf'] ],
	}
}
