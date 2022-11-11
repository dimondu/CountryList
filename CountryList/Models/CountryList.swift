//
//  CountryList.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 31.10.2022.
//

import Foundation

enum CountryListData {
    case initial
    case loading(Data)
    case success(Data)
    case failure(Data)
}

struct CountryList: Decodable {
    let next: String
    let countries: [Country]
}

struct Country: Decodable {
    let name: String
    let continent: String
    let capital: String
    let population: Int
    let descriptionSmall: String
    let description: String
    let image: String
    let countryInfo: CountryInfo
}

struct CountryInfo: Decodable {
    let images: [String]
    let flag: String
}
