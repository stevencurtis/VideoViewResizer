//
//  VideoViewResizerTests.swift
//  VideoViewResizerTests
//
//  Created by Steven Curtis on 02/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import VideoViewResizer

class VideoViewResizerTests: XCTestCase {
    //aspect fit should always fit, and retain any parts as transparent
    
    func testViewRectangleScaleAspect(){
        let containerSize = CGSize(width: 200, height: 400)
        let videoSize = CGSize(width: 640, height: 480)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFit)
        XCTAssert(result == CGRect(origin: CGPoint(x: 0, y: 125.0), size: CGSize(width: 200.0, height: 150.0)) )
    }
    
    func testViewRectanglescaleAspectFit(){
        let containerSize = CGSize(width: 200, height: 400)
        let videoSize = CGSize(width: 640, height: 480)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFit)
        let aRect = CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize)
        XCTAssert(aRect.contains(result!))
    }
    
    func testViewRectanglescaleReverseAspectFit(){
        let containerSize = CGSize(width: 400, height: 200)
        let videoSize = CGSize(width: 640, height: 480)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFit)
        let aRect = CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize)
        XCTAssert(aRect.contains(result!))
    }
    
    func testViewRectanglescaleLargeSquareAspectFit(){
        let containerSize = CGSize(width: 400, height: 200)
        let videoSize = CGSize(width: 1000, height: 1000)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFit)
        let aRect = CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize)
        XCTAssert(aRect.contains(result!))
    }
    
    func testViewRectanglescaleLargehorizontalAspectFit(){
        let containerSize = CGSize(width: 400, height: 200)
        let videoSize = CGSize(width: 1080, height: 720)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFit)
        let aRect = CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize)
        XCTAssert(aRect.contains(result!))
    }
    
    func testViewRectanglescaleLargeVerticalAspectFit(){
        let containerSize = CGSize(width: 400, height: 200)
        let videoSize = CGSize(width: 720, height: 1080)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFit)
        let aRect = CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize)
        XCTAssert(aRect.contains(result!))
    }
    
    //scaleAspectFill scales the result while maintaing the aspect ratio
    func testViewRectanglescaleLargeVerticalAspectFill(){
        let containerSize = CGSize(width: 400, height: 200)
        let videoSize = CGSize(width: 720, height: 1080)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFill)
        let videoRatio = videoSize.height / videoSize.width
        let resultRatio = result!.height / result!.width
        XCTAssert(videoRatio == resultRatio && (containerSize.width == result?.width || containerSize.height == result?.height ) )
    }
    
    func testViewRectanglescaleLargeVerticalReverseContainerAspectFill(){
        let containerSize = CGSize(width: 200, height: 400)
        let videoSize = CGSize(width: 720, height: 1080)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFill)
        let videoRatio = videoSize.height / videoSize.width
        let resultRatio = result!.height / result!.width
        XCTAssert(videoRatio == resultRatio && (containerSize.width == result!.width || containerSize.height == result!.width || containerSize.width == result!.height || containerSize.height == result!.height) )
    }
    
    func testViewRectanglescaleLargeHorizontalAspectFill(){
        let containerSize = CGSize(width: 400, height: 200)
        let videoSize = CGSize(width: 1080, height: 720)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFill)
        let videoRatio = videoSize.height / videoSize.width
        let resultRatio = result!.height / result!.width
        XCTAssert(videoRatio == resultRatio && (containerSize.width == result!.width || containerSize.height == result!.width || containerSize.width == result!.height || containerSize.height == result!.height) )
        //Ratio very close
    }
    
    func testViewRectanglescaleLargeHorizontalReverseVideoAspectFill(){
        let containerSize = CGSize(width: 400, height: 200)
        let videoSize = CGSize(width: 720, height: 1080)
        let result = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize, aspectFit: UIView.ContentMode.scaleAspectFill)
        let videoRatio = videoSize.height / videoSize.width
        let resultRatio = result!.height / result!.width
        
        XCTAssert(videoRatio == resultRatio && (containerSize.width == result!.width || containerSize.height == result!.width || containerSize.width == result!.height || containerSize.height == result!.height) )
        //Ratio very close
    }
}
