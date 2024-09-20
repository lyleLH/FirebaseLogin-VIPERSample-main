//
//  WindowRoute.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/15.
//

import UIKit


enum ModuleType: String {
    
    case splashPage = "splash"
    case loginPage = "login"
    case Home = "home"
    
    
}

class ModuleRoute: NSObject {
    
    private(set) weak var window: UIWindow?
    
    @MainActor
    func routeToModuleRootPage(_ module: ModuleType, withWindow: UIWindow )  -> UIViewController {
        var vc = UIViewController()
        switch module {
        case .splashPage:
            vc = UINavigationController(rootViewController: SplashRouter.createModule().entry as! UIViewController)
            
        case .loginPage:
            vc = UINavigationController(rootViewController: SignInRouter.createModule().viewController)
            
        case .Home:
            vc = MTTabbarViewController()
        }
        self.window = withWindow
        
        return vc
    }
    
    
}
