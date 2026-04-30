Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB9CCD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1EC10E472;
	Thu, 30 Apr 2026 18:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AzNBGrF2";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA6F10E19F;
 Thu, 30 Apr 2026 18:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKCqdVyL9BgQwjT9UahUqWr/w4CehhbL7Bv6HCwmJb6i4nMLihelTFb/rKVqMJS8DJ4NK4j31jBcT0n4c2y7lJ0AQcGKh8SQVioGWjSJ+T6V9KU/QaOrPKHWEWYNOGsPRDW+5xInBrIdCMLWYl3QZgQ2wglsMVCZf7ZtM+Qn1VBWEshbVvjPgNVVDUs3qntzPi9E6+zJyB7n56HwUYyaNoON/oV8k8pyorW9JRDxFwB42EBgZsYH1Zp87aDqMdeavo2Uyqqpb2X/+Fb2EGg9wl34oPWcldFN8kMbtVWBwr1kgTX+/sCtjH+w9KTsR6JHvRP+gCfC7Gh00LvQL+i7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo0GKpu6G478RwijxYKYc+FYOP4odnFF0jcCCUvuzHc=;
 b=W61n4EBCScSYmNz6knk87uNxRmLwIkn9bRLwCBdo+78Mm2tatt9jYPiJKrUVKWKzKZF5074InJcvAvB4dgXIMsFSv92oHRszXcmAL0d5RrlYKM8sXeSCTqchAWlCG6wWklZegU7dIKThgcKloJymHldGmWWBqYHQsS8bcWhat0e5cpP6O/zIL1tBwXDn7N5y3KeF79PUREuItDR1qGV9vedwHjEJXKrhgDnUgSC6vX+ZVGgpuwoyf17dS8TcZIrsGDJg7Vstsahvo22yvQaG9xWbYwRBASytpAfvZEifcBDbmXF/OCFL/PUmp9niCNJ1OtDtJyXRP4KeriZCOLkvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo0GKpu6G478RwijxYKYc+FYOP4odnFF0jcCCUvuzHc=;
 b=AzNBGrF2SgsMBBUv4IsgjRHDLon7PumJgor8NOyhzx2BDTyQrjiPOY1kMU5dTP7/OQJ/KOiLKCgWyHzK746fyIaT95qg1nDKipjG2s8HIwxL5RkeHy6rR4PPg3iig6MWMO9GdWIyy1xipwhrnr46lZ9EvFTmVVysHVdFf8+xj/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Thu, 30 Apr
 2026 18:19:50 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 18:19:50 +0000
