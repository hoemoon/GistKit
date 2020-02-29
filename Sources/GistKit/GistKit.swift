//
//  GistService.swift
//  GistKit
//
//  Copyright © 2020 bseoul. All rights reserved.
//

import Foundation
import OAuthSwift
import AuthenticationServices

public protocol GistService {
    func authorize(completion: @escaping (String?, Error?) -> Void)
    func handleOpenURLContext(url: URL)
}

public class GistServiceImpl: GistService {
    enum Constant {
        static let authorizeURL: String = "https://github.com/login/oauth/authorize"
        static let accessTokenURL: String = "https://github.com/login/oauth/access_token"
        static let callbackURL: String = "particle://oauth-callback/github"
        static let responseType: String = "code"
    }
    
    let consumerKey: String
    let consumerSecret: String
    weak var presentationContext: ASWebAuthenticationPresentationContextProviding!
    var oauth2: OAuth2Swift!
    
    public init(
        consumerKey: String,
        consumerSecret: String,
        presentationContext: ASWebAuthenticationPresentationContextProviding
    ) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.presentationContext = presentationContext
    }
    
    public func handleOpenURLContext(url: URL) {
        OAuthSwift.handle(url: url)
    }
    
    public func authorize(completion: @escaping (String?, Error?) -> Void) {
        oauth2 = OAuth2Swift(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            authorizeUrl: Constant.authorizeURL,
            accessTokenUrl: Constant.accessTokenURL,
            responseType: Constant.responseType
        )
        oauth2.authorizeURLHandler = ASWebAuthenticationURLHandler(
            callbackUrlScheme: Constant.callbackURL,
            presentationContextProvider: presentationContext
        )
        oauth2.authorize(
            withCallbackURL: URL(string: Constant.callbackURL)!,
            scope: "gist",
            state: generateState(withLength: 20)) { result in
                switch result {
                case .success(let (credential, _, _)):
                    completion(credential.oauthToken, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
