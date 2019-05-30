//
//  Tests.swift
//  Tests
//
//  Created by Suyeol Jeon on 17/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import XCTest

import TouchAreaInsets

class Tests: XCTestCase {

  func testTouchArea_withoutInsets() {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    XCTAssertEqual(view.point(inside: CGPoint(x: 50, y: -5), with: nil), false)
    XCTAssertEqual(view.point(inside: CGPoint(x: -5, y: 50), with: nil), false)
    XCTAssertEqual(view.point(inside: CGPoint(x: 105, y: 50), with: nil), false)
    XCTAssertEqual(view.point(inside: CGPoint(x: 50, y: 105), with: nil), false)
    
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: 50, y: -5)), false)
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: -5, y: 50)), false)
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: 105, y: 50)), false)
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: 50, y: 105)), false)
  }

  func testTouchArea_withInsets() {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    view.touchAreaInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    XCTAssertEqual(view.point(inside: CGPoint(x: 50, y: -5), with: nil), true)
    XCTAssertEqual(view.point(inside: CGPoint(x: -5, y: 50), with: nil), true)
    XCTAssertEqual(view.point(inside: CGPoint(x: 105, y: 50), with: nil), true)
    XCTAssertEqual(view.point(inside: CGPoint(x: 50, y: 105), with: nil), true)
    
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: 50, y: -5)), true)
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: -5, y: 50)), true)
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: 105, y: 50)), true)
    XCTAssertEqual(view.accessibilityFrame.contains(CGPoint(x: 50, y: 105)), true)
  }

}
