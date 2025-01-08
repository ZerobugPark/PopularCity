//
//  GameViewController.swift
//  PopularCity
//
//  Created by youngkyun park on 1/8/25.
//

import UIKit


class GameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 

    @IBOutlet var testTexField: UITextField!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!

    @IBOutlet var presentTextView: UITextView!
     
    let pickerView = UIPickerView()
    

    
    var numbers: [Int] = []
    var result: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        inputTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
       
        
        numbers = Array(1...100).reversed()
      
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(numbers[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print(numbers)
        return numbers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(row)
    }


}
