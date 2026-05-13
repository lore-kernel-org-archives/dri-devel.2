Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBECCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFAC10E308;
	Wed, 13 May 2026 13:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uNExFU4G";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223EE10E308;
 Wed, 13 May 2026 13:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svtUx6DgWYbdsMJ5PZ9ZnapftB3M7p/BRTJAv64uRsxUA8S8cOYwnQU+T0GSaGyQf8IZ2Bx/TXYolt9H12cfGDSjo0hBdzkK39WcdpwjqvRc4CJgiky+NQdoyEahbkBus975WP4NP4s0WhFQ/scljcdK/nBrM7CjXJjSbAuI2/xrk9HpBUU6QeLbeAiua17eYV+NdSOoLGT9QU5M0ZgYdCP9l3gq3EG44i4yHF0CVt4PjjFYvDGQv3nJntMfHGPYK20opv68EYe/9Lx4z62Mpl0G2ta6DzvEi+O6IuAeeYWxOqzGpVMnDWJ+4/dyc2wxZvh4k4yEfnIOTCAMQXQ4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x1A8t306T9UZqAAd6Hb1XOKe9GVHQa/bsleg7FBmiU=;
 b=Wi4sYZk9Rhbm61DgkUjznEefmDidLblOAqTyjodWDfETyW+WqX87exuwqWihiPrQRUaRlNUuOrJXWLhHV6SONeClc5HEWARYTf4Ppg49ylBhMrwBYA+llTSwoqlYR5HRulaLa8V1m2Tn36Fdz1HEq+3EBUSFJb9VhwwHB8pIV0rc/aM+4mDCSnPUMYg4gDajAbVc8+drN/hRnMW+0Q1WpNAVxdIcDGEBGYIui/Y4X74/rrQx1xsNbTH6fNyBwZRJNY5xQ6oez75PAFvBSJZ3BbjxLNaY+0EttL5Lpvs5WE8BIAP+etKRsHaENYpQB/wMDuHSpMF9vbzn5V09XjAlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x1A8t306T9UZqAAd6Hb1XOKe9GVHQa/bsleg7FBmiU=;
 b=uNExFU4GLnl1n4mWMBYdIEuBatK6H2IpRqezVbJR74Aat80I41wbdQNPpOLbU12uebV3xcbWySvCP4UkqQhUU//wq7JuNPFsIV3dHXTkBJ9oUeR31LC0Cbr8lM2ZrgQmlVzMNXEUjcAQPsxMJlhmSY4QnMYO0aMFJJaG/IxZ2E8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:47:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 13:47:43 +0000
Message-ID: <901369e4-9763-4477-a908-86ac8d77cb4e@amd.com>
Date: Wed, 13 May 2026 15:47:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/amdgpu: hook up ZONE_DEVICE registration in
 device init and reset
