//
//  MainViewController.swift
//  Renderizer
//
//  Created by Mateus Augusto M Ferreira on 07/12/20.
//

import Foundation
import UIKit


final class MainViewController: UIViewController{
    
    
    //MARK: - Variables
    //Variables
    private let baseView = MainView()
     

    //MARK: - Load View
    //Load View
    
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    
    
    //MARK: - View Did Load
    //View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
