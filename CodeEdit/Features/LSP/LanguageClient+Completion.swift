//
//  LanguageClient+Completion.swift
//  CodeEdit
//
//  Created by Abe Malla on 2/7/24.
//

import Foundation
import LanguageServerProtocol

extension LanguageServer {
    func requestCompletion(document documentURI: String, position: Position) async throws -> CompletionResponse {
        let cacheKey = CacheKey(uri: documentURI, requestType: "completion")
        if let cachedResponse: CompletionResponse = lspCache.get(key: cacheKey) {
            return cachedResponse
        }
        let completionParams = CompletionParams(
            uri: documentURI,
            position: position,
            triggerKind: .invoked,
            triggerCharacter: nil
        )
        let response = try await lspInstance.completion(completionParams)

        lspCache.set(key: cacheKey, value: response)
        return response
    }
}
