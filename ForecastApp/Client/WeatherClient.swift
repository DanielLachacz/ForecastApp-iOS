//
//  WeatherClient.swift
//  ForecastApp
//
//  Created by Daniel Łachacz on 03/05/2019.
//  Copyright © 2019 Daniel Łachacz. All rights reserved.
//

import UIKit

class WeatherClient: NSObject {
    
    static let shareInstance = WeatherClient()

    func fetchWeather(completion: @escaping([CurrentWeather]?, Error?) -> ()){
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=London/52e6ff60bba8613b4850e065dcd3d0ac"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")}
            else {
                guard let data = data else {return}
                do{
                    let results = try JSONDecoder().decode(Weather.self, from: data)
                    print(results)
                }
                catch let jsonErr {
                    print("json error: \(jsonErr.localizedDescription)")
                }
                
            }
        }.resume()
    }
}
