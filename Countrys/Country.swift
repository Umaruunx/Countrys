

import SwiftUI
import Foundation

struct Country: Codable, Hashable {
    let isSuccess: Bool
    let userMessage, technicalMessage: JSONNull?
    let totalCount: Int
    let response: [Response]

    enum CodingKeys: String, CodingKey {
        case isSuccess = "IsSuccess"
        case userMessage = "UserMessage"
        case technicalMessage = "TechnicalMessage"
        case totalCount = "TotalCount"
        case response = "Response"
    }
}

struct Response: Codable, Hashable {
    let name, alpha2Code, alpha3Code, nativeName: String
    let region: Region
    let subRegion, latitude, longitude: String
    let area, numericCode: Int?
    let nativeLanguage, currencyCode, currencyName, currencySymbol: String
    let flag: String
    let flagPNG: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case alpha2Code = "Alpha2Code"
        case alpha3Code = "Alpha3Code"
        case nativeName = "NativeName"
        case region = "Region"
        case subRegion = "SubRegion"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case area = "Area"
        case numericCode = "NumericCode"
        case nativeLanguage = "NativeLanguage"
        case currencyCode = "CurrencyCode"
        case currencyName = "CurrencyName"
        case currencySymbol = "CurrencySymbol"
        case flag = "Flag"
        case flagPNG = "FlagPng"
    }
}

enum Region: String, Codable, Hashable {
    case africa = "Africa"
    case americas = "Americas"
    case asia = "Asia"
    case empty = ""
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher){
              hasher.combine(0)
          }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

