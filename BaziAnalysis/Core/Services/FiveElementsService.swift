import Foundation

class FiveElementsService {
    static let shared = FiveElementsService()
    
    private init() {}
    
    func analyzeFiveElements(bazi: BaziResult) -> String {
        let analysis = analyzeElements(bazi)
        return formatAnalysis(analysis)
    }
    
    private func analyzeElements(_ bazi: BaziResult) -> [ElementAnalysis] {
        var elements: [ElementAnalysis] = []
        
        // 分析天干五行
        let stemElements = bazi.stemElements
        for stem in stemElements {
            if let element = BaziService.shared.stemElements[stem] {
                let isStrong = checkElementStrength(element, in: bazi)
                let description = getElementDescription(element, isStrong: isStrong)
                elements.append(ElementAnalysis(element: element, isStrong: isStrong, description: description))
            }
        }
        
        return elements
    }
    
    private func checkElementStrength(_ element: FiveElement, in bazi: BaziResult) -> Bool {
        // 简化版的五行强弱判断
        let stemCount = bazi.stemElements.filter { BaziService.shared.stemElements[$0] == element }.count
        let branchCount = bazi.branchElements.filter { BaziService.shared.branchElements[$0] == element }.count
        
        return (stemCount + branchCount) >= 2
    }
    
    private func getElementDescription(_ element: FiveElement, isStrong: Bool) -> String {
        switch element {
        case .wood:
            return isStrong ? "木气旺盛，利于生发，创业有利" : "木气偏弱，需要培养，宜稳健发展"
        case .fire:
            return isStrong ? "火气旺盛，表现活跃，人缘良好" : "火气偏弱，内向谨慎，需多社交"
        case .earth:
            return isStrong ? "土气旺盛，稳重踏实，利于积累" : "土气偏弱，基础不稳，需要沉淀"
        case .metal:
            return isStrong ? "金气旺盛，果断坚毅，决策有力" : "金气偏弱，意志不坚，需要磨练"
        case .water:
            return isStrong ? "水气旺盛，智慧充沛，思维活跃" : "水气偏弱，智慧不足，需要学习"
        }
    }
    
    private func formatAnalysis(_ analysis: [ElementAnalysis]) -> String {
        var description = ""
        
        for element in analysis {
            description += "【\(element.element.rawValue)】"
            description += element.isStrong ? "偏强" : "偏弱"
            description += "，"
            description += element.description
            description += "\n"
        }
        
        return description.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func analyzeMainPattern(bazi: BaziResult) -> String {
        // 简化版的命格分析
        if let dayElement = BaziService.shared.stemElements[bazi.dayStem] {
            switch dayElement {
            case .wood:
                return "木命：性格坚韧，重情重义，富有理想。适合从事创新、教育、环保等行业。"
            case .fire:
                return "火命：性格开朗，热情活泼，充满活力。适合从事销售、表演、餐饮等行业。"
            case .earth:
                return "土命：性格稳重，踏实可靠，重视责任。适合从事管理、房地产、农业等行业。"
            case .metal:
                return "金命：性格刚毅，意志坚定，重视原则。适合从事金融、法律、军警等行业。"
            case .water:
                return "水命：性格灵活，思维敏捷，适应力强。适合从事科技、艺术、传媒等行业。"
            }
        }
        return "暂无分析结果"
    }
} 