To: Junhua Shen <Junhua.Shen@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 honglei1.huang@amd.com, Lingshan.Zhu@amd.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260513095734.69598-1-Junhua.Shen@amd.com>
 <20260513095734.69598-6-Junhua.Shen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260513095734.69598-6-Junhua.Shen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 7701dc2c-daac-428b-d77b-08deb0f63520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: KOElgTviXDCFvm1P2dUu+5qpVdGqHFi/cZcwPd07S7nVbNhoaREQSY9I/O+zH5vBqaiGlKW6YMX2O3oHTm0t/wYKmXgEhchS2Nw598jJghARwoA1zmu4YXyIEy61dwPXfyHH+A9vc7fi0HY/eJPl1MRsZQd8JLYWs7vhlluBxVbBLHksbAp7aXADyX2S9MKwkvNWSGBlMnsMwvw1XJwXmsyuRQuj54wVImXoao/8AdR+vf1n8aAmsYA4a324THAuL3joLZKow3Ip1LYhSU/OGxeppM9dN63cIxIBvVgtOOj017m38Ch15kedmYC3WwnTRvXZhSGbZ/2D3t1aFTYfVDddJdAduf6p0gCd0YgaFqfdAZDaovEQT2zaZF7qc1syqsJpTqdy8BIaC+JnpQdLgoHzsN7HnAH7ra7Q+TCaVhGwYkHvvdXDZmjomEwgxD1b8R4+yooo+ODGIsHinFch7nIyZ3EiAtcHpWKS9vR68GwkYEqk4jqahsuu63wk3mx+uRQ2FgCYspB1ZetZ14n61oAWYhPSbVVXmI4W7nQAdDnIIC2YfYySd6kZu6pBFzluMkfUQd/A5rE1MqMY/O95FWBBEgzrvbMX5RzzdU03ZH0jpqz8+esl5Dz6txtMr7nuVgPOXLIfOTJGtVaUPDGHREL16TbIKUl/TT4wuuwwj59uVdV2VIqgH8Bak24xN9b35mhFwsg1NW/FBK/MtFHbqlbtKuaQNfkG/kVQKrdrJco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VktXNFZDM2wzekZwSW45YWZtb01CMzJMNlFySVlGam9RakVsdXUzcG1kaHJi?=
 =?utf-8?B?OEZSVDJpajRqRUFFRUNIY2QzTXVYOUV1Y0kybkpPaGR4ZXhGYU9JUm0wRTJh?=
 =?utf-8?B?UjRQUW1mL2lqYm55MC9mdTVRL1hCTEZGNjBxZEsySlVTcnVaN2Z3SHlvamlx?=
 =?utf-8?B?RTdVbWI2ZGxOclZzK0VBUW5DdFFzcUJOcUhJSnpqN3NIYUFkSWFSaWgxdWo2?=
 =?utf-8?B?eTJiRlVnS0FESE5Fcm1Mc1R6U1pwVENRcFJ1MVhJSzU1NUJEWXdNcnRpOFF5?=
 =?utf-8?B?b3hMemRRWkRBRUpGRWZVQUp1UEREWEtOaDhXMU9BMjVuZUlHWFVaOC8rYjBX?=
 =?utf-8?B?SlpCRTYvbzUxSmNMdGI1RDA5N0VtSU02TmlmWm03SkxwUEJUcTVIK0VadDla?=
 =?utf-8?B?QUtXK1Uyc2ZaSVo0bWRCOWFJcml3NzcwOVV3MVhWQkFzamFyem9JSmRFT1hI?=
 =?utf-8?B?Wm54ZlpLeHVqbmY3OU9sTUpyMXVJbUVxcTdKU3pJZWQ1TWJBd3pMTUI1Q21G?=
 =?utf-8?B?ckp6bU0wWTlUQU8ySXNHZkM0SlNOM1hnZlZzTVkxaUFNNWlBdldHeWpNWm9B?=
 =?utf-8?B?RStMS05qZFRvc3hseDUzVGFDNnpqNmpHL3RqN3lkMmhSc2JPMEErYkNCL3Bv?=
 =?utf-8?B?Rm1SZDNsMVBrN3FMSm42K2ZjSGxObXFod2xNcW9pcGkwcjlLNitWZUlza0ty?=
 =?utf-8?B?dytRZ1ZHSE51elAyYml4cmtrU28vV3QrR3NGNEFSOWluNlBqQ09GSUJiRlU4?=
 =?utf-8?B?WnBGb3JkaC80dVhra0RFb1g5ZTB1c2psam1kVnp6T0ZXYmIvQWpYM1VRa05y?=
 =?utf-8?B?MUdxYVNrZlVJZ3dIQVNUTFI2cCtNVTFlVG83VGVJNDJkRHg4VWxQNnNSV0l0?=
 =?utf-8?B?bU1XVm4rQklnQzRHVG5FM2k5TldTcUswRXVDWDdjOUYrU3lPcmQyMlBrangy?=
 =?utf-8?B?dFh3RXhlcnY0ekhtdnBYMytCT3JpRjlNTEtEY3RabUFRclgxSkw1dE45cUk0?=
 =?utf-8?B?YlRUTTBuTnhGdG5obVZvS3hoeitHWmR3MXNJemF4UjlBd1pvQ2x0SkNVc1ha?=
 =?utf-8?B?TXF6M3dZTHlKT1NBNlp1U2dnVy85ZHByaWxxNXcrNmczQ1BLMXpUa2RqL0F3?=
 =?utf-8?B?UjJQK0wrNHRUOTUwWCtobTQ0aXoxWUVYeVdVNTdCUm11Z1IvU2xSMHlrdXpU?=
 =?utf-8?B?VlJtVytOZ0tTV2Jqb0I3VndHZVVBdEQ2WnJXWnJMczhMdDJyU29NNDNMcFdh?=
 =?utf-8?B?RjNKT2pMY0pidndkRElraDhyTWpQRjRBWFFwRUh3VjUrcU96Z1cwQkRRb2Jn?=
 =?utf-8?B?S2hvZUVybVFyeXdPL0JXSEd3NFF2YUFqMXFkb3VjcC9YUjROTFNmeXBydXdH?=
 =?utf-8?B?R25ZWFFNYVhIaUhVbm1Fa1p6eWwvclhiRE5vN1M1WmJRRTV2Z3liaG4yMkgw?=
 =?utf-8?B?bmd3eFEwVHlSaWZsc1pmUmJjSEoxdFNFc003bUQ0ZFUxbFVuVEs0MnVUdExS?=
 =?utf-8?B?Tm81dWpyRDBVd2lLNVZ0VlpQclpnQmtTT1NQNTBwOUt5Tkd3TE1ZVmRMOXRj?=
 =?utf-8?B?T1d6dmx0T2RNdlh4SjdOdVlWdnBjL3VJYVN1NFlKRkxINzVQS0dNVG1jWFEy?=
 =?utf-8?B?ak41YjFIVmJVSnFsWjU1b2dWdmtDQXhsR0NFS2txcFUyUnNaWXkycVFjdjJG?=
 =?utf-8?B?MDBPb2tkYlg5ZGNseTAzejh1RWRxQThXbWh0amlqL0Vmdm1WekRjbGlTU09a?=
 =?utf-8?B?czlXdExzTVNNUnA0YUFyNmZuOHRZTDJnYUZublVCaHovb1AwZzlkdUtWZHgr?=
 =?utf-8?B?WW1UQU83VStHZjdpemREeXhiTmcvblFaWVJNWkZHdldBRjdUa3pqdnZBckZk?=
 =?utf-8?B?MmxhY2tYTlZmQmRYbkFTcjlEb2d6WlNFUlNLMnNuS0o5M09kb2RWUEl6TFBl?=
 =?utf-8?B?d1k2WjhPL1YxSnk3bzVMcUpzR1psMjhsaUFsWitUdGNJbnZjSy9TekQ2MVhz?=
 =?utf-8?B?dWdJL0F2ZnVXOTRZNHVSVkFTQk85TVlOaXZvMWRNRUlEZ0NLZ3paRHhkaUNM?=
 =?utf-8?B?Wkt3Umt0RlJrTzZMTjQ4MG9sVDlQQitVdFZhNXVVMlU3aGRnZzcyU01sQnlY?=
 =?utf-8?B?c2hINWt4RE5EKzdEYUNIaVk2MjBVdzR5dmViUWQ2Z1l2VXpkc25ma3pXT2J6?=
 =?utf-8?B?aGt2bklqVXpSeUpPRmtFVmptTlpJelFlT3Nyd3IzUSs0NDNhSDFxbnI3OGRB?=
 =?utf-8?B?WFBoRThXbFdMNjY1czQrMXhud0FuTDgxQ0FvRTRjYUVseGkrY25JOVF3SEdR?=
 =?utf-8?Q?Zp2n1zjGbIim97kBO5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7701dc2c-daac-428b-d77b-08deb0f63520
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:47:43.4432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLD/FqkxAobvxbbIw83aLD0FvK/rbVuNC8RGZkKVe2EJ1pqXmIfP5J0h5jUs5YAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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



