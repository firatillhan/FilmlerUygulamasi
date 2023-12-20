//
//  Kategoriler.swift
//  Filmler Uygulaması
//
//  Created by Fırat İlhan on 9.04.2023.
//

import Foundation


class Kategoriler:Codable {
    var kategori_id:String?
    var kategori_ad:String?
    
    init() {
        
}

    init(kategori_id:String,kategori_ad:String) {
        self.kategori_id = kategori_id
        self.kategori_ad = kategori_ad
    }

    
    
}
