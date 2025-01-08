//
//  MainTableViewController.swift
//  PopularCity
//
//  Created by youngkyun park on 1/6/25.
//

import UIKit

class MainTableViewController: UITableViewController, UITextFieldDelegate {
    
    let cityInfo = CityInfo().city

    //    var domestic: [City] = []
//    var international: [City] = []
    var data: [City] = []
    
    var cityFilter: [City] = []
    var isOn: Bool = false
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var seg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: TravelInfoTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TravelInfoTableViewCell.identifier)
        
        textField.delegate = self
        tableView.keyboardDismissMode = .onDrag
        
        view.backgroundColor = .white
        segmentControlSetup()
        //filterCity()
        

        
    }
    
    private func segmentControlSetup() {
        
        let title: [String] = ["모두", "국내", "해외"]
        
        for i in 0...2{
            seg.setTitle(title[i], forSegmentAt: i)
        }
        seg.selectedSegmentIndex = 0
        cityFilter = cityInfo
    }
    
//    private func filterCity() {
//        
//        
//        for i in 0..<cityInfo.count {
//            if cityInfo[i].domestic_travel {
//                domestic.append(cityInfo[i])
//            } else {
//                international.append(cityInfo[i])
//            }
//        }
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        return true
    }

    
    @IBAction func textFieldDidChagne(_ sender: UITextField) {
        //print("실시간 입력값: \(textField.text ?? "")") // 바로 업데이트된 값 확인
        searchCity()
        if isOn {
            tableView.reloadData()
        }
    }
    

    func searchCity() {
        if let text = textField.text {
            let stringWithoutSpaces = text.replacingOccurrences(of: " ", with: "")
            for i in 0..<cityFilter.count {
                var components = cityFilter[i].city_explain.components(separatedBy: ",")
                for j in 0..<components.count{
                    components[j] = components[j].trimmingCharacters(in: .whitespaces)
                }
                if cityFilter[i].city_name == stringWithoutSpaces || cityFilter[i].city_english_name.uppercased() == stringWithoutSpaces.uppercased() || components.contains(stringWithoutSpaces) {
                    if data.count != 0 {
                        data.removeAll()
                    }
                    isOn = true
                    data.append(cityFilter[i])
                    return
                }

            }
        }
    }
    
    
    //    func searchDate() {
    //        if let text = textField.text {
    //            let stringWithoutSpaces = text.replacingOccurrences(of: " ", with: "")
    //            if seg.selectedSegmentIndex == 0 {
    //                for i in 0..<cityInfo.count {
    //                    var components = cityInfo[i].city_explain.components(separatedBy: ",")
    //                    for j in 0..<components.count{
    //                        components[j] = components[j].trimmingCharacters(in: .whitespaces)
    //                    }
    //                    if cityInfo[i].city_name == stringWithoutSpaces || cityInfo[i].city_english_name.uppercased() == stringWithoutSpaces.uppercased() || components.contains(stringWithoutSpaces) {
    //                        if data.count != 0 {
    //                            data.removeAll()
    //                        }
    //                        data.append(cityInfo[i])
    //                        return
    //                    }
    //                }
    //                textField.text = ""
    //                let alert = UIAlertController(title: "알림", message: "찾으시는 항목이 없습니다", preferredStyle: .alert)
    //                let ok = UIAlertAction(title: "확인", style: .default)
    //
    //                alert.addAction(ok)
    //                present(alert,animated: true)
    //            } else if seg.selectedSegmentIndex == 1 {
    //                for i in 0..<domestic.count {
    //                    var components = domestic[i].city_explain.components(separatedBy: ",")
    //                    for j in 0..<components.count{
    //                        components[j] = components[j].trimmingCharacters(in: .whitespaces)
    //                    }
    //                    if domestic[i].city_name == stringWithoutSpaces || domestic[i].city_english_name.uppercased() == stringWithoutSpaces.uppercased() || components.contains(stringWithoutSpaces){
    //                        if data.count != 0 {
    //                            data.removeAll()
    //                        }
    //                        data.append(domestic[i])
    //                        return
    //                    }
    //                }
    //                textField.text = ""
    //                let alert = UIAlertController(title: "알림", message: "찾으시는 항목이 없습니다", preferredStyle: .alert)
    //                let ok = UIAlertAction(title: "확인", style: .default)
    //
    //                alert.addAction(ok)
    //                present(alert,animated: true)
    //            }
    //            else  {
    //                for i in 0..<international.count {
    //                    var components = international[i].city_explain.components(separatedBy: ",")
    //                    for j in 0..<components.count{
    //                        components[j] = components[j].trimmingCharacters(in: .whitespaces)
    //                    }
    //                    if international[i].city_name == stringWithoutSpaces || international[i].city_english_name.uppercased() == stringWithoutSpaces.uppercased() || components.contains(stringWithoutSpaces) {
    //                        if data.count != 0 {
    //                            data.removeAll()
    //                        }
    //                        data.append(international[i])
    //                        return
    //                    }
    //                }
    //                textField.text = ""
    //                let alert = UIAlertController(title: "알림", message: "찾으시는 항목이 없습니다", preferredStyle: .alert)
    //                let ok = UIAlertAction(title: "확인", style: .default)
    //
    //                alert.addAction(ok)
    //                present(alert,animated: true)
    //            }
    //        }
    //
    //    }
    //
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isOn {
            return 1
        }
        
        if seg.selectedSegmentIndex == 0 {
            return cityFilter.count
        } else if seg.selectedSegmentIndex == 1 {
            return cityFilter.count
        } else  {
            return cityFilter.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoTableViewCell.identifier, for: indexPath) as! TravelInfoTableViewCell
        
        
        var row: City
        
        if seg.selectedSegmentIndex == 0 {
            row = cityFilter[indexPath.row]
        } else if seg.selectedSegmentIndex == 1 {
            row = cityFilter[indexPath.row]
        } else {
            row = cityFilter[indexPath.row]
        }
        
        
        if isOn {
            cell.serachTravelData(data: data[0])
            isOn = false
        } else {
            cell.configData(row, segNum: seg.selectedSegmentIndex)
        }
        
        
        textField.text = ""
        
        return cell
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 143
    }
    
   
    
    @IBAction func segmentedControlSelected(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            cityFilter = cityInfo
        case 1:
            cityFilter = cityInfo.filter {$0.domestic_travel}
        case 2:
            cityFilter = cityInfo.filter {!$0.domestic_travel}
        default:
            cityFilter = cityInfo
        }
        
        textField.text = ""
        tableView.reloadData()
    }
    
    
    
    
}
