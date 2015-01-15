//
//  ModelTests.swift
//  WowAttendance
//
//  Created by Mohsin on 15/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit
import XCTest
//import WowAttendance


class ModelTests: XCTestCase {
   
    func testSignInAndUserExist(){
        
        // Declare our expectation
        let loginExpectation = expectationWithDescription("login")
        let UserIsExistExpectation = expectationWithDescription("login1")
        
        // Call the asynchronous method with completion handler
        wowref.asyncLoginUser("ziaukhan@hotmail.com", password: "123") { (error, user) -> Void in
            
            // Perform our tests...
            XCTAssertNil(error, "login Sussessfuly \(user?.userName)")
            
            // And fulfill the expectation...
            loginExpectation.fulfill()
            
        }
        
        
        // Call the asynchronous method with completion handler
        wowref.asynUserIsExist("mmohsin", callBack: { (isExist) -> Void in
            
            // Perform our tests...
            XCTAssertTrue(isExist, "user id exist")
        
            // And fulfill the expectation...
            UserIsExistExpectation.fulfill()
            
        })
        
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(15, { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testAdd(){
        let add = wowref.tempAdd(2, b: 8)
        
        XCTAssertEqual(add, 10, "both are equal")
    }
    
}
