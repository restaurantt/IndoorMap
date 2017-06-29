//
//  AddressCell.swift
//  IndoorMap
//
//  Created by Gu Jiajun on 2017/6/28.
//  Copyright © 2017年 gjj. All rights reserved.
//

import UIKit
import Kingfisher

class AddressCell: UITableViewCell {

    var iconView:   UIImageView = UIImageView(image: UIImage(named: "setIcon"))
    var nameLbl:       UILabel = UILabel()
    var addressLbl:      UILabel = UILabel()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.width.height.equalTo(40)
        }
        
        self.contentView.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(15)
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.height.equalTo(20)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
        }
        
        addressLbl.numberOfLines = 2
        addressLbl.font = UIFont.systemFont(ofSize: 14)
        addressLbl.textColor = UIColor.lightGray
        self.contentView.addSubview(addressLbl)
        addressLbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(15)
            make.top.equalTo(self.nameLbl.snp.bottom).offset(5)
//            make.height.equalTo(40)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
        }
    }
    
    var model: AMapPOI? {
        willSet {
            
            nameLbl.text = newValue?.name
            addressLbl.text = newValue?.address
            
            if (newValue?.images.count)! > 0 {
                let imageObj: AMapImage = (newValue?.images[0])!
                
                let url = URL(string: imageObj.url)
                iconView.kf.setImage(with: url, placeholder: UIImage(named: "logo"), options: nil, progressBlock: { (current, total) in
                    
                }) { (image, error, CacheType, imageUrl) in
                    
                }

            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
