# Flutter and Firebase project.

A mobile app helps accelerate the process of discovering potential new plants with image recognition and community vote. We used Flutter and Firebase for this project.

## Setup steps:

-   First, Install AndroidStudio.
-   Then,running our code requires configuring an environment that uses the flutter language.

Follow the steps on this [website](https://flutter.dev/) to complete the configuration.

Use flutter doctor to check if the configuration is successful.

## About code:

We added comments to the code for easy reading, where different folders represent different meanings.

Almost every DART file can provide useful information.

The group members responsible for front-end and back-end code implementation are different, so code habits may differ.

## About testing:

Due to virtual machine network request issues, it is necessary to use the **real machine** connection project and run the code.

We have only developed projects with Android environment so far, so

-   **Android environment phones** are the **first choice**.
-   It also requires **Android SDK version** greater than 21.
-   The app needs to be given the permission of get location **manually** after the installation.
-   HUAWEI phones may need to be **offline** in order to install the app.

We have also prepared an [apk file](https://drive.google.com/file/d/1DHkAzoU5itsU2hll1CIAhVne4QvchHCF/view?usp=sharing) that Android phones can download and install directly.

If you are using the code to test the application directly, the **dependencies** are required. Please use
`flutter pub get`
and
`flutter run`
in the terminal of the project root folder.

## About image recognition:

Due to the limitations of the API itself, you cannot upload images larger than **4MB**, otherwise an error will be reported.

Since image recognition is an API call, it takes a certain amount of time to identify this plant. It may take about 5 seconds.

Please check the results after **5 seconds** of uploading.

## About users:

Our projects are divided into general users and expert users.

Because not everyone can register as an Expert User, we assign an Expert User account (with our permission).

The registration page can only register ordinary users.

We provide an expert user account for reference.

-   email for expert user: expertone@qq.com
-   password for expert user: 123456
