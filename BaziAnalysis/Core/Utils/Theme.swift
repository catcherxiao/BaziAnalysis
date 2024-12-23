import SwiftUI

struct AppTheme {
    // 主题渐变色 - 柔和的紫色渐变
    static let gradient = LinearGradient(
        colors: [
            Color(hex: "E9E3FF"),  // 浅紫色
            Color(hex: "F5F2FF")   // 更浅的紫色
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // 卡片背景色
    static let cardBackground = Color.white
    
    // 文字颜色
    static let primaryText = Color(hex: "333333")
    static let secondaryText = Color(hex: "666666")
    
    // 强调色
    static let accent = Color(hex: "8B7EFF")  // 中等紫色
    
    // 模块颜色
    struct ModuleColors {
        // 八字模块 - 柔和的蓝紫色
        static let bazi = Color(hex: "8B9FFF")
        
        // 五行模块 - 柔和的粉紫色
        static let fiveElements = Color(hex: "B88BFF")
        
        // 命理模块 - 柔和的青紫色
        static let destiny = Color(hex: "8BCAFF")
        
        // 历史记录模块 - 柔和的绿色
        static let history = Color(hex: "8BFFB9")
        
        // 个人中心模块 - 柔和的橙色
        static let profile = Color(hex: "FFB88B")
    }
    
    // 分析结果的颜色
    static let analysisColors = [
        Color(hex: "FF9ECD"),  // 柔和的粉色
        Color(hex: "94B3FD"),  // 柔和的蓝色
        Color(hex: "94DAFD"),  // 柔和的青色
        Color(hex: "99FDD7"),  // 柔和的绿色
        Color(hex: "FDBD94")   // 柔和的橙色
    ]
    
    // 状态颜色
    static let success = Color(hex: "86EFAC")  // 柔和的绿色
    static let warning = Color(hex: "FFD699")  // 柔和的黄色
    static let error = Color(hex: "FFB4B4")    // 柔和的红色
    
    // 卡片阴影
    static let shadowColor = Color.black.opacity(0.05)
    static let shadowRadius: CGFloat = 8
    static let shadowX: CGFloat = 0
    static let shadowY: CGFloat = 2
    
    // 圆角
    static let cornerRadius: CGFloat = 12
    static let smallCornerRadius: CGFloat = 8
}

// 扩展 View 以方便应用主题样式
extension View {
    func moduleCard(color: Color = AppTheme.cardBackground) -> some View {
        self.padding()
            .background(color)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(
                color: AppTheme.shadowColor,
                radius: AppTheme.shadowRadius,
                x: AppTheme.shadowX,
                y: AppTheme.shadowY
            )
    }
    
    func accentButton() -> some View {
        self.padding()
            .background(AppTheme.accent)
            .foregroundColor(.white)
            .cornerRadius(AppTheme.cornerRadius)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
} 