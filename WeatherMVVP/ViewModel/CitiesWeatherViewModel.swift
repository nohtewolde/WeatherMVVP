//
//  CitiesWeatherViewModel.swift
//  WeatherMVVP
//
//  Created by Noh Tewolde on 4/19/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import Foundation

class CitiesWeatherViewModel{
    
    var cityWeather = [CurrentWeather]()
    
    var service: APIHandler
    
    init(service: APIHandler){
        self.service = service
    }
    
    func getWeather(latitude: Double, longitude: Double, completionHandler: @escaping ( _ error: String?) -> Void){
        service.fetchCurrentWeather(latitude: latitude, longitude: longitude, completion: { (weatherdata, error) in
            if error == nil{
                self.cityWeather.append(weatherdata!)
                completionHandler(nil)
            } else{
                completionHandler(error?.localizedDescription)
                return
            }
        })
    }
    
}
