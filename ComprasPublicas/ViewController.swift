//
//  ViewController.swift
//  ComprasPublicas
//
//  Created by Ana Finotti on 5/5/18.
//  Copyright © 2018 Finotti. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import Vision
import CoreML
import CoreData
import CoreDataManager
import UIKit.UIGestureRecognizerSubclass

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}
class ViewController: UIViewController {
    
    
    var i = 0
    var eName: String?
    var compra: Compra?
    var compras = [Compra]()
    
    var cameraLayer: CALayer!
    let captureSession = AVCaptureSession()

    private let cdm = CoreDataManager.sharedInstance
    
    let productDetailView = ProductDetailView.fromNib(named: "ProductDetailView") as! ProductDetailView
    private var animationProgress: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraSetup()
        //getXmlFiles(path: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getProducts(id: String) {
        var context: NSManagedObjectContext?
        if cdm.mainContext.hasChanges {
            context = cdm.backgroundContext
        } else {
            context = cdm.mainContext
        }
        compras = (context?.managerFor(Compra.self).array.filter({ $0.codigoItem == id }))!
        getAverageCost()
    }
    
    func getAverageCost() {
        var totalValue = 0.0
        var i = 0
        for item in compras {
            i += 1
            totalValue += Double(item.valorUnitarioNegociado)!
        }
        let averageCost = totalValue/Double(i)
        print(averageCost)
        showView(averageCost: "\(averageCost)", totalItems: "\(i)")
    }
    
    func cameraSetup() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
        let input = try! AVCaptureDeviceInput(device: backCamera)
        
        captureSession.addInput(input)
        
        cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraLayer)
        cameraLayer.frame = view.bounds
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "buffer delegate"))
        videoOutput.recommendedVideoSettings(forVideoCodecType: .jpeg, assetWriterOutputFileType: .mp4)
        
        captureSession.addOutput(videoOutput)
        captureSession.sessionPreset = .high
        captureSession.startRunning()
    }
    

    func predict(image: CGImage) {
        let model = try! VNCoreMLModel(for: Objetos_850846597().model)
        let request = VNCoreMLRequest(model: model, completionHandler: results)
        let handler = VNSequenceRequestHandler()
        try! handler.perform([request], on: image)
    }

    func results(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            print("No result found")
            return
        }
        
        guard results.count != 0 else {
            print("No result found")
            return
        }
        
        let highestConfidenceResult = results.first!
        if highestConfidenceResult.confidence > 0.7 {
            let identifier = highestConfidenceResult.identifier.contains(", ") ? String(describing: highestConfidenceResult.identifier.split(separator: ",").first!) : highestConfidenceResult.identifier
            captureSession.stopRunning()
            getProducts(id: identifier)

            print(identifier)
        } else {
            return
        }
    }
    
    func showView(averageCost: String, totalItems: String) {
        productDetailView.addGestureRecognizer(tapRecognizer)
        productDetailView.addGestureRecognizer(panRecognizer)

        productDetailView.itemTitleLabel.text = compras.first?.descricaoItem
        productDetailView.averageCostLabel.text = averageCost
        productDetailView.totalLabel.text = totalItems
        
        productDetailView.frame = CGRect(x: 0, y: 1000, width: view.frame.width, height: 314)
        view.addSubview(productDetailView)
        view.bringSubview(toFront: productDetailView)
        UIView.animate(withDuration: 0.5, animations: {
            self.productDetailView.frame = CGRect(x: 0, y: self.view.frame.height - 314, width: self.view.frame.width, height: 314)
        }) { (completed) in
        }
    }
    
    func getXmlFiles(path: Int) {
        switch path {
        case 0:
            if let path = Bundle.main.url(forResource: "2017_01", withExtension: "xml") {
                if let parser = XMLParser(contentsOf: path) {
                    
                    parser.delegate = self
                    parser.parse()
                }
            }
        case 1:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_02", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 2:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_03", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 3:
            DispatchQueue.main.async {
                
                if let path = Bundle.main.url(forResource: "2017_04", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 4:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_05", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 5:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_06", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 6:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_07", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 7:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_08", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 8:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_09", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 9:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_10", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 10:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_11", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 11:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2017_12", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 12:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2018_01", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 13:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2018_02", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        case 14:
            DispatchQueue.main.async {
                if let path = Bundle.main.url(forResource: "2018_03", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                    }
                }
            }
        default:
            break;
        }
    }
    
    
    // MARK: - Animation

    /// All of the currently running animators.
    private var runningAnimators = [UIViewPropertyAnimator]()
    
    
    private lazy var panRecognizer: InstantPanGestureRecognizer = {
        let recognizer = InstantPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(productDetailViewPanned(recognizer:)))
        return recognizer
    }()
    
    private var currentState: State = .closed
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(productDetailViewTapped(recognizer:)))
        return recognizer
    }()
    
    @objc private func productDetailViewTapped(recognizer: UITapGestureRecognizer) {
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.productDetailView.frame = CGRect(x: 0, y: self.view.frame.height - 314, width: self.view.frame.width, height: 314)
            case .closed:
                self.productDetailView.frame = CGRect(x: 0, y: 1000, width: self.view.frame.width, height: 0)
                self.captureSession.startRunning()
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            switch self.currentState {
            case .open:
                self.productDetailView.frame = CGRect(x: 0, y: self.view.frame.height - 314, width: self.view.frame.width, height: 314)
            case .closed:
                self.productDetailView.frame = CGRect(x: 0, y: 1000, width: self.view.frame.width, height: 0)
                self.captureSession.startRunning()
            }
        }
        transitionAnimator.startAnimation()
    }
    
    /// Animates the transition, if the animation is not already running.
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        
        // ensure that the animators array is empty (which implies new animations need to be created)
        guard runningAnimators.isEmpty else { return }
        
        // an animator for the transition
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.productDetailView.frame = CGRect(x: 0, y: self.view.frame.height - 314, width: self.view.frame.width, height: 314)
            case .closed:
                self.productDetailView.frame = CGRect(x: 0, y: 1000, width: self.view.frame.width, height: 0)
                self.captureSession.startRunning()
            }
            self.view.layoutIfNeeded()
        })
        
        // the transition completion block
        transitionAnimator.addCompletion { position in
            
            // update the state
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            
            // manually reset the constraint positions
            switch self.currentState {
            case .open:
                self.productDetailView.frame = CGRect(x: 0, y: self.view.frame.height - 314, width: self.view.frame.width, height: 314)
            case .closed:
                self.productDetailView.frame = CGRect(x: 0, y: 1000, width: self.view.frame.width, height: 0)
                self.captureSession.startRunning()
            }
            
            // remove all running animators
            self.runningAnimators.removeAll()
        }
        
        // start all animators
        transitionAnimator.startAnimation()
        
        // keep track of all running animators
        runningAnimators.append(transitionAnimator)
        
    }
    
    @objc private func productDetailViewPanned(recognizer: UIPanGestureRecognizer) {
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: nil)
        switch recognizer.state {
        case .began:
            animationProgress = transitionAnimator.fractionComplete
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1.5)
            transitionAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: productDetailView)
            var fraction = -translation.y / 314
            if currentState == .open { fraction *= -1 }
            if transitionAnimator.isReversed { fraction *= -1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: productDetailView).y
            let shouldClose = yVelocity > 0
            if yVelocity == 0 {
                transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            switch currentState {
            case .open:
                if !shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            case .closed:
                if shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if !shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            }
            transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            ()
        }
    }
    
}

