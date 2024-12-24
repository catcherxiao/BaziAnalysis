import SwiftUI
import Charts
#if os(iOS)
import UIKit
#else
import AppKit
#endif

struct AnalysisResultView: View {
    let result: AnalysisResult
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 八字展示卡片
                baziCard
                
                // 五行分析卡片
                fiveElementsCard
                
                // 命理解读卡片
                interpretationCard
            }
            .padding()
            .background(AppTheme.cardBackground)
        }
        .background(AppTheme.gradient)
    }
    
    // 统一的卡片标题样式
    private func cardTitle(_ text: String) -> some View {
        Text(text)
            .font(.system(.headline, design: .serif))
            .foregroundColor(AppTheme.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // 统一的卡片子标题样式
    private func cardSubtitle(_ text: String) -> some View {
        Text(text)
            .font(.system(.subheadline, design: .serif))
            .foregroundColor(AppTheme.secondaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var baziCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            cardTitle("您的八字")
            
            HStack(spacing: 15) {
                ForEach(0..<4) { index in
                    let pillar = result.bazi.getPillarContent(index)
                    VStack(spacing: 8) {
                        Text(result.bazi.getPillarTitle(index))
                            .font(.system(.callout, design: .serif))
                            .foregroundColor(AppTheme.secondaryText)
                            .padding(.top, 2)
                        
                        VStack(spacing: 12) {
                            Text(pillar.stem)
                                .font(.system(.body, design: .serif))
                            Text(pillar.branch)
                                .font(.system(.body, design: .serif))
                        }
                        .foregroundColor(AppTheme.primaryText)
                        .padding(.bottom, 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .moduleCard(color: AppTheme.ModuleColors.bazi.opacity(0.1))
    }
    
    private var fiveElementsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            cardTitle("五行分析")
                .padding(.bottom, 12)
            
            VStack(spacing: 12) {
                // 天干五行
                VStack(alignment: .leading, spacing: 2) {
                    cardSubtitle("天干五行")
                        .padding(.bottom, 2)
                    
                    HStack {
                        ForEach(result.bazi.stemElements, id: \.self) { stem in
                            Text(convertStemToElement(stem))
                                .font(.system(.body, design: .serif))
                                .foregroundColor(AppTheme.primaryText)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                }
                
                // 地支五行
                VStack(alignment: .leading, spacing: 2) {
                    cardSubtitle("地支五行")
                        .padding(.bottom, 2)
                    
                    HStack {
                        ForEach(result.bazi.branchElements, id: \.self) { branch in
                            Text(convertBranchToElement(branch))
                                .font(.system(.body, design: .serif))
                                .foregroundColor(AppTheme.primaryText)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .moduleCard(color: AppTheme.ModuleColors.fiveElements.opacity(0.1))
    }
    
    // 添加天干五行转换方法
    private func convertStemToElement(_ stem: String) -> String {
        switch stem {
        case "甲", "乙": return "木"
        case "丙", "丁": return "火"
        case "戊", "己": return "土"
        case "庚", "辛": return "金"
        case "壬", "癸": return "水"
        default: return stem
        }
    }
    
    // 添加地支五行转换方法
    private func convertBranchToElement(_ branch: String) -> String {
        switch branch {
        case "寅", "卯": return "木"
        case "巳", "午": return "火"
        case "辰", "戌", "丑", "未": return "土"
        case "申", "酉": return "金"
        case "子", "亥": return "水"
        default: return branch
        }
    }
    
    // 命理解读卡片
    private var interpretationCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("命理解读")
                .font(.headline)
                .foregroundColor(AppTheme.primaryText)
            
            VStack(alignment: .leading, spacing: 16) {
                // 主要特征
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("主要特征")
                    }
                    .font(.subheadline)
                    .foregroundColor(AppTheme.secondaryText)
                    
                    Text(result.mainPattern)
                        .font(.body)
                        .foregroundColor(AppTheme.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // 五行分析
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        Text("五行分析")
                    }
                    .font(.subheadline)
                    .foregroundColor(AppTheme.secondaryText)
                    
                    Text(result.elementAnalysis)
                        .font(.body)
                        .foregroundColor(AppTheme.primaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.vertical, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .moduleCard(color: AppTheme.ModuleColors.destiny.opacity(0.1))
    }
}

struct ProgressBar: View {
    let value: Double
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: 0)
                Rectangle()
                    .fill(AppTheme.gradient)
                    .frame(height: geometry.size.height * CGFloat(value / 100))
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(3)
    }
} 
