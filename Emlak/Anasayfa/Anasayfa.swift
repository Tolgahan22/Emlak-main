//
//  Anasayfa.swift
//  Emlak
//
//  Created by tolgahan sonmez on 21.01.2023.
//

import UIKit

class Anasayfa: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
    }
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

}
