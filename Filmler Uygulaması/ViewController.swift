//
//  ViewController.swift
//  Filmler Uygulaması
//
//  Created by Fırat İlhan on 5.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var kategoriTableView: UITableView!
    
    var kategorilerListe = [Kategoriler]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   

        kategoriTableView.delegate = self
        kategoriTableView.dataSource = self
        tumKategorilerAll()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! FilmViewController
        gidilecekVC.kategori = kategorilerListe[indeks!]
        
        
    }

    func tumKategorilerAll() {
        let url = URL(string: "https://www.swiftogreniyorum.com/filmler/tum_kategoriler.php")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            do {
                let cevap = try JSONDecoder().decode(KategoriCevap.self, from: data!)
                if let gelenKategoriListesi = cevap.kategoriler {
                    self.kategorilerListe = gelenKategoriListesi
                }
                DispatchQueue.main.async {
                    self.kategoriTableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }

}



extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kategori = kategorilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriHucre", for: indexPath) as! KategoriHucreTableViewCell
        

        cell.kategoriLabelAd.text = kategori.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row )
    }
    
    
}
