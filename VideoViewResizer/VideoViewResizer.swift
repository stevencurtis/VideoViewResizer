//
//  VideoViewResizer.swift
//  WebRTCManager
//
//  Created by Steven Curtis on 30/1/18.
//  Copyright © 2018 Steven Curtis. All rights reserved.
//

import Foundation
import UIKit

public class VideoViewResizer {
    public func videoView(_ videoView: UIView, didChangeVideoSize size: CGSize) {
        //called for localview when the orientation changes
        videoSize = size
        videoView.frame = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: size, aspectFit: contentMode)!
    }
    
    var videoSize :  CGSize?
    let videoView : UIView
    
    //Container size only changes when the orientation of the device changes
    public var containerSize : CGSize {
        didSet{
            videoView.frame = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize!, aspectFit: contentMode)!
            videoView.setNeedsLayout()
            videoView.layoutIfNeeded()
        }
    }
    
    public var contentMode: UIView.ContentMode {
        didSet{
            videoView.frame = VideoViewResizer.calculateRectangle(containerSize: containerSize, videoSize: videoSize!, aspectFit: contentMode)!
            videoView.setNeedsLayout()
            videoView.layoutIfNeeded()
        }
    }
    
    //pass in a video view frame, the container it needs to fit into and the content mode for displaying the video. then whenever a video stream is received through the delegate the frame is adjusted approproately
    public init(_ videoView: UIView, containerSize: CGSize, contentMode: UIView.ContentMode) {
        self.videoView = videoView
        self.containerSize = containerSize
        self.contentMode = contentMode
    }
    
    // .scaleAspectFit
    //aspectFill can clip the contents, aspect fit scales the picture to fit, so there can be transparent areas (bars)
    //aspect fit: Scales the image until the biggest side fits flush with the target area. Empty space is applied to EITHER the top of the side
    //aspect fill: Scales the image until the emallest sied fits flush with the target area. One side is cropped, never both
    
    //if given a void combination, may be able to return nil
    static func calculateRectangle(containerSize: CGSize, videoSize: CGSize, aspectFit: UIView.ContentMode) -> CGRect?{
        //isContainerWidthMax is the larger of the container width and height
        let isContainerWidthMax = containerSize.width > containerSize.height
        let isLandscape = isContainerWidthMax
        //isVideoWidthMax is the largest dimension of the video
        let isVideoWidthMax = videoSize.width > videoSize.height

        //Return the largest and smallest dimensions of the container.
        //Aspect fill means we fix the smallest dimension of the container, aspect fit means the largest
        let maxContainerDimension = isContainerWidthMax ? containerSize.width : containerSize.height
        let minContainerDimension = !isContainerWidthMax ? containerSize.width : containerSize.height
        let fixedDimension = aspectFit != .scaleAspectFill ? minContainerDimension : maxContainerDimension

        //Ratio is the video ratio. Condition decides whether the ratio is the reciprocal of the ratio according to the display mode
        let condition = aspectFit == .scaleAspectFit ? isContainerWidthMax : isVideoWidthMax
        var ratio = videoSize.width / videoSize.height
        if (!condition) { ratio = 1 / ratio }
        
        var newWidth: CGFloat = 0
        var newHeight : CGFloat = 0
        //set the width and the height, depending on which dimension is fixed and then multiplying by the ratio

            newWidth = fixedDimension * (condition ? ratio : 1)
            newHeight = fixedDimension  * (condition  ? 1 : ratio)

        //if the width of the container and the video are the max, but the video is larger than the container i.e. where the incoming video and device are in orientation mode
        if (newWidth>containerSize.width && isLandscape && (aspectFit == UIView.ContentMode.scaleAspectFit) )
        {
            newWidth = containerSize.width
            newHeight = containerSize.width * (1/ratio)
        }

        //Reposition the view to the middle of the container (both the x and y coordinates)
        let newX = ( -(newWidth / 2) + ( (containerSize.width) / 2) )
        let newY = ( -(newHeight / 2) + ( (containerSize.height) / 2) )
        
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
    
    
    
}
