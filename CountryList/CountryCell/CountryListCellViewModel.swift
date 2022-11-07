//
//  CountryListCellViewModel.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 01.11.2022.
//

import Foundation


protocol CountryListCellViewModelProtocol {
    var flagImage: ((Data)->())? { get set }
    func fetchImage()
    var name: String { get }
    var capital: String { get }
    var descriptionSmall: String? { get }
    init(country: Country)
}

final class CountryListCellViewModel: CountryListCellViewModelProtocol {
    public var flagImage: ((Data) -> ())? {
        didSet {
            fetchImage()
        }
    }
    
    var name: String {
        country.name
    }
    
    var capital: String {
        country.capital
    }
    
    var descriptionSmall: String? {
        country.descriptionSmall
    }
    
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    func fetchImage() {
       NetworkManager.shared.fetchImage(from: country.countryInfo.flag) { [weak self]  imageData in
           self?.flagImage?(imageData)
       }
   }
}
