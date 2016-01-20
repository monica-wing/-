//
//  ViewController.h
//  AD_BL
//
//  Created by 3013 on 14-6-5.
//  Copyright (c) 2014年 com.aidian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TRANSFER_SERVICE_UUID           @"FFF0"
#define TRANSFER_CHARACTERISTIC_UUID_1    @"FFF1"
#define TRANSFER_CHARACTERISTIC_UUID_4    @"FFF4"
#define TRANSFER_CHARACTERISTIC_UUID_6    @"FFF6"


@interface ViewController : UIViewController{
    UIButton *mainBtn;
    BOOL isLightOpen;
    
    
}

@property (retain, nonatomic) CBCharacteristic *discoveredCharacteristic;

@property (strong,nonatomic)CBPeripheral * peripheralOpration;

@end
