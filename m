Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E31C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8BC10E581;
	Fri,  3 Jul 2026 07:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pLcNQ+3Z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA12910E581;
 Fri,  3 Jul 2026 07:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXoqY0M9yADHyZg18F2/wT+mBawgSh0tE2G5W+lz7CvqpzSAtjjImr/twOmb56Xs2+klLyRyqD0pizMu+Vz9D0JAP/pL3dt9HST9zqq0xEJHwv8ScTTI2P8n2zOfHYwDjROSS9+G021K6TgpvFy//DuCrSMleJ0Y+pFogxpKjs701x/OTHUBCa6usdM/p6tnCKpcDMJNBuebV1gKD01zOlsNo/w3mTafIKVAznpCZMD/Unam2hL6ai6NBfo7R+SKp/ptj0e+Iy+VJTyXAd86vOlJa5VWus5vBB0qust5utBi0xwKHPJuD7JId+CKxuN6fNcJi5Xr6PtLhx8yQ4iGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pozjgVNCvFyrzHbOvnRxvrqlxo1HVJkJtTS0zuqd1Ys=;
 b=u7/SXjZKDq28nkZ8Iy8RMZgeQ5CNz983YBh6n+IJIxblXnrEtQvEsUaUEoyLBLBFArbNpYmOpUDoI9yl+jEJE0jpt3Y2D00QYSKSTlxffQvFQKlAEfLCKpS+2r9WbvFpoKvCm6dB4sI7i0RhUnFyQ051JWLFU9S0KookFUOXu9T/ovpy1alzJMIiQQg47NIFduNEVOQLMJuYvRS4zq+R+OtVkFTR4grqcKhmXUdyWMpd8kyKg7P5eUL3WDE9H+taeQXzOTd/thfyoJsM9KBQWNAckfRVI40OMTlsiGddmok6oWVltgfTmXi/KDdYM9ACk88YENVHOkG5XxrCmPyPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pozjgVNCvFyrzHbOvnRxvrqlxo1HVJkJtTS0zuqd1Ys=;
 b=pLcNQ+3Zq7aq6AYJH2k0I+vLUwxXHflvwKh5+Z/CuZm0wcbTiumJTUUBWz74RdEg7E+NTGgDNkAuR3sMIdakrdd/FNke2EcwK/Zqn2ncfM2iU0JY/RkGN3Wo8L7Wx18ZvR/g14e26ipYGRHkUZNp1n83D74eMBw+ObqRZRy/LWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 07:21:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 07:21:12 +0000
