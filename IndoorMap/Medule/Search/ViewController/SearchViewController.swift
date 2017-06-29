//
//  SearchViewController.swift
//  IndoorMap
//
//  Created by Gu Jiajun on 2017/6/27.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource, AMapSearchDelegate  {
    
    typealias SelectPOIBlock = (_ poi: AMapPOI) -> Void
    var selectPOIBlock: SelectPOIBlock?
    
    var poisArray = NSMutableArray()
    
    var search = AMapSearchAPI()
    
    var searchBarView = SearchBarView()
    let tableView: UITableView = UITableView(frame: UIScreen.main.bounds,style:.plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        setupView()
        
        weak var weakSelf = self
        LocationManager.shared.requestLoctionOnce { (location, reGeocode) in
            
            weakSelf?.searchAround(location: location!)
        }
        
        search!.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchAround(location: CLLocation) {
        let request = AMapPOIAroundSearchRequest()
        
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
        request.requireExtension = true
        
        search?.aMapPOIAroundSearch(request)
    }
    
    func searchKeyword(keyword: String) {
        let request = AMapPOIKeywordsSearchRequest()
        request.keywords = keyword
        request.requireExtension = true
//        request.cityLimit = true
//        request.requireSubPOIs = true
        
        search?.aMapPOIKeywordsSearch(request)

    }
    
    func setupView() {
        weak var weakSelf = self
        searchBarView.shouldGotoSearch = false
        searchBarView.searchBlock = {
            keyword in
            weakSelf?.searchKeyword(keyword: keyword)
        }
        
        self.view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(25)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-60)
            make.height.equalTo(35)
        }
        
        let cancelBtn = UIButton(type: .system)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelAction), for: .touchUpInside)
        self.view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.searchBarView.snp.centerY)
            make.left.equalTo(self.searchBarView.snp.right).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.height.equalTo(35)
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressCell.self, forCellReuseIdentifier: "AddressCell")
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(70)
            make.left.right.bottom.equalTo(self.view);
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poisArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = AddressCell(style: UITableViewCellStyle.default, reuseIdentifier: "AddressCell")
        
        cell.model = poisArray[indexPath.row] as? AMapPOI
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (selectPOIBlock != nil) {
            selectPOIBlock!(poisArray[indexPath.row] as! AMapPOI)
            self.navigationController?.popViewController(animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65;
    }
    
    //MARK
    func cancelAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        if response.count == 0 {
            return
        }
        
        //解析response获取POI信息，具体解析见 Demo
        poisArray.removeAllObjects()
        poisArray.addObjects(from: response.pois)
        self.tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBarView.textField.resignFirstResponder()
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
