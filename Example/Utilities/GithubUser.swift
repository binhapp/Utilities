//
//  GithubUser.swift
//
//  Created by blcsntb on 4/9/17
//  Copyright (c) BLCS. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct GithubUser {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let publicRepos = "public_repos"
    static let organizationsUrl = "organizations_url"
    static let reposUrl = "repos_url"
    static let starredUrl = "starred_url"
    static let type = "type"
    static let bio = "bio"
    static let gistsUrl = "gists_url"
    static let followersUrl = "followers_url"
    static let id = "id"
    static let blog = "blog"
    static let followers = "followers"
    static let following = "following"
    static let company = "company"
    static let url = "url"
    static let name = "name"
    static let updatedAt = "updated_at"
    static let publicGists = "public_gists"
    static let siteAdmin = "site_admin"
    static let email = "email"
    static let gravatarId = "gravatar_id"
    static let htmlUrl = "html_url"
    static let avatarUrl = "avatar_url"
    static let login = "login"
    static let location = "location"
    static let createdAt = "created_at"
    static let subscriptionsUrl = "subscriptions_url"
    static let followingUrl = "following_url"
    static let receivedEventsUrl = "received_events_url"
    static let eventsUrl = "events_url"
  }

  // MARK: Properties
  public var publicRepos: Int?
  public var organizationsUrl: String?
  public var reposUrl: String?
  public var starredUrl: String?
  public var type: String?
  public var bio: String?
  public var gistsUrl: String?
  public var followersUrl: String?
  public var id: Int?
  public var blog: String?
  public var followers: Int?
  public var following: Int?
  public var company: String?
  public var url: String?
  public var name: String?
  public var updatedAt: String?
  public var publicGists: Int?
  public var siteAdmin: Bool? = false
  public var email: String?
  public var gravatarId: String?
  public var htmlUrl: String?
  public var avatarUrl: String?
  public var login: String?
  public var location: String?
  public var createdAt: String?
  public var subscriptionsUrl: String?
  public var followingUrl: String?
  public var receivedEventsUrl: String?
  public var eventsUrl: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public init(json: JSON) {
    publicRepos = json[SerializationKeys.publicRepos].int
    organizationsUrl = json[SerializationKeys.organizationsUrl].string
    reposUrl = json[SerializationKeys.reposUrl].string
    starredUrl = json[SerializationKeys.starredUrl].string
    type = json[SerializationKeys.type].string
    bio = json[SerializationKeys.bio].string
    gistsUrl = json[SerializationKeys.gistsUrl].string
    followersUrl = json[SerializationKeys.followersUrl].string
    id = json[SerializationKeys.id].int
    blog = json[SerializationKeys.blog].string
    followers = json[SerializationKeys.followers].int
    following = json[SerializationKeys.following].int
    company = json[SerializationKeys.company].string
    url = json[SerializationKeys.url].string
    name = json[SerializationKeys.name].string
    updatedAt = json[SerializationKeys.updatedAt].string
    publicGists = json[SerializationKeys.publicGists].int
    siteAdmin = json[SerializationKeys.siteAdmin].boolValue
    email = json[SerializationKeys.email].string
    gravatarId = json[SerializationKeys.gravatarId].string
    htmlUrl = json[SerializationKeys.htmlUrl].string
    avatarUrl = json[SerializationKeys.avatarUrl].string
    login = json[SerializationKeys.login].string
    location = json[SerializationKeys.location].string
    createdAt = json[SerializationKeys.createdAt].string
    subscriptionsUrl = json[SerializationKeys.subscriptionsUrl].string
    followingUrl = json[SerializationKeys.followingUrl].string
    receivedEventsUrl = json[SerializationKeys.receivedEventsUrl].string
    eventsUrl = json[SerializationKeys.eventsUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = publicRepos { dictionary[SerializationKeys.publicRepos] = value }
    if let value = organizationsUrl { dictionary[SerializationKeys.organizationsUrl] = value }
    if let value = reposUrl { dictionary[SerializationKeys.reposUrl] = value }
    if let value = starredUrl { dictionary[SerializationKeys.starredUrl] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = bio { dictionary[SerializationKeys.bio] = value }
    if let value = gistsUrl { dictionary[SerializationKeys.gistsUrl] = value }
    if let value = followersUrl { dictionary[SerializationKeys.followersUrl] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = blog { dictionary[SerializationKeys.blog] = value }
    if let value = followers { dictionary[SerializationKeys.followers] = value }
    if let value = following { dictionary[SerializationKeys.following] = value }
    if let value = company { dictionary[SerializationKeys.company] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = publicGists { dictionary[SerializationKeys.publicGists] = value }
    dictionary[SerializationKeys.siteAdmin] = siteAdmin
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = gravatarId { dictionary[SerializationKeys.gravatarId] = value }
    if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
    if let value = avatarUrl { dictionary[SerializationKeys.avatarUrl] = value }
    if let value = login { dictionary[SerializationKeys.login] = value }
    if let value = location { dictionary[SerializationKeys.location] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = subscriptionsUrl { dictionary[SerializationKeys.subscriptionsUrl] = value }
    if let value = followingUrl { dictionary[SerializationKeys.followingUrl] = value }
    if let value = receivedEventsUrl { dictionary[SerializationKeys.receivedEventsUrl] = value }
    if let value = eventsUrl { dictionary[SerializationKeys.eventsUrl] = value }
    return dictionary
  }

}
