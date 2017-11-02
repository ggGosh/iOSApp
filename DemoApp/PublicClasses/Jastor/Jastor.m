#import "Jastor.h"
#import "JastorRuntimeHelper.h"

@implementation Jastor

@synthesize objectId;
static NSString *idPropertyName = @"id";
static NSString *idPropertyNameOnObject = @"objectId";

Class nsDictionaryClass;
Class nsArrayClass;

+ (id)objectFromDictionary:(NSDictionary*)dictionary {
    id item = [[self alloc] initWithDictionary:dictionary];
    return item;
}

+ (NSArray *)modelsOfClassFromJSONArray:(NSArray *)JSONArray{
    if (JSONArray.count == 0) {
        return nil;
    }
    
    NSMutableArray *returnMutableArray = [[NSMutableArray alloc] init];
    for (id obj in JSONArray) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            id model = [[self class] objectFromDictionary:obj];
            if (model){
                [returnMutableArray addObject:model];
            }
        }
    }
    return returnMutableArray;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
	if (!nsArrayClass) nsArrayClass = [NSArray class];

	if ((self = [self init])) {
        NSArray *propertNames = [JastorRuntimeHelper propertyNames:[self class]];
        NSDictionary *map = [self map:propertNames];
		for (NSString *key in propertNames) {
            
            // json model.description -> model.desc
            if ([key isEqualToString:@"desc"] && ![dictionary objectForKey:@"desc"]) {  // model中有desc && json中没有desc
                id description = [dictionary objectForKey:@"description"];
                if (description) [self setValue:description forKey:@"desc"];
            }
            
			id value = [dictionary valueForKey:[map valueForKey:key]];
			if (value == [NSNull null] || value == nil) {// || [value isEqual:@""] 防止字符串为null的问题
                continue;
            }
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			
			// handle dictionary
			if ([value isKindOfClass:nsDictionaryClass]) {
				Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
                if ([klass instancesRespondToSelector:@selector(initWithDictionary:)]) {
                    value = [[klass alloc] initWithDictionary:value];
                }
//                NSAssert1([klass instancesRespondToSelector:@selector(initWithDictionary:)], @"%@属性 请继承于Jastor", key);
			}
			// handle array
			else if ([value isKindOfClass:nsArrayClass]) {
				
				NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
				
				for (id child in value) {
                    if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
                        NSString *selectorString = [NSString stringWithFormat:@"%@_class", key];
                        SEL selector = NSSelectorFromString(selectorString);
//                        NSAssert1([[self class] respondsToSelector:selector], @"请重载%@方法", selectorString);
                        
                        if ([[self class] respondsToSelector:selector]) {
                            Class arrayItemType = [[self class] performSelector:selector];
                            if ([arrayItemType isSubclassOfClass:[NSDictionary class]]) {
                                [childObjects addObject:child];
                            } else if ([arrayItemType isSubclassOfClass:[Jastor class]]) {
                                Jastor *childDTO = [[arrayItemType alloc] initWithDictionary:child];
                                [childObjects addObject:childDTO];
                            }

                        }else {
                            [childObjects addObject:child];
                        }
                        
                    } else {
						[childObjects addObject:child];
					}
				}
				
				value = childObjects;
            }
            
            NSString* propertyType = [JastorRuntimeHelper propertyTypeForPropertyName:key ofClass:[self class]];
            
            if([value isKindOfClass:NSClassFromString(propertyType)]){
                // handle all others
                [self setValue:value forKey:key];
            }else if([value isKindOfClass:[NSNumber class]]){//BOOL 也
                if([@"test" isKindOfClass:NSClassFromString(propertyType)]){
                    //HJLog(@"值是个int 定义的是字符串");

                    if([propertyType isEqualToString:@"char"]){//bool 有些系统不支持
                        [self setValue:@([value charValue]) forKey:key];
                    }else{
                        [self setValue:[value stringValue] forKey:key];
                    }

                }else if(!NSClassFromString(propertyType)){
                    [self setValue:value forKey:key];
                }else if([NSObject isKindOfClass:NSClassFromString(propertyType)]){//对象
                    [self setValue:nil forKey:key];
                    //HJLog(@"给个空对象错误过滤  klass:%@,key:%@,propertyType2:%@",propertyType,key,[value class]);
                }
            }else if([value isKindOfClass:[NSString class]]){
                // handle all others
                if(!NSClassFromString(propertyType)){
                    if([propertyType isEqualToString:@"char"]){//bool
                        [self setValue:@([value integerValue]) forKey:key];
                    }else{
                        [self setValue:value  forKey:key];
                    }
                }else if([NSObject isKindOfClass:NSClassFromString(propertyType)]){//对象
                    [self setValue:nil forKey:key];
                }
            }else{
                NSLog(@"错误过滤  klass:%@,key:%@,propertyType2:%@",propertyType,key,[value class]);
            }
            
            
        }


		id objectIdValue;
		if (([dictionary isKindOfClass:[NSDictionary class]]) && (objectIdValue = [dictionary objectForKey:idPropertyName]) && objectIdValue != [NSNull null]) {
			if (![objectIdValue isKindOfClass:[NSString class]]) {
				objectIdValue = [NSString stringWithFormat:@"%@", objectIdValue];
			}
			[self setValue:objectIdValue forKey:idPropertyNameOnObject];
		}
	}
	return self;	
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)dealloc {
	self.objectId = nil;
	
//	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
//		//[self setValue:nil forKey:key];
//	}
}

