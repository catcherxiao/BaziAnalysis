import Foundation

class BaziService {
    static let shared = BaziService()
    
    private let stems = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    private let branches = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
    
    // 修改为 internal 访问级别
    let stemElements: [String: FiveElement] = [
        "甲": .wood, "乙": .wood,
        "丙": .fire, "丁": .fire,
        "戊": .earth, "己": .earth,
        "庚": .metal, "辛": .metal,
        "壬": .water, "癸": .water
    ]
    
    let branchElements: [String: FiveElement] = [
        "子": .water, "丑": .earth, "寅": .wood,
        "卯": .wood, "辰": .earth, "巳": .fire,
        "午": .fire, "未": .earth, "申": .metal,
        "酉": .metal, "戌": .earth, "亥": .water
    ]
    
    private init() {}
    
    func calculateBazi(date: Date) -> BaziResult {
        // 获取年、月、日、时的干支
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        
        let yearGanzhi = calculateYearPillar(year: year)
        let monthGanzhi = calculateMonthPillar(year: year, month: month)
        let dayGanzhi = calculateDayPillar(date: date)
        let hourGanzhi = calculateHourPillar(hour: hour, dayStem: dayGanzhi.stem)
        
        return BaziResult(
            yearStem: yearGanzhi.stem,
            yearBranch: yearGanzhi.branch,
            monthStem: monthGanzhi.stem,
            monthBranch: monthGanzhi.branch,
            dayStem: dayGanzhi.stem,
            dayBranch: dayGanzhi.branch,
            hourStem: hourGanzhi.stem,
            hourBranch: hourGanzhi.branch
        )
    }
    
    private func calculateYearPillar(year: Int) -> (stem: String, branch: String) {
        // 以1984年甲子年为基准
        let baseYear = 1984
        let stemIndex = (year - baseYear) % 10
        let branchIndex = (year - baseYear) % 12
        
        let stem = stems[(stemIndex + 10) % 10]
        let branch = branches[(branchIndex + 12) % 12]
        
        return (stem, branch)
    }
    
    private func calculateMonthPillar(year: Int, month: Int) -> (stem: String, branch: String) {
        // 月干 = （年干 × 2 + 月数）% 10
        let yearStem = calculateYearPillar(year: year).stem
        let yearStemIndex = stems.firstIndex(of: yearStem)!
        let monthStemIndex = ((yearStemIndex * 2 + month) % 10 + 10) % 10
        
        // 月支直接对应
        let monthBranchIndex = ((month + 2) % 12 + 12) % 12
        
        return (stems[monthStemIndex], branches[monthBranchIndex])
    }
    
    private func calculateDayPillar(date: Date) -> (stem: String, branch: String) {
        // 以1900年1月31日甲子日为基准
        let baseDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 31))!
        let days = Calendar.current.dateComponents([.day], from: baseDate, to: date).day!
        
        let stemIndex = (days % 10 + 10) % 10
        let branchIndex = (days % 12 + 12) % 12
        
        return (stems[stemIndex], branches[branchIndex])
    }
    
    private func calculateHourPillar(hour: Int, dayStem: String) -> (stem: String, branch: String) {
        // 将小时转换为时辰
        let timeIndex = (hour + 1) / 2 % 12
        
        // 根据日干推算时干
        let dayStemIndex = stems.firstIndex(of: dayStem)!
        let hourStemIndex = ((dayStemIndex * 2 + timeIndex) % 10 + 10) % 10
        
        return (stems[hourStemIndex], branches[timeIndex])
    }
    
    // 添加节气判断方法
    private func getSolarTerm(date: Date) -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        // 简化的节气判断，实际项目中应该使用更精确的计算方法
        let solarTerms = [
            (2, 4), (2, 19),   // 立春、雨水
            (3, 6), (3, 21),   // 惊蛰、春分
            (4, 5), (4, 20),   // 清明、谷雨
            (5, 6), (5, 21),   // 立夏、小满
            (6, 6), (6, 21),   // 芒种、夏至
            (7, 7), (7, 23),   // 小暑、大暑
            (8, 8), (8, 23),   // 立秋、���暑
            (9, 8), (9, 23),   // 白露、秋分
            (10, 8), (10, 24), // 寒露、霜降
            (11, 8), (11, 22), // 立冬、小雪
            (12, 7), (12, 22), // 大雪、冬至
            (1, 6), (1, 20)    // 小寒、大寒
        ]
        
        for (index, term) in solarTerms.enumerated() {
            if month == term.0 && day < term.1 {
                return index
            }
        }
        
        return 0
    }
    
    // 其他计算方法...
} 