import SwiftUI
import PhotosUI

struct AvatarEditView: View {
    @Binding var avatarImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    @State private var tempImage: UIImage?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 预览区域
                    HStack {
                        Spacer()
                        if let image = tempImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                }
                
                Section("选择头像") {
                    // 从相册选择
                    PhotosPicker(selection: $selectedItem,
                               matching: .images) {
                        Label("从相册选择", systemImage: "photo.on.rectangle")
                    }
                    
                    // 拍照
                    Button {
                        showingCamera = true
                    } label: {
                        Label("拍照", systemImage: "camera")
                    }
                }
                
                if tempImage != nil {
                    Section {
                        // 删除当前头像
                        Button(role: .destructive) {
                            tempImage = nil
                        } label: {
                            Label("删除当前头像", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("修改头像")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        avatarImage = tempImage
                        dismiss()
                    }
                }
            }
            .onChange(of: selectedItem) { item in
                Task {
                    if let data = try? await item?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        tempImage = image
                    }
                }
            }
            .sheet(isPresented: $showingCamera) {
                ImagePicker(image: $tempImage, sourceType: .camera)
            }
        }
    }
}

// 相机拍照视图
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
} 