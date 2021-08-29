//
//  TableViewController.swift
//  passwords
//
//  Created by Valeria Conde on 6/12/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    var redes = [RedSocial]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*

         let accountUsername: String = tfAccount.text!
         let accountPassword: String = tfPassword.text!
         let accountRed: String = account
         
         // meten
         defaults.set(accountUsername, forKey: "accountUsername\(account!)")
         defaults.set(accountPassword, forKey: "accountPassword\(account!)")
         defaults.set(accountRed, forKey: "accountRed\(account!)")
         
         // saca
         defaults.string(forKey: "password")
         
         */
        let pickerData = ["Facebook", "Twitter", "Instagram", "Google", "Blackboard", "Pinterest", "Github", "LinkedIn", "Skype", "Tumblr", "Netflix", "Line", "Kik", "Reddit", "Apple", "Amazon", "Spotify", "Snapchat", "Otro"]
        
        for red in pickerData {
            if defaults.string(forKey: "accountRed\(red)") != nil {
                let infoRed = RedSocial(nombre: red, logo: UIImage(named: red)!,
                                        cuenta: defaults.string(forKey: "accountUsername\(red)")!,
                                        contrasena: defaults.string(forKey: "accountPassword\(red)")!)
                redes.append(infoRed)
            }
        }
        
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "redsocial")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return redes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redsocial", for: indexPath) as! TableViewCell

    
        // Configure the cell...
        cell.imLogo.image = redes[indexPath.row].logo
        cell.lbRed.text = redes[indexPath.row].nombre
        
        
        
        return cell
    }
 
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAccInfo", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAccInfo" {
            let vc2 = segue.destination as! ViewController2
            let indexPath = tableView.indexPathForSelectedRow
            vc2.redSoc = redes[indexPath!.row]
        
        
        }
    }
}
