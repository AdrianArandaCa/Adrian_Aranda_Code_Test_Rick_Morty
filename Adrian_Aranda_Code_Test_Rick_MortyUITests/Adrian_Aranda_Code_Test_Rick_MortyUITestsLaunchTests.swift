//
//  Adrian_Aranda_Code_Test_Rick_MortyUITestsLaunchTests.swift
//  Adrian_Aranda_Code_Test_Rick_MortyUITests
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import XCTest

final class Adrian_Aranda_Code_Test_Rick_MortyUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
