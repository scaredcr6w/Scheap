//
//  ScheapTests.swift
//  ScheapTests
//
//  Created by Anda Levente on 18/07/2024.
//

import XCTest
@testable import Scheap

final class ShoppingListTests: XCTestCase {
    var viewModel: ShoppingListViewModel!
    
    override func setUpWithError() throws {
        viewModel = ShoppingListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testHandleUserInputWithValidInput() {
        
        viewModel.userListInput = "Milk\nBread\nEggs"
        
        let expectation = self.expectation(description: "Valid input processes successfully")
        
        viewModel.handleUserInput { error in
            XCTAssertNil(error)
            XCTAssertFalse(self.viewModel.shoppingItems.isEmpty)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
}
