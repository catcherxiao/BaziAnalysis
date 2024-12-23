import SwiftUI

struct FeedbackView: View {
    @State private var feedbackText = ""
    @State private var contactInfo = ""
    @State private var showingAlert = false
    
    var body: some View {
        List {
            Section {
                TextEditor(text: $feedbackText)
                    .frame(height: 150)
                    .overlay {
                        if feedbackText.isEmpty {
                            Text("请输入您的反馈意见...")
                                .foregroundColor(.secondary)
                                .padding(8)
                                .allowsHitTesting(false)
                        }
                    }
            } header: {
                Text("反馈内容")
            }
            
            Section {
                TextField("联系方式（选填）", text: $contactInfo)
            } header: {
                Text("联系方式")
            }
            
            Section {
                Button("提交反馈") {
                    submitFeedback()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("反馈")
        .alert("反馈已提交", isPresented: $showingAlert) {
            Button("确定") {
                feedbackText = ""
                contactInfo = ""
            }
        } message: {
            Text("感谢您的反馈！")
        }
    }
    
    private func submitFeedback() {
        // TODO: 实现反馈提交逻辑
        showingAlert = true
    }
} 