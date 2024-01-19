//
//  ViewController.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 05.01.2024.
//


import UIKit
import simd

let ROOM_PLAN_DUMMY = false

class ViewController: UIViewController, RoomCaptureViewControllerDelegate {
    
    @IBOutlet weak var layoutView: LayoutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let room = RoomCaptureHelper.createRoomCaptureResultFromRawJSON() {
//            RoomCaptureHelper.saveToDisk(result: room)
//        }

    }
    

    
    @IBAction func startScan(_ sender: UIButton) {
        
        if (ROOM_PLAN_DUMMY) {
            let viewController = RoomCaptureViewControllerDummy()
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
            viewController.delegate = self
        }
        else {
            if (RoomCaptureHelper.isSupported()) {
                
                if #available(iOS 16.0, *) {
                    let storyboard = UIStoryboard(name: "RoomPlanMain", bundle: nil)
                    if let viewController = storyboard.instantiateViewController(
                        withIdentifier: "RoomCaptureViewController") as? RoomCaptureViewController {
                        
                        let nav = UINavigationController()
                        nav.pushViewController(viewController, animated: false)
                        viewController.modalPresentationStyle = .fullScreen
                        present(nav, animated: true)
                        viewController.delegate = self
                    }
                }
            }
        }
    }


    func roomCapture(didFinishedWithResult result:  RoomCaptureResult) {
        dismiss(animated: true)
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(result)
        {
            print(jsonData)
            layoutView.setWalls(walls: result.walls)
            layoutView.setDoors(doors: result.doors)
            layoutView.setWindows(windows: result.windows)
        }
        
        
    }
}

