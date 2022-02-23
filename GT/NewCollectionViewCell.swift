//
//  NewCollectionViewCell.swift
//  GT
//
//  Created by jekun on 2022/1/14.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {
    
    var titleL: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayCell(tag:Int) {
        titleL.tag = tag
    }
    
    func setupView() {
        titleL = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 20))
        titleL.text = "123123"
        contentView.addSubview(titleL)
    }
    
}
