import Foundation

struct WeatherForecast : Decodable {

     let cod : String
     let message : Float
     let cnt : Int
     let list : [List]
     let city : City
}

struct City : Decodable {
    
     let id : Int
     let name : String
     let coord : CoordinateWF
     let country : String
}

struct CoordinateWF : Decodable {
    
     let lat : Float
     let lon : Float
}

 struct List : Decodable {
    
     let dt : Int
     let main : MainWF
     let weather : [WeatherWF]
     let clouds : CloudsWF
     let wind : WindWF
     let sys : SysWF
     let dtTxt : String
}

struct SysWF : Decodable {
    
     let pod : String
}

struct WindWF : Decodable {
    
     let speed : Float
     let deg : Float
}

struct CloudsWF : Decodable {
    
     let all : Int
}

struct WeatherWF : Decodable {
    
     let id : Int
     let main : String
     let description : String
     let icon : String
}

struct MainWF : Decodable {
    
     let temp : Float
     let tempMin : Float
     let tempMax : Float
     let pressure : Float
     let seaLevel : Float
     let grndLevel : Float
     let humidity : Int
     let tempKf : Float
}

enum MainEnumWF: String, Decodable {
    case clear = "Clear"
    case cloud = "Clouds"
    case rain = "Rain"
    case base = "Base"
    case description = "Description"
    
    case failure = "Failure"
    case success = "Success"
}
