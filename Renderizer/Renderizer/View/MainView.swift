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
    
    let randomImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
    }()
    
    let filtersBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filters"), for: .normal)
        button.setImage(UIImage(named: "filtersPressed"), for: .selected)
        button.setTitle("Filtros", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.sizeToFit()
        button.centerLabelVerticallyWithPadding(spacing: 0.5, alingment: 0)
        return button
    }()
    
    lazy var filtersButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: self.filtersBarButton)
        return button
    }()
    

    let saveBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "savePhoto"), for: .normal)
        button.setImage(UIImage(named: "savePhotoPressed"), for: .selected)
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.sizeToFit()
        button.centerLabelVerticallyWithPadding(spacing: 0.5, alingment: 0)
        return button
    }()
    
    lazy var saveButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: self.saveBarButton)
        return button
    }()
    
    let updateBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "updatePhoto"), for: .normal)
        button.setImage(UIImage(named: "updatePhotoPressed"), for: .selected)
        button.setTitle("Atualizar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.sizeToFit()
        button.centerLabelVerticallyWithPadding(spacing: 0.5, alingment: 0)
        return button
    }()
    
    lazy var updateButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: self.updateBarButton)
        return button
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

//MARK: - View Codable
extension MainView: ViewCodable {
    
    /// Setup View Hierarchy
    func setupViewHierarchy() {
        self.addSubview(backgroundView)
        self.addSubview(randomImage)
    }
    
    
    /// Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Background View
            self.backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            // Random Image
            self.randomImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.randomImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.randomImage.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor)
            
        ])
    }
    
    /// Setup Additional Configuration
    func setupAdditionalConfiguration() { }
}

//MARK: - Items on Toolbar
extension MainView {
    
    func getBarButtonItems() -> [UIBarButtonItem] {
        return [filtersButtonItem, .flexibleSpace(), updateButtonItem, .flexibleSpace(), saveButtonItem]
    }
}
