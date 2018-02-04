//
//  PeripheralManager.m
//  BLEManager
//
//  Created by Hassan Shahbazi on 6/25/17.
//  Copyright © 2017 Hassan Shahbazi. All rights reserved.
//

#import "PeripheralManager.h"

@interface PeripheralManager()
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) CBMutableService *bluetoothService;
@end

@implementation PeripheralManager

- (id)init {
    self = [super init];
    if (self) {
        _peripheralManager = [[CBPeripheralManager alloc]  initWithDelegate:self queue:nil];
    }
    return self;
}

+ (PeripheralManager *)SharedInstance {
    static PeripheralManager *singleton = nil;
    if (!singleton) {
        singleton = [PeripheralManager new];
    }
    return singleton;
}

- (void)StartAdvertising {
    _bluetoothService = [[CBMutableService alloc] initWithType:_ServiceUUID primary:YES];
    NSMutableArray *characteristics = [[NSMutableArray alloc] init];
    for (Characteristic *characteristic in _ServiceCharacteristics) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:[self ConvertStringToBase64:characteristic.Value]
                                                           options:NSDataBase64DecodingIgnoreUnknownCharacters];
        CBMutableCharacteristic *characteristicOBJ = [[CBMutableCharacteristic alloc]
                                                initWithType: characteristic.UUID
                                                properties: CBCharacteristicPropertyRead
                                                value: data
                                                permissions: characteristic.Attribute];
        [characteristics addObject:characteristicOBJ];
    }
    _bluetoothService.characteristics = characteristics;
    [_peripheralManager addService:_bluetoothService];
}

- (NSString *)ConvertStringToBase64:(NSString *)plain {
    NSData *plainData = [plain dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:kNilOptions];
    return base64String;
}

#pragma mark - Peripheral Manager Delegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    [_delegate PeripheralStateChanged:peripheral.state];
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error {
    if (error != nil) {
        if ([_delegate respondsToSelector:@selector(Error:)])
            [_delegate Error:error];
    }
    else
        [_peripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey: _LocalName,
                                               CBAdvertisementDataServiceUUIDsKey: @[service.UUID]}];
}
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
    if (error != nil) {
        if ([_delegate respondsToSelector:@selector(Error:)])
            [_delegate Error:error];
    }
    else
        [_delegate PeripheralStartAdvertising];
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary<NSString *,id> *)dict {
    
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request {
    
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    
}
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral {
    
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic {
    
}
@end

@implementation Characteristic

@end
