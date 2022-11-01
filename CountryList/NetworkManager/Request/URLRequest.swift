//
//  URLRequest.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 31.10.2022.
//

import Foundation


extension URLRequest {
    init?(request: Request) {
        guard let url = URL(string: "\(request.baseURL)\(request.path)") else { return nil }
        self.init(url: url)
    }
}
