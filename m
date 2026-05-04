Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F80FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 17:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBC710E7D8;
	Mon,  4 May 2026 17:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vmICSO4L";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D53B10E408;
 Mon,  4 May 2026 17:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icz0r5HgjLs56S6+7C+NgyXq1uBo1TRu0yqJO42HuoaelZIbKoPUjOHC/ffJNwiJA74E0bw9s/xY3SFfcEYU/WDfrAJBgRNe/1kEQ58YI836gtHVJzz0SVqVsgHoW126TjETcgf96sfFlxdqshn0W1IjZ8D0bnsX8Vh7IqcYOEVxK3mRnnOAaEuQNbQcqaoF4uGOUqxpecxXf0mQb4FG6+c4UHCf56AwKOsI3g9558qUz8sMNibjiqk+hXWHVlJb/nXZp6yFbWmk41yFQoqnp2gLa4++nvqmoGyDqIZP1sFBysLltx6PJxripNtIkG9TB78R9aHaYVtL+ultEqaszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9I6PI0kxVmzG3Za8AzTPfMVeN9Y4TjFLFh4BGidBYk=;
 b=T8SqGBCxr//lDBF2OOHD1i0igOFu9xyLDgFveNa2yRT24WbFItdnlw1TpWwdAN6Raj9OxdzdFdzNhGgc6+Ejqe+8Tr5owl6Vmh1hY304tJxZ54q6d62YPiCxSqVo6k7K+INuNtLH79RgbmZiFgdv8LhUVoYs/3/VHhy4Iian8A1J39n711kiAi+P5wIubngoAKkYfb1iRcMGlGWG+tbsEID4OMSjg50pcQtokZbfWBfURHsbVN53hkWyYPxFURf5TrjO/IaT575ulw9uRt++B1nizEaadW9DYgOW2Q8yJ9IVjW/qYXsuEzXJ9MuV8KylIjbGUj3EwfmEfOhbGukxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9I6PI0kxVmzG3Za8AzTPfMVeN9Y4TjFLFh4BGidBYk=;
 b=vmICSO4Lmoi5VFm9wOhqyuSKCrdLK99ZgPjnsxbxylA6H7z7eOupYD6i9Q8xUjgamott2E47wGr7nRM3mAzaosXyJTrJoRQQf4dm3ZYShSOWzFIzmwE0BBU9a4XDkczT0poegrn4NW5xiyZpM6cwD2odwiXAUoz191j11ekESow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Mon, 4 May
 2026 17:55:28 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 17:55:28 +0000
