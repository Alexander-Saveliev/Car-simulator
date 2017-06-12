//
//  Instruction.swift
//  CarSimulator
//
//  Created by Marty on 11.06.17.
//  Copyright © 2017 Marty. All rights reserved.
//

private enum Instruction {
  case info
  case engineOn
  case engineOff
  case setGear(gear: Int)
  case setSpeed(speed: Int)
  case exit
  case empty
}


private func defineInstruction() -> Instruction {
  var designation = readLine() ?? ""
  
  switch designation {
  case "info":
    return Instruction.info
    
  case "engineOn":
    return Instruction.engineOn
    
  case "engineOff":
    return Instruction.engineOff
    
  case _ where designation.hasPrefix("setGear "):
    let prefixLength = 8
    let value = designation.startIndex..<designation.index(designation.startIndex, offsetBy: prefixLength)
    designation.removeSubrange(value)
    
    if let valueInt = Int(designation) {
      return Instruction.setGear(gear: valueInt)
    } else {
      print("wrong atribute: ", designation)
      return Instruction.empty
    }
    
  case _ where designation.hasPrefix("setSpeed "):
    let prefixLength = 9
    let value = designation.startIndex..<designation.index(designation.startIndex, offsetBy: prefixLength)
    designation.removeSubrange(value)
    
    if let valueInt = Int(designation) {
      return Instruction.setSpeed(speed: valueInt)
    } else {
      print("wrong atribute: ", designation)
      return Instruction.empty
    }
    
  case "exit":
    return Instruction.exit
    
  default:
    print("I don't know this instruction: ", designation)
    return Instruction.empty
  }
}


func carSimulator(car myCar: Car) {
  
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
        print("I can't set this gear")
      }
      
    case .exit:
      break ExitMark
      
    case .empty:
      break
    }
  }
}
