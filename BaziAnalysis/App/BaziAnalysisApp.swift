import SwiftUI

@main
struct BaziAnalysisApp: App {
    // 创建全局状态管理器
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(appState.colorScheme)
        }
    }
}

// 全局状态管理
class AppState: ObservableObject {
    @Published var colorScheme: ColorScheme? = nil
    @Published var lastAnalysis: AnalysisResult?
    @Published var analysisHistory: [AnalysisResult] = []
    
    // 主题切换
    func toggleTheme() {
        colorScheme = colorScheme == .dark ? .light : .dark
    }
    
    // 保存分析结果
    func saveAnalysis(_ result: AnalysisResult) {
        lastAnalysis = result
        analysisHistory.append(result)
    }
}