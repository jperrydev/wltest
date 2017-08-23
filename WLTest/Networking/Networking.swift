//
//  Networking.swift
//  WLTest
//
//  Created by Jordan Perry on 8/18/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

/// Requestable allows easy network access for a model
protocol Requestable {
    /// The route to use for the request
    func route() -> String?
    
    /// Request resource from the given route
    ///
    /// - Parameter completion: handler for when request has finished
    func request(completion: @escaping (Self?, URLResponse?, Error?) -> Swift.Void)
    
    /// initialize with JSON
    ///
    /// - Parameter with: the JSON object
    init?(with json: Any?)
}

// Wrapper around URLSession to handle networking
// singleton validation:
// each URLSession maintains its own TLS session cache
// to prevent unnecessary SSL handshakes (an especially large burden on slower connections),
// using one URLSession instance since communicating with one server only
// more info: https://developer.apple.com/library/content/qa/qa1727/_index.html https://developer.apple.com/library/content/technotes/tn2232/_index.html
class Networking: NSObject, URLSessionDelegate {
    /// Shared instance of Networking
    static let shared = Networking()
    
    /// the URLSession used for requests in the app
    lazy var session: URLSession = {
        [unowned self] in
        let config = URLSessionConfiguration.default
        let memoryCap = 1024 * 1024
        let diskCap = 1024 * 1024 * 256
        config.urlCache = URLCache(memoryCapacity: memoryCap, diskCapacity: diskCap, diskPath: nil)
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    /// host to be used for connections
    let host: String = Constants.host()
    
    
    /// Load data from a given url
    ///
    /// - Parameters:
    ///   - with: URL to request
    ///   - completion: handler for when request has finished
    func loadData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        session.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    /// Load data for a given Requestable model
    ///
    /// - Parameters:
    ///   - with: the Requestable object
    ///   - completion: handler for when request has finished
    func loadData<T>(with model: T, completion: @escaping (T?, URLResponse?, Error?) -> Swift.Void) where T: Requestable {
        guard let route = model.route() else {
            return
        }
        
        let urlString = "https://\(host)/\(route)"
        if let url = URL(string: urlString) {
            loadData(with: url, completion: { (data, response, error) in
                var t: T? = nil
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        if let obj = T(with: json) {
                            t = obj
                        }
                    } catch {
                        
                    }
                }
                
                completion(t, response, error)
            })
        }
    }
    
    // MARK: URLSessionDelegate
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
}
