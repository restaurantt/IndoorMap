//
//  HomeViewController.swift
//  IndoorMap
//
//  Created by Gu Jiajun on 2017/6/27.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import CoreLocation

class HomeViewController: BaseViewController, MAMapViewDelegate {

    var mapView: MAMapView!
    var searchBarView = SearchBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMapView()
        setupView()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func initMapView() {
        
        mapView = MAMapView(frame: self.view.bounds)
        mapView.isShowsIndoorMap = true
        mapView.isShowsIndoorMapControl = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.compassOrigin = CGPoint(x: mapView.compassOrigin.x, y: 60)
        mapView.showsScale = true
        mapView.scaleOrigin = CGPoint(x: 5, y: mapView.bounds.size.height-40)
        //缩放级别（默认3-19，有室内地图时为3-20）
        mapView.zoomLevel = 15
        self.view.addSubview(mapView!)
    }
    
    func setupView() {
        weak var weakSelf = self
        searchBarView.gotoSearchBlock = {
            let vc = SearchViewController()
            weakSelf?.navigationController?.pushViewController(vc, animated: true)
        }
        self.view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(25)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(35)
        }
    }

    func checkLocationAuth() {
        if(CLLocationManager.authorizationStatus() != .denied) {
            print("应用拥有定位权限")
        }else {
            
            let alert = UIAlertController(title: "打开定位开关", message:"定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,并允许使用定位服务", preferredStyle: .alert)
            let tempAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            }
            let callAction = UIAlertAction(title: "立即设置", style: .default) { (action) in
                let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                if UIApplication.shared.canOpenURL((url?.absoluteURL)!) {
                    
                }
                
            }
            alert.addAction(tempAction)
            alert.addAction(callAction)
            self.present(alert, animated: true, completion: { 
                
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
