import Foundation

struct CurrentWeather : Decodable {
    
    let coord : Coordinate
    let cod, visibility, id : Int
    let name : String
    let base : String
    let weather : [Weather]
    let clouds: Clouds
    let sys : Sys
    let main : Main
    let wind : Wind
    let dt : Date
}

struct Coordinate : Decodable {
    let lat, lon : Double
    
}

struct Weather : Decodable {
    let id : Int
    let icon : String
    let main : MainEnum
    let description: String
}

struct Sys : Decodable {
    let type, id : Int
    let sunrise, sunset : Date
    let message : Double
    let country : String
}

struct Main : Decodable {
    let temp, tempMin, tempMax : Double
    let pressure, humidity : Int
}

struct Wind : Decodable {
    let speed : Double
    let deg : Int
    let gust : Double?
}

struct Clouds: Decodable {
    let all : Int
}

enum MainEnum: String, Decodable {
    case clear = "Clear"
    case cloud = "Clouds"
    case rain = "Rain"
    case base = "Base"
    case description = "Description"
    
    case failure = "Failure"
    case success = "Success"
}
