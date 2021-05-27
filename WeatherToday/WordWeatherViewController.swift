//
//  ViewController.swift
//  WeatherToday
//
//  Created by 장주명 on 2021/01/11.
//

import UIKit

class WordWeatherViewController: UIViewController {

    @IBOutlet weak var wordWeathertableView: UITableView!
    
    var countries : [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "세계 날씨"
        wordWeathertableView.delegate = self
        wordWeathertableView.dataSource = self
        
        let jsonDecoder = JSONDecoder()
        guard let dataAsset : NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.wordWeathertableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCountryWatherView" {
            let vc = segue.destination as! CountryWeatherViewController
            if let index = sender as? Int {
                vc.countryName = countries[index].koreanname
                vc.countryAssetName = countries[index].assetname
            }
        }
        
    }
    
}

extension WordWeatherViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordWeatherTableViewCell", for: indexPath) as? WordWeatherTableViewCell else { return UITableViewCell() }
        
        let country : Country = self.countries[indexPath.row]
        
        cell.CountryLabel.text = country.koreanname
        cell.CountryImageView.image = UIImage(named: "flag_" + country.assetname)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCountryWatherView", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

class WordWeatherTableViewCell : UITableViewCell {
    
    @IBOutlet weak var CountryImageView: UIImageView!
    @IBOutlet weak var CountryLabel: UILabel!
    
}

