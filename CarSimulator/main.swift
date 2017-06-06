//
//  main.swift
//  CarSimulator
//
//  Created by Marty on 06.06.17.
//  Copyright © 2017 Marty. All rights reserved.
//


// MARK: Car
class Car {
  enum EngineStatus: String {
    case on, off
  }
  
  enum Direction: String {
    case forward, backward, stand
  }
  
  let speedLimit = [
    -1 :  0...20,
     0 :  0...299_792_458, // It must be a const, but compiler doesn't think so
     1 :  0...30,
     2 : 20...50,
     3 : 30...60,
     4 : 40...90,
     5 : 50...150
  ]
  
  var engineStatus  = EngineStatus.off
  var direction     = Direction.stand
  var gear          = 0
  var speed         = 0
  
  
  
  func turnOnEngine() -> Bool {
    guard self.engineStatus == .off && self.gear == 0 && self.speed == 0 && self.direction == .stand else { return false }
    
    self.engineStatus = .on
    return true
  }
  
  
  func turnOffEngine() -> Bool {
    guard self.engineStatus == .on && self.gear == 0 && self.speed == 0 && self.direction == .stand else { return false }
    
    self.engineStatus = .off
    return true
  }
  
  
  //set speed and direction
  func setSpeed(withSpeed speed: Int) -> Bool {
    func setDirection(speed: Int) -> Direction {
      if speed == 0 {
        return .stand
      } else if gear == -1 {
        return .backward
      } else if gear != 0 {
        return .forward
      }
      return self.direction
    }
    
    guard self.engineStatus == .on && speedLimit[self.gear] != nil else { return false }
    
    let speedRange = speedLimit[self.gear]!
    
    guard speedRange.contains(speed) else { return false }
    
    if gear != 0 || (speed < self.speed) {
      self.direction = setDirection(speed: speed)
      self.speed = speed
      return true
    } else {
      return false
    }
  }
  
  
  func setGear(withGear gear: Int) -> Bool {
    guard speedLimit[gear] != nil && speedLimit[gear]!.contains(self.speed) else { return false }

    switch gear {
    case -1 where self.engineStatus == .on && ( self.direction == .stand || self.gear == gear ):
      self.gear = gear
      return true
      
    case 0:
      self.gear = gear
      return true
      
    case 1 where self.engineStatus == .on && ( self.direction == .stand || self.direction == .forward ):
      self.gear = gear
      return true
      
    case 2...5 where self.direction == .forward && self.engineStatus == .on:
      self.gear = gear
      return true
      
    default:
      return false
    }
  }
  
  
  // Some usefull things
  func resetCar() {
    self.speed         = 0
    self.gear          = 0
    self.direction     = .stand
    self.engineStatus  = .off
  }
  
  
  func showCarStatus() {
    print("Engine : \(self.engineStatus.rawValue)")
    print("Direction : \(self.direction.rawValue)")
    print("Gear : \(self.gear)")
    print("Speed : \(self.speed)")
  }
}


// MARK: Instructions
enum Instruction {
  case info
  case engineOn
  case engineOff
  case setGear(gear: Int)
  case setSpeed(speed: Int)
  case exit
  case empty
}


func defineInstruction() -> Instruction {
  var designation: String!  = readLine()
  
  switch designation {
  case "info":
    return Instruction.info
    
  case "engineOn":
    return Instruction.engineOn
    
  case "engineOff":
    return Instruction.engineOff
    
  case _ where designation.hasPrefix("setGear "):
    let value = designation.startIndex..<designation.index(designation.startIndex, offsetBy: 8)
    designation.removeSubrange(value)
    
    if let valueInt = Int(designation) {
      return Instruction.setGear(gear: valueInt)
    } else {
      return Instruction.empty
    }
    
  case _ where designation.hasPrefix("setSpeed"):
    let value = designation.startIndex..<designation.index(designation.startIndex, offsetBy: 9)
    designation.removeSubrange(value)
    
    if let valueInt = Int(designation) {
      return Instruction.setSpeed(speed: valueInt)
    } else {
      return Instruction.empty
    }
    
  case "exit":
    return Instruction.exit
    
  default:
    return Instruction.empty
  }
}


//MARK: Start

func carSimulator() {
  let myCar = Car()
  
  var instructionStatus = Instruction.empty
  
  ExitMark: while true {
    print("\n--> ", separator: "", terminator: "")
    instructionStatus = defineInstruction()
    print()
    
    switch instructionStatus {
    case .info:
      myCar.showCarStatus()
      
    case .engineOn:
      if !myCar.turnOnEngine() {
        print("I can't turn on engine")
      }
      
    case .engineOff:
      if !myCar.turnOffEngine() {
        print("I can't turn off engine")
      }
      
    case .setSpeed(let speed):
      if !myCar.setSpeed(withSpeed: speed) {
        print("I can't set this speed")
      }
      
    case .setGear(let gear):
      if !myCar.setGear(withGear: gear) {
        print("I can't set this geare")
      }
      
    case .exit:
      break ExitMark
      
    case .empty:
      break
    }
  }
}


// MARK: Go

carSimulator()

