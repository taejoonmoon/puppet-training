class apache {
	package { 'nginx':
		ensure => absent,
	}

	package { 'httpd':
		ensure  => installed,
		require => Package['nginx'],
	}
	
	service { 'httpd':
		ensure  => running,
		enable  => true,
		require => Package['httpd'],
	}
	
	file { '/etc/httpd/conf.d/default.conf':
		source => 'puppet:///modules/apache/default.conf',
		notify => Service['httpd'],
	}

	file { '/var/www/html/index.html':
		source => 'puppet:///modules/apache/index.html',
	}
	
	# template test
	$vhost_port = "8080"
	$site_name = 'example.com'
	file { '/etc/httpd/conf.d/example.com.conf':
		content => template('apache/vhost.conf.erb'),
		notify => Service['httpd'],
	}

}
