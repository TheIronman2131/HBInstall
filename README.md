# Getting Started

After installing `htb_connect.sh` make sure that it is installed in your downloads folder.
Next make sure you have downloaded the Hack The Box VPN from the activity you plan to use.
Once the VPN is downloaded and kept in your downloads folder, this is key because the script automatically searches your downloads folder for user ease, run `chmod +x htb_connect.sh` (Keep in mind you must be in ~/Downloads first).

## Important Notes

Invisible passwords: The script will ask for your Mac login password to install tools (Homebrew, Nmap, OpenVPN, etc.) or to create the VPN connection. When you type this password in the terminal, nothing will show up. This is normal for MacOS security. Just type your password blindly and press `Enter`.

The Install Pause: If you do not have Homebrew installed, the script will install it for you. This can take up to 3-5minutes and might look like the script froze. It did not, do not press ^C, let it run, it will print a sucess messeage when that step has completed. 

Sucess: You will know you are connected when the script outputs a big `[+] SUCCESS!` message showing your new `10.10.x.x` IP Address.

## Next Time

Just run `./htb_connect.sh` (Keep in mind you must be in ~/Downloads first) in the future anytime you do a Hack The Box activity and the script will connect you automatically. Do note if you switch from `Starting Point` to `Machines` you will need to delete the `startingPoint.opvn` file and download the `Machines.ovpn` file. 
