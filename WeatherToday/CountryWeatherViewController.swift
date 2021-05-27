//
//  CountryWeatherViewController.swift
//  WeatherToday
//
//  Created by 장주명 on 2021/01/11.
//

import UIKit

class CountryWeatherViewController: UIViewController {

    
    @IBOutlet weak var countryWeatherTabelVeiw: UITableView!
    
    var countryWeather : [Weather] = []
    var countryName : String = ""
    var countryAssetName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countryName
        countryWeatherTabelVeiw.delegate = self
        countryWeatherTabelVeiw.dataSource = self
  
        let jsonDecoder = JSONDecoder()
        
        guard let dataAsset : NSDataAsset = NSDataAsset(name: countryAssetName ) else {
            return
        }
        
        do {
            self.countryWeather = try jsonDecoder.decode([Weather].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.countryWeatherTabelVeiw.reloadData()
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeatherDetailViewController" {
            let vc = segue.destination as! WeatherDetailViewController
            if let index = sender as? Int {
                vc.detailViewTitle = countryWeather[index].cityName
                vc.state = countryWeather[index].state
                vc.detailRainfallProbability = countryWeather[index].rainfallProbability
                vc.celsius = countryWeather[index].celsius
                
            }
        }
 
     }

}

extension CountryWeatherViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryWeatherCell", for: indexPath) as? CountryWeatherCell else { return UITableViewCell()}
        
        let weatherData : Weather = self.countryWeather[indexPath.row]
        let celsius = weatherData.celsius
        let Fahrenheit = String(format: "%.1f",  (celsius * 1.8) + 32)
        let rainfallProbability = String(weatherData.rainfallProbability)
        let weahterStateData = weatherData.state
        var imageName : String = ""
        
        switch weahterStateData {
        case 10 :
            imageName = "sunny"
        case 11 :
            imageName = "cloudy"
        case 12 :
            imageName = "rainy"
        case 13 :
            imageName = "snowy"
        default :
            imageName = "nothing"

        }
        
        if weatherData.rainfallProbability >= 60 {
            cell.rainfallProbability.textColor = .orange
        } else {
            cell.rainfallProbability.textColor = .black
        }
        
        cell.cityLabel.text = weatherData.cityName
        cell.temperatureLabel.text = "섭씨 \(celsius) / 화씨 \(Fahrenheit)"
        cell.rainfallProbability.text = "강수 확률 \(rainfallProbability)%"
        cell.countryWeatherImgView.image = UIImage(named: imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWeatherDetailViewController", sender: indexPath.row)
    }
    
}


class CountryWeatherCell : UITableViewCell {
    
    @IBOutlet weak var countryWeatherImgView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallProbability: UILabel!
    
}
