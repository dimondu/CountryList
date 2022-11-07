//
//  Request.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 31.10.2022.
//

import Foundation


protocol Request {
    var baseURL: String { get }
    var path: String { get }
}
