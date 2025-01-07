//
//  PopularViewController.swift
//  PopularCity
//
//  Created by youngkyun park on 1/7/25.
//

import UIKit
// 1. 이름 (파일 생성0
// 2. 프로토콜 연결
// 3. 필수 기능
// 4. 델리게이트 연결

class PopularViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
   
    @IBOutlet var cityCollectionView: UICollectionView!
    @IBOutlet var seg: UISegmentedControl!
    @IBOutlet var textField: UITextField!
    
    let cityInfo = CityInfo().city
    var data: [City] = []
    var cityFilter: [City] = []
    var isOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        cityCollectionView.keyboardDismissMode = .onDrag
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        //layout.minimumLineSpacing = 20
        //layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        cityCollectionView.collectionViewLayout = layout 

        navigationItem.title = "인기도시"
        
        setup()
        
    }
    


    private func setup() {
        
        registerCell()
        segConfig()
    }
    
    private func registerCell() {
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
    }
    
    private func segConfig() {

        let title: [String] = ["모두", "국내", "해외"]
        
        for i in 0...2{
            seg.setTitle(title[i], forSegmentAt: i)
        }
        seg.selectedSegmentIndex = 0
        cityFilter = cityInfo
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isOn {
            return  1
        }
        
        return cityFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
    
        
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
    
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        
        print("실시간 입력값: \(textField.text ?? "")") // 바로 업데이트된 값 확인
        searchCity()
        if isOn {
            cityCollectionView.reloadData()
        }
    }
    

    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        
     
        
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
        cityCollectionView.reloadData()
 
        
        
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
    
        view.endEditing(true)
    }
    
    
}
