//
//  CarSimulatorTest.swift
//  CarSimulatorTest
//
//  Created by Marty on 06.06.17.
//  Copyright © 2017 Marty. All rights reserved.
//

import XCTest
@testable import CarSimulator

class CarSimulatorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  // the engine is off, gear is 0, speed is 0, stand
  let ferrari = Car()
  
  // can't turn off the engine, set gear and set speed
  func testTurnOffEngine() {
    ferrari.resetCar()
    
    XCTAssertFalse( ferrari.turnOffEngine() )
    XCTAssertFalse( ferrari.setGear(withGear: 1) )
    XCTAssertFalse( ferrari.setSpeed(withSpeed: 10) )
  }
  
  // can turn on engine. Can set gear 1 , -1 when the engine is on
  func testTurnOnEngine() {
    ferrari.resetCar()
    
    XCTAssertTrue( ferrari.turnOnEngine() )
    XCTAssertTrue( ferrari.setGear(withGear: 1) )
    XCTAssertTrue( ferrari.setGear(withGear: -1) )
  }
  
  // can't turn off the engine with a gear
  func testTurnOffEngineWithGear() {
    ferrari.resetCar()
    ferrari.turnOnEngine()
    ferrari.setGear(withGear: 1)
    
    XCTAssertFalse( ferrari.turnOffEngine() )
    
    ferrari.setGear(withGear: -1)
    
    XCTAssertFalse( ferrari.turnOffEngine() )
  }
  
  // with 1 gear can set speed [0 .. 30], set gear 0, set -1 gear with speed 0, set gear 2 with speed [20 .. 30]
  func testFirstGear() {
    ferrari.resetCar()
    ferrari.turnOnEngine()
    ferrari.setGear(withGear: 1)
    
    XCTAssertTrue(ferrari.setSpeed(withSpeed: 10))
    XCTAssertFalse(ferrari.setSpeed(withSpeed: 40))
    XCTAssertTrue(ferrari.setGear(withGear: 0))
    XCTAssertFalse(ferrari.setGear(withGear: -1))
    
    ferrari.setSpeed(withSpeed: 0)
    XCTAssertTrue(ferrari.setGear(withGear: -1))
    
    ferrari.setGear(withGear: 1)
    ferrari.setSpeed(withSpeed: 19)
    
    XCTAssertFalse(ferrari.setGear(withGear: 2))

    ferrari.setSpeed(withSpeed: 20)
    XCTAssertTrue(ferrari.setGear(withGear: 2))
  }
  
  // with gear 0 and stright movement. Can't increase a speed, can reducs a speed or save
  func testZerotGear() {
    ferrari.resetCar()
    ferrari.turnOnEngine()
    ferrari.setGear(withGear: 1)
    ferrari.setSpeed(withSpeed: 10)
    ferrari.setGear(withGear: 0)
    
    XCTAssertFalse(ferrari.setSpeed(withSpeed: 15))
    XCTAssertTrue(ferrari.setSpeed(withSpeed: 10))
    XCTAssertTrue(ferrari.setSpeed(withSpeed: 9))
  }
  
}