Message-ID: <7acc6e90-63e7-4c09-9944-502006c77f28@amd.com>
Date: Thu, 30 Apr 2026 14:19:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/9] drm/colorop: Add limited-range YUV-to-RGB CSC
 FF enum values
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-3-harry.wentland@amd.com>
 <1fe865c5-3f82-4178-a88e-88a6837a4819@intel.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <1fe865c5-3f82-4178-a88e-88a6837a4819@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: b7563df9-6e3d-43c0-19c9-08dea6e5114d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: nBQjH1MDASOZr/JOvrZaivWMjLKo+p08NKrRszvmadeuT2AMpdTmghhXxA8D6z6EjfZVusHiRMoqSdNFsABESLv896yIZSStYOEtCLGvI585bk+9XHSa1dNYAS1EUxYbs5k12AYHolMNg5a0RVIaBPK0MMJdOmRfW8wiSSdxrzdAxxBjSLm8tPSdF1MeOhv3vW+BrxFoKWgvH2/MOiYk2DE+7HaY2H4j9k5FtitdkA//ZSZ6WX8te7jqOju4t9mIPsGjUemGT8RYGnE2p9JyEUpowHlQSonQ4fMmT4g2JbjK07U5tzIq/7xuKO52XzSRSrxG7qqGEc+JTL7meUWhpnHJzXy9B0O80Vv9C9n3xv4bvT8CN1xoLz8JDNrjdzYlPRINFbVwZT0IF0ld4G5CPxHZ4O0dcdIY4JxoeEBLAFtgNYkDhsfay86d0pzPN+vBPhWjHPILQd9rjUvBxHwnQz4+OsqFb61On79TzTLkWZXYvq/g2jQBKQrrMUhDeCm4T6nF1n6BS7c3FaVlB3d4liEQ0VHPwC3Drz+95PmSdCMAAbJgY5JKj4g/d0RbGHx4IFJGxH14UJcWQ6qcsslPEjum1uVpRsvloa0di64DLII0fgB+Fwzwpnqhde2WmZ6tsDj9w6dIbjhPiEnvWNPh4wVuYjkxg4yloSDy/RFC20dnHYB6ctkKUz2s+1D9w9XB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEYwK0ZDL3NyVkNBSEQyZ3ZHNFY4c3pNWkF0QkFNNkpnc3dwcUMybWZvL1BK?=
 =?utf-8?B?RkxBYnZGN0JBbVFtZ3ZpTTdHUmRCT0h6MEZZYWNNNWVUem11d04yL0hUVURp?=
 =?utf-8?B?ZEZYekRoV09tR0NISmpYMkNDT2QyNXBlZ3J1VUpNTTRQUUpIWmtINTJpejMz?=
 =?utf-8?B?R25xSVFmRm9oOW9NRFJWVUxydVNpaDc5dGF4UFNQUFRzZWg5Unpzb2w4OGht?=
 =?utf-8?B?WEpPTU9yeWY5NHFpRmpwS2xFQ2pDSEhSMWlta1lDSmgybVl2bjhxUzZsa1Jt?=
 =?utf-8?B?UUFyZzdBOWVVQzdYeXE1K2N5NEtVNytURU1GV0pQVDdiRnhPQ3dOdnFUV1gy?=
 =?utf-8?B?dE55UURIaWVPMGZsNFZkZXQwcy8yOXh1SkxmTXhDTFQ1Y3hpOFNLbEpvOVJy?=
 =?utf-8?B?bG1KK2g4Y3Bab3RobWdhMkt5QVk4Ykh0MVlqYnZHdG5hZWh2K2s4REJRaUdZ?=
 =?utf-8?B?cDZCdWJnRzY2ZEV6eDN2aEFMSFBGd0NJUm40cGlrdFl5NkdDWURhaTJsOG1K?=
 =?utf-8?B?SXpBbS8yeXlBZDNaQWNqbWZ1bkI5NWVZZmlRV0NvS1pVdTlINnFmUXc4aDBI?=
 =?utf-8?B?Q3RZQkZZQVNUaTR2NzlPSXJ6d1I2QnJ0REpsUXg3MDZ6cm4xeTVOVWtIaTlQ?=
 =?utf-8?B?YWM4MVRSQm9xUk9sL1FHaXl1bm84WXJNQTZXMEpadkpoUTY2d2tBT1p5RFZC?=
 =?utf-8?B?ck1LWTRReWpzTXI0blQ0ckxuRmxxTVZDVk4xQ3hSellsSE9jNVJyNS92U0la?=
 =?utf-8?B?QnRFdlVPM2pkQjdDbDhVMng1OWRxTkh1VGZoVHVBbVBrNHFPMHZOYWpZMUFa?=
 =?utf-8?B?Z0hRdWoyTFRCcXRIbUdKQjJHV3RqUWZkaU5FcTFJZitoTlJzZVV5NXdYUzlF?=
 =?utf-8?B?c1RKcHdHOWZrSXhFT0t6V2hVMDhieUNRa2pRNXhQSklwT05rOFJKV2dtWnZH?=
 =?utf-8?B?RjhXMGhIK3FURlRkdEdhaUVOTkt4Q2hvc2pMVlltSURmTzBEZ1pVd25lY1Bv?=
 =?utf-8?B?RU1HK2kyNTFJQVArVzl6U0hVWm1ZdjFVUkJ4RkozNUxSQ3U3L3BSaGxnbUx4?=
 =?utf-8?B?ZW5NZ0lIYXMrMXdZT2dnejM5NkVCN1JqNkkxeEJ1cG8zYW1lUThzak5ncWJv?=
 =?utf-8?B?cERXWks1UzZ3dlNma1hvdXJLck5JZDcxc0tjRi9YZTd4R0Nyb2lmMVhlV0FN?=
 =?utf-8?B?N25sNmdYS0ZUVGVIK016MVdNd2JMYlNjK0JBbzN0OEphV2cvZ0x0b3ZUZmNr?=
 =?utf-8?B?YXVGZXNsVmVUSWMraWpIbS94elFXUWQvRVFOdWg1WjlqYUYwS2o1d3dwZDdv?=
 =?utf-8?B?NjY1blJKN2FieGpmd1E0RTcrcjRVVVhIdHl4aHdDNDJFdjBQOVNEWTIzMDBG?=
 =?utf-8?B?dStFR3RqdmgwUDlsTU94eVlxdmlSVlBTYkhtbFZ6OWFiRFZhditlQkZTSU5E?=
 =?utf-8?B?dnhoKzBoaWR1Z3NmbVJUbjRmekJTVDRaVldhRVQwRWdPVG1aVTJsbXFFcXZE?=
 =?utf-8?B?Z3pPZ0Y0SnJiVFV6Ny9BaUI5MEpSdG9wVllLQVo0andIWi8vT0p1OXNWVWoz?=
 =?utf-8?B?K1NFQnNoWGhFU3hSZURIU3RJaEdPbTc2R0NuMDBVTUFHYXNRYmlQRFozU1Vs?=
 =?utf-8?B?UWlTaGxWWHFlN1BLMExOZFZ3NFgzMmtuZkFFTDhBVHBIdWlpTG4rVjlsVFBj?=
 =?utf-8?B?SGhhYnd6aXVITEdOQUpieG1sMDk5T3RZYTZSL2xTM2FrazJCTlJwUDJKcUds?=
 =?utf-8?B?ZTJnTEp6dk92LzBlQ1JWMjNVaFdHc3VSQWFOdGl0Vm1ta0kycW5jU3lCQVd2?=
 =?utf-8?B?MFFUdWVSY2JFYUE3Z0l4YXJZRnF4UWsrUVY0TWV6dzlNUm5ROUlYdkpTdWJj?=
 =?utf-8?B?eEJzVXgzU2NFenhjNnp5cldodXozWmRocEZKcjZnU0ZwMGlxNWdZZ1U4ajJC?=
 =?utf-8?B?RXg5ZXZmak1TOHZ0aUxibElOYmdkbVQ5RVJYY21Oblh5RGh2UGt5dzE1ekQ5?=
 =?utf-8?B?ZmFuNGliWm1HVFNCSy8rM2JhbEhJdXJSUGMzVHlqck9uSVY3OURZakxabnU0?=
 =?utf-8?B?Ly9ldm4rcmJha05hVm1ueEdpNWVGLy9HYU9kcG9NSWpPbzhIK3AyNFR0SzVl?=
 =?utf-8?B?ZWNyTHRDT1U1YVFDQjZFMmx5djdzaFArV1JBLzdUa3dhb1RvdWs0UDQ1V3NM?=
 =?utf-8?B?Q1AzWUFOVVFZM2tRTlRKYzR5TzF1Ukw0akpsYmo4UnpBNWMyRUdMN0QzT0x3?=
 =?utf-8?B?RDk4M2JOaFlXR1dMTHdCMnZLaTVHNW5rREhwOFE0dXRBMS81WjJzUHpzekhi?=
 =?utf-8?B?UWZxMGlmY3piNGU0Vkp1a2xISXJtSUtDSkxiUjAvVDdrL3NObEhyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7563df9-6e3d-43c0-19c9-08dea6e5114d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:19:50.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqAhSmew/fPo//q2Iz9/uTgjQ6CfjRNA+n0YftA+KfgrCO/R1yRZYZw9cIOyLfEIC+8SkVWFb9Qy+a4GRq1+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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



