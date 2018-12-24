//
//  LoginViewController.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 22.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        Settings.login = loginTextField.text ?? "9953454763"
        Settings.password = passwordTextField.text ?? "Forever$4"
//        var phoneNumber = "9953454763"
//        var ePassword = "Forever$4"
        
        self.present(_splitViewController!, animated: true, completion: nil)
        
    }
    
    
    var _splitViewController: UISplitViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTextField.text = Settings.login
        passwordTextField.text = Settings.password
        // Do any additional setup after loading the view.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        _splitViewController = storyboard.instantiateViewController(withIdentifier: "splitVC") as? UISplitViewController
        let navigationController = _splitViewController?.viewControllers[(_splitViewController?.viewControllers.count)! - 1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = _splitViewController?.displayModeButtonItem
        _splitViewController?.delegate = self
        
    }

}

extension LoginViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? CallDetailViewController else { return false }
        if topAsDetailController.callItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}
