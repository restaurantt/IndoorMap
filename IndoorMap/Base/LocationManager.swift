//
//  LocationManager.swift
//  IndoorMap
//
//  Created by Gu Jiajun on 2017/6/28.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: AMapLocationManager/*, AMapLocationManagerDelegate*/ {

    
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        
        self.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        self.locationTimeout = 2
        
        self.reGeocodeTimeout = 2
    }
    
    func requestLoctionOnce(complated: @escaping (_ mlocation: CLLocation?,_ mreGeocode: AMapLocationReGeocode?) -> Void) {
        self.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            if let location = location {
                NSLog("location:%@", location)
            }
            
            if let reGeocode = reGeocode {
                NSLog("reGeocode:%@", reGeocode)
            }
    
            complated(location, reGeocode)
        })
    }
}
