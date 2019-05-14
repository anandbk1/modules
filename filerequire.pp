file{'/tmp/file1':
  ensure => present,
  require => File['/tmp/file2']
  }
  
file{'/tmp/file2':
  ensure => present, 
  require => File['/tmp/file3']
  }
 
file{'/tmp/file3':
  ensure => present, 
  require => File['/tmp/file4']
  }
  
  
file{'/tmp/file4':
  ensure => present, 
  require => File['/tmp/file5']
  }

file{'/tmp/file5':
  ensure => present, 
  }
