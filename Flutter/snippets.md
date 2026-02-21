# Create Flutter Project

```bash
flutter create --project-name micard --org net.mumcu --platforms=android MiCard


```





Why use Super Parameters?
Before this update, every single widget you created had to manually "pass" the key up to the parent StatelessWidget or StatefulWidget. It was a lot of typing for something that happens in every single widget.

super.key tells Dart: "Take the key argument and automatically pass it to the constructor of the class I'm extending."

When to use them
You should use super.parameterName whenever you are just passing a value directly to the parent class without changing it. The most common use case is super.key, but it works for any property in a class hierarchy.




dart pub deps --unused


flutter clean
flutter pub get
flutter run
flutter pub add package_name

flutter config --android-sdk "C:\Mobile\android-sdk"
Add to Path: C:\Mobile\android-sdk\platform-tools

# Clear Project

To clear out the "remnants" of old Gradle versions and corrupted build files, you have two options: a Safe Project Clean (standard) and a Total Nuclear Clean (deep system-wide clean).

1. The Standard "Flutter Clean" (Project Level)
This is what you should do regularly. It deletes the build/ folder in your project.

In your Android Studio terminal, run:

flutter clean
flutter pub get


2. The "Nuclear" Gradle Clean (System Level)
Gradle stores downloaded versions (like the old 8.3.0) and cached library files in a global folder on your C: drive. If your builds are acting strange, "nuke" this folder:

Close Android Studio completely.
Open File Explorer.
Go to your User folder: C:\Users\YOUR_NAME\
Find the folder named .gradle. (Note: It starts with a dot).
Delete the entire .gradle folder.

Don't worry: This folder doesn't contain your code. It only contains downloaded tools.

Restart Android Studio and run your app.

Warning: The next build will take a long time because it has to redownload Gradle 8.7.0 from scratch, but it will be a "perfect" clean install.


3. Clear Android Studio System Caches
Sometimes the IDE itself holds onto old file indexes:

Go to File > Invalidate Caches...
Select all checkboxes.
Click Invalidate and Restart.




Welcome to the cutting edge! You are seeing this because you are using Android Gradle Plugin (AGP) 9.0+.

In this version, Google changed the rules: Kotlin support is now built-in. You no longer need to explicitly ask for the Kotlin plugin in your app's build file; in fact, doing so now causes the crash you're seeing.


1)

A:\AppStore\Dev.Flutter\apps\diyabet_rehberim\android/gradle/wrapper/gradle-wrapper.properties. 

distributionUrl=https\://services.gradle.org/distributions/gradle-8.3-all.zip
distributionUrl=https\://services.gradle.org/distributions/gradle-8.9-all.zip


2)

A:\AppStore\Dev.Flutter\apps\diyabet_rehberim\android\settings.gradle

id "com.android.application" version "8.1.0" apply false
id "com.android.application" version "8.7.0" apply false







