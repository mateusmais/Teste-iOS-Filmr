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
    
    override func setUp() {
        super.setUp()
        network = Network()
    }
    
    override func tearDown() {
        super.tearDown()
        network = nil
    }
}
