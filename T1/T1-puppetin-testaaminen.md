# T1 Puppetilla SSH asennus ja testaus

##  Tehtävät
a) Asenna jokin muu demoni kuin Apache. Raportoi, miten rakensit, selvitit ja testasit kunkin osan (esim. sudo puppet resource, puppet describe, lähteet…). Julkaise myös modulisi lähdekoodi niin, että sen voi helposti ottaa käyttöön.

## Raudan Tiedot

* Laitteen nimi: Surface Book
* Prosessori: Intel(R) Core (TM) i7-6600U CP
* Näytönojain: Nvidia 2GB Muisti: 16GB
*Varastolaite: Samsung SSD 500GB
* [xubuntu-16.04.3](http://nl.archive.ubuntu.com/ubuntu-cdimage-xubuntu/releases/16.04/release/xubuntu-16.04.3-desktop-amd64.iso) virtuaalikoneessa VMware Workstation pro 14


## Puppetin assenus
Avaa terminaali painamalla Ctrl+Alt+T ja syötä sinne seuraava komento.

Ensiksi päivitetään linuxin paketit ja asennetaan puppet lisäksi, jos haluat voit asentaa tree deamonin sillä voit tutkia hakemistojen rakennetta.

`$ sudo apt-get update && sudo apt-get -y install puppet && apt-get -y install tree`

Onnistuneen asennuksen jälkeen voit testata puppetin version komennolla.

`$ puppet --version`

![img](https://guichlyhessen.files.wordpress.com/2017/10/screenshot_2017-10-31_07-25-421.png?w=982)

## Manifest Ordering

Helpotta koodin kirjottamista. Kone lukee koodia ylhäältä alas.

`$ sudoedit /etc/puppet.conf`

Lisää kodin pätkä tiedostoon seuraavasti.

`ordering = manifest`

Ctrl+X ja save chages? “yes” tallennetaan asetukset.

## Puppet hakemistojen luominen

Asennuksen onnistumisen jälkeinen luodaan manifest ja templates kansiot seuraavasti:
````
$ cd /etc/puppet/modules # polkuun navigointi

#hakemistojen luonti
$ sudo mkdir openssh
$ cd openssh
$ sudo mkdir manifests
$ sudo mkdir templates
#hakemistojen katselu
$ tree
$ pwd
$ ls
````
![img](https://guichlyhessen.files.wordpress.com/2017/10/screenshot_2017-10-31_08-42-03.png?w=982)

## SSH puppet tiedoston luonti

manifest kansioon pitää luoda init.pp tiedosto ja lisätä sinne ssh tiedot:

````
$ cd manifests
$ sudoedit init.pp
````
package “paketin tiedot”, file “tiedoston tiedot” , service ” deamonin toiminnan tiedot”.

````
class openssh {
        #paketin asennus
       package { ssh:
       ensure => 'installed',
        #livetikussa puppet komennon suorittamista varten.
       #allowcdrom => true,
       } 
        #ssh konfiguraatio tiedostojen muokkaaminen.
       file { '/etc/ssh/ssh_config':
       content => template("openssh/ssh_config"),
        #servicen huomautus ssh_config tiedoston muuttuessa
       notify => Service["ssh"],
       }
        #ssh moduulin toiminnan varmistaminen.
       service { 'ssh':
       ensure => 'running',
       enable => 'true',
       }
}
````

Ctrl+X ja save chages? “yes” tiedoston luomisen jälkeen kopioidaan ssh konfiguraatio tiedosto seuraavasti.

`$ sudo cp /etc/ssh/ssh_config /etc/puppet/modules/openssh/templates/`

Lopputulos pitäisi näyttää tältä.

![img](https://guichlyhessen.files.wordpress.com/2017/10/screenshot_2017-10-31_09-29-25.png?w=982)

## SSH puppet suorittaminen

init.pp:een class:in nimi pitää olla sama kuin hakemiston nimi tässä tapauksessa openssh.

`$ sudo puppet apply -e 'class {'openssh':}'`

![img](https://guichlyhessen.files.wordpress.com/2017/10/screenshot_2017-10-31_09-27-37.png?w=982)

## SSH testaus

Luodaan testikäyttäjä seuraavasti käyttäen vahvaa salasanaa.
Vahavan salasanan saat generoitua nopeasti sivulta [strongpasswordgenerator](https://strongpasswordgenerator.com)

`$ sudo adduser tester`

Luodaan ssh yhteys tester käyttäjällä seuraavasti.

`$ ssh tester@localhost`

![img](https://guichlyhessen.files.wordpress.com/2017/10/screenshot_2017-10-31_09-38-55.png?w=982)

## GitHubiin puskeminen

kopioidaan tuotokset puppet hakemistosta git repoon seuraavasti.

`cp -r /etc/puppet/modules/openssh/ ~/puppet-tests/T1/`

Mennään git hakemistoon ja pusketaan tuotos repoon seuraavasti.

````
$ cd 
$ cd puppet-tests/
$ git add * && git commit -m "TEXT"
$ git pull && git push
````
[GITHUB](https://github.com/guichly/puppet-tests/tree/master/T1)

## Lähteet

http://terokarvinen.com/2013/ssh-server-puppet-module-for-ubuntu-12-04

http://terokarvinen.com/2017/aikataulu-linuxin-keskitetty-hallinta-3-op-vanha-ops-%e2%80%93-loppusyksy-2017-p5-puppet

https://docs.puppet.com/puppet/3.8/lang_summary.html

https://www.puppetcookbook.com/ 

**Tätä dokumenttia saa kopioida ja muokata [GNU General Public License 3v](https://www.gnu.org/licenses/gpl-3.0.en.html) tai uudemman mukaisesti.**

