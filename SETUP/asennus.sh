#Suomen näppäimistö käyttöönotto 
setxkbmap fi

#Alku järjestelyt ja asennukset
sudo apt-get update
sudo apt install -y git
sudo apt install -y tree
sudo apt install -y puppet
sudo apt install -y ssh
#Projektin kloonaus 
git clone https://github.com/guichly/puppet-tests.git

#lisää 9 riviin "ordering = manifest". https://www.gnu.org/software/sed/manual/sed.html
sudo sed -i "9i ordering = manifest" /etc/puppet/puppet.conf

#kopioidaan rekursiivisesti "-r" ja päällekirjoittamatta samat nimiset "-n" tiedostot /etc/ hakemistoon.
sudo cp -rn ~/puppet-tests/puppet /etc/

#Testataan kopioidulla moduulilla "openssh".
sudo puppet apply -e 'class {'openssh':}'

#Linuxin ajan hallinnan demoni (Suomen aikaan) https://www.systutorials.com/docs/linux/man/1-timedatectl/
sudo timedatectl set-timezone Europe/Helsinki
