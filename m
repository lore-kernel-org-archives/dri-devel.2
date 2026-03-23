Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5141F4611C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DDFB10E21A;
	Mon, 23 Mar 2026 14:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Jn24YbJ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1C310E03F;
 Mon, 23 Mar 2026 14:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKPtUqb/7OOH8FLb9j80aNPOGt+G1KEhN/+zLClkvQ2RHBrexmwqsR5GKzcKEiFf+Qr/H3F5uWYinR9QzRGHSPqKPaPsL7JLrG4+h7trHcyyjaHRzjzQsPuSnZ9HTWTGy6GppIQat/DXAAbR9kpfJuZWhMZsZzjKOSDLTRHekse2G3tDzd3A0clVmn5pv6NNtj8cy5Iz70YGvcMcknYq16T0dp2ssPCZMAmQHXx9vWl3q1odELTAhouQdOgcoT0hAxwE2ClCUe8M8zVduPIOnIK94JopCBVbw5swQXUu8LRje2ubs/mYHJRFyU0MQ5ZKksExbqM6DOvWKvGo0ZphxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVhNhJD7aX7cb1fRfyoIdhFLxM62idExmefsUtRZ+6I=;
 b=AHG6IyURnOVCGsOMJ7X7h5dtg4wME4RmkjvoO6SgtYZ7FqT207w196SAG7D0ntB5zIAbW5ZqGkkER5pUq57GNp7F/hxgboLSmL+d4x8N+2Wn+B6zDP6ztVmIb8yDk9/PFLqN949blCRQcmCCDp+LCNLetJI/xfgUaLj8gBOD1MsXY2ffa5d+3suwFquKKMuacc6A5OlVxxHyrzxdiVP8Ex9unkqcjF+k/FRZRJICmcgnQ0oPsLg37KBVNPzNN4nlKyCrwfPAocb7nrizX90vQ8ENE0uwz3o/Pq0vRxhOEB2VUPPL1sUDtCAXnZXY0+58ffv6pcxYHp9U2PkHuFhv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVhNhJD7aX7cb1fRfyoIdhFLxM62idExmefsUtRZ+6I=;
 b=0Jn24YbJ9DHy3CbaT39OjOdp72cEyuUqrjvwT/GTlNaHdT2Kh5SKc3i2TqCW976MQtcfUN3xyntMHqDF7CA6ENxL5/XlKSLw7k3ZnKtLH9IYcgZaHPbR5HGZLMFxy6gBHEK6TnC8dxc9TAPfKywkNvLnGBX+onVq0MWh/6hRoXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 14:16:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 14:16:12 +0000
Message-ID: <07acd68e-8d67-405a-8911-a424a8ee5f77@amd.com>
Date: Mon, 23 Mar 2026 15:16:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/xe: Send 'none' recovery method for
 XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET
