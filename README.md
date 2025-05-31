# Kitman Labs Mobile Tech Test API



_A simple API to be use for Kitman Labs mobile team tech tests._

## Implementation
[Architectural Overview](file:///./MobileTextTest/Docs/architecture.png)

### Features
- clean Architecture
    - Network layer / APIRequestManager
    - Model layer via APIClient for Model instantiation
    - Dedicated observable ViewModels on top of model layer to load / propagate change
- loose coupling via protocol classes that enable mocking via protocol conforming mocks
- Dependency injection based on protocol to enable tests
- Dedicated modules with a single reponsibility to support loose coupling
- Unit tests via SwiftTesting     

### Shortcuts
- Simplistic UI 
- No localisation / localised bundle
- No accessibility support
- No Errorhandling
- dataModels used as viewmodels
- ImageCache is not routed through Network layer (APIRequestManager / APIClient)
- no xcuitests
- initial set of unit tests for demonstration purposes
- no snapshot tests

### Thoughts
- API methods squads / athletes should require authentication
- API methods squads / athletes should allow for individual Id e.g. /squad/<id> , /athlete/<id>



## Challenge

The base challenge is to create a small app with a basic login along with a view that displays a list of athletes along with an athlete details screen. The UI isn't expected to be beautiful as it's a tech test, not an art piece, but give consideration to UX and general app flow.

The exact end product is up to you, you will have access to athlete's squads so if you find a way to utilise that, even better.

Spend no more than a day working on it, we understand this is your free time and don't want to take up any more than necessary.

Use this as an opportunity to showcase your own engineering values along with what you feel are important aspects of mobile app development. While you possibly won't be able to include everything you wanted, make the most of what you can and tell us what you would've like to of added or expanded given more time. 

You can use what ever libraries you feel necessary.

**Delieverable**

* Ideally a Github/bitbucket link to a repo containing the app. If that's not possible, send over a full runnable zip of the project/workspace.

Base URL:  [https://kml-tech-test.glitch.me](https://kml-tech-test.glitch.me)

### Endpoints

#### Athletes

Returns a list of athletes

* Method:       `GET`
* Path:         `/athletes`
* Content Type: `application/json`
* Params:        None

Sample Response: 
``` 
[
   {
      "first_name":"Adam",
      "last_name":"Beard",
      "id":1964,
      "image":{
         "url":"https://kitman.imgix.net/avatar.jpg"
      },
      "username":"abeardathlete",
      "squad_ids":[
         78
      ]
   },
   {
      "first_name":"Al",
      "last_name":"Saunders",
      "id":5011,
      "image":{
         "url":"https://kitman.imgix.net/avatar.jpg"
      },
      "username":"asaunders",
      "squad_ids":[
         78
      ]
   }
]
```

#### Squads

Returns a list of squads

* Method:       `GET`
* Path:         `/squads`
* Content Type: `application/json`
* Params:        None

Sample Response: 
``` 
[
   {
      "created_at":"2015-09-14T18:26:11.000Z",
      "id":78,
      "name":"staff",
      "organisation_id":6,
      "updated_at":"2015-09-14T18:26:11.000Z"
   },
   {
      "created_at":"2015-09-02T19:42:22.000Z",
      "id":72,
      "name":"Active Roster",
      "organisation_id":6,
      "updated_at":"2015-09-02T19:42:22.000Z"
   }
]
```
#### Session

Dummy login end point, any username and password combination will work once they are three characters or more. Just use to validate your login flow.

* Method:       `POST`
* Path:         `/session`
* Content Type: `application/json`
* Body:        
```
{
    "username": "sampleUsername",
    "password": "samplePassword"
}
```

Sample Response: 
```
{
    "username": "sampleUsername"
}
```
