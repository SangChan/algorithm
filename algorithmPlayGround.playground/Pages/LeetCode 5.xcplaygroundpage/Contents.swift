//: [Previous](@previous)

import Foundation

class Twitter {
    
    private var _tweets : [Int:Set<Int>] = [:]
    private var _followers : [Int: Set<Int>] = [:]
    private var _news : [Int] = []
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Compose a new tweet. */
    func postTweet(_ userId: Int, _ tweetId: Int) {
        if var tweet = _tweets[userId] {
            tweet.insert(tweetId)
            _tweets[userId] = tweet
        } else {
            _tweets[userId] = [tweetId]
        }
        _news.append(tweetId)
    }
    
    /** Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent. */
    func getNewsFeed(_ userId: Int) -> [Int] {
        var newsfeed : [Int] = []
        _news.reversed().forEach { tweetId in
            if newsfeed.count >= 10 { return }
            if let _ = _tweets[userId]?.firstIndex(of: tweetId) {
                newsfeed.append(tweetId)
            } else if let follwers = _followers[userId] {
                follwers.map { follower in
                    if let _ = _tweets[follower]?.firstIndex(of: tweetId) {
                        newsfeed.append(tweetId)
                    }
                }
            }
            
        }
        
        return newsfeed
    }
    
    /** Follower follows a followee. If the operation is invalid, it should be a no-op. */
    func follow(_ followerId: Int, _ followeeId: Int) {
        if var follower = _followers[followerId] {
            follower.insert(followeeId)
            _followers[followerId] = follower
        } else {
            _followers[followerId] = [followeeId]
        }
    }
    
    /** Follower unfollows a followee. If the operation is invalid, it should be a no-op. */
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        if var follower = _followers[followerId] {
            if let index = follower.firstIndex(of: followeeId) {
                follower.remove(at: index)
                _followers[followerId] = follower
            }
        }
    }
}


//let obj = Twitter()
//obj.postTweet(1, 5)
//let ret_1: [Int] = obj.getNewsFeed(1)
//print("ret_1 = \(ret_1)")
//obj.follow(1, 2)
//obj.postTweet(2, 6)
//let ret_2: [Int] = obj.getNewsFeed(1)
//print("ret_2 = \(ret_2)")
//obj.unfollow(1, 2)
//let ret_3: [Int] = obj.getNewsFeed(1)
//print("ret_3 = \(ret_3)")

let obj = Twitter()
obj.postTweet(1, 5)
obj.postTweet(1, 3)
let ret_1: [Int] = obj.getNewsFeed(1)
print("ret_1 = \(ret_1)")
