//
//  APIHandler.swift
//  WeatherMVVP
//
//  Created by Noh Tewolde on 4/18/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import Foundation

let currentWeatherByCityUrl = "https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&APPID=%@"
let fiveDayForecastUrl = "htts://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&APPID=%@"
let weatherAPIkey = "61006d91511b141429da1340e48cf394"


class APIHandler: NSObject{
    
    enum APIHandlerError: Error{
        case inCorrectUrl
        case unableToParse
        case timeoutError
        case wrongResponse
        
        var localizedDescription: String{
            switch self{
            case .inCorrectUrl:
                return "URL is not correct"
            case .timeoutError:
                return "Request timeout"
            case .unableToParse:
                return "Failed to parse response"
            case .wrongResponse:
                return "Incorrect response format"
            }
        }
    }
    
    static var sharedInstance = APIHandler()
    var cityWeather = [CurrentWeather]()
    override init() {}
    
    func fetchCurrentWeather(latitude: Double, longitude: Double,
                                 completion: @escaping (_ weatherdata: CurrentWeather?, _ error: APIHandlerError?) -> Void){
        let urlLoc = String(format: currentWeatherByCityUrl, String(describing: latitude),String(describing: longitude),weatherAPIkey)
        guard let url = URL(string: urlLoc) else {
            completion(nil, .inCorrectUrl)
            return
        }
        
        URLSessionCall(url: url) { (currentWeather, error) in
            completion(currentWeather,error)
        }
    }
    
    func fetchFiveDayForecast(latitude: Double, longitude: Double,
                              completion: @escaping (_ weatherdata: CurrentWeather?, _ error: APIHandlerError?) -> Void){
        
        let urlLoc = String(format: fiveDayForecastUrl, String(describing: latitude),String(describing: longitude),weatherAPIkey)
        guard let url = URL(string: urlLoc) else {
            completion(nil, .inCorrectUrl)
            return
        }
        
        URLSessionCall(url: url) { (currentWeather, error) in
            completion(currentWeather,error)
        }
    }
    
    func URLSessionCall(url: URL,
                        completion: @escaping (_ weatherdata: CurrentWeather?, _ error: APIHandlerError?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil{
                guard let data = data else {
                    completion(nil, .wrongResponse)
                    return}
                do{
                    let weatherdata = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    print(weatherdata)
                    completion(weatherdata, nil)
                } catch{
                    print(error.localizedDescription)
                    completion(nil, .unableToParse)
                }
            }
            else{
                print("Error while fetching data")
                completion(nil, .timeoutError)
            }
            }.resume()
    }
}