Message-ID: <d2e0852e-006d-4d30-b754-7fe597b9b4f0@amd.com>
Date: Mon, 4 May 2026 12:55:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] backlight: add kernel-internal backlight API
Content-Language: en-US
To: Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org
Cc: harry.wentland@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-2-mario.limonciello@amd.com>
 <b1a09658-ff19-4331-a184-b1a5457b7f69@bootlin.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b1a09658-ff19-4331-a184-b1a5457b7f69@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9217da-5160-42fa-146c-08deaa06536c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: hfy9hDXf3QHTFh3tk5kSq+95u3tbXKM1wwTD24VuwLoqUC9QT9jLYrVbGXwduhtXOuFd0cssSYtuVZ0kFE3w5wOBdVlku+0aunMBEN5mArg4mPWWnYpdLy0L/FUPfzmu+baZoX1cc9l+xhBc/B5Mfw3IsWF3PB7+hwuoiXyQv09pVYN2JhdFErb+orYdOYk3f8u+aVcknvAdZyNYdBZ2ekfLNzvE2eBro1/iKId/j83ogyU3qq0S7MVSI29P4M7C1sWIahGXAI3J9SQZPQFXJDPiKAR8exojaDv64+FnyK6sdx4vBHiMuwZW+LVkNwfuEYhiLnjxLJZzyrRn1kQ+56zmABUpRt+O2+OL4Xv8P+vwD20EkQfwwaU06Uz5LIDM/E1mYJKzwlLEA4om22/fLCL4k/qe0VAzF4c+cpuqvgLLN39/VMtReXU6hjWyK/c+8HQU1RCfP2hdpFeaD3CGvp3wvdz9zhm6xn7YUCFZkGwmjfv3qLPHOhy0j5PLDqth8r+YTqxJhsXS3xaqsDaaf8Ip53N3+zsCieTKCKKbWt4obmUxVqrTj7P2dfpPu+qwi4Ghlk8QbFrbt5ZM10a5BE9yAEjvwOyweYNutAmrbijNrwG6XgDIxFray0KtkPEX8KluZEd/SKVcHhoeqBHXWOBqCVkhJNf+eXFqITMZmBMal1Vh+dja79dLHtuo88w9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlQczk3QzRNRVNjWWQvZlVic010ek1ieWJtRXZFUzVGek14VzJab1d4Mit4?=
 =?utf-8?B?VElaN2l0RjNtL0hPbjY0Y0hhYXpYOVJZV09VYUVoNDg3VzUzV0RYOVZLRmxW?=
 =?utf-8?B?WTJHbGhndmV3VmlORGpCR0dmWGZyUGV5bVNNK1R1N1hOWU9WV1hDSGtsMnRH?=
 =?utf-8?B?RnBFTTVPMXl6K29SUThwbWxCSHRaTDVycHlvbFdWZitFQzc1RDhZWm1DODhS?=
 =?utf-8?B?QlpJMFh5M05FaGZVejJ0ZUpoMnZmV1Qwb3ZoUkhtQllyOUMrOENHeER3U1ow?=
 =?utf-8?B?MGZoRzV5OTZiUWtCT0tKbnRCSzhQQmZWaWVsNW01UVE4UzEyalpROU5uZ2JO?=
 =?utf-8?B?SWd4bVFQNzZQbTZDSGtycnNROTh4VG0ycGxEZC8yY0RMeldyUWNEVm1HZHVT?=
 =?utf-8?B?Ny8wN2FPZEI2V2FhMUM3cUxzRXhHTG1jU0lva0FjSHB3U1dwTHU3WnN4TDQv?=
 =?utf-8?B?RDdNVzRWYnpnckxLajMvbUpYL0UyR0lpaWY1NkxiRU1RRGdyQUFweC9JNTQ5?=
 =?utf-8?B?WjF6eStxNFJsT3BCczdhVE1YLzFUaWdyU3JXK2IyZWtZd3RoeUdJWURtcVRw?=
 =?utf-8?B?TUYwL3F2dmNiMXRqTUV0YmxPenVOM2FXMlRSMnJCcmF4cW5GVTlyU3hPN3Zo?=
 =?utf-8?B?eXcrWXNVK0ZvekpoMWh2aWNaNG1qbXJOb01ENWNwOHczc014SkJNNTZEc2dP?=
 =?utf-8?B?V1pzR2EwdlI4bkZCa0dxZEltL0FyL3RnS2dIeVVzSG9rcjJDQUppYjFqVEkr?=
 =?utf-8?B?UUdrRGZGUkgySDQ0NVVFbS94S1hTSFh3ZU5ycnhPNWkwK1hJc2tLbTBsMWdh?=
 =?utf-8?B?bm8wdCthaW1BVGNxUWtoa25vNlBjdjdNckdIbks4Zk1rT1R4ZmU3UmhSQkRj?=
 =?utf-8?B?Z3BSZi83VWpRRkYzS1JBS2F3WkRNYi9xeEIzMWZpSGJnNE1RMWhQNkJEUHUr?=
 =?utf-8?B?Qm4yZDZjc0cyMkh2Q1BtajU4bW9TWTBtc3BxQTF1bFZudUkrZXdhVmlkaCs2?=
 =?utf-8?B?d2dEeTlNdDBMZ3cydi9ZZ2RoOG1kNFE1Q3dMbWVnRDgwejRGSm5rS1hNMWVB?=
 =?utf-8?B?dUtFZkRieU11SFVFMG4vbXhieU1PYUJRR2lUOFY1ZXdwT2RZdGVwanZHTWNX?=
 =?utf-8?B?N3ViSEFvNzM4WTlZYm1RMTVtK3BYd1VsL1pBb2ExV252TG5TMXJxNmEyK2dl?=
 =?utf-8?B?TDZwemtCcys2T1ZXMkdtYlN2SVNTYWE3ZFBOdjI1TWpPMnlVRmNUY2wzMmFS?=
 =?utf-8?B?RTRXSm1SMUc4M0JFNkU5SGNUV1BQYUU3d3FEN241Y1lpbWFwVUsrZythRi9w?=
 =?utf-8?B?SnYyQkxoRURVQ1VVeHJnWGlUWGdhUVY1L1R6NHZUN3ExbldCdGZmMi83elJS?=
 =?utf-8?B?RzMxVEJKWjVJNHlTcm92aTZ3L1lCM3hqaVhrT0UwRVUzeW1VR3VDUWNMWnRp?=
 =?utf-8?B?ZEJ4dDdoL08zQi9EdUxqUjJITFNYb0ttNTVuWmtSTk4vcFNHQnlHakRGaUt2?=
 =?utf-8?B?b0J2ZmFJSDh3dEh0amFsZVJ5d21QSTNseC9xY2wvTDZ1WGI3RnZPVkUxcVda?=
 =?utf-8?B?Q0FOVjhFWWdsdjIwQlV0U0laV2Y5UkNsOXFxdDFxcU1xYnpOQWRNazJPZThJ?=
 =?utf-8?B?ZkQyc3dCeHg5N2pRQXlja0lrc3BqS2R2M3hiWTlscSsvOVd0RnhCQmQ0YjdW?=
 =?utf-8?B?Vnhhc05vSC9ydnU3M3J0MWxTVm9vT3JxNDN1RkxHWlp0Zm5iUGlOZVh1MmZT?=
 =?utf-8?B?b2pTMG5lY1Ixekg3Tk44bzZ1eTF1YmdSMFJNckMzU3NzU3hUMy9OQmF2bDdC?=
 =?utf-8?B?eUVOOXUvVlBLYTYvY3dzYk9jTFFwVkdnaFBpS1dEQ1NTbTBQUkNETEJaOFFT?=
 =?utf-8?B?Z2pHczdlY0xINExFaWR1ZjF1OHdOaDV6MFh2SVMySE9reVRZeHV0TFhVb25O?=
 =?utf-8?B?MTRhM3kzaUFWaFFwbUFlcnFwVzBLTnZSVXRhQ1JwRGxIbW41SktLZjZYNm9T?=
 =?utf-8?B?Y2dDZnZsVmEvcnp5Wm50SUt0UVZpbXVKb1hDa2xVWndDQ01TeWNJZUx6VlBJ?=
 =?utf-8?B?bHNjalVwdU1wd3hUbFVzd1Fub1NOdCtqc2tpNTZvNUpIU2h6RkhXcDllVzBo?=
 =?utf-8?B?VkliMGRUUU0ySXYwbGE2U2NZR09sUXdEcVNKZjY0VXUxVWNCMDNLbmJzYnJl?=
 =?utf-8?B?QUgrU29RTm92WVo5MTNjMjYzOVBpVGpQTllyb1VETkpXZWxLVU03SG1EbWFo?=
 =?utf-8?B?TzRWNEF2U1dHR0Q1alQzTjJxVVAyYU5mMXdkYTRoNUlvd2xoTkRZUTVrem5V?=
 =?utf-8?Q?gM2O543ht7ccKfmkcs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9217da-5160-42fa-146c-08deaa06536c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 17:55:28.0166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cp/09OGy6FIjmNkl9nJZRA6C9lCqxDvIhx3SBSsrgOziQsh0Pq7iXzMk7MGyRZ2TUdGJ8+tTpKm2yz1VCZdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 5/4/26 08:55, Louis Chauvet wrote:
