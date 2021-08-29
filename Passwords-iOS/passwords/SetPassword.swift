//
//  SetPassword.swift
//  passwords
//
//  Created by Valeria Conde on 6/13/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class SetPassword: UIViewController {
    
    @IBOutlet weak var tfSetAppPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuitaTeclado))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func QuitaTeclado()
    {
        view.endEditing(true)
    }
    
    
    @IBAction func btnSavePassword(_ sender: UIButton) {
        let appPassword: String = tfSetAppPassword.text!
        
        let defaults = UserDefaults.standard
        
        defaults.set(appPassword, forKey: "password")
        
        let alert = UIAlertController(title: "Password Set", message: "You can now log in to the app", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
}
