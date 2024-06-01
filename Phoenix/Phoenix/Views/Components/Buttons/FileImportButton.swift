//
//  FileImportButton.swift
//  Phoenix
//
//  Created by James Hughes on 9/23/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileImportButton: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let type: UTType
    @State var isImporting: Bool = false
    @State var input: String?
    @Binding var outputPath: String
    let showOutput: Bool
    let title: String
    let unselectedLabel: String
    let selectedLabel: String
    let action: (URL) -> String?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                if showOutput && outputPath != "" {
                    Text("\(selectedLabel): \(outputPath)")
                        .foregroundColor(.secondary)
                        .font(.caption)
                } else if let input = input {
                    Text("\(selectedLabel): \(input)")
                        .foregroundColor(.secondary)
                        .font(.caption)
                } else {
                   Text(unselectedLabel)
                       .foregroundColor(.secondary)
                       .font(.caption)
               }
            }
            Spacer()
            Button(
                action: {
                    isImporting = true
                },
                label: {
                    Text(LocalizedStringKey("editGame_Browse"))
                }
            )
            .accessibilityLabel(title)
        }
        .fileImporter(
            isPresented: $isImporting,
            allowedContentTypes: [type],
            allowsMultipleSelection: false
        ) { result in
            do {
                let selectedFileURL: URL? = try result.get().first
                if let selectedFileURL = selectedFileURL, let response = action(selectedFileURL) {
                    input = selectedFileURL.path
                    outputPath = response
                }
            }
            catch {
                logger.write(error.localizedDescription)
                appViewModel.failureToastText = "Unable to get file: \(error)"
                appViewModel.showFailureToast.toggle()
            }
        }
        .onDrop(of: [type], isTargeted: nil) { selectedFile in
            handleDrop(providers: selectedFile)
            return true
        }
        .padding()
    }
    
    private func handleDrop(providers: [NSItemProvider]) {
        for provider in providers {
            print(provider)
            // Check if the dropped item is a file URL
            provider.loadItem(forTypeIdentifier: type.identifier, options: nil) { item, error in
                if let error = error {
                    logger.write(error.localizedDescription)
                    appViewModel.failureToastText = "Unable to create application launch command: \(error)"
                    appViewModel.showFailureToast.toggle()
                    return
                }
                if let selectedFileURL = (item as? URL), let response = action(selectedFileURL) {
                    input = selectedFileURL.path
                    outputPath = response
                }
            }
        }
    }
}
