//  NetworkManager.swift
//  Mantis
//  Created by rodoolfo gonzalez on 10-05-23.

import UIKit
import AVFoundation

protocol NetworkManagerDelegate {
    func didUpdateNetwork(_ networkManager: NetworkManager, network: [DataInfo])
    func didFailWithError(error: Error)
}

class NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    
    
    func processNetwork(name : String) async{
        
        
        do{
            if let stringText = try await regularExpre(text: name){
                if let url = try await fetchURL(search: stringText){
                    if let data = try await performReq(with: url){
                        if let dataResult = try await parsJson(data){
                            self.delegate?.didUpdateNetwork(self, network: dataResult)
                        }
                    }
                   
                }
            }
            
           
            
        }catch {
            self.delegate?.didFailWithError(error: error)
        }
    }
    
    func regularExpre(text: String)async -> String?{
        
        let normalizedText = NSMutableString(string: text.lowercased().folding(options: .diacriticInsensitive, locale: .current))

        let range = NSMakeRange(0, normalizedText.length)
        
        let regex = try! NSRegularExpression(pattern: "[^a-z0-9]", options: [])
        
        regex.replaceMatches(in: normalizedText, options: [], range: range, withTemplate: "")
        print(normalizedText.description)
        let text = String(normalizedText)
      
        return text
       
    }

    
    func fetchURL(search: String )async -> String? {
      
        let url = "https://checkmarks.com/api/v1/username/\(search)/account/rodDev/password/kCfx4NVgtW"
         
        return url
    }
    
    func performReq(with url: String) async throws -> Data?{
        
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
       
        return data
        
    }
    
    func parsJson(_ networkData: Data) async throws -> [DataInfo]?{
        
        let decoder = JSONDecoder()
        let decodedDataArray = try! decoder.decode([Result].self , from: networkData)
            let result = decodedDataArray
            let face = DataInfo(web: result[0].website, status: result[0].status)
            let twitter = DataInfo(web: result[1].website, status: result[1].status)
            let instagram = DataInfo(web: result[2].website, status: result[2].status)
            let snapchat = DataInfo(web: result[3].website, status: result[3].status)
            let youtube = DataInfo(web: result[4].website, status: result[4].status)
            let networkArray = [face,twitter, instagram, snapchat, youtube]
        
        return networkArray
            
    }
   
    /*
    func fetchNetwork(searchName: String) {
        
        let urlString = "https://checkmarks.com/api/v1/username/\(searchName)/account/rodDev/password/kCfx4NVgtW"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .ephemeral)
            
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
            
            let decodedDataArray : [NetworkData] = try JSONDecoder().decode([NetworkData].self , from: networkData)
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
    */
}
