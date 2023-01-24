//
//  ViewController.swift
//  Emlak
//
//  Created by tolgahan sonmez on 21.01.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
   
    
    var newDict = [String : String]()
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var passText: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearCurrentUserData()
        getUserList ()
        
        
        
    }
   
    
    
    @IBAction func loginButton(_ sender: Any) {
        if idText.text != "" && passText.text != "" {
            Auth.auth().signIn(withEmail: idText.text!, password: passText.text!) { authData, errorLogin in
                if errorLogin != nil {
                    print(errorLogin?.localizedDescription ?? "Hata")    // Auth kısmında girilen kullanıcıyı bulamadığı için hata veriyor ve User sözlüğünde aramaya geçiyor.
                    if self.newDict.index(forKey: self.idText.text!) != nil {  // User sözlüğünde key kontrolü yapıyor. Bulursa devam edecek.
                        if self.newDict[self.idText.text!] == self.passText.text! {  // User sözlüğünde key kontrolü başarılı ise burada o key'in value kontrolünü yapıyor.
                            self.performSegue(withIdentifier: "toApp", sender: nil)
                            print("Kullanıcı girişi başarılı")
                            // Güncel kullanıcı adını Firebase ye ekleme
                            let dbCurrentUser = Firestore.firestore()
                            let dbCurrentUserArray = ["currentUser" : self.idText.text!] as [String : Any]
                            dbCurrentUser.collection("currentUser").document("currentUserData").setData(dbCurrentUserArray) { errorCurrent in
                                if errorCurrent != nil {
                                    print(errorCurrent?.localizedDescription ?? "Hata")
                                } else {
                                    print("Mevcut kullanıcı Firebase' de güncellendi.")
                                }
                            }
                            // Güncel kullanıcı kod sonu
                            
                        } else {
                            self.makeAlert(title: "Hata", message: "Yanlış şifre")
                        }
                        
                    } else {
                        self.makeAlert(title: "Hata", message: "Yanlış kullanıcı adı")
                    }
                    
                } else {
                    self.performSegue(withIdentifier: "toApp", sender: nil)   // Auth kısmında kullanıcıyı bulup Auth kullanıcı olarak giriş yapıyor.
                    print("Admin girişi başarılı")
                }
            }
        } else {
            makeAlert(title: "Hata", message: "Boşluk doldur")
        }
    }
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func getUserList () {
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                let db = Firestore.firestore()
                db.collection("Users").addSnapshotListener { [self] snapShot, errorSnapshot in
                    if errorSnapshot != nil {
                        print(errorSnapshot?.localizedDescription ?? "Hata")
                    } else {
                        if snapShot?.isEmpty != true {
                            for i in snapShot!.documents{
                                let userId = i.get("userId") as? String
                                let passId = i.get("userPass") as? String
                                newDict[userId!] = passId!
                            }
                        }
                        print(newDict)
                    }
                }
            }
        }
    func clearCurrentUserData(){
            let dbClear = Firestore.firestore()
            dbClear.collection("currentUser").document("currentUserData").delete() { errorClear in
                if errorClear != nil {
                    print("Mevcut kullanıcı silinemedi. HATA!")
                } else {
                    
                    print("Mevcut kullanıcı silme başarılı.")
                }
            }

            let dbClearAuth = Auth.auth()
            do {
                try dbClearAuth.signOut()
                print("Admin çıkışı başarılı")
            } catch {
                print("Auth kullanıcısı çıkış yapamadı.")
            }
        }
    
    

        

}
    


