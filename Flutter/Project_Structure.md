Android projects use a "nested" structure where settings trickle down from the top (the project) to the bottom (the app).

Here is the breakdown of the "Big Three" files you'll deal with:

1. settings.gradle (The Manager)
Think of this as the Project Map. It’s the very first file Gradle looks at.

Purpose: It defines which folders are actually "modules" (like :app) and where to find the plugins (libraries that help Gradle build Android code).

Key Job: It sets the version of the Android tools globally so you don't have to repeat them in every sub-folder.

2. build.gradle (Project-level)
In modern projects, this file is actually becoming quite empty.

Purpose: It handles configuration that applies to every single module in your project.

Key Job: Mostly used for "cleaning" tasks or global variables. If you’re using the newer plugins block in settings.gradle, this file might only have a few lines.

3. app/build.gradle (The Worker)
This is the most important file for your daily coding. It lives inside the app folder.

Purpose: It contains the specific instructions for building your app.

Key Job: * SDK Versions: What is the minimum Android version you support?

App ID: What is your com.example.app name?

Dependencies: This is where you list libraries (like Retrofit, Room, or Compose) that your code needs to run.

Where to put your code?

Adding a new library? Go to app/build.gradle under dependencies.
Changing the App Version? Go to app/build.gradle under defaultConfig.
Fixing a "Plugin not found" error? Go to settings.gradle.