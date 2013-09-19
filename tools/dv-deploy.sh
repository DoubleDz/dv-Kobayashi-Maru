#!/bin/sh
# Sample how to create a minimized MinHtml html dir from development

ECHO() {
  echo $*
  $*
}

# Assume our minimized project URL is at $HtmlRoot/$MinHtml, with Packages '$UserPkgs',
#  and using 'bootstrap', and development moduls for EpicMvc is at $HtmlRoot/EpicMvc

HtmlRoot=${EPIC_HtmlRoot-'/Applications/MAMP/htdocs'}

EpicDir=${EPIC_EpicDir-${3-"$HtmlRoot/epic"}}
EnvPkg=${EPIC_EnvPkg-'bootstrap'}

UserDir=${EPIC_UserDir-${2-"$HtmlRoot/dv_dev"}}
UserPkgs=${EPIC_UserPkgs-'dv'}
UserIndex=${EPIC_UserIndex-'dv-index'}
MinHtml=${EPIC_MinHtml-${1-'dv'}}

#echo HtmlRoot=$HtmlRoot
echo EpicDir=$EpicDir
#echo EnvPkg=$EnvPkg
echo UserDir=$UserDir
#echo UserPkgs=$UserPkgs
#echo MinHtml=$MinHtml

if [ -d $HtmlRoot/$MinHtml ]
then
  echo " ---------> (For your safety, verify this path) ----------> Removing all of $HtmlRoot/$MinHtml"
  rm -Ir $HtmlRoot/$MinHtml
fi
for DIR in $HtmlRoot/$MinHtml $HtmlRoot/$MinHtml/Package $HtmlRoot/$MinHtml/js
do
  if [ ! -d $DIR ]
  then 
    mkdir $DIR
  fi
done

echo Verifying links DevEpic, DevUser, MinHtml
if [ -h DevEpic ] ; then rm DevEpic ; fi
ln -s $EpicDir DevEpic
if [ -h DevUser ] ; then rm DevUser ; fi
ln -s $UserDir DevUser
if [ -h MinHtml ] ; then rm MinHtml ; fi
ln -s $HtmlRoot/$MinHtml MinHtml
ls -l --color=auto DevEpic DevUser MinHtml

declare -A MD5_MAP
MD5Check=''

echo "Building:    DevEpic"
MinEpic=MinHtml/js/EpicMvc-Base-bootstrap-0.0.0-min-%MD5_EPICMVC%.js
MD5_MAP[%MD5_EPICMVC%]=$MinEpic
MD5Check="$MD5Check %MD5_EPICMVC%"
cat copyright.js > $MinEpic
./makeit DevEpic/EpicMvc $MinEpic

PKG=Base
echo "Building:    Package/$PKG"
./makeit-pkg DevUser/Package/$PKG $MinEpic
echo "Compressing: Package/$PKG/view"
./makeit-view $EpicDir $EpicDir $PKG >> $MinEpic

PKG=$EnvPkg
echo "Building:    Package/$PKG (the EnvPkg)"
./makeit-pkg DevUser/Package/$EnvPkg $MinEpic
echo "Compressing: Package/$PKG/view"
./makeit-view $EpicDir $EpicDir $PKG >> $MinEpic

MinSiteJs=MinHtml/js/Site-min-%MD5_SITEJS%.js
MD5_MAP[%MD5_SITEJS%]=$MinSiteJs
MD5Check="$MD5Check %MD5_SITEJS%"
echo -n > $MinSiteJs
for PKG in $UserPkgs
do
  echo "Building:    Package/$PKG"
  ./makeit-pkg DevUser/Package/$PKG $MinSiteJs
  echo "Compressing: Package/$PKG/view"
  ./makeit-view $EpicDir $UserDir $PKG >> $MinSiteJs
  echo "Combining: Package/$PKG/css"
  MinSiteCss=MinHtml/Package/$PKG/css/Site-min-%MD5_${PKG}CSS%.css
  MD5_MAP[%MD5_${PKG}CSS%]=$MinSiteCss
  MD5Check="$MD5Check %MD5_${PKG}CSS%"
  mkdir -p MinHtml/Package/$PKG/css
  cat DevUser/Package/$PKG/css/_*css > $MinSiteCss
#  ECHO cp -r DevUser/Package/$PKG/css/icons MinHtml/Package/$PKG/css/.
  ECHO cp -r DevUser/Package/$PKG/images MinHtml/Package/$PKG/.
done

SUB='$0'
echo "-- Capture 'git' versions --"
SUB="gensub(\"%GIT_EPICMVC%\",\"`(cd DevEpic ; git describe --always)`\",1,$SUB)"
SUB="gensub(\"%GIT_DVWEBCLIENT%\",\"`(cd DevUser ; git describe --always)`\",1,$SUB)"

echo "-- Process MD5 renames --"
for KEY in $MD5Check
do
  FILE=${MD5_MAP[$KEY]}
  MD5=`md5sum $FILE | cut -c1-5`
  SUB="gensub(\"$KEY\",\"$MD5\",1,$SUB)"
  ECHO mv $FILE `echo $FILE | awk "{print gensub(\"$KEY\",\"$MD5\",1)}"`
done
cat DevUser/$UserIndex.html | awk "{print $SUB}" > MinHtml/index.html

echo "-- Custom assets --"
# Notes:

echo Clean-up specific to our module

echo Done.
