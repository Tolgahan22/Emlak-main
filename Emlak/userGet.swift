//
//  userGet.swift
//  Emlak
//
//  Created by tolgahan sonmez on 25.01.2023.
//

import Foundation
import Firebase
class lists {
    
    var newDict = [String : Any]()
    init(){
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
                    print("asd \(newDict)")
                }
            }
            //print("list")
        }
    }
}
