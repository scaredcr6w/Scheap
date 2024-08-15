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
        
        viewModel.userInputList = "Méz\nvaj\nsajt"
        
        let expectation = self.expectation(description: "Valid input processes successfully")
        
        viewModel.handleUserInput { error in
            XCTAssertNil(error)
            XCTAssertFalse(self.viewModel.shoppingItems.isEmpty)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCreateCheapListWithValidInput() async throws {
        viewModel.userInputList = "Méz\nvaj\nsajt"
        
        let expectation = self.expectation(description: "List processes successfully")
        
        do {
            let cheapList = try await viewModel.createCheapestList(from: "aldi")
            
            XCTAssertTrue(cheapList.store == "aldi")
            XCTAssertTrue(cheapList.shoppingList[0].name == "Méz")
            XCTAssertTrue(cheapList.shoppingList[1].name == "Vaj")
            XCTAssertTrue(cheapList.shoppingList[2].name == "Gouda sajt")
            expectation.fulfill()
            
        } catch {
            XCTFail("Test failed with error: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5)
    }
}
