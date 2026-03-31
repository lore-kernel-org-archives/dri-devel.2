Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140E4109B477
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7967210E0C6;
	Tue, 31 Mar 2026 14:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D6fqzgfa";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1628010E0A8;
 Tue, 31 Mar 2026 14:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys69eMdORgmVd8PZGfkgzEzyVtN4PcyQnhfLuxmYp2vRwaAlARvGO4m/8x6uNQ6PtR0r0CzV7HHyULGf3Qvx2ox3WXg8Gk9lIxLOIuqw3EKtDLShqVYQQ8BW/oZHciwao4q27yaFeJZuORMAzM/OfPft3OhLwOVbyfbDkhAsatNQ98ZV/J1D6RiGIPe4IHP509hjgkOQFM3AYgDkpHxB38HAvqNqR4wCv7cYynkzPB49cBcKCtWtmUdrxBskvIrMuLHZnTqIg2IvK7IbCRPbEwEZeFkK1PnPENEbVyLVi7/qCq/oGTDezweQDZYYN0V43mbsf7LssdmdI+VFXutYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huekssA1ReKPh9XrQqGNECX6rAcR8T5VCJou/SkB03Y=;
 b=jxEpTRGXKf1sxcncH+q1z3f5gMZma45aJrshEHJFKRZm1C93+DuolX7ZDz+A7ctfbyBlPiiUl6cvOw/WxTNkFCy8bBT8YQ5wifYyqCRQupbbfD5T+6yrGFfuWOMlNMU4Y6LIsVJVJLLLSx1R0fG9WnmErDhmCnIHjG6D56IHv32nmvtxs69IEPm1ZTbeeL/ldL1W9hfxDNJWwACAv+Vu2iYdTcUOOe6dX+i3rRiolSLYt0W4bK9baOF7LlAtdADnVirwShCKaO//GmpsDmm9jWxijgXkOFfPnMAJF/ffb4Rm8mEbvkfcHybS3yi4VHEgLvYIO6J7Xv7UHBlfch9Bog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huekssA1ReKPh9XrQqGNECX6rAcR8T5VCJou/SkB03Y=;
 b=D6fqzgfazvuLj13yRP9Dfp7imuwW+APrQNNPthljZnEeGML/NK8beYYT7K9MQHpQZhTdSFRbK14kafcaVXnxYGPunQ9bXzrXYVudDBn2vU8Ljm3LzpMDtnZiNTHgx7B/SAIh9tyR8x2TTPbAT8LA4W/ZoyNR441xNwHdLwBfwT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 14:29:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 14:29:33 +0000
