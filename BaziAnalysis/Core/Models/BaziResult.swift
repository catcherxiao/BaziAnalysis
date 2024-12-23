import Foundation

public struct BaziResult {
    public let yearStem: String
    public let yearBranch: String
    public let monthStem: String
    public let monthBranch: String
    public let dayStem: String
    public let dayBranch: String
    public let hourStem: String
    public let hourBranch: String
    
    public var yearPillar: String { yearStem + yearBranch }
    public var monthPillar: String { monthStem + monthBranch }
    public var dayPillar: String { dayStem + dayBranch }
    public var hourPillar: String { hourStem + hourBranch }
    
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