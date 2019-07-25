//
//  DetailViewController.h
//  WebViewUATest
//
//  Created by 周 軼飛 on 2019/07/24.
//  Copyright © 2019 F.O.X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *ua;
@property (assign, nonatomic) NSInteger pattern;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

