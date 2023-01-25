//
//  MapVc.swift
//  Emlak
//
//  Created by tolgahan sonmez on 22.01.2023.
//

import UIKit
import MapKit

class MapVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

  
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Abuzittin Nerede"
        
        return cell
    }
    



}
