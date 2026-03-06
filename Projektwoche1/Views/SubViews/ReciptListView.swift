import SwiftData
import SwiftUI
import PhotosUI

struct ReciptListView: View {

    @Environment(\.modelContext) private var context
    @Query(sort: \Recipt.title) private var recipts: [Recipt]

    @State private var add = false
    @State private var selectedRecipt: Recipt?

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?

    var body: some View {

        NavigationStack {

            List {

                ForEach(recipts) { recipt in

                    HStack(spacing: 15) {

                        // Bild Vorschau
                        if let data = recipt.imageData,
                           let uiImage = UIImage(data: data) {

                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                        } else {

                            Image(systemName: "photo")
                                .font(.title2)
                                .frame(width: 60, height: 60)
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }

                        VStack(alignment: .leading) {

                            Text(recipt.title)
                                .font(.headline)

                            Text(
                                recipt.amount,
                                format: .currency(code: "EUR")
                            )
                            .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }

                    // Swipe Actions
                    .swipeActions(edge: .trailing) {

                        Button(role: .destructive) {
                            deleteRecipt(recipt)
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                        .tint(nil)
                    }

                    .swipeActions(edge: .leading) {

                        Button {
                            selectedRecipt = recipt
                        } label: {
                            Label("Bearbeiten", systemImage: "pencil")
                        }
                        .tint(.blue)
                       
                    }
                }
            }

            .navigationTitle("Belege")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        add.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(nil)
                }

            }
        }

        // Bild laden wenn ausgewählt
        .onChange(of: selectedItem) { _, newItem in
            Task {

                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {

                    selectedImage = image
                }
            }
        }

        // Sheet für neuen Beleg
        .sheet(isPresented: $add) {
            ReciptAddView()
                .presentationDetents([.height(450), .large])
        }

        // Sheet für bearbeiten
        .sheet(item: $selectedRecipt) { recipt in
            ReciptEditView(recipt: recipt)
        }
    }

    func deleteRecipt(_ recipt: Recipt) {
        context.delete(recipt)
        try? context.save()
    }
}

#Preview {
    ReciptListView()
        .modelContainer(for: Recipt.self)
}
