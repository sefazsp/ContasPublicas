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

class ViewController: UIViewController {
    
    @IBOutlet var cameraView: UIView!
    
    var i = 0
    var eName: String?
    var compra: Compra?
    
    var cameraLayer: CALayer!
    
    private let cdm = CoreDataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraSetup()
       // getXmlFiles(path: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cameraSetup() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
        let input = try! AVCaptureDeviceInput(device: backCamera)
        
        captureSession.addInput(input)
        
        cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraView.layer.addSublayer(cameraLayer)
        cameraLayer.frame = view.bounds
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "buffer delegate"))
        videoOutput.recommendedVideoSettings(forVideoCodecType: .jpeg, assetWriterOutputFileType: .mp4)
        
        captureSession.addOutput(videoOutput)
        captureSession.sessionPreset = .high
        captureSession.startRunning()
    }
    

    func predict(image: CGImage) {
        let model = try! VNCoreMLModel(for: Inceptionv3().model)
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
        let identifier = highestConfidenceResult.identifier.contains(", ") ? String(describing: highestConfidenceResult.identifier.split(separator: ",").first!) : highestConfidenceResult.identifier
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
    
    //MARK: Camera
    @IBAction func captureTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func searchByDescriptionTouchUpInside(_ sender: UIButton) {
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
