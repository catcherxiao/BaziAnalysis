import Foundation

class FiveElementsService {
    static let shared = FiveElementsService()
    
    private init() {}
    
    func analyzeFiveElements(bazi: BaziResult) -> [ElementAnalysis] {
        var scores: [FiveElement: Double] = [:]
        
        // 初始化分数
        FiveElement.allCases.forEach { scores[$0] = 0 }
        
        // 计算天干五行得分
        calculateStemScores(bazi, scores: &scores)
        
        // 计算地支五行得分
        calculateBranchScores(bazi, scores: &scores)
        
        // 计算总分
        let total = scores.values.reduce(0, +)
        
        // 生成分析结果
        return scores.map { element, score in
            let percentage = score / total * 100
            let level = calculateLevel(percentage)
            return ElementAnalysis(
                element: element,
                percentage: percentage,
                level: level
            )
        }
    }
    
    private func calculateLevel(_ percentage: Double) -> ElementLevel {
        switch percentage {
        case ..<10: return .veryWeak
        case ..<20: return .weak
        case ..<30: return .balanced
        case ..<40: return .strong
        default: return .veryStrong
        }
    }
    
    private func calculateStemScores(_ bazi: BaziResult, scores: inout [FiveElement: Double]) {
        // 天干权重为1.0
        let weight = 1.0
        
        // 年干
        if let element = BaziService.shared.stemElements[bazi.yearStem] {
            scores[element]? += weight
        }
        
        // 月干
        if let element = BaziService.shared.stemElements[bazi.monthStem] {
            scores[element]? += weight
        }
        
        // 日干（日主）
        if let element = BaziService.shared.stemElements[bazi.dayStem] {
            scores[element]? += weight * 2 // 日主权重加倍
        }
        
        // 时干
        if let element = BaziService.shared.stemElements[bazi.hourStem] {
            scores[element]? += weight
        }
    }
    
    private func calculateBranchScores(_ bazi: BaziResult, scores: inout [FiveElement: Double]) {
        // 地支权重为0.5
        let weight = 0.5
        
        // 年支
        if let element = BaziService.shared.branchElements[bazi.yearBranch] {
            scores[element]? += weight
        }
        
        // 月支
        if let element = BaziService.shared.branchElements[bazi.monthBranch] {
            scores[element]? += weight
        }
        
        // 日支
        if let element = BaziService.shared.branchElements[bazi.dayBranch] {
            scores[element]? += weight
        }
        
        // 时支
        if let element = BaziService.shared.branchElements[bazi.hourBranch] {
            scores[element]? += weight
        }
    }
    
    // 添加命格分析方法
    func analyzeMainPattern(bazi: BaziResult) -> String {
        // 以日干为主
        let dayStem = bazi.dayStem
        let dayBranch = bazi.dayBranch
        
        // 简化版命格判断
        if let element = BaziService.shared.stemElements[dayStem] {
            switch element {
            case .wood:
                return "木命：性格坚韧，重情重义，富有理想"
            case .fire:
                return "火命：性格开朗，热情活泼，充满活力"
            case .earth:
                return "土命：性格稳重，踏实可靠，重视责任"
            case .metal:
                return "金命：性格刚毅，意志坚定，重视原则"
            case .water:
                return "水命：性格灵活，思维敏捷，适应力强"
            }
        }
        
        return "未知命格"
    }
    
    // 其他分析方法...
} 