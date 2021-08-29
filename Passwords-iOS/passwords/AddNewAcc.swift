//
//  AddNewAcc.swift
//  passwords
//
//  Created by Valeria Conde on 6/13/19.
//  Copyright © 2019 Valeria Conde. All rights reserved.
//

import UIKit

class AddNewAcc: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var account: String! = "Facebook"
    let defaults = UserDefaults.standard
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Captures what the user selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        account = pickerData[row]
    }
    
    @IBOutlet weak var pvRedes: UIPickerView!
    
    var pickerData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.pvRedes.delegate = self
        self.pvRedes.dataSource = self
        
        // Opciones del picker view
        
        pickerData = ["Facebook", "Twitter", "Instagram", "Google", "Blackboard", "Pinterest", "Github", "LinkedIn", "Skype", "Tumblr", "Netflix", "Line", "Kik", "Reddit", "Apple", "Amazon", "Spotify", "Snapchat", "Otro"]
        
        // Teclado
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuitaTeclado))
        view.addGestureRecognizer(tap)
        
        
    }
    
    @IBAction func QuitaTeclado()
    {
        view.endEditing(true)
    }
    

    @IBAction func btnSave(_ sender: UIButton) {
        pvRedes.selectRow(0, inComponent: 0, animated: true)
        let alert = UIAlertController(title: "Success!", message: "Account saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
       
        let accountUsername: String = tfAccount.text!
        let accountPassword: String = tfPassword.text!
        let accountRed: String = account
        
        
        defaults.set(accountUsername, forKey: "accountUsername\(account!)")
        defaults.set(accountPassword, forKey: "accountPassword\(account!)")
        defaults.set(accountRed, forKey: "accountRed\(account!)")
        
        tfAccount.text = ""
        tfPassword.text = ""
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
