
# APIService — Swift Networking Layer

A modular, flexible, and lightweight networking layer for Swift/iOS built using async/await.  
Supports dynamic request bodies, custom headers, endpoint-driven API structure, and centralized error handling.

---

## 🚀 Features

- Easy API calls using `async/await`
- Encodable, Data, or Dictionary request bodies
- Automatic JSON decoding
- Reusable endpoint-based architecture
- Global authentication headers
- Custom status-code handling
- Clean and maintainable structure

---

# 📦 Installation (SPM)

Add this package using Swift Package Manager:

https://github.com/Soorajkumar0705/APIService


---

# ⚙️ Setup — Instantiate APIService


```swift

// Declare global instance
var apiService : APIServiceClientType!

func instantiateAPIService() {
    apiService = APIServiceFactory()
        .setDelegate(self)
        .setAuthenticationHeader([
            .init(
                field: .init("X-Session-Token"),
                value: .init("Session")
            )
        ])
        .setCustomHandlingStatusCode([401])
        .make()
}

```

### What You Can Customize here.

| Method                                | Purpose                                       |
| ------------------------------------- | --------------------------------------------- |
| `.setDelegate(self)`                  | Receive callbacks for status codes            |
| `.setAuthenticationHeader([])`        | Set default headers globally                  |
| `.setCustomHandlingStatusCode([Int])` | Add custom status codes that trigger delegate |
| `.make()`                             | Build the APIService instance                 |


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


### Get API Example 

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
















