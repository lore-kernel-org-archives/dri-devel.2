Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE445F43683
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B2910E9AE;
	Fri, 17 Apr 2026 09:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N6ZySaAb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AE710E9A6;
 Fri, 17 Apr 2026 09:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQnlMLQZP4eX5qnTGG+zHGVzQteQOjwjkLSHdTeSPSmaMDZmDjT9VHRZgS2W7oNGbxgYW6xPN6PsulxvDy54dxKAQ4/YG97alsLO1HZ0Swl5QNSLMDDrr1RMwGtMCmE1kAheD7l9z3y0JNxIq0vPz5uEH0EHfkIcBYGA16mXV4unNvO5lLjk7YOL0p97L4cD0ZgYEEa7NuWTMDgrK43x3KFQXbTDMpexsnR7H9DNpY67Tae3lTfYcI2CLssWh8hruvE7JyiNQTcrAF3xVRw7AgueYo6KrK5tzTFMJ28Xkh2t85y0zu+gYMutRwaZdh7OLu3k01VQiK5YqtwlJDasJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi57AQCYbR96O3eAbckpK6+kKEykhNZVlYPkZk1OZ2c=;
 b=o13oTYkFG++vujGDLkhWZ7Yey6Rpd8sd0HU30hQv39Qz4PKFcIbgUbNYqCOAIdCqU3Y2A7BGADfG3ad89dwfrhCgnEtqcHYqLa/500Bym+OYb5HYoJDmK5r5Rns73W871sJaSzWqDZGiOAJH3tOJ5MGTKQgrJrvtD8KxCIJMm2vNyVhSFuMiE+6VB18sgKZeW/gDH08ETREeSJG01p47ljf6FHOLMVOq0UdGjc1zoFTNcBSm0uhj7v2ucX44lMwUmsoJ9q690kv2vrqtvCb4S5NywZPzaZBLqWL0ad0vOiBfKvDc6DnyNCwdXNI4erRpGNEVrCaA1Pkvn3C6LyzYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi57AQCYbR96O3eAbckpK6+kKEykhNZVlYPkZk1OZ2c=;
 b=N6ZySaAbatJOQrYpX5kf2e8PoGY6LC2Wy9V9BR5q/Kklyg7QngJGr6ZKVsix24DZoSUzRmyQPwv74liGwD8TxcHa1rWCEN0QXGMdEVrhzbZUyom3avi6SM0FQW1XxSOAzV4nGC6mPcOyyI7SQ0BWhAQsbu5+yJ9wEgZaOOR/Hww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 09:51:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 09:51:10 +0000
Message-ID: <403722a9-eb23-475f-8172-47039f54605d@amd.com>
Date: Fri, 17 Apr 2026 11:51:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Deduplicate eop_irq v11/v12 functions to use
 helper
