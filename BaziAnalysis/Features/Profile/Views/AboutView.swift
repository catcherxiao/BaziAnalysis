import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    Image(systemName: "apps.iphone")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                    
                    Text("八字命理")
                        .font(.title2)
                    
                    Text("版本 1.0.0")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
            }
            
            Section("关于") {
                Text("这是一款基于传统八字命理的分析工具，提供精准的八字计算和全面的命理分析。")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("关于")
    }
} 