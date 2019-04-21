//
//  WeatherCell.swift
//  WeatherMVVP
//
//  Created by Noh Tewolde on 4/18/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherCell: UITableViewCell {

    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var city: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setValues(weatherData: CurrentWeather){
        let celLow = Int(weatherData.main!.tempMin - 273.15)
        let celHigh = Int(weatherData.main!.tempMax - 273.15)
        DispatchQueue.main.async {
            self.low.text = "\(celLow)\u{00B0}C"
            self.high.text = "\(celHigh)\u{00B0}C"
            self.city.text = weatherData.name
            let urlStr = "http://openweathermap.org/img/w/" + weatherData.weather![0].icon + ".png"
            let url = URL(string: urlStr)!
            self.icon.sd_setImage(with: url, completed: nil)
            self.setGradientBackground()
        }
    }
}

extension UIView {
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.random.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 0.5)
    }
}
