//
//  BaziAnalysisUITests.swift
//  BaziAnalysisUITests
//
//  Created by catcher on 2024/12/22.
//

import XCTest

final class BaziAnalysisUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testBasicNavigation() throws {
        // 测试底部标签栏导航
        XCTAssertTrue(app.tabBars["TabBar"].buttons["分析"].exists)
        XCTAssertTrue(app.tabBars["TabBar"].buttons["历史"].exists)
        XCTAssertTrue(app.tabBars["TabBar"].buttons["我的"].exists)
        
        // 测试分析页面基本元素
        XCTAssertTrue(app.datePickers["出生日期"].exists)
        XCTAssertTrue(app.datePickers["出生时间"].exists)
        XCTAssertTrue(app.buttons["开始分析"].exists)
    }
    
    func testAnalysisFlow() throws {
        // 选择日期和时间
        app.datePickers["出生日期"].tap()
        app.datePickers["出生时间"].tap()
        
        // 点击分析按钮
        app.buttons["开始分析"].tap()
        
        // 验证结果页面元素
        XCTAssertTrue(app.staticTexts["您的八字"].exists)
        XCTAssertTrue(app.staticTexts["五行分析"].exists)
        XCTAssertTrue(app.staticTexts["命理建议"].exists)
    }
}
