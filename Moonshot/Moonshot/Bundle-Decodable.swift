//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/20/24.
//

import Foundation

extension Bundle{
    func decode<T: Codable>(_ file: String) -> T /*[String: Astronaut]*/ {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(/*[String: Astronaut]*/T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
