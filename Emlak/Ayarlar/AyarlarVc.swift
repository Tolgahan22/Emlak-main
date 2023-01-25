//
//  AyarlarVc.swift
//  Emlak
//
//  Created by tolgahan sonmez on 21.01.2023.
//

import UIKit
import Firebase



class AyarlarVc: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    
    @IBOutlet weak var addUserId: UITextField!
    @IBOutlet weak var addUserPass: UITextField!
    @IBOutlet weak var Map: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var addClicledOut: UIButton!
    @IBOutlet weak var adSoy: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var listUserIdArray = [String]()
    var currentUserIdArray = [String]()
    
    func makeAlert(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        addUserId.isHidden = true
        addUserPass.isHidden = true
        Map.isHidden = true
        logoutButton.isHidden = true
        addClicledOut.isHidden = true
        adSoy.isHidden = true
        label.isHidden = true
        tableView.isHidden = true
        getUserList ()
    }
    
    
    func getUserList () {
        print("ilkbaşarılı")
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                print("2.bas")
                let db = Firestore.firestore()
                db.collection("Users").addSnapshotListener { [self] snapShot, errorSnapshot in
                    if errorSnapshot != nil {
                        print(errorSnapshot?.localizedDescription ?? "Hata")
                    } else {
                        if snapShot?.isEmpty != true {
                            for i in snapShot!.documents{
                                if let userId = i.get("userId") as? String{
                                    self.listUserIdArray.append(userId)
                                }
                            }
                        }
                    }
                    print(self.listUserIdArray)
                }
                // current user datası çekip boş ise admin girişi olduğunu dolu ise kullanıcı girişi olduğunu algılayacak ve işlem yapacak.
                db.collection("currentUser").addSnapshotListener { snapShotCurrent, errorCurrent in
                    if errorCurrent != nil {
                        print(errorCurrent?.localizedDescription ?? "Current User Çekerken Hata")
                    } else {
                        if snapShotCurrent?.isEmpty != true {
                            for a in snapShotCurrent!.documents {
                                if let currentId = a.get("currentUser") as? String{
                                    self.currentUserIdArray.append(currentId)
                                }
                            }
                        }
                    }
                    if self.currentUserIdArray.isEmpty == true {
                        print("Mevcut kullanıcı admin") // Admin tüm içeriğe erişeceği için tüm hidden'lar false olacak
                        self.addUserId.isHidden = false
                        self.addUserPass.isHidden = false
                        self.Map.isHidden = false
                        self.logoutButton.isHidden = false
                        self.addClicledOut.isHidden = false
                        self.adSoy.isHidden = false
                        self.label.isHidden = false
                        self.tableView.isHidden = false
                    } else {
                        print("Mevcut kullanıcı (self.currentUserIdArray[0])") // Kullanıcı için tüm kodlar buraya
                        self.logoutButton.isHidden = false
                    }
                }
     
            }
        }

    @IBAction func addClicked(_ sender: Any) {
        let db = Firestore.firestore()
        let dbArray = ["userId" : addUserId.text!, "userPass" : addUserPass.text!, "userName" : adSoy.text! ] as [String : Any]
        if addUserId.text == "" && addUserPass.text == "" && adSoy.text == ""{
                    self.makeAlert(title: "Hata", message: "Boşlukları doldur.")
                } else {
                    db.collection("Users").addDocument(data: dbArray) { errorUserAdd in
                        if errorUserAdd != nil {
                            self.makeAlert(title: "Hata", message: errorUserAdd?.localizedDescription ?? "Hata")
                        } else {
                            self.makeAlert(title: "Başarılı", message: "Kullanıcı eklendi")
                        }
                    }
                }
                addUserId.text = ""
                addUserPass.text = ""
                adSoy.text = ""
    }


    @IBAction func cikisCliked(_ sender: Any) {
        Anasayfa.Helper.locationManager.stopUpdatingLocation()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUserIdArray.count
        
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Test"
            return cell
        

    }
    
    
    

}
    
