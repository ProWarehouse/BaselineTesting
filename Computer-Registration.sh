#!/bin/bash
#####################################################################
#
# 	Script Name		- Computer-Registration.sh
# 	Author			- Nick van Jaarsveld
# 	Organisation	- Pro Warehouse
# 	Version			- 1.0
# 	Description
#	Prompts the user to enter a computer name using swiftDialog.
#
#####################################################################
# GLOBAL VARIABLES
dialog="/usr/local/bin/dialog"
jamf=$(which jamf)

title="${4:-"Register your Mac"}"
icon="${5:-"https://euc1.ics.services.jamfcloud.com/icon/hash_a7d0ffb246fac1252f636a06bf31d55d14d274d93a2d5284ce33f47b48ec3264"}"
bannerimage="${6:-"https://probaseline.jamfcloud.com/api/v1/branding-images/download/14"}"
selecttitle="${7:-""}"
selectvalues="${8:-""}"

infobox="#### Support \n - +31 88 776 70 40  \n#### Your Mac \n - macOS {osname} ({osversion}) \n - {computermodel}  \n - {serialnumber}"
message="Personalize your Mac by giving it a name that suits you best. You can enter a name now, or you can do this later via **Self Service**:\n
* Select the **Pro Warehouse** icon in the menu bar\n
* Select **Self Service**\n
* Click the **Register** button below the **Computer Name** item and follow the on-screen instructions"

textfield="Computer Name,value=Mac John Appleseed,required"
button1text="Register"
button2text="Cancel"


#####################################################################
# RUN SCRIPT

ComputerNameDialog="$dialog \
--title \"$title\" \
--message \"$message\" \
--icon \"$icon\" \
--bannerimage \"$bannerimage\" \
--textfield \"$textfield\" \
--button1text \"$button1text\" \
--button2text \"$button2text\" \
--messagefont \"size=15\" \
--width 960 \
--height 700 \
--blurscreen \
--ontop"

computerName=$(eval "$ComputerNameDialog" | awk -F " : " '{print $NF}')

scutil --set HostName "$computerName" || echo "Error setting HostName"
scutil --set LocalHostName "$computerName" || echo "Error setting LocalHostName"
scutil --set ComputerName "$computerName" ||  echo "Error setting ComputerName"

$jamf recon