import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var birthViewModel: BirthViewModel
    @State private var showingDatePicker = false
    @State private var showingAvatarEdit = false
    @State private var avatarImage: UIImage?
    
    var body: some View {
        List {
            // 用户信息区域
            Section {
                Button(action: {
                    showingAvatarEdit = true
                }) {
                    HStack {
                        if let image = avatarImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("用户昵称")
                                .font(.headline)
                            Text("点击修改头像")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                }
                .sheet(isPresented: $showingAvatarEdit) {
                    AvatarEditView(avatarImage: $avatarImage)
                }
            }
            
            // 基本信息设置
            Section("基本信息") {
                Button(action: {
                    showingDatePicker = true
                }) {
                    HStack {
                        Label("出生日期", systemImage: "calendar")
                        Spacer()
                        Text(birthViewModel.birthDate.formatted(date: .long, time: .shortened))
                            .foregroundColor(.secondary)
                    }
                }
                .sheet(isPresented: $showingDatePicker) {
                    NavigationStack {
                        BirthDateEditView(birthDate: $birthViewModel.birthDate)
                    }
                }
            }
            
            // 应用设置
            Section("应用设置") {
                NavigationLink(destination: ProfileThemeSettingsView()) {
                    Label("主题设置", systemImage: "paintbrush")
                }
                
                NavigationLink(destination: ProfileNotificationSettingsView()) {
                    Label("通知设置", systemImage: "bell")
                }
                
                NavigationLink(destination: ProfilePrivacySettingsView()) {
                    Label("隐私设置", systemImage: "lock")
                }
            }
            
            // 其他信息
            Section("其他") {
                NavigationLink(destination: ProfileAboutView()) {
                    Label("关于我们", systemImage: "info.circle")
                }
                
                NavigationLink(destination: ProfileHelpView()) {
                    Label("使用帮助", systemImage: "questionmark.circle")
                }
                
                HStack {
                    Label("版本", systemImage: "gear")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("个人中心")
    }
}

// 出生日期编辑视图
struct BirthDateEditView: View {
    @Binding var birthDate: Date
    @Environment(\.dismiss) private var dismiss
    @State private var tempDate = Date()
    @EnvironmentObject private var birthViewModel: BirthViewModel
    
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
        VStack(spacing: 24) {
            // 日期选择
            VStack(alignment: .leading, spacing: 8) {
                Text("出生日期")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                DatePicker("",
                         selection: $tempDate,
                         displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .frame(maxHeight: 320)
                .environment(\.locale, Locale(identifier: "zh_CN"))
                .environment(\.calendar, Calendar(identifier: .gregorian))
                .transformEnvironment(\.calendar) { calendar in
                    calendar.locale = Locale(identifier: "zh_CN")
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            
            // 时辰选择
            VStack(alignment: .leading, spacing: 8) {
                Text("出生时辰")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Picker("", selection: $birthViewModel.selectedTimeSlot) {
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
                .frame(height: 100)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            
            // 确认按钮
            Button(action: {
                birthViewModel.birthDate = tempDate
                dismiss()
            }) {
                Text("确认")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 12)
        }
        .padding()
        .navigationTitle("修改出生时间")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("取消") {
                    dismiss()
                }
            }
        }
        .onAppear {
            tempDate = birthDate
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
} 