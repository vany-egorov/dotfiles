#!/usr/bin/env bash

# OPENVPN_USER, OPENVPN_KEY, OPENVPN_PROFILE defined in openvpn-private.sh

# in file :"/Users/${USER}/Library/Application\ Support/Tunnelblick/Configurations/${OPENVPN_PROFILE}.tblk/Contents/Resources/config.ovp"
# replace:
#   auth-user-pass
# to:
#   auth-user-pass /Users/${USER}/.openvpn-tunnelblick-auth
#
# diff ./config.ovpn ./config-patched.ovpn
# 16c16
# < auth-user-pass
# ---
# > auth-user-pass /Users/<user-name-here>/.openvpn-tunnelblick-auth
#
# $ \cat ~/.openvpn-tunnelblick-auth
# user
# password
function openvpn-tunnelblick() {
	echo -e "${OPENVPN_USER}\n$( oathtool --totp -b ${OPENVPN_KEY} )" > /Users/${USER}/.openvpn-tunnelblick-auth

	osascript -e "tell application \"/Applications/Tunnelblick.app\"" -e\
		  "connect \"${OPENVPN_PROFILE}\"" -e "end tell"
}
