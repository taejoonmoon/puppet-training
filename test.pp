# file test
file { '/tmp/hello':
		content => "Hello, world\n",
}
file { '/etc/motd':
		content => "Welcome to your Vagrant-built virtual machine!
		Managed by Puppet.\n"
}


# package test
package { 'httpd':
        ensure  => installed,
}

# service test
service { 'httpd':
        ensure  => running,
        enable  => true,
        require => Package['httpd'],
}
        

# user test
user { 'art':
	ensure  => present,
	comment => 'my art',
	home => '/home/art',
	managehome => true,
}

ssh_authorized_key { 'art_ssh':
	user => 'art',
	type => 'rsa',
	key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAx2YcCaWdje2qMnORcpl1elFX83PS5Oq2oSyvPRKEcJwy5Jdcu2n4sSoWCicIpu8EbxkcWcGajuVnRrWyDOa06h40fVaDwxHKuSOu9/Av4hAR8XzjIPX7ag4egmhXT6Gt5LVdc5N2cKvjpnDBlLdwG/1YkZGB2ThWYaI4OxSPbAm3MPD0iA7Wl/X1yO8rfOcUQSdrCkq6j8pjXXBuNnk5WTyECo6IAUI4q6o3RLPhCvyb8EJze/b3EzhSWlnuYI5zxKf8qqpKoosdWOVWp3QtJmKt1A0+KNq8xJIW2uoA9TTOWOBFgR9am7qRuNYHm8KQuTJTHsYguH8xtSS/34I2NQ==',
}

# exec test
exec { 'Run my arbitray command':
	command => '/bin/echo I ran this command on `/bin/date` > /tmp/command.output.txt',
	#creates => '/tmp/command.output.txt',
	#unless  => '/usr/bin/test -f /tmp/command.output.txt',
	#onlyif  => '/usr/bin/test -f /tmp/command.output.txt',
	#path => ['bin','/usr/bin'],
}

exec { 'command-1':
	command => '/bin/touch /tmp/step1 && /bin/echo Step 1',
	#creates => '/tmp/step1',
	unless  => '/usr/bin/test -f /tmp/step1',
}

exec { 'command-2':
	command => '/bin/echo Step 2',
	require => Exec['command-1'],
}

# cron test
cron { 'test cron':
	command => 'touch /tmp/testcron',
	hour	  => '04',
	minute  => '00',
	user => 'vagrant',
}

# array test
package { ['lynx','mc','traceroute']:
	ensure => installed,
}
