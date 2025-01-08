//
//  ReuseProtocol.swift
//  PopularCity
//
//  Created by youngkyun park on 1/8/25.
//

import Foundation

@objc
protocol ObjectSetup {
    func Setup()
    @objc optional func labelConfig()
    @objc optional func textFieldConfig()
    @objc optional func imageViewConfig()
    @objc optional func textViewConfig()
    @objc optional func buttonConfig()
    
}
