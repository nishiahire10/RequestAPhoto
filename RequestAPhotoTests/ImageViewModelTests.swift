//
//  ImageViewModelTests.swift
//  RequestAPhoto
//
//  Created by Nishigandha Bhushan Jadhav on 22/07/24.
//

import XCTest
import Combine
@testable import RequestAPhoto

class ImageViewModelTests: XCTestCase {
    var mockURLSession : MockURLSession!
    var viewModel: ImageViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockURLSession = MockURLSession()
        viewModel = ImageViewModel()
        viewModel.urlSession = mockURLSession
        cancellables = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockURLSession = nil
        cancellables = nil
        super.tearDown()
    }

    func test_FetchImagesSuccess() {
        let imageItems = [ImageData(id: "IJolVhJKk7c", slug: "a-person-sitting-on-a-rock-with-a-camera-QpLJ8Kw5S0Q", alternative_slugs: nil, created_at : "2024-07-03T23:17:57Z", updated_at: "2024-07-24T02:09:11Z", promoted_at: nil, width : 4000, height: 6000, color: "", blur_hash : nil, description: nil, alt_description: "A person sitting on a rock with a camera", breadcrumbs: nil, urls: URLModel(raw: "https://images.unsplash.com/photo-1719937206642-ca0cd57198cc?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTcyMTgyMjU5M3w&ixlib=rb-4.0.3&q=85", full: "https://images.unsplash.com/photo-1719937206642-ca0cd57198cc?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTcyMTgyMjU5M3w&ixlib=rb-4.0.3&q=85", regular: "https://images.unsplash.com/photo-1719937206642-ca0cd57198cc?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTcyMTgyMjU5M3w&ixlib=rb-4.0.3&q=85", small: "https://images.unsplash.com/photo-1719937206642-ca0cd57198cc?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTcyMTgyMjU5M3w&ixlib=rb-4.0.3&q=85", thumb: "https://images.unsplash.com/photo-1719937206642-ca0cd57198cc?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTcyMTgyMjU5M3w&ixlib=rb-4.0.3&q=85", small_s3: "https://images.unsplash.com/photo-1719937206642-ca0cd57198cc?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTcyMTgyMjU5M3w&ixlib=rb-4.0.3&q=85"),links: nil,likes: 9, liked_by_user: false, current_user_collections: nil, sponsorship: nil, topic_submissions: nil, asset_type: "photo", user: nil)]
        let data = try? JSONEncoder().encode(imageItems)
        
        mockURLSession.data = data
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://api.unsplash.com/photos?page=1&per_page=10&client_id=TQrbR8WqGXApbhue3ysLsJTdFE4uBtZWy4Zq-g6eBuw")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = XCTestExpectation(description: "Fetch images")
        
        viewModel.$images
            .dropFirst()
            .sink { images in
                XCTAssertEqual(images.first?.id, imageItems.first?.id)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchImages()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_FetchImagesFailure() {
        mockURLSession.error = URLError(.notConnectedToInternet)
        
        let expectation = XCTestExpectation(description: "Fetch images failure")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage, "Expected error message to be non-nil")
                XCTAssertEqual(errorMessage, URLError(.notConnectedToInternet).localizedDescription, "Expected specific error message")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchImages()
        
        wait(for: [expectation], timeout: 5.0)
    }

}
