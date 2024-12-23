import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var birthViewModel: BirthViewModel
    
    var body: some View {
        List {
            if let results = birthViewModel.analysisHistory {
                ForEach(results) { result in
                    HistoryItemView(result: result)
                }
            }
        }
        .listStyle(.insetGrouped)
        .background(AppTheme.gradient)
        .overlay {
            if birthViewModel.analysisHistory?.isEmpty ?? true {
                ContentUnavailableView(
                    "暂无历史记录",
                    systemImage: "clock",
                    description: Text("进行分析后的结果会显示在这里")
                )
            }
        }
    }
}

struct HistoryItemView: View {
    let result: AnalysisResult
    
    var body: some View {
        NavigationLink {
            AnalysisResultView(result: result)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                // 日期
                Text(result.date.formatted(date: .long, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // 八字
                HStack {
                    ForEach(0..<4) { index in
                        let pillar = result.bazi.getPillarContent(index)
                        VStack {
                            Text(pillar.stem)
                            Text(pillar.branch)
                        }
                        .font(.system(.body, design: .serif))
                    }
                }
                
                // 主要特征
                Text(result.mainPattern)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    NavigationStack {
        HistoryView()
            .environmentObject(BirthViewModel())
    }
} 