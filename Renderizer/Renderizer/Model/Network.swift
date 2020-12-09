//
//  Network.swift
//  Renderizer
//
//  Created by Mateus Augusto M Ferreira on 07/12/20.
//

import Foundation
import UIKit

//MARK: - Network Delegate
/// Network Delegate
protocol NetworkDelegate {
    func didUpdateImage(_ network: Network, _ networkData: NetworkModel)
    func didFailWithError(_ error: Error)
}

//MARK: - Network Struct
/// Network Struct
struct Network {
    
    //Variables
    private var delegate: NetworkDelegate?
    private var randomImageURL = "https://api.unsplash.com/photos/random?client_id=\(Key.accessKey)"
    
    func fetchImage(){
        performRequest(with: randomImageURL)
    }
    
    
    //MARK: - Perform Request
    /// Make Requisition
    /// - Parameter urlString: API Url
    private func performRequest(with urlString: String){
        //1. Create URL
        if let url = URL(string: urlString) {
            
            //2.Create URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let imageData = data {
                    if let image = self.parseImageJSON(imageData) {
                        self.delegate?.didUpdateImage(self, image)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    
    /// Parsing Image URL Data to Image URL
    /// - Parameter imageData: Image Data
    /// - Returns: Image URL
    private func parseImageJSON(_ imageData: Data) -> NetworkModel? {
        let decode = JSONDecoder()
        
        do {
            let decodedImageData = try decode.decode(NetworkData.self, from: imageData)
            let imageFullData = decodedImageData.urls.full
            let imageFull = NetworkModel(full: imageFullData)
            return imageFull
        } catch  {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}
