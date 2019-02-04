# Miner Sample App iOS

This small smaple iOS app has been created to demonstrate the power of using Heroku for easily and continously developing, integrating, and deploying web applications — particularly in concert with Salesforce. It integrates with the [hello-miner-app](https://github.com/frankcaron/hello-miner-app) light-weight node backend. 

Alternatively, this is a neat little visual front end for consumption of any arbitrary object data from any arbitrary well-formed REST end-point.

# Run Instructions

Make sure to open the Workspace and not the project file. I'm using cocoapods with `Alamofire` for the REST API consumption.

# Modification Instructions

In order to make this work for your use case, you'll need to modify a few things:

1. The `Model` folder contains a single class, "Site", which represents the object and object details you want to display. You'll need to modify that class to represent both the data model of your desired object from Heroku / API as well the path to the API itself, which is declared towards the top of that class.

2. The `Controller` folder contains a class called `SiteTableController`, which deals with the table draws relating to the site itself. You may (read: will likely) need to modify this behaviour based on how you modify the `Site` object.

3. The video in the `Video` folder is called from the `InitialNavController` controller. You can either swap out the video and keep the same code or update both the video and that controller to make the splash screen reflect your desired gorgeousness.

4. The `XCASSETS` folder has the pictures used as table backgrounds. Swapping those out while keeping the same asset name will allow you to update your table.

# Forks, etc.

Feel free! Stars and forks make my heart happy.

# Etc.

Created with love by Frank Caron.
