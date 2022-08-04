/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Contains the object recognition view controller for the Breakfast Finder.
*/

import UIKit
import AVFoundation
import Vision

final class VisionObjectRecognitionViewController: UIViewController {
    
    private let contentView: VisionObjectRecognitionView = VisionObjectRecognitionView(frame: UIScreen.main.bounds)
    private let viewModel: VisionObjectRecognitionViewModel = VisionObjectRecognitionViewModel()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setupRootLayer()
        contentView.setupLayers()
        viewModel.delegate = self
        viewModel.setupAVCapture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawVisionRequestResults(_ results: [VNObservation]) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        contentView.detectionOverlay.sublayers = nil // remove all the old recognized objects
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                continue
            }
            // Select only the label with the highest confidence.
            let topLabelObservation = objectObservation.labels[0]
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(contentView.bufferSize.width), Int(contentView.bufferSize.height))
            
            let shapeLayer = contentView.createRoundedRectLayerWithBounds(objectBounds)
            
            let textLayer = contentView.createTextSubLayerInBounds(objectBounds,
                                                            identifier: topLabelObservation.identifier,
                                                            confidence: topLabelObservation.confidence)
            shapeLayer.addSublayer(textLayer)
            contentView.detectionOverlay.addSublayer(shapeLayer)
        }
        contentView.updateLayerGeometry()
        CATransaction.commit()
    }
    
}

// MARK: - VisionObjectRecognitionViewModelDelegate
extension VisionObjectRecognitionViewController: VisionObjectRecognitionViewModelDelegate {
    
    func didReceiveRecognitionResults(_ results: [VNObservation]) {
        drawVisionRequestResults(results)
    }
    
    func didReceiveBufferWidth(_ width: CGFloat) {
        contentView.setBufferWidth(width)
    }
    
    func didReceiveBufferHeight(_ height: CGFloat) {
        contentView.setBufferHeight(height)
    }
    
    func setupPreviewLayers(_ previewLayer: CALayer) {
        contentView.setupRootLayer()
        previewLayer.frame = contentView.rootLayer.bounds
        contentView.rootLayer.addSublayer(previewLayer)
        
        // setup Vision parts
        contentView.setupLayers()
        contentView.updateLayerGeometry()
    }
}
