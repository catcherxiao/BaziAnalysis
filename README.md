# 八字命理分析 App

一款基于 SwiftUI 开发的 iOS 八字命理分析应用，提供精准的八字计算和全面的命理分析。

## 功能特点

- 精准的八字计算
  - 支持公历日期输入
  - 自动转换农历日期
  - 精确节气判定
  - 四柱天干地支推算

- 全面的五行分析
  - 八字五行属性计算
  - 五行强弱分析
  - 命格特征判定
  - 个性化命理建议

## 技术架构

### 开发环境
- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+
- SwiftUI

### 项目结构
```
BaziAnalysis/
├── App/
│   └── BaziAnalysisApp.swift        // App入口
├── ContentView.swift                 // 主视图
├── Features/
│   ├── Birth/                       // 出生信息输入模块
│   │   ├── Views/
│   │   │   └── BirthInputView.swift // 出生信息输入视图
│   │   └── ViewModels/
│   │       └── BirthViewModel.swift  // 出生信息处理
│   ├── Analysis/                    // 分析结果模块
│   │   ├── Views/
│   │   │   └── AnalysisResultView.swift // 分析结���展示
│   │   └── ViewModels/
│   │       └── AnalysisViewModel.swift   // 分析结果处理
│   └── Profile/                     // 个人信息模块
│       └── Views/
│           └── ProfileView.swift     // 个人信息页面
└── Core/                            // 核心功能模块
    ├── Models/                      // 数据模型
    │   ├── BaziResult.swift         // 八字结果模型
    │   ├── FiveElements.swift       // 五行模型
    │   └── ElementAnalysis.swift    // 五行分析模型
    └── Services/                    // 服务层
        ├── BaziService.swift        // 八字计算服务
        └── FiveElementsService.swift // 五行分析服务
```

### 页面结构

#### 1. 出生信息输入页面 (BirthInputView)
```
VStack
├── 顶部图标 (calendar.circle.fill)
├── 日期时间选择区域
│   ├── 日期选择器 (DatePicker)
│   └── 时间选择器 (DatePicker)
└── 操作按钮区域
    └── 开始分析/修改时间按钮
```

#### 2. 分析结果页面 (AnalysisResultView)
```
ScrollView
└── VStack(spacing: 20)
    ├── 八字展示卡片 (baziCard)
    │   ├── 标题 (.headline, serif)
    │   └── 四柱展示 (HStack, spacing: 15)
    │       └── ForEach柱子 (VStack, spacing: 8)
    │           ├── 柱名 (.callout, serif)
    │           └── 天干地支 (VStack, spacing: 12)
    │
    ├── 五行分析卡片 (fiveElementsCard)
    │   ├── 标题 (.headline, serif, indent: 1px)
    │   └── 分析内容 (VStack, spacing: 12)
    │       ├── 天干五行
    │       │   ├── 子标题 (.subheadline, indent: 3px)
    │       │   └── 五行展示 (HStack)
    │       └── 地支五行
    │           ├── 子标题 (.subheadline, indent: 3px)
    │           └── 五行展示 (HStack)
    │
    ├── 主命格分析卡片 (interpretationCard)
    │   ├── 标题 (.headline)
    │   └── 内容区域 (VStack, spacing: 20)
    │       ├── 主命格
    │       │   ├── 图标+标题
    │       │   └── 解读文本 (lineSpacing: 8)
    │       ├── 性格特征
    │       │   ├── 图标+标题
    │       │   └── 解读文本 (lineSpacing: 8)
    │       └── 适合行业
    │           ├── 图标+标题
    │           └── 解读文本 (lineSpacing: 8)
    │
    └── 五行解读卡片 (elementInterpretationCard)
        ├── 标题 (.headline)
        └── 内容区域 (VStack, spacing: 20)
            ├── 图标+标题
            └── 分析文本 (lineSpacing: 8)
```

#### 3. 个人信息页面 (ProfileView)
```
List
├── 用户信息区域
│   ├── 头像
│   └── 昵称
├── 设置区域
│   ├── 主题设置
│   ├── 通知设置
│   └── 隐私设置
└── 其他信息
    ├── 关于我们
    ├── 使用帮助
    └── 版本信息
```

## 核心算法实现

### 1. 基础数据源

#### 1.1 天干地支数据
```swift
// 十天干
private let stems = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]

// 十二地支
private let branches = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]

// 天干五行对应关系
private let stemElements: [String: FiveElement] = [
    "甲": .wood, "乙": .wood,    // 木
    "丙": .fire, "丁": .fire,    // 火
    "戊": .earth, "己": .earth,  // 土
    "庚": .metal, "辛": .metal,  // 金
    "壬": .water, "癸": .water   // 水
]

// 地支五行对应关系
private let branchElements: [String: FiveElement] = [
    "子": .water, "丑": .earth,  // 水土
    "寅": .wood, "卯": .wood,    // 木木
    "辰": .earth, "巳": .fire,   // 土火
    "午": .fire, "未": .earth,   // 火土
    "申": .metal, "酉": .metal,  // 金金
    "戌": .earth, "亥": .water   // 土水
]
```

