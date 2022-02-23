//
//  LaunchView.swift
//  TT
//
//  Created by jekun on 2022/1/13.
//

import UIKit

class LaunchViewController: UIViewController {
    
    public var writeList:[[String:Any]] = [
        ["writeClassName": "ViewControllerV2", "writeTag": [1002,102,104,105,106,10005,200,700]]
    ]
    
    lazy var arrowImg: UIImageView = {
        self.arrowImg = UIImageView.init(image: UIImage(named: "icon_ea_indicator"))
        self.arrowImg.isHidden = true
        return self.arrowImg
    }()
    
    lazy var button: UIButton = {
        self.button = UIButton.init(type: .custom)
        self.button.frame.size = CGSize(width: 100, height: 40)
        self.button.setTitle("点击一下", for: .normal)
        self.button.setTitleColor(.white, for: .normal)
        let border:CAShapeLayer = CAShapeLayer.init()
        border.strokeColor = UIColor.white.cgColor
        border.fillColor = UIColor.clear.cgColor
        let path:UIBezierPath = UIBezierPath.init(roundedRect: self.button.bounds, cornerRadius: 6)
        border.path = path.cgPath
        border.frame = self.button.bounds
        border.lineWidth = 2.0
        border.lineDashPattern = [10, 5]
        self.button.layer.cornerRadius = 6
        self.button.layer.addSublayer(border)
        return self.button
    }()
    
    private var writeView:[UIView] = []
    private var selIndex:Int = 0
    
    lazy private var mainWindow:UIWindow = {
        self.mainWindow = self.windowWithLevel(level: UIWindow.Level.normal)
        return self.mainWindow
    }()
    
    lazy public var alertWindow:UIWindow = {
        self.alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        self.alertWindow.windowLevel = .alert
        self.alertWindow.backgroundColor = .clear
        self.alertWindow.rootViewController = self
        return self.alertWindow
    }()
    
    lazy private var backgroudView:UIView = {
        self.backgroudView = UIView.init(frame: UIScreen.main.bounds)
        self.backgroudView.alpha = 0.0
        self.backgroudView.backgroundColor = .black
        self.backgroudView.addSubview(self.backgroudControl)
        return self.backgroudView
    }()
    
