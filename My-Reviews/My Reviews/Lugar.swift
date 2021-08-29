//
//  Lugar.swift
//  My Reviews
//
//  Created by Valeria Conde on 7/2/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class Lugar: NSObject, Codable {
    
    var name: String
    
    // Arreglo de fotos para el lugar... ? *
    var photo: String
    var vicinity: String
    var rating: Double
    var id: String
    
    // valeria/desktop/documentdirectory/domain
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    // valeria/desktop/documentdirectory/domain/Tareas
    static let archiveURL = documentsDirectory.appendingPathComponent("Lugares")
    
    // Moverla a guardados con id ? *
    init(name: String, photo: String, vicinity: String, rating: Double, id: String) {
        self.name = name
        self.photo = photo
        self.vicinity = vicinity
        self.rating = rating
        self.id = id
    }
}
