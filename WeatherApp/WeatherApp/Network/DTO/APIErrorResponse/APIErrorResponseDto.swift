//
//  APIErrorResponseDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 25/07/2024.
//

struct APIErrorResponseDto: Decodable {
    let code: APIErrorResponseCode
    let message: String
    let reference: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case message = "Message"
        case reference = "Reference"
    }
}
