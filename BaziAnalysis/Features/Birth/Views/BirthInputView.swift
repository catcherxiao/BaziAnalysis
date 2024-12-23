import SwiftUI

struct BirthInputView: View {
    @EnvironmentObject private var viewModel: BirthViewModel
    
    // 定义十二时辰
    private let timeSlots = [
        (name: "子时", range: "23:00-00:59"),
        (name: "丑时", range: "1:00-2:59"),
        (name: "寅时", range: "3:00-4:59"),
        (name: "卯时", range: "5:00-6:59"),
        (name: "辰时", range: "7:00-8:59"),
        (name: "巳时", range: "9:00-10:59"),
        (name: "午时", range: "11:00-12:59"),
        (name: "未时", range: "13:00-14:59"),
        (name: "申时", range: "15:00-16:59"),
        (name: "酉时", range: "17:00-18:59"),
        (name: "戌时", range: "19:00-20:59"),
        (name: "亥时", range: "21:00-22:59")
    ]
    
    var body: some View {
        Group {
            if viewModel.showingResult {
                AnalysisResultView(result: viewModel.analysisResult!)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        Text("请选择出生时间")
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.top, 16)
                        
                        // 日期选择
                        VStack(alignment: .leading, spacing: 6) {
                            Text("出生日期")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            DatePicker("",
                                     selection: $viewModel.birthDate,
                                     displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .frame(maxHeight: 280)
                            .environment(\.locale, Locale(identifier: "zh_CN"))
                            .environment(\.calendar, Calendar(identifier: .gregorian))
                            .transformEnvironment(\.calendar) { calendar in
                                calendar.locale = Locale(identifier: "zh_CN")
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                        
                        // 时辰选择
                        VStack(alignment: .leading, spacing: 6) {
                            Text("出生时辰")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Picker("", selection: $viewModel.selectedTimeSlot) {
                                ForEach(0..<12) { index in
                                    HStack {
                                        Text(timeSlots[index].name)
                                            .font(.headline)
                                        Text("(\(timeSlots[index].range))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 90)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                        
                        // 分析按钮
                        Button(action: {
                            viewModel.analyze()
                        }) {
                            if viewModel.isAnalyzing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("开始分析")
                                    .font(.headline)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(viewModel.isAnalyzing)
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .scrollDismissesKeyboard(.immediately)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
} 