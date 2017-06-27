//
//  HomeViewController.swift
//  IndoorMap
//
//  Created by Gu Jiajun on 2017/6/27.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit


class HomeViewController: BaseViewController, MAMapViewDelegate {

    var mapView: MAMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMapView()
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
        self.view.addSubview(mapView!)
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
