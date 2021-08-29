//
//  ViewController.swift
//  passwords
//
//  Created by Valeria Conde on 6/12/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuitaTeclado))
        view.addGestureRecognizer(tap)
    }

    
    @IBAction func QuitaTeclado() {
        view.endEditing(true)
    }
    
    @IBAction func validar(_ sender: UIButton) {
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toMain" {
            if (tfPassword.text == nil || tfPassword.text != defaults.string(forKey: "password")) {
                let alert = UIAlertController(title: "Wrong password", message: "Try again or reset password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                return false
                
            }
        }
        return true
    }
    
     @IBAction func unwindToSetPassw(segue:UIStoryboardSegue) { }
}

