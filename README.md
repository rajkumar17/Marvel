# Marvel

The purpose of this project is to develop app using MVVM, and including a Usecase.

![CharactersListScreen](https://user-images.githubusercontent.com/1968356/153556772-850fbf4b-ed77-41ec-80e1-a38d49a11892.png)
![CharacterDetailsScreen](https://user-images.githubusercontent.com/1968356/153556784-a20762d1-f72d-4bcf-9441-e025de9acab7.png)


Features

Characters list: displays a list of characters and their thumbnails.
Character detail: displays a picture of a character and its full description.

Technical details

MVVM Architecture

This app has been developed using an MVVM architectural pattern, which is a combination of the Model-View-ViewModel architecture. In this implementation, the binding between the Views and the ViewModels is done via observer. The app has three major layers:

The Presentation layer, which contains the views and other UIKit-related units.
The Domain layer, which contains the business logic and use cases.
The Data layer, which contains the networking and local data handling, as well as the models and authentication logic needed to connect to the Marvel API.
