
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
  docker::image { 'evarga/jenkins-slave':
    require => Class['docker']
  }
  jenkins::plugin {'git-client':} ~>
  jenkins::plugin {'scm-api':} ~>
  jenkins::plugin {'git':} ~>
  
  file { '/var/lib/jenkins/plugins/docker-plugin.hpi':
    source => '/vagrant/files/docker-plugin.hpi'
  }
  #jenkins::plugin {
  #  'docker-plugin':
  #    version =>'0.6';
  #}
}
