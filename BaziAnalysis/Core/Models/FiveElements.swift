import Foundation

public enum FiveElement: String, CaseIterable {
    case metal = "金"
    case wood = "木"
    case water = "水"
    case fire = "火"
    case earth = "土"
}

public struct ElementAnalysis {
    public let element: FiveElement
    public let percentage: Double
    public let level: ElementLevel
}

public enum ElementLevel: String {
    case veryWeak = "太弱"
    case weak = "偏弱"
    case balanced = "适中"
    case strong = "偏旺"
    case veryStrong = "太旺"
}

extension ElementAnalysis: Identifiable {
    public var id: String { element.rawValue }
} 