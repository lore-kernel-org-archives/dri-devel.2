Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE57FFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADF010EFFC;
	Wed, 29 Apr 2026 13:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHZJIaBH";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E05410E3E0;
 Wed, 29 Apr 2026 13:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz266IpZKBPldZmKzBNJQThT2MprYqDqU1cklk0ehWNeS5w49PHC+Bw4u50VJTmpewGL3BcOpP90/HGsTVTfOIriOL+Th/XjH88tcWPBcnnHm1pJfgxiVuzfJSCPd+GoHhP/QHKcCGjJvJK3g9Na+aFYdpNnLEbEALL2scO9gsaQDpz3BPUIiH9QjFZ6F85dFOFOBO7hy4RUhv0DF3X8fvdXOU8SXFCCD4FBpQk3NSRcFmhn9rQ+eQeG5kmYvqteMbrzm4+bqoGHsHOvJVKPUg+/YzmfoSjLJN/QBupEqigwwTJb3wMe0lwomVe8l4JwjRWd8S47UcGRW5JcDWnWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKokh2X0Uxys1MElfp9oGA4adeA+76ON/aHO6hnBxjw=;
 b=vlKzT+yGqcqdvlI+I9OFU/EVtkAqCBpTEW44syjT4a9GvXnRDRzYrOYzCIlPhX5dHh8nEUIl6NPBn+kqtZnlXeKY2y39V0K61J+jHPMzFNf60RJnNulhgRhV2+ZcQrY/b/h3I6SCcoQQRj/ymtsRvPm4yBccpMowF7q8rcvuFEk5OKzeLl2JAoPIQCSTqwWwB08WeTNhU4+VRsjhbjqdyi70cYc3Su3QcNlnrw1VH/8Sh8P6ZVwnoSfY87Ad4ayOl71kn61F6g23yUwzmN5aOemHXBAQBsGhqzzhX5tlw//PXDhJmi80Z0HABLQuu0DQea+W/aUaLRufkTC9mawblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKokh2X0Uxys1MElfp9oGA4adeA+76ON/aHO6hnBxjw=;
 b=LHZJIaBH9Aw0c8V9PxphvyY9HfE/h07yIy7od0LKCVAUMLwwXoDAayLyRPVIV0tOPWpG650240G16jmyLZpZmZec6A/HTsbZZmD8Dka2UZlxba1HI5nSLMLe1WhUVwIk8ZSNxZJ9P39mY6LwDRS9R1E6dOXfeZvIVxlaLv8UM7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 13:13:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 13:13:17 +0000
