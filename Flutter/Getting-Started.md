# Getting Started for Windows

1. Download and install the latest version of [Git for Windows](https://git-scm.com/install/windows).

2. To quickly install Flutter, then edit and debug your apps, install and set up [Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview).

3. Add the Flutter (and Dart) extensions to VS Code. Visit the [Flutter extension's marketplace page](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter), then click Install. If prompted by your browser, allow it to open VS Code.

3. Open VS Code and open the command palette in VS Code.

	* Go to View > Command Palette or press Control + Shift + P.

	* In the command palette, type flutter.

	* Select Flutter: New Project.

	* VS Code prompts you to locate the Flutter SDK on your computer. Select Download SDK.

	* When the Select Folder for Flutter SDK dialog displays, choose where you want to install Flutter.

	* Click Clone Flutter.

	* Click Add SDK to PATH.

4. To ensure that Flutter is available in all terminals, close, then reopen all terminal windows and restart VS Code.

## Manual Setup

1. Download the installation bundle to get the latest stable release of the Flutter SDK from [here](https://docs.flutter.dev/install/manual)

2. Extract the SDK bundle you downloaded into the directory you want to store the Flutter SDK in.

3. Add the Flutter SDK's `bin` directory to your PATH environment variable. Adding Flutter to your PATH allows you to use the flutter and dart command-line tools in terminals and IDEs.

4. To ensure you successfully added the SDK to your PATH, open command prompt or your preferred terminal app, then try running the flutter and dart tools.

flutter --version
dart --version

5. Download and install [Android Studio](https://developer.android.com/studio).


6. Open Android Studio and select SDK Manager from `More Actions` dropdown in the welcome screen. And select the following components and download them:

	* SDK Platforms
		- Android 16.0 (Baklava) 

	* SDK Tools:
		- Android SDK Command Line Tools (latest) 
		- Google Play Services
		- Google USB Driver
		- Google Web Driver
		- Google Repository

	* Close the SDK Manager.

7. Click the Plugins button at the left of the Welcome screen and install the Flutter and Dart plugins.

8. Download and install Java JDK. Flutter's Android toolchain works most stably with Java 17, especially when used with Gradle and the Android Gradle Plugin (AGP).

9. Add Java `bin` directory to your PATH environment variable. To ensure you successfully added the SDK to your PATH, open command prompt or your preferred terminal app, then try running the following command:

java -version

## Post Installation Steps

flutter config --android-sdk "C:\Flutter\android_sdk"
flutter doctor --android-licenses

-- If you don't want to create windows desktop applications, add the following config to skip check of `Visual Studio - develop Windows apps`
flutter config --no-enable-windows-desktop

flutter doctor

# Create a new Flutter app

1. Open the command palette in VS Code and start typing flutter:.

2. Select the Flutter: New Project command.

3. Choose the Application template. Choose Application to bootstrap a simple app.

4. Create or select the parent directory for your new app's folder. Select or create the parent directory where you want the project to be created.

5. VS Code should prompt you to enter a name for your new app. Enter a  lowercase_with_underscores name to you application. To confirm your selection, press Enter.

6. Wait for project initialization to complete.

### Command Line

flutter create app_name
flutter run
flutter devices
flutter clean
flutter pub get

## Run your app on the web

While Flutter apps can run on many platforms, try running your new app on the web.

* Open the command palette in VS Code and start typing flutter:.
* Select the Flutter: Select Device command. 
* From the Select Device prompt, select Chrome.
* Run or start debugging your app.
* Go to Run > Start Debugging or press F5.

flutter run is used to build and start your app, then a new instance of Chrome should open and start running your newly created app.

## Hot Reload

Flutter offers a fast development cycle with stateful hot reload, the ability to reload the code of a live running app without restarting or losing app state.

You can change your app's source code, run the hot reload command (Hot Reload Button) in VS Code, then see the change in your running app.












https://flutter.dev/



Getting Started with MacOS

nano ~/.zprofile 

export PATH="$PATH:/Users/Username/Dev/FlutterSdk/flutter/bin"

flutter config --android-sdk /Users/Username/Dev/AndroidSDK

flutter doctor --android-licenses 

flutter doctor

If Necessary set  the following configs as well:

flutter config --android-studio-dir ***
flutter config --jdk-dir=***

Add Code to Path
Open the command palette in VS Code.
Go to View > Command Palette or press Command + Shift + P.
Type "shell command" into the search box.
Select Shell Command: Install 'code' command in PATH.
VS Code usually creates a symbolic link (a shortcut) in a directory that is already in your system's default PATH (/usr/local/bin).
/usr/local/bin is a standard system-wide location macOS looks for programs, it works "out of the box" without you needing to tell the shell where to look every time it starts up.

Create  First Application
flutter create first_app

cd first_app
code .

Run Application:

Command + Shift + P
Select Flutter: Launch Emulator
Select the emulator

You can click the Run link above the main method, you can execute “flutter run” command from vscode terminal or you can click Start Debugging or Run Without Debugging from Run menu of vscode.
Make sure you  have selected correct device as default in status  bar of vscode
