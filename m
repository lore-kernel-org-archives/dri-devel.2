Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584BCC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83F610E367;
	Fri, 24 Jul 2026 02:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egQ2tt60";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDD010F27A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBTUwlq6+1J506O/jmMdVmZx3i+kBmKij1JGtR9jngAjnU7Egrbu5jts0WTjfVMQqSrPLps1JlSF8bGcflEwG9sOLsOfASgBfudLFJy3qeIA5fRl/t4ozwYotRVOhdU6Hep16H0PBrEYZLBvYXnzXwFfL2P7RNKf77WeNU7SrZcrrfZjzp+SwTTD6y3gpJo5yOMhiRhjl1vzJRtX56dd3IlRw72Isx7pyhZBIf8gJb0M7z64iiKuMbHPUU0u9+LJb0XMsEuJYtxnzysjblBK7jvVZGFDScEJBhHtzJUyh70pU6Vh0sm4HX4aHOYkT54vZqk2S/4nOM8QP04/o9tPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vihIF1UYeuVspy/Y0EiErscNFHWoWOCxAfupTl5+7M=;
 b=fpKnYiEh4AgYmsdF3YGRYWOgaz9Dh7Ah1VLwdgvUgUN/6xzAmmorF/LJTQmlapnSmwMZvsnGEK8YdSvnmBdyog2yntwZe28KntMrkJPE0yglbnd0uTwW6AX1W55/EuQR806tk/COne3ZB3XWqIaWM5why+yt3rd52rM2GDoYmLcabEuM+B36ABEMK3YEwm883BixkEsOFaCfw0ljeJ9DXWDe6HEgWt7JgBi2Wa6+uDXYxmAnaQFxOg6QQnxE9Bg5Knp7UqO+8usfbdg18yJ4HVF+03UtAlgqgXDc3pseTg136poh+Su7e4bf9ZwEH6a3tDkV/IQU7VDVUs58jabgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vihIF1UYeuVspy/Y0EiErscNFHWoWOCxAfupTl5+7M=;
 b=egQ2tt60XOhc7kg+8+Yrr17iAsO27f6SHhrOgkK4y9iYjSv0/Ie56DH68Xzud6PReW/8khb91t14TAH5nTVC6WbUlLyos3UbSGNTC0Pil59Mqwu0cHiY/ISxYz+5EyfzaFvWPZ67P2RxV2cXejehSGOfkz+H654fxmu5v9kP/3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 02:39:25 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:39:25 +0000
Message-ID: <640dbef3-0e7d-46e7-b9f2-57ca341eef5f@amd.com>
Date: Thu, 23 Jul 2026 20:39:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] drm/amd/display: use drmm allocation for writeback
 connector
