//
//  NetworkClient.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation

struct APIConfiguration {
    static var defaultHeader: [String: String] {
        [
            "X-Api-Key": "<use-your-own-API-key-here>",
            "Content-Type": "application/json"
        ]
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case tooManyRequests
}

class NetworkClient {
    static let shared = NetworkClient()

    private init() {}

    func sendRequest<U: Decodable>(
        with url: URL,
        method: String = "GET",
        headers: [String: String] = APIConfiguration.defaultHeader,
        type: U.Type,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        // Prepare request
        var request = URLRequest(url: url)
        request.httpMethod = method

        // Add custom headers if provided
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Perform request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse,
                      429 != httpResponse.statusCode else {
                    completion(.failure(NetworkError.tooManyRequests))
                    return
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    completion(.failure(NetworkError.requestFailed))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.requestFailed))
                    return
                }
                do {
                    let content = try JSONDecoder().decode(type, from: data)
                    completion(.success(content))
                } catch {
                    completion(.failure(NetworkError.requestFailed))
                }
            }
        }
        task.resume()
    }

    func buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
}
