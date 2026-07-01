Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815BEC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A941510EE0D;
	Wed,  1 Jul 2026 07:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yZ2bcgEa";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34A010EE07;
 Wed,  1 Jul 2026 07:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFNSi6VnlL3guHlMm8yseVQbL9vBWmVstXjPuucJ9M9IvS2cup2FWf4qEEXIImjJEX0VHbMaaCyeZbgaGYSpcY06KZ/tgg6UDulz3ZEURZU4n9yLfY5UBehlp3gbhup1zi8Nx8XM6oktVBmoxb65+4Q6DGUlxet4lEc1Qvc/FjknaiNagHzgAqAMgiFJ9NumYaKGo2u17pQX4VyqOaL5gYNcKp/dTTjKIv2J1nFNjPuxZ2ppXsGennCjo7bAwNrsjI+jJCPrK6XaOjbxYYEhHxi2V9GFnes/fIQwhghbrcChNOnyXSj02zXITns4add0MiAVby7si5GR6bFn813zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDZObnylcYjZdQ+oKbeKB1jYYEWi5HlNnx0lKCBgIi4=;
 b=Ro8rurK/PsOnP0bUsC4/YhLuzgqay1sVSqQuK17tBShCKuiTFYj9rWM22k8ytsdKIWxoAap75TvqV2ae10YBeQbYflsBiMt2OOI1DVbE9gAGYY5txIvy9ZyX3R+tmNEORSa3mn/vZzrI9/gERJnLkfCnbTnFzUYtdGgQ9xfw/C3CFHAyi3KmQP9O8/ueTzyutEKzgAJ0SCnyky9pcf/UH93OtTnxxO7rgEvsAxJc0VcdqUMaJZQyvoJFAYIrb73KAVh3zBKwUBRJO3L9FLzqaW7Ecw+FNN+EOxfAhslJ2zE3UQXRK4tTfy18QV+macLJw3wlBpm9ttA810nK+8xpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDZObnylcYjZdQ+oKbeKB1jYYEWi5HlNnx0lKCBgIi4=;
 b=yZ2bcgEaLC3elAayTt3YQbHdELDoPL6nYEtSzGHNz0QRCXnAxIBk5aYn88MkxK2QJP18tNU+iZrnEpobwGUJkDveEV9BOp/ytfy3LFAF7CNO2FLdHbvCUQpjU7/+cbbbeEKPNxGPoo/lW1YknVDZLvsE1XVdedITi221HVW9Lkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 07:18:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 07:18:34 +0000
