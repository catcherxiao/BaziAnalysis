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
    
    private var baziCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("您的八字")
                .font(.headline)
                .foregroundColor(AppTheme.primaryText)
            
            HStack(spacing: 15) {
                ForEach(0..<4) { index in
                    let pillar = result.bazi.getPillarContent(index)
                    VStack(spacing: 8) {
                        Text(result.bazi.getPillarTitle(index))
                            .font(.caption)
                            .foregroundColor(AppTheme.secondaryText)
                        
                        VStack(spacing: 4) {
                            Text(pillar.stem)
                                .font(.system(.body, design: .serif))
                            Text(pillar.branch)
                                .font(.system(.body, design: .serif))
                        }
                        .foregroundColor(AppTheme.primaryText)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .moduleCard(color: AppTheme.ModuleColors.bazi.opacity(0.1))
    }
    
    // 五行分析卡片
    private var fiveElementsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("五行分析")
                .font(.headline)
                .foregroundColor(AppTheme.primaryText)
            
            VStack(spacing: 15) {
                // 天干五行
                VStack(alignment: .leading, spacing: 8) {
                    Text("天干五行")
                        .font(.subheadline)
                        .foregroundColor(AppTheme.secondaryText)
                    
                    HStack {
                        ForEach(result.bazi.stemElements, id: \.self) { element in
                            Text(element)
                                .font(.system(.body, design: .serif))
                                .foregroundColor(AppTheme.primaryText)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                }
                
                // 地支五行
                VStack(alignment: .leading, spacing: 8) {
                    Text("地支五行")
                        .font(.subheadline)
                        .foregroundColor(AppTheme.secondaryText)
                    
                    HStack {
                        ForEach(result.bazi.branchElements, id: \.self) { element in
                            Text(element)
                                .font(.system(.body, design: .serif))
                                .foregroundColor(AppTheme.primaryText)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .moduleCard(color: AppTheme.ModuleColors.fiveElements.opacity(0.1))
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