On 2026-04-23 05:34, Borah, Chaitanya Kumar wrote:
> 
> 
> On 3/30/2026 9:04 PM, Harry Wentland wrote:
>> Add three new limited-range YUV-to-RGB conversion presets to the
>> CSC Fixed-Function colorop enum:
>>
>>    - DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601
>>    - DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709
>>    - DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020
>>
>> The existing full-range enums (YUV601_RGB601, YUV709_RGB709,
>> YUV2020_RGB2020) are kept as-is. The limited-range variants are
>> inserted after their corresponding full-range entries.
>>
>> This gives drivers the ability to advertise support for both full
>> and limited range YCbCr framebuffers via the color pipeline,
>> replacing the need for separate COLOR_ENCODING and COLOR_RANGE
>> properties on the CSC colorop.
>>
>> Assisted-by Claude:claude-opus-4.6
>>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>   drivers/gpu/drm/drm_colorop.c | 11 +++++----
>>   include/drm/drm_colorop.h     | 42 ++++++++++++++++++++++++++++++-----
>>   2 files changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
>> index 6a345e2e8b15..f0d11cf7e3cd 100644
>> --- a/drivers/gpu/drm/drm_colorop.c
>> +++ b/drivers/gpu/drm/drm_colorop.c
>> @@ -92,10 +92,13 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>>   };
>>     static const char * const colorop_csc_ff_type_names[] = {
>> -    [DRM_COLOROP_CSC_FF_YUV601_RGB601]   = "YUV601 to RGB601",
>> -    [DRM_COLOROP_CSC_FF_YUV709_RGB709]   = "YUV709 to RGB709",
>> -    [DRM_COLOROP_CSC_FF_YUV2020_RGB2020] = "YUV2020 to RGB2020",
>> -    [DRM_COLOROP_CSC_FF_RGB709_RGB2020]  = "RGB709 to RGB2020",
>> +    [DRM_COLOROP_CSC_FF_YUV601_RGB601]           = "YUV601 to RGB601",
>> +    [DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601]    = "YUV601 Limited to RGB601",
>> +    [DRM_COLOROP_CSC_FF_YUV709_RGB709]            = "YUV709 to RGB709",
>> +    [DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709]    = "YUV709 Limited to RGB709",
>> +    [DRM_COLOROP_CSC_FF_YUV2020_RGB2020]          = "YUV2020 to RGB2020",
>> +    [DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020]  = "YUV2020 Limited to RGB2020",
>> +    [DRM_COLOROP_CSC_FF_RGB709_RGB2020]           = "RGB709 to RGB2020",
> 
> As I understand, all combinations of input/output ranges are mathematically valid (e.g., “YCbCr XXX Limited → RGB Limited” or “YCbCr XXX Full → RGB Limited”).
> 
> I am not sure how widespread such use-cases are but will it be prudent to have the enums be named as "YCbCrXXX <range> to RGB <range>"?

I'm not sure how likely it would be that anyone would need to convert to RGB limited. I'd prefer to keep things simpler for now. If anyone does need to add enums for conversion to limited RGB they could always add _RGB_LIMITED variations of the enums in the future.

Harry

> 
> ==
> Chaitanya
> 
>>   };
>>     /* Init Helpers */
>> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
>> index 2cd8e0779c2a..c414b9070afb 100644
>> --- a/include/drm/drm_colorop.h
>> +++ b/include/drm/drm_colorop.h
>> @@ -145,31 +145,61 @@ enum drm_colorop_csc_ff_type {
>>        *
>>        * enum string "YUV601 to RGB601"
>>        *
>> -     * Selects the fixed-function CSC preset that converts YUV
>> -     * (BT.601) colorimetry to RGB (BT.601).
>> +     * Selects the fixed-function CSC preset that converts full-range
>> +     * YUV (BT.601) colorimetry to RGB (BT.601).
>>        */
>>       DRM_COLOROP_CSC_FF_YUV601_RGB601,
>>   +    /**
>> +     * @DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601:
>> +     *
>> +     * enum string "YUV601 Limited to RGB601"
>> +     *
>> +     * Selects the fixed-function CSC preset that converts limited-range
>> +     * YUV (BT.601) colorimetry to RGB (BT.601).
>> +     */
>> +    DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601,
>> +
>>       /**
>>        * @DRM_COLOROP_CSC_FF_YUV709_RGB709:
>>        *
>>        * enum string "YUV709 to RGB709"
>>        *
>> -     * Selects the fixed-function CSC preset that converts YUV
>> -     * (BT.709) colorimetry to RGB (BT.709).
>> +     * Selects the fixed-function CSC preset that converts full-range
>> +     * YUV (BT.709) colorimetry to RGB (BT.709).
>>        */
>>       DRM_COLOROP_CSC_FF_YUV709_RGB709,
>>   +    /**
>> +     * @DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709:
>> +     *
>> +     * enum string "YUV709 Limited to RGB709"
>> +     *
>> +     * Selects the fixed-function CSC preset that converts limited-range
>> +     * YUV (BT.709) colorimetry to RGB (BT.709).
>> +     */
>> +    DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709,
>> +
>>       /**
>>        * @DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
>>        *
>>        * enum string "YUV2020 to RGB2020"
>>        *
>> -     * Selects the fixed-function CSC preset that converts YUV
>> -     * (BT.2020) colorimetry to RGB (BT.2020).
>> +     * Selects the fixed-function CSC preset that converts full-range
>> +     * YUV (BT.2020) colorimetry to RGB (BT.2020).
>>        */
>>       DRM_COLOROP_CSC_FF_YUV2020_RGB2020,
>>   +    /**
>> +     * @DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020:
>> +     *
>> +     * enum string "YUV2020 Limited to RGB2020"
>> +     *
>> +     * Selects the fixed-function CSC preset that converts limited-range
>> +     * YUV (BT.2020) colorimetry to RGB (BT.2020).
>> +     */
>> +    DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020,
>> +
>>       /**
>>        * @DRM_COLOROP_CSC_FF_RGB709_RGB2020:
>>        *
> 