    lazy private var backgroudControl:UIControl = {
        self.backgroudControl = UIControl.init(frame: self.backgroudView.bounds)
        self.backgroudControl.addTarget(self, action: #selector(onBgTouchupInsideAction), for: .touchUpInside)
        return self.backgroudControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.addSubview(self.backgroudView)
        view.addSubview(self.arrowImg)
        view.addSubview(self.button)
        creatLayer()
    }
    
    func getWriteTarget() -> [String:Any] {
        for clas in writeList {
            let vc:UIViewController = getVC()
            if String.init(clas["writeClassName"] as! String) == getClassName(vc: vc) {
                return clas
            }
        }
        return [:]
    }
    
    func creatLayer() {
        
        // 控件在控制器的view内
        let target:[String:Any] = getWriteTarget()
        if target.count <= 0 {
            dismiss()
            return
        }
        let vc:UIViewController = getVC()
        var isHave:Bool = false
        var selRect:CGRect = .zero
        for v:UIView in vc.view.subviews {
            if v.tag == (target["writeTag"] as! [Int])[selIndex] {
                isHave = true
                let basicPath = UIBezierPath(rect: backgroudView.bounds) // 底层
                basicPath.append(UIBezierPath.init(arcCenter: v.center, radius: v.frame.width, startAngle: 0, endAngle: 2*Double.pi, clockwise: false))
                let maskLayer = CAShapeLayer()
                maskLayer.path = basicPath.cgPath
                self.backgroudView.layer.mask = maskLayer
                selRect = v.frame
                break
            }
        }
        // 控件在某个view内
        if !isHave {
            for v:UIView in vc.view.subviews {
                // 控件在tableView内
                if v .isKind(of: UITableView.self) {
                    let tbMain:UITableView = v as! UITableView
                    let cells:[IndexPath] = tbMain.indexPathsForVisibleRows ?? []
                    for indexPath in cells {
                        let cell:UITableViewCell = tbMain.cellForRow(at: indexPath)!
                        for subCell:UIView in cell.contentView.subviews {
                            if subCell.tag == (target["writeTag"] as! [Int])[selIndex] {
                                isHave = true
                                let rect = subCell.convert(subCell.convert(subCell.frame, from: cell.contentView), to: tbMain.superview)
                                let basicPath = UIBezierPath(rect: backgroudView.bounds) // 底层
                                basicPath.append(UIBezierPath.init(arcCenter: CGPoint(x: rect.origin.x + rect.width * 0.5, y: rect.origin.y + rect.height * 0.5), radius: rect.width, startAngle: 0, endAngle: 2*Double.pi, clockwise: false))
                                let maskLayer = CAShapeLayer()
                                maskLayer.path = basicPath.cgPath
                                self.backgroudView.layer.mask = maskLayer
                                selRect = rect
                                break
                            }
                        }
                    }
                    if isHave {
                        break
                    }
                }
                // 控件在collectionView内
                else if v .isKind(of: UICollectionView.self) {
                    let clMain:UICollectionView = v as! UICollectionView
                    let cells:[IndexPath] = clMain.indexPathsForVisibleItems
                    for indexPath in cells {
                        let cell:UICollectionViewCell = clMain.cellForItem(at: indexPath) ?? UICollectionViewCell.init()
                        for subCell:UIView in cell.contentView.subviews {
                            if subCell.tag == (target["writeTag"] as! [Int])[selIndex] {
                                isHave = true
                                let rect = subCell.convert(subCell.convert(subCell.frame, from: cell.contentView), to: clMain.superview)
                                let basicPath = UIBezierPath(rect: backgroudView.bounds) // 底层
                                basicPath.append(UIBezierPath.init(arcCenter: CGPoint(x: rect.origin.x + rect.width * 0.5, y: rect.origin.y + rect.height * 0.5), radius: rect.width, startAngle: 0, endAngle: 2*Double.pi, clockwise: false))
                                let maskLayer = CAShapeLayer()
                                maskLayer.path = basicPath.cgPath
                                self.backgroudView.layer.mask = maskLayer
                                selRect = rect
                                break
                            }
                        }
                    }
                    if isHave {
                        break
                    }
                }
                // 控件在view内
                else if v .isKind(of: UIView.self) {
                    for subView:UIView in v.subviews {
                        if subView.tag == (target["writeTag"] as! [Int])[selIndex] {
                            isHave = true
                            let rect = subView.convert(subView.convert(subView.frame, from: v), to: v.superview)
                            let basicPath = UIBezierPath(rect: backgroudView.bounds) // 底层
                            basicPath.append(UIBezierPath.init(arcCenter: CGPoint(x: rect.origin.x + rect.width * 0.5, y: rect.origin.y + rect.height * 0.5), radius: rect.width, startAngle: 0, endAngle: 2*Double.pi, clockwise: false))
                            let maskLayer = CAShapeLayer()
                            maskLayer.path = basicPath.cgPath
                            self.backgroudView.layer.mask = maskLayer
                            selRect = rect
                            break
                        }
                    }
                    if isHave {
                        break
                    }
                }
            }
        }
        setArrowFrame(isShow: isHave, rect: selRect)
        if !isHave {
            onBgTouchupInsideAction()
        }
    }
    
    func setArrowFrame(isShow:Bool, rect:CGRect = .zero) {
        self.arrowImg.isHidden = !isShow
        arrowImg.transform = CGAffineTransform(rotationAngle: 0)
        var newRect:CGRect = CGRect.zero
        var isReversal:Bool = false
        newRect.size = CGSize(width: arrowImg.image!.size.width, height: arrowImg.image!.size.height)
        newRect.origin.x = rect.origin.x + rect.width * 0.5
        newRect.origin.y = rect.origin.y + rect.width * 1.5 + 10
        self.arrowImg.frame = newRect
        if newRect.origin.x < UIScreen.main.bounds.width * 0.1 {
            arrowImg.transform = CGAffineTransform(rotationAngle: .pi * 0.2).inverted()
        }
        else if newRect.origin.x < UIScreen.main.bounds.width * 0.2 {
            arrowImg.transform = CGAffineTransform(rotationAngle: .pi * 0.1).inverted()
        }
        else if newRect.origin.x > UIScreen.main.bounds.width * 0.9 {
            arrowImg.transform = CGAffineTransform(rotationAngle: .pi * 0.2)
        }
        else if newRect.origin.x > UIScreen.main.bounds.width * 0.8 {
            arrowImg.transform = CGAffineTransform(rotationAngle: .pi * 0.1)
        }
        
        let spaceX:CGFloat = newRect.origin.x / (UIScreen.main.bounds.width * 0.5)
        newRect.origin.x = 10 * (2 - spaceX)
        
        if newRect.origin.y > UIScreen.main.bounds.height * 0.7 {
            isReversal = true
            arrowImg.frame.origin.y = rect.origin.y - rect.width * 1.5 - 20
            arrowImg.transform = CGAffineTransform(rotationAngle: .pi)
        }
        
        self.button.isHidden = !isShow
        newRect = arrowImg.frame
        newRect.size = button.frame.size
        if isReversal {
            newRect.origin.y = newRect.minY - newRect.size.height - 15
        }else{
            newRect.origin.y = newRect.maxY + 25
        }
        let space:CGFloat = newRect.origin.x / UIScreen.main.bounds.width
        newRect.origin.x = newRect.origin.x - button.frame.size.width * space
        button.frame = newRect
    }

    func dismiss() -> Void {
        self.alertWindow.isHidden = true
        self.alertWindow.removeFromSuperview()
        self.alertWindow.rootViewController = nil
        self.alertWindow = UIWindow.init()
        self.mainWindow.makeKeyAndVisible()
    }
    
    func showWithAnim() -> Void {
        beforeShow()
        self.alertWindow.makeKeyAndVisible()
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroudView.alpha = 0.8
        }) { (finish) in
            self.afterShow()
        }
    }
    
    public func beforeShow() {
        
    }
    
    public func afterShow() -> Void {
        
    }
    
    func dismissWithAnim() -> Void {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.beforeDismiss()
        }) { (finish) in
            if finish{
                self.dismissExecute()
            }
        }
    }
    
    func dismissExecute() -> Void {
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroudView.alpha = 0.0
        }) { (finish) in
            self.dismiss()
        }
    }
    
    func beforeDismiss() -> Void {
        
    }
    
    @objc func onBgTouchupInsideAction() {
        let tags:[Int] = getWriteTarget()["writeTag"] as! [Int]
        if selIndex >= tags.count - 1 {
            dismissWithAnim()
        }else{
            selIndex += 1
            creatLayer()
        }
    }

}

extension LaunchViewController {
    
    func windowWithLevel(level:UIWindow.Level) -> UIWindow {
        
        let windows = UIApplication.shared.windows
        for window in windows {
            if window.windowLevel == level {
                return window
            }
        }
        return UIWindow.init()
    }
    
    func getVC() -> UIViewController {
        let delegate  = UIApplication.shared.delegate as? AppDelegate
        var current = delegate?.window.rootViewController
        
        while (current?.presentedViewController != nil)  {
            current = current?.presentedViewController
        }
        
        if let tabbar = current as? UITabBarController , tabbar.selectedViewController != nil {
            current = tabbar.selectedViewController
        }

        while let navi = current as? UINavigationController , navi.topViewController != nil  {
            current = navi.topViewController
        }
        return current ?? UIViewController.init()
    }
    
    func getClassName(vc:UIViewController) -> String {
        let name:String = NSStringFromClass(type(of: vc)).components(separatedBy: ".").last ?? ""
        return name
    }
    
}