> [You don't often get email from louis.chauvet@bootlin.com. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 4/25/26 00:09, Mario Limonciello wrote:
>> From: David Herrmann <dh.herrmann@gmail.com>
>>
>> So far backlights have only been controlled via sysfs. However, sysfs is
>> not a proper user-space API for runtime modifications, and never was
>> intended to provide such. The DRM drivers are now prepared to provide
>> such a backlight link so user-space can control backlight via DRM
>> connector properties. This allows us to employ the same access-management
>> we use for mode-setting.
>>
>> This patch adds few kernel-internal backlight helpers so we can modify
>> backlights from within DRM.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>>
>> V2: Marta Lofstedt <marta.lofstedt@intel.com>
>> - rebase
>> - minor edit for checkpatch warning
>>
>> Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>
>>
>> V3: Mario Limonciello <mario.limonciello@amd.com>
>>   - rebase
>>   - Use guard(mutex)
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/video/backlight/backlight.c | 60 +++++++++++++++++++++++++++++
>>   include/linux/backlight.h           | 16 ++++++++
>>   2 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/ 
>> backlight/backlight.c
>> index ab87a5e3dbf70..c3673bee6d9cf 100644
>> --- a/drivers/video/backlight/backlight.c
>> +++ b/drivers/video/backlight/backlight.c
>> @@ -513,6 +513,66 @@ static int devm_backlight_device_match(struct 
>> device *dev, void *res,
>>       return *r == data;
>>   }
>>
>> +/**
>> + * backlight_device_lookup - find a backlight device
>> + * @name: sysname of the backlight device
>> + *
>> + * @return Reference to the backlight device, NULL if not found.
>> + *
>> + * This searches through all registered backlight devices for a 
>> device with the
>> + * given device name. In case none is found, NULL is returned, 
>> otherwise a
>> + * new reference to the backlight device is returned. You must drop this
>> + * reference via backlight_device_unref() once done.
>> + * Note that the devices might get unregistered at any time. You need 
>> to lock
>> + * around this lookup and inside of your backlight-notifier if you 
>> need to know
>> + * when a device gets unregistered.
>> + *
>> + * This function can be safely called from IRQ context.
>> + */
>> +struct backlight_device *backlight_device_lookup(const char *name)
>> +{
>> +     struct backlight_device *bd;
>> +     const char *t;
>> +
>> +     guard(mutex)(&backlight_dev_list_mutex);
>> +     list_for_each_entry(bd, &backlight_dev_list, entry) {
>> +             t = dev_name(&bd->dev);
>> +             if (t && !strcmp(t, name)) {
>> +                     backlight_device_ref(bd);
>> +                     return bd;
>> +             }
>> +     }
>> +
>> +     return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(backlight_device_lookup);
>>
> 
> Hello,
> 
> I think this function can be repalced with backlight_device_get_by_name.

Yes; good call.

> 
>> +/**
>> + * backlight_set_brightness - set brightness on a backlight device
>> + * @bd: backlight device to operate on
>> + * @value: brightness value to set on the device
>> + * @reason: backlight-change reason to use for notifications
>> + *
>> + * This is the in-kernel API equivalent of writing into the 
>> 'brightness' sysfs
>> + * file. It calls into the underlying backlight driver to change the 
>> brightness
>> + * value. The value is clamped according to device bounds.
>> + * A uevent notification is sent with the reason set to @reason.
>> + */
>> +void backlight_set_brightness(struct backlight_device *bd, unsigned 
>> int value,
>> +                           enum backlight_update_reason reason)
>> +{
>> +     guard(mutex)(&bd->ops_lock);
>> +     if (bd->ops) {
>> +             value = clamp(value, 0U,
>> +                           (unsigned int)bd->props.max_brightness);
> 
> Why did you use a clamping here? I think it is better to return error
> instead.
> 

This is called from a work queue.  This is the call path:

__drm_backlight_worker().
-> __drm_backlight_schedule()
->-> __drm_backlight_prop_changed()
->->-> drm_backlight_set_luminance().

So - I suppose that actually what you are suggesting is to plumb an 
error all the way from the work queue up to all the callers.  That might 
for a change to make things synchronous that weren't 'intended' to be 
synchronous.

Maybe a better solution is to try to look at the max brightness 
'directly' in drm_backlight_set_luminance() and then reject it before 
going down the work queue path.

Thoughts?

>> +             dev_dbg(&bd->dev, "set brightness to %u\n", value);
>> +             bd->props.brightness = value;
>> +             backlight_update_status(bd);
>> +     }
>> +     backlight_generate_event(bd, reason);
>> +}
>> +EXPORT_SYMBOL_GPL(backlight_set_brightness);
>>
> 
> I think this could be nice to update backlight_device_set_brightness to
> avoid code duplication:
> 
> int backlight_device_set_brightness(...) {
>         return backlight_set_brightness(..., BACKLIGHT_UPDATE_SYSFS);
> }

OK.

> 
>>   /**
>>    * backlight_register_notifier - get notified of backlight 
>> (un)registration
>>    * @nb: notifier block with the notifier to call on backlight 
>> (un)registration
>> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
>> index d905173c7f73c..7e4fee65fddd9 100644
>> --- a/include/linux/backlight.h
>> +++ b/include/linux/backlight.h
>> @@ -429,6 +429,22 @@ static inline void 
>> backlight_notify_blank_all(struct device *display_dev,
>>   { }
>>   #endif
>>
>> +struct backlight_device *backlight_device_lookup(const char *name);
>> +void backlight_set_brightness(struct backlight_device *bd, unsigned 
>> int value,
>> +                           enum backlight_update_reason reason);
>> +
>> +static inline void backlight_device_ref(struct backlight_device *bd)
>> +{
>> +     if (bd)
>> +             get_device(&bd->dev);
>> +}
>> +
>> +static inline void backlight_device_unref(struct backlight_device *bd)
>> +{
>> +     if (bd)
>> +             put_device(&bd->dev);
>> +}
>> +
> Most of the kernel use _put and _get functions, I think it could be nice
> to keep the same naming.

OK.

