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
    case home = "home"
}

class ModuleRoute: NSObject {
    
    private(set) weak var window: UIWindow?
    
    func routeToModuleRootPage(_ module: ModuleType, withWindow: UIWindow ) ->
    UIViewController {
        var vc = UIViewController()
        switch module {
        case .splashPage:
            vc = UINavigationController(rootViewController: SplashRouter.createModule().entry!)
        case .loginPage:
            vc = UINavigationController(rootViewController: SignInRouter.createModule().viewController)
            
        case .home:
            vc = MTTabbarViewController()
        }
        self.window = withWindow
        
        return vc
    }
    
}
