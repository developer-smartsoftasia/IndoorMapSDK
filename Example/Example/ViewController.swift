//
//  ViewController.swift
//  Example
//
//  Created by Jeremy on 17/9/2563 BE.
//

import UIKit
import IndoorMap
import RxSwift
import RxCocoa
import CoreLocation

class ViewController: UIViewController {
    private let bag = DisposeBag()
    
    var manager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var shops:[[String:Any]] = []
        
        // this is AIS shop
        if let path = Bundle.main.path(forResource: "shop", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let json = jsonResult as? [String:Any], let shopJSON = json["shop"] as? [[String:Any]]{
                    shops = shopJSON
                }
            }catch let error {
                print(error.localizedDescription)
            }
        }
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        
        SPWIndoorMapSDKManager.shared.initialSDK(slug: .oneSiam,
                                                 shops: shops,
                                                 language: .th,
                                                 appDelegate: AppDelegate.self, isDebug: false)
        self.showLoading()
        SPWIndoorMapSDKManager.shared.getVenues(completion: {
            self.hideLoading()
            SPWIndoorMapSDKManager.shared.resetOrginAndDestination()
            
            if let store = SPWIndoorMapSDKManager.shared.store("5bd9248dabc75d7da0f2c58e"), let name = store.nameLocalized(){
                print("\(name)")
                SPWIndoorMapSDKManager.shared.setDestination(store)
            }
            self.showMapView()
        }) { (error) in
            self.hideLoading()
            print(error.errorDescription)
        }
        
        SPWIndoorMapSDKManager.shared.setEnableDeviceLocation(isEnableDeviceLocation: true)
        self.manager.startUpdatingLocation()
        self.manager.requestAlwaysAuthorization()

    }
    
    func showMapView(){
        let vc = SPWIndoorMapSDKManager.shared.viewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.view.makeToastActivity(.center)
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async {
            self.view.hideToastActivity()
            self.view.hideAllToasts()
        }
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let mock = [SPWAISLocation(isIndoor: true, latitude: "13.746478", longitude: "100.534629",
                                                          builId: "4409", buildName: "Siam Paragon", floorId: "8288", floorNumber: "0"),
                                     SPWAISLocation(isIndoor: true, latitude: "13.7465", longitude: "100.534629",
                                                          builId: "4409", buildName: "Siam Paragon", floorId: "8290", floorNumber: "1"),
                                     ]
        
        SPWIndoorMapSDKManager.shared.updateUserCurrentPosition(CLLocationCoordinate2D(latitude: 13.746478, longitude: 100.534629))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }
    
    
}
