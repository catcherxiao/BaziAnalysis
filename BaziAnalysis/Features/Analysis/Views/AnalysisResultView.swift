import SwiftUI
import Charts
#if os(iOS)
import UIKit
#else
import AppKit
#endif

struct AnalysisResultView: View {
    let result: AnalysisResult
    @Environment(\.dismiss) private var dismiss
    @State private var showContent = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                baziCard
                    .padding(.horizontal)
                    .transition(.moveAndFade())
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                
                patternCard
                    .padding(.horizontal)
                    .transition(.moveAndFade())
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                
                elementAnalysisCard
                    .padding(.horizontal)
                    .transition(.moveAndFade())
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                
                adviceCard
                    .padding(.horizontal)
                    .transition(.moveAndFade())
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                
                Spacer().frame(height: 30)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                showContent = true
            }
        }
    }
    
    private var baziCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("您的八字")
                .font(.headline)
            
            HStack(spacing: 20) {
                pillarView("年柱", stem: result.bazi.yearStem, branch: result.bazi.yearBranch)
                pillarView("月柱", stem: result.bazi.monthStem, branch: result.bazi.monthBranch)
                pillarView("日柱", stem: result.bazi.dayStem, branch: result.bazi.dayBranch)
                pillarView("时柱", stem: result.bazi.hourStem, branch: result.bazi.hourBranch)
            }
        }
        .modifier(cardStyle)
    }
    
    private var patternCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("命格分析")
                .font(.headline)
            
            Text(result.mainPattern)
                .font(.body)
                .lineSpacing(6)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .modifier(cardStyle)
    }
    
    private var elementAnalysisCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("五行分析")
                .font(.headline)
            
            Chart {
                ForEach(result.elementAnalysis) { analysis in
                    BarMark(
                        x: .value("Element", analysis.element.rawValue),
                        y: .value("Score", showContent ? analysis.percentage : 0)
                    )
                    .foregroundStyle(chartColors[analysis.element.index])
                }
            }
            .animation(.spring(response: 0.8), value: showContent)
            .frame(height: 200)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(result.elementAnalysis) { analysis in
                    Text("\(analysis.element.rawValue): \(String(format: "%.1f%%", analysis.percentage))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .modifier(cardStyle)
    }
    
    private var adviceCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("命理建议")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12) {
                adviceSection(title: "性格特点", content: getPersonalityAdvice())
                adviceSection(title: "事业发展", content: getCareerAdvice())
                adviceSection(title: "健康建议", content: getHealthAdvice())
            }
        }
        .modifier(cardStyle)
    }
    
    private func adviceSection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(content)
                .font(.body)
                .lineSpacing(6)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func pillarView(_ title: String, stem: String, branch: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(stem)
                .font(.title3)
                .foregroundColor(.primary)
            
            Text(branch)
                .font(.title3)
                .foregroundColor(.primary)
        }
    }
    
    private func adviceRow(_ title: String, _ content: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(content)
                .font(.body)
        }
    }
    
    private var cardStyle: CardStyle {
        CardStyle(colorScheme: colorScheme)
    }
    
    private func getPersonalityAdvice() -> String {
        let strongestElement = result.elementAnalysis
            .max(by: { $0.percentage < $1.percentage })?.element
        
        switch strongestElement {
        case .wood:
            return "您性格坚韧，富有理想，适合担任领导角色。"
        case .fire:
            return "您性格开朗活泼，善于社交，富有感染力。"
        case .earth:
            return "您性格稳重踏实，做事可靠，重视责任。"
        case .metal:
            return "您性格刚毅坚定，原则性强，追求完美。"
        case .water:
            return "您思维灵活，适应力强，善于创新。"
        case .none:
            return "暂无性格分析"
        }
    }
    
    private func getCareerAdvice() -> String {
        return "根据您的八字特点，建议从事..."
    }
    
    private func getHealthAdvice() -> String {
        return "建议您在保健养生方面注意..."
    }
}

extension AnyTransition {
    static func moveAndFade() -> AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

extension AnalysisResultView {
    private var chartColors: [Color] {
        colorScheme == .dark ? [
            .green.opacity(0.8),    // 木
            .red.opacity(0.8),      // 火
            .yellow.opacity(0.8),   // 土
            .gray.opacity(0.8),     // 金
            .blue.opacity(0.8)      // 水
        ] : [
            .green,    // 木
            .red,      // 火
            .yellow,   // 土
            .gray,     // 金
            .blue      // 水
        ]
    }
}

extension FiveElement {
    var index: Int {
        switch self {
        case .wood: return 0
        case .fire: return 1
        case .earth: return 2
        case .metal: return 3
        case .water: return 4
        }
    }
}

private struct CardStyle: ViewModifier {
    let colorScheme: ColorScheme
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
            .cornerRadius(12)
            .shadow(
                color: colorScheme == .dark ? .black.opacity(0.3) : .gray.opacity(0.2),
                radius: 8,
                x: 0,
                y: 2
            )
    }
} 