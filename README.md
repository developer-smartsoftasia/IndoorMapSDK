# Siam Piwat MappedIn Indoor Map iOS SDK

# Add Pod

```
pod 'SiamPiwatIndoorMapSDK', '0.7.1'
```

```
run pod install
```

# Note

Please make sure!

```
Project -> Build Settings -> Enable Bitcode -> No
Project -> Your Target-> Build Settings -> Enable Bitcode -> No
Project -> Pods -> Build Settings -> Enable Bitcode -> No
```

# Initial SDK in AppDelegate

```

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    override init() {
         super.init()
         SPWIndoorMapSDKManager.shared.initialSDK(slug: .oneSiam,
                                                 shops: [],
                                                 language: .en,
                                                 appDelegate: AppDelegate.self,
                                                 isDebug: true)

         // This is method for initialize IndoormapSDK you need to add it here.
         // MappedIn Service need to initialize with AppDelegate.self
         // remark if you not add it here the app will crash.
     }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
}
```

# Set Debug

```
  SPWIndoorMapSDKManager.shared.setDebugMode(isDebug: true)
```

# Set Simulate Navigation

```
     SPWIndoorMapSDKManager.shared.setSimulateNavigation(simulateNavigation: true)
```

# Set Enable Device Location

import CoreLocation and Privacy to Info.plist
Privacy - Location Always and When In Use Usage Description, Privacy - Location Always Usage Description, Privacy - Location When In Use Usage Description whatever
and add delegate

```
 import CoreLocation

 var manager:CLLocationManager = CLLocationManager()
 self.manager.delegate = self
 self.manager.desiredAccuracy = kCLLocationAccuracyBest

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last{
            print("latitude: \(location.coordinate.latitude) longitude: \(location.coordinate.longitude)")
            SPWIndoorMapSDKManager.shared.updateUserCurrentPosition(location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }


}
```

```
  SPWIndoorMapSDKManager.shared.setEnableDeviceLocation(isEnableDeviceLocation: true)
```

# Set Update User Current Position

before you use this method you need to set EnableDeviceLocation by SPWIndoorMapSDKManager.shared.setEnableDeviceLocation(isEnableDeviceLocation: true)

```
 SPWIndoorMapSDKManager.shared.updateUserCurrentPosition(CLLocationCoordinate2DMake(13.746478, 100.534629))
```

# Set AIS Store

after you initialized the SDK, you have to set AIS store. we use AIS Store Object for display Store Name, Description

```
    SPWIndoorMapSDKManager.shared.setAISShops(shops)
```

| Parameters |                   Description                   |
| ---------- | :---------------------------------------------: |
| Shops      | array of dictionary (same as a structure below) |

Example of AIS JSON Dictionary

```
 {
      "closeAt": [
        "22:00",
        "22:00",
        "22:00",
        "22:00",
        "22:00",
        "22:00",
        "22:00"
      ],
      "lineIds": [""],
      "mall_id": "5baa79c43280ac373f6c06e5",
      "positions": [
        {
          "x": "0",
          "y": "0",
          "z": "0"
        }
      ],
      "tag_ids": [""],
      "isDeleted": false,
      "publish": {
        "publishEndDate": "2119-01-09T03:33:41.720Z",
        "publishStartDate": "2019-01-09T03:33:41.720Z",
        "isPublish": true
      },
      "images": ["https://siampiwat.azureedge.net/shop/5863559047260669.png"],
      "floor_id": "5bc6e1050e17b1204c8829d2",
      "createdAt": "2019-01-08T09:00:54.000Z",
      "name": {
        "cn": "Fix & Wash",
        "en": "Fix & Wash",
        "th": "Fix & Wash"
      },
      "priority": 0,
      "cat_ids": ["5bccb5c913443b4720c2477c"],
      "updatedAt": "2019-10-21T08:14:25.000Z",
      "subcat_ids": ["5bccb5c513443b4720c24770"],
      "descThumbnail": {
        "cn": "",
        "en": "",
        "th": ""
      },
      "lot_no": "BR17",
      "tels": ["+6626581121"],
      "email": "",
      "zone_id": "",
      "id": "5bd9248dabc75d7da0f2c26a",
      "urls": ["https://th-th.facebook.com/fixandwash"],
      "openDay": [true, true, true, true, true, true, true],
      "desc": {
        "cn": "",
        "en": "",
        "th": ""
      },
      "imageThumbnail": "https://siampiwat.azureedge.net/shop/01178384601978566.png",
      "openAt": ["10:00", "10:00", "10:00", "10:00", "10:00", "10:00", "10:00"]
    }
```

# Get Venues

before using the map view you need to call "getVenues". this is a method for getting department store. by the way, this method will filter out the store that not match the ais store JSON that you have set up

```
   self.showLoading()
   SPWIndoorMapSDKManager.shared.getVenues(completion: {
     self.hideLoading()
     self.showMapView()
    }) { (error) in
      self.hideLoading()
      print(error.errorDescription)
    }
```

| Parameters |     Description     |
| ---------- | :-----------------: |
| Completion | completion callback |
| Failure    |  failure callback   |

# Map ViewController

This is a property for getting MapViewController.

```
  let vc = SPWIndoorMapSDKManager.shared.viewController
   self.navigationController?.pushViewController(vc, animated: true)
//        alternative way
//        let navC = UINavigationController(rootViewController: vc)
//        self.present(navC, animated: true, completion: nil)
```

# Get All Stores

you can get all stores by calling this

```
    let stores =  SPWIndoorMapSDKManager.shared.stores()
```

# Get Store by External ID

This is a method for getting store by External ID

```
     SPWIndoorMapSDKManager.shared.store("5bd9248dabc75d7da0f2c421")
```

| Parameters  | Description |
| ----------- | :---------: |
| External ID | ID of store |

# Get Department Store by Slug

```
  if let siamDiscovery = SPWIndoorMapSDKManager.shared.getDepartmentStore(slug: .siamDiscovery) {
     SPWIndoorMapSDKManager.shared.setDepartmentStore(departmentStore: siamDiscovery)
   }
```

# Get Current Department Store

this method will return the department store.

```

    let departmentStore = SPWIndoorMapSDKManager.shared.departmentStore()

```

# Update User Current Location

you can show user current location on map by sending a AISLocation object to this method <br />
if floor id and floor number not the same as active floor the location will not show on map

```
     let location = SPWAISLocation(isIndoor: true, latitude: "13.7466", longitude: "100.534629",
                                        builId: "4409", buildName: "Siam Paragon", floorId: "8288", floorNumber: "0")
    SPWIndoorMapSDKManager.shared.updateUserCurrentPosition(location)
```

# Get Closest Store

```
        SPWIndoorMapSDKManager.shared.setFloor(by: 0)
        let location = SPWAISLocation(isIndoor: true, latitude: "13.7466", longitude: "100.534629",
                                        builId: "4409", buildName: "Siam Paragon", floorId: "8288", floorNumber: "0")
        let store = SPWIndoorMapSDKManager.shared.getClosestStore(location: location)
```

# Set Origin

```
  SPWIndoorMapSDKManager.shared.setOrgin(storeA)
```

# Set Destination

```
  SPWIndoorMapSDKManager.shared.setDestination(storeA)
```

# Set Origin and Destination

```
   SPWIndoorMapSDKManager.shared.setOrginAndDestination(orgin: storeA, destination: storeB)
```

# Reset origin and destination

```
     SPWIndoorMapSDKManager.shared.resetOrginAndDestination()
```

# Set Floor by floor number

0 is G , B is -1

```
    SPWIndoorMapSDKManager.shared.setFloor(by: -1)
```
