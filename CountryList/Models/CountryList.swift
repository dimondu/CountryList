//
//  CountryList.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 31.10.2022.
//

import Foundation


struct CountryList: Decodable {
    let next: String
    let countries: [Country]
}

struct Country: Decodable {
    let name, continent, capital: String
    let population: Int
    let descriptionSmall, countryDescription: String
    let image: String
    let countryInfo: CountryInfo
}

struct CountryInfo: Decodable {
    let images: [String]
    let flag: String
}
