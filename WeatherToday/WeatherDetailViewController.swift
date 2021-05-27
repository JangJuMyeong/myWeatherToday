//
//  WeatherDetailViewController.swift
//  WeatherToday
//
//  Created by 장주명 on 2021/01/11.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var celsius : Float?
    var detailViewTitle : String = ""
    var state : Int?
    var detailRainfallProbability : Int?
    var imageName : String = ""
    var weather : String?
    
    
    @IBOutlet weak var detailweatherImgView: UIImageView!
    @IBOutlet weak var detailWeatherLabel: UILabel!
    @IBOutlet weak var detailTemperatureLabel: UILabel!
    @IBOutlet weak var detailRainfallProbabilityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        title = detailViewTitle
        if let rainfallProbability = detailRainfallProbability {
            let detailRainfallProbabilityText = String(rainfallProbability)
            if rainfallProbability >= 60 {
                detailWeatherLabel.textColor = .orange
            }
            detailRainfallProbabilityLabel.text = "강수 확률 \(detailRainfallProbabilityText)%" 
        }
        
        if let weatherStatus = state {
            
            if weatherStatus == 10 {
                imageName = "sunny"
                weather = "맑음"
            } else if weatherStatus == 11{
                imageName = "cloudy"
                weather = "구름"
            } else if weatherStatus == 12{
                imageName = "rainy"
                weather = "비"
            } else if weatherStatus == 13{
                imageName = "snowy"
                weather = "눈"
            }
            
            detailWeatherLabel.text = weather
            detailweatherImgView.image = UIImage(named: imageName)
        }
        
        if let temperature = celsius {
            let celsius = temperature
            let Fahrenheit = String(format: "%.1f",  (celsius * 1.8) + 32)
            detailTemperatureLabel.text = "섭씨 \(celsius) / 화씨 \(Fahrenheit)"
        }
        

        
    }
    

    
}
