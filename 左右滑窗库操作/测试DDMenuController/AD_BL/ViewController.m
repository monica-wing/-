//
//  ViewController.m
//  AD_BL
//
//  Created by 3013 on 14-6-5.
//  Copyright (c) 2014年 com.aidian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    BOOL canSendMes;
    UILabel *lightIp;
    UILabel *lightName;
    UILabel *numberStr;
    NSMutableDictionary *openDic;
    CBCharacteristic * peripheralGroupTem;
}

@end

@implementation ViewController

@synthesize discoveredCharacteristic;
@synthesize peripheralOpration;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"新建的");
    
    self.title = @"Light";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 568)];
    [backgroundView setImage:[UIImage imageNamed:@"main_bg"]];
    [self.view addSubview:backgroundView];
    
    
    mainBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [mainBtn setFrame:CGRectMake(70, 84, 180, 180)];
    [mainBtn setBackgroundImage:[UIImage imageNamed:@"power_off"] forState:UIControlStateNormal];
    [mainBtn addTarget:self action:@selector(openLight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mainBtn];
    
    UIImageView *downImage=[[UIImageView alloc]initWithFrame:CGRectMake(110, 284, 100, 100)];
    [downImage setImage:[UIImage imageNamed:@"light_pl"]];
    [self.view addSubview:downImage];
    
    
    //亮度值label
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    numberStr= [[UILabel alloc] initWithFrame:CGRectMake(20, 20, downImage.frame.size.width-40, 30)];
    numberStr.text=[userDefaults objectForKey:@"brigness"];
    numberStr.text=@"6%";
    numberStr.font =[UIFont systemFontOfSize:26];
    numberStr.backgroundColor=[UIColor clearColor];
    numberStr.textColor =[UIColor colorWithRed:0.0 green:0.9 blue:0.9 alpha:1.0];
    numberStr.textAlignment = NSTextAlignmentCenter;
    [downImage addSubview:numberStr];
    
    //灯泡名称信息label
    lightName= [[UILabel alloc] initWithFrame:CGRectMake(20, 50, downImage.frame.size.width-40, 15)];
    lightName.text=@"Untitled";
    lightName.font =[UIFont systemFontOfSize:10];
    lightName.backgroundColor=[UIColor clearColor];
    lightName.textColor =[UIColor whiteColor];
    lightName.textAlignment = NSTextAlignmentCenter;
    [downImage addSubview:lightName];
    
    //设备ip地址
    lightIp= [[UILabel alloc] initWithFrame:CGRectMake(20, 65, downImage.frame.size.width-40, 10)];
    lightIp.text=[userDefaults objectForKey:@"IP"];
    lightIp.text=@"192.168.1.20";
    lightIp.textColor =[UIColor whiteColor];
    lightIp.backgroundColor= [UIColor clearColor];
    lightIp.font =[UIFont fontWithName:@"HelveticaNeue" size:8];
    lightIp.textAlignment = NSTextAlignmentCenter;
    [downImage addSubview:lightIp];
    

    openDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    
}
-(void)awakeFromNib{
    NSLog(@"awakeFromNib");
    //注册消息通知
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(update:) name:@"peripheralOpration" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(updateColorAndBrght:) name:@"ColorAndBrght" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(updateColorAndBrght:) name:@"NewColorAndBrght" object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_cfg"] style:UIBarButtonItemStylePlain target:self action:@selector(SettingAction)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
}
-(void)updateColorAndBrght:(NSNotification*) notification{
    if (self.peripheralOpration==nil&&[openDic count]==0) {
        return;
    }
    if ([openDic count]==0) {
        canSendMes=NO;
        for (CBCharacteristic *characteristic in [[self.peripheralOpration.services objectAtIndex:1] characteristics])
        {
            //定制特性4，以收取外围设备发过来的数据
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_4]])
            {
                [self.peripheralOpration setNotifyValue:YES forCharacteristic:characteristic];
            }
            
            if([[notification name] isEqualToString:@"NewColorAndBrght"]){
                //保留找到的特性1
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_6]])
                {
                    
                    self.discoveredCharacteristic=characteristic;
                    canSendMes=YES;
                    
                }
            }else{
                //保留找到的特性1
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_1]])
                {
                    
                    self.discoveredCharacteristic=characteristic;
                    canSendMes=YES;
                    
                }
            }
            
            
        }
        
        if (!canSendMes) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"未能找到能发送命令的特性" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        
        [self.peripheralOpration writeValue:[[notification userInfo] objectForKey:@"tempData"] forCharacteristic:self.discoveredCharacteristic type:CBCharacteristicWriteWithResponse];
        
        
    }else{
        canSendMes=NO;
        isLightOpen=!isLightOpen;
        for (int i=0 ;i<[[openDic objectForKey:@"DataArray"] count] ; i++) {
            CBPeripheral *peripheral=[[openDic objectForKey:@"DataArray"] objectAtIndex:i];
            
            for (CBCharacteristic *characteristic in [[peripheral.services objectAtIndex:1] characteristics])
            {
                //定制特性4，以收取外围设备发过来的数据
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_4]])
                {
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                }
                //保留找到的特性1
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_1]])
                {
                    peripheralGroupTem=characteristic;
                    canSendMes=YES;
                }else{
                    //                    NSLog(@"characteristic.UUID:%@",characteristic.UUID);
                }
            }
            
            if (!canSendMes) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"未能找到能发送命令的特性" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [alert show];
                return;
            }
            
            [peripheral writeValue:[[notification userInfo] objectForKey:@"tempData"] forCharacteristic:peripheralGroupTem type:CBCharacteristicWriteWithResponse];
            
            
        }
        
    }
    
}


