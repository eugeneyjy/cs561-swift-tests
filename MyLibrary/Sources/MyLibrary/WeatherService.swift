import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

enum BaseUrl :String {
    case prod = "https://api.openweathermap.org/data/2.5/weather"
    case mock = "http://host.docker.internal:3000/data/2.5/weather"
}

class WeatherServiceImpl: WeatherService {
    private let url: String

    init(prod: Bool? = false) {
        if prod == true {
            self.url = "\(BaseUrl.prod.rawValue)?q=corvallis&units=imperial&appid=f0d214f5a83825db70916d4a72970843"
        } else {
            self.url = "\(BaseUrl.mock.rawValue)?q=corvallis&units=imperial&appid=f0d214f5a83825db70916d4a72970843"
        }
    }

    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

internal struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
