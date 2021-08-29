//
//  CollectionViewController.swift
//  My Reviews
//
//  Created by Valeria Conde on 7/2/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit
import GooglePlaces
import Alamofire

private let reuseIdentifier = "celda"
private var locManager = CLLocationManager()

class CollectionViewController: UICollectionViewController, UISearchBarDelegate {
    var Lugares = [Lugar]()
    var LugarSegue : Lugar!
    let apiKey = "AIzaSyB5IDaKe2iK-1WSEhMJ1sJfGCjiMEG2WzY"
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected at: \(indexPath.row)")
        LugarSegue = Lugares[indexPath.row]
        performSegue(withIdentifier: "info", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "info" {
            let vc = segue.destination as! DetallesViewController
            vc.lugar = LugarSegue
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Lugares.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        cell.nombre.text = Lugares[indexPath.row].name
        
        // request for photo
        if Lugares[indexPath.row].photo != "" {
            var url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference="
            url += Lugares[indexPath.row].photo + "&key=\(apiKey)"
            print(url)
            
            let imageUrl:URL = URL(string: url)!
            
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    cell.foto.image = image
                    cell.foto.contentMode = UIView.ContentMode.scaleAspectFit
                }
            }
        }
        return cell
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    //MARK: - SEARCH
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Lugares.removeAll()
        if(!(searchBar.text?.isEmpty)!){
            let host = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
            var parameters = "?key=\(apiKey)"
            
            var currLoc: CLLocation!
            if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                currLoc = locManager.location
                parameters += "&location=\(currLoc.coordinate.latitude),\(currLoc.coordinate.longitude)"
                parameters += "&keyword=\(searchBar.text!)"
                parameters += "&rankby=distance"
                let query = host + parameters
                
                // Request
                Alamofire.request(query, method: .get)
                    .responseJSON { response in
                        if response.result.isSuccess {
                            if let result = response.result.value {
                                let JSON = result as! NSDictionary
                                let results = JSON["results"] as! [NSDictionary]
                                let placeCount = results.count
                                
                                for result in results {
                                    var ref = ""
                                    if let pic = result["photos"] {
                                        let pics = pic as! [NSDictionary]
                                        if pics.count > 0 {
                                            ref = pics[0]["photo_reference"] as! String
                                        }
                                    }
                                    
                                    let tmpLugar = Lugar(name: result["name"] as! String, photo: ref, vicinity: result["vicinity"] as! String, rating: result["rating"] as! Double, id: result["id"] as! String)
                                    self.Lugares.append(tmpLugar)
                                    if self.Lugares.count == placeCount {
                                        self.collectionView.reloadData()
                                    }
                                }
                                print(self.Lugares)
                            }
                        } else {
                            print("Error! Could not retrieve data")
                        }
                }
            }
            else {
                print("No ha dado autorizacion")
            }
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }
    
}
