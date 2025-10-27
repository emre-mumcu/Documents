GIT CREDENTIALS
---------------
Unlike Windows, Git Credential Manager (GCM) isn’t bundled with Git.

On Linux you usually have three main options for storing GitHub credentials:

1. Install Git Credential Manager (same tool as on Windows/macOS)

# Download and install the .deb package (latest release)
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.1/gcm-linux_amd64.2.6.1.deb
# download it manually 

sudo dpkg -i gcm-linux_amd64.2.6.1.deb
rm gcm-linux_amd64.2.6.1.deb

# Then configure Git to use it:
git-credential-manager configure

2. Use Git’s built-in credential cache (simpler)

If you just want to avoid retyping credentials temporarily:

git config --global credential.helper cache
# cache for 1 hour
git config --global credential.helper 'cache --timeout=3600'

3. Use Git’s libsecret integration (GNOME / Ubuntu recommended) This stores credentials securely in your GNOME Keyring.

{
sudo apt install libsecret-1-0 libsecret-1-dev
sudo apt install libsecret-1-0 libsecret-1-dev build-essential git
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
git config --global credential.helper
}

To build the git-credential-libsecret helper, you need the make tool and a compiler. You can install them like this:

sudo apt update
sudo apt install build-essential

AFTER 1 / 2 
----------------
First make sure GCM is installed:
git-credential-manager --version

Then configure Git to use GCM as its helper:
git config --global credential.helper manager
or sometimes (depending on the version):
git config --global credential.helper manager-core



printf 'protocol=https\nhost=github.com\nusername=USER\npassword=PASS\n' | git-credential-manager store

AFTER 3
-------
Pre-store credentials manually:
export GCM_CREDENTIAL_STORE=secretservice # tells GCM to use your GNOME keyring (libsecret).
printf "protocol=https\nhost=github.com\nusername=USER\npassword=TOKEN\n" | git-credential-manager-core store

export GCM_CREDENTIAL_STORE=secretservice
printf "protocol=https\nhost=github.com\nusername=USER\npassword=TOKEN\n" | git-credential-manager store





printf "protocol=https\nhost=github.com\nusername=USER\npassword=TOKEN\n" | git credential-manager store


NOTE
----
warning: credential.helper has multiple values error: cannot overwrite multiple values with a single value: Use a regexp, --add or --replace-all to change credential.helper.

git config --global --get-all credential.helper
git config --global --unset-all credential.helper


NOTE:

make tool comes with sudo apt install build-essential

List all existing values and see where they come from: 
git config --show-origin --get-all credential.helper

Remove all definitions of credential.helper:
git config --global --unset-all credential.helper

git config --local --unset-all credential.helper
git config --local --unset-all credential.helper

And if any appear in system config (less common), you may need to run:
sudo git config --system --unset-all credential.helper

Set the one value you want using --replace-all (safe)
to use the store helper: git config --global --replace-all credential.helper store
to use libsecret (if built): git config --global --replace-all credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

for Git Credential Manager: git config --global --replace-all credential.helper manager

****

make sure GCM is installed:
git-credential-manager --version
Then configure Git to use GCM as its helper:
git config --global credential.helper manager

how can i use libsecret:
sudo apt update
sudo apt install libsecret-1-0 libsecret-1-dev build-essential git

Build the Git libsecret helper
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make

Configure Git to use it
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

You can check that it’s set correctly:
git config --global credential.helper


** git-credential-manager (GCM) is different from libsecret.

You configured Git to use libsecret (/usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret), but then you tried to run git credential-manager store, which is part of GCM, not libsecret. That’s why you get:

fatal: No credential store has been selected.

Libsecret doesn’t use the git credential-manager command. Instead, it works automatically through Git when you do a Git operation that needs authentication.

How to use libsecret properly
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
Use Git normally


Optional: Pre-store credentials manually
export GCM_CREDENTIAL_STORE=secretservice
printf "protocol=https\nhost=github.com\nusername=USER\npassword=TOKEN\n" | git-credential-manager-core store

