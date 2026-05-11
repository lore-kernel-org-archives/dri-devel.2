Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866F1CD484A
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC70410E72E;
	Mon, 11 May 2026 13:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDNwPGMv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0D410E720;
 Mon, 11 May 2026 13:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYvCyynp5J9z8E0I2+7+ud/0OcWstIsx4WQaZ8s1OyM/IvKMyzibD1WNSy7L9dKyvj4GLotibp5qIhZoZ6ZqkYJfcXBJclrjfMUg1t5H81OoSyYYWgcdaUv+XUu4EKfPB74zM2fET8XqN2x6lLcYnvskGU5/AAAldpBASW4oswxC2+hyu8285JfSbaybgdvrHHAU5SJsOfxA2oLhvEuYMxAIoUkbUHfeuwf75Kctqi9LDnFfrtHFrBEBOFigppGBSqcmjs2gLRhi4zqSrnVeknMHpHY4XgaWmmX2RMegF/HyeXwl2zaOtyvUH1yAjN5EOorYIG3Eo4DHHoatLO5AnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iR2rAmu+w8RlQ5jNaAS5awBCKlvOUQZh5ZdikzOmnE=;
 b=qI14jLfSRl7cZq0ECtrrmGQkFNk5Sm8cyD0993x4W+Elo6q5J0WHuVbBuQRuBIWDoZ9f2OdDCV0UBgTzHoU3hobQKW5VMTzmW+R2tz320/DbAOUdYLY9praU2G44VLE0M6tqz+CHhYkzd6JPmfy6qM8Q+bDeqBb60WYyxxJ93cbXBqWpkeytcp+D7cHnTB9kYvbdR9Im/phNZOitYrcPBGYo731W0qX134D5QOZJpymFK1lvMvkSJsFFCsjeiMaHTT6MzF0dptAidMHlXYHZADjcbizKt8rNELTPSK33uYO0Ez5yxq8W9lswaFjFjWQ11e9uZAmHsf6xZKHE6QZsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iR2rAmu+w8RlQ5jNaAS5awBCKlvOUQZh5ZdikzOmnE=;
 b=mDNwPGMvqAlQL4ooI5qzEFDo+E6bRenvHHTt2Iy5Z7TGFiY7iVNm5nc+B3yxJ8X6cv9LjLGJiA4OYs93qovyOXEKjL/R/S1KwLzIiiD0SaH6k3tge+BGudKjzpaZMTdzhuMR1+b06qSqIWlUZLzhspWwaoozUJvh1ewb/fRdd74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:50:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:50:47 +0000
Message-ID: <cef3ac12-b306-4b72-b015-49f77556874e@amd.com>
Date: Mon, 11 May 2026 19:20:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amd/pm: Use guard(mutex) instead of manual
 lock+unlock
