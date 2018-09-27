# YieldManager IOS SDK
Nektria gives an SDK to integrate the service of time windows closing. This SDK acts as a middleware in order to ease the integration between the Yield Manager API and IOS clients.

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Features
- Persist a location with its GPS.
- Generate open/closed time windows for a specific order.

## Requirements
- IOS 10+
- Xcode 8.3+
- Swift 4+

## Installation
### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
```bash
$ gem install cocoapods
```
To integrate this SDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'YieldManager', '~> 0.0.2'
end
```
Then, run the following command:

```bash
$ pod install
```

### Manually
If you prefer not to use cocoapods, you can integrate this SDK into your project manually.

#### Embedded Framework
- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add YieldManager as a git [submodule](https://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/nektria/yieldmanager-ios.git
  ```

- Open the new `YieldManager` folder, and drag the `YieldManager.xcodeproj` into the Project Navigator of your application's Xcode project.

- Select the `YieldManager.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Select `YieldManager.framework`.

- And that's it!

## Usage
### Sending a location
```swift
import YieldManager

Client.shared.baseUrl = "https://<your-dedicated-url>/api/v1"
Client.shared.apiKey = "your-api-key"

let request = CreateLocationRequest(
    address: "Avda Diagonal 440, Barcelona",
    postalCode: "08037",
    elevator: true
)
Client.shared.create(with: request) { (response, error) in
    // Request has finished.
}
```

### Generating time windows for a specific order
```swift
import YieldManager

Client.shared.baseUrl = "https://<your-dedicated-url>/api/v1"
Client.shared.apiKey = "your-api-key"

let request = GenerateTimeWindowsRequest(
    address: "Avda Diagonal 440",
    postalCode: "08015",
    elevator: true,
    weight: 1000,
    startTime: "2018/09/20 10:00",
    endTime: "2018/09/22 12:00"
)

Client.shared.retrieveGrid(with: request) { (response, error) in
    guard response != nil && response?.timeWindows != nil else {
        return
    }

    let closedTimeWindows = response?.timeWindows?.filter(by: .closed)

    for closedTimeWindow in closedTimeWindows! {
        // ...
    }
}
```
## Credits
This SDK is owned and maintained by [Nektria](https://www.nektria.com)

## License
[See LICENSE](https://github.com/nektria/yieldmanager-ios/blob/master/LICENSE) for details.
