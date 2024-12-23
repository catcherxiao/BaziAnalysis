import Foundation

struct DateFormatters {
    static let shared = DateFormatters()
    
    private let chineseWeekdays = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    private let chineseMonths = ["一月", "二月", "三月", "四月", "五月", "六月", 
                                "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    private init() {}
    
    func chineseWeekdaySymbols() -> [String] {
        return chineseWeekdays
    }
    
    func chineseMonthSymbols() -> [String] {
        return chineseMonths
    }
    
    func configureDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.weekdaySymbols = chineseWeekdays
        formatter.shortWeekdaySymbols = chineseWeekdays
        formatter.veryShortWeekdaySymbols = chineseWeekdays
        formatter.monthSymbols = chineseMonths
        formatter.shortMonthSymbols = chineseMonths
        formatter.veryShortMonthSymbols = chineseMonths
        return formatter
    }
} 