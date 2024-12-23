import Foundation

public struct AnalysisResult: Identifiable {
    public let id = UUID()
    public let date: Date
    public let bazi: BaziResult
    public let elementAnalysis: [ElementAnalysis]
    public let mainPattern: String
    
    public init(bazi: BaziResult, elementAnalysis: [ElementAnalysis], mainPattern: String) {
        self.date = Date()
        self.bazi = bazi
        self.elementAnalysis = elementAnalysis
        self.mainPattern = mainPattern
    }
} 