Message-ID: <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
Date: Tue, 31 Mar 2026 16:29:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:52c::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 596e98e2-686a-472a-4cef-08de8f31ed47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 6Z7TaAfNUJNo/Ezv863lFwnn7ajqcKeSSiaE/msHIthfowos4RZClM1Adiee05TFE3mAwCofew5CRgYQKWN8+uG1WIf/nWF50ass1woYwHEf3bIMVdiXzRk4XcR0/uwglFkETFrhMwq+zgnWTSMhtBg5tQ+MxlEpA3aqmtGxoNmhqluMpN+VZpnBSrXuORXU4cSw/VKHwXuZxKdaYX7U5aA0vbV7EPikGGQA+cN0NPMhZHBCnTJ9xmJDmG6ugbe+Lj0z7mjiOLHUWXa5MaUvULY3VcVEV/N77jQIzGw1OFWOO2qkSTFFirzPek9Xa0zpqq1lP8YeacPmvavk4hwWUFRqI17gNEKOJrP8CwRSJ7d3ZWPsWvmMVYd+ZHjPAPik1+4DeWH8div2un8DT6nmM+hj23f5bu7YQhR48LiaSfLpc0HNLvU9ZYmATGH9okotUbsbth2vPMJU6VaudBRw037r8xyVYPMiFU0m7gKNWu3yomt9x4JA59Y4J8PuMhzRcG1VAwi/6n7i/03cECvAgSH+XOXhCBIntqaCIrbRxk/fyPjujLbH/disLXd3ilGLAoAB4UirUNReNuOZYyEkUcVarpPMoX4dZuqVBdyVw0pe9Z6L1x0qUidvsqOs88rFtO61omZ4haLnTeZne/5eX6fDIeJXpV5y/Aa+o+yQO5x0lC2rqqLP9NQRlFUAeZuISPD44gXwRyDKWo0AeMXApcWFiWBtJnz67F3njDTA5CSELBIUv/u1eiMiCxJT60DF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZBbkJ2U3JZY3NJTUJOellaT1F3S29DMGdkNEowZVJzMkxwVWZOekdFSFMx?=
 =?utf-8?B?Zm5NQjBWMjM1ZU0zaXRoaEtDUWNIcVVjT05DU2VHMFlvVWlOL0gyUU9mREJt?=
 =?utf-8?B?dlBzd1RZZUc4ZlFKRHZ1aUdxWXZqWkd3VGFTYmI5ek85MlBodGlkY2J1aGFa?=
 =?utf-8?B?NjNybi9RaDgvTC9nQVdxcFJyNFlPU3lxOU4rYVNoQ3hPMDJNRkRlaTVyUnJO?=
 =?utf-8?B?Sk1TK2lWa0twdlYxRzJPV1Vzei9wR0lBY0xpK2FxSVNvajJBKzZWMGZKNjNK?=
 =?utf-8?B?cGJ5YVRkNiszRVlHdkFBZ2c3Tk9LT0ZmOUhhK1diOW15eEtMczZaV3R4cDgz?=
 =?utf-8?B?S3lhOFFZczgvYXgyaThhczJzSEUxcWVsMWhjYmZHUERBQ0NkWXdwdGgvZUdm?=
 =?utf-8?B?ajFvTlNzUkZkTkdxLzVoYUsyaVpjdzIzc2FkZThCYTdodlFIZjJZL1VvcmFD?=
 =?utf-8?B?WThLNEovV2g2TzBkSEhIdDBBa2kyWERLbzhnYXRFSnN1c3FDNkcxcDJLUVNL?=
 =?utf-8?B?cFFyVzN4ZlNYdzFvcjV4Ui90OVNUMXhTcmhpbnhNLzltY0VneCtQVkRsWURE?=
 =?utf-8?B?REM0cTQ5UkIwaGdWVkxraVNDMmtpVUc0Y2hOc0p4a01MS1VaaGQxQmU3bEov?=
 =?utf-8?B?bCtKTHpmak4yVkljUitCcVVkOVgwalZPYXBlNDVkcDJqQXJvc2VuWGFrZURD?=
 =?utf-8?B?WURjYXVJN2Rwc0xaV2tVajhLRFNqMHA5VkRlem1qMmFrVWVhUnZuUXMweWp6?=
 =?utf-8?B?eTh2L0M3L2VpL0hSeUFYUW1HRjJ2L3cveW94MG9aaWk1SzBld2FPSGQzQUNM?=
 =?utf-8?B?TjNaTVFxWHByeGI4d3I3dnNLREpHNGs4VDloYmRPcUl0cm9pUGdLeStrWUw3?=
 =?utf-8?B?b2c4OHFSSmk4b09yd1YzMXg1Y2FNczFyRkZhL3hmKzFwRnlYcXJhclR2VEVW?=
 =?utf-8?B?dlROUEl3eE9vVkxLeWl5ZUhmZFJZbGRlVm5henQ5UDZoWVV2Qm0xYnNOcUNq?=
 =?utf-8?B?M0ROL05FWXRxTTZWT283SVByUm5GYmVTcmpCYjlsNDc3Vk1UbDJsQmxmZlVw?=
 =?utf-8?B?M3E4WmdIVFN2TGxUVnE5dGtPQzRhMFVZbEVxT29uMUV3VjZCaVhSSllxYVJC?=
 =?utf-8?B?MituMXFmN3J1R2hxZktpMTNGVkR3SzhxOVQ3N2MzUDhlaHlxSU40SUZ0WWFI?=
 =?utf-8?B?UFNQWStUQjlQbmx0ODFvS0RjOXhvZ29WNk44NzNRVWthSlNSTU5kc0d5TVY1?=
 =?utf-8?B?SUY1aitYeGk0SE9CdWp3S3lPdnZWbGZpUkRzQWJHQ3VvdlAwZzhLSVBIQ0VZ?=
 =?utf-8?B?SlJYYkxDNDF0L2Jvb0FUNWo1N1NweUY1NzlYS1JObFdjOWhoRW9wRmJrREdp?=
 =?utf-8?B?NDUzSmd4OHVvMDB1aGVDR3lndVZZVTdteXlFSDdDR21FNUVjUU1mOVNXY0tD?=
 =?utf-8?B?TXlUdmlvbjlLc2pGbnJkMVhCNjI1SkhJVXdWVTRnLzVrU25TSitsUDIxa2hU?=
 =?utf-8?B?YWE1YlhadEw5OUgvaTRzYWtTdHlDeXVrVXhwelYvZ1NsMFpaa1lrT1VXcVRJ?=
 =?utf-8?B?Ni81ZU1XMHl6NHVGSFhkdEovZTZsK0RLclNQMUNzd2huYjU2Y1h2djlrMzEr?=
 =?utf-8?B?RGNlUVNIL1FKdjMrcDE1cmdvbjd0TFpqV2d6YWEvNVV3Y2ZIVlVLd3VYTUdj?=
 =?utf-8?B?WnJkYlJmdHVrS0lVUGdrTUphVisxbE8rRTRWdlhIWTc4bzJpWk5nN3c4bWda?=
 =?utf-8?B?Vi9nLzdqQXppSG00K1QyWHRZSERvZ0J4Q3hTK2ZubkZLN1luZHZEU0V5cm9H?=
 =?utf-8?B?Sm4vMnVFb3QxUDA3NU5ocUp1Sk9UWDl2ZEtYZ3hLc3RCeVlBdXR4NFVOdFRn?=
 =?utf-8?B?c2EwUlNKWWx1YS9MY2VEbXJNL09aRmZEeUFlRVhPcjJSeTRXK1BUbmtIMXJr?=
 =?utf-8?B?d3VNeDhQTlJBS2hwSTh4djVOcGFOMTF3Sm5sNmdTaG9GMXFNNUlEOTNtRFZr?=
 =?utf-8?B?ai80WG9YTjFrVGpNNjd6RlB2dTMzbk93bTNoL2VDcDZLbGRHK1VjcmVVeDdB?=
 =?utf-8?B?b25WVTNvMUEyVSsvSlN5bytzeTMwaS94a1VQRncxcllQZXdaVkVkQmRNaDlw?=
 =?utf-8?B?QWZ5UWFUbUtaZWFPWFhseU8ySWR1Sm9hVmRsVVlTRHVoTW1VdzVHS2t4cjJP?=
 =?utf-8?B?UlBkYndqdng5ckJ6V2ZVNWxzZE9ZN1NCMXNSMkpNaHZHeW90NnRZeFBMbWdU?=
 =?utf-8?B?Y0xBUGVqam50OW8wTzVtaitMc0psZVVIR00yc1dLUVhMRitXK1RuUGlodW9M?=
 =?utf-8?Q?ld+f0o+4daHMvhGmYn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596e98e2-686a-472a-4cef-08de8f31ed47
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:29:33.1936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OILA2w4K5Yap9QSZPGEOTqtpuTIYye/g5cdEGLzHoYWhUpywmU1+aRrePoyWAk6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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



