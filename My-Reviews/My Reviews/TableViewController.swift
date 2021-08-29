//
//  TableViewController.swift
//  My Reviews
//
//  Created by Valeria Conde on 6/28/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var Lugares = [Lugar]()
    var LugarSegue : Lugar!
    let apiKey = "AIzaSyB5IDaKe2iK-1WSEhMJ1sJfGCjiMEG2WzY"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(appFin(notification:)), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        Lugares = Lee()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "lugar")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func Lee() -> [Lugar] {
        // Swift sí permite que una función regrese un arreglo
        // aqui voy a poner _ para que regrese una _ de un archivo
        do {
            let data = try Data.init(contentsOf: Lugar.archiveURL)
            let tareasTmp = try PropertyListDecoder().decode([Lugar].self, from: data)
            return tareasTmp
        } catch {
            return []
        }
    }
    
    @objc func appFin(notification: NSNotification) {
        do {
            let data = try PropertyListEncoder().encode(Lugares)
            try data.write(to: Lugar.archiveURL)
        } catch {
            print("No se pudo guardar la información")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Lugares.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lugar", for: indexPath) as! TableViewCell

        // Configure the cell...
        cell.name.text = Lugares[indexPath.row].name
        
        let cali = Int(Lugares[indexPath.row].rating.rounded())
        cell.rating.text =  String(repeating: "⭐️", count: cali)
        
        // request for photo
        if Lugares[indexPath.row].photo != "" {
            var url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference="
            url += Lugares[indexPath.row].photo + "&key=\(apiKey)"
            
            let imageUrl:URL = URL(string: url)!
            
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    cell.pic.image = image
                    cell.pic.contentMode = UIView.ContentMode.scaleAspectFit
                }
            }
        }

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "info2" {
            let vc = segue.destination as! DetallesViewController
            vc.lugar = LugarSegue
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LugarSegue = Lugares[indexPath.row]
        performSegue(withIdentifier: "info2", sender: self)
    }
 
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        Lugares = Lee()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Lugares = Lee()
        tableView.reloadData()
    }

}
