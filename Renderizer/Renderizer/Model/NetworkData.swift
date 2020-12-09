//
//  NetworkData.swift
//  Renderizer
//
//  Created by Mateus Augusto M Ferreira on 08/12/20.
//

import Foundation
import UIKit

struct NetworkData: Codable {
    let urls: Urls
}


struct Urls: Codable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}