#### 1.2 节气数据
```swift
// 节气表（2000年为基准）
private let solarTerms: [(month: Int, day: Int, name: String)] = [
    (2, 4, "立春"), (2, 19, "雨水"),
    (3, 6, "惊蛰"), (3, 21, "春分"),
    (4, 5, "清明"), (4, 20, "谷雨"),
    (5, 6, "立夏"), (5, 21, "小满"),
    (6, 6, "芒种"), (6, 21, "夏至"),
    (7, 7, "小暑"), (7, 23, "大暑"),
    (8, 8, "立秋"), (8, 23, "处暑"),
    (9, 8, "白露"), (9, 23, "秋分"),
    (10, 8, "寒露"), (10, 24, "霜降"),
    (11, 8, "立冬"), (11, 22, "小雪"),
    (12, 7, "大雪"), (12, 22, "冬至"),
    (1, 6, "小寒"), (1, 20, "大寒")
]
```

### 2. 八字计算详细步骤

#### 2.1 年柱计算
```swift
func calculateYearPillar(year: Int) -> (stem: String, branch: String) {
    // 步骤1: 计算年干索引（以1984年甲子年为基准）
    let baseYear = 1984
    let stemIndex = (year - baseYear) % 10
    let adjustedStemIndex = (stemIndex + 10) % 10
    
    // 步骤2: 计算年支索引
    let branchIndex = (year - baseYear) % 12
    let adjustedBranchIndex = (branchIndex + 12) % 12
    
    // 步骤3: 获取年干年支
    let stem = stems[adjustedStemIndex]
    let branch = branches[adjustedBranchIndex]
    
    return (stem, branch)
}
```

#### 2.2 月柱计算
```swift
func calculateMonthPillar(year: Int, month: Int, day: Int) -> (stem: String, branch: String) {
    // 步骤1: 获取节气
    let solarTerm = getSolarTerm(year: year, month: month, day: day)
    
    // 步骤2: 根据节气调整月份
    let adjustedMonth = getAdjustedMonth(month: month, day: day, solarTerm: solarTerm)
    
    // 步骤3: 计算月干（月干 = 年干 × 2 + 月数）
    let yearStem = calculateYearPillar(year: year).stem
    let yearStemIndex = stems.firstIndex(of: yearStem)!
    let monthStemIndex = ((yearStemIndex * 2 + adjustedMonth) % 10 + 10) % 10
    
    // 步骤4: 计算月支
    let monthBranchIndex = ((adjustedMonth + 2) % 12 + 12) % 12
    
    return (stems[monthStemIndex], branches[monthBranchIndex])
}
```

#### 2.3 日柱计算
```swift
func calculateDayPillar(date: Date) -> (stem: String, branch: String) {
    // 步骤1: 计算与基准日期的天数差（1900年1月31日甲子日）
    let baseDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 31))!
    let days = Calendar.current.dateComponents([.day], from: baseDate, to: date).day!
    
    // 步骤2: 计算日干索引
    let stemIndex = (days % 10 + 10) % 10
    
    // 步骤3: 计算日支索引
    let branchIndex = (days % 12 + 12) % 12
    
    return (stems[stemIndex], branches[branchIndex])
}
```

#### 2.4 时柱计算
```swift
func calculateHourPillar(hour: Int, dayStem: String) -> (stem: String, branch: String) {
    // 步骤1: 将小时转换为时辰（每两小时一个时辰）
    let timeIndex = (hour + 1) / 2 % 12
    
    // 步骤2: 根据日干推算时干
    let dayStemIndex = stems.firstIndex(of: dayStem)!
    let hourStemIndex = ((dayStemIndex * 2 + timeIndex) % 10 + 10) % 10
    
    return (stems[hourStemIndex], branches[timeIndex])
}
```

### 3. 五行分析算法

#### 3.1 五行得分计算
```swift
func calculateElementScores(bazi: BaziResult) -> [FiveElement: Double] {
    var scores: [FiveElement: Double] = [:]
    
    // 步骤1: 初始化五行分数
    FiveElement.allCases.forEach { scores[$0] = 0 }
    
    // 步骤2: 计算天干得分（权重1.0）
    let stems = [bazi.yearStem, bazi.monthStem, bazi.dayStem, bazi.hourStem]
    for stem in stems {
        if let element = stemElements[stem] {
            scores[element]? += 1.0
        }
    }
    
    // 步骤3: 计算地支得分（权重0.5）
    let branches = [bazi.yearBranch, bazi.monthBranch, bazi.dayBranch, bazi.hourBranch]
    for branch in branches {
        if let element = branchElements[branch] {
            scores[element]? += 0.5
        }
    }
    
    // 步骤4: 日主特殊处理（日干权重加倍）
    if let element = stemElements[bazi.dayStem] {
        scores[element]? += 1.0
    }
    
    return scores
}
```

