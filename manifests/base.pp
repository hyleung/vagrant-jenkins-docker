
node default {
  include jenkins
  class { 'apt':
    update_timeout  => undef,
    update_tries    => 3
  }

  #Packages
  package {'git':
    ensure => present;
  }
  #NGINX
  class { 'nginx': }
  #Docker
  class { 'docker':
    version       => '1.2.0',
    tcp_bind      => 'tcp://0.0.0.0:4243',
    socket_bind   => 'unix:///var/run/docker.sock',
  }
  docker::image { 'hyleung/jenkins-agent':
    require =>  Class['docker']
  }
  docker::image { 'hyleung/android-agent':
    require => Class['docker']
  }

  #Jenkins user
  group { 'jenkins':
    ensure => present;
  } ->
  user {'jenkins':
    ensure => present,
    managehome => true,
    gid => 'jenkins',
    groups => 'sudo'
  } ->
  ssh_keygen { 'jenkins': }

  #Jenkins plugins
  jenkins::plugin {'git-client':} ~>
  jenkins::plugin {'scm-api':} ~>
  jenkins::plugin {'git':} ~>
  jenkins::plugin {
    'docker-plugin':
      version =>'0.7';
  }
  jenkins::plugin {'mailer':
    version =>  '1.10';
  } ~>
  jenkins::plugin {'openid4java':
    version => '0.9.8.0';
  } ~>
  jenkins::plugin {'openid':
    version => '2.1';
  }
  jenkins::plugin {'hockeyapp':
    version => '1.1.0';
  }
  jenkins::plugin {'gradle':
    version => '1.24';
  }
  jenkins::plugin {'credentials':
    version => '1.16.1';
  } ~>
  jenkins::plugin {'ssh-credentials':
    version => '1.9';
  } ~>
  jenkins::plugin {'ssh-slaves':
    version => '1.6';
  } ~>
  jenkins::plugin {'build-monitor-plugin':
    version => '1.5+build.120';
  }
  jenkins::plugin {'git-server':
    version => '1.3';
  } ~>
  jenkins::plugin {'scriptler':
    version => '2.2';
  } ~>
  jenkins::plugin {'token-macro':
    version => '1.5.1';
  } ~>
  jenkins::plugin {'dynamicparameter':
    version => '0.2.0';
  } 

  file{ '/var/dockervolume':
    ensure => directory,
    mode   => 'a+w';
  }
  	
}
