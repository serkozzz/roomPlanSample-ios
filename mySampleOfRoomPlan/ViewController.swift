//
//  ViewController.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 05.01.2024.
//

import UIKit
import RoomPlan
import simd

class ViewController: UIViewController, RoomCaptureViewControllerDelegate {
    
    @IBOutlet weak var layoutView: LayoutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
///*
        if let room = RoomCaptureHelper.createRoomCaptureResultFromRawJSON() {
            RoomCaptureHelper.saveToDisk(result: room)
        }
//*/
        
///*
        if let room = RoomCaptureHelper.createRoomCaptureResultFromFile() {
            layoutView.setWalls(walls: room.walls)
            layoutView.setDoors(doors: room.doors)
            layoutView.setWindows(windows: room.windows)
        }
//*/
    }
    

    
    @IBAction func startScan(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RoomPlanMain", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "RoomCaptureViewNavigationController")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    func roomCapture(sender: RoomCaptureViewController, didFinishedWithResult result:  RoomCaptureResult) {
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(result)
        {
            print(jsonData)
        }
    }
}

