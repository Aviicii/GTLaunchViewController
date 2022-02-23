//
//  BaseTabbarVC.swift
//  GT
//
//  Created by jekun on 2022/1/17.
//

import UIKit

class BaseTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .red
        setupView()
        // Do any additional setup after loading the view.
    }

    func setupView() {
        self.view.backgroundColor = .yellow
        for i in 0...3 {
            var vc:UIViewController
            if i == 1 {
                vc = ViewControllerV2()
            }else{
                vc = ViewController()
            }
            vc.title = "\(i)"
            let nav:UINavigationController = UINavigationController.init(rootViewController: vc)
            nav.tabBarItem.title = "\(i)"
            nav.tabBarItem.tag = 500 + i
            self.addChild(nav)
        }
    }

}
