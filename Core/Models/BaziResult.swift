import Foundation

public struct BaziResult {
    // 八字基本信息
    public let yearStem: String
    public let yearBranch: String
    public let monthStem: String
    public let monthBranch: String
    public let dayStem: String
    public let dayBranch: String
    public let hourStem: String
    public let hourBranch: String
    
    // 四柱
    public var yearPillar: String { yearStem + yearBranch }
    public var monthPillar: String { monthStem + monthBranch }
    public var dayPillar: String { dayStem + dayBranch }
    public var hourPillar: String { hourStem + hourBranch }
    
    // 五行属性
    public var stemElements: [String] {
        [yearStem, monthStem, dayStem, hourStem]
    }
    
    public var branchElements: [String] {
        [yearBranch, monthBranch, dayBranch, hourBranch]
    }
    
    public init(yearStem: String, yearBranch: String,
               monthStem: String, monthBranch: String,
               dayStem: String, dayBranch: String,
               hourStem: String, hourBranch: String) {
        self.yearStem = yearStem
        self.yearBranch = yearBranch
        self.monthStem = monthStem
        self.monthBranch = monthBranch
        self.dayStem = dayStem
        self.dayBranch = dayBranch
        self.hourStem = hourStem
        self.hourBranch = hourBranch
    }
}

// 扩展用于显示的辅助方法
extension BaziResult {
    // 获取柱子的标题
    public func getPillarTitle(_ index: Int) -> String {
        switch index {
        case 0: return "年柱"
        case 1: return "月柱"
        case 2: return "日柱"
        case 3: return "时柱"
        default: return ""
        }
    }
    
    // 获取柱子的内容
    public func getPillarContent(_ index: Int) -> (stem: String, branch: String) {
        switch index {
        case 0: return (yearStem, yearBranch)
        case 1: return (monthStem, monthBranch)
        case 2: return (dayStem, dayBranch)
        case 3: return (hourStem, hourBranch)
        default: return ("", "")
        }
    }
} 