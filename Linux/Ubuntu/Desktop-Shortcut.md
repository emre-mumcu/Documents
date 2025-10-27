# Manually Create a Custom Desktop Shortcut

Create a new .desktop file:

nano ~/Desktop/my-application.desktop

Edit the .desktop file:

[Desktop Entry]
Version=1.0
Name=My Application
Comment=Description of the app
Exec=/path/to/your/application
Icon=/path/to/icon.png
Terminal=false
Type=Application
Categories=Utility;

Save and make the file executable:

chmod +x ~/Desktop/my-application.desktop

Many applications already have .desktop files created by default, and they are usually located in one of these directories:

System-wide: 

/usr/share/applications/

User-specific: 

~/.local/share/applications/

Copy the desired .desktop file to your Desktop:

cp /usr/share/applications/firefox.desktop ~/Desktop/

After copying the file, you may need to make it executable:

chmod +x ~/Desktop/firefox.desktop