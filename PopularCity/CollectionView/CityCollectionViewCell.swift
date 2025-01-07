//
//  CityCollectionViewCell.swift
//  PopularCity
//
//  Created by youngkyun park on 1/7/25.
//

import UIKit



class CityCollectionViewCell: UICollectionViewCell {

    static let identifier = "CityCollectionViewCell"

    @IBOutlet var mainimageView: UIImageView!
    
    @IBOutlet var mainTitle: UILabel!
    
    @IBOutlet var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    
    
    
    func configure() {
        
        mainTitle.font = .boldSystemFont(ofSize: 12)
        mainTitle.textAlignment = .center
        mainTitle.numberOfLines = 0
        
        subTitle.textColor = .black
        subTitle.font = .systemFont(ofSize: 10)
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
        
        mainimageView.layer.cornerRadius = mainimageView.frame.width / 2
        mainimageView.contentMode = .scaleAspectFill
    
        
        

    }
    
    
    
    func configData(_ row: City, segNum: Int) {
        mainTitle.text = row.title
        mainTitle.textColor = .black
        
        if segNum == 0 {
            let url = URL(string: row.city_image)
            mainimageView.kf.setImage(with: url)

            subTitle.text = row.city_explain
            
        } else if segNum == 1 {
            if row.domestic_travel == true {
                let url = URL(string: row.city_image)
                mainimageView.kf.setImage(with: url)
                subTitle.text = row.city_explain
            }
        } else {
            if row.domestic_travel == false {
                let url = URL(string: row.city_image)
                mainimageView.kf.setImage(with: url)
                subTitle.text = row.city_explain
            }
        }
        
        
    }
    
    func serachTravelData(data: City) {
        mainTitle.text = data.title
        mainTitle.textColor = .red
        let url = URL(string: data.city_image)
        mainimageView.kf.setImage(with: url)
        subTitle.text = data.city_explain
        
    }
    
    
    
  
}
