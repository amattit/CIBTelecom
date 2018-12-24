//
//  MasterViewController.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 18.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import UIKit

class CallListViewController: UITableViewController {

    var detailViewController: CallDetailViewController? = nil
    var callItems = [CallItemViewModel]()

    var textField: UITextField?
    
    @IBAction
    func backToList(_ sender: UIStoryboardSegue) {}
    
    @IBAction func settingsBarButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "+7" + phoneNumber
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CallDetailViewController
        }
        
        API.shared.getCalls { (items) in
            self.callItems = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = callItems[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! CallDetailViewController

                controller.callItem = object
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CallsTableViewCell

        let object = callItems[indexPath.row]
        cell.managerLabel.text = object.id
        cell.phoneLabel.text = object.phone
        cell.callTypeLabel.text = object.type

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

}

