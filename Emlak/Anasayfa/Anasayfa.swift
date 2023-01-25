//
//  Anasayfa.swift
//  Emlak
//
//  Created by tolgahan sonmez on 21.01.2023.
//

import UIKit
import Firebase
import CoreLocation


class Anasayfa: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    struct Helper{
        static var locationManager = CLLocationManager()
    }

        

    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mevcutKullancıLabel: UILabel!
    var log = [String]()
    var logName = [String : String]()
    var currentId = String()
    
    var longitudever = Double()
    var latitudever = Double()
    var currentUserIdArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getUserList()
        Helper.locationManager.delegate = self
        Helper.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        Helper.locationManager.requestAlwaysAuthorization()
        Helper.locationManager.startUpdatingLocation()
        
        
        
        
        
        
        
    }
    
    //location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        //print(location!.coordinate.latitude)
        //print(location!.coordinate.longitude)
        latitudever = location!.coordinate.latitude
        longitudever = location!.coordinate.longitude
       // locWrite()
    }
    //location firebase records
    /*func locWrite() {
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
            let db = Firestore.firestore()
            
            db.collection("currentUser").addSnapshotListener { snapShotCurrent, errorCurrent in
                if errorCurrent != nil {
                    print(errorCurrent?.localizedDescription ?? "Location Çekerken Hata")
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
                    let dbLocArray = ["longitude" : self.longitudever, "latitude" : self.latitudever] as [String : Double]
                    db.collection("location admin").document("currentLocation").setData(dbLocArray) {
                        errorloc in
                        if errorloc != nil{
                            print(errorloc?.localizedDescription ?? "Error")
                        }else{
                            print("Done")
                        }
                    }
                    
                
                }else{
                    let dbLocArray = ["longitude" : self.longitudever, "latitude" : self.latitudever] as [String : Double]
                    db.collection("location\(self.mevcutKullancıLabel.text!)").document("currentLocation").setData(dbLocArray) {
                        errorloc in
                        if errorloc != nil{
                            print(errorloc?.localizedDescription ?? "Error")
                        }else{
                            print("Done")
                        }
                    }
                    
                }
                
                
            }
            
        }
    }
    */
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "anacell", for: indexPath) as! Anasayfacell
        cell.Baslik.text = "merhaba dünyalı merkez akçayda"
        cell.fiyat.text = "1600000"
        cell.odaSayisi.text = "3+1"
        cell.yer.text = "Sarıkız"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetay", sender: nil)
    }
    //içerdeki kullanıcı
    func getUserList () {
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                let db = Firestore.firestore()
                //current user çekme
                db.collection("currentUser").addSnapshotListener { snapShotCurrent, errorCurrent in
                    if errorCurrent != nil{
                        print(errorCurrent?.localizedDescription ?? "Hata")
                    }else{
                        if snapShotCurrent?.isEmpty != true{
                            for cur in snapShotCurrent!.documents{
                                self.currentId = cur.get("currentUser") as!  String
                                //print(self.currentId)
                            }
                        }
                    }
                }
                
                
                //userId çekme
                db.collection("Users").addSnapshotListener { [self] snapShot, errorSnapshot in
                    if errorSnapshot != nil {
                        print(errorSnapshot?.localizedDescription ?? "Hata")
                    } else {
                        if snapShot?.isEmpty != true {
                            for i in snapShot!.documents{
                                let userId = i.get("userId") as? String
                                let userName = i.get("userName") as? String
                                self.logName[userId!] = userName

                            }
                            // label İsim yazdırma
                            var labelCek = logName[currentId] as? String
                            self.mevcutKullancıLabel.text = labelCek
                        
                            
                        }
                    }
                }
               
                
                
     
            }
        }

}
