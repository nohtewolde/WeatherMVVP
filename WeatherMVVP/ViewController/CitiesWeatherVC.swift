//
//  CitiesWeatherVC.swift
//  WeatherMVVP
//
//  Created by Noh Tewolde on 4/18/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

import UIKit
import SVProgressHUD
import GooglePlaces

class CitiesWeatherVC: UIViewController {
    
    var citiesWeatherViewModel : CitiesWeatherViewModel!
    var latitiude : Double?
    var longitude : Double?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesWeatherViewModel = CitiesWeatherViewModel(service: APIHandler.sharedInstance)
        tableView.tableFooterView = UIView()
    }
    
    func getWeather(latitude: Double, longitude: Double){
        SVProgressHUD.show()
        citiesWeatherViewModel.getWeather(latitude: latitude, longitude: longitude) {(error) in
            SVProgressHUD.dismiss()
            if error == nil{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else{
                print(error!)
            }
        }
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
                openStarLocation()
    }
    
}

extension CitiesWeatherVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesWeatherViewModel.cityWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WeatherCell
        cell.setValues(weatherData: citiesWeatherViewModel.cityWeather[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
}

extension CitiesWeatherVC : GMSAutocompleteViewControllerDelegate {
    
    func openStarLocation() {
        let autoCompleteCtrl = GMSAutocompleteViewController()
        autoCompleteCtrl.delegate = self
        self.present(autoCompleteCtrl, animated: true, completion: nil)
    }
    
    //Mark - GMSAutoCompleteViewControllerDelegate methods
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error : \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let latitude : Double = place.coordinate.latitude
        let longitude : Double = place.coordinate.longitude
        getWeather(latitude: latitude, longitude: longitude)
        self.dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
