import SwiftUI

// 主题设置视图
public struct ProfileThemeSettingsView: View {
    public init() {}  // 添加公共初始化器
    
    public var body: some View {
        Text("主题设置")
            .navigationTitle("主题设置")
    }
}

// 通知设置视图
public struct ProfileNotificationSettingsView: View {
    public init() {}
    
    public var body: some View {
        Text("通知设置")
            .navigationTitle("通知设置")
    }
}

// 隐私设置视图
public struct ProfilePrivacySettingsView: View {
    public init() {}
    
    public var body: some View {
        Text("隐私设置")
            .navigationTitle("隐私设置")
    }
}

// 关于我们视图
public struct ProfileAboutView: View {
    public init() {}
    
    public var body: some View {
        Text("关于我们")
            .navigationTitle("关于我们")
    }
}

// 使用帮助视图
public struct ProfileHelpView: View {
    public init() {}
    
    public var body: some View {
        Text("使用帮助")
            .navigationTitle("使用帮助")
    }
} 