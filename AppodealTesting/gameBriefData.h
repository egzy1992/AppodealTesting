//
//  GameBriefData.h
//  AppodealTesting
//
//  Created by Admin on 29.07.17.
//  Copyright © 2017 appodeal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameBriefData : NSObject
    @property (nonatomic, retain) NSString* gameName;
    @property (nonatomic, retain) UIImage* gameImg;
    @property (nonatomic, retain) NSMutableString* gameImgUrl;
    @property (nonatomic, retain) NSNumber* gameId;
@end
