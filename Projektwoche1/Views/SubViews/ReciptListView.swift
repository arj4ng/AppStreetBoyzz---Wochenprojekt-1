import SwiftData
import SwiftUI

struct ReciptListView: View {

    @Environment(\.modelContext) private var context
    @Query(sort: \Recipt.title) private var recipts: [Recipt]

    @State private var add = false
    @State private var selectedRecipt: Recipt?

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

                        // Löschen
                        Button(role: .destructive) {
                            deleteRecipt(recipt)
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                    }

                    .swipeActions(edge: .leading) {

                        // Bearbeiten
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

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        add.toggle()
                    } label: {
                        Label("Beleg hinzufügen", systemImage: "plus")
                    }
                }
            }
        }
        .tint(nil)
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
