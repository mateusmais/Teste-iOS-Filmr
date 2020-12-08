//
//  MainView.swift
//  Renderizer
//
//  Created by Mateus Augusto M Ferreira on 07/12/20.
//

import Foundation
import UIKit


/// Main View Class
class MainView: UIView {
    
    //MARK: - Variables
    
    let backgroundView: UIImageView = {
        let background = UIImageView(image: UIImage(named: "background"))
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    //MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension MainView: ViewCodable {
    
    func setupViewHierarchy() {
        self.addSubview(backgroundView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            // Background View
            self.backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor)
        
        ])
    }
    
    func setupAdditionalConfiguration() { }
}
