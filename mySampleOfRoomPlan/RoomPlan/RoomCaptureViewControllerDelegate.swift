//
//  RoomCaptureViewControllerDelegate.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 18.01.2024.
//

import Foundation


protocol RoomCaptureViewControllerDelegate : AnyObject {
    func roomCapture(didFinishedWithResult result:RoomCaptureResult)
}
