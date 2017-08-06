//
//  GameShowViewController.m
//  AppodealTesting
//
//  Created by Admin on 29.07.17.
//  Copyright © 2017 appodeal. All rights reserved.
//

#import "GameShowViewController.h"
#import "UNIRest.h"
#import "igdbAPIConnection.h"
#import "JMImageCache.h"
#import "FBNetworkReachability.h"

//Почему выбрано такое объявление переменных
@interface GameShowViewController ()
{
    NSArray *infoGame;
    NSDictionary* headers;
}

@end

@implementation GameShowViewController

-(void)putDataIntoScreen{
    //При выключении интернета приложение крэшится
    self.gameShowName.text=infoGame[0][@"name"];
    int Rate=[infoGame[0][@"rating"] intValue];
    NSNumber *rateNumber=[[NSNumber alloc] initWithInt:Rate];
    self.gameShowRate.text=[rateNumber stringValue];
    self.gameShowText.text=infoGame[0][@"summary"];
    NSMutableString *gameImgUrl=[[NSMutableString alloc] initWithString:[[NSMutableString alloc] initWithString:@"https:"]];
    gameImgUrl=[[NSMutableString alloc] initWithString:[gameImgUrl stringByAppendingString:infoGame[0][@"cover"][@"url"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:gameImgUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                self.gameShowCover.image = [UIImage imageWithData:data];
                
            }] resume];

    //NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString: gameImgUrl]];
    //self.gameShowCover.image=[UIImage imageWithData:data];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self getGameInfo];
    
    // Do any additional setup after loading the view.
    
    
    FBNetworkReachabilityConnectionMode mode = [FBNetworkReachability sharedInstance].connectionMode;
    if (mode!=FBNetworkReachableNon)
    {
        
        igdbAPIConnection *newIGDBconnection=[[igdbAPIConnection alloc] init];
        infoGame=[newIGDBconnection getGameInfo:_gameId];
        [self putDataIntoScreen];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Network problems! Connect to the internet, please!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
