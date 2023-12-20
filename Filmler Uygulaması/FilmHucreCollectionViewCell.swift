//
//  FilmHucreCollectionViewCell.swift
//  Filmler Uygulaması
//
//  Created by Fırat İlhan on 9.04.2023.
//

import UIKit

protocol FilmHucreCollectionViewCellProtocol {
    func sepeteEkle(indexPath:IndexPath)
}



class FilmHucreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewFilmResim: UIImageView!
    @IBOutlet weak var labelFilmAdi: UILabel!
    @IBOutlet weak var labelFilmFiyat: UILabel!
    
    var hucreProtocol:FilmHucreCollectionViewCellProtocol?
    var indexPath:IndexPath?
    
    
    
    
    @IBAction func filmSepeteEkle(_ sender: Any) {
        hucreProtocol?.sepeteEkle(indexPath: indexPath!)
    }
}
