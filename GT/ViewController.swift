//
//  ViewController.swift
//  TT
//
//  Created by jekun on 2022/1/13.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    lazy private var collectionView: UICollectionView = {
        self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: self.flowlayout)
        self.collectionView.register(NewCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "NewCollectionViewCell")
        self.collectionView.backgroundColor = .systemOrange
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        return self.collectionView
    }()
    
    lazy private var flowlayout: UICollectionViewFlowLayout = {
        self.flowlayout = UICollectionViewFlowLayout.init()
        self.flowlayout.sectionInset = UIEdgeInsets.zero
        self.flowlayout.minimumLineSpacing = 12
        self.flowlayout.minimumInteritemSpacing = 12
        self.flowlayout.itemSize = CGSize(width: (UIScreen.main.bounds.width  - 36) * 0.5, height: 40)
        self.flowlayout.scrollDirection = .vertical
        return self.flowlayout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupTableView()
        setupCollectionView()
        setupBtnInView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let vc:LaunchViewController = LaunchViewController()
        vc.showWithAnim()
    }
    
    func setupView() {
        for i in 1..<7 {
            let btn = UIButton.init()
            btn.tag = 100 + i
            btn.setTitle("😂", for: .normal)
            btn.setTitleColor(.red, for: .normal)
            btn.backgroundColor = .red
            view.addSubview(btn)
            btn.frame = CGRect(x: 50 * i, y: 100, width: 30, height: 30)
        }
    }
    
    func setupTableView() {
        tableView = UITableView.init(frame: CGRect(x: 12, y: 150, width: UIScreen.main.bounds.width - 24, height: 200), style: .plain)
        tableView.register(newCell.classForCoder(), forCellReuseIdentifier: "newCell")
        tableView.backgroundColor = .systemPink
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    func setupCollectionView() {
        view.addSubview(self.collectionView)
        self.collectionView.frame = CGRect.init(x: self.tableView.frame.minX, y: self.tableView.frame.maxY + 20, width: tableView.frame.width, height: 200)
    }
    
    func setupBtnInView() {
        let btn:UIButton = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: 50, height: 60))
        btn.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        let bgV:UIView = UIView.init(frame: CGRect.init(x: tableView.frame.minX, y: collectionView.frame.maxY + 20, width: tableView.frame.width, height: 100))
        bgV.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        btn.tag = 200
        bgV.addSubview(btn)
        view.addSubview(bgV)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:newCell = tableView.dequeueReusableCell(withIdentifier: "newCell") as! newCell
        cell.contentView.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        cell.displayCell(tag: 1000 + indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:NewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCell", for: indexPath) as! NewCollectionViewCell
        cell.contentView.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        cell.displayCell(tag: 10000 + indexPath.item)
        return cell
    }
    
}

