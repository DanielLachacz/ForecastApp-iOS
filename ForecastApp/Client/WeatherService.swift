//
//  WeatherService.swift
//  ForecastApp
//
//  Created by Daniel Łachacz on 06/05/2019.
//  Copyright © 2019 Daniel Łachacz. All rights reserved.
//

import Foundation

class WeatherSerice {
    
    let weatherAPIKey: String
    let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?"
    let forecastBaseURL = "https://api.openweathermap.org/data/2.5/forecast?"
   // let units: String = "metric"
    
    init(APIKey: String) {
        
        self.weatherAPIKey = APIKey
    }
    
    func getCurrentWeather(city: String, completion: @escaping (Result<CurrentWeather,Error>) -> Void) {
        
        var urlComponents = URLComponents(string: weatherBaseURL)!
        let queryItems = [URLQueryItem(name: "q", value: city),
                          URLQueryItem(name: "appid", value: weatherAPIKey),
                          URLQueryItem(name: "units", value: "metric")]
        urlComponents.queryItems = queryItems
        
        if let weatherURL = urlComponents.url {
            
            let task = URLSession.shared.dataTask(with: weatherURL) {(data, response, error) in
                
                if let error = error {completion(.failure(error))}
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let result = try decoder.decode(CurrentWeather.self, from: data!)
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
        }
        task.resume()
        }
    }
    
    func getWeatherForecast(city: String, completion: @escaping (Result<WeatherForecast,Error>) -> Void) {
        
        var urlComponents = URLComponents(string: forecastBaseURL)!
        let queryItems = [URLQueryItem(name: "q", value: city),
                          URLQueryItem(name: "appid", value: weatherAPIKey),
                          URLQueryItem(name: "units", value: "metric"),
                          URLQueryItem(name: "cnt", value: "12")]
        urlComponents.queryItems = queryItems
        
        if let weatherURL = urlComponents.url {
            
            let task = URLSession.shared.dataTask(with: weatherURL) {(data, response, error) in
                
                if let error = error {completion(.failure(error))}
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let result = try decoder.decode(WeatherForecast.self, from: data!)
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

}