// MARK: - InstantPanGestureRecognizer
/// A pan gesture that enters into the `began` state on touch down instead of waiting for a touches moved event.
class InstantPanGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizerState.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizerState.began
    }
}


extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { fatalError("pixel buffer is nil") }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext(options: nil)
        
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { fatalError("cg image") }
        let uiImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .leftMirrored)
        
        DispatchQueue.main.sync {
            predict(image: uiImage.cgImage!)
        }
    }
}

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if eName == "_x0030_" {
            var context: NSManagedObjectContext?
            if cdm.mainContext.hasChanges {
                context = cdm.backgroundContext
            } else {
                context = cdm.mainContext
            }
            compra = NSEntityDescription.insertNewObject(forEntityName: "Compra", into: context!) as? Compra
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "_x0030_" {
            var context: NSManagedObjectContext?
            if cdm.mainContext.hasChanges {
                context = cdm.backgroundContext
            } else {
                context = cdm.mainContext
            }
            try! context?.save()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(i)
        i += 1
        if i <= 14 {
            getXmlFiles(path: i)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string.contains("\n") { return }
        if eName == "OC" {
            compra?.oc = string
        }
        if eName == "MODALIDADE" {
            compra?.modalidade = string
        }
        if eName == "ITEM" {
            compra?.item = string
        }
        if eName == "CODIGO_ITEM" {
            compra?.codigoItem = string
        }
        if eName == "DESCRICAO_ITEM" {
            compra?.descricaoItem = string
        }
        if eName == "UNIDADE_FORNECIMENTO" {
            compra?.unidadeFornecimento = string
        }
        if eName == "RESULTADO_ITEM" {
            compra?.resultadoItem = string
        }
        if eName == "VENCEDOR_OC_ITEM" {
            compra?.vencedorOCItem = string
        }
        if eName == "VALOR_UNITARIO_NEGOCIADO" {
            compra?.valorUnitarioNegociado = string
        }
        if eName == "VALOR_TOTAL_NEGOCIADO" {
            compra?.valorTotalNegociado = string
        }
        if eName == "QUANTIDADE" {
            compra?.quantidade = string
        }
        if eName == "DATA_ENCERRAMENTO" {
            if !string.isEmpty {
                var date = Date(fromString: string, format: DateFormatType.isoDateTimeMilliSec)
                if date == nil {
                    date = Date(fromString: string, format: DateFormatType.isoDateTimeSec)
                }
                compra?.dataEncerramento = date
            } else {
                compra?.dataEncerramento = Date()
            }
        }
        if eName == "CODIGO_UGE" {
            compra?.codigoUGE = string
        }
        if eName == "UGE" {
            compra?.uge = string
        }
        if eName == "TIPO_UGE" {
            compra?.tipoUGE = string
        }
        if eName == "LOGRADOURO_UGE" {
            compra?.logradouroUGE = string
        }
        if eName == "CEP_UGE" {
            compra?.cepUGE = string
        }
        if eName == "UF_UGE" {
            compra?.ufUGE = string
        }
    }
}
