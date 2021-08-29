//
//  DetallesViewController.swift
//  My Reviews
//
//  Created by Valeria Conde on 7/2/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class DetallesViewController: UIViewController {

    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var imFoto: UIImageView!
    @IBOutlet weak var lbDireccion: UILabel!
    @IBOutlet weak var lbCalificacion: UILabel!
    @IBOutlet weak var btnHeart: UIButton!
    
    var lugar : Lugar!
    let apiKey = "AIzaSyB5IDaKe2iK-1WSEhMJ1sJfGCjiMEG2WzY"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbNombre.text = lugar.name
        lbDireccion.text = lugar.vicinity
        let cali = Int(lugar.rating.rounded())
        lbCalificacion.text =  String(repeating: "⭐️", count: cali)
        
        // request for photo
        if lugar.photo != "" {
            var url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference="
            url += lugar.photo + "&key=\(apiKey)"
            
            let imageUrl:URL = URL(string: url)!
            
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.imFoto.image = image
                    self.imFoto.contentMode = UIView.ContentMode.scaleAspectFit
                }
            }
        }
        
        // vamo a ve si existe
        let misLugares = Lee()
        if misLugares.first(where: { $0.id == lugar.id }) != nil {
            btnHeart.setImage(UIImage(named: "checkedheart"), for: [])
        }
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
    
    @IBAction func btnLike(_ sender: UIButton) {
        // vamo a ve si existe
        var misLugares = Lee()
        if misLugares.first(where: { $0.id == lugar.id }) != nil {
            btnHeart.setImage(UIImage(named: "heart"), for: [])
            misLugares.removeAll(where: {$0.id == lugar.id})
        }
        else{
            btnHeart.setImage(UIImage(named: "checkedheart"), for: [])
            misLugares.append(lugar)
        }
        
        do {
            let data = try PropertyListEncoder().encode(misLugares)
            try data.write(to: Lugar.archiveURL)
        } catch {
            print("No se pudo guardar la información")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
