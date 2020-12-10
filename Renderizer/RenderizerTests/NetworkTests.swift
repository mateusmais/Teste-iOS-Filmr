//
//  NetworkTests.swift
//  RenderizerUITests
//
//  Created by Mateus Augusto M Ferreira on 09/12/20.
//


@testable import Renderizer
import XCTest

class NetworkTests: XCTestCase {

    var network: Network?
    
    
    /// Set Up
    override func setUp() {
        super.setUp()
        network = Network()
    }
    
    
    /// Tear Down
    override func tearDown() {
        super.tearDown()
        network = nil
    }
    
    
    /// Test FetchImage
    func testFetchImage(){
        let url = "https://api.unsplash.com/photos/random?client_id=\(Key.accessKey)"
        let test: ()? = network?.performRequest(with: url)
        XCTAssertNotNil(test, "")
        XCTAssertTrue((test != nil))
    }
}
