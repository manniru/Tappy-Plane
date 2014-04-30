//
//  TPBitmapFontLabel.h
//  Tappy Plane
//
//  Created by J Hastwell on 30/04/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TPBitmapFontLabel : SKNode

@property (nonatomic) NSString* fontName;
@property (nonatomic) NSString* text;
@property (nonatomic) CGFloat letterSpacing;

-(instancetype)initWithText:(NSString*)text andFontName:(NSString*)fontName;

@end
