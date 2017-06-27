//
//  SearchViewController.swift
//  IndoorMap
//
//  Created by Gu Jiajun on 2017/6/27.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    var searchBarView = SearchBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        weak var weakSelf = self
        searchBarView.shouldGotoSearch = false
        searchBarView.searchBlock = {
            keyword in
            print(keyword)
        }
        
        self.view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(25)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(35)
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
