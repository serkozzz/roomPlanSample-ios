//
//  RoomCapture.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 12.01.2024.
//

import Foundation
import simd

class RoomCaptureHelper {
    
//    struct Window {
//        var dimentions : simd_float3
//        var transform : simd_float4x4
//    }
//
//    struct Door {
//        var dimentions : simd_float3
//        var transform : simd_float4x4
//    }
//
    struct Surface2D {
        var start: CGPoint
        var end: CGPoint
    }
    
    static func convertSurfaceTo2D(transform: simd_float4x4, dimensions: simd_float3) -> Surface2D {
        let start = matrix_multiply(transform, simd_float4(-dimensions / 2, 1))
        let end = matrix_multiply(transform, simd_float4(dimensions / 2, 1))
        
        let start2D = CGPoint(x: Double(start.x), y: Double(start.z) )
        let end2D = CGPoint(x: Double(end.x), y: Double(end.z))
        return Surface2D(start: start2D, end: end2D)
    }

}