On 3/31/26 16:21, Mikhail Gavrilov wrote:
> Replace the PASID IDR + spinlock with XArray as noted in the TODO
> left by commit dccd79bb1c7f ("drm/amdgpu: fix the idr allocation
> flags").
> 
> The IDR conversion still has an IRQ safety issue:
> amdgpu_pasid_free() can be called from hardirq context via the fence
> signal path, but amdgpu_pasid_idr_lock is taken with plain spin_lock()
> in process context, creating a potential deadlock:
> 
>      CPU0
>      ----
>      spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>      <Interrupt>
>        spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> 
>    The hardirq call chain is:
> 
>      sdma_v6_0_process_trap_irq
>       -> amdgpu_fence_process
>        -> dma_fence_signal
>         -> drm_sched_job_done
>          -> dma_fence_signal
>           -> amdgpu_pasid_free_cb
>            -> amdgpu_pasid_free
> 
> Use XArray with XA_FLAGS_LOCK_IRQ (all xa operations use IRQ-safe
> locking internally) and XA_FLAGS_ALLOC1 (zero is not a valid PASID).
> Both xa_alloc_cyclic() and xa_erase() then handle locking
> consistently, fixing the IRQ safety issue and removing the need for
> an explicit spinlock.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> 
> v7: Rebased on amd-staging-drm-next which already includes
>     dccd79bb1c7f ("drm/amdgpu: fix the idr allocation flags").
>     Updated commit message to reflect that sleeping-under-spinlock
>     is already fixed and the xarray conversion now addresses the
>     remaining IRQ safety issue.  Inverted error check to
>     if (r < 0) return r; per Christian König.
> v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
>     so all xa operations use IRQ-safe locking internally.  Drop
>     Cc: stable since the regression was never released to any stable
>     kernel. (Christian König)
>     https://lore.kernel.org/all/20260331111733.118553-1-mikhail.v.gavrilov@gmail.com/
> v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
>     since xa_erase() only uses plain xa_lock() which is not safe from
>     hardirq context.
>     https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmail.com/
> v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
>     xa_lock_irqsave, as suggested by Lijo Lazar.
>     https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
> v3: Replace IDR with XArray instead of fixing the spinlock, as
>     suggested by Lijo Lazar.
>     https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>     lock inconsistency (spin_lock -> spin_lock_irqsave).
>     https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>     using idr_preload/GFP_NOWAIT.
>     https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 34 ++++++++++---------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index e495a8fa13fd..a6ac3b4ce0df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>   */
>  #include "amdgpu_ids.h"
>  
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>  #include <linux/dma-fence-array.h>
>  
>  
> @@ -40,8 +40,8 @@
>   * VMs are looked up from the PASID per amdgpu_device.
>   */
>  
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1);
> +static u32 amdgpu_pasid_xa_next;
>  
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
> @@ -62,22 +62,19 @@ struct amdgpu_pasid_cb {
>   */
>  int amdgpu_pasid_alloc(unsigned int bits)
>  {
> -	int pasid;
> +	u32 pasid;
> +	int r;
>  
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	/* TODO: Need to replace the idr with an xarry, and then
> -	 * handle the internal locking with ATOMIC safe paths.
> -	 */
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_ATOMIC);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> -
> -	if (pasid >= 0)
> -		trace_amdgpu_pasid_allocated(pasid);
> +	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +			    XA_LIMIT(1, (1U << bits) - 1),
> +			    &amdgpu_pasid_xa_next, GFP_KERNEL);
> +	if (r < 0)
> +		return r;
>  
> +	trace_amdgpu_pasid_allocated(pasid);
>  	return pasid;
>  }
>  
> @@ -88,10 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  void amdgpu_pasid_free(u32 pasid)
>  {
>  	trace_amdgpu_pasid_freed(pasid);
> -
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_erase(&amdgpu_pasid_xa, pasid);
>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -634,7 +628,5 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>   */
>  void amdgpu_pasid_mgr_cleanup(void)
>  {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>  }

