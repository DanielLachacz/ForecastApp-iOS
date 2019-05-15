//
//  ViewController.swift
//  ForecastApp
//
//  Created by Daniel Łachacz on 21/04/2019.
//  Copyright © 2019 Daniel Łachacz. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
        searchButton.layer.cornerRadius = 10
            searchButton.layer.backgroundColor = #colorLiteral(red: 0.0808333233, green: 0.1026388332, blue: 0.3512958884, alpha: 1)
        }
    }
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var humidityImageView: UIImageView!
    @IBOutlet weak var forecastTabelView: UITableView!
    var forecastArray = [WeatherForecast]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        humidityImageView.tintColor = UIColor.white
        
        let tintedImage = windImageView.image?.withRenderingMode(.alwaysTemplate)
        windImageView.image = tintedImage
        windImageView.tintColor = UIColor.white
        
        let tintedImage2 =
        humidityImageView.image?.withRenderingMode(.alwaysTemplate)
        humidityImageView.image = tintedImage2
        humidityImageView.tintColor = UIColor.white
        
        self.forecastTabelView.delegate = self
        self.forecastTabelView.dataSource = self
        forecastTabelView.reloadData()
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func searchCity(_ sender: Any) {
        cityLabel.text = cityTextField.text
        let city = cityTextField.text
        
        let weatherService = WeatherSerice(APIKey: "52e6ff60bba8613b4850e065dcd3d0ac")
        weatherService.getCurrentWeather(city: city!) { result in
            switch result {
            case .success(let result):  DispatchQueue.main.async {
                print(result)
                self.conditionLabel.text = "\(result.weather.randomElement()!.description)"
                self.cityLabel.text = result.name
                self.tempLabel.text = "\(result.main.temp) \(" ℃")"
                self.windLabel.text = "\(result.wind.speed) \(" m/s")"
                self.humidityLabel.text = "\(result.main.humidity) \(" %")"
                let icon = result.weather.randomElement()!.icon
                let address = URL(string: "https://openweathermap.org/img/w/" + icon + ".png")
                self.iconImageView.kf.setImage(with: address)
                }
            case .failure(let error): print(error)
            }
        }
        
        let forecastService = WeatherSerice(APIKey: "52e6ff60bba8613b4850e065dcd3d0ac")
        forecastService.getWeatherForecast(city: city!) { result in
            switch result {
            case .success(let result): DispatchQueue.main.async {
                print(result)
                self.forecastArray = [result]
                self.forecastTabelView.reloadData()
            
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? ForecastCell else {
            return UITableViewCell()
        }
        
       // let forecast = forecastArray[indexPath.row]
        let icon = forecastArray[indexPath.row].list.randomElement()!.weather.randomElement()!.icon
        let address = URL(string: "https://openweathermap.org/img/w/" + icon + ".png")
        cell.iconImageView.kf.setImage(with: address)
        cell.dayLabel.text = forecastArray[indexPath.row].list.randomElement()!.dtTxt
        cell.tempMinLabel.text = "\(forecastArray[indexPath.row].list.randomElement()!.main.tempMin) \(" ℃")"
        cell.tempMaxLabel.text = "\(forecastArray[indexPath.row].list.randomElement()!.main.tempMax) \(" ℃")"
       
        print("RESULT ", forecastArray[indexPath.row])
        return cell
        
    }
}

