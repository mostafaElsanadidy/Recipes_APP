//
//  Reload.swift
//  MadeInKuwait
//
//  Created by Amir on 1/29/20.
//  Copyright © 2020 Amir. All rights reserved.
//

import UIKit

extension AppDelegate:ReloadDelegate {
    
    func isLoggedIn() -> Bool {
        
        if let x = UserDefaults.standard.object(forKey: "Logged") as? String {
            if x.isEmpty {
                return false
            }else{
                return true
            }
        }
        else {
            return false
        }
    }
    
    func goToHomeVC() {
        goToHomeVC(window: ad.window!)
    }
    
}


protocol ReloadDelegate {
    func goToHomeVC(window:UIWindow)
}

extension ReloadDelegate {
    
    func goToHomeVC(window:UIWindow) {
        

        let transition: UIView.AnimationOptions = .transitionFlipFromLeft
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let nav1 = UINavigationController()
        nav1.navigationBar.tintColor = #colorLiteral(red: 0.7997059226, green: 0.6618819237, blue: 0.3807252049, alpha: 1)

        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
     //   let MainDiscoveryVC = storyboard.instantiateViewController(withIdentifier :"MainDiscoveryVC") as! SearchVC
        let MainDiscoveryVC = HomeVC()
        let navController = UINavigationController.init(rootViewController: MainDiscoveryVC)
        
        
        //ad.isLoggedIn() ? homeVC  : loginVC )

//        let newRoot  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootTabBar")
        
        
        if #available(iOS 13.0, *) {
            if let delegate = UIApplication.shared.connectedScenes.first?.delegate {
                if let window = (delegate as? SceneDelegate)?.window {
                    window.rootViewController =  navController
                    window.makeKeyAndVisible()
                    
                }
                
            }
            else {
                rootviewcontroller.rootViewController =  navController
                rootviewcontroller.makeKeyAndVisible()
            }
        } else {
            // Fallback on earlier versions
        }

        let mainwindow = (UIApplication.shared.delegate?.window!)!
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
            
        }
    }

//    func goToHomeVC(window:UIWindow) {
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        //LOGIN
//        let loginVC = storyboard.instantiateViewController(withIdentifier :"LoginVC") as! LoginVC
//        //HOME
//        let homeVC = storyboard.instantiateViewController(withIdentifier :"HomeVC") as! HomeVC
//
//
//        let navController = UINavigationController.init(rootViewController: ad.isLoggedIn() ? homeVC  : loginVC )
//
//
//        //        let navController = UINavigationController.init(rootViewController: loginVC)
//
//        //        navController.isNavigationBarHidden = true
//        //        let yourBackImage = UIImage(named: "return-arrow")
//        //        navController.navigationBar.backIndicatorImage = yourBackImage
//        //        navController.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//        navController.navigationBar.topItem?.title = ""
//
//
//        window.rootViewController = navController
//        window.makeKeyAndVisible()
//
//    }
}
