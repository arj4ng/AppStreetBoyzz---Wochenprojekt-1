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
    @State private var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var amount: String = ""

    var body: some View {

        VStack(spacing: 20) {

            Text("Kassenbon hochladen")
                .font(.title)

            TextField("Titel", text: $title)
                .textFieldStyle(.roundedBorder)

            TextField("Betrag", text: $amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)

            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }

            PhotosPicker(selection: $selectedItem, matching: .images) {
                Label("Beleg hinzufügen", systemImage: "photo")
            }

            Button("Speichern") {
                saveRecipt()
                    
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }

    func saveRecipt() {

        let imageData = selectedImage?.jpegData(compressionQuality: 0.7)

        let recipt = Recipt(
            title: title,
            amount: Double(amount) ?? 0,
            imageData: imageData
        )

        context.insert(recipt)
        try? context.save()
        
        dismiss()
    }
}
#Preview {
    ReciptAddView()
}
