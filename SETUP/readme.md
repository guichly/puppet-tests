# Komenolla autoomaatisesti

````
wget -O - https://raw.githubusercontent.com/guichly/puppet-tests/master/SETUP/asennus.sh | bash
````
-O - kopioi tiedoston STDOUTiin kansioon /dev/null 

# Mitä scripti tekee

1. Vaihtaa suomen näppäimistöksi.
2. Asentaa git, tree, puppet demonit.
3. Kloonaa git repon home kansioon.
4. Lisää 9 riviin "ordering = manifest"
5. Kopioi git hakemistosta puppet kansion ja tiedostot /etc/
6. Testaa kopioidulla moduulilla "openssh".
7. vaihtaa lokaali ajan Suomen aikaan.

## Lähteet
https://www.linux.fi/wiki/Wget
https://github.com/poponappi/essential-tools
http://terokarvinen.com/2017/aikataulu-linuxin-keskitetty-hallinta-3-op-vanha-ops-%e2%80%93-loppusyksy-2017-p5-puppet#comment-23252
