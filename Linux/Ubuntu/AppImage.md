# AppImage Files

On Ubuntu, AppImage files don’t need installation the way .deb or Snap packages do. They’re portable executables that run directly once you give them permission.

chmod +x example.AppImage
./example.AppImage

Some AppImages support desktop integration so the app shows up in your application launcher. 

Run the AppImage once, and it may ask if you want to "integrate with the system." If not, you can do it manually by creating a .desktop file in:

~/.local/share/applications/

nano ~/.local/share/applications/example.desktop

Paste this (adjust paths and name):

[Desktop Entry]
Name=Example App
Exec=/home/yourusername/Downloads/example.AppImage
Icon=/home/yourusername/Downloads/example-icon.png
Type=Application
Categories=Utility;