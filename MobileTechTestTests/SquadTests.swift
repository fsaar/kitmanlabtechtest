import Testing
import Foundation
@testable import MobileTechTest

@Suite("SquadTests")
struct SquadTests {
    
    @Test("Squad decoding with valid JSON")
    func squadDecoding() throws {
        let json = """
        {
            "created_at":"2015-09-14T18:26:11.000Z",
            "id":78,
            "name":"staff",
            "organisation_id":6,
            "updated_at":"2015-09-14T18:26:11.000Z"
        }
        """
        
        let data = json.data(using: .utf8)!
        let squad = try JSONDecoder().decode(Squad.self, from: data)
        
        #expect(squad.id == 78)
        #expect(squad.name == "staff")
        #expect(squad.organisationId == 6)
        
        let expectedDate = Squad.dateFormatter.date(from: "2015-09-14T18:26:11.000Z")!
        
        #expect(squad.createdAt == expectedDate)
        #expect(squad.updatedAt == expectedDate)
    }
    
    @Test("Squad decoding with different dates")
    func squadDecodingWithDifferentDates() throws {
        let json = """
        {
            "created_at":"2020-01-01T12:00:00.000Z",
            "id":123,
            "name":"development",
            "organisation_id":10,
            "updated_at":"2020-12-31T23:59:59.999Z"
        }
        """
        
        let data = json.data(using: .utf8)!
        let squad = try JSONDecoder().decode(Squad.self, from: data)
        
        #expect(squad.id == 123)
        #expect(squad.name == "development")
        #expect(squad.organisationId == 10)
        
        let expectedCreatedAt = Squad.dateFormatter.date(from: "2020-01-01T12:00:00.000Z")!
        let expectedUpdatedAt = Squad.dateFormatter.date(from: "2020-12-31T23:59:59.999Z")!
        
        #expect(squad.createdAt == expectedCreatedAt)
        #expect(squad.updatedAt == expectedUpdatedAt)
    }
    
    @Test("Squad decoding fails with missing fields")
    func squadDecodingFailsWithMissingFields() {
        let json = """
        {
            "id":78,
            "name":"staff"
        }
        """
        
        let data = json.data(using: .utf8)!
        
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Squad.self, from: data)
        }
    }
    
    @Test("Squad decoding fails with invalid date format (created_at")
    func squadDecodingFailsWithInvalidCreatedAtDateFormat() {
        let json = """
        {
            "created_at":"invalid-date",
            "id":78,
            "name":"staff",
            "organisation_id":6,
            "updated_at":"2015-09-14T18:26:11.000Z"
        }
        """
        
        let data = json.data(using: .utf8)!
        
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Squad.self, from: data)
        }
    }
    
    @Test("Squad decoding fails with invalid date format (updated_at")
    func squadDecodingFailsWithInvalidUpdatedAtDateFormat() {
        let json = """
        {
            "created_at":"2015-09-14T18:26:11.000Z",
            "id":78,
            "name":"staff",
            "organisation_id":6,
            "updated_at":"invalid-date"
        }
        """
        
        let data = json.data(using: .utf8)!
        
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Squad.self, from: data)
        }
    }
    
    @Test("Squad decoding fails with invalid id")
    func squadDecodingFailsWithInvalidId() {
        let json = """
        {
            "created_at":"2015-09-14T18:26:11.000Z",
            "id":"invalid",
            "name":"staff",
            "organisation_id":6,
            "updated_at":"2015-09-14T18:26:11.000Z"
        }
        """
        
        let data = json.data(using: .utf8)!
        
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Squad.self, from: data)
        }
    }
}
