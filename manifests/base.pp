
node default {
  include jenkins
  class { 'apt':
    update_timeout  => undef,
    update_tries    => 3
  }
  class { 'docker':
    tcp_bind    => 'tcp://127.0.0.1:4243',
    socket_bind => 'unix:///var/run/docker.sock',
  }
  docker::image { 'hyleung/jenkins-agent':
    require =>  Class['docker']
  }
  docker::image { 'hyleung/android-agent':
    require => Class['docker']
  }
  jenkins::plugin {'git-client':} ~>
  jenkins::plugin {'scm-api':} ~>
  jenkins::plugin {'git':}
  jenkins::plugin {
    'docker-plugin':
      version =>'0.6'
  }
}
