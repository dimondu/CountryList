//
//  CountryListViewModel.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 01.11.2022.
//

import Foundation

protocol CountryListViewModelProtocol {
    
    func fetchCountryList(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func getCountryListCellViewModel(at indexPath: IndexPath) -> CountryListCellViewModelProtocol
}

final class CountryListViewModel: CountryListViewModelProtocol {
    
    private var countries: [Country] = []
    
    func fetchCountryList(completion: @escaping () -> Void) {
        NetworkManager.shared.fetch(CountryList.self, for: Api.api.rawValue) { [unowned self] result in
            switch result {
            case .success(let countryList):
                self.countries = countryList.countries
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        countries.count
    }
    
    func getCountryListCellViewModel(at indexPath: IndexPath) -> CountryListCellViewModelProtocol {
        CountryListCellViewModel(country: countries[indexPath.row])
    }
    
    
}
