//
//  RedSocial.swift
//  passwords
//
//  Created by Valeria Conde on 6/12/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

// Clase RedSocial, con: nombre, logo, cuenta y password

class RedSocial: NSObject {
    var nombre: String!
    var logo: UIImage!
    var cuenta: String!
    var contrasena: String!
    
    init(nombre:String, logo: UIImage, cuenta: String, contrasena: String) {
        self.nombre = nombre
        self.logo = logo
        self.cuenta = cuenta
        self.contrasena = contrasena
    }
}
