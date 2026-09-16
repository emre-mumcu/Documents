# Getting Started

[Flutter](https://github.com/flutter/flutter) is an open-source UI toolkit (framework) by Google for building natively compiled applications for mobile, web, and desktop from a single codebase. It uses the Dart programming language and provides fast development with features like hot reload.

## Create a Development Environment

Your [Flutter Development Environment](https://docs.flutter.dev/get-started/install/windows/mobile) must have the following components:

* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* [Git](https://git-scm.com/)
* [Android Studio](https://developer.android.com/studio)
* [Visual Studio Code](https://code.visualstudio.com/download)
* A Virtual Device

1. To install Flutter, download the [Flutter SDK bundle](https://docs.flutter.dev/release/archive) from its archive, move the bundle to where you want it stored, then extract the SDK from the zip file to `C:\FlutterDev\flutter` folder. 

You can choose any destination but don't install Flutter to a directory that contains special characters or spaces, or the path requires elevated privileges.

Add the flutter bin directory `C:\FlutterDev\flutter\bin` to PATH.

```Powershell
# To add the folder to User PATH:
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\FlutterDev\flutter\bin", "User")

# To add the folder to System PATH (Administrator required):
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "Machine") + ";C:\FlutterDev\flutter\bin", "Machine")

# Then close and reopen your terminal and to verify:
$env:Path -split ";"
where.exe flutter
flutter --version
dart --version

# NOTE: Important: avoid duplicates: A cleaner PowerShell approach that only adds the folder if it isn't already there:
$folder = "C:\FlutterDev\flutter\bin"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (($userPath -split ";") -notcontains $folder) {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$folder", "User")
}
```

2. Download and install Android Studio. I prefer downloading the zip file NOT the executable one. Extract the zip file to `C:\FlutterDev\android-studio` folder. Open the Android Studio and run the Android Studio Setup Wizard.

Select custom setup and set the Android SDK path to `C:\FlutterDev\android-sdk` folder. 

After the Android Studio Setup Wizard completes, open the `Android Studio -> Mode Actions -> SDK Manager` 

From the SDK Platforms tab, select the following components to install:

* Latest or preferred Android version

From the SDK Tools tab, select the following components to install:

* Android SDK Build-Tools
* Android SDK Command-line Tools (Latest)
* Android Emulator
* Android SDK Platform-Tools
* Google USB Driver
* Google Web Driver
* Google Play Services
* Google Repository

Click OK to apply.

After components have been installed, 

Click Plugins tab of Android Studio and install Flutter & Dart plugins.

Add the following PATH entries:

```powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\FlutterDev\android-sdk\platform-tools", "User")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\FlutterDev\android-sdk\emulator", "User")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\FlutterDev\android-sdk\cmdline-tools\latest\bin", "User")
```

Then close and reopen your terminal. 

Point the flutter to Android SDK:

```powershell
flutter config --android-sdk "C:\FlutterDev\android-sdk"
```

Run `flutter doctor -v` command.

3. Check Android SDK Location: 
Open Android Studio -> Geasr Icon -> Settings → Languages & Frameworks → Android SDK
Validate Android SDK Location as `C:\FlutterDev\android-sdk`


## Configuration

You can get the Flutter configuration using the following command:

```shell
PS> flutter config --list
```

To reset configurations to their default state, you can delete or modify the ~/.flutter_settings file, or run:

```shell
PS> flutter config --clear-features
```

You can change the configuration using the following commands:

```shell
PS> flutter config --enable-linux-desktop
PS> flutter config --enable-macos-desktop
PS> flutter config --enable-windows-desktop
PS> flutter config --no-enable-web
```

winget install --id Google.AndroidCLI
android info
android sdk list
android sdk install "ndk;28.2.13676358"
android --sdk="D:\MobileDev\android-sdk" sdk install "ndk;28.2.13676358"
flutter doctor --android-licenses

## Create First Application

Run the following commands to create and run your first flutter application. Do NOT use spaces and dash character in folder names.

```shell
# create app
flutter create first_app
# Specify organization (for package name):
flutter create --org com.example my_app
# Create only specific platforms:
flutter create --platforms=android,ios my_app
# Create with a specific template:
flutter create --template=app my_app
# Other templates: module, plugin, package

C:\Dev>flutter create --org net.mumcu.demologin --platforms=android demologin

# list devices:
flutter devices

# run app
flutter run

# update dependencies & packages:
flutter clean
flutter pub get
flutter run
```

While Flutter apps can run on many platforms, try running your new app on the web.

* Open the command palette in VS Code and start typing flutter:.
* Select the Flutter: Select Device command. 
* From the Select Device prompt, select Chrome.
* Run or start debugging your app.
* Go to Run > Start Debugging or press F5.

flutter run is used to build and start your app, then a new instance of Chrome should open and start running your newly created app.

## Uninstall Android Studio

1. Run the Android Studio uninstaller if available.

2. Remove the Android Studio files. In File Explorer, go to your user folder `%USERPROFILE%`, and delete `.android`, `.AndroidStudio` and any analogous directories with versions on the end, i.e. `.AndroidStudio1.2`, `.gradle` and `.m2` if they exist.

3. Also delete the any `AndroidStudio*` directories that are in `%LOCALAPPDATA%\Google` and `%APPDATA%\Google`.

4. Finally, go to `C:\Program Files` and delete the `Android` directory.

5. To delete any remains of the SDK, go to `%LOCALAPPDATA%` and delete the Android directory.

**Summary of all paths of leftover files from Android Studio**

* C:\Program Files\Android
* C:\Users\USERNAME\AppData\Local\Android
* C:\Users\USERNAME\AppData\Local\Google\AndroidStudio2024.2
* C:\Users\USERNAME\AppData\Roaming\Google\AndroidStudio2024.2
* C:\Users\USERNAME\.gradle
* C:\Users\USERNAME\.android
* C:\Users\USERNAME\.AndroidStudio
* C:\Users\USERNAME\.konan
* C:\Users\USERNAME\.m2