Message-ID: <b12cbd03-9e11-44ff-9ce1-8afb82379b53@amd.com>
Date: Fri, 3 Jul 2026 09:21:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: Felipe Sousa <felipesousa@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260702212204.12171-1-ulissespaixao@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260702212204.12171-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 817236ef-8641-4a8c-e0ac-08ded8d3a920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5z042RWxMgh4kbfyHciVhALCw7qJVUJeI74apIC4zGNIvTeKF+LN2ybZkNfuJUW28tmTjLQ13Ef+cYE37L9ufMl4n5OdV6dA+TPMxZOremkDPVFGht067PHnUvL/+cul8bKqRb397cJpcn2IOyqIzL++4xkxF2hrYA4JSbKuoI38ewDlecno0IsnU2tG9rY8mH7lUeCUKmqeb7kynqK/T5Du6axbiiuxDSVuUkm4ECcarN3c1NvZZhk6ba5hS3RCl8v9zF/nkwvOc4SYCxH9Iz4kVPXWbg7gVaM/Lwo6fvb7ozn6w6ykZ3qXKK+qWKREf/GrzH/H0PUfapMmQvlILUY5+Drz/uu9V+kf4j22sbBaYTMBcifSvWriEUdrP8lrvFU00mZLdtizHToZ18wC+Vg9lXeycvtn84u5I01ot700SlytC4qkD4pJg6SOMT5WI6cVLhTaekVZfXxJfBbKMaNIIdWKXiBqw8IQ+CPepI3ueseWc39VwyF6ZriAtZMVhoyxh04YxFNTt9aFZe+jRepimUqleU61QUI6OCrfLnrX3A4L6EGTwHozn9gmOD8UmH6mTozUmzlVsquqyGu1wYtTWTUf8cX6oXCcCnRUylORyXq1/RIL/UJY7Ac0VeL9rtTiAEqgNmhXXFMy7EtT1ruAns0chc22xf3sFonIf7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhPUW1jWDkyMHpqRFVURVJmNnVkNlV4TkMwenhtYjZaMmNvM3ZQR0hWOVkz?=
 =?utf-8?B?WXhCMHI1c3ZQcGQ3OG83V3VIMG11OEdXelNUelhmbWFHelIwM2swdTFFZzhO?=
 =?utf-8?B?bXdUQzJUSUluMHpZcW55KzFXSlNSZlA4eUtYbmZCVU5xYVpURHFENTNGY0xW?=
 =?utf-8?B?V1hXc1BBbDZjUzVpMjJLellrSTl5NVUxZkI2Z3VFMFpQdEJobVhrVDNnRWV1?=
 =?utf-8?B?cDhGUXdaOEgwNVdxWVYvbW1ybmdteWt6N2RueHk4Tjh0YmZXN2RHNWpPMjAx?=
 =?utf-8?B?NDZsc3Z6Z1laaE5WS1E1bmV6cVh3UzdtYUUzTE9WdHNhUDk5TDFCS3hvbUJh?=
 =?utf-8?B?SEVoMUVFZDhVRVRnOXoyaHFtb2pqZUdvdDYyU0dZM0FtdU9uRUZoUWhySTVv?=
 =?utf-8?B?a05yUmJrZlpEVXRRQVBoSXVVRVVwZDlmbWlENFdiQjUxUE84TU5jYVFRU3BE?=
 =?utf-8?B?VzgxNndyb3dYa2tIcVBqSG83QXZ3UXk0Wm9sM0FqSnArWGFIcjJDbm5nK1V0?=
 =?utf-8?B?dmNyUUlyTHRmWXRScHpnR01DMEFsSUNHcGJwLzNwa2owcUpZRjJQbFFJWUpp?=
 =?utf-8?B?dkFYVkd0RVQwVVoxUEpjbXRjbXJqTVY0cG5EMm9sbXcrUmhJOTNvd3oxNUZU?=
 =?utf-8?B?dDZzMTJZZ01YUEZiZlRwUWpaRFkxblc5UEo3dEdxK0tUYWNWTnp6YjlOVGll?=
 =?utf-8?B?OHVBSlIwL2FYUlJ0THpVWjkvVW9Ya1lVUk1ZK3F0Vm5BUWFhRGxUOXJiUEZv?=
 =?utf-8?B?NUVrUDRPWWdBSzdOak9ndi9Fd2FCZDJ3ZlVXUXRaelk0WTRRRlJaQkplQThl?=
 =?utf-8?B?SGtCVWFWSzNhaUZqOGJQbW5Wb0FxUWhkSU8xRk1yaE9ZOGIwOXQxQVJaRG9t?=
 =?utf-8?B?d3Z4a0l3cktHTG5hWEdob3ZQa3JxZlJoR2RBUXc3Skx1M054cnBhV08reDk3?=
 =?utf-8?B?SjJTcVlVQlZPMkhWSjdEOGRNdU91MGNJVndNb29iRm1GODN3TmE4U1dHdHUy?=
 =?utf-8?B?VG1UTm9JdVlPcW5RK0NPVElPTUhUeFJDWjJBV0xoanltWjNPUERDNEEwYkdN?=
 =?utf-8?B?SG91eElzb0pNbmhVcW02NDFSUHlMVzg0d29lays5ak01ekc4WDVUSHlmUm1y?=
 =?utf-8?B?Ky8yWGltSHJBdzV1ZC9uTFYwZ2lwNFFSR29taGFQTHY1ZWRGWEkvUG1XNnJm?=
 =?utf-8?B?Y2x4VjNJZDUzLzdSN01kTkJaYTkxN21reVVwdm9Zb3ZYejRQSDhVakhCajRK?=
 =?utf-8?B?SFlrT3hmdjZ3YTNlU1U1Tk0xbWZmNC82OUtvQlJ3djRMVmdhT2grQUxLZG1B?=
 =?utf-8?B?OVQ3dlhXa25HcjgwN0NqSHpISWdhbkU0M0ZHMWhlUW9yYnlKemx4SkswSFQw?=
 =?utf-8?B?blBOdGphQUVobERnblk5VnZGdTl4a052bFpSNmF3VnRwT3l4Slk0cnlKdnJz?=
 =?utf-8?B?UFdVQkVCSjB6N3dtTjRzVndwOGN5RzhjLzNWeUxzRytlMHJjUEZmY1hLK2xX?=
 =?utf-8?B?eFFyL01NSHVNWHhjc2Y3MmdPUG41eHdpWTBkT3gxSGtTNGRjYzREWDE5bmV2?=
 =?utf-8?B?c2lyN2dta2ZFVEtKMEtrbW5pZHBaQzhnUnh4VVcvb2xGTEUwQW03TFd0Vk9v?=
 =?utf-8?B?N0xhbVh5b21iQVJkK3E5TGhtY2ppMUpwa3NqK21PQWxiQytjR1dxYllreE5H?=
 =?utf-8?B?dTBZZzhYMEI0U0hGK2wzMFZPMjNoMnEveStuZjlEMEpWVXFobytiTnhaVGNQ?=
 =?utf-8?B?RGwvMDF4Nk1leXBPcmU4SHFRVW14OFNHaGpySUY5cnh3RE15dFFJS3hRRzlk?=
 =?utf-8?B?OUpZU3NPTHBiN2h3OVVzMUQ3M1BhaDA1Z1haY2ZCaHZSWW5iTkZEUnc5dTBj?=
 =?utf-8?B?d2liSzA1Z2JpOGxhVEFXT0ZNbmYwMGVmUXRkRzBQOFJCL2hzL21uWFJ1SzRu?=
 =?utf-8?B?eVZQUGNuS3lkMzRCSnZlSHYrZzZLYm1pTkdadnFDVzQ3Mi8rTisybUlRNGxP?=
 =?utf-8?B?di9ZVUNLTXRLVzExYjBBeVhqRHZmcVdoaGJvL2EvdnpOSWlRVHhGaGVVNkZQ?=
 =?utf-8?B?ZDdhc3lycGpqL1gzY0xvYVhKRU1lb0daVHdkZ01ELzc5ZGlCNGI3bFUxaSsr?=
 =?utf-8?B?d2VIdXIvaDdmVXh4OFZiRFh6OVhGL2g3NXJYSFhRSEFBRWxzcytQbWFUZ1h2?=
 =?utf-8?B?MlNIRWFZUzhZK1BjM0tWK2RmNFRrcCtRVjE5czdzUU9lZFV4cTJYclFocnYz?=
 =?utf-8?B?d3lieC9hSVdlRDV4VUNienNmbXdIV2ZtMExFWDRyeHFDVEp6U0I5VVU3K0JE?=
 =?utf-8?Q?GfO8gRvFg61JwS+mXV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817236ef-8641-4a8c-e0ac-08ded8d3a920
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:21:12.2257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EJuXY1wNmuKjUCphIq6CVpjaLSEr5X675RXTqGFnEfZtjtYxeHr3JsxudNpN25R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
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

