//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.


import UIKit
import CoreLocation

protocol WeatherProtocol: AnyObject {
    func weatherDataWith(weather: WeatherData)
}

final class WeatherViewController: UIViewController, WeatherProtocol {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var locationButton: UIButton!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var feelLikeLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var visibilityLabel: UILabel!
    @IBOutlet private weak var cloudImage: UIImageView!
    @IBOutlet private weak var unitsView: UIView!
    @IBOutlet private weak var locationView: UIView!
    @IBOutlet private weak var cloudView: UIView!
    
    
    // MARK: - Variables
    
    var presenter : WeatherPresentationProtocol?
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        
        let viewController = self
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        
        //View Controller will communicate with only presenter
        viewController.presenter = presenter
        
        //Presenter will communicate with Interector and Viewcontroller
        presenter.viewController = viewController
        presenter.interactor = interactor
        
        //Interactor will communucate with only presenter.
        interactor.presenter = presenter
    }
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Get updated location from Location Manager class
        
        LocationHelper.shared.getUpdatedLocation = { [weak self] currentLocation in
            
            guard let self = self else {
                return
            }
            self.getSelectedLocation(currentLocation: currentLocation)
        }
    }
    
    // MARK: Button Action
    
    @IBAction private func actionSearchButton(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        
        if let searchVC = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
         
            searchVC.selectedLocation = { [weak self] place in
                
                guard let self = self else {
                    return
                }
                
                self.storeSelectedLocation(place)
                self.presenter?.apiCallForWeather(lat: place.lat, long: place.lon)
            }
            
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    
    // MARK: Protocol Implementation
    
    func weatherDataWith(weather: WeatherData) {
        displayWeatherData(weather)
    }
    
    private func displayWeatherData(_ weather: WeatherData) {
        
        let radius: CGFloat = 8
        
        unitsView.layer.cornerRadius = radius
        locationView.layer.cornerRadius = radius
        cloudView.layer.cornerRadius = radius
        
        locationButton.setTitle((weather.name ?? "") + ", " + (weather.sys?.country ?? ""), for: .normal)
        
        descriptionLabel.text = weather.weather?.first?.description
        
        mainLabel.text = weather.weather?.first?.main
        
        let temperature = (Int)(floor(weather.main?.temp ?? 0))
        temperatureLabel.text = "\(temperature)°F"
        
        let feelsLike = (Int)(weather.main?.feelsLike ?? 0)
        feelLikeLabel.text = "Feels Like \(feelsLike)°F"
        
        windLabel.text = "Wind: \(weather.wind?.speed ?? 0)mph"
        humidityLabel.text = "Humidity: \(weather.main?.humidity ?? 0)%"
        pressureLabel.text = String(format: "Pressure: %.2finHg", (weather.main?.pressure ?? 0)/33.864)
        
        let distanceMeters = Measurement(value: weather.visibility ?? 0, unit: UnitLength.meters)
        let miles = distanceMeters.converted(to: UnitLength.miles).value
        visibilityLabel.text = String(format: "Visibility: %.2fmi", miles)
        
        if let url = URL(string: "\(CloudImageBaseURL)\(weather.weather?.first?.icon ?? "01d")@2x.png") {
            cloudImage.loadImage(url: url)
        }
    }
}

// MARK: Check location cases & API Call

extension WeatherViewController {
    
    private func storeSelectedLocation(_ location: SearchResponse) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(location) {
            AppUserDefaults.set(encoded, forKey: UserDefaultSelectedLocation)
        }
    }
    
    private func getSelectedLocation(currentLocation: CLLocationCoordinate2D?) {
        
        if let savedLocation = AppUserDefaults.object(forKey: UserDefaultSelectedLocation) as? Data {
            
            let decoder = JSONDecoder()
            if let selectedLocation = try? decoder.decode(SearchResponse.self, from: savedLocation) {
                self.presenter?.apiCallForWeather(lat: selectedLocation.lat, long: selectedLocation.lon)
            }
        } else {
            
            if let currentLocation = currentLocation {
                self.presenter?.apiCallForWeather(lat: currentLocation.latitude, long: currentLocation.longitude)
            } else {
                self.presenter?.apiCallForWeather(lat: DefaultLatitude, long: DefaultLongitude)
            }
        }
    }
}
