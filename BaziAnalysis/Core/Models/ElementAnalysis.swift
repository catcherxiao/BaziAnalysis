import Foundation

public struct ElementAnalysis: Identifiable {
    public let element: FiveElement
    public let isStrong: Bool
    public let description: String
    public let level: ElementLevel
    
    public var id: String { element.rawValue }
    
    public init(element: FiveElement, isStrong: Bool, description: String = "", level: ElementLevel = .balanced) {
        self.element = element
        self.isStrong = isStrong
        self.description = description
        self.level = level
    }
} 