On 7/2/26 23:22, Ulisses Paixao wrote:
> The functions gfx_v11_0_handle_priv_fault and
> gfx_v12_0_handle_priv_fault share the same logic for searching and
> triggering a scheduler fault on a ring. This patch moves the shared
> ring-searching logic to a common function, amdgpu_gfx_handle_priv_fault,
> in amdgpu_gfx.c. The hardware-specific decoding of ring IDs remains in
> the version-specific files to maintain proper architectural separation.
> 
> Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
> Co-developed-by: Felipe Sousa <felipesousa@usp.br>
> Signed-off-by: Felipe Sousa <felipesousa@usp.br>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
> v5:
> Return early on adv->gfx.disable_kq check.
> 
> v4:
> Restore the adev->gfx.disable_kq check to prevent falsely triggering
> scheduler faults on idle kernel rings when MES is managing user queues.
> 
> v3:
> Return early if the ring is found in the gfx rings loop.
> 
> v2:
> Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
> Remove the redundant check for adev->gfx.disable_kq.
> Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
> all gfx and compute rings without a switch statement.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 40 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +----------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +----------------
>  4 files changed, 44 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca87669..47e06a585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -830,6 +830,46 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
>  	return r;
>  }
>  
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +					u8 me_id, u8 pipe_id, u8 queue_id)
> +{
> +	struct amdgpu_ring *ring;
> +	int i;
> +
> +	/* The scheduler only handles kernel queues so this is a no-op 
> +	without them. */
> +	if (adev->gfx.disable_kq) {
> +		return;
> +	}

Just style nit picks, the comment style should be like this:

/*
 * Text.....
 */

And drop the extra {} around the return, checkpatch.pl would complain about that.

Christian.


> +
> +	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +		ring = &adev->gfx.gfx_ring[i];
> +		if (ring->me == me_id && ring->pipe == pipe_id &&
> +		    ring->queue == queue_id) {
> +			drm_sched_fault(&ring->sched);
> +			return;
> +		}
> +	}
> +	
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		ring = &adev->gfx.compute_ring[i];
> +		if (ring->me == me_id && ring->pipe == pipe_id &&
> +		    ring->queue == queue_id)
> +			drm_sched_fault(&ring->sched);
> +	}
> +}
> +
>  static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
>  				   bool no_delay)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..0b2f6ce85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
>  						struct amdgpu_ring *ring);
>  bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
>  				    int pipe, int queue);
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +					u8 me_id, u8 pipe_id, u8 queue_id);
>  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>  void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
>  int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 2c6f1e25c..888c9f3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6688,37 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>  					struct amdgpu_iv_entry *entry)
>  {
>  	u8 me_id, pipe_id, queue_id;
> -	struct amdgpu_ring *ring;
> -	int i;
>  
>  	me_id = (entry->ring_id & 0x0c) >> 2;
>  	pipe_id = (entry->ring_id & 0x03) >> 0;
>  	queue_id = (entry->ring_id & 0x70) >> 4;
>  
> -	if (!adev->gfx.disable_kq) {
> -		switch (me_id) {
> -		case 0:
> -			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -				ring = &adev->gfx.gfx_ring[i];
> -				if (ring->me == me_id && ring->pipe == pipe_id &&
> -				    ring->queue == queue_id)
> -					drm_sched_fault(&ring->sched);
> -			}
> -			break;
> -		case 1:
> -		case 2:
> -			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -				ring = &adev->gfx.compute_ring[i];
> -				if (ring->me == me_id && ring->pipe == pipe_id &&
> -				    ring->queue == queue_id)
> -					drm_sched_fault(&ring->sched);
> -			}
> -			break;
> -		default:
> -			BUG();
> -			break;
> -		}
> -	}
> +	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>  }
>  
>  static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 6baac533a..3f0d29372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5019,37 +5019,12 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
>  					struct amdgpu_iv_entry *entry)
>  {
>  	u8 me_id, pipe_id, queue_id;
> -	struct amdgpu_ring *ring;
> -	int i;
>  
>  	me_id = (entry->ring_id & 0x0c) >> 2;
>  	pipe_id = (entry->ring_id & 0x03) >> 0;
>  	queue_id = (entry->ring_id & 0x70) >> 4;
>  
> -	if (!adev->gfx.disable_kq) {
> -		switch (me_id) {
> -		case 0:
> -			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -				ring = &adev->gfx.gfx_ring[i];
> -				if (ring->me == me_id && ring->pipe == pipe_id &&
> -				    ring->queue == queue_id)
> -					drm_sched_fault(&ring->sched);
> -			}
> -			break;
> -		case 1:
> -		case 2:
> -			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -				ring = &adev->gfx.compute_ring[i];
> -				if (ring->me == me_id && ring->pipe == pipe_id &&
> -				    ring->queue == queue_id)
> -					drm_sched_fault(&ring->sched);
> -			}
> -			break;
> -		default:
> -			BUG();
> -			break;
> -		}
> -	}
> +	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>  }
>  
>  static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,

