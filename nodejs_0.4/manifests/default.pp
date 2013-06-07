package { 'git':
    ensure => present
}

package { 'curl':
    ensure => present
}

package {'gcc':
    ensure => present
}

package {'build-essential':
    ensure => present
}

package {'openssl':
    ensure => present
}

package {'libssl-dev':
    ensure => present
}

package {'libyaml-dev':
    ensure => present
}

package {'memcached':
    ensure => present
}

exec { 'install-nvm':
    command =>  'su -l vagrant -c "wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh"',
    creates => '/home/vagrant/.nvm',
    path    => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
    require => Package['curl']
}

exec { 'install-node-4':
    command =>  'su -l vagrant -c "nvm install 0.4"',
    creates => '/home/vagrant/.nvm/v0.4.12/bin/node',
    path    => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
    timeout => 0,
    require => [
        Package['openssl'], 
        Package['libssl-dev'], 
        Package['build-essential'], 
        Package['gcc'], 
        Package['libyaml-dev'], 
        Package['memcached'], 
        Exec['install-nvm']
    ]
}

exec { 'select-node-4':
    command => 'su -l vagrant -c "nvm alias default 0.4"',
    path    => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
    creates => '/home/vagrant/.nvm/alias/default',
    require => Exec['install-node-4']
}
