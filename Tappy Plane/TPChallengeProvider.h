//
//  TPChallengeProvider.h
//  Tappy Plane
//
//  Created by J Hastwell on 22/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPChallengeItem : NSObject

@property (nonatomic) NSString *obstacleKey;
@property (nonatomic) CGPoint position;

+ (instancetype)challengeItemWithKey:(NSString*)key andPosition:(CGPoint)position;

@end



@interface TPChallengeProvider : NSObject

+ (instancetype)getProvider;
- (NSArray*)getRandomChallenge;

@end
