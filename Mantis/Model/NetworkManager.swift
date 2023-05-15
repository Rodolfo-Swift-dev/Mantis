//  NetworkManager.swift
//  Mantis
//  Created by rodoolfo gonzalez on 10-05-23.

import Foundation

protocol NetworkManagerDelegate {
    func didUpdateNetwork(_ networkManager: NetworkManager, network: [NetworkModel])
    func didFailWithError(error: Error)
}

struct NetworkManager {

    var delegate: NetworkManagerDelegate?
    
    func fetchNetwork(searchName: String) {
        
        let urlString = "https://checkmarks.com/api/v1/username/\(searchName)/account/rodDev/password/kCfx4NVgtW"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    
                    if let network = self.parseJSON(safeData) {
                        self.delegate?.didUpdateNetwork(self, network: network)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ networkData: Data) -> [NetworkModel]? {
        let decoder = JSONDecoder()
        do {
            
            let decodedDataArray : [NetworkData] = try decoder.decode([NetworkData].self , from: networkData)
            let face = NetworkModel(web: decodedDataArray[0].website, status: decodedDataArray[0].status)
            let twitter = NetworkModel(web: decodedDataArray[1].website, status: decodedDataArray[1].status)
            let instagram = NetworkModel(web: decodedDataArray[2].website, status: decodedDataArray[2].status)
            let snapchat = NetworkModel(web: decodedDataArray[3].website, status: decodedDataArray[3].status)
            let youtube = NetworkModel(web: decodedDataArray[4].website, status: decodedDataArray[4].status)
            print(decodedDataArray[0].status)
            print(decodedDataArray[1].status)
            
            let networkArray = [face, twitter, instagram, snapchat, youtube]
            return networkArray
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
