//
//  newCell.swift
//  GT
//
//  Created by jekun on 2022/1/14.
//

import UIKit

class newCell: UITableViewCell {
    
    var btn: UIButton!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayCell(tag:Int) {
        btn.tag = tag
    }
    
    func setupView() {
        btn = UIButton.init(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        btn.backgroundColor = .orange
        contentView.addSubview(btn)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
    }

    @objc func btnAction(sender:UIButton) {
        debugPrint(sender.tag)
    }
}
