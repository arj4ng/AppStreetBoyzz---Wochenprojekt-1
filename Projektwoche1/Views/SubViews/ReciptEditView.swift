//
//  ReciptEditView.swift
//  Projektwoche1
//
//  Created by Hendrik Puls on 05.03.26.
//


import SwiftUI
import PhotosUI
import SwiftData

struct ReciptEditView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var recipt: Recipt

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?

    @State private var title: String = ""
    @State private var amount: String = ""

    var body: some View {

        VStack(spacing: 20) {

            Text("Beleg bearbeiten")
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
                Label("Neues Bild auswählen", systemImage: "photo")
            }

            Button("Speichern") {
                saveChanges()
            }
            .buttonStyle(.borderedProminent)

        }
        .padding()

        .onAppear {
            title = recipt.title
            amount = String(recipt.amount)

            if let data = recipt.imageData {
                selectedImage = UIImage(data: data)
            }
        }

        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }

    func saveChanges() {

        recipt.title = title
        recipt.amount = Double(amount) ?? 0
        recipt.imageData = selectedImage?.jpegData(compressionQuality: 0.7)

        try? context.save()

        dismiss()
    }
}