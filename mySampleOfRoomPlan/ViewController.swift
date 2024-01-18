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
        
        guard let path = Bundle.main.path(forResource: "TestRoom", ofType: "json") else {
            return
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            
            let capturedRoom = try JSONDecoder().decode(CapturedRoom.self, from: data)
            print(capturedRoom)
            
            let roomCaptureResult = RoomCaptureResult(from: capturedRoom)
            
            
            layoutView.setWalls(walls: roomCaptureResult.walls)
            layoutView.setDoors(doors: roomCaptureResult.doors)
            layoutView.setWindows(windows: roomCaptureResult.windows)
            
        } catch {
            print(error.localizedDescription)
        }
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

