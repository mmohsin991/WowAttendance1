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
            XCTAssertNil(error, "login Sussessfuly \(user?.uID)")
            
            // And fulfill the expectation...
            loginExpectation1.fulfill()
            
        }
        
        //if login with correct username and Wrong password
        wowref.asyncLoginUser("ziaukhan@hotmail.com", password: "xyz") { (error, user) -> Void in

            XCTAssertNotNil(error, "login Sussessfuly \(user?.uID)")
            
            loginExpectation2.fulfill()
            
        }
        
        //if login with wrong username and correct password
        wowref.asyncLoginUser("xyz@hotmail.com", password: "123") { (error, user) -> Void in
            
            XCTAssertNotNil(error, "login Sussessfuly \(user?.uID)")
            
            loginExpectation3.fulfill()
            
        }
        
        //if login with wrong username and wrong password
        wowref.asyncLoginUser("xyz@hotmail.com", password: "xyz") { (error, user) -> Void in
            
            XCTAssertNotNil(error, "login Sussessfuly \(user?.uID)")
            
            loginExpectation4.fulfill()
            
        }
        
        
        
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(15, { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testUserExist(){
        
        // Declare our expectation
        let UserIsExistExpectation1 = expectationWithDescription("correct username")
        let UserIsExistExpectation2 = expectationWithDescription("wrong username")

        // if corrrect username provided
        // Call the asynchronous method with completion handler
        wowref.asynUserIsExist("mmohsin", callBack: { (isExist) -> Void in
            
            // Perform our tests...
            XCTAssertTrue(isExist, "user id exist")
            
            // And fulfill the expectation...
            UserIsExistExpectation1.fulfill()
            
        })
        
        // if wrong username provided
        wowref.asynUserIsExist("zyz", callBack: { (isExist) -> Void in
            
            // Perform our tests...
            XCTAssertFalse(isExist, "user id does not exist")
            
            // And fulfill the expectation...
            UserIsExistExpectation2.fulfill()
            
        })
        
        
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(15, { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    
    func testSignUp() {
        // Declare our expectation
        let SignUpExpectation1 = expectationWithDescription("new user name")
//        let SignUpExpectation2 = expectationWithDescription("aleady exist username")
//        let SignUpExpectation3 = expectationWithDescription("new user name with aleady exist email")
        
        
        // if new user name provided
        wowref.asyncSignUpUser(User(ref: "", uID: "newUserName", email: "newEmailAddress@gmail.com", firstName: "M", lastName: "Mo", status: "pending"), password: "123") { (error) -> Void in
            
            XCTAssertNil(error, "user signup successfuly")
            SignUpExpectation1.fulfill()
            
        }
        
        
        
        
        waitForExpectationsWithTimeout(15, handler: { (error) -> Void in
            XCTAssertNil(error, "Error")
        })
        
        
        
    }
    
    
    
}
