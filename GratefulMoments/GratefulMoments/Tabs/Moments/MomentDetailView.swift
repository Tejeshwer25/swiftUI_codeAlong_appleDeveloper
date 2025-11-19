//
//  MomentDetailView.swift
//  GratefulMoments
//
//  Created by Tejeshwer Singh on 19/11/25.
//

import SwiftUI
import SwiftData

struct MomentDetailView: View {
    var moment: Moment
    @State private var showConfirmation = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    
    var body: some View {
        ScrollView {
            contentStack
        }
        .navigationTitle(moment.title)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button {
                    showConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
                .confirmationDialog("Delete Moment", isPresented: $showConfirmation) {
                    Button("Delete Moment", role: .destructive) {
                        dataContainer.context.delete(moment)
                        try? dataContainer.context.save()
                        dismiss()
                    }
                } message: {
                    Text("This moment will be permanently deleted. Earned badges won't be removed")
                }
            }
        }
    }
    
    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(moment.timeStamp, style: .date)
                .font(.subheadline)
            
            if !moment.note.isEmpty {
                Text(moment.note)
                    .textSelection(.enabled)
            }
            
            if let image = moment.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    NavigationStack {
        MomentDetailView(moment: .imageSample)
            .sampleDataContainer()
    }
}
