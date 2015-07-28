//
//  StarBoseTests.swift
//  StarBoseTests
//
//  Created by MrSmall on 2015/06/26.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import UIKit
import XCTest

class StarBoseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testSBState() {
    
        let state :SBState = SBState()
        
        // test for check range
        let val = state[99, 99]!
        XCTAssertEqual(val, Piece.NONE, "faild check range1")
        
        let val2 = state[-1, -1]!
        XCTAssertEqual(val2, Piece.NONE, "faild check range2")
        
        // test for set/get
        state[1, 1] = Piece.STAR
        let ret = state[1, 1]!
        XCTAssertEqual(ret, Piece.STAR, "faild check set/get")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
