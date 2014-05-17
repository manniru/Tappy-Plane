//
//  TPTilesetTextureProvider.h
//  Tappy Plane
//
//  Created by J Hastwell on 2/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface TPTilesetTextureProvider : NSObject

@property (nonatomic) NSString *currentTilesetName;

+(instancetype)getProvider;

-(void)randomizeTileset;
-(SKTexture*)getTextureForKey:(NSString*)key;


@end
