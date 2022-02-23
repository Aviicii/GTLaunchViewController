//
//  ViewControllerV2.swift
//  GT
//
//  Created by jekun on 2022/1/17.
//

import UIKit

class ViewControllerV2: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI() {
        let btn:UIButton = UIButton.init(type: .custom)
        btn.setTitle("123", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.tag = 700
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }

}