Message-ID: <d3bbb2cb-f073-4518-8f59-48619eb124df@amd.com>
Date: Wed, 1 Jul 2026 09:18:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: Felipe Sousa <felipesousa@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260630205545.23920-1-ulissespaixao@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260630205545.23920-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0391.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 4074ad84-cef1-4dc0-d78b-08ded740f63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8ZZ7x1hp0qMe4Bf1P+MNf+8/89X24r0xSsY8qQrIFZ6KucNeha6n2221lkw7B7sdp02QIr6zSP54zOnknYR5zl2lT3fav8ANX9dTs2jIrq9CKFRGPptnJJ4Wbyc+qHoB/iB1xLP+WMkvFKIV6xgYxQZmD1CvxPb9OZqv5oD+NvdZaDPn68E16I5ntcwY6AhHwxiGHJ/nZ5ZqyD23aJ8Xsu05ELft0HcIm58Q/4+gPnEzAmlcbU+FbJxMD8FzEEc5gSsTTWOwwkNgSUhH6f2GnWqyWl0kpbvgIDrpeMHS2m/GHXEFAMWz1OsUKCgDsmFJVtvhN/qqxuloyhnxIKcJppp999K3u36r2f1SolJW9+Nih10tNSoRzkc1Fs2uM25q8gu+GdA66Wkl36QZ8cLVh5EOirmKkI2l13O74onnvkKq/IGim7bB4/Ney4fO/lEYmPr4ZjMqci6USMwMKbQxnOMl23rq6qYxNpivDqozSwI1qbeZ1JJJBjTRAvpE+n38M2tfYxjq6oUMBrA3PyjWK9ZHmqsheq2xQP4Zi4uwg8COFWbQNUka40hVLHZXJqKpYpkvQA04XvnWpqN4FTP4Z3zsnPB/lNZcVCKu0Phtq5e/zmfYBh8m96QWbaLSVP5eeG/Gs4vPGUewOzlw3eeoHkkWZv/rXO3BmbQNHsOH11Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVkrOHpZeDFDNk40cnZMS2pxRURqcjVOWXdBU1VJdWoxMjd0Y0xZdXhVU09P?=
 =?utf-8?B?cnNaV1dRVVZ6S05XWDFONHZ0Ly9GRHlwVitqR09oZVAxV1c1N29hWlRnaGlh?=
 =?utf-8?B?NVM1MEtrSFRKenZXa09TWHkzL2RQMnczd01BTmN4cWR5dUtubXBNaTdQSVFw?=
 =?utf-8?B?L2FCWktvN0huT0s1TGoyWVlLRG1CRzJyVGRFK1Y4dXNrMUFjSmQyTE1nU0R2?=
 =?utf-8?B?ZTl2RXNzM2pSRVF3SmxWRHNoWmp5YU5lWmYxRDZVU2Y4Y21FN1Q0N2ZoTmFj?=
 =?utf-8?B?ZWN3RmhzQ0Jmb01aMUV5U2o3SUp1V29QQ3g1U1EwZ1FjamZORjdFUWhsODNE?=
 =?utf-8?B?NVo4RUxBeWw2UXFlYko2dHNTUFEwUXowc2M4MG1Cc0FVN0RrRXpLMU5PZXlv?=
 =?utf-8?B?dUZMY2ttYU5zUVNPOFpON1dtTDlwS2VUUmZhTUhvcUhJQjJPUEhXbWRsQzU5?=
 =?utf-8?B?YUgwL1A1eVEwcW9UdGNnQi82N0NNNy92T21NWHNwUzdEemdkZ2VScnVvekVP?=
 =?utf-8?B?OERoTmI4bmplYk5OTG1sblIxRjBwdXVSb3VSUGdNYjc2SGN4TEFSbTFZM0V4?=
 =?utf-8?B?bmpTV0M1a0FVU3R4cTlKakVYdXpyYis3a1dQc3BtdWhBcFJIc1BvVVdMaHBS?=
 =?utf-8?B?RTBvbTlmd1BMWG04cXFrUHhZYWVrY2JncDN4bUJQL3B4MWhtS1l4b1B2am9H?=
 =?utf-8?B?NTcvUnc5Y0d4U0VHeGRzOWtxdUxWMmlUekIvLzYzUXhESXlGQVlkb1VYSWhG?=
 =?utf-8?B?MVF3NHBrZVM4dzFwZktyelFPd2lFYzc4VmNSbUJNRXRoTDVVamhDSkE2QVpQ?=
 =?utf-8?B?ckhtOVpma0dDRGlGNGhLMFZYZXVEQnJPa1V3RjlkSjUwemdLbCtUb2tFK3hY?=
 =?utf-8?B?OXR3Y2YvaUcxOWxJZmVuWWJhK25NOWtyVmVOSlZINlc4Uy9SeWRyalZqbWp4?=
 =?utf-8?B?d2tiWm9ZcGtSUkpERmo5dGREVHFEYTVHU016WTlqWVQzT3hYUEJNUURYNmlu?=
 =?utf-8?B?U2tMZ1Q1K1F0aFNBeDhQUnhlZXV4MlJBazJhL0pqbGphNmdkMkxMQ3RPK2hy?=
 =?utf-8?B?QkFRVDErd1ljeERqdGN5aG9Bbjl3ZC9qdlFDM2FoM0t3eUpMU0NVWk9BSStT?=
 =?utf-8?B?dVgzbHhpakt3U01IKzh6NlhocmdkQWNOcWtvaWdLZnAvcHlKdC9FN0V0K1dJ?=
 =?utf-8?B?QjRvSGhUTVJLUlA4bG0rN1FDSk9pSzZGMG9oRlduMmNiUUNJdkEvQVpQQ0F2?=
 =?utf-8?B?Z1YwNG9DL0FNbE9MMUNKbFg2NzkrbmN3YlhVZWo0MEErOWNwSjRmNHdhQXBO?=
 =?utf-8?B?MVpOckxUU0tOSkRRb1ZVSjVCTFBoeklPQVJRK3Rwc1lGbzJsM1hEMDVSRDYv?=
 =?utf-8?B?Qm5RWDdpZ0dyKzN2R2d6dmFNbUI1SHdxaFpPdUtQUzVnQnB4bGl4aGJ6RzVV?=
 =?utf-8?B?N2dFQWM4TVhjOVlEYVJoc3dNQmV6dXNKZklBektDSVYya0lVU0Y3TEF1VFpr?=
 =?utf-8?B?RkNGR2tFbHFVM2IwbnZvNHl1VXlXdUl2Y1AvUmFkNWRYV09DMGRhN3V1U0Q3?=
 =?utf-8?B?OG43Z0V6dktRLzFndFB3VjlUOTB6V2lCSmplNE9veko1cTBvMHlhcUN0d0d5?=
 =?utf-8?B?NlVENEw1dlpzd3MwVjdzbFBxakRUQnA5MHp0aTVFbUVFWjdCbm12V2RPTUhC?=
 =?utf-8?B?MlFuVk9NSTUrL2craFBhcWQ4LzBoZ1FkTG9lUHBiNEhxSmhnUGRtamtaa3pX?=
 =?utf-8?B?N2p5d3RwS0VhKzc3ZHdVK2s5Y29iY3BCNTFEajFVWk9Mci9sMStjWlprZXJs?=
 =?utf-8?B?RXlYS2swVzlrS0x3N0NFaXdYTTMrNGJ6UXFPRjVHMFhtMzVwdCswNVQySzZn?=
 =?utf-8?B?c2R1VTZrdGpadmNrVDFWKzh1b3ltQ25oeUo0QzR1TWxGOXcyT2tXYWJYTGg2?=
 =?utf-8?B?MGthZ2FkengvZlFNcFp0MGU3ZmtHVWp2NTVrTXVISkxmZWt2d3FLcGFzZmNF?=
 =?utf-8?B?ejVqenkxTDQ4UHdCeWFzdjd1WXhnSnhrQms3SklzVzh0ZkYzOHgyNGI4anNU?=
 =?utf-8?B?M1NSbnd0VWI5UENVZWhBeERuKzRaZUl6NkVucHIvR3pmVlFPcm9tSSszbnV0?=
 =?utf-8?B?VTZmcHF3a0l6QUNRS25ZWEh6M21keHhqWk92MXFRODdUN2ZiVXVKL1AycS9C?=
 =?utf-8?B?a3NCQlgveVNXd2ZHamVmT3YwSWNFcnl1VzZPSTNwVDhmNU0vdmZJWktzMXh5?=
 =?utf-8?B?YzlYbDJlVjJPbkNZd1RTcEZnd3c4dnIrQVRlSEtGaG5xUmcvek00L2ZDZ0xV?=
 =?utf-8?Q?+Ohzr+eMxMuTvFtPVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4074ad84-cef1-4dc0-d78b-08ded740f63e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:18:34.4332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUaMR3MTkbCq0AZB3aFAAMyjU1tNljQIJMoTTQ12LUsiKFrAV6QscfAAC6034ako
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
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



On 6/30/26 22:55, Ulisses Paixao wrote:
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
> Note that v2 was already reviewed by Christian.
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 36 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +------------------
>  4 files changed, 40 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca87669..98035129a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -830,6 +830,42 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
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
> +	if (!adev->gfx.disable_kq) {

Return early with a comment would be nice to see. E.g. something like:

/* The scheduler only handles kernel queues so this is a no-op without them. */
if (!adev->gfx.disable_kq)
	return;

Apart from that feel free to keep my rb.

Thanks,
Christian.

> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			if (ring->me == me_id && ring->pipe == pipe_id &&
> +			    ring->queue == queue_id) {
> +				drm_sched_fault(&ring->sched);
> +				return;
> +			}
> +		}
> +	
> +		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +			ring = &adev->gfx.compute_ring[i];
> +			if (ring->me == me_id && ring->pipe == pipe_id &&
> +			    ring->queue == queue_id)
> +				drm_sched_fault(&ring->sched);
> +		}
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

