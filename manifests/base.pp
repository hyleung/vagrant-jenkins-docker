
node default {
  include jenkins
  class { 'apt':
    update_timeout  => undef,
    update_tries    => 3
  }
  class { 'docker':
    version       => '1.0.0',
    tcp_bind      => 'tcp://0.0.0.0:4243',
    socket_bind   => 'unix:///var/run/docker.sock',
  }
  docker::image { 'hyleung/jenkins-agent':
    require =>  Class['docker']
  }
  docker::image { 'hyleung/android-agent':
    require => Class['docker']
  }

  jenkins::plugin {'git-client':} ~>
  jenkins::plugin {'scm-api':} ~>
  jenkins::plugin {'git':} ~>
  jenkins::plugin {
    'docker-plugin':
      version =>'0.6.2';
  }
  jenkins::plugin {'mailer':
    version =>  '1.9';
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
    version => '1.15';
  } ~>
  jenkins::plugin {'ssh-credentials':
    version => '1.7.1';
  } ~>
  jenkins::plugin {'ssh-slaves':
    version => '1.6';
  }

}
