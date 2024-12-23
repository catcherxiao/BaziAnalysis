import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        List {
            ForEach(appState.analysisHistory) { result in
                HistoryItemView(result: result)
            }
        }
        .listStyle(.insetGrouped)
        .overlay {
            if appState.analysisHistory.isEmpty {
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
                    .font(.headline)
                
                // 八字
                HStack(spacing: 12) {
                    Text(result.bazi.yearPillar)
                    Text(result.bazi.monthPillar)
                    Text(result.bazi.dayPillar)
                    Text(result.bazi.hourPillar)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    NavigationStack {
        HistoryView()
            .environmentObject(AppState())
    }
} 