//
//  GameViewController.swift
//  PopularCity
//
//  Created by youngkyun park on 1/8/25.
//

import UIKit


class GameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, ObjectSetup {
 
 

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!

    @IBOutlet var presentTextView: UITextView!
     
    @IBOutlet var resultLabel: UILabel!
    
    let pickerView = UIPickerView()
    
    var numbers: [Int] = []
    var resultArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        inputTextField.delegate = self
        
        Setup()
        
        numbers = Array(1...1000).reversed()
      
    }
    
    func Setup() {
        labelConfig()
        textFieldConfig()
        textViewConfig()
    }
    
    
    func labelConfig() {
        let title = "369 게임"
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        
        resultLabel.font = .boldSystemFont(ofSize: 24)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        
    }
    func textFieldConfig() {
        
        let placeholder = "최대 숫자를 선택해주세요."
        inputTextField.placeholder = placeholder
        inputTextField.inputView = pickerView
        
    }
    func textViewConfig() {
        presentTextView.isEditable = false
        presentTextView.font = .systemFont(ofSize: 16)
        presentTextView.layer.borderColor = UIColor.lightGray.cgColor
        presentTextView.layer.borderWidth = 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(numbers[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var num = row
        num = numbers.count - row
        checkClap(inputNum: num)

    }

    private func checkClap(inputNum: Int) {
        
        var clapCnt = 0
        
        for i in 1...inputNum {
            var temp = i
            var cnt = 0
            while (temp > 0) {

                if temp % 10 == 3 || temp % 10 == 6 || temp % 10 == 9 {
       
                    cnt += 1
                }
                temp /=  10
            }
            if cnt > 0 {
                resultArray.append(String(repeating: "👏", count: cnt))
                clapCnt += cnt
            } else {
                resultArray.append(String(i))
            }
            
        }
        let str = resultArray.joined(separator: ", ")
        presentTextView.text = str
        resultArray.removeAll()
        resultLabel.text = "숫자 \(inputNum)까지 총 박수는 \n\(clapCnt)입니다"
    }

}
