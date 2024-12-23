import SwiftUI
#if os(iOS)
import UIKit
#else
import AppKit
#endif

public struct BirthInputView: View {
    @EnvironmentObject private var viewModel: BirthViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State private var showDatePicker = true
    
    // 日期格式化器
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }()
    
    // 时间格式化器
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 顶部图标
                Image(systemName: "calendar.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                if showDatePicker {
                    // 日期时间选择器
                    dateTimePickerView
                        .transition(.opacity)
                    
                    // 开始分析按钮
                    analyzeButton
                } else {
                    // 显示选择的日期时间
                    selectedDateTimeView
                        .transition(.opacity)
                    
                    // 分析结果
                    if let result = viewModel.analysisResult {
                        AnalysisResultView(result: result)
                            .transition(.move(edge: .bottom))
                    }
                }
                
                Spacer(minLength: 30)
            }
        }
        #if os(iOS)
        .background(Color(UIColor.systemGroupedBackground))
        #else
        .background(Color(NSColor.windowBackgroundColor))
        #endif
    }
    
    // 日期时间选择器视图
    private var dateTimePickerView: some View {
        VStack(spacing: 20) {
            // 日期选择
            VStack(alignment: .leading, spacing: 8) {
                Text("出生日期")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                DatePicker("",
                         selection: $viewModel.birthDate,
                         displayedComponents: [.date])
                #if os(iOS)
                    .datePickerStyle(.graphical)
                #else
                    .datePickerStyle(.stepperField)
                #endif
                    .environment(\.locale, Locale(identifier: "zh_CN"))
                    .labelsHidden()
            }
            
            // 时间选择
            VStack(alignment: .leading, spacing: 8) {
                Text("出生时间")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                DatePicker("",
                         selection: $viewModel.birthTime,
                         displayedComponents: [.hourAndMinute])
                #if os(iOS)
                    .datePickerStyle(.wheel)
                #else
                    .datePickerStyle(.stepperField)
                #endif
                    .environment(\.locale, Locale(identifier: "zh_CN"))
                    .labelsHidden()
                    .frame(height: 150)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                #if os(iOS)
                .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
                #else
                .fill(colorScheme == .dark ? Color(NSColor.windowBackgroundColor) : .white)
                #endif
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
    
    // 选择的日期时间视图
    private var selectedDateTimeView: some View {
        VStack(spacing: 12) {
            Text("您选择的出生时间")
                .font(.headline)
            
            HStack(spacing: 20) {
                Text(dateFormatter.string(from: viewModel.birthDate))
                Text(timeFormatter.string(from: viewModel.birthTime))
            }
            .font(.title2)
            
            Button(action: {
                withAnimation {
                    showDatePicker = true
                    viewModel.analysisResult = nil
                }
            }) {
                Text("修改出生时间")
                    .foregroundColor(.blue)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                #if os(iOS)
                .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
                #else
                .fill(colorScheme == .dark ? Color(NSColor.windowBackgroundColor) : .white)
                #endif
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
    
    // 分析按钮
    private var analyzeButton: some View {
        Button(action: {
            withAnimation {
                showDatePicker = false
                viewModel.analyze()
            }
        }) {
            HStack {
                Text("开始分析")
                    .font(.headline)
                
                if viewModel.isAnalyzing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue)
            )
            .foregroundColor(.white)
        }
        .padding(.horizontal)
        .disabled(viewModel.isAnalyzing)
    }
}

#Preview {
    BirthInputView()
        .environmentObject(BirthViewModel())
} 