#### 3.2 五行强弱分析
```swift
func analyzeElementStrengths(scores: [FiveElement: Double]) -> [ElementAnalysis] {
    // 步骤1: 计算总分
    let total = scores.values.reduce(0, +)
    
    // 步骤2: 计算各元素百分比和等级
    let analyses = scores.map { element, score in
        let percentage = (score / total) * 100
        let level = calculateLevel(percentage)
        return ElementAnalysis(
            element: element,
            score: score,
            percentage: percentage,
            level: level
        )
    }
    
    return analyses
}

// 强弱等级判定标准
func calculateLevel(_ percentage: Double) -> ElementLevel {
    switch percentage {
    case ..<10: return .veryWeak   // 太弱：低于10%
    case ..<20: return .weak       // 偏弱：10-20%
    case ..<30: return .balanced   // 适中：20-30%
    case ..<40: return .strong     // 偏旺：30-40%
    default: return .veryStrong    // 太旺：40%以上
    }
}
## 界面设计与交互

### 1. 主界面布局
```swift
TabView {
    NavigationStack {
        BirthInputView()           // 八字分析页面
    }
    NavigationStack {
        ProfileView()              // 个人中心页面
    }
}
```

### 2. 出生信息输入页面 (BirthInputView)

#### 2.1 页面结构
```
VStack
├── 顶部图标 (calendar.circle.fill)
├── 日期时间选择区域
│   ├── 日期选择器 (DatePicker)
│   └── 时间选择器 (DatePicker)
└── 操作按钮区域
    └── 开始分析/修改时间按钮
```

#### 2.2 交互状态
```swift
@State private var showDatePicker = true        // 控制日期选择器显示
@Published var isAnalyzing = false              // 分析状态
@Published var showingResult = false            // 结果显示状态
```

#### 2.3 交互流程
1. 初始状态
   - 显示日期时间选择器
   - 显示"开始分析"按钮

2. 选择日期时间
   - 日期选择器：图形化界面
   - 时间选择器：滚轮式选择

3. 点击"开始分析"
   - 隐藏日期选择器
   - 显示已选择的日期时间
   - 显示"修改出生时间"按钮
   - 展示分析结果

4. 修改时间
   - 点击"修改出生时间"
   - 重新显示日期选择器
   - 清空分析结果

### 3. 分析结果页面 (AnalysisResultView)

#### 3.1 页面结构
```
VStack
├── 八字展示卡片 (baziCard)
│   ├── 标题："您的八字"
│   └── 四柱展示 (HStack)
│       ├── 年柱
│       ├── 月柱
│       ├── 日柱
│       └── 时柱
├── 命格分析卡片 (patternCard)
│   ├── 标题："命格分析"
│   └── 分析内容
├── 五行分析卡片 (elementAnalysisCard)
│   ├── 标题："五行分析"
│   ├── 图表展示 (Chart)
│   └── 详细数据
└── 建议卡片 (adviceCard)
    ├── 标题："命理建议"
    ├── 性格特点
    ├── 事业发展
    └── 健康建议
```

#### 3.2 动画效果
```swift
// 卡片渐入动画
.transition(.slide)
.opacity(showContent ? 1 : 0)
.offset(y: showContent ? 0 : 20)

// 图表动画
.animation(.spring(response: 0.8), value: showContent)
```

## 安装说明

1. 克隆项目
```bash
git clone https://github.com/yourusername/bazi-analysis.git
```

2. 打开项目
```bash
cd bazi-analysis
open BaziAnalysis.xcodeproj
```

3. 运行项目
- 选择目标设备（iPhone）
- 点击运行按钮或按 Cmd + R

## 许可证

MIT License

## 页面结构与交互逻辑

### 1. 出生信息输入页面 (BirthInputView)
- 主要功能：输入出生日期和时辰
- 布局结构：
```
VStack
├── 标题："请选择出生时间"
├── 日期选择区域
│   ├── 标题："出生日期"
│   └── 日期选择器 (中文化显示)
├── 时辰选择区域
│   ├── 标题："出生时辰"
│   └── 时辰选择器 (12时辰带时间范围)
└── 开始分析按钮
```
- 交互细节：
  - 日期选择器使用中文显示周一至周日
  - 时辰选择使用传统十二时辰，并显示具体时间范围
  - 优化布局高度，确保按钮完整显示

### 2. 分析结果页面 (AnalysisResultView)
[原有的分析结果页面结构保持不变...]

### 3. 个人中心页面 (ProfileView)
- 主要功能：用户信息管理和设置
- 布局结构：
```
List
├── 用户信息区域
│   ├── 头像 (支持修改)
│   └── 昵称
├── 基本信息设置
│   └── 出生时间 (与主页保持一致的选择器)
├── 应用设置
│   ├── 主题设置
│   ├── 通知设置
│   └── 隐私设置
└── 其他信息
    ├── 关于我们
    ├── 使用帮助
    └── 版本信息
