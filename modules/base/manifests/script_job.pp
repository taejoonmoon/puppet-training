# define test
define base::script_job ( $hour = '00' ) {
		include base
		file { "/usr/local/bin/${name}":
			source => "puppet:///modules/base/${name}",
			mode => '0755',
		}
		cron { "Run ${name}":
			command => "/usr/local/bin/${name}",
			hour => $hour,
			minute => '00',
			user => 'vagrant',
		}
}
