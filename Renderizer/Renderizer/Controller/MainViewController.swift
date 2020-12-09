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
    private var changeFilter = 0
    private var baseImage = UIImageView()
    
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
            self.baseImage.kf.setImage(with: networkModel.small)
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

//MARK: - Button Actions
extension MainViewController {
    
    /// Call Filters
    @objc private func didFiltersButtonClicked() {
        nextFilter()
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

//MARK: - Generate Image Filter
extension MainViewController {
    func generateImageFilter(_ filter: String){
        
 
        
        guard let inputImage = self.baseView.randomImage.image else {
            print(Error.self)
            return
        }
        
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: filter) {
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)
            
            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    self.imageToSave.image = processedImage
                    self.baseView.randomImage.image = self.imageToSave.image
                }
            }
        }
    }
}

extension MainViewController {
    func nextFilter(){
        self.changeFilter+=1
        switch self.changeFilter {
        case 1:
            self.generateImageFilter(Filter.CISepiaTone)
        case 2:
            baseView.randomImage.image = baseImage.image
            imageToSave.image = baseImage.image
            self.changeFilter = 0
        default:
            print(Error.self)
        }
    }
}
