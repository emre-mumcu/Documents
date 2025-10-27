VSCODE Warning Message
----------------------
You're running in a GNOME environment but the OS keyring is not available for encryption. Ensure you have gnome-keyring or another libsecret compatible implementation installed and running.

# Install the required packages
sudo apt install gnome-keyring libsecret-1-0

# Start the gnome-keyring daemon in your session
eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets)

# Enable automatic startup (so you don’t have to run it every time)
# Check if gnome-keyring-daemon is listed in your autostart:
ls /etc/xdg/autostart/gnome-keyring*.desktop
# If not, you can add it manually to your session startup programs:
mkdir -p ~/.config/autostart
cp /etc/xdg/autostart/gnome-keyring-secrets.desktop ~/.config/autostart/

# PAM integration (optional, for login unlock)
# If you want the keyring to unlock automatically with your login password
auth optional pam_gnome_keyring.so
session optional pam_gnome_keyring.so auto_start





VSCODE Reset
------------

Make sure VS Code is fully closed.

Remove user settings and configuration:

rm -rf ~/.config/Code
rm -rf ~/.config/Code\ -\ OSS   # only if you use VS Code OSS version

Remove extensions:

rm -rf ~/.vscode
rm -rf ~/.vscode-oss  # only if using OSS version

Clear cached data:

rm -rf ~/.cache/Code
rm -rf ~/.cache/Code\ -\ OSS

Clear GNOME Keyring entries

If you logged in with Settings Sync (Microsoft or GitHub), also remove stored credentials:

secret-tool clear service vscode



IMPORT EXPORT EXTENSIONS
------------------------
code --list-extensions > vscode-extensions.txt # windows
code --list-extensions > vscode-extensions.txt # linux

cat vscode-extensions.txt | xargs -L 1 code --install-extension # linux
type vscode-extensions.txt | % { code --install-extension $_ }  # windows
#or
for /f %i in (vscode-extensions.txt) do code --install-extension %i # windows


code --list-extensions