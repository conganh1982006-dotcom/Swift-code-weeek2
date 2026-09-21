import SwiftUI

// Represents one computer in the lab
struct PC: Identifiable {
    var id: UUID = UUID()
    var name: String
    var location: String
    var isAvailable: Bool
}
