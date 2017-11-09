class openssh {
	  #paketin asennus
	package { ssh:
	ensure => 'installed',
	  #livetikussa puppet komennon suorittamista varten.
	allowcdrom => true,
	}	

	  #ssh konfiguraatio tiedostojen muokkaaminen.
	file { '/etc/ssh/ssh_config':
	content => template("openssh/ssh_config"),
	  #servicen huomautus sshd_config tiedoston muuttuessa
	notify => Service["ssh"],
	}

	  #ssh moduulin toiminnan varmistaminen.
	service { 'ssh':
	ensure => 'running',
	enable => 'true',
	}
}

