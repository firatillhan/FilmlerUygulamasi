//
//  FilmDetayViewController.swift
//  Filmler Uygulaması
//
//  Created by Fırat İlhan on 9.04.2023.
//

import UIKit

class FilmDetayViewController: UIViewController {

    @IBOutlet weak var imageViewFilmResim: UIImageView!
    @IBOutlet weak var labelFilmAd: UILabel!
    @IBOutlet weak var labelFilmYil: UILabel!
    @IBOutlet weak var labelFilmKategori: UILabel!
    @IBOutlet weak var labelFilmYonetmen: UILabel!
    
    var film:Filmler?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let f = film {
            if let url = URL(string: "https://www.swiftogreniyorum.com/filmler/\(f.film_resim!)") {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.imageViewFilmResim.image = UIImage(data: data!)
                    }
                }
            }
            labelFilmAd.text = f.film_ad
            labelFilmYil.text = f.film_yil
            labelFilmKategori.text = f.kategori?.kategori_ad
            labelFilmYonetmen.text = f.yonetmen?.yonetmen_ad
        }
    }
    



}
