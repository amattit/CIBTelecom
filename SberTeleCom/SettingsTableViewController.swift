//
//  SettingsTableViewController.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 24.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var IPAddressForRecognize: UITextField!
    @IBOutlet weak var portForRecognize: UITextField!
    @IBOutlet weak var loginForRecognize: UITextField!
    @IBOutlet weak var passwordForeRecognize: UITextField!
    
    var doneButton: UIBarButtonItem?
    
    @objc
    func doneButtonHandler() {
        guard let ip = IPAddressForRecognize.text, let port = portForRecognize.text else { return }
        
        guard let login = loginForRecognize.text, let password = passwordForeRecognize.text else { return }
        
        Settings.ipForRecognize = ip
        
        Settings.portForRecognize = Int(port) ?? 80
        
        Settings.login = login
        
        Settings.password = password
        
        performSegue(withIdentifier: "backToList", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandler))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    private func configureView() {
        IPAddressForRecognize.text =  Settings.ipForRecognize
        portForRecognize.text = String(Settings.portForRecognize)
        loginForRecognize.text = Settings.login
        passwordForeRecognize.text = Settings.password
    }

}
