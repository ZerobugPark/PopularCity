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
        cityNameLabel.textColor = .white
        cityNameLabel.font = .boldSystemFont(ofSize: 16)
        cityNameLabel.textAlignment = .right
        
        
        cityImageView.contentMode = .scaleAspectFill
        explainLabel.textColor = .white
        explainLabel.font = .systemFont(ofSize: 12)
        
        explainView.alpha = 0.5
        explainView.backgroundColor = .black
    }
    
    func configData(_ row: City, segNum: Int) {
        
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        
        
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
