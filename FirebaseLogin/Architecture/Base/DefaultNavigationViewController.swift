//
//  DefaultNavigationViewController.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/9/20.
//

import UIKit

extension  DefaultNavigationViewController {
    func applyDefaultNaviAppearance() {
        naviBarSetting()
    }
}

class DefaultNavigationViewController: UINavigationController, UINavigationControllerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        visibleViewController?.preferredStatusBarStyle ?? .default
    }
    
    var bgColor: UIColor = .white
    var isTranslucent = false

    var showDressingRoomButton: Bool = true

    var popViewController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
		self.delegate = self   
        naviBarSetting()
  
    }
    
    private func naviBarSetting() {
        // swiftlint:disable line_length
        for controlState in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.disabled] {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline) as Any], for: controlState)
        }
        // swiftlint:enable line_length
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = bgColor
        navigationBar.isTranslucent = isTranslucent
        navigationBar.backItem?.backButtonDisplayMode = .minimal
//        navigationBar.tintColor = UIColor.dark
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font:
                                                UIFont.preferredFont(forTextStyle: .headline) as Any]
        // swiftlint:disable line_length
        navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: UIImage.SymbolWeight.bold, scale: .medium))?.withInsets(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: UIImage.SymbolWeight.bold, scale: .medium))?.withInsets(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        // swiftlint:enable line_length
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        popViewController = viewController
    }
    
	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
 
		let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
		viewController.navigationItem.backBarButtonItem = item
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let presentationController = presentationController, 
            let presentationControllerDelegate = presentationController.delegate {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // reset status bar
                presentationControllerDelegate.presentationControllerDidDismiss?(presentationController)
            }
        }
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)

    }
}

extension UINavigationBar {
    
    func setNavigationBar(alpha: CGFloat, color: UIColor) {
        for obj in self.subviews {
            if let cls = NSClassFromString("_UIBarBackground") {
                if #available(iOS 10.0, *), obj.isKind(of: cls) {
                    DispatchQueue.main.async {
                        if obj.alpha != alpha {
                            obj.alpha = alpha
                        }
                        obj.backgroundColor = color
                    }
                } else {
                    if let navBarBackgroundCls = NSClassFromString("_UINavigationBarBackground") {
                        if obj.isKind(of: navBarBackgroundCls) {
                            DispatchQueue.main.async {
                                if obj.alpha != alpha {
                                    obj.alpha = alpha
                                }
                                obj.backgroundColor = color
                            }
                        }
                    }
                }
            }
        }
    }
    
}
