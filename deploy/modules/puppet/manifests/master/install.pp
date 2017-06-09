class puppet::master::install {
	package{'puppet-server':
        ensure => 'lastest'
    }
}