To: Andre Jun Hirata <andrejhirata@usp.br>, kenneth.feng@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Gabriel Dimant <gabriel.dimant@usp.br>,
 Guilherme Gabriel <guilhermesangabriel@usp.br>,
 Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <DM6PR12MB2972C1F2B155E1930319634682382@DM6PR12MB2972.namprd12.prod.outlook.com>
 <20260511124240.8484-1-andrejhirata@usp.br>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260511124240.8484-1-andrejhirata@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::34) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bf180d-4cc2-45d9-6257-08deaf644dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: /jNTwDjoJew6xs83k9D3Z8gnMXw3u2pOCZ0Rh9YFUNi1GCmn6C1kkqq8TkVAGs6fmXZm2bEeP1ir7doeFumL+oTVkn6ruhxenCogwKUH2UXgVRg0qjaqQGr0AAOOjeDCUsSnHbmyJvlQ/fSUVaDp7rzRKGQ4ESNY1bDRiKZrcK6zm+8oYJKmrbi3q66wxvrttYoH5/DRVZ/VHyNT33iIVgufYf9Xh3WEB/G5Uax0DYHu1htSYfhFxtRvISBwe62/a6w15T9rkdQTocnLA7eX0WT36dXfW5MF+017mnq6SUkkY4XtSRK2CFLa8c3280Mx7xJcTLvbamyTs/JIq5NITj63O9+/pvPCviwV/P2Wj8ytqfXA6Xg9wODW9Jrf2/dCMW4EnKdrqW9X9MO4RrHN3MjKpZ9CKuCDczqN1S4MMApRL5DNQk3OUO7lANeABoyaH4Hk6r7nes3OjKNjzysd65NtmvyTIqQKsMvomUkCTzMGr+my4/j/FFlSNB9puBlzCquLHqSrYE3/MuX2GS4e7VhJSeNXnA4eIoeMv2laFnOnSLt4tJaEK5/kXUbWEXy4O70g3eUCU6yDPQHVs7wDybJl2RlDP1IydmtQrfE5ISpqJGSkEzONbGd61c8m1xqwz3WtUltRge78xw8xCsXcGJ5ZPCIYxKogZ6hEQDw8h+GOzA+Y/iDN3h83LJe2zYT3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFc3VW80TVlqQ0IzRjI1WVZRL1dlK2wrdTRVZlg3VXRhQlVoZlpOUUdEMEhW?=
 =?utf-8?B?eENhdUdrSm9OaUY2V1RoSTNhK3phK2dhVjJKTFg0T2JvaWVTV0MxUHZHUDk4?=
 =?utf-8?B?R284TXdIaFd6SkF0ZDBrb01KL2VPM0tObWVjem1jeHZNWXhhelZZNUtRem91?=
 =?utf-8?B?TS8wL2NsbEtoMUkzMFM3bHZJelBUQjRrWlVhWHN0V2dPaG9IK3hqK0lRcmFh?=
 =?utf-8?B?L0tvQ2RkMGRIaXM0RjVyZHV0dzdjME11RHhQYVhXbTRiWlFmODNuRWJCTHFJ?=
 =?utf-8?B?eEYwVmZUaFo3c1hwNU5KWDI2dGU0VmpmNjhjSmNoTEdPbXdhVGRGRnQ2TWJ4?=
 =?utf-8?B?cGJDMUgweXlzWWNGTDVyRkMzVnFiak9NSkd2eW4zVXlsMmMwRlZsVG9SRE16?=
 =?utf-8?B?TVJsUlNvNUFsS1F1Q01ZaGE3d256U3RoMjloUUFXdWZYU0xMVVpGbm1kc2c2?=
 =?utf-8?B?ektWS25CUk9HR3FQTGM0OG1LS25yMVZQbjJBaTFZMGM1WEt5anQ5UWtjd2Jo?=
 =?utf-8?B?d2xPZktOdFluLzE1c1RueHlmOFRLK1VWMmg1ZUhJWGRJVGw4cUdUUUdDaE5S?=
 =?utf-8?B?ZE5pVDhULzBSNkZ2dUNhM1c1YTZISlVZWG1wWjZlOVRoQWMrRnp0ZkF3S2Ur?=
 =?utf-8?B?cnUxbW1RSDhUTTJrK0hJOVVnZTNtV24xaW92QnJGSE9VZnAzc3ZIc2Uyc3dl?=
 =?utf-8?B?YU93QkVodjhTcEVkdmhSVDdDb3dGcjRSd0tuZEtTSG1kb1B1dEp2NDRBcm02?=
 =?utf-8?B?UXNQd2d2djBYN3VoVTJtLzdUakI1aDlyaDZxR0pySEh5SS9NdzkxOGNrK0x1?=
 =?utf-8?B?eWRCbTlySWRkeDJGcjk3REJtMlp0VUQ1ZnJoN0luMFl0VHpMejQ1cVU3YjRp?=
 =?utf-8?B?bFZwbWlEei9LUkwyNWQzUkU4WWhNanRNbVIzR1J3OVIxUllLR3A4MlVhY0pW?=
 =?utf-8?B?d2JzSisvNGY5SGpvbjZ0MWtMS2p2RkpXcEQyVHdGUDBhS3lNT2tlajlHeFFi?=
 =?utf-8?B?YzRxVTE3UXB0aWFTdkJkVHJvcjlDK05rL0Y4NUJjd2dVcm1wRTY5czRZdmpR?=
 =?utf-8?B?Wm9NazVwU3pnMTBkdnFKZmhmRVpoQi9teHNSWHE0cUI2RXIwd3MycFBFZzBy?=
 =?utf-8?B?RmY2VmsxOU0ydjV4VXVXZkRHbHNOR3R0c0pQODJEdk9hR0s2L0pxQ05hVUlP?=
 =?utf-8?B?eEt5bkgvRnZsdWpHTHJoQXAxY1ZUZVgvTlp2d2JsNlh6TXZ1djk2cFAreklM?=
 =?utf-8?B?S0IyZVppUXRaVytUaFZUdGFxR2RLeTZERTNLV3hxeVU3SVpicjAwcUd5dGQw?=
 =?utf-8?B?MVV4dk05c0VIcVNETDJKOFUvMzJaL3F3dTdCcS9yNlFFOVN2WHJMQ0dKL0Q0?=
 =?utf-8?B?UmNrYklWSjgya2NnaFlaeW5QVUtFZE5jWUZrTitnMk1IWUJoZUNhcmdwRTdy?=
 =?utf-8?B?WEN3UGk0ZGxOOXRDTHdyTU1zZC9QVXFuek1IbkEvaHFCdnloYjcrQ25BckhE?=
 =?utf-8?B?a05iL205S2VLMEMzSWJwaThmZHc1ak1KVVVQOStJZlNHZDdEUit6d1l5ekZp?=
 =?utf-8?B?ZGd0R2Y0YldkdnZhVndFZjg0RXdtaEk3c3dSRWVyWm5pNml3Q0RGVERyczNv?=
 =?utf-8?B?Zkh0ZG9NWkd3Zk1nczBRR0dHZUJJWUplV3M4NUZkamJFSTc5MHF1YkVFR3Ay?=
 =?utf-8?B?eitMZFhzeXd2eGNLVkJPVyt1OEVHRXY0Z2ZqUWE0RWV4OUJEaTNPZjh1ZWRS?=
 =?utf-8?B?TzVJUlNhV2JUNnNHZGZUazNuVzBmVkhLYTRBN1VWcWpWU0JTQWtJaVZqMlRY?=
 =?utf-8?B?dkt2VlBhajl4ZXJNVzZ3bDdHcmJkeExJRWIvanF1aVdtVVpnSStRaFUrSmVl?=
 =?utf-8?B?dXA2L1pod09yZGJ3VjR3cENKaU0ybEcrUGZ0OWptb1AzYjRkVEFiVWExa3M0?=
 =?utf-8?B?OERPejdPZEJESmo1RzFLWGRhMXdnTmozbWhVTTBRb0E3WWhiTU1MdUY2WVhV?=
 =?utf-8?B?VnZNNkUyd3hnajRLUTBaVW01eWZZeTl4RXdGYVk3dmRTdUoraU1GMFlPc0RT?=
 =?utf-8?B?Z2Z5QWR6Sm9PYVlJRGNmQWtWTXNzYjdTeTlheVRaRmNhb3BDZzRlZHB3T1hT?=
 =?utf-8?B?MzFZZlFBbWY4c09PZjVOSkNIL20rVlJDUlI2aTFhdGxERWI0Wm12WlFnVEYv?=
 =?utf-8?B?VDRSQVVYR1pPZHJGakFKdGNKUTdZeWRaVFMwZWlPVHh2ZCtmM3VtTGorS2xq?=
 =?utf-8?B?SW5kc0F2dE9HS05UQk01QUxvREVUd3BYcXUyTXlnbEJ3cEVwaWM2MHFRWGRZ?=
 =?utf-8?B?dkZMY2hHVnN2VzRQbDFRUHNtVmFQbnRxVE5ySTFQd0NBcUdqeVlBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bf180d-4cc2-45d9-6257-08deaf644dbd
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:50:47.4086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jJJvVB2+mhzU0DByiQUc0DWgGegMzsEImrCgDxZPggT+6+LOlqxUUaszRVb+DRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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



