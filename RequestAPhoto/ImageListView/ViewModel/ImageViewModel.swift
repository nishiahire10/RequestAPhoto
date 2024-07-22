//
//  File.swift
//  RequestAPhoto
//
//  Created by Nishigandha Bhushan Jadhav on 21/07/24.
//

import Foundation
import Combine

class ImageViewModel : ObservableObject {
    @Published var images : [ImageData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchImages() {
        guard let url = URL(string: "https://api.unsplash.com/photos?page=\(currentPage)&per_page=10&client_id=TQrbR8WqGXApbhue3ysLsJTdFE4uBtZWy4Zq-g6eBuw") else { return }
        guard !isLoading, currentPage <= totalPages else { return }


               isLoading = true
               errorMessage = nil

        URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .decode(type: [ImageData].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    if let decodingError = error as? DecodingError {
                        self.handleDecodingError(decodingError)
                    } else {
                        self.errorMessage = error.localizedDescription
                    }
                }
                
            }, receiveValue: { images in
                self.currentPage += 1
                self.totalPages = self.currentPage + 1
                self.images.append(contentsOf: images)
            })
            .store(in: &cancellables)
    }
    
    
    private func handleDecodingError(_ error: DecodingError) {
        switch error {
                case .typeMismatch(let type, let context):
                    self.errorMessage = "Type '\(type)' mismatch: \(context.debugDescription)"
                    print("Type mismatch at \(context.codingPath): \(context.debugDescription)")
                case .valueNotFound(let type, let context):
                    self.errorMessage = "Value '\(type)' not found: \(context.debugDescription)"
                    print("Value not found at \(context.codingPath): \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    self.errorMessage = "Key '\(key)' not found: \(context.debugDescription)"
                    print("Key not found at \(context.codingPath): \(context.debugDescription)")
                case .dataCorrupted(let context):
                    self.errorMessage = "Data corrupted: \(context.debugDescription)"
                    print("Data corrupted at \(context.codingPath): \(context.debugDescription)")
                @unknown default:
                    self.errorMessage = "Unknown decoding error"
                }
    }

}


