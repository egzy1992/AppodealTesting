//
//  GameShowViewController.h
//  AppodealTesting
//
//  Created by Admin on 29.07.17.
//  Copyright © 2017 appodeal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameShowViewController : UIViewController
    

@property (weak, nonatomic) IBOutlet UILabel *gameShowName;
@property (weak, nonatomic) IBOutlet UILabel *gameShowRateLable;
@property (weak, nonatomic) IBOutlet UILabel *gameShowRate;
@property (weak, nonatomic) IBOutlet UIImageView *gameShowCover;
@property (weak, nonatomic) IBOutlet UITextView *gameShowText;
@property (weak, nonatomic) IBOutlet UIImageView *gameShowScreen;

    @property (strong, nonatomic) NSNumber *gameId;

    
@end
