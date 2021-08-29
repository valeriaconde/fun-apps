//
//  ViewController2.swift
//  passwords
//
//  Created by Valeria Conde on 6/12/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    
    @IBOutlet weak var lbBigNombre: UILabel!
    @IBOutlet weak var imBigLogo: UIImageView!
    @IBOutlet weak var lbAccount: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    
    var redSoc: RedSocial!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbBigNombre.text = redSoc.nombre
        imBigLogo.image = redSoc.logo
        lbAccount.text = redSoc.cuenta
        lbPassword.text = redSoc.contrasena
        

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
