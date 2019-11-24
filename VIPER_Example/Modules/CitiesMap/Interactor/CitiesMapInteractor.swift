//
//  CitiesMapInteractor.swift
//  VIPER_Example
//
//  Created by Malik Usman on 14/05/2019.
//  Copyright © 2019 Usman. All rights reserved.
//

import Foundation

class CitiesMapInteractor {
    // MARK: Properties
    
    weak var output: CitiesMapUseCaseOutput?
    let services = CitiesMapServices()
}

extension CitiesMapInteractor: CitiesMapUseCase {
    // MARK: - Function
    
    // Annotation points
    
    func getCitiesPositionArray() -> [CitiesPositionModel] {
        var cities = [CitiesPositionModel]()
        cities.append(CitiesPositionModel(name: "", latitude: 24.8607, longitude: 67.0011))
        cities.append(CitiesPositionModel(name: "", latitude: 31.549722, longitude: 74.343611))
        cities.append(CitiesPositionModel(name: "", latitude: 31.416667, longitude: 73.083333))
        cities.append(CitiesPositionModel(name: "", latitude: 34.73933, longitude: 72.335655))
        cities.append(CitiesPositionModel(name: "", latitude: 33.597331, longitude: 73.047904))
        cities.append(CitiesPositionModel(name: "", latitude: 30.196789, longitude: 71.478241))
        cities.append(CitiesPositionModel(name: "", latitude: 32.155667, longitude: 74.187052))
        cities.append(CitiesPositionModel(name: "", latitude: 25.396891, longitude: 68.377183))
        cities.append(CitiesPositionModel(name: "", latitude: 34.008, longitude: 71.578488))
        cities.append(CitiesPositionModel(name: "", latitude: 34.1463, longitude: 73.211684))
        cities.append(CitiesPositionModel(name: "", latitude: 33.69, longitude: 73.0551))
        cities.append(CitiesPositionModel(name: "", latitude: 30.184138, longitude: 67.00141))
        cities.append(CitiesPositionModel(name: "", latitude: 32.985414, longitude: 70.602701))
        cities.append(CitiesPositionModel(name: "", latitude: 29.4, longitude: 71.683333))
        
        return cities
    }
    
    // MARK: - Function
    
    func fetchForcastDetail(latitude: Double, longitude: Double) {
        services.executeForcastDetail(latitude: latitude, longitude: longitude) { response in
            if let response = response.result.value {
                self.output?.onResponse(response: response)
            } else {
                self.output?.onFailure(error: response.error ?? NSError(domain: "", code: 2000, userInfo: ["Error": "Something went wrong"]))
            }
        }
    }
}
