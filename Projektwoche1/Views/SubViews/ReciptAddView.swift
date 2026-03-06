//
//  AnalyseView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 04.03.26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ReciptAddView: View {

    @Environment(\.modelContext) private var context

    @State private var selectedItem: PhotosPickerItem?
    @State private var showSourceDialog: Bool = false
    @State private var showCamera: Bool = false
    @State private var showFileImporter: Bool = false
    @State private var showPhotoPicker: Bool = false
    @State private var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State  var amount: Double = 0.0

    var body: some View {

        VStack(spacing: 20) {

            Text("Kassenbon hochladen")
                .font(.title)

            TextField("Titel", text: $title)
                .textFieldStyle(.roundedBorder)

            TextField(
                "Betrag",
                value: $amount,
                format: .number
            )
            .keyboardType(.decimalPad)
            Slider(value: $amount, in: 0...3000, step: 50)
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }

            Button {
                showSourceDialog = true
            } label: {
                Label("Beleg hinzufügen", systemImage: "photo")
            }

            Button("Speichern") {
                saveRecipt()
                    
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
        .confirmationDialog("Bildquelle wählen", isPresented: $showSourceDialog, titleVisibility: .visible) {
              Button("Foto aufnehmen") {
                showCamera = true
              }
              Button("Aus Mediathek wählen") {
                showPhotoPicker = true
              }
              Button("Datei auswählen") {
                showFileImporter = true
              }
            }
            .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem, matching: .images)
            .sheet(isPresented: $showCamera) {
              CameraPicker(image: $selectedImage)
            }
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.image]) { result in
              if case .success(let url) = result,
                let data = try? Data(contentsOf: url),
                let uiImage = UIImage(data: data) {
                selectedImage = uiImage
              }
            }
          }

    func saveRecipt() {

        let imageData = selectedImage?.jpegData(compressionQuality: 0.7)

        let recipt = Recipt(
            title: title,
            amount: amount,
            imageData: imageData
        )

        context.insert(recipt)
        try? context.save()
        
        dismiss()
    }
}

struct CameraPicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let img = info[.originalImage] as? UIImage {
                parent.image = img
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview {
    ReciptAddView()
}
