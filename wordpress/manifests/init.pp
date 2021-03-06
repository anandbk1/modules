exec {'apt update': 
   path => '/usr/bin'
}

$packagenames = ['apache2', 'mysql-server', 'mysql-client', 'php', 'libapache2-mod-php', 'php-mcrypt', 'php-mysql', 'unzip']
$packagenames.each |String $package| {
package {"${package}":
 ensure => latest,
 }
}

user { 'mysqladmin':
 ensure => present,
 password => 'rootpassword',
}

exec {'wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands':
     cwd => '/tmp',	
     path => '/usr/bin',
     creates => '/tmp/mysqlcommands',	
}

exec {'sudo mysql -uroot -prootpassword < /tmp/mysqlcommands':
   path => '/usr/bin'
}

exec {'wget https://wordpress.org/latest.zip':
    cwd => '/tmp',
    path => '/usr/bin',
    creates => '/tmp/latest.zip',
}

exec {'unzip /tmp/latest.zip -d /var/www/html':
         path => '/usr/bin',
         creates => '/var/www/html/wordpress',
}

exec {'wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php':
    cwd => '/var/www/html/wordpress',
    path => '/usr/bin',
    creates => '/var/www/html/wordpress/wp-config-sample.php',
}

file {'/var/www/html/wordpress/wp-config.php':
   ensure => present,
   source => '/var/www/html/wordpress/wp-config-sample.php',
}

file { '/var/www/html/wordpress':
  mode => '775',
  recurse => true,
  owner => 'www-data',
}

#exec {"sed -i 's/database_name_here/wordpress/' /var/www/html/wordpress/wp-config.php":
#    path => '/bin',
#}

#exec {"sed -i 's/username_here/wordpressuser/' /var/www/html/wordpress/wp-config.php":
#    path => '/bin',
#}

#exec {"sed -i 's/password_here/password/' /var/www/html/wordpress/wp-config.php":
#    path => '/bin',
#}

exec {'service apache2 restart':
	            path => ['/usr/sbin', '/usr/bin', '/bin', '/sbin'],
}

