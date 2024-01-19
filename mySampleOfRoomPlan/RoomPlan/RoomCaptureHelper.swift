//
//  RoomCapture.swift
//  mySampleOfRoomPlan
//
//  Created by Sergey Kozlov on 12.01.2024.
//

import Foundation
import RoomPlan
import simd



class RoomCaptureHelper {
    typealias Surface2D = RoomCaptureResult.Surface2D
    
    
    static func convertSurfaceTo2D(transform: simd_float4x4, dimensions: simd_float3) -> Surface2D {
        let start = matrix_multiply(transform, simd_float4(-dimensions / 2, 1))
        let end = matrix_multiply(transform, simd_float4(dimensions / 2, 1))
        
        let start2D = CGPoint(x: Double(start.x), y: Double(start.z) )
        let end2D = CGPoint(x: Double(end.x), y: Double(end.z))
        return Surface2D(start: start2D, end: end2D)
    }

    
    static func saveToDisk(result: RoomCaptureResult) {
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(result)
        {
            print(jsonData)
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("RoomCaptureResult.json")
            {
                //let destinationFolderURL = FileManager.default.temporaryDirectory.appending(path: "Export")
                //let url = destinationFolderURL.appending(path: "RoomCaptureResult.json")
                do {
                    try jsonData.write(to: url)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func createRoomCaptureResultFromRawJSON() -> RoomCaptureResult? {
        guard let room: CapturedRoom = loadFrom(jsonFile: "TestRoomRaw") else { return nil }
        return RoomCaptureResult(from: room)
            
    }
    
    static func createRoomCaptureResultFromFile() -> RoomCaptureResult? {
        return loadFrom(jsonFile: "RoomCaptureResult")
    }
    
    private static func loadFrom<T: Decodable>(jsonFile fileName: String) -> T? {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(T.self, from: data)
            print(result)
            return result
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
