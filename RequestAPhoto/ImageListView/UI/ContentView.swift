//
//  ContentView.swift
//  RequestAPhoto
//
//  Created by Nishigandha Bhushan Jadhav on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var imageviewModel = ImageViewModel()
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            Group {
                if imageviewModel.isLoading && imageviewModel.images.isEmpty {
                    ProgressView("Loading...")
                } else if let errorMessage = imageviewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    ScrollView {
                        LazyVGrid(columns:columns,spacing: 20) {
                            ForEach(imageviewModel.images) { imagedata in
                                NavigationLink(destination: ImageViewDetail(image: imagedata, imageurl: imagedata.urls?.regular ?? "")) {
                                        ImageView(url: imagedata.urls?.regular ?? "")
                                            .onAppear {
                                                if imagedata.id == imageviewModel.images.last?.id {
                                                    imageviewModel.fetchImages()
                                                }
                                            }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Images")
            .onAppear {
                imageviewModel.fetchImages()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
