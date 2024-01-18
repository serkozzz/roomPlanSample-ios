//
//  LayoutView.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 05.01.2024.
//

import UIKit
import simd
import RoomPlan

class LayoutView: UIView {
    typealias Surface2D = RoomCaptureResult.Surface2D
    typealias Surface3D = RoomCaptureResult.Surface3D
    
    func setWindows(windows: [Surface3D]) {
        self.windowsToDraw = windows
        setNeedsDisplay()
    }
     
    func setDoors(doors: [Surface3D]) {
        self.doorsToDraw = doors
        setNeedsDisplay()
    }
    
    func setWalls(walls: [Surface3D]) {
        self.wallsToDraw = walls
        setNeedsDisplay()
    }

    
    private func drawEdgesFor(surface: RoomCaptureHelper.Surface2D) {
        let path = UIBezierPath()
        let start = CGPoint(x: surface.start.x * scale + translationX, y: surface.start.y * scale + translationY)
        let end = CGPoint(x: surface.end.x * scale + translationX, y: surface.end.y * scale + translationY)
        
        UIColor.blue.setStroke()
        UIColor.gray.setFill()
        let pathCircle1 = UIBezierPath.init(arcCenter: start, radius: pointsRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        pathCircle1.close()
        pathCircle1.stroke()
        pathCircle1.fill()
        
        UIColor.blue.setStroke()
        UIColor.gray.setFill()
        let pathCircle2 = UIBezierPath.init(arcCenter: end, radius: pointsRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        pathCircle2.close()
        pathCircle2.stroke()
        pathCircle2.fill()
    }
    
    private func drawLineFor(surface: RoomCaptureHelper.Surface2D, color: UIColor ) {
        
        let path = UIBezierPath()
        let start = CGPoint(x: surface.start.x * scale + translationX, y: surface.start.y * scale + translationY)
        let end = CGPoint(x: surface.end.x * scale + translationX, y: surface.end.y * scale + translationY)
        
        color.setStroke()
        
        path.move(to: start)
        path.addLine(to: end)
        
        
        
        path.close()

        path.lineWidth = 3.0
        path.stroke()
        path.fill()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        UIColor.blue.setStroke()
        UIColor.green.setFill()
        


        
        for wall3D in wallsToDraw {
            let wall = RoomCaptureHelper.convertSurfaceTo2D(transform: wall3D.transform, dimensions: wall3D.dimensions)
            self.drawLineFor(surface: wall, color: UIColor.gray)
            //self.drawEdgesFor(surface: wall)
        }
        
        for window3D in windowsToDraw {
            let window = RoomCaptureHelper.convertSurfaceTo2D(transform: window3D.transform, dimensions: window3D.dimensions)
            self.drawLineFor(surface: window, color: UIColor.blue)
            self.drawEdgesFor(surface: window)
        }
        
        for door3D in doorsToDraw {
            let door = RoomCaptureHelper.convertSurfaceTo2D(transform: door3D.transform, dimensions: door3D.dimensions)
            self.drawLineFor(surface: door, color: UIColor.green)
            self.drawEdgesFor(surface: door)
        }

    }
    
    private var wallsToDraw: [Surface3D] = []
    private var windowsToDraw: [Surface3D] = []
    private var doorsToDraw: [Surface3D] = []
    
    private let scale:Double = 50.0
    private let translationX = 400.0
    private let translationY = 200.0
    private let pointsRadius = 5.0
}
