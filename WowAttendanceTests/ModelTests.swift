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
   
    func testSignIn(){
        
        // Declare our expectation
        let loginExpectation1 = expectationWithDescription("login with correct username and password")
        let loginExpectation2 = expectationWithDescription("login with correct username and Wrong password")
        let loginExpectation3 = expectationWithDescription("login with wrong username and correct password")
        let loginExpectation4 = expectationWithDescription("login with wrong username and wrong password")
       
        //if login with correct username and password
        // Call the asynchronous method with completion handler
        wowref.asyncLoginUser("ziaukhan@hotmail.com", password: "123") { (error, user) -> Void in
            
            // Perform our tests...
            XCTAssertNil(error, "login Sussessfuly \(user?.userName)")
            
            // And fulfill the expectation...
            loginExpectation1.fulfill()
            
        }
        
        //if login with correct username and Wrong password
        wowref.asyncLoginUser("ziaukhan@hotmail.com", password: "xyz") { (error, user) -> Void in

            XCTAssertNotNil(error, "login Sussessfuly \(user?.userName)")
            
            loginExpectation2.fulfill()
            
        }
        
        //if login with wrong username and correct password
        wowref.asyncLoginUser("xyz@hotmail.com", password: "123") { (error, user) -> Void in
            
            XCTAssertNotNil(error, "login Sussessfuly \(user?.userName)")
            
            loginExpectation3.fulfill()
            
        }
        
        //if login with wrong username and wrong password
        wowref.asyncLoginUser("xyz@hotmail.com", password: "xyz") { (error, user) -> Void in
            
            XCTAssertNotNil(error, "login Sussessfuly \(user?.userName)")
            
            loginExpectation4.fulfill()
            
        }
        
        
        
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(15, { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testUserExist(){
        
        // Declare our expectation
        let UserIsExistExpectation = expectationWithDescription("login1")

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
    
    
}
