//
//  CountryListViewModel.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 01.11.2022.
//

import Foundation

protocol CountryListViewModelProtocol {
    var url: String { get set }
    var isPagination: Bool { get set }
    func fetchCountryList(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func getCountryListCellViewModel(at indexPath: IndexPath) -> CountryListCellViewModelProtocol
}

final class CountryListViewModel: CountryListViewModelProtocol {
    var isPagination = false
    
    var url: String = Api.api.rawValue
    
    private var countries: [Country] = []
    
    func fetchCountryList(completion: @escaping () -> Void) {
        if isPagination {
            NetworkManager.shared.fetch(CountryList.self, for: url ) { [unowned self] result in
                switch result {
                case .success(let countryList):
                    self.countries.append(contentsOf: countryList.countries)
                    self.url = countryList.next
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            NetworkManager.shared.fetch(CountryList.self, for: url) { [unowned self] result in
                switch result {
                case .success(let countryList):
                    self.countries = countryList.countries
                    self.url = countryList.next
                    self.isPagination = true
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