```

## 版本更新记录

### v1.0.1 (2024-03-21)
- 交互优化
  - 统一了出生时间选择界面的设计
  - 将时间选择改为传统十二时辰显示
  - 优化了日期选择器的中文化显示
  - 调整了界面布局，提升了空间利用率

- 界面改进
  - 减小了选择器模块的高度
  - 优化了卡片间距和内边距
  - 改进了阴影效果
  - 统一了字体样式和大小

- 功能完善
  - 添加了头像上传功能
  - 完善了个人中心页面
  - 优化了时间选择的精确度
  - 添加了更多设置选项

### v1.0.0 (2024-03-15)
- 初始版本发布
  - 实现基础八字计算功能
  - 添加五行分析功能
  - 完成基础界面布局
  - 支持基本的用户交互

### v1.0.3 (2024-03-23)
- 界面优化
  - 统一了分析结果页面的卡片样式
  - 优化了五行分析卡片的高度和间距
  - 改进了文字显示，修复了乱码问题
  - 统一使用 serif 字体设计

- 交互改进
  - 优化了出生时间选择的提示信息
  - 改进了分析按钮的状态反馈
  - 完善了日期选择的默认值处理
  - 添加了更友好的用户提示

- 功能完善
  - 优化了五行分析的展示逻辑
  - 改进了天干地支到五行的转换
  - 完善了日期时间的可选状态
  - 统一了模块间的数据传递

## 许可证

MIT License

## 界面布局

### 1. 主界面
- 采用浅色系紫色主题
- 模块化卡片设计
- 清晰的视觉层次
- 柔和的色彩搭配

### 2. 分析结果页
```
ScrollView
└── VStack(spacing: 20)
    ├── 八字展示卡片 (baziCard)
    │   ├── 标题 (.headline, serif)
    │   └── 四柱展示 (HStack, spacing: 15)
    │       └── ForEach柱子 (VStack, spacing: 8)
    │           ├── 柱名 (.callout, serif)
    │           └── 天干地支 (VStack, spacing: 12)
    │
    ├── 五行分析卡片 (fiveElementsCard)
    │   ├── 标题 (.headline, serif, indent: 1px)
    │   └── 分析内容 (VStack, spacing: 12)
    │       ├── 天干五行
    │       │   ├── 子标题 (.subheadline, indent: 3px)
    │       │   └── 五行展示 (HStack)
    │       └── 地支五行
    │           ├── 子标题 (.subheadline, indent: 3px)
    │           └── 五行展示 (HStack)
    │
    ├── 主命格分析卡片 (interpretationCard)
    │   ├── 标题 (.headline)
    │   └── 内容区域 (VStack, spacing: 20)
    │       ├── 主命格
    │       │   ├── 图标+标题
    │       │   └── 解读文本 (lineSpacing: 8)
    │       ├── 性格特征
    │       │   ├── 图标+标题
    │       │   └── 解读文本 (lineSpacing: 8)
    │       └── 适合行业
    │           ├── 图标+标题
    │           └── 解读文本 (lineSpacing: 8)
    │
    └── 五行解读卡片 (elementInterpretationCard)
        ├── 标题 (.headline)
        └── 内容区域 (VStack, spacing: 20)
            ├── 图标+标题
            └── 分析文本 (lineSpacing: 8)
```

### 3. 布局规范

#### 间距规范
- 卡片间距：20pt
- 标题底部间距：12pt
- 内容块间距：12-20pt
- 文本行间距：8pt
- 卡片内边距：
  - 八字卡片：16pt
  - 五行卡片：12pt
  - 解读卡片：水平16pt，垂直12pt

#### 字体规范
- 卡片标题：.headline, serif
- 子标题：.subheadline, serif
- 八字柱名：.callout, serif
- 正文内容：.body, serif

#### 对齐方式
- 标题左对齐
- 内容两端对齐
- 五行分析标题缩进：1px
- 五行分析子标题缩进：3px

### 数据模型

#### AnalysisResult
```swift
public struct AnalysisResult: Identifiable {
    public let id = UUID()
    public let date = Date()
    public let bazi: BaziResult
    public let elementAnalysis: String
    public let mainPattern: String
    public let characterTraits: String     // 性格特征
    public let careerSuggestions: String   // 适合行业
}

[其他内容保持不变...]