On 11-May-26 6:12 PM, Andre Jun Hirata wrote:
> Use guard() and scoped_guard() for handling mutex lock instead of
> manually locking and unlocking the mutex. This prevents forgotten
> locks due to early exits and removes the need of gotos.
> 
> Signed-off-by: Andre Jun Hirata <andrejhirata@usp.br>
> Co-developed-by: Gabriel Dimant <gabriel.dimant@usp.br>
> Signed-off-by: Gabriel Dimant <gabriel.dimant@usp.br>
> Co-developed-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
> Signed-off-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> ---
> v2: incorporate Christian König's suggestions:
>    - use return f() directly instead of ret = f(); return ret;
>    - use early return pattern before guard() where applicable
> 
> v3: fix style nits pointed by Christian König:
>    - drop superfluous ret initialization in set_gfx_power_up_by_imu
>    - drop unnecessary braces around single-line scoped_guard
> 
> v4:
>   - fix build errors introduced in v3
>   - fix incorrect is_support_sw_smu() condition
>   - remove accidental "return =" typos
> 
> v5: fix incorrect diff in v4
> 
> v6: fix missing semicolon in smu_mode1_reset_is_support() return statement
> 

Thanks for the changes. A few more nits noted below. With those addressed,
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 868 +++++++++-------------------
>   1 file changed, 260 insertions(+), 608 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index feadf604b..e7ffb2b1b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -30,6 +30,7 @@
>   #include "amd_pcie.h"
>   #include "amdgpu_display.h"
>   #include "hwmgr.h"
> +#include <linux/cleanup.h>
>   #include <linux/power_supply.h>
>   #include "amdgpu_smu.h"
>   
> @@ -41,33 +42,25 @@
>   int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_sclk)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_sclk((adev)->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_sclk((adev)->powerplay.pp_handle,
>   				 low);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_mclk)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_mclk((adev)->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_mclk((adev)->powerplay.pp_handle,
>   				 low);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
> @@ -80,13 +73,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>   	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
>   	bool is_vcn = block_type == AMD_IP_BLOCK_TYPE_VCN;
>   
> -	mutex_lock(&adev->pm.mutex);
> -
> +	guard(mutex)(&adev->pm.mutex);
>   	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
>   			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
>   		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
>   				block_type, gate ? "gate" : "ungate");
> -		goto out_unlock;
> +		return ret;
>   	}
>   
>   	switch (block_type) {
> @@ -115,20 +107,16 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>   	if (!ret)
>   		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
>   
> -out_unlock:
> -	mutex_unlock(&adev->pm.mutex);
> -
>   	return ret;
>   }
>   
>   int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = -EOPNOTSUPP;
> +	int ret;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_set_gfx_power_up_by_imu(smu);
> -	mutex_unlock(&adev->pm.mutex);
> +	scoped_guard(mutex, &adev->pm.mutex)
> +		ret = smu_set_gfx_power_up_by_imu(smu);
>   
>   	msleep(10);
>   
> @@ -139,44 +127,31 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	void *pp_handle = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>   		return -ENOENT;
>   
> -	mutex_lock(&adev->pm.mutex);
> -
> +	guard(mutex)(&adev->pm.mutex);
>   	/* enter BACO state */
> -	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
> -
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	return pp_funcs->set_asic_baco_state(pp_handle, 1);
>   }
>   
>   int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	void *pp_handle = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>   		return -ENOENT;
>   
> -	mutex_lock(&adev->pm.mutex);
> -
> +	guard(mutex)(&adev->pm.mutex);
>   	/* exit BACO state */
> -	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
> -
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	return pp_funcs->set_asic_baco_state(pp_handle, 0);
>   }
>   
>   int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>   			     enum pp_mp1_state mp1_state)
>   {
> -	int ret = 0;
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
>   	if (mp1_state == PP_MP1_STATE_FLR) {
> @@ -184,23 +159,19 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>   		if (amdgpu_sriov_vf(adev))
>   			adev->pm.dpm_enabled = false;
>   	} else if (pp_funcs && pp_funcs->set_mp1_state) {
> -		mutex_lock(&adev->pm.mutex);
> -
> -		ret = pp_funcs->set_mp1_state(
> +		guard(mutex)(&adev->pm.mutex);
> +		return pp_funcs->set_mp1_state(
>   				adev->powerplay.pp_handle,
>   				mp1_state);
> -
> -		mutex_unlock(&adev->pm.mutex);
>   	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	void *pp_handle = adev->powerplay.pp_handle;
> -	int ret;
>   
>   	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
>   		return 0;
> @@ -216,49 +187,32 @@ int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>   	if (adev->in_s3)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -
> -	ret = pp_funcs->get_asic_baco_capability(pp_handle);
> -
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_asic_baco_capability(pp_handle);
>   }
>   
>   int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	void *pp_handle = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
>   		return -ENOENT;
>   
> -	mutex_lock(&adev->pm.mutex);
> -
> -	ret = pp_funcs->asic_reset_mode_2(pp_handle);
> -
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->asic_reset_mode_2(pp_handle);
>   }
>   
>   int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	void *pp_handle = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!pp_funcs || !pp_funcs->asic_reset_enable_gfx_features)
>   		return -ENOENT;
>   
> -	mutex_lock(&adev->pm.mutex);
> -
> -	ret = pp_funcs->asic_reset_enable_gfx_features(pp_handle);
> -
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->asic_reset_enable_gfx_features(pp_handle);
>   }
>   
>   int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
> @@ -270,75 +224,60 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
>   	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>   		return -ENOENT;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   
>   	/* enter BACO state */
>   	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
>   	if (ret)
> -		goto out;
> +		return ret;
>   
>   	/* exit BACO state */
>   	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
> -
> -out:
> -	mutex_unlock(&adev->pm.mutex);
>   	return ret;
>   }
>   
>   bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	bool support_mode1_reset = false;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		support_mode1_reset = smu_mode1_reset_is_support(smu);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!is_support_sw_smu(adev))
> +		return false;
>   
> -	return support_mode1_reset;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_mode1_reset_is_support(smu);
>   }
>   
>   int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = -EOPNOTSUPP;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = smu_mode1_reset(smu);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_mode1_reset(smu);
>   }
>   
>   bool amdgpu_dpm_is_link_reset_supported(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	bool support_link_reset = false;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		support_link_reset = smu_link_reset_is_support(smu);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!is_support_sw_smu(adev))
> +		return false;
>   
> -	return support_link_reset;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_link_reset_is_support(smu);
>   }
>   
>   int amdgpu_dpm_link_reset(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = -EOPNOTSUPP;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = smu_link_reset(smu);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_link_reset(smu);
>   }
>   
>   int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
> @@ -346,100 +285,82 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
>   				    bool en)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if (pp_funcs && pp_funcs->switch_power_profile) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->switch_power_profile(
> -			adev->powerplay.pp_handle, type, en);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->switch_power_profile)
> +		return 0;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->switch_power_profile(
> +			adev->powerplay.pp_handle, type, en);
>   }
>   
>   int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
>   				   bool pause)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if (pp_funcs && pp_funcs->pause_power_profile) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->pause_power_profile(
> -			adev->powerplay.pp_handle, pause);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->pause_power_profile)
> +		return 0;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->pause_power_profile(
> +			adev->powerplay.pp_handle, pause);
>   }
>   
>   int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
>   			       uint32_t pstate)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
> -	if (pp_funcs && pp_funcs->set_xgmi_pstate) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
> -								pstate);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->set_xgmi_pstate)
> +		return 0;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
> +								pstate);
>   }
>   
>   int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
>   			     uint32_t cstate)
>   {
> -	int ret = 0;
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	void *pp_handle = adev->powerplay.pp_handle;
>   
> -	if (pp_funcs && pp_funcs->set_df_cstate) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->set_df_cstate)
> +		return 0;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_df_cstate(pp_handle, cstate);
>   }
>   
>   ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
>   				      enum pp_pm_policy p_type, char *buf)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = -EOPNOTSUPP;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = smu_get_pm_policy_info(smu, p_type, buf);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_get_pm_policy_info(smu, p_type, buf);
>   }
>   
>   int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
>   			     int policy_level)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = -EOPNOTSUPP;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = smu_set_pm_policy(smu, policy_type, policy_level);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_set_pm_policy(smu, policy_type, policy_level);
>   }
>   
>   int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
> @@ -447,15 +368,12 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
>   	void *pp_handle = adev->powerplay.pp_handle;
>   	const struct amd_pm_funcs *pp_funcs =
>   			adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
> -	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->enable_mgpu_fan_boost)
> +		return 0;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->enable_mgpu_fan_boost(pp_handle);
>   }
>   
>   int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
> @@ -464,16 +382,13 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
>   	void *pp_handle = adev->powerplay.pp_handle;
>   	const struct amd_pm_funcs *pp_funcs =
>   			adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
> -	if (pp_funcs && pp_funcs->set_clockgating_by_smu) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->set_clockgating_by_smu(pp_handle,
> -						       msg_id);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->set_clockgating_by_smu)
> +		return 0;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_clockgating_by_smu(pp_handle,
> +						       msg_id);
>   }
>   
>   int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
> @@ -482,22 +397,19 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
>   	void *pp_handle = adev->powerplay.pp_handle;
>   	const struct amd_pm_funcs *pp_funcs =
>   			adev->powerplay.pp_funcs;
> -	int ret = -EOPNOTSUPP;
>   
> -	if (pp_funcs && pp_funcs->smu_i2c_bus_access) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->smu_i2c_bus_access(pp_handle,
> -						   acquire);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->smu_i2c_bus_access)
> +		return -EOPNOTSUPP;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->smu_i2c_bus_access(pp_handle,
> +						   acquire);
>   }
>   
>   void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>   {
>   	if (adev->pm.dpm_enabled) {
> -		mutex_lock(&adev->pm.mutex);
> +		guard(mutex)(&adev->pm.mutex);

Isn't scoped_guard more appropriate? Or may just return when 
(!adev->pm.dpm_enabled) to be consistent with the other changes.

>   		if (power_supply_is_system_supplied() > 0)
>   			adev->pm.ac_power = true;
>   		else
> @@ -510,7 +422,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>   		if (is_support_sw_smu(adev))
>   			smu_set_ac_dc(adev->powerplay.pp_handle);
>   
> -		mutex_unlock(&adev->pm.mutex);
>   	}
>   }
>   
> @@ -518,49 +429,40 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
>   			   void *data, uint32_t *size)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = -EINVAL;
>   
>   	if (!data || !size)
>   		return -EINVAL;
>   
> -	if (pp_funcs && pp_funcs->read_sensor) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->read_sensor(adev->powerplay.pp_handle,
> +	if (!pp_funcs || !pp_funcs->read_sensor)
> +		return -EINVAL;
> +
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->read_sensor(adev->powerplay.pp_handle,
>   					    sensor,
>   					    data,
>   					    size);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = -EOPNOTSUPP;
>   
> -	if (pp_funcs && pp_funcs->get_apu_thermal_limit) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->get_apu_thermal_limit(adev->powerplay.pp_handle, limit);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->get_apu_thermal_limit)
> +		return -EOPNOTSUPP;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_apu_thermal_limit(adev->powerplay.pp_handle, limit);
>   }
>   
>   int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = -EOPNOTSUPP;
>   
> -	if (pp_funcs && pp_funcs->set_apu_thermal_limit) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = pp_funcs->set_apu_thermal_limit(adev->powerplay.pp_handle, limit);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!pp_funcs || !pp_funcs->set_apu_thermal_limit)
> +		return -EOPNOTSUPP;
>   
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_apu_thermal_limit(adev->powerplay.pp_handle, limit);
>   }
>   
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
> @@ -583,9 +485,8 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   			amdgpu_fence_wait_empty(ring);
>   	}
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
> -	mutex_unlock(&adev->pm.mutex);
>   }
>   
>   void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
> @@ -593,14 +494,14 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>   	int ret = 0;
>   
>   	if (adev->family == AMDGPU_FAMILY_SI) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (enable) {
> -			adev->pm.dpm.uvd_active = true;
> -			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> -		} else {
> -			adev->pm.dpm.uvd_active = false;
> +		scoped_guard(mutex, &adev->pm.mutex) {
> +			if (enable) {
> +				adev->pm.dpm.uvd_active = true;
> +				adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +			} else {
> +				adev->pm.dpm.uvd_active = false;
> +			}
>   		}
> -		mutex_unlock(&adev->pm.mutex);
>   
>   		amdgpu_dpm_compute_clocks(adev);
>   		return;
> @@ -627,15 +528,15 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>   	int ret = 0;
>   
>   	if (adev->family == AMDGPU_FAMILY_SI) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (enable) {
> -			adev->pm.dpm.vce_active = true;
> -			/* XXX select vce level based on ring/task */
> -			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> -		} else {
> -			adev->pm.dpm.vce_active = false;
> +		scoped_guard(mutex, &adev->pm.mutex) {
> +			if (enable) {
> +				adev->pm.dpm.vce_active = true;
> +				/* XXX select vce level based on ring/task */
> +				adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +			} else {
> +				adev->pm.dpm.vce_active = false;
> +			}
>   		}
> -		mutex_unlock(&adev->pm.mutex);
>   
>   		amdgpu_dpm_compute_clocks(adev);
>   		return;
> @@ -670,84 +571,66 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
>   int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int r = 0;
> +	int ret = 0;

Ths init is not needed.>
>   	if (!pp_funcs || !pp_funcs->load_firmware ||
>   	    (is_support_sw_smu(adev) && (adev->flags & AMD_IS_APU)))
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	r = pp_funcs->load_firmware(adev->powerplay.pp_handle);
> -	if (r) {
> +	guard(mutex)(&adev->pm.mutex);
> +	ret = pp_funcs->load_firmware(adev->powerplay.pp_handle);
> +	if (ret) {
>   		pr_err("smu firmware loading failed\n");
> -		goto out;
> +		return ret;
>   	}
>   
>   	if (smu_version)
>   		*smu_version = adev->pm.fw_version;
>   
> -out:
> -	mutex_unlock(&adev->pm.mutex);
> -	return r;
> +	return ret;
>   }
>   
>   int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool enable)
>   {
> -	int ret = 0;
> +	if (!is_support_sw_smu(adev))
> +		return 0;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		ret = smu_handle_passthrough_sbr(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_handle_passthrough_sbr(adev->powerplay.pp_handle,
>   						 enable);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_send_hbm_bad_pages_num(smu, size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_send_hbm_bad_pages_num(smu, size);
>   }
>   
>   int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t size)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_send_hbm_bad_channel_flag(smu, size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_send_hbm_bad_channel_flag(smu, size);
>   }
>   
>   int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_send_rma_reason(smu);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_send_rma_reason(smu);
>   }
>   
>   /**
> @@ -761,61 +644,45 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
>   bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	bool ret;
>   
>   	if (!is_support_sw_smu(adev))
>   		return false;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_reset_sdma_is_supported(smu);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_reset_sdma_is_supported(smu);
>   }
>   
>   int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_reset_sdma(smu, inst_mask);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_reset_sdma(smu, inst_mask);
>   }
>   
>   int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_reset_vcn(smu, inst_mask);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_reset_vcn(smu, inst_mask);
>   }
>   
>   bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	bool ret;
>   
>   	if (!is_support_sw_smu(adev))
>   		return false;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_reset_vcn_is_supported(smu);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_reset_vcn_is_supported(smu);
>   }
>   
>   int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
> @@ -823,22 +690,17 @@ int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>   				  uint32_t *min,
>   				  uint32_t *max)
>   {
> -	int ret = 0;
> -
>   	if (type != PP_SCLK)
>   		return -EINVAL;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_get_dpm_freq_range(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_get_dpm_freq_range(adev->powerplay.pp_handle,
>   				     SMU_SCLK,
>   				     min,
>   				     max);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
> @@ -862,16 +724,12 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>   int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_write_watermarks_table(smu);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_write_watermarks_table(smu);
>   }
>   
>   int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
> @@ -879,76 +737,56 @@ int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
>   			      uint64_t event_arg)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_wait_for_event(smu, event, event_arg);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_wait_for_event(smu, event, event_arg);
>   }
>   
>   int amdgpu_dpm_set_residency_gfxoff(struct amdgpu_device *adev, bool value)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_set_residency_gfxoff(smu, value);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_set_residency_gfxoff(smu, value);
>   }
>   
>   int amdgpu_dpm_get_residency_gfxoff(struct amdgpu_device *adev, u32 *value)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_get_residency_gfxoff(smu, value);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_get_residency_gfxoff(smu, value);
>   }
>   
>   int amdgpu_dpm_get_entrycount_gfxoff(struct amdgpu_device *adev, u64 *value)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_get_entrycount_gfxoff(smu, value);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_get_entrycount_gfxoff(smu, value);
>   }
>   
>   int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_get_status_gfxoff(smu, value);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_get_status_gfxoff(smu, value);
>   }
>   
>   uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
> @@ -969,28 +807,23 @@ uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
>   void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
>   				 enum gfx_change_state state)
>   {
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	if (adev->powerplay.pp_funcs &&
>   	    adev->powerplay.pp_funcs->gfx_state_change_set)
>   		((adev)->powerplay.pp_funcs->gfx_state_change_set(
>   			(adev)->powerplay.pp_handle, state));
> -	mutex_unlock(&adev->pm.mutex);
>   }
>   
>   int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>   			    void *umc_ecc)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
>   
>   	if (!is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_get_ecc_info(smu, umc_ecc);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return smu_get_ecc_info(smu, umc_ecc);
>   }
>   
>   struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
> @@ -1002,12 +835,9 @@ struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
>   	if (!pp_funcs->get_vce_clock_state)
>   		return NULL;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	vstate = pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
>   					       idx);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return vstate;
>   }
>   
>   void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
> @@ -1015,28 +845,24 @@ void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   
>   	if (!pp_funcs->get_current_power_state) {
>   		*state = adev->pm.dpm.user_state;
> -		goto out;
> +		return;
>   	}
>   
>   	*state = pp_funcs->get_current_power_state(adev->powerplay.pp_handle);
>   	if (*state < POWER_STATE_TYPE_DEFAULT ||
>   	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
>   		*state = adev->pm.dpm.user_state;
> -
> -out:
> -	mutex_unlock(&adev->pm.mutex);
>   }
>   
>   void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>   				enum amd_pm_state_type state)
>   {
> -	mutex_lock(&adev->pm.mutex);
> -	adev->pm.dpm.user_state = state;
> -	mutex_unlock(&adev->pm.mutex);
> +	scoped_guard(mutex, &adev->pm.mutex)
> +		adev->pm.dpm.user_state = state;
>   
>   	if (is_support_sw_smu(adev))
>   		return;
> @@ -1055,12 +881,11 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
>   	if (!pp_funcs)
>   		return AMD_DPM_FORCED_LEVEL_AUTO;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	if (pp_funcs->get_performance_level)
>   		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
>   	else
>   		level = adev->pm.dpm.forced_level;
> -	mutex_unlock(&adev->pm.mutex);
>   
>   	return level;
>   }
> @@ -1151,17 +976,13 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
>   				 struct pp_states_info *states)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_pp_num_states)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
>   					  states);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
> @@ -1169,24 +990,19 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
>   			      enum amd_pm_state_type *user_state)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->dispatch_tasks)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
>   				       task_id,
>   				       user_state);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!table)
>   		return -EINVAL;
> @@ -1194,12 +1010,9 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
>   	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_pp_table(adev->powerplay.pp_handle,
>   				     table);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
> @@ -1208,19 +1021,15 @@ int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
>   				      uint32_t size)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_fine_grain_clk_vol)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
>   					       type,
>   					       input,
>   					       size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
> @@ -1229,19 +1038,15 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
>   				  uint32_t size)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->odn_edit_dpm_table)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
>   					   type,
>   					   input,
>   					   size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
> @@ -1250,52 +1055,40 @@ int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
>   				  int *offset)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->emit_clock_levels)
>   		return -ENOENT;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
>   					   type,
>   					   buf,
>   					   offset);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
>   				    uint64_t ppfeature_masks)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_ppfeature_status)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
>   					     ppfeature_masks);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_ppfeature_status)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
>   					     buf);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
> @@ -1303,33 +1096,25 @@ int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
>   				 uint32_t mask)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->force_clock_level)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->force_clock_level(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->force_clock_level(adev->powerplay.pp_handle,
>   					  type,
>   					  mask);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_sclk_od)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
>   }
>   
>   int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
> @@ -1339,10 +1124,10 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
>   	if (is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	if (pp_funcs->set_sclk_od)
> -		pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
> -	mutex_unlock(&adev->pm.mutex);
> +	scoped_guard(mutex, &adev->pm.mutex) {
> +		if (pp_funcs->set_sclk_od)

Since this is redone anyway, better to reverse the order - check if 
pointer exists and then take a mutex guard before setting. That is more 
aligned to scoped_guard.

> +			pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
> +	}
>   
>   	if (amdgpu_dpm_dispatch_task(adev,
>   				     AMD_PP_TASK_READJUST_POWER_STATE,
> @@ -1357,16 +1142,12 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
>   int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_mclk_od)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
>   }
>   
>   int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
> @@ -1376,10 +1157,10 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
>   	if (is_support_sw_smu(adev))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	if (pp_funcs->set_mclk_od)
> -		pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
> -	mutex_unlock(&adev->pm.mutex);
> +	scoped_guard(mutex, &adev->pm.mutex) {
> +		if (pp_funcs->set_mclk_od)

Same as earlier, consider reversing the order.
> +			pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
> +	}
>   
>   	if (amdgpu_dpm_dispatch_task(adev,
>   				     AMD_PP_TASK_READJUST_POWER_STATE,
> @@ -1395,170 +1176,130 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
>   				      char *buf)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_power_profile_mode)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
>   					       buf);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
>   				      long *input, uint32_t size)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_power_profile_mode)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
>   					       input,
>   					       size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_gpu_metrics)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
>   					table);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
>   				  size_t size)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_pm_metrics)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metrics,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metrics,
>   				       size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
>   				    uint32_t *fan_mode)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_control_mode)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
>   					     fan_mode);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
>   				 uint32_t speed)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_speed_pwm)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
>   					  speed);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
>   				 uint32_t *speed)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_speed_pwm)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
>   					  speed);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
>   				 uint32_t *speed)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_fan_speed_rpm)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
>   					  speed);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
>   				 uint32_t speed)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_speed_rpm)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
>   					  speed);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
>   				    uint32_t mode)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_fan_control_mode)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
>   					     mode);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
> @@ -1567,19 +1308,15 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
>   			       enum pp_power_type power_type)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_power_limit)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_power_limit(adev->powerplay.pp_handle,
>   					limit,
>   					pp_limit_level,
>   					power_type);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
> @@ -1587,17 +1324,13 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
>   			       uint32_t limit)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_power_limit)
>   		return -EINVAL;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_power_limit(adev->powerplay.pp_handle,
>   					limit_type, limit);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
> @@ -1607,9 +1340,8 @@ int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
>   	if (!is_support_sw_smu(adev))
>   		return false;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	cclk_dpm_supported = is_support_cclk_dpm(adev);

May return directly here.


Thanks,
Lijo

> -	mutex_unlock(&adev->pm.mutex);
>   
>   	return (int)cclk_dpm_supported;
>   }
> @@ -1622,10 +1354,9 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
>   	if (!pp_funcs->debugfs_print_current_performance_level)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	pp_funcs->debugfs_print_current_performance_level(adev->powerplay.pp_handle,
>   							  m);
> -	mutex_unlock(&adev->pm.mutex);
>   
>   	return 0;
>   }
> @@ -1635,18 +1366,14 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>   				       size_t *size)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_smu_prv_buf_details)
>   		return -ENOSYS;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
>   						addr,
>   						size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
> @@ -1698,7 +1425,6 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>   			    size_t size)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!buf || !size)
>   		return -EINVAL;
> @@ -1706,13 +1432,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>   	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_pp_table(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_pp_table(adev->powerplay.pp_handle,
>   				     buf,
>   				     size);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev)
> @@ -1737,17 +1460,13 @@ int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
>   					    const struct amd_pp_display_configuration *input)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->display_configuration_change)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->display_configuration_change(adev->powerplay.pp_handle,
>   						     input);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
> @@ -1755,35 +1474,27 @@ int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
>   				 struct amd_pp_clocks *clocks)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_clock_by_type)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_clock_by_type(adev->powerplay.pp_handle,
>   					  type,
>   					  clocks);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_display_mode_validation_clks(struct amdgpu_device *adev,
>   						struct amd_pp_simple_clock_info *clocks)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_display_mode_validation_clocks)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_display_mode_validation_clocks(adev->powerplay.pp_handle,
>   							   clocks);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
> @@ -1791,18 +1502,14 @@ int amdgpu_dpm_get_clock_by_type_with_latency(struct amdgpu_device *adev,
>   					      struct pp_clock_levels_with_latency *clocks)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_clock_by_type_with_latency)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_clock_by_type_with_latency(adev->powerplay.pp_handle,
>   						       type,
>   						       clocks);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
> @@ -1810,69 +1517,53 @@ int amdgpu_dpm_get_clock_by_type_with_voltage(struct amdgpu_device *adev,
>   					      struct pp_clock_levels_with_voltage *clocks)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_clock_by_type_with_voltage)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_clock_by_type_with_voltage(adev->powerplay.pp_handle,
>   						       type,
>   						       clocks);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_watermarks_for_clocks_ranges(struct amdgpu_device *adev,
>   					       void *clock_ranges)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_watermarks_for_clocks_ranges)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_watermarks_for_clocks_ranges(adev->powerplay.pp_handle,
>   							 clock_ranges);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_display_clock_voltage_request(struct amdgpu_device *adev,
>   					     struct pp_display_clock_request *clock)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->display_clock_voltage_request)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->display_clock_voltage_request(adev->powerplay.pp_handle,
>   						      clock);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_current_clocks(struct amdgpu_device *adev,
>   				  struct amd_pp_clock_info *clocks)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_current_clocks)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_current_clocks(adev->powerplay.pp_handle,
>   					   clocks);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
> @@ -1882,43 +1573,34 @@ void amdgpu_dpm_notify_smu_enable_pwe(struct amdgpu_device *adev)
>   	if (!pp_funcs->notify_smu_enable_pwe)
>   		return;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	pp_funcs->notify_smu_enable_pwe(adev->powerplay.pp_handle);
> -	mutex_unlock(&adev->pm.mutex);
>   }
>   
>   int amdgpu_dpm_set_active_display_count(struct amdgpu_device *adev,
>   					uint32_t count)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_active_display_count)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_active_display_count(adev->powerplay.pp_handle,
>   						 count);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_set_min_deep_sleep_dcefclk(struct amdgpu_device *adev,
>   					  uint32_t clock)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->set_min_deep_sleep_dcefclk)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->set_min_deep_sleep_dcefclk(adev->powerplay.pp_handle,
>   						   clock);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
> @@ -1929,10 +1611,9 @@ void amdgpu_dpm_set_hard_min_dcefclk_by_freq(struct amdgpu_device *adev,
>   	if (!pp_funcs->set_hard_min_dcefclk_by_freq)
>   		return;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	pp_funcs->set_hard_min_dcefclk_by_freq(adev->powerplay.pp_handle,
>   					       clock);
> -	mutex_unlock(&adev->pm.mutex);
>   }
>   
>   void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
> @@ -1943,44 +1624,35 @@ void amdgpu_dpm_set_hard_min_fclk_by_freq(struct amdgpu_device *adev,
>   	if (!pp_funcs->set_hard_min_fclk_by_freq)
>   		return;
>   
> -	mutex_lock(&adev->pm.mutex);
> +	guard(mutex)(&adev->pm.mutex);
>   	pp_funcs->set_hard_min_fclk_by_freq(adev->powerplay.pp_handle,
>   					    clock);
> -	mutex_unlock(&adev->pm.mutex);
>   }
>   
>   int amdgpu_dpm_display_disable_memory_clock_switch(struct amdgpu_device *adev,
>   						   bool disable_memory_clock_switch)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->display_disable_memory_clock_switch)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->display_disable_memory_clock_switch(adev->powerplay.pp_handle,
>   							    disable_memory_clock_switch);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_max_sustainable_clocks_by_dc(struct amdgpu_device *adev,
>   						struct pp_smu_nv_clock_table *max_clocks)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_max_sustainable_clocks_by_dc)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_max_sustainable_clocks_by_dc(adev->powerplay.pp_handle,
>   							 max_clocks);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
> @@ -1988,35 +1660,27 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>   						  unsigned int *num_states)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_uclk_dpm_states)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_uclk_dpm_states(adev->powerplay.pp_handle,
>   					    clock_values_in_khz,
>   					    num_states);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>   				   struct dpm_clocks *clock_table)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_dpm_clock_table)
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_dpm_clock_table(adev->powerplay.pp_handle,
>   					    clock_table);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   /**
> @@ -2037,17 +1701,13 @@ ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
>   				    enum smu_temp_metric_type type, void *table)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret;
>   
>   	if (!pp_funcs->get_temp_metrics ||
>   	    !amdgpu_dpm_is_temp_metrics_supported(adev, type))
>   		return -EOPNOTSUPP;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_temp_metrics(adev->powerplay.pp_handle, type, table);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_temp_metrics(adev->powerplay.pp_handle, type, table);
>   }
>   
>   /**
> @@ -2064,19 +1724,15 @@ bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
>   					  enum smu_temp_metric_type type)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	bool support_temp_metrics = false;
>   
>   	if (!pp_funcs->temp_metrics_is_supported)
> -		return support_temp_metrics;
> +		return false;
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		support_temp_metrics =
> -			pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +	if (!is_support_sw_smu(adev))
> +		return false;
>   
> -	return support_temp_metrics;
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
>   }
>   
>   /**
> @@ -2098,17 +1754,13 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
>   				   void *table)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	int ret = 0;
>   
>   	if (!pp_funcs->get_xcp_metrics)
>   		return 0;
>   
> -	mutex_lock(&adev->pm.mutex);
> -	ret = pp_funcs->get_xcp_metrics(adev->powerplay.pp_handle, xcp_id,
> +	guard(mutex)(&adev->pm.mutex);
> +	return pp_funcs->get_xcp_metrics(adev->powerplay.pp_handle, xcp_id,
>   					table);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>   }
>   
>   const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev)

