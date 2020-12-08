//
//  ViewCodable.swift
//  Renderizer
//
//  Created by Mateus Augusto M Ferreira on 07/12/20.
//

import Foundation
import UIKit


protocol ViewCodable {
    func setupView()
    func setupViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
}

extension ViewCodable {
    
    func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }

}
