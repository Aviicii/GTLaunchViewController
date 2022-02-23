# GTLaunchViewController
引导图
说明：后续可使用单例在AppDelegate中设置白名单数组

     writeList:[[String:Any]] = [
                                 ["writeClassName": "ViewControllerV2", 
                                  "writeTag": [1002,102,104,105,106,10005,200,700]
                                 ]
    ]
    
    "writeClassName": 白名单控制器名称
    "writeTag":       白名单控件Tag（当前控制器内指定唯一tag才能找到控件，找不到跳到下一个）
    
 后续更新：
    1.镂空处增加多种样式（矩形等）
    2.增加单例方法
    3.增加点击处为图片样式

<<TableView中Cell某个控件>>
![Image text](https://github.com/Aviicii/GTLaunchViewController/blob/main/png/1.png)

<<控制器View上某个控件>>
![Image text](https://github.com/Aviicii/GTLaunchViewController/blob/main/png/2.png)

<<CollectionView中Cell某个控件>>
![Image text](https://github.com/Aviicii/GTLaunchViewController/blob/main/png/3.png)

<<控制器View嵌套View中某个控件>>
![Image text](https://github.com/Aviicii/GTLaunchViewController/blob/main/png/4.png)



