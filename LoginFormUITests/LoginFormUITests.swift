//
//  LoginFormUITests.swift
//  LoginFormUITests
//
//  Created by Никита Гундорин on 02.04.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import XCTest

class LoginFormUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSubmitButtonDisabledAfterLaunch() throws {
        let isEnabled = app.buttons["Submit"].isEnabled
        XCTAssertFalse(isEnabled)
    }
    
    func testSubmitButtonEnablesAfterFillingTextFields() {
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("e")
        let isEnabledAfterFillingEmail = app.buttons["Submit"].isEnabled
        XCTAssertFalse(isEnabledAfterFillingEmail)
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("p")
        
        let isEnabledAfterFillingPassword = app.buttons["Submit"].isEnabled
        XCTAssertTrue(isEnabledAfterFillingPassword)
    }
    
    func testSubmitButtonDisablesAfterRemovingTextFromEmailField() {
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("e")
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("p")
        
        app.textFields["E-mail"].doubleTap()
        app.keys["delete"].tap()
        
        let isEnabledAfterRemovingTextFromEmailField = app.buttons["Submit"].isEnabled
        XCTAssertFalse(isEnabledAfterRemovingTextFromEmailField)
    }
    
    func testSubmitButtonDisablesAfterRemovingTextFromPasswordField() {
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("e")
        
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("p")
        app.keys["delete"].tap()
        
        let isEnabledAfterRemovingTextFromPasswordField = app.buttons["Submit"].isEnabled
        XCTAssertFalse(isEnabledAfterRemovingTextFromPasswordField)
    }
    
    func testWhenSendWithInvalidEmailWarningIsShown() {
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("email.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("123")
        app.buttons["Submit"].tap()
        let warningLabel = app.staticTexts["Invalid email"]
        XCTAssertTrue(warningLabel.exists)
    }
    
    func testWhenSendWithInvalidPasswordWarningIsShoww() {
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("email@e.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("1")
        app.buttons["Submit"].tap()
        
        let warningLabel1 = app.staticTexts["Password must not be shorter than 6 characters"]
        XCTAssertTrue(warningLabel1.exists)
        
        app.secureTextFields["Password"].typeText("23456")
        app.buttons["Submit"].tap()
        let warningLabel2 = app.staticTexts["Password must contain at least one uppercase letter"]
        XCTAssertTrue(warningLabel2.exists)
        
        app.secureTextFields["Password"].typeText("A")
        app.buttons["Submit"].tap()
        let warningLabel3 = app.staticTexts["Password must contain at least one lowercase letter"]
        XCTAssertTrue(warningLabel3.exists)
        
        app.secureTextFields["Password"].doubleTap()
        app.secureTextFields["Password"].typeText("Password")
        app.buttons["Submit"].tap()
        let warningLabel4 = app.staticTexts["Password must contain at least one number"]
        XCTAssertTrue(warningLabel4.exists)
    }
    
    func testWhenAllFieldsValidAndSendPressedWelcomeIsShown() {
        app.textFields["E-mail"].tap()
        app.textFields["E-mail"].typeText("email@e.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("Password1")
        app.buttons["Submit"].tap()
        
        let welcomeStaticText = app.staticTexts["Welcome!"]
        XCTAssertTrue(welcomeStaticText.exists)
    }
}