To: Erick Henrique <erick.am@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: Lais Alves Da Costa <laisalvesc@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260417090841.6190-1-erick.am@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260417090841.6190-1-erick.am@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:208:fc::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2322a8-1c7e-408c-2daa-08de9c66da4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 4erzErgEvdVhXGxqmtj5fmu6PWuFVMoDKVDiCpSLckvL0VUOpxgWkF/P/zqq9yMM7OQ2YVwxSR7NgBSDz3jqy3pAlhWm77IB5dNlXWtvAFMwKDE65W5CQlTx4IU7d5/5hdg8bX4xODl5WdsBe0K1m6Wp1gFice6b/Q1RR7AfJJIonEc4a2uqr8TpWI+oBCgMyEIYJ7YfATSyG+PUrXVW9i6O2gM86HKuMGOGlwIszQ3ePjGhBEkmHtLWpNmhKzxp+GMa6iG+t2tpBaoEgFO7BbJTGVtO4C+4qw7XWF1Xck+yTD/3fU63R5EHexiMRSJuMKDGpvOcH3NZPXhkqFeM+BF3yhWCaoeCUSJMDjl5ggV0jnNJyNWRe0sj+Fg97C6L0yZMA1uxq8YOkMNmaj/BX2gDd4PK3yJRf8nZfBVJ8ZShRdaYrxkCAS5BD85lw6AaCtOaQUNyqv98gUgpT5nQSuzUAU4i87pAyTS7GSdVNg6sranJ5Z9ZF+PEEvB8oCMOlkGEJ6dYhhjTynUu4FzjwS/LwLmGz+fRq40W4yC1S8pDsZXev1Ib83rHLViRO5vcHZwxWMj1EgGR/Q0nCCAqVJ+b5XlXD456ukQ6K9w/7X6UMiZlXK00cIxMuFaCSO3q6DPkEP7Pn471ItLU1zsu10JJHaTEkr6UrYYwMpeB6j68UFwiAG+nEeoRopceuCzABBlgL35majtk3+zQj+KbOvRsVsJ11Gm4n+8BG+NHZiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpqUXBrN0YzZS9GeWIyb0t2Z3NjbncyR2NtZENZOXhFbjdXWTVSdGhNOVJj?=
 =?utf-8?B?aWF3Q1AvbWhlQUZnNmlOaTJIWlJpQ0ZhL1JtdjBySFBlYXZ6TnhaZnhsVVEx?=
 =?utf-8?B?d0w2YVBWRk9kY0YrKzVhbXM3emRzOXJpWHRKeFhBa1ZpdkZWTFZLK2NFTnlJ?=
 =?utf-8?B?bzd2cDM5Z3VhOTNnSVVqKy83WWZmNzJGSm5ZSUZYNEp5R3BGalNYS1k4S0hM?=
 =?utf-8?B?TWV0Mis5dkZQVzlNcytJeUpsRENhT2Fjemxab2pGSXZKTm9iQ3YvM0VjdEc0?=
 =?utf-8?B?WUNacnZLY05tOU5JbjkwZVhkL09KNC9FRkJtRFhZRHp5S3Iyb0dzWFJ1a0Fv?=
 =?utf-8?B?Zy9EWkNSbk9mckFHVzFMMnp2a0RJdEVBWTJGcUloQ1dyYjZkWmRSTE1yb3VH?=
 =?utf-8?B?UHI2d045T0Rkc1c4OE9JTW15Q3NieW5VOVk4M3NEYm8yL0Izb3NGRWh4T0gr?=
 =?utf-8?B?N2lFUXh5WC8vZ1BJZnJsa2tTRnVqcTBBaUZGeVpXY0xja1J4Y245L2RqSGN5?=
 =?utf-8?B?a1VHSVRQSUM2WEhwdjNxUXptRm9rbWJJYmFkK08zSitsaGE2OTJEMkJxMGxn?=
 =?utf-8?B?aWc3WXJ0QmZjZG5hZlF2amdvbE5lUVc3Nm8xMWRMbGVsWTV5ZUFBZlV2ZnNZ?=
 =?utf-8?B?RW02WUYvQkREVmZJYXM5dFVxWldSR0lmK1RidlFRL1J3Qm0xVzhXOEtsemlM?=
 =?utf-8?B?dngrR3NyNGNjZzBHVncwemlCVmRwby9QQ2k5NkgyeitkazVyZ0ZpSFljSTZI?=
 =?utf-8?B?Tng2UEJRQ1lhd3I5YXpQckRuWFV6SWtHUDlzKythR3lnZ0YzSXp6dHltb3VY?=
 =?utf-8?B?a3NIVFliajd2aFA1RjdIZ21yMytkY3huRHk1SnlEemFUTUF6MVd3L0E2NkJL?=
 =?utf-8?B?OWhtejV6U29XU0RBOTNManNlNTVQZGNNcjc3S0g4eDlTWVNJaVBZaStOM29v?=
 =?utf-8?B?Nk1vci9QTnVTZUpLSjFnUk5yU21iVXJ6cC90Sy9ZTDByWVhER1JQcG5pNGJV?=
 =?utf-8?B?SXVkQjBlVnEvUVlEazZNRGU2ZnIvUWc2Yll0MURrbXQrUnI1U1RRejdlblRH?=
 =?utf-8?B?N1lpeDBaS2RjOXlTejRPMjVUdWNJRDhPUlZyQ3V3cXUxNmpybU5hTzVlZVdY?=
 =?utf-8?B?RG00OGlzYnBsKytHZGZCNExDb1NYZUNpNkJDUk43TDlnTmtGRnRQYVJzYjVO?=
 =?utf-8?B?Qjl4bDJwRDBGUkxGb1hZWUgrWEpXQllFVU9FRFpGaHNiYkMxaG1ob2dnLzBR?=
 =?utf-8?B?UFl6U2xLdzNySmtmQVJuL3Q5Y3dXbTBrd08vOUNxNmZEVXNQTFNmUHB6WWRE?=
 =?utf-8?B?MGJQV0VNS2VqQkJsYnpxYW50cFJhRjUySm1zN29adFRsMjk1bHJORVdVSGI3?=
 =?utf-8?B?bmN2UzhJY2NCc2x2QVlRS01Ea2xoVU9KTmpMRjluc3RQL29SemxZNXliZGZa?=
 =?utf-8?B?aE1WZGxGZzcvNGhpMGNUN0Z5L2J6SUhoZy9mRHI2MjRWV3BZQUtVRlNyaUcy?=
 =?utf-8?B?SndJZFVvU0o3RXRYaEgxMmhiQW9sa2xtQm5tMUdzSU8wRkhUbERrZ05VbkZw?=
 =?utf-8?B?Nk8xN0FCZDVxcDNVcEU4enVrL3NkdjRpTlVtMi8xeS9zTVU0cWl0cWtYYU9L?=
 =?utf-8?B?VXRqLzdOcjl2OVlIMER1T3o5MVFveWZ3L20rTFZXbHFTQkFCUHZ0TDE2ZnJu?=
 =?utf-8?B?bHRoeDJlSU9UbnJjQ0V4SWI5Q3RmMW5HeHFyZFFyb09La1NBTWV5V2crNy9R?=
 =?utf-8?B?bnN4NUtITlhoZlhzck5VU2lnVnNvTU83Ym9kQVp1d0pNbUhJV1BZR0EyZ3dw?=
 =?utf-8?B?b1psdFZRUytieUZhNDB1SFJTT2VRZVZwSGhDNnltWDA2TmVqRlA2czVxb0hh?=
 =?utf-8?B?a0puclhjU1F0eXUwNXUvcnRNRm1iQ1krZU8zd3ZlOFhhN2poaURaVVZpU2c5?=
 =?utf-8?B?anlYUHkzYjR6OEJoNkdPVkl1REs3S01BR1VCT3ZsR2Y1TDZ4M2NWV2dYTEpl?=
 =?utf-8?B?MkZuYXhoa2QxZ0NpcnB5VG5uY1FmdURENFpXQlkxa2NHRDVxUUxFUjBUUXV4?=
 =?utf-8?B?V3NiMFJOV0hHT2Uxek9kZGYvUU8rRlQvVlpwYzFSQkl1dGdSVG51elQwbDV2?=
 =?utf-8?B?bnNmQnJxaE1NTnp0ZTNtZFhqU0w3YTM0M0VLRnZJUUtGaGI1YkhER0gvUFpi?=
 =?utf-8?B?bWsxUXZpaW9BZWlyMlFScTY3ZnlmL2JNWjdaemVOaWtVNk8vdFBKbHhvQmQ4?=
 =?utf-8?B?TUZZZ2dGNzI5djdDSGtEdytBbzFsSXZNQUpLMGtJTWtKN1k0TXJkME83MGpY?=
 =?utf-8?Q?4AMaXpqst3Mj+trHeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2322a8-1c7e-408c-2daa-08de9c66da4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 09:51:10.3316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ryqa0fsawRZfdjMvX8w9cPQo6iEpPSbuQV373TEYnAENx1oM7ALTCyrcGCdz12L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

