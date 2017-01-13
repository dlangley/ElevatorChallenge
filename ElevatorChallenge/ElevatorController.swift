//
//  ElevatorController.swift
//  ElevatorChallenge
//
//  Created by Dwayne Langley on 1/13/17.
//
//

import UIKit

class ElevatorController: UIViewController {
    
    @IBOutlet var currentFloorLabel: UILabel!
    @IBOutlet var topFloorLabel: UILabel!
    @IBOutlet var queueLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var configMessage: UILabel!
    @IBOutlet var floorField: UITextField!
    
    @IBAction func floorsSet(_ sender: AnyObject) {
        installForBuilding(with: Int(floorField.text!))
        
        configMessage.text = "Building Set!"
        requests.removeAll()
    }
    
    
    @IBAction func nextFloorPressed(_ sender: UIButton) {
        moveToNextFloor()
    }
    
    var requests = [Int]() {
        willSet {
            self.queueLabel.text = "\(newValue)"
            nextButton.isEnabled = !newValue.isEmpty
        }
    }
    
    var car : Elevator!
    var panel : ButtonPanelCVC!
    
    
    func installForBuilding(with floors: Int?) {
        car = Elevator(with: floors)
        car.delegate = self
        
        panel = childViewControllers.first as! ButtonPanelCVC
        panel.delegate = self
        
        panel.floors = car.topFloor
    }
    
    /// Receives a floor request
    func request(floor: Int) {
        guard 1...car.topFloor ~= floor else {
            return
        }
        
        requests.append(floor)
    }
    
    /// Moves the elevator to the next requested floor.
    func moveToNextFloor() {
        guard !requests.isEmpty else {
            return
        }
        
        car.currentFloor = requests.removeFirst()
    }
}

extension ElevatorController: ElevatorDelegate {
    
    func changesOccured() {
        topFloorLabel.text = "\(car.topFloor)"
        currentFloorLabel.text = "\(car.currentFloor)"
    }
}

extension ElevatorController: SelectionDelegate {
    
    func addSelection(floor: Int) {
        request(floor: floor)
    }
}