To: Raag Jadav <raag.jadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, mripard@kernel.org,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, riana.tauro@intel.com,
 andrealmeid@igalia.com
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <20260305130720.3685754-4-raag.jadav@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260305130720.3685754-4-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0014.prod.exchangelabs.com (2603:10b6:208:71::27)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b707e20-4643-4280-c44c-08de88e6bc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: Va9KUL480dEWQm2T0vAnafYEPGSMHxwoPjKZ7txbOvH5xwHfTP6UhH6MEd0sDSxHF6NnuABMO/m8bl/JiSFttHOr0Jof1/1FLYGF1F1C0saVt63CIoWlp1eAVugontZ6uEzniHnGIcyzSyc2mTID0AcQocXEchQ57FD5YcdnvCIMmmU50zE3XGbbuhW/LTyp6rqblPs+Kzy2KXuXzfO1Ak7Miq7O7Gd579TL6HyPCpXwGdMuNWtqbAU8whhWVN+YdYMwH8Wa2/UEIIXLiSA3SgQGuN+SfUeGGZh3ypdJcOKpJwCO+iMOGjVQy7+XR/hR0Pd1APQ3NOPuJqKzG8EzQcgR33LQ5n4xjSvzfF5fgMstZqDdJCx/aa+GNH5mmdosxuYeL2fTy4dFZdVd1hVmz26JcnHhvssxFaEyKCEZN1HcFcYUaSDH0SMA1UeS+zR7wC94X3A2D+Dl6sCp7b161YId0MpbnvCF1FEMLfxil1BezWIWgriG7+q/br9O2SR/8bueHUH5HX44Lf+yTqwqijKlk4dOm2JvYiZtS/Aapeg+vfS13jkMrGk5l0bDziZF4BFrNRhaBkqg4kY9E4QnSa3oqkOwBlVBORttAT0M/dMSrvdHFSM+NdReUwrG1x8Ign87IIJudY16axp4XaJKzcE7AI5+VjWwlb/XQ0HxflgY8ZXIlmm04oZqE0sVBxN47GE+d/X0JKS8xOULFspaGOaNBkYnuyxjJTgLiEY/L6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzIrbEtOcUdTR0RIcFBQdnpaMm5rN3hjZDgzcExaV3RZUlBOZE5iNThGeXNC?=
 =?utf-8?B?UGNWUUREemlnc1pLMTczTWhRMzk4cWVrbGRQRStGUUQ4UlRFcHZXRGVacHVH?=
 =?utf-8?B?TzhwQm9PcjNCb3Q2YkdnbFd6YlVxUjhQTWdyVDZVWEZiSGF4WmREUkg1ODZk?=
 =?utf-8?B?OW0wQ0t1RHQ4d2NMcWhQbmlQN29qYWMzUytacjQzMjBiNE5XZDkxN1NLekVX?=
 =?utf-8?B?ZFhtdVRnV3V3aElDT0hNYU84RlB2OW1DRE9UY3F3cnJrZ1BxVzNoeU13aEto?=
 =?utf-8?B?USt2dVUyQ25ub0lvdm1nTEJadUIxSU50RkFzaERuM2xkNis2LzRGNktKMnhh?=
 =?utf-8?B?OER6K2E1TGpRTENqaEhmckFuamlFNjZ4QmhjODM4dzZqVVk5WHJsS0NaQjRw?=
 =?utf-8?B?L0hvNlBvR2QrSUVDSTFoaStPblRuSG55MkY2eWV0NmdzeEpQMm9tK3lwQ3By?=
 =?utf-8?B?b3lDNVFtVExQRFRPd0hJdTdlSkZUWEFyYU9mSk9MQ25FcVljWWlNVzRuclJY?=
 =?utf-8?B?amlycnp2b3Z2OVNGTTVtRTF2YmdVL1BGZFU1L2NoTWlGTURvRTlZYzljN3dI?=
 =?utf-8?B?YUs0NGJzcU1palhhRWkveEt5aVlPbDRqQnRmVlRxVlVubnUraTJOenE5ZFFu?=
 =?utf-8?B?RG9STDk3ckpObGYrVXEzbkw1eEsrUUZad0RvZU4zczhiaDNralpYYkRDVFV4?=
 =?utf-8?B?ZnZBb0RyME9DYlpYS3g3OVhSdHpCUDhkcEx3WVJyRVhNMExSd3lHY29mQXNW?=
 =?utf-8?B?bFlTUzVhTTNxZ1NMNzhSanIzUksyT09VVGxnMUkwN2lxUDFzdk40TVJCZ05m?=
 =?utf-8?B?d1RWMi9zcTFJbGpSQ2pJVC9MK2czMUJYUG1QWmxVc0N6alhIbnNrUThzVVdr?=
 =?utf-8?B?VmVRYlRWMnVPUmUvMVRXWngrQ0EveVNDUmZNTkVPZmFaeFVUTUxnNC82ZGZW?=
 =?utf-8?B?ZWM4T2ZHSnZxMVE3UDFWZUF5RzQ2R3I1T2NRTzJhdHBSR0VGcSs0MXJkbHYz?=
 =?utf-8?B?UEZHb2Jjd1FZSFZtaG1saTNHMUh3ZDVoUGR3MVJIM24vN0gyekRnWEtrWUd5?=
 =?utf-8?B?TW9vTTFyRjl3NjE1MWtUVENLZGJsOEJsRlFOYWFHUncvMjdIWWd6amljdmIx?=
 =?utf-8?B?UGNtMC9LZldIYit4OXNPcitlUS9IZ3ZoMWxxWnludFRnSHFTRE03RUxZMnpY?=
 =?utf-8?B?Y0MvcnRqQ2RoZVg4V0hZYWdUeTl3aGxpVWQyL0R2dGpjdzg1N2Y5Q1B1VUsr?=
 =?utf-8?B?Z29qOE1TNFZadGUvUGl5QnJmekpMMjgrQ1ZJSG9YT24zbXJGNzAycjhaUUpi?=
 =?utf-8?B?VGVDK2NZR3F6SGJrME56R25kRmYwS0piZWttbW93YjVDZVVGeHNXeW1YY0E1?=
 =?utf-8?B?YTBmcG5jdm9JQ0pYcDNqVldqdy9UamdVSzZBcE9HZnRZOGdtMDdtUWRGd0pS?=
 =?utf-8?B?d2hQbWtJTjRZSUE0OWh1UEY4N1VCVG5wQjNzRGFnNnV5NDdyU2JRQnFpRGxY?=
 =?utf-8?B?aExFRnZhQncvTzZYd1ZjR0tPNnMySGJvRFdUUWE1cmNwTjdSNk82c0NjN04r?=
 =?utf-8?B?TUpPbVdKTldTUm80RFRRaDFJdURSM2t5emtVeHNrUWFYMDlPWjZsdnZIbWRY?=
 =?utf-8?B?MWxLVDAxYkZBSmtTRmZBSGltaExYNDByNnZKUkJuZnJKL3BYTG96UTNyWGx6?=
 =?utf-8?B?VmJFdXl1NWNXOVFnMkRDOXRBdUl2V3p6ZCtDV1YvTjZmY20reWRWTENybHJY?=
 =?utf-8?B?UUg4a3ZsOGdMZ2hDMmNlZG51eUE1T0g0NjVzb2h2KzBjWWorck00QkpwTzVa?=
 =?utf-8?B?enRCSTZmUEt4b25obG1iMjJrT2YxbERCaXFvWjl2ZWdmdnhqdzNPRk5BNlFa?=
 =?utf-8?B?Ri82K1U2Tk5lNURXK2RmNXBIUjZnUVRsTVFQZ1VxdTBIUEx4bkxHdEU1dmg1?=
 =?utf-8?B?TFp4ZzlIT2dsNXQxbE9Hc1E3RkY5NzFOQi9Fb1VyaVZ2R29NMTBDamZzNE9X?=
 =?utf-8?B?ZmxtTDl4ck9FZ0dNU1h0em9XS1pTcDZlSzMvUW9LVGJubEJXcndnMjBIUXF0?=
 =?utf-8?B?NUdsZlVaUEtuQkkzV1M4NG02Q2RKZmZhZWJLU09IcDN0dzBtU2JpdjRNUjV1?=
 =?utf-8?B?RW1GMjNFV0hJVGJHK3M0ZDdxaEJTNGdsRmIvUmFrb1lUdHBRcmdsRk15QzVT?=
 =?utf-8?B?RXpNVEpTNW1jZGZ6Q3dySTVCQWNKdTVuVjAwcmJrWkpRV0lmTzBsZG9Zamxm?=
 =?utf-8?B?RnlMZ3NMNmtSQ2NrSVFzci85dm81RjdxaUQvcUxwRW0rTE50VVMxWjVMTitv?=
 =?utf-8?Q?zaxYjUMzhFS8CVKwOx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b707e20-4643-4280-c44c-08de88e6bc6e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 14:16:12.1021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiRg0XLMYdQYDzAeJgkEwSizoFZRGy5u70NQQx24JunmDsS4fCHyOsRgpsjNnMd4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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
> XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET is intended for debugging hangs,
> so wedge the device with 'none' recovery method and have it available
> to the user for debugging.

Looks sane to me, but I certainly can't review nor ack that patch.

It's basically up to the XE maintainers to decide if this fulfills the requirements or not.

Regards,
Christian.

> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index c137dc0a1840..eeb626737760 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -1329,8 +1329,15 @@ void xe_device_declare_wedged(struct xe_device *xe)
>  		xe_gt_declare_wedged(gt);
>  
>  	if (xe_device_wedged(xe)) {
> +		/*
> +		 * XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET is intended for debugging
> +		 * hangs, so wedge the device with 'none' recovery method and have
> +		 * it available to the user for debugging.
> +		 */
> +		if (xe->wedged.mode == XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET)
> +			xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_NONE);
>  		/* If no wedge recovery method is set, use default */
> -		if (!xe->wedged.method)
> +		else if (!xe->wedged.method)
>  			xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |
>  						    DRM_WEDGE_RECOVERY_BUS_RESET);
>  