On 4/17/26 11:07, Erick Henrique wrote:
> From: Erick Henrique De Araujo Moreira <erick.am@usp.br>
> 
> Identical code implementations to handle the ISR for the EOP signal from the
> graphics and compute engines of AMD GPUS on the gfx_v11_0_eop_irq()
> and gfx_v12_0_eop_irq() functions.
> 
> Introduce a shared helper amdgpu_gfx_eop_irq() and convert the EOP
> implementations to use it.
> 
> This reduces duplication and improves maintainability without
> changing behaviour.
> 
> No functional changes intended.
> 
> Signed-off-by: Erick Henrique De Araujo Moreira <erick.am@usp.br>
> Co-developed-by: Lais Alves Da Costa <laisalvesc@usp.br>
> Signed-off-by: Lais Alves Da Costa <laisalvesc@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 55 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 48 +--------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 48 +--------------------
>  4 files changed, 61 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2956e45c9..3ac7d9305 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -34,6 +34,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_mes.h"
> +#include "amdgpu_userq_fence.h"
>  #include "nvd.h"
> 
>  /* delay 0.1 second to enable gfx off feature */
> @@ -2684,3 +2685,57 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>  #endif
>  }
> 
> +int amdgpu_gfx_eop_irq(struct amdgpu_device *adev,
> +                            struct amdgpu_irq_src *source,
> +                            struct amdgpu_iv_entry *entry)
> +{
> +       u32 doorbell_offset = entry->src_data[0];
> +               u8 me_id, pipe_id, queue_id;
> +               struct amdgpu_ring *ring;
> +               int i;

The coding style here looks completely broken.

Additional to that the separation was intentional.

> +
> +               DRM_DEBUG("IH: CP EOP\n");
> +
> +               if (adev->enable_mes && doorbell_offset) {


> +                       struct xarray *xa = &adev->userq_doorbell_xa;
> +                       struct amdgpu_usermode_queue *queue;
> +                       unsigned long flags;
> +
> +                       xa_lock_irqsave(xa, flags);
> +                       queue = xa_load(xa, doorbell_offset);
> +                       if (queue)
> +                               amdgpu_userq_fence_driver_process(queue->fence_drv);
> +                       xa_unlock_irqrestore(xa, flags);

What we could do is to move this chunk into a common function, there should be multiple copies of it in the SDMA code as well.

Regards,
Christian.

> +               } else {
> +                       me_id = (entry->ring_id & 0x0c) >> 2;
> +                       pipe_id = (entry->ring_id & 0x03) >> 0;
> +                       queue_id = (entry->ring_id & 0x70) >> 4;
> +
> +                       switch (me_id) {
> +                       case 0:
> +                               if (pipe_id == 0)
> +                                       amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +                               else
> +                                       amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
> +                               break;
> +                       case 1:
> +                       case 2:
> +                               for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +                                       ring = &adev->gfx.compute_ring[i];
> +                                       /* Per-queue interrupt is supported for MEC starting from VI.
> +                                       * The interrupt can only be enabled/disabled per pipe instead
> +                                       * of per queue.
> +                                       */
> +                                       if ((ring->me == me_id) &&
> +                                               (ring->pipe == pipe_id) &&
> +                                               (ring->queue == queue_id))
> +                                               amdgpu_fence_process(ring);
> +                               }
> +                               break;
> +                       }
> +               }
> +
> +               return 0;
> +
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..a180d1903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -664,6 +664,10 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
> 
> +int amdgpu_gfx_eop_irq(struct amdgpu_device *adev,
> +                            struct amdgpu_irq_src *source,
> +                            struct amdgpu_iv_entry *entry);
> +
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>  {
>         switch (mode) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5097de940..767887d7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6494,53 +6494,7 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>                              struct amdgpu_irq_src *source,
>                              struct amdgpu_iv_entry *entry)
>  {
> -       u32 doorbell_offset = entry->src_data[0];
> -       u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> -
> -       DRM_DEBUG("IH: CP EOP\n");
> -
> -       if (adev->enable_mes && doorbell_offset) {
> -               struct amdgpu_usermode_queue *queue;
> -               struct xarray *xa = &adev->userq_doorbell_xa;
> -               unsigned long flags;
> -
> -               xa_lock_irqsave(xa, flags);
> -               queue = xa_load(xa, doorbell_offset);
> -               if (queue)
> -                       amdgpu_userq_fence_driver_process(queue->fence_drv);
> -               xa_unlock_irqrestore(xa, flags);
> -       } else {
> -               me_id = (entry->ring_id & 0x0c) >> 2;
> -               pipe_id = (entry->ring_id & 0x03) >> 0;
> -               queue_id = (entry->ring_id & 0x70) >> 4;
> -
> -               switch (me_id) {
> -               case 0:
> -                       if (pipe_id == 0)
> -                               amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> -                       else
> -                               amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -                               ring = &adev->gfx.compute_ring[i];
> -                               /* Per-queue interrupt is supported for MEC starting from VI.
> -                                * The interrupt can only be enabled/disabled per pipe instead
> -                                * of per queue.
> -                                */
> -                               if ((ring->me == me_id) &&
> -                                   (ring->pipe == pipe_id) &&
> -                                   (ring->queue == queue_id))
> -                                       amdgpu_fence_process(ring);
> -                       }
> -                       break;
> -               }
> -       }
> -
> -       return 0;
> +       return amdgpu_gfx_eop_irq(adev, source, entry);
>  }
> 
>  static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 65c33823a..aadebb4d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4846,53 +4846,7 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
>                              struct amdgpu_irq_src *source,
>                              struct amdgpu_iv_entry *entry)
>  {
> -       u32 doorbell_offset = entry->src_data[0];
> -       u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> -
> -       DRM_DEBUG("IH: CP EOP\n");
> -
> -       if (adev->enable_mes && doorbell_offset) {
> -               struct xarray *xa = &adev->userq_doorbell_xa;
> -               struct amdgpu_usermode_queue *queue;
> -               unsigned long flags;
> -
> -               xa_lock_irqsave(xa, flags);
> -               queue = xa_load(xa, doorbell_offset);
> -               if (queue)
> -                       amdgpu_userq_fence_driver_process(queue->fence_drv);
> -               xa_unlock_irqrestore(xa, flags);
> -       } else {
> -               me_id = (entry->ring_id & 0x0c) >> 2;
> -               pipe_id = (entry->ring_id & 0x03) >> 0;
> -               queue_id = (entry->ring_id & 0x70) >> 4;
> -
> -               switch (me_id) {
> -               case 0:
> -                       if (pipe_id == 0)
> -                               amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> -                       else
> -                               amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -                               ring = &adev->gfx.compute_ring[i];
> -                               /* Per-queue interrupt is supported for MEC starting from VI.
> -                                * The interrupt can only be enabled/disabled per pipe instead
> -                                * of per queue.
> -                                */
> -                               if ((ring->me == me_id) &&
> -                                   (ring->pipe == pipe_id) &&
> -                                   (ring->queue == queue_id))
> -                                       amdgpu_fence_process(ring);
> -                       }
> -                       break;
> -               }
> -       }
> -
> -       return 0;
> +       return amdgpu_gfx_eop_irq(adev, source, entry);
>  }
> 
>  static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
> --
> 2.43.0
> 

