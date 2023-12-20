//
//  FilmViewController.swift
//  Filmler Uygulaması
//
//  Created by Fırat İlhan on 9.04.2023.
//

import UIKit

class FilmViewController: UIViewController {
    @IBOutlet weak var filmCollectionView: UICollectionView!
    
    var filmListesi = [Filmler]()
    var kategori:Kategoriler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filmCollectionView.dataSource = self
        filmCollectionView.delegate = self
        
        let tasarim : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.filmCollectionView.frame.size.width
        let yukseklik = self.filmCollectionView.frame.size.height
        
        
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let hucreGenislik = (genislik - 30) / 2
        let hucreYukseklik = yukseklik / 2.5
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreYukseklik )
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        filmCollectionView.collectionViewLayout = tasarim
        
        if let k = kategori {
            if let kid = Int(k.kategori_id!) {
                
                navigationItem.title = k.kategori_ad
                filmlerByKategoriID(kategori_id: kid)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! FilmDetayViewController
        gidilecekVC.film = filmListesi[indeks!]
    }

    func filmlerByKategoriID(kategori_id:Int) {

        var request = URLRequest(url: URL(string: "https://www.swiftogreniyorum.com/filmler/filmler_by_kategori_id.php")!)
        request.httpMethod = "POST"
        
        let postString = "kategori_id=\(kategori_id)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            do {
                let cevap = try JSONDecoder().decode(FilmCevap.self, from: data!)
                if let gelenFilmListesi = cevap.filmler {
                    self.filmListesi = gelenFilmListesi
                }
                DispatchQueue.main.async {
                    self.filmCollectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

extension FilmViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let film = filmListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmHucre", for: indexPath) as! FilmHucreCollectionViewCell
        
        cell.labelFilmAdi.text = film.film_ad
        cell.labelFilmFiyat.text = "15.99 TL"
        
        if let url = URL(string: "https://www.swiftogreniyorum.com/filmler/\(film.film_resim!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.imageViewFilmResim.image = UIImage(data: data!)
                }
            }
        }
        
        cell.imageViewFilmResim.image = UIImage(named: film.film_resim!)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}

extension FilmViewController:FilmHucreCollectionViewCellProtocol {
    func sepeteEkle(indexPath: IndexPath) {
        print("sepete eklenen film \(filmListesi[indexPath.row].film_ad!)")
    }
}
  
