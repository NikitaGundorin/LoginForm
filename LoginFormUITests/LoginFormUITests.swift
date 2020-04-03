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

    func testSubmitButtonDisabled() throws {
        
        let app = XCUIApplication()
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".buttons[\"Submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
