//
//  File.swift
//  CarSimulator
//
//  Created by Marty on 10.06.17.
//  Copyright © 2017 Marty. All rights reserved.
//

class Car {
  
  private enum EngineStatus: String {
    case on
    case off
  }
  
  private enum Direction: String {
    case forward
    case backward
    case stand
  }
  
  private let speedLimit = [
   -1 :  0...20,
    0 :  0...299_792_458, // It must be a const, but compiler doesn't think so
    1 :  0...30,
    2 : 20...50,
    3 : 30...60,
    4 : 40...90,
    5 : 50...150
  ]
  
  private var engineStatus  = EngineStatus.off
  private var direction     = Direction.stand
  private var gear          = 0
  private var speed         = 0
  
  
  
  func turnOnEngine() -> Bool {
    guard self.engineStatus == .off && self.gear      == 0 &&
          self.speed        == 0    && self.direction == .stand
      else { return false }
    
    self.engineStatus = .on
    return true
  }
  
  
  func turnOffEngine() -> Bool {
    guard self.engineStatus == .on && self.gear      == 0 &&
          self.speed        == 0   && self.direction == .stand
      else { return false }
    
    self.engineStatus = .off
    return true
  }
  
  
  //set speed and direction
  func setSpeed(withSpeed speed: Int) -> Bool {
    guard self.engineStatus == .on && speedLimit[self.gear] != nil
      else { return false }
    
    let speedRange = speedLimit[self.gear]!
    
    guard speedRange.contains(speed)
      else { return false }
    
    if gear != 0 || speed <= self.speed {
      
      if speed     ==  0 { self.direction = .stand }
      else if gear == -1 { self.direction = .backward }
      else if gear !=  0 { self.direction = .forward }

      self.speed = speed
      return true
      
    } else { return false }
    
  }
  
  
  func setGear(withGear gear: Int) -> Bool {
    guard speedLimit[gear] != nil && speedLimit[gear]!.contains(self.speed) //?
      else { return false }
    
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
  
  
  // Some useful things
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

