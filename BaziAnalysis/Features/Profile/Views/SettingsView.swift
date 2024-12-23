import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("autoSave") private var autoSave = true
    
    var body: some View {
        List {
            Section {
                Toggle("推送通知", isOn: $notificationsEnabled)
                Toggle("自动保存", isOn: $autoSave)
            }
            
            Section {
                NavigationLink("清除缓存") {
                    // TODO: 清除缓存功能
                }
                
                NavigationLink("隐私政策") {
                    // TODO: 隐私政策页面
                }
            }
        }
        .navigationTitle("设置")
    }
} 