# puppet node file
# managed by taejoon moon
node 'vagrant-centos64.vagrantup.com' {

	include apache
	include base
	
#	include ntp
#	class { 'ntp':
#		server => 'us.pool.ntp.org',
#	}

  base::script_job { 'backup_database1':
    hour => '05',
  }
}
