//
//  ViewController.swift
//  rekrut
//
//  Created by Mikołaj Linczewski on 24/04/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var labelOutlet: UILabel!
    @IBOutlet var imageOutlet: UIImageView!
    @IBOutlet var objectTitle: UILabel!
    @IBOutlet var ModificationDate: UILabel!
    
    var dataFromUrl: [DataModel] = []
    let url: String = "https://recruitment-task.futuremind.dev/recruitment-task"
    
    let parser = JSONParser.sharedParser
    
    func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(url: URL) {
        getData(url: url) { (data, response, error) in
            guard let tempData = data else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageOutlet.image = UIImage(data: tempData)
                
            }
        }
    }
    
    fileprivate func fileDL() {
        super.viewDidLoad()
        parser.readFromURL(fromURL: url) { [self] (data) in
            do {
                guard let data = data else { return }
                let tempData: [DataModel] = try parser.parse(jsonData: data)
                dataFromUrl = tempData
                DispatchQueue.main.async {
                    assignElements()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func assignElements() {
        labelOutlet.text = dataFromUrl[0].description
        objectTitle.text = dataFromUrl[0].title
        ModificationDate.text = String(dataFromUrl[0].modificationDate)
        downloadImage(url: dataFromUrl[0].image_url)
    }
    
    override func viewDidLoad() {
        fileDL()
    }
}




