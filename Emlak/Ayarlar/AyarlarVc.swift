//
//  AyarlarVc.swift
//  Emlak
//
//  Created by tolgahan sonmez on 21.01.2023.
//

import UIKit
import Firebase



class AyarlarVc: UIViewController {
    
    
    @IBOutlet weak var addUserId: UITextField!
    
    
    @IBOutlet weak var addUserPass: UITextField!
    
    
    @IBOutlet weak var Map: UIButton!
    
    func makeAlert(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func addClicked(_ sender: Any) {
        let db = Firestore.firestore()
        var dbref : DocumentReference? = nil
        let dbArray = ["user":addUserId.text! , "pass":addUserPass.text!] as [String : Any]
        if addUserId.text == "" && addUserPass.text == "" {
            makeAlert(title: "Error", message: "Alanları Doldurun.")
        }else{
            db.collection("users").addDocument(data: dbArray) { usersadderror in
                if usersadderror != nil{
                    self.makeAlert(title: "Error", message: usersadderror?.localizedDescription ?? "Error.")
                }else{
                    self.makeAlert(title: "Başarılı", message: "Kayit Başarılı")
                }
            }
        }
        
  
        
    }
    
    

}