To: John Harrison <John.Harrison@Igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
 <20260723003205.330362-3-John.Harrison@Igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260723003205.330362-3-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f8eb15-e9fe-41f3-9ed1-08dee92cc684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +aB4yKh7Ypmk+uYH2XR3No5DSmLsgV73f6ItV0o6O8tt4HcX4eE1AtZMyfkFaTf81WYI7AZfUhJg7mA06PLy/eGCVPLgp4ccE+PegstwpiaKmVFxLR1A7Vtslh5v/7plhWcT6xikf7UcnsoHiEQ0c6TQNOdgT6kh7Hn2EMn7SUcOxqvArgoD4vE3OnzxUgq22+h69O8xBjlbJFxsRTsPUiSYZ595VEKB2FbrnJRe08qyTD1IartPYYUBg2Sp0eVxfZSAr85Ps/9My+Dy92O16h5SLPH5EioEAX2mVUPQHQJQQdoDZuk8wWzffR+VOCtToaG6nub4WcLG+pAgZiTAqvwu10qB25es/mYdB0nk8C8RmO4Xbls+j3ux7TSS6ETAunPxDuGuOLf5IDkeUYJ8vrLMS17xxnOI9gUeJq7xSVLexUsT91oB0qXewG/f6hZBLPFUvdq4LB9ziOwzSd8QCrCjCb9knzf5v2DCMsQhkyBk2NLIhkxteUV5rcJcDFrzLLxN2rX/zrRqxcO+fH9PWvENv+4ykB7gH770BDxajDRCOegdcE4sljXAb36En7jv2l33kSgrTQVYpCc1dPxgcPunImaCcDFoqSpLPUGPS/+NYO5OM2dC9+m/ajlJbVXDKcT8mSnmPHtdTybCIQRvjF5hfOHfFzxGpTJdFSn1D74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZFR3pNTXlZdndpRkNlSmhPOW1xUVI4MS8wV2tnL2tLbGtKcEQzR1lzYTlt?=
 =?utf-8?B?Rk85MmFoKzVVWWFiWFBOdXNGV1MxR3E4SE1xbHpReCs1bGdFdEl4U0J4NVBw?=
 =?utf-8?B?OVJnYXc0dkdodnprU3pqV0MyZjNtT0dUYTR4azdzYkJCL1pwUloxVlhNRUly?=
 =?utf-8?B?aWVkZTFzcUR2M3NyUW4wMUlrdnVvZWtUMUlaclV6OGJ4ZzZaV3FnMGVIc0Fw?=
 =?utf-8?B?cVhOQzFDOFBLOXRDSG5lTk11UmRsZWpmRGEzcm1uakNrWlpaRlVuaUpZR3BC?=
 =?utf-8?B?cXEvVlhYWFBHblFUMXlHZHMvb1k5dGpqZmZTS28xYTZrR2dkTng5MVdXNFRZ?=
 =?utf-8?B?Wk9QWFFWTWZvUWptck5IcXVOcGhxYjBZUWtuSXBUc2FBWVgzMmMvWjgvQzdm?=
 =?utf-8?B?MThlNnM5eHlUaVBNR2J5aEU5RUNPOGVjZUJLLzN2b212N3BGQkZxS0w4Nk5J?=
 =?utf-8?B?TjMwb0F0aXZnNGhCaXRlRmFVWWl3S1U0ZzZLUHFpblliSlRzSm5vQ0JSb3BD?=
 =?utf-8?B?K3pubmZOY2Z5ak1IWmY4TXdwK1VIOG5OZlQ1YzRDekR0aDVYaGhQZzlmY09l?=
 =?utf-8?B?WTBNWnBEUFIrUHdJYzlRNUJvOEE5NGN5UjJPYm5rRzdFSDJYRUFNSHA4cytR?=
 =?utf-8?B?Y2JqQlFIajA4NDgyem1YTW9VanAyd0tlZHJPTjM4VDZVRWpRZGYvUWduWXE0?=
 =?utf-8?B?QXlLcUVqaGQ4c1ZTWjRUejQvZGE0L25HMk1vZXUrR2hNYnZ3SGQxS3oxU0Uy?=
 =?utf-8?B?M1Zrc3RJOGhFcmVqZzdyN1EyalFoOEY5enlQV0xHc2JmbUY4M1hhNUprU0ZT?=
 =?utf-8?B?WElwMXZHSjJodzJrdWg5RlRzSmFIMk44NTNvYXdvVzgwL01TZEcveE44VjEr?=
 =?utf-8?B?d3ZNVzBGeEtpMEJzRm83VUI3aE5oYzczaEc5QWtnT3NYMjV2OVRCUWFyVWRw?=
 =?utf-8?B?bGxtdmdYbG9jbWFsdjVZZkpTdUZPZzJiWVRoVDBvazNSVjFTMFk5aE1xQVRy?=
 =?utf-8?B?anZTUXlxL21CQXNaRWU0RWVDZnR1R2tabVdnanNEZjNSWkg0dzI5NEhEVG8x?=
 =?utf-8?B?WUxTejJ3Uko4OGd4bUxGSTFFaVRDNmorNWRFdnN3WlExMVBuS1pGRDMwVFpE?=
 =?utf-8?B?NjFTTlhtTUswRitzbDNWa0tFM2x0aThhUFRhYWlWSFhuUTV3Zlo1ZkdIYWYy?=
 =?utf-8?B?dmFMK2gxZXJCeUcvMzdYWTlJZTdSUVdoN1pPUE11eEExSUNiL3YrMlMxeldx?=
 =?utf-8?B?UDd2dUNBK3k2UFNBam1wN0ptczRZc0huZFUydjhDdEZqeTZqS29EMzFRVElR?=
 =?utf-8?B?SkRSelprMnJJMVJYNTNBVUQzQzNsM0ZBM0JPd1kvM3RqMkpDV3llZHAvUG93?=
 =?utf-8?B?Tk81eW4xdC9WMnFIMENpY3JXNWkrZTRLeVN5UGNkYlpwK3h1cDFWaWR6ZHFv?=
 =?utf-8?B?bjEyRTNiY1RxR2tsOVAyTmdpK2QvT3hwTHl1OTAzeStFdGh0VzRFZ1N0dG1B?=
 =?utf-8?B?R1VveDRLT3NoYVVVSkFqSGtYS1hVVzcyWjBVWEJHYjhSVnJYZXZwR0hleW91?=
 =?utf-8?B?UnhET2luM2kwSENDbURLamdkdiszUkgyK2NkTEVaSytjRDlabVh3RjU3RHY2?=
 =?utf-8?B?YjFYaTZCQTVybkhaQUVPSTg2UDRxRDBEUGRiUWFpSmNibTFiZnJuS3ZxTXNJ?=
 =?utf-8?B?UkN0NStYMHNQWjhXZHh2MWZsRlA4K0VGZlZMaldudmM2REV4eGluYVRPOU0r?=
 =?utf-8?B?S09qdG4vSklQVGdzK1JaSGpiSjZic2lWKzJJMW92eWpaZWsvRUd0Z0NnZEM2?=
 =?utf-8?B?K1FzaWR6djNDSnQ5UGo2WGp2MnI3c3pNVzlBOGhwRlgxcUo4Um4raENSdi9S?=
 =?utf-8?B?cHYwenUxV3YxUTRBMlAvSEQ3a2UyUUQyYW5YSjFyM2orbGt0SEVRYWk3MmE4?=
 =?utf-8?B?a00wNHZkWW1nZkJkVVM1Y0RHSTVHSGoyZG4wQi9hVGNVdmVKV0lNREN4WkJl?=
 =?utf-8?B?bnV0UENvdlIvZkFmMyt5MkUweGtyL2dLTklkNk5qS0VWUVpMS3AvdUh2enVX?=
 =?utf-8?B?NmlIeDkyRmg4a1pBNUJHeEh1T1B2QlRrRHMzcVhic2x0Q2IrbC9jaE9qT094?=
 =?utf-8?B?clBTV2hpNjJ3eW5ZVE00alJHTlRBSFMrSm10c3NITE96a1BSVngwNVpvVjlm?=
 =?utf-8?B?Z0ZmSnI0VjlzRG5JZGx4cnlQTXRMNklqamEwdjVWNmZncE53WEt4cytLS0Zm?=
 =?utf-8?B?VlVwWFpXNDBNb0VoL055a3JseFlKSnp2SE9LUkhlemsxWnBweGVJWHVicGtV?=
 =?utf-8?Q?loCsks2gepEwNuNw4N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8eb15-e9fe-41f3-9ed1-08dee92cc684
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:39:25.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OerHGmRGbla2CnBWPzPmBL/2VQ/4ycplkUopv3XwMLK570R8flu49FsMav+xignxJWba1YccECEQvvESjnrAvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 7/22/26 18:31, John Harrison wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Currently memory used for writeback connectors isn't freed on driver
> unbinding, leaking the memory. Use drm_device-memory allocation
> function for the writeback connector, making sure that the memory is
> freed on the driver unbinding.
> 
> v2: Fix missing parameter.
> v3: Drop drmm_kfree in error path as unnecessary and causes problems
> with dangling clean up code.
> 
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Suggested-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e7080880b221..9c49374a2cbb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -96,6 +96,7 @@
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_eld.h>
> +#include <drm/drm_managed.h>
>   #include <drm/drm_mode.h>
>   #include <drm/drm_utils.h>
>   #include <drm/drm_vblank.h>
> @@ -2621,7 +2622,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		link = dc_get_link_at_index(dm->dc, i);
>   
>   		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
> -			struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
> +			struct amdgpu_dm_wb_connector *wbcon = drmm_kzalloc_obj(adev_to_drm(adev), *wbcon);
>   
>   			if (!wbcon) {
>   				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connector\n");
> @@ -2630,7 +2631,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   
>   			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>   				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback connector\n");
> -				kfree(wbcon);
>   				continue;
>   			}
>   

