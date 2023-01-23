//
//  Anasayfacell.swift
//  Emlak
//
//  Created by tolgahan sonmez on 22.01.2023.
//

import UIKit

class Anasayfacell: UITableViewCell {
    
    
    @IBOutlet weak var Baslik: UILabel!
    
    @IBOutlet weak var fiyat: UILabel!
    
    @IBOutlet weak var odaSayisi: UILabel!
    
    @IBOutlet weak var yer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
