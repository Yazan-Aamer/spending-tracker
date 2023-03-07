# Spending Tracker App


## Dependency injection
I made use of the `get_it` package for implementing DI __not to be confused with GetX__
this is mainly in order to apply the separation of concerns principle and programming for 
and interface. not an implementation. The service locator file is located in the root 
of the project with name `sl.dart` for _service locator_.

## State management
The simplicity of the logic actually made this choice. not me. State management is 
not-immutable, `change notifier` delivered with the provider package.

## Architecture
* This code follows Clean Architecture paradigm. 
* The app is plitted into 3 main layers. domain, data, ui

#### domain
This is the central layer in the app. It has no dependencies on any other framework 
and must be written entierly in `dart`. which is in this case. 


#### data
Data layer is responsible for managing datasources and delivering it to the app. 

### ui
Here is where flutter stuff live.


## Models
* Transaction - category, summary, ammount, date,


### Current issues
- [X] performance issue - resolved




