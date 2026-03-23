Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0A8F46126
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7663010E060;
	Mon, 23 Mar 2026 14:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZR+axaM9";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5B010E200;
 Mon, 23 Mar 2026 14:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldwykqykEz5SOEmiFrTDda/MPuoQhEqdj/iK3R0b9+BLqePdwD0AYE3RenBZzdoxM1XaXM5CgQsLRdOyIQXJnRqOgisew6wYYyMURoWcsvY0+y0O/ZklwN66WV9gfFdy5ps5/cXxo7xYhcWUcNz1O2Adp1Ev0gR5fwDkrCQ+HD5xDjwq1URe+E6ulXnBYDNXo/heIWMjs00I8X0i0zy2dSOogiPtxHLGcPN+eJrZ07YewWRI574Kt8Yt5a50w4WAGq8QT5AuSIHowuHF4xs2xMVPKAqkfUggkchHEenEDbtdnhuy2eMLJSZnefOwu69eOJlma9nxVMSzjmrRzh050A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K17mPHY1TV/yvJ3IsamsQ59BO3FD5swt+Z9cRLQAfJ0=;
 b=iaMuqldn121HDGt2x5zV5WV4TMVPbNev7DBPYnQbV2iYcM0Uze2+chZvtRS9zJRexePPzhgTIr3xzcNdYinfPSTBW1XtPLqac6R/7sFmBwzIKXQbXG2G8IuJ4sG8I9y44soJOdEsHyruB12VZulid9yCXCsgxOk+2V7bi4+PxHgdVgwCrR1kjEn3MbkmeojTcomjONegDZpPvR4QSMzrApWHHbr3UhiD2OZNRuAqglntp0EDXcU9vTXZZFhLjPBhXABFpcxrh+aChfBV1IM5gE63RAWF3VZGlBI/WKcghBDzXTPZeP6B/XYUwTMxlWGAtWOaBiBiTSJ8j9rbEwC8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K17mPHY1TV/yvJ3IsamsQ59BO3FD5swt+Z9cRLQAfJ0=;
 b=ZR+axaM9Eqws6CW6ZmIJZ3bvdUzFamvTDkw5eKo2dDF24kxpoy2N6Q9OpPZ4Gbuic/W6/7M6wgSF1OlZTAQrhSWpNuarYDDUoYE82JJPTw9Gk42CPyGiGJiTo9PWrOBrm4HfGWY8r/7+fj+k2et4AtgK0YmPUCOehNviDL/5frc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999158.namprd12.prod.outlook.com (2603:10b6:303:2c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 14:13:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 14:13:06 +0000
Message-ID: <649a6594-a1df-4889-bfe8-d3e6483971c8@amd.com>
Date: Mon, 23 Mar 2026 15:13:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/doc: Update documentation for 'none' recovery
 method
To: Raag Jadav <raag.jadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, mripard@kernel.org,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, riana.tauro@intel.com,
 andrealmeid@igalia.com
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <20260305130720.3685754-2-raag.jadav@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260305130720.3685754-2-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999158:EE_
X-MS-Office365-Filtering-Correlation-Id: ac196395-a6fc-47c2-edb4-08de88e64d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: 5nKT7OKZBILXozxQQbKNuPwSylRnaA0lJKyPRMF5gLYqfO1lcJMM57zUMLO8pI9GQbW9qH/sMoPdu6gkmQ7RE8BO/tvpJEKtCVN6sdaKSq4tgOPfwDSVr2y8ylo+D6551mstdUCHFSu4R1Lmno+HP7l/eSCyDElXes+iomCe72g3cT+7MfZh9A857K4zfyUJb2sgfkjvcR1moO3c97nkDyK2cMUHF3xjLktEth8g8/vZw2unON7XyY6l7FnTKR96wYoek2KUNtxx3fR2b17R/4bEJGZRz+SDYh4YLLRod69SNdM6taU9+UdDxU54auGZU8RiI5MlnVwnkayn3LCCToppoD3FqRfXhtZ6T6wjuPbr5u1VxIYMhIHx18J27Dq1DckaGar+5InGBwz4uhwboPQIH4TNcq0vfSeoRbQChx3tVAjAjlqbFYHP59gd+31Lmb4/P01SAc/VJvyJiBHOgUGXYLwB8BbJVEQ5VSPLNzkU5AreES/HLRQjVzh2d+BCshqWV7X+YxW8dnngsqJ7vB5iqMCK2QhiUNuDb9CWQ8/3YTz7pT5UeHXFjZ0Y+AQQmQW9z6BWpBj5l/sVM6SfvGZqoBaXsuVOBw/NOvyXhrqOnjgQTfbsUdcn+AxbKqBuBqE6cm975mH3XQhs0JfByn97p2Y0LZizZo6y3+b9D4llWXlIRWbXnv0LRyI3NyogMYLwVpkna1aa/GSJ2v+VZPYgc1jMY+ZgZ/JTRh0Exww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NStqM0Ftc3FZSWlRRWkrTFgrSnRUcFVyMlZsd1ArckI0Y2FZRzhSSHlrdXNa?=
 =?utf-8?B?NTc3V3J5bGthTE45L1RPUWF6MThxV2Y0K0YrRTNxa0w0TlBkWFJrZVZwNUND?=
 =?utf-8?B?WW9oS2NSRlkrWEQ2Tjc4N0xmYk00WEt2Ri80N1RTcnRYNUE2TmcveFo4WjJa?=
 =?utf-8?B?N09Nd0g1YXZRSjlzUUJvd1J5NkFiY0JtejhsZDQxNGpqTU9PVEFjRER0Yk0r?=
 =?utf-8?B?YUp3QWpjYTFqY0JabHN6U0RLbTRzOThlUzRMSzdUYWhoRFl2OFdiVDdMOFoy?=
 =?utf-8?B?OTZhWmhmcG9zNWxzdE80bVRWbXYzcXFVUStKWEZjU1V5NDFCWTBCNU9neUZL?=
 =?utf-8?B?YThYZ08rOSswMEpwcWx6L2wrd3U3aDAxQzZSQ0QrbUR5Z3k0SXBsbXo3bmh3?=
 =?utf-8?B?ZEljTUNFYVZ6SG1hNEJsSzRYWE02MHdCQXlyUmE0SVhPNW1qQkVqNFN5VkRj?=
 =?utf-8?B?am5HWnJYRmZVTlBRMFovb2tyQUJtaTNudGlDMzNwbGN1czFISXVCbnNqeWFm?=
 =?utf-8?B?d21Kb2FpNDdkTnVzWndWQ0dvbEVWOTU2WmVTbEh6UURDYi91bjc1T0krVEsz?=
 =?utf-8?B?bDhvQ2MwTGxIekpUWFI4QUs5Q2oyLzYvVHphKzdmY29JcHYydnA4cDE3Tmpn?=
 =?utf-8?B?aVMwRy9TejFTWkpMKzI4dUJwcHNOQ1JyRnJWQlRVL0hkZUdFNzR0OVEwSDRo?=
 =?utf-8?B?NnErNnViVktUNDgvNmdjU1hCbnhuMlhHbDNvbWFYeVg2RmxVNHUwR3ZGb3ZC?=
 =?utf-8?B?QlNwaFNVcDhZVlB2TmpSRDJnSm9ISGVJb1BIWXhoR2dyS1EvS2pSKzNJMWcv?=
 =?utf-8?B?YzQvc0h3dEtUQU9OdXpMekRWb2d2U3Zob1JxaXdQeXhDY1NXalk3bDBKNHNa?=
 =?utf-8?B?THUyVnRVRmowejI1VzZrenI0QXNoamRlKzdwY1Q1MG1lN09WeUw0TW1wUTdK?=
 =?utf-8?B?Z3B6M094Y1Jxa3JQS1pLenVEaXdKZ3cyamFUOHBiUGhvcU00Yi90UnAyTVE4?=
 =?utf-8?B?bUY5VUowVnF2R0tWdkdoWWREWjc3Tkt0aStISW1pWCs5WiswNlhabktWT2k3?=
 =?utf-8?B?NUw4SktzTVMycEdKQ3lERndWOC9CdkdlYTFoUXJMWXV1ZXdYZkI1c2pQUytQ?=
 =?utf-8?B?eWdaRWxxYjQwK3FPc0FjaU4vVE4ydThpR0FRdTh6NHY0VkphNXBFR3VaUDM5?=
 =?utf-8?B?dWtodWVUVHBpSk9COEZ0aEgzVnZtS1FsTjFheDRBZGJRSytiMWpMTHVnN2tY?=
 =?utf-8?B?ekI2cVFBZU5VNGM3SVFmeVk5a1dyeEMwUWJodXF3K0pTdGQxeTZNMjQ5VDJI?=
 =?utf-8?B?dFBORlg0M0VlVHRFd0VjdGhwVjhDbnVYdjR4Y3F2enRCZzI0WllzVE14akxN?=
 =?utf-8?B?VmtWZk1NNzdhTTBJWWFxYUk5UHVvNG9jaUdLcmRNTGVadkNSNEJ6NzhiOWV5?=
 =?utf-8?B?cUlYejBrSkV3U0E0N0tncUswbnhBbW8zb3FFWGpUWUxENWlMOVEyMFBaZVJO?=
 =?utf-8?B?SmxDRjc1Tnh6STljOTg5cXBTWTUyYlVIZ2szdUN1N0Z1OS95MUpENVlNNzlt?=
 =?utf-8?B?ckYyUzFZN0JLV2NUOEFpUmVsb3NxWkQwMEdwNThhemJNdkxRRFZzYlJQRTZB?=
 =?utf-8?B?OTI4K2k3Tk5GaHVGaUpwajkyQlBPZDdFdkc0dGhHdml1QVhRMHhnOHhWVkpX?=
 =?utf-8?B?NDlGd3pCODdYcmV3RjF4VEtJanlYTkVsaHdPYXUzaG15cW9CU3J3M1djbDNT?=
 =?utf-8?B?T1BJTmQ1QWxwUmVnOEIrL1RjSHRQQWk2WlNNODRVNXUzMHJZYWFmSWJvbWpK?=
 =?utf-8?B?cE15QnV2YVVwWkY3YVRlZjdjMlRDa0RhK3EvMG5TRDRyZHhpT2VsTTBteFRy?=
 =?utf-8?B?anVkS0dwOCtqZXQ5djF3VlE4dk5OQ3ZTaDVzNnJVQW93WWNWK2FKSWl3ekdB?=
 =?utf-8?B?dmNEaFRJOThCeUp3bHVhSGo2UzRWQXhlYmYrdGo2ZGNOckFDUkpvbjBlYzg0?=
 =?utf-8?B?TTRTZUZqQjhidlV6OTZNRitlNzVBcjNIektsTFhMa0JLVUx1SmU5VmticlRs?=
 =?utf-8?B?VDZtSEJEYXJQM3NEaUdvMS9NdXZLMHpJdXJJRzhvV2lCZTBqL2VkMlc3TC93?=
 =?utf-8?B?UDR4bzZnMmErZWNwd1grMi83bm45Ym9QNHQwS1RoTmQ2OHI0aStFRTlSM3ZM?=
 =?utf-8?B?VEp6T25xcmNmNlY1aE10RGxHUE90SDBtZ1VGZVJvYks4SkUrR0tlZXFESG9E?=
 =?utf-8?B?MFpldE1hVmJNSmtXQTZnZ3lkRGZGaktNVUdwS3c3UFY5MklucTFKenBDRm41?=
 =?utf-8?Q?dK0wz9TI9/pUyQcZJG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac196395-a6fc-47c2-edb4-08de88e64d9f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 14:13:06.2174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2X2yIyXQG+i8bkHAMy1zdytOldhEjLSArEAr42o3ith7oQ/rmm69JK3jQXN3IHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999158
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

On 3/5/26 14:06, Raag Jadav wrote:
> Expand 'none' recovery method for wedged event to include debug cases
> where driver wants to hint "no recovery" without resetting the device
> from driver context.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  Documentation/gpu/drm-uapi.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index d98428a592f1..579e87cb9ff7 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -438,14 +438,14 @@ following expectations.
>      unknown         consumer policy
>      =============== ========================================
>  
> -The only exception to this is ``WEDGED=none``, which signifies that the device
> -was temporarily 'wedged' at some point but was recovered from driver context
> -using device specific methods like reset. No explicit recovery is expected from
> -the consumer in this case, but it can still take additional steps like gathering
> -telemetry information (devcoredump, syslog). This is useful because the first
> -hang is usually the most critical one which can result in consequential hangs or
> -complete wedging.
> +No Recovery
> +-----------
>  
> +Here ``WEDGED=none`` signifies that no recovery is expected from the consumer
> +but it can still try to gather telemetry information (devcoredump, syslog) for
> +debug purpose in order to root cause the hang. This is useful because the first
> +hang is usually the most critical one which can result in consequential hangs
> +or complete wedging.
>  
>  Vendor Specific Recovery
>  ------------------------

