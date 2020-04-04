//
//  LoginFormTests.swift
//  LoginFormTests
//
//  Created by Никита Гундорин on 02.04.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import XCTest
@testable import LoginForm

class LoginFormTests: XCTestCase {
    var sut: ViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCheckValidEmailShouldReturnFalseForIncorrectEmails() {
        let invalidEmail1 = "123@abc"
        let result1 = sut.checkValidEmail(email: invalidEmail1)
        XCTAssertFalse(result1, "Positive result for invalid email")
        
        let invalidEmail2 = "abcabc.ru"
        let result2 = sut.checkValidEmail(email: invalidEmail2)
        XCTAssertFalse(result2, "Positive result for invalid email")
    }
    
    func testCheckValidEmailShouldReturnTrueForCorrectEmails() {
        let validEmail1 = "1abc12@abc.com"
        let result1 = sut.checkValidEmail(email: validEmail1)
        XCTAssertTrue(result1, "Negative result for valid email")
        
        let validEmail2 = "test2_a@yandex.ru"
        let result2 = sut.checkValidEmail(email: validEmail2)
        XCTAssertTrue(result2, "Negative result for valid email")
    }
    
    func testCheckValidPasswordShouldReturnCorrectWarningForShortPassword() {
        let shortPassword = "abc12"
        let result = sut.checkValidPassword(password: shortPassword)
        XCTAssertEqual(result,
                       "Password must not be shorter than 6 characters",
                       "Incorrect result for short password")
    }
    
    func testCheckValidPasswordShouldReturnCorrectWarningForUppercaselessPass() {
        let uppercaselessPass = "abcdef"
        let result = sut.checkValidPassword(password: uppercaselessPass)
        XCTAssertEqual(result,
                       "Password must contain at least one uppercase letter",
                       "Incorrect result for password without upeprcase")
    }
    
    func testCheckValidPasswordShouldReturnCorrectWarningForLowercaselessPass() {
        let lowercaselessPass = "PASSWORD"
        let result = sut.checkValidPassword(password: lowercaselessPass)
        XCTAssertEqual(result,
                       "Password must contain at least one lowercase letter",
                       "Incorrect result for password without lowercase")
    }
    
    func testCheckValidPasswordShouldReturnCorrectWarningForNumberslessPass() {
        let numberslessPass = "Password"
        let result = sut.checkValidPassword(password: numberslessPass)
        XCTAssertEqual(result,
                       "Password must contain at least one number",
                       "Incorrect result for password without numbers")
    }
    
    func testCheckValidPasswordShouldReturnNilForCorrectPassword() {
        let validPassword1 = "Abcd11"
        let result1 = sut.checkValidPassword(password: validPassword1)
        XCTAssertNil(result1, "Incorrect result for correct password")
        
        let validPassword2 = "Password01"
        let result2 = sut.checkValidPassword(password: validPassword2)
        XCTAssertNil(result2, "Incorrect result for correct password")
    }
}
