//
//  CodableHelper.swift
//  APIService
//
//  Created by sooraj kahar on 15/11/25.
//

import Foundation

public struct CodableHelper {
    
    public static func encodeData<T:Codable>(data : T) -> Data?{
        do{
            return try JSONEncoder().encode(data)
        }catch let error{
            print("Error found while encoding ",error)
        }
        return nil
    }
    
    public static func decodeData<T: Codable>(type : T.Type, data: Data) -> T?{
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch let error{
            print("Error found while encoding ",error)
        }
        return nil
    }
    
}

public extension String{
    
    func toJSON() -> StringAnyDict{
        guard let jsonData = self.data(using: .utf8) else{
            return [:]
        }
        return jsonData.toJSON() ?? [:]
    }
    
    func toJSONArray() -> StringAnyDictArray{
        guard let jsonData = self.data(using: .utf8) else{
            return []
        }
        return jsonData.toJSONArray()
    }
    
}

public extension Data{
    
    func toJSON() -> StringAnyDict?{
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? StringAnyDict
        } catch let error {
            print("Error deserializing JSON: \(error)")
        }
        return nil
    }
    
    func toJSONArray() -> StringAnyDictArray{
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? StringAnyDictArray ?? []
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        return []
    }
    
}
