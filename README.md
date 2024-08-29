#  Dessert/Recipe App by Fabrice Gehy

## App Overview
The app was built with Xcode 15.4. To build the app, pull the `main` branch and run the project. Note: In a work environment, this work would've been separated into multiple branches/PRs. I elected to do this all in one branch & one PR since I'm the only one reviewing the work for this assignment.

This app displays a list of desserts from https://themealdb.com/api.php. Upon opening the app, all desserts will be downloaded and displayed. Tapping a recipe on the list will lead you to a screen to view additional details for the selected recipe. 

## Architecture
The app is made up of 3 layers: the network layer, data/model layer, and view/UI layer. 

### Network Layer
    * Contains the protocol `MealNetworkService` which defines a blueprint of all possible data transfer objects that can be fetched from a remote data source.
    
    * The `MealNetworkManager` actor adopts the `MealNetworkService` protocol and handles the fetching of data from the API. It will also throw custom `MealError`s should issues arise with fetching or decoding. 
    
### Data layer
    * Contains the protocol `MealDataService` which defines all actions available to get recipe data. This layer will communicate with the network layer to obtain data as needed.
    
    * The `MealDataManager` adopts the `MealDataService` protocol and handles all data manipulation needs, including converting models from the remote source into custom types that can be used by the UI layer. Errors thrown from the network layer will pass through here to the UI layer as well.
     At the moment, all data is constantly being sourced from the network layer. If we ever needed to store this data locally, the data manager would also handle this behavior and make the decision to fetch from the remote source or get data locally.
     
     Given the `MealNetworkManager` and `MealDataManager` handle fetching and data manipulation for the app, I decided to make them `actor`s to ensure thread safety (since these instances could be shared in different parts of the app) and improve performance. Given the simplicity of the app in its current iteration, they are not storing any mutable state (just fetching and returning). However, this ensures that the app is already set up for this should the app get more complex in the future (e.g if we were to implement data storage or data update requirements).
    
### UI Layer
    * The UI layer uses the MVVM pattern to separate view setup from data manipulation for the UI. The view model will interact with the data layer to get recipe data, manipulate that data as needed for the UI, and pass the data to the view layer to display.
    
    * View hierarchy:
        * `MealListView` and its associated view model, `MealListViewModel`, handle the UI for the full list of recipes.
        * `MealDetailView` and its associated view model, `MealDetailViewModel`, handle the UI for the screen displaying recipe details.
        
    * UI Assets
        * For readability and reuse purposes, most components used in the views listed above are broken down into separate views.
        
        
## Testing
    * The `DessertProject.app` has about 50% code coverage
    * Critical functionality in managers are covered by unit tests.
    * Critical functionality in view models are covered by unit tests.
    * The views themselves are not covered at the moment by that can be done with snapshot tests. This allows us to visually detect any changes in the UI by comparing a base image to an image generated for each test.
        * To accomplish this, I would've used the `swift-snapshot-testing` library (https://github.com/pointfreeco/swift-snapshot-testing) and added it to the app using Swift Package Manager.





