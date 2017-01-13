//
//  Elevator.swift
//  ElevatorChallenge
//
//  Created by Dwayne Langley on 1/13/17.
//
//

import Foundation

struct Elevator {
    var topFloor = Int() {
        didSet {
            self.delegate?.changesOccured()
        }
    }
    
    var currentFloor = 1 {
        didSet {
            self.delegate?.changesOccured()
        }
    }
    
    var delegate : ElevatorDelegate? {
        didSet {
            self.delegate?.changesOccured()
        }
    }
    
    
    /// Creates an elevator structure for a specified amount of floors.
    init(with floors : Int? = 0) {
        guard floors! > 0 else {
            topFloor = currentFloor
            return
        }
        
        topFloor = floors!
    }
}

protocol ElevatorDelegate {
    func changesOccured()
}
