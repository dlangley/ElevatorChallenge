//
//  ElevatorChallengeTests.swift
//  ElevatorChallengeTests
//
//  Created by Dwayne Langley on 1/13/17.
//
//

import XCTest
@testable import ElevatorChallenge

class ElevatorChallengeTests: XCTestCase {
    
    /// local instance mock structure, number of floors are set in the Test Setup.
    var building : MockBuilding!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        building = MockBuilding(withFloors: 5)
        building.controller.installForBuilding(with: building.floors)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Verifies that the specified number of floors is supported by the elevator controller.
    func testFloorSupportAtInstallation() {
        
        // Additional Setup
        let elevator = building.controller.car
        
        // Actual Test
        XCTAssert(elevator?.topFloor == building.floors, "This building can not support \(building.floors) floors.")
        
    }
    
    /// Verifies that the elevator receives requests.
    func testFloorRequest() {
        
        // Additional Setup
        let requestedFloor = 3
        building.controller.request(floor: requestedFloor)
        
        // Actual Test
        guard 1...building.floors ~= requestedFloor else {
            XCTFail("Invalid Request")
            return
        }
        
        XCTAssert(building.controller.requests.contains(requestedFloor), "Request for level \(requestedFloor) has not been received.")
        
    }
    
    /// Verifies that the elevator will go to the next requested floor.
    func testRequestQueue() {
        
        // Additional Setup
        let requestQueue = [3, 5, 2, 4, 1]
        
        for level in requestQueue {
            building.controller.request(floor: level)
        }
        
        // Actual Test
        for index in 0..<requestQueue.count {
            building.controller.moveToNextFloor()
            
            let current = building.controller.car.currentFloor
            XCTAssert(current == requestQueue[index], "We could not move to level \(requestQueue[index])")
        }
    }
    
    /// Verifies the passenger can check the current floor.
    func testCurrentFloorCheck() {
        
        // Additional Setup
        let requestQueue = [3, 5, 2, 4, 1]
        
        for level in requestQueue {
            building.controller.request(floor: level)
        }
        
        // Actual Test
        for index in 0..<requestQueue.count {
            building.controller.moveToNextFloor()
            
            let current = building.controller.car.currentFloor
            XCTAssert(current != nil, "There is no current floor")
        }
    }

}

/// Mock structure for testing specified elevator controller requirements.
struct MockBuilding {
    init(withFloors amount: Int) {
        floors = amount
    }
    var floors: Int
    
    var controller = ElevatorController()
    
}