//通知响应方法
-(void)update:(NSNotification*) notification{
   
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([notification object]!=nil){ //  如果是单个灯
        self.peripheralOpration=[notification object];
        
        lightIp.text=[self.peripheralOpration.identifier UUIDString];
        lightName.text=self.peripheralOpration.name;
        [openDic removeAllObjects];
        
//        NSDictionary *BluetoothDic=[[NSDictionary alloc]initWithObjectsAndKeys:[self.peripheralOpration.identifier UUIDString],@"UUID",self.peripheralOpration.name,@"name",nil];
//        [userDefaults setObject:BluetoothDic forKey:@"peripheralOpration"];
//        [userDefaults setObject:BluetoothDic forKey:@"connectLight"];
//        [userDefaults synchronize];
        
        
    }else{//如果是一个群组
        openDic=[NSMutableDictionary dictionaryWithDictionary:[notification userInfo]];
        NSLog(@"openDic:%@",openDic);
    }
}

-(void)openLight{
    
    if (self.peripheralOpration==nil&&[openDic count]==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"没有选择操作的对象" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([openDic count]==0) {
       
        
        
        
        canSendMes=NO;
        
        for (CBCharacteristic *characteristic in [[self.peripheralOpration.services objectAtIndex:1] characteristics])
        {
            //定制特性4，以收取外围设备发过来的数据
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_4]])
            {
                [self.peripheralOpration setNotifyValue:YES forCharacteristic:characteristic];
            }
            
            
            
            //保留找到的特性1
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_1]])
            {
                self.discoveredCharacteristic=characteristic;
                canSendMes=YES;
                
                
                
                [self.peripheralOpration readValueForCharacteristic:characteristic];
                NSLog(@"读取特性内容");
            }else{
//                NSLog(@"characteristic.UUID:%@",characteristic.UUID);
            }
        }
        
        if (!canSendMes) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"未能找到能发送命令的特性" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        isLightOpen=!isLightOpen;
        if (isLightOpen) {
            NSLog(@"开灯");
            [mainBtn setBackgroundImage:[UIImage imageNamed:@"power_on"] forState:UIControlStateNormal];
            char strcommand[9]={'s','*','*','*','*','*','1','e'};
            strcommand[6]=2;
            NSData *cmdData = [NSData dataWithBytes:strcommand length:9];
            [self.peripheralOpration writeValue:cmdData forCharacteristic:self.discoveredCharacteristic type:CBCharacteristicWriteWithResponse];
            
        }else{
            NSLog(@"关灯");
            [mainBtn setBackgroundImage:[UIImage imageNamed:@"power_off"] forState:UIControlStateNormal];
            char strcommand[9]={'s','*','*','*','*','*','1','e'};
            strcommand[6]=1;
            NSData *cmdData = [NSData dataWithBytes:strcommand length:9];
            [self.peripheralOpration writeValue:cmdData forCharacteristic:self.discoveredCharacteristic type:CBCharacteristicWriteWithResponse];
        }
    }else{
        canSendMes=NO;
        isLightOpen=!isLightOpen;
        for (int i=0 ;i<[[openDic objectForKey:@"DataArray"] count] ; i++) {
            CBPeripheral *peripheral=[[openDic objectForKey:@"DataArray"] objectAtIndex:i];
            NSLog(@"peripheral.services:%@",peripheral.services);
            for (CBCharacteristic *characteristic in [[peripheral.services objectAtIndex:1] characteristics])
            {
                //定制特性4，以收取外围设备发过来的数据
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_4]])
                {
                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                }
                //保留找到的特性1
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID_1]])
                {
                    peripheralGroupTem=characteristic;
                    canSendMes=YES;
                }else{
                    //                    NSLog(@"characteristic.UUID:%@",characteristic.UUID);
                }
            }
            
            if (!canSendMes) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"未能找到能发送命令的特性" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [alert show];
                return;
            }
            
            
            if (isLightOpen) {
                [mainBtn setBackgroundImage:[UIImage imageNamed:@"power_on"] forState:UIControlStateNormal];
                char strcommand[9]={'s','*','*','*','*','*','1','e'};
                strcommand[6]=2;
                NSData *cmdData = [NSData dataWithBytes:strcommand length:9];
                [peripheral writeValue:cmdData forCharacteristic:peripheralGroupTem type:CBCharacteristicWriteWithResponse];
                
            }else{
                [mainBtn setBackgroundImage:[UIImage imageNamed:@"power_off"] forState:UIControlStateNormal];
                char strcommand[9]={'s','*','*','*','*','*','1','e'};
                strcommand[6]=1;
                NSData *cmdData = [NSData dataWithBytes:strcommand length:9];
                [peripheral writeValue:cmdData forCharacteristic:peripheralGroupTem type:CBCharacteristicWriteWithResponse];
            }
        }
        
    }
    
}
-(void)SettingAction{
    
    
    
}

@end
