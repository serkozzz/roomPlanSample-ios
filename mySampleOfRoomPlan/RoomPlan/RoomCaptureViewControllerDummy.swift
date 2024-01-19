//
//  RoomCaptureViewControllerDummy.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 19.01.2024.
//

import Foundation
import UIKit

class RoomCaptureViewControllerDummy: UIViewController
{
    weak var delegate: RoomCaptureViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        let doneButton = UIButton(type: .system, primaryAction: UIAction(title: "Done", handler: { _ in
            if let result = RoomCaptureHelper.createRoomCaptureResultFromFile() {
                self.delegate?.roomCapture(didFinishedWithResult: result)
            }
        }))

        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            doneButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
