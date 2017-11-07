#Alku järjestelyt ja asennukset
sudo apt-get update
sudo apt-get install -y git && tree && puppet

#Projektin kloonaus 
git clone https://github.com/guichly/puppet-tests.git

#lisää 9 riviin "ordering = manifest" ja tekee uuden rivin.
sudo sed -i "9i ordering = manifest\n" /etc/puppet/puppet.conf

#kopioidaan rekursiivisesti "-r" ja päällekirjoittamatta samat nimiset "-n" tiedostot /etc/ hakemistoon.
sudo cp -rn ~/puppet/puppet-tests/puppet /etc/

#Testataan kopioidulla moduulilla "openssh".
sudo puppet apply -e 'class {'openssh':}'

#Linuxin ajan hallinnan demoni (Suomen aikaan) https://www.systutorials.com/docs/linux/man/1-timedatectl/
sudo timedatectl set-timezone Europe/Helsinki

#Suomen näppäimistö käyttöönotto 
setxkbmap fi