On 5/13/26 11:57, Junhua Shen wrote:
> Call amdgpu_svm_migration_init() in the device initialization and
> XGMI reset-restore paths to register the GPU's VRAM as a ZONE_DEVICE
> region before KFD initialization.
> 
> This activates the drm_pagemap migration infrastructure.
> 
> Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fbe553c38583..3be51a2c0106 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -78,6 +78,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> +#include "amdgpu_migrate.h"
>  
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> @@ -4076,6 +4077,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	/* Don't init kfd if whole hive need to be reset during init */
>  	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> +		amdgpu_svm_migration_init(adev);
> +#endif

Looks good in general, but just a style advise:

Instead of spread those #if IS_ENABLED() It's good practice to do something like this in the header:

#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)

void amdgpu_svm_migration_init(struct amdgpu_device *adev);

#else

void amdgpu_svm_migration_init(struct amdgpu_device *adev) {}

#endif

Especially when the function is used multiple times.

Regards,
Christian.

>  		kgd2kfd_init_zone_device(adev);
>  		kfd_update_svm_support_properties(adev);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 28c4ad62f50e..c94d43f3ab42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -25,6 +25,7 @@
>  #include "aldebaran.h"
>  #include "sienna_cichlid.h"
>  #include "smu_v13_0_10.h"
> +#include "amdgpu_migrate.h"
>  
>  static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>  {
> @@ -87,6 +88,9 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
>  		return r;
>  	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
>  		if (!tmp_adev->kfd.init_complete) {
> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> +			amdgpu_svm_migration_init(tmp_adev);
> +#endif
>  			kgd2kfd_init_zone_device(tmp_adev);
>  			amdgpu_amdkfd_device_init(tmp_adev);
>  			amdgpu_amdkfd_drm_client_create(tmp_adev);

