file{'/tmp/file1':
  ensure => present }
  
file{'/tmp/file2':
  ensure => present, 
  before => File['/tmp/file1']
  }
 
file{'/tmp/file3':
  ensure => present, 
  before => File['/tmp/file2']
  }
  
  
file{'/tmp/file4':
  ensure => present, 
  before => File['/tmp/file3']
  }

file{'/tmp/file5':
  ensure => present, 
  before => File['/tmp/file4']
  }
