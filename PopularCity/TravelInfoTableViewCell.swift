//
//  TravelInfoTableViewCell.swift
//  PopularCity
//
//  Created by youngkyun park on 1/6/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet var cityNameLabel: UILabel!
    
    @IBOutlet var cityImageView: UIImageView!
    
    @IBOutlet var explainLabel: UILabel!
    
    @IBOutlet var explainView: UIView!
    
    static let identifier = "TravelInfoTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    private func  configure() {
        cityNameLabel.font = .boldSystemFont(ofSize: 16)
        cityNameLabel.textAlignment = .right
        
        
        cityImageView.contentMode = .scaleAspectFill

        
        explainView.backgroundColor = .black
        explainView.layer.opacity = 0.5
        
        //궁금한게 있습니다. 스토리보드 자체에서 opacity를 설정하면 아래 계층에 Layer에는 영향을 주지 않는데,
        //왜 코드로 작성하면 영향을 받을까요? 코드로 수정한 경우 아래 계층에 Layer도 함께 투명하게 보입니다..
        
  
        explainLabel.textColor = .white
        explainLabel.font = .systemFont(ofSize: 12)
        
    }
    
    func configData(_ row: City, segNum: Int) {
        
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        cityNameLabel.textColor = .white
        
        if segNum == 0 {
            let url = URL(string: row.city_image)
            cityImageView.kf.setImage(with: url)
            explainLabel.text = row.city_explain
            
        } else if segNum == 1 {
            if row.domestic_travel == true {
                let url = URL(string: row.city_image)
                cityImageView.kf.setImage(with: url)
                explainLabel.text = row.city_explain
            }
        } else {
            if row.domestic_travel == false {
                let url = URL(string: row.city_image)
                cityImageView.kf.setImage(with: url)
                explainLabel.text = row.city_explain
            }
        }
        
        
    }
    
    func serachTravelData(data: City) {
        cityNameLabel.text = "\(data.city_name) | \(data.city_english_name)"
        cityNameLabel.textColor = .red
        let url = URL(string: data.city_image)
        cityImageView.kf.setImage(with: url)
        explainLabel.text = data.city_explain
        
    }
}