Message-ID: <38b716ff-fac9-4921-8121-4a76cf1cef18@amd.com>
Date: Wed, 29 Apr 2026 15:13:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: deduplicate ring preempt ib function
To: Leonardo Cesar <leonardocesar@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260428232009.10737-1-leonardocesar@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260428232009.10737-1-leonardocesar@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: caa2b859-9755-4e34-5fca-08dea5f113e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: NRs4VBIu8RsyjRWJhffh2gHsLh6UMtGtm+Crq0Dh9Y9vTvMI/I03JPdq9h6MSpkdxGAZQXLVIAlnGoDTqvDPl4SIAs8rvVXvRgkCbSn2YrThEKrMT211EVyZmOQp1SttxnUB+pnb5teti5YpG1AVGQludOeQpii+aynXdgS8ef/KZlz+YYstd4rewz+k/8H8WvMD1l/hAQh2wbVB30+O/J+FUz4YYCnh3z5f2cSR++gF34HExhpUH+w//5h1qT+dQ53RpU2NEGD6vAwKhN7P466DjFYioUY9loqg32yKg+0Eom+yGL8+6IdNKpbqig+fJQ5B9TOW8BD1XehLkawK02SWU+LxW0Kr6qlPCnjxn+us6mihVHyKauqtaTNlbueaThnDuNkfmTE7BqjItgpVXdkY5G+Mw0M40iDBWphMFj2qkTH4b06Mb1A+XzLj/1IIszS+pGXliUsU9NRujWIYGkSwlMgoGA9PNjJFK28vXdGMiX7XYRCFHWGRzJotL/9Ryn3yq7zdp/kBdkoOXgWFZG6Ic8t4erD4a/71RKRLjkCxCNEA/xbltOGnoDgZfIfCRdggmKeLscKL2+CY+LAa/TEwDQ59BzoxS1HVELl2Et6Ieg/0y/bAfPOYzsPxs4OHnhC1MofwwVaC78mqELQICTzfNLOxOyS33WGpgxNADzGvlMwPzkChft8cxtHosvQ3wbOkErM60p5N15+RdNXmprbsmjM2xq3eOW0XinNMMCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09BVjU5NkM3T01UaUtXM1dFcEtoMWNmUjUvam5WVUhmV0hkaGhmV1lFeG5Y?=
 =?utf-8?B?YnNyYUZGbHVQTzIxdWw2bmRqT0NUVEQ3bGhrbW9pVGxLaEY2aU1QSHNaZncz?=
 =?utf-8?B?WFIzTWtqU2dCbGVJcktkVTh2ZllkcjdPM3dNQy9LcjZOOTFQdXJWUnpwZnhQ?=
 =?utf-8?B?L1c2c0wrWnMvNXg5aGpzMVVBdFZpWTlXM25KODV1dS9TRGU4UTRVY3FDUGEw?=
 =?utf-8?B?dWlodzY1SU9hNjdaTkhSb3JBNGpBT0pBRDBna1orY3RKUlNnb24zMllta1g3?=
 =?utf-8?B?a0piN3oyMW5oUU9lVExLWTJlQXlMbzdrckFHWTZGZEZqR2dqVmVyTnZZUEZT?=
 =?utf-8?B?Z1owbWZDdVFJajQyWmNiSmZuS3UwRnlJdjVSMmx0bHRoZmRKMUJadk1vc2hF?=
 =?utf-8?B?WW4raDN6MWNVN1EwTHpzVXNPS3g5eXpEU3hYaGc4WXhOTk1OOW85cVRVNFow?=
 =?utf-8?B?YW1mYVJoU1BXQ1dkcjlKRTdSWEJXd2NLVDdocXVEREFzdUF5bUNNK25ZeWgy?=
 =?utf-8?B?WFlSb1VoN1NMTXpGYUhGdldMaExYSXJ1Skd1WEk0cmxKVndaV0o2WkpnUjM4?=
 =?utf-8?B?SHVxdS9ZL01ySlZMeGVqRGVnTG1CNFB1T3lCem12TjlvWmN2M3N2ZnFVbzAr?=
 =?utf-8?B?TzlPbzh5R2tWTmphQXRpNE96TGNISlRUNzNSdUZnZnFrcXdVZTQrM21nemkx?=
 =?utf-8?B?bWcyWDJQaEwxS2dIdGxwbmZWSU5HQmxPWnN1TEhLSHVpa2Z3TzdudXVMYlFJ?=
 =?utf-8?B?dG94ejdkSHVaMUtiZExITWVtZytGeTgwUkhOSUJjRzRsaVhyZVRiT1c2T2dh?=
 =?utf-8?B?MkFwbEdXMjJPUkVUNldkMmJOZ1c3YWViRGJ2a3FTaHdCS0Nvd1lxZHdtQ2My?=
 =?utf-8?B?bTRDTzg2T0NvRHl1eHVndU5KM0lZVGt5UW9TcnFjSjV0MWhZb1BUMGl1K2RU?=
 =?utf-8?B?ZE1MY0NmTUpVbUdWWnJlOXFCVDYzQTlqNVFKZFV4b3RlUHJyNU5RMm1YNGN0?=
 =?utf-8?B?WERtVjdsaHdUQzNycXN3SUllUVUzSTZXOHh6RGJGcFUyNWJTMXhLM2kwMXJS?=
 =?utf-8?B?SUNRWGx3eVYyZlEwZDR1bjVBY3pTZ3Q1U2w0TWNpb1NRNVk5RFY5YWQ4QW9X?=
 =?utf-8?B?L3dndUh1UUtjaldnVEthQjQ3bkRQOU4yczB1SHlDdGtjdDdRUWdGV1EzVndG?=
 =?utf-8?B?ZG50b215YlFvbjdWSEo4enNJcitNYUhrbFh2NjJ5UlN3aGp0cWRFTHhvNkVC?=
 =?utf-8?B?VVc4RVVwVHlBK1FKTUJnY3hwaXZ6OTVOSVhZdFE0eFJFd3lnTXBpaUxTRTNp?=
 =?utf-8?B?bUdQWks3WG5EMk42blJIWi9Ba3M4K1hzS1dlby80aEY2TVdGMFZqSU1XdUhC?=
 =?utf-8?B?T2xNTThoYS8zUVVBaTFvUDJQZytQTXRRYkF0ZkhoOTJLbXR6Nm9TRncxVTZB?=
 =?utf-8?B?WWhtNVovd21MMEZsV3ByTDMxRmkxYmV5bUlPamQycTBNa0MxS3RPd3NLeWVm?=
 =?utf-8?B?TXFUWjQxYmllUksrNXFwUFdsUzUraUhHN2kwa3BjODFMT0JYSnJkMnQ0V05M?=
 =?utf-8?B?NnRlU2RCSnpGck04Ym0wUkYzNE1VZk1zSTl5WmNRV211QnE2U2hsaVNsTHFC?=
 =?utf-8?B?YmROWE1ZQVpPeS83K0JySzludFlGTm1zREdneFJQMG1oUlRyY0RKZnpWY1lR?=
 =?utf-8?B?cUNzeHhNRDhCRG9vQmYwS003d2ZZZjhuS3l4eGFLWml4VFI4TjZEMll3Qk45?=
 =?utf-8?B?K0E2b1J1dm5jeDNCZWtuUEV6bThiNDZITXQwM1kraEhHT2VqM3VQSzFoTG9v?=
 =?utf-8?B?SEJaRkhCZUR0V29RY1pzZmNHK3l0MXVWL242Si95N3JDM3hwUnNlWkVTSzg5?=
 =?utf-8?B?bFFGWVlsdUxYZm9LMjNUeVVjajdWN0xLWW5tNDRNcU04MzBISytWNmR0QjFW?=
 =?utf-8?B?TUFEeXRkWEx6MFpPVnFXdVUzYUpidmlGQ3dWUWdDdDFkV1NuSnBoT2dYWmYx?=
 =?utf-8?B?ZlZNV0Y1VERKdHFZd0J3WFgzeWNVL1RWT0ZqYng0bE81b1VveENJUXhUako1?=
 =?utf-8?B?MzIwSlVYTlBNS2lnRlEvRS9EbXhrU1BNQk9TMU1xOVNGYjJPWm5PSG1pRENE?=
 =?utf-8?B?NUI4a29DVTllOHRhcENVK0ZxWVVER2tmQmw2UnRYT3Y4NnkrL2NUY1dkc0hp?=
 =?utf-8?B?NmhValFPeHd0ZzFCVlRjN2E3OVZMbGlFWEw2ZnRDNUdJWmNDM3NGRWY2WDZz?=
 =?utf-8?B?SEdIL0M4KytHT2lRTUZ6UDE0dXZ1VjZTK1dHVUJ4Z1dJNFlTbkd6SDRtRnps?=
 =?utf-8?Q?qQLflHpB8zcs6mhWvl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa2b859-9755-4e34-5fca-08dea5f113e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:13:17.6303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xacUogOELllo40CnTognd9zVJtxVGxQpKYGsvjFIOs+txpXmB1I7CpyZ7S1vmOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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

