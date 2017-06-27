//
//  SearchBarView.swift
//  IndoorMap
//
//  Created by Gu Jiajun on 2017/6/27.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchBarView: UIView, UITextFieldDelegate {

    typealias GotoSearchBlock = () -> ()
    typealias SearchBlock = (_ keyword: String) -> Void

    
    var textField = UITextField()
    var shouldGotoSearch = true //是否跳转去搜索
    var gotoSearchBlock: GotoSearchBlock?
    var searchBlock: SearchBlock?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        
        textField.placeholder = "搜索"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .none
        textField.delegate = self
        self.addSubview(textField)
        textField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).offset(-5)
        }
    }
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if shouldGotoSearch {
            gotoSearchBlock!()
        } else {
            return true
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty)! {
            searchBlock!(textField.text!)
        }
        return true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
