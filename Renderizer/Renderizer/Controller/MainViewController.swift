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
    
    
    /// Request and Update Image
    /// - Parameters:
    ///   - network: Network
    ///   - networkData: Network Model
    func didUpdateImage(_ network: Network, _ networkModel: NetworkModel) {
        DispatchQueue.main.async {
            self.baseView.randomImage.kf.setImage(with: networkModel.small)
            self.imageToSave.kf.setImage(with: networkModel.small)
        }
    }
    
    
    /// Did Fail With Error
    /// - Parameter error: Error
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - Toolbar
extension MainViewController {
    
    /// Setup Toolbar With Update And Actions
    private func setupToolbar() {
        
        //Call Update ToolBar Items
        updateToolbarItems()
        
        //Filters Button Target
        baseView.filtersBarButton.addTarget(self, action: #selector(didFiltersButtonClicked), for: .touchUpInside)
        
        //Save Image Button Target
        baseView.saveBarButton.addTarget(self, action: #selector(didSaveImageButtonClicked), for: .touchUpInside)
        
        //Save Image Button Target
        baseView.updateBarButton.addTarget(self, action: #selector(didUpdateButtonClicked), for: .touchUpInside)
        
    }
    
    /// Update Toolbar
    private func updateToolbarItems() {
        toolbarItems = baseView.getBarButtonItems()
    }
}

//MARK: - Actions
extension MainViewController {
    
    /// Call Filters
    @objc private func didFiltersButtonClicked() {
        //Function
    }
    
    /// Call Filters
    @objc private func didUpdateButtonClicked() {
        DispatchQueue.main.async {
            self.network.fetchImage()
        }
    }
    
    /// Save Image In Camera Roll
    @objc private func didSaveImageButtonClicked() {
      
        //Guard Image To Save
        guard let image = self.imageToSave.image else {
            print(Error.self)
            return
        }
        
        //Save In Camera Roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        //Create and Call Alert
        let alert = UIAlertController(title: "Salvar Imagem", message: "Imagem salva com sucesso.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
}
