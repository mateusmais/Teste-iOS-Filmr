//
//  MainViewController.swift
//  Renderizer
//
//  Created by Mateus Augusto M Ferreira on 07/12/20.
//

import Foundation
import UIKit
import Kingfisher


final class MainViewController: UIViewController {
    
    
    //MARK: - Variables
    //Variables
    private let baseView = MainView()
    private var imageToSave = UIImageView()
    private var network = Network()
    
    
    
    //MARK: - Load View
    //Load View
    
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    
    //MARK: - View Will Appear
    
    /// View Will Appear
    /// - Parameter animated: True Or False
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    //MARK: - View Did Load
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign Delegate
        network.delegate = self
        
        //Call Request
        network.fetchImage()
        
        //Setup Toolbar
        setupToolbar()
    }
}

//MARK: - Network Delegate
extension MainViewController: NetworkDelegate {
    func didUpdateImage(_ network: Network, _ networkData: NetworkModel) {
        DispatchQueue.main.async {
            self.baseView.randomImage.kf.setImage(with: networkData.small)
            self.imageToSave.kf.setImage(with: networkData.small)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - Toolbar
extension MainViewController {
    
    /// Setup Toolbar With Update And Actions
    private func setupToolbar() {
        
        updateToolbarItems()
        
        baseView.filtersBarButton.addTarget(self, action: #selector(didFiltersButtonClicked), for: .touchUpInside)
        
        baseView.saveBarButton.addTarget(self, action: #selector(didSaveImageButtonClicked), for: .touchUpInside)
        
    }
    
    /// Update Toolbar
    private func updateToolbarItems() {
        toolbarItems = baseView.getBarButtonItems()
    }
}

//MARK: - Actions
extension MainViewController {
    
    @objc private func didFiltersButtonClicked() {
        //Function
    }
    
    @objc private func didSaveImageButtonClicked() {
        guard let image = self.imageToSave.image else {
            print(Error.self)
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
}
