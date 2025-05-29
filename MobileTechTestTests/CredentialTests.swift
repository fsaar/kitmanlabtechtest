import Testing
import Foundation
@testable import MobileTechTest

@Suite("CredentialTests")
struct CredentialTests {
    
    @Test("Credential initialization")
    func credentialInitialization() {
        let credential = Credential(username: "testuser", password: "testpass")
        
        #expect(credential.username == "testuser")
        #expect(credential.password == "testpass")
    }
    
    @Test("Credential encoding to JSON")
    func credentialEncodingToJSON() throws {
        let credential = Credential(username: "john_doe", password: "secret123")
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(credential)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        #expect(json["username"] as? String == "john_doe")
        #expect(json["password"] as? String == "secret123")
    }
    
    @Test("Credential decoding from JSON")
    func credentialDecodingFromJSON() throws {
        let json = """
        {
            "username": "alice",
            "password": "mypassword"
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let credential = try decoder.decode(Credential.self, from: data)
        
        #expect(credential.username == "alice")
        #expect(credential.password == "mypassword")
    }
    
    @Test("Credential decoding fails with missing fields")
    func credentialDecodingFailsWithMissingFields() {
        let json = """
        {
            "username": "alice"
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        #expect(throws: DecodingError.self) {
            try decoder.decode(Credential.self, from: data)
        }
    }
    
    @Test("Credential hashable conformance")
    func credentialHashableConformance() {
        let credential1 = Credential(username: "user1", password: "pass1")
        let credential2 = Credential(username: "user1", password: "pass1")
        let credential3 = Credential(username: "user2", password: "pass1")
        
        #expect(credential1 == credential2)
        #expect(credential1 != credential3)
        #expect(credential1.hashValue == credential2.hashValue)
    }
    
    @Test("Credential can be used in Set")
    func credentialCanBeUsedInSet() {
        let credential1 = Credential(username: "user1", password: "pass1")
        let credential2 = Credential(username: "user1", password: "pass1")
        let credential3 = Credential(username: "user2", password: "pass2")
        
        let credentialSet: Set<Credential> = [credential1, credential2, credential3]
        
        #expect(credentialSet.count == 2)
        #expect(credentialSet.contains(credential1))
        #expect(credentialSet.contains(credential3))
    }
    
    @Test("Credential with empty values")
    func credentialWithEmptyValues() {
        let credential = Credential(username: "", password: "")
        
        #expect(credential.username == "")
        #expect(credential.password == "")
    }
    
    @Test("Credential with special characters")
    func credentialWithSpecialCharacters() throws {
        let credential = Credential(username: "user@domain.com", password: "p@ssw0rd!")
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(credential)
        let decoder = JSONDecoder()
        let decodedCredential = try decoder.decode(Credential.self, from: data)
        
        #expect(decodedCredential.username == "user@domain.com")
        #expect(decodedCredential.password == "p@ssw0rd!")
    }
}