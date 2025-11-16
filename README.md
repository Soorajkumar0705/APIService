
# APIService — Custom Swift Networking Layer Module

A modular, flexible, and lightweight networking layer for Swift/iOS built using async/await.  
Supports dynamic request bodies, custom headers, endpoint-driven API structure, and centralized error handling.

## Features

- Easy API calls using `async/await`
- Encodable, Data, or Dictionary request bodies
- Automatic JSON decoding
- Reusable endpoint-based architecture
- Global authentication headers
- Custom status-code handling
- Clean and maintainable structure

## Installation (SPM)

Add using Swift Package Manager:

```
https://github.com/Soorajkumar0705/APIService
```

## Configuration
Configuration of the api service includes multiple stages.


### 1. Instantiate APIService 
> - Intantiate the class using the `APIServiceFactory`.
> - Create a global Instance of the `APIServiceClientType` protocol Type.
> - Using the Factory and Builder feed your custom configurations in the `APIServiceClient` class.
> - The Delegate here Provides a method of callback events when any of the provided `HTTP Status Codes` will be sent from the server.
> - set Authentication headers are, when you have api to call with the auth, Feed them and it will be automatically be passed in the API Headers.

> 💡NOTE: Set the Header Key `"X-Session-Token"` as well as the value `"Session Token Value"` as in the below example.

```swift

// Declare the global instance In the DI or VM class.
var apiService : APIServiceClientType!

func instantiateAPIService() {
    apiService = APIServiceFactory()
        .setDelegate(self)
        .setAuthenticationHeader([
            .init(
                field: .init("X-Session-Token"),
                value: .init("Session Token Value")
            )
        ])
        .setCustomHandlingStatusCode([401])
        .make()
}

```

#### What You Can Customize here.

| Method                                | Purpose                                       |
| ------------------------------------- | --------------------------------------------- |
| `.setDelegate(self)`                  | Receive callbacks for status codes            |
| `.setAuthenticationHeader([])`        | Set default headers globally                  |
| `.setCustomHandlingStatusCode([Int])` | Add custom status codes that trigger delegate |
| `.make()`                             | Build the APIService instance                 |



##### Custom Handling Status Codes

- In Custom Handling Status Codes, pass those HTTP Status codes which you want a call back event from the APIService class.
- This call back event feature is mainly designed to handle such scenarios when the `Session Token` or `Refresh Token` gets expired and we have to Navigate or Route the user to Authentication screen.
- In Such Scenarios Set the Specific HTTP Status codes which are expected from the server, when any of the `Session Token` or `Refresh Token` gets expired.
- When Any of the code will be recieved from the server it will give the call back event.


```swift

extension ViewController : APIServiceDelegate {
    
    func didReceiveResponse(with statusCode: Int, data: Data?) {
        
    }
    
}

```

---

## Create API Endpoints
Endpoints are created using an enum that conforms to APIEndpointEnumType.

```swift

enum UsersEndpoint {
    case fetchUsers
}

```


Extend the enum and configure each endpoint with the specific Details.


```swift


extension UsersEndpoint: APIEndpointEnumType {

    var baseURL: String { Constant.API.baseURL }
    var versionURL: String { Constant.API.versionURL }

    func getEndpoint() -> any APIEndpointType {
        switch self {
        case .fetchUsers:
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "users",
                method: .GET,
                headers: [],
                params: nil
            )
        }
    }
}

```

#### Endpoint Breakdown

| Property     | Meaning                                  |
| ------------ | ---------------------------------------- |
| `baseURL`    | Base API URL                             |
| `versionURL` | API versioning, if used                  |
| `path`       | Endpoint path e.g. `"users"`             |
| `method`     | `.GET`, `.POST`, `.PUT`, `.DELETE`       |
| `headers`    | Additional endpoint-specific headers     |
| `params`     | Request body (Encodable/Data/Dictionary) |


## GET API Call

```swift
func getData() {
    Task {
        do {
            let apiResult = try await apiService.getData(
                endpoint: UsersEndpoint.fetchUsers,
                successResponseModelType: [UserData].self
            )
            
            print("Found response: \(apiResult)")
        } catch let error {
            if let error = error as? APIService.APIServiceErrorType {
                error.log()
            } else {
                print(error)
            }
        }
    }
}
```
















