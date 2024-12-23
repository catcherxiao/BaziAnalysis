import Foundation
import SwiftUI

public class BirthViewModel: ObservableObject {
    @Published public var birthDate = Date()
    @Published public var selectedTimeSlot = 6  // 默认午时
    @Published public var analysisResult: AnalysisResult?
    @Published public var showingResult = false
    @Published public var isAnalyzing = false
    
    private let baziService = BaziService.shared
    private let fiveElementsService = FiveElementsService.shared
    
    // 时辰对应的小时起始时间
    private let timeSlotHours = [23, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21]
    
    public init() {
        // 设置默认时间为今天中午12点
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 12
        components.minute = 0
        if let defaultTime = Calendar.current.date(from: components) {
            birthDate = defaultTime
        }
    }
    
    public func analyze() {
        isAnalyzing = true
        
        // 合并日期和时辰
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: birthDate)
        dateComponents.hour = timeSlotHours[selectedTimeSlot]
        dateComponents.minute = 0  // 使用每个时辰的起始时间
        
        guard let date = calendar.date(from: dateComponents) else {
            isAnalyzing = false
            return
        }
        
        // 模拟网络延迟
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // 计算八字
            let bazi = self.baziService.calculateBazi(date: date)
            
            // 分析五行
            let elementAnalysis = self.fiveElementsService.analyzeFiveElements(bazi: bazi)
            
            // 获取命格分析
            let mainPattern = self.fiveElementsService.analyzeMainPattern(bazi: bazi)
            
            // 生成分析结果
            self.analysisResult = AnalysisResult(
                bazi: bazi,
                elementAnalysis: elementAnalysis,
                mainPattern: mainPattern
            )
            
            self.isAnalyzing = false
            self.showingResult = true
        }
    }
} 