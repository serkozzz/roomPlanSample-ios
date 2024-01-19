//
//  RoomCaptureResult.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 18.01.2024.
//

import Foundation
import simd
import RoomPlan

struct RoomCaptureResult : Codable {

    struct Surface3D : Codable {
        var dimensions : simd_float3
        var transform : simd_float4x4
        
        @available(iOS 17.0, *)
        init(from room: CapturedRoom.Surface) {
            self.dimensions = room.dimensions
            self.transform = room.transform
        }
    }
    
    struct Surface2D {
        var start: CGPoint
        var end: CGPoint
    }
    
    struct Object: Codable {
        var dimensions: simd_float3
        var transform: simd_float4x4
        var category: String
        
        @available(iOS 17.0, *)
        init(from object: CapturedRoom.Object) {
            self.dimensions = object.dimensions
            self.transform = object.transform
            self.category = String(describing: object.category)
        }
    }
    
    @available(iOS 17.0, *)
    init(from room: CapturedRoom) {
        walls = room.walls.map {  Surface3D(from: $0) }
        doors = room.doors.map {  Surface3D(from: $0) }
        windows = room.windows.map { Surface3D(from: $0) }
        objects = room.objects.map { Object(from: $0) }
    }
    
    var walls: [Surface3D] = []
    var windows: [Surface3D] = []
    var doors: [Surface3D] = []
    var objects: [Object] = []
}




extension simd_float4x4 : Codable {
    
    enum CodingKeys: String, CodingKey {
      case matrix
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let arr = try values.decode([Float].self, forKey: .matrix)

        self = simd_float4x4(columns: (simd_make_float4(arr[0], arr[1], arr[2], arr[3]),
                                            simd_make_float4(arr[4], arr[5], arr[6], arr[7]),
                                            simd_make_float4(arr[8], arr[9], arr[10], arr[11]),
                                            simd_make_float4(arr[12], arr[13], arr[14], arr[15])))

    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let columnMajorArray = (0..<4).flatMap { col in
            (0..<4).map { row in
                self[col][row]
            }
        }
        try container.encode(columnMajorArray, forKey: .matrix)
    }
    
}