- (void)encodeWithCoder:(NSCoder*)encoder {
	[encoder encodeObject:self.objectId forKey:idPropertyNameOnObject];
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		[encoder encodeObject:[self valueForKey:key] forKey:key];
	}
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		[self setValue:[decoder decodeObjectForKey:idPropertyNameOnObject] forKey:idPropertyNameOnObject];
		
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			id value = [decoder decodeObjectForKey:key];
			if (value != [NSNull null] && value != nil) {
				[self setValue:value forKey:key];
			}
		}
	}
	return self;
}

- (NSMutableDictionary *)toDictionary {
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.objectId) {
        [dic setObject:self.objectId forKey:idPropertyName];
    }
	
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		id value = [self valueForKey:key];
        if (value && [value isKindOfClass:[Jastor class]]) {
			[dic setObject:[value toDictionary] forKey:[[self map] valueForKey:key]];
        } else if (value && [value isKindOfClass:[NSArray class]] && ((NSArray*)value).count > 0) {
            id internalValue = [value objectAtIndex:0];
            if (internalValue && [internalValue isKindOfClass:[Jastor class]]) {
                NSMutableArray *internalItems = [NSMutableArray array];
                for (id item in value) {
                    [internalItems addObject:[item toDictionary]];
                }
				[dic setObject:internalItems forKey:[[self map] valueForKey:key]];
            } else {
				[dic setObject:value forKey:[[self map] valueForKey:key]];
            }
        } else if (value != nil) {
			[dic setObject:value forKey:[[self map] valueForKey:key]];
        }
	}
    return dic;
}

- (NSDictionary *)map {
	NSArray *properties = [JastorRuntimeHelper propertyNames:[self class]];
    return [self map:properties];
}

- (NSDictionary *)map:(NSArray *)properties {
    NSMutableDictionary *mapDictionary = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
    for (NSString *property in properties) {
        [mapDictionary setObject:property forKey:property];
    }
    return [NSDictionary dictionaryWithDictionary:mapDictionary];
}

- (NSString *)description {
    NSMutableDictionary *dic = [self toDictionary];
	
	return [NSString stringWithFormat:@"#<%@: id = %@ %@>", [self class], self.objectId, [dic description]];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy)
    {
        for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            id value = [self valueForKey:key];
            [copy setValue:value forKey:key];
        }
    }
    
    return copy;
}
@end
