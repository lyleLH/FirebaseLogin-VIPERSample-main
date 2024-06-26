//
//  TabbarViewController.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/24.
//

import UIKit

class MTTabbarViewController: PTCardTabBarController {

    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        let vc1 = MTNavigationViewController(rootViewController: CreationRouter.createModule().entry!)
        let vc2 = MTNavigationViewController(rootViewController: RecordRouter.createModule().entry!)
        let vc3 = MTNavigationViewController(rootViewController: ProfileRouter.createModule().entry!)
        
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "calendar"), tag: 2)
        vc3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "more"), tag: 3)
        
        self.viewControllers = [vc1, vc2, vc3]
        
        super.viewDidLoad()
    }
}
