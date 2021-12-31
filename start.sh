#!/bin/bash

# här installeras dina csgo-serverar
DESTINATION="/home/servrar"

# här installeras STEAMCMD
STEAMCMD="/home/steamcmd"

# nu döper vi din server
SERVERNAMN="Cloudnet"

# kollar om foldern 'servrar' finns, annars skapar vi den
sudo test -r $DESTINATION -a -x $DESTINATION
if [ $? -ne 0 ]; then
    sudo mkdir $DESTINATION
fi

# skapar steamcmd-foldern i /home
mkdir /home/steamcmd
cd /home/steamcmd

# nu hämtar vi steamcmd
curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# nu hämtar vi lite x86-paket och gcc1
sudo apt-get install lib32gcc1 lib32stdc++6 -y

# dags att göra installationsargument för äckelservern
echo "login anonymous 
force_install_dir $DESTINATION/$SERVERNAMN
app_update 740 validate
quit" > install.txt

# nu ger vi filrättigheter till horfilen
chmod 777 $STEAMCMD/install.txt

# nu ska jag frågar jag om en server ska installeras, hela poängen med scriptet
echo ""
echo ""
echo "Okeee, vill du installera din server nu?"
select yn in "JA" "Nej"; do
    case $yn in
        JA ) bash $STEAMCMD/steamcmd.sh +runscript install.txt; break;;
        Nej ) exit;;
    esac
done
