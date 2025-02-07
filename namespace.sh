#!/bin/bash
# 
# create a new namespace in DokuWiki
# 
# Setting variables 

dokudir=/var/www/dokuwiki
dokuowner="www-data"
bindir=$dokudir/bin
nsdir=$dokudir/data/pages
mediadir=$dokudir/data/media
template=_template.txt
dwsite="https://dwkoen.ddns.net"
currentns=$(find $nsdir -maxdepth 1 -type d ! -name '_template' -printf %f\\n |sort)

# Setting functions

#create a namespace
CreateNamespace(){

# name of new namespace
echo "Name of the new namespace (ONLY underscore allowed!):"
read nsname

# copy template files
cp -R $nsdir/_template $nsdir/$nsname
mkdir $mediadir/$nsname
cp $mediadir/dokuwiki/insert-image-icon.jpg $mediadir/$nsname/icon.jpg

# setting permissons on namespace
chown -R $dokuowner $mediadir/$nsname
chmod -R 755 $mediadir/$nsname
chown -R $dokuowner $nsdir
chmod -R 755 $nsdir

# put name namespace as subject
sed -i "s/onderwerp/$nsname/g" $nsdir/$nsname/onderwerp.txt
sed -i "s/onderwerp/$nsname/g" $nsdir/$nsname/_template.txt
mv $nsdir/$nsname/onderwerp.txt $nsdir/$nsname/$nsname.txt


echo -e "namespace $nsname SUCCESSFULLY created\n"
echo "1) use the link underneath to find a picture related to \"$nsname\"" 
echo "   https://www.google.com/search?as_st=y&tbm=isch&as_q=$nsname&as_epq=&as_oq=&as_eq=&cr=&as_sitesearch=&safe=images&tbs=ift:jpg"
echo "2) save the picture as: icon.jpg on your desktop" 
echo -e "3) open a browser: $dwsite/doku.php?id=$nsname:$nsname" 
echo -e "4) replace the existing icon.jpg with the one on your desktop.\n"

}

#delete a namespace
DeleteNamespace(){

# name of new namespace
echo "Name of the namespace you want to delete:"
echo $currentns
read nsnameD

for nsdel in $nsnameD; do

	rm -rf $nsdir/$nsdel
	rm -rf $mediadir/$nsdel
done

}


#add a new device
AddDevice(){

# name of the new device
echo "Name of the new device (lowercase characters, only!)?" 
read devicename

# copy template files
cp -R $nsdir/configuratie/$template $nsdir/configuratie/$devicename.txt
sed -i "s/device/$devicename/g"  $nsdir/configuratie/$devicename.txt
cp -R $nsdir/incident/$template $nsdir/incident/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/incident/$devicename.txt
cp -R $nsdir/installatie/$template $nsdir/installatie/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/installatie/$devicename.txt
cp -R $nsdir/changelogs/$template $nsdir/changelogs/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/changelogs/$devicename.txt
cp -R $nsdir/werkinstructies/$template $nsdir/werkinstructies/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/werkinstructies/$devicename.txt


# setting permissons on namespace
chown -R $dokuowner $nsdir/
chmod -R 755 $nsdir/

}


#add a new actrice
AddActrice(){

# name of the new "actrice"
echo "Name of the new actrice (lowercase characters, only!)?" 
read actrice

# copy template files
cp -R $nsdir/configuratie/$template $nsdir/configuratie/$devicename.txt
sed -i "s/device/$devicename/g"  $nsdir/configuratie/$devicename.txt
cp -R $nsdir/incident/$template $nsdir/incident/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/incident/$devicename.txt
cp -R $nsdir/installatie/$template $nsdir/installatie/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/installatie/$devicename.txt
cp -R $nsdir/changelogs/$template $nsdir/changelogs/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/changelogs/$devicename.txt
cp -R $nsdir/werkinstructies/$template $nsdir/werkinstructies/$devicename.txt
sed -i "s/device/$devicename/g" $nsdir/werkinstructies/$devicename.txt


# setting permissons on namespace
chown -R $dokuowner $nsdir/
chmod -R 755 $nsdir/

}











################
# start script #
################

clear


echo "           ##################################"
echo "           # DokuWiki: managing  namespaces #"
echo -e "           ##################################\n"

echo -e "Select the operation:\n"
echo "1: display current namespaces"
echo "2: create a new namespace"
echo "3: delete a namespace"
echo -e "4: add a new device\n"

read action
case $action in 
	"1") for ns in $currentns; do echo $ns; done|nl
	;;
	"2") CreateNamespace 
	;;
	"3") DeleteNamespace
	;;
	"4") AddDevice
	;;
esac
