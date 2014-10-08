//
//  ViewController.h
//  flyck
//
//  Created by EndoTsuyoshi on 2014/10/04.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomisedMDCSwipeToChooseView.h"

#import "REMenu.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "NADView.h"

@interface ViewController : UIViewController
<MDCSwipeToChooseDelegate,
NADViewDelegate>
@property (strong, readonly, nonatomic) REMenu *topMenu;

@end

