import Testing
import Foundation
@testable import MobileTechTest

@Suite("AthleteTests")
struct AthleteTests {
    @Test("Athlete decoding with valid JSON")
    func athleteDecoding() throws {
        let json = """
        {
            "first_name":"Al",
            "last_name":"Saunders",
            "id":5011,
            "image":{
                "url":"https://kitman.imgix.net/avatar.jpg"
            },
            "username":"asaunders",
            "squad_ids":[78]
        }
        """
        
        let data = json.data(using: .utf8)!
        let athlete = try JSONDecoder().decode(Athlete.self, from: data)
        
        #expect(athlete.firstName == "Al")
        #expect(athlete.lastName == "Saunders")
        #expect(athlete.id == 5011)
        #expect(athlete.imageURL?.absoluteString == "https://kitman.imgix.net/avatar.jpg")
        #expect(athlete.username == "asaunders")
        #expect(athlete.squadIds == [78])
    }
    
    @Test("Athlete decoding with valid JSON without imageURL")
    func athleteDecodingWithoutImage() throws {
        let json = """
        {
            "first_name":"Al",
            "last_name":"Saunders",
            "id":5011,
            "username":"asaunders",
            "squad_ids":[78]
        }
        """
        
        let data = json.data(using: .utf8)!
        let athlete = try JSONDecoder().decode(Athlete.self, from: data)
        
        #expect(athlete.firstName == "Al")
        #expect(athlete.lastName == "Saunders")
        #expect(athlete.id == 5011)
        #expect(athlete.imageURL == nil)
        #expect(athlete.username == "asaunders")
        #expect(athlete.squadIds == [78])
    }

    @Test("Athlete decoding with multiple squads")
    func athleteDecodingWithMultipleSquads() throws {
        let json = """
        {
            "first_name":"John",
            "last_name":"Doe",
            "id":1234,
            "image":{
                "url":"https://example.com/image.jpg"
            },
            "username":"jdoe",
            "squad_ids":[1, 2, 3]
        }
        """
        
        let data = json.data(using: .utf8)!
        let athlete = try JSONDecoder().decode(Athlete.self, from: data)
        
        #expect(athlete.firstName == "John")
        #expect(athlete.lastName == "Doe")
        #expect(athlete.id == 1234)
        #expect(athlete.imageURL?.absoluteString == "https://example.com/image.jpg")
        #expect(athlete.username == "jdoe")
        #expect(athlete.squadIds == [1, 2, 3])
    }
    

    @Test("Athlete decoding fails with missing fields")
    func athleteDecodingFailsWithMissingFields() {
        let json = """
        {
            "first_name":"Al",
            "id":5011,
            "username":"asaunders"
        }
        """
        
        let data = json.data(using: .utf8)!
        
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Athlete.self, from: data)
        }
    }

    @Test("Athlete decoding fails with invalid id")
    func athleteDecodingFailsWithInvalidId() {
        let json = """
        {
            "first_name":"Al",
            "last_name":"Saunders",
            "id": "5011",
            "image":"invalid_string",
            "username":"asaunders",
            "squad_ids":[78]
        }
        """
        
        let data = json.data(using: .utf8)!
        
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Athlete.self, from: data)
        }
    }
}

