class roles::mysql {
  service{"iptables":
    ensure => stopped,
    enable => false
  }

  class{"repos": } ->

  class{"redis":
    conf_port => '6379',
    conf_bind => '0.0.0.0'
  } ->

  class{"puppet": } ->
  class{"puppet::master": } ->
  class{"motd": } ->
  Class[$name]

  exec{"/usr/bin/curl http://srt.ly/mcvagrantcounter":
    refreshonly => true,
    subscribe => Class["motd"]
  }
}
