//
//  Ekleme.swift
//  Emlak
//
//  Created by tolgahan sonmez on 22.01.2023.
//

import UIKit
import Firebase


class Ekleme: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var firstPhotoView: UIImageView!
    @IBOutlet weak var lastPhotoView: UIImageView!
    @IBOutlet weak var addPhotoView: UIImageView!
    
    
    let oda = ["1+0","1+1","2+0","2+1","3+0","3+1","4+1","4+2"]
    let yer = ["Akçay","Sarıkız","ikizçay","Güre"]
 
    
    @IBOutlet weak var yerPicker: UIPickerView!
    
    @IBOutlet weak var odaPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yerPicker.delegate = self
        yerPicker.dataSource = self
        odaPicker.dataSource = self
        odaPicker.delegate = self
       
     
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return oda.count
        }else{
            return yer.count
        }
    
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return oda[row]
        }else{
            return yer[row]
        }
        
    }
    func pickerView(_pickerView:UIPickerView, didSelectRow: Int, inComponent: Int){

    }
    


    @IBAction func evKaydetButton(_ sender: Any) {

      
        
        }

    
        
    

    
 

}