On 4/29/26 01:19, Leonardo Cesar wrote:
> The ring preemption function is identical for both gfx_v11_0 and
> gfx_v12_0. This patch refactors the code by moving the core logic
> into a generic function inside amdgpu_gfx.c to reduce code
> duplication and simplify future maintenance.
> 
> Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>

Reviewed-by: Christian König <christian.koenig@amd.com>

> 
> ---
> v3 -> v4:
> - Dropped 'r' variable by reordering the return logic
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 52 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +------------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +------------------------
>  4 files changed, 56 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2956e45c9..f7ebead09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2684,3 +2684,55 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>  #endif
>  }
>  
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_ring *kiq_ring = &kiq->ring;
> +	unsigned long flags;
> +	int i;
> +
> +	if (adev->enable_mes)
> +		return -EINVAL;
> +
> +	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	/* assert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +	/* assert IB preemption, emit the trailing fence */
> +	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> +					ring->trail_fence_gpu_addr,
> +					++ring->trail_seq);
> +	amdgpu_ring_commit(kiq_ring);
> +
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	/* poll the trailing fence */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (ring->trail_seq ==
> +			le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +			break;
> +		udelay(1);
> +	}
> +
> +	/* deassert preemption condition */
> +    amdgpu_ring_set_preempt_cond_exec(ring, true);
> +
> +	if (i >= adev->usec_timeout) {
> +		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..77050f988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -664,6 +664,8 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>  
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
> +
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>  {
>  	switch (mode) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5097de940..1ba848bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6206,56 +6206,6 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
>  	ring->set_q_mode_offs = offs;
>  }
>  
> -static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
> -{
> -	int i, r = 0;
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> -	struct amdgpu_ring *kiq_ring = &kiq->ring;
> -	unsigned long flags;
> -
> -	if (adev->enable_mes)
> -		return -EINVAL;
> -
> -	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -		return -EINVAL;
> -
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -		return -ENOMEM;
> -	}
> -
> -	/* assert preemption condition */
> -	amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -	/* assert IB preemption, emit the trailing fence */
> -	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> -				   ring->trail_fence_gpu_addr,
> -				   ++ring->trail_seq);
> -	amdgpu_ring_commit(kiq_ring);
> -
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -	/* poll the trailing fence */
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (ring->trail_seq ==
> -		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i >= adev->usec_timeout) {
> -		r = -EINVAL;
> -		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -	}
> -
> -	/* deassert preemption condition */
> -	amdgpu_ring_set_preempt_cond_exec(ring, true);
> -	return r;
> -}
> -
>  static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -7295,7 +7245,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>  	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
>  	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
>  	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
> -	.preempt_ib = gfx_v11_0_ring_preempt_ib,
> +	.preempt_ib = amdgpu_gfx_ring_preempt_ib,
>  	.emit_frame_cntl = gfx_v11_0_ring_emit_frame_cntl,
>  	.emit_wreg = gfx_v11_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 65c33823a..6cf244349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4611,56 +4611,6 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
>  	return ret;
>  }
>  
> -static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
> -{
> -	int i, r = 0;
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> -	struct amdgpu_ring *kiq_ring = &kiq->ring;
> -	unsigned long flags;
> -
> -	if (adev->enable_mes)
> -		return -EINVAL;
> -
> -	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -		return -EINVAL;
> -
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -		return -ENOMEM;
> -	}
> -
> -	/* assert preemption condition */
> -	amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -	/* assert IB preemption, emit the trailing fence */
> -	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> -				   ring->trail_fence_gpu_addr,
> -				   ++ring->trail_seq);
> -	amdgpu_ring_commit(kiq_ring);
> -
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -	/* poll the trailing fence */
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		if (ring->trail_seq ==
> -		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i >= adev->usec_timeout) {
> -		r = -EINVAL;
> -		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -	}
> -
> -	/* deassert preemption condition */
> -	amdgpu_ring_set_preempt_cond_exec(ring, true);
> -	return r;
> -}
> -
>  static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
>  				     uint32_t reg_val_offs)
>  {
> @@ -5539,7 +5489,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
>  	.pad_ib = amdgpu_ring_generic_pad_ib,
>  	.emit_cntxcntl = gfx_v12_0_ring_emit_cntxcntl,
>  	.init_cond_exec = gfx_v12_0_ring_emit_init_cond_exec,
> -	.preempt_ib = gfx_v12_0_ring_preempt_ib,
> +	.preempt_ib = amdgpu_gfx_ring_preempt_ib,
>  	.emit_wreg = gfx_v12_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,

