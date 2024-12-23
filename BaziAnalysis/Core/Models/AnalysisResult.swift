import Foundation

public struct AnalysisResult: Identifiable, Hashable {
    public let id = UUID()
    public let date = Date()
    public let bazi: BaziResult
    public let elementAnalysis: String
    public let mainPattern: String
    
    public init(bazi: BaziResult, elementAnalysis: String, mainPattern: String) {
        self.bazi = bazi
        self.elementAnalysis = elementAnalysis
        self.mainPattern = mainPattern
    }
    
    // 实现 Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: AnalysisResult, rhs: AnalysisResult) -> Bool {
        lhs.id == rhs.id
    }
} 