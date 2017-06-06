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
  
  
  func testTurnOnEngine() {
    let ferrari = Car()
    
    XCTAssertTrue( ferrari.turnOnEngine() )
    XCTAssertFalse( ferrari.turnOnEngine() )
    
    ferrari.resetCar()
    ferrari.gear = 2
    XCTAssertFalse( ferrari.turnOnEngine() )
    
    ferrari.resetCar()
    ferrari.direction = .forward
    XCTAssertFalse( ferrari.turnOnEngine() )
    
    ferrari.resetCar()
    ferrari.speed = 2
    XCTAssertFalse( ferrari.turnOnEngine() )
  }
  
  
  func testTurnOffEngine() {
    let ferrari = Car()
    
    XCTAssertFalse( ferrari.turnOffEngine() )
    
    ferrari.engineStatus = .on
    XCTAssertTrue( ferrari.turnOffEngine() )
    
    ferrari.engineStatus = .on
    ferrari.gear = -1
    XCTAssertFalse( ferrari.turnOffEngine() )
    
    ferrari.engineStatus = .on
    ferrari.gear = 0
    ferrari.direction = .backward
    XCTAssertFalse( ferrari.turnOffEngine() )
    
    ferrari.engineStatus = .on
    ferrari.gear = 0
    ferrari.speed = 2
    XCTAssertFalse( ferrari.turnOnEngine() )
    
  }
  
  
  func testSetGear() {
    let ferrari = Car()
    XCTAssertFalse( ferrari.setGear(withGear: 3) )
    
    ferrari.speed = 1
    XCTAssertFalse( ferrari.setGear(withGear: -1) )
    
    ferrari.resetCar()
    ferrari.gear = 1
    XCTAssertFalse( ferrari.setGear(withGear: -1) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    XCTAssertTrue( ferrari.setGear(withGear: -1) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.gear = 1
    XCTAssertTrue( ferrari.setGear(withGear: -1) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.direction = .backward
    XCTAssertFalse( ferrari.setGear(withGear: 1) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.direction = .forward
    XCTAssertFalse( ferrari.setGear(withGear: -1) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.direction = .forward
    ferrari.gear = 3
    ferrari.speed = 50
    XCTAssertTrue( ferrari.setGear(withGear: 4) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.direction = .forward
    ferrari.gear = 3
    ferrari.speed = 49
    XCTAssertFalse( ferrari.setGear(withGear: 5) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.direction = .backward
    ferrari.gear = -1
    ferrari.speed = 10
    XCTAssertFalse( ferrari.setGear(withGear: 1) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.direction = .stand
    ferrari.gear = -1
    ferrari.speed = 0
    XCTAssertTrue( ferrari.setGear(withGear: 1) )
    
    ferrari.resetCar()
    ferrari.engineStatus = .on
    ferrari.direction = .backward
    ferrari.gear = -1
    ferrari.speed = 10
    XCTAssertTrue( ferrari.setGear(withGear: 0) )
    
    XCTAssertTrue( ferrari.setGear(withGear: 0) )
    
    XCTAssertFalse( ferrari.setGear(withGear: 1) )
    XCTAssertFalse( ferrari.setGear(withGear: -1) )
    
    ferrari.resetCar()
    ferrari.gear = 1
    XCTAssertFalse( ferrari.setGear(withGear: -1) )
    XCTAssertFalse( ferrari.setGear(withGear: 2) )
    XCTAssertTrue( ferrari.setGear(withGear: 0) )
    
  }
  

  func testSetSpeed() {
    let ferrari = Car()
    XCTAssertFalse( ferrari.setSpeed(withSpeed: 1))
    ferrari.engineStatus = .on
    ferrari.direction = .forward
    ferrari.gear = 2
    ferrari.speed = 30
    XCTAssertFalse( ferrari.setSpeed(withSpeed: 60))
    XCTAssertFalse( ferrari.setSpeed(withSpeed: 19))
    XCTAssertTrue( ferrari.setSpeed(withSpeed: 30))
    XCTAssertTrue( ferrari.setSpeed(withSpeed: 40))
  }
  
}
