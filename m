Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C39F94CD8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 06:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B0E10E0E5;
	Wed, 22 Apr 2026 06:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sL0QkJLl";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20A010E285;
 Wed, 22 Apr 2026 06:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSvaZZo7xrKmVRZ2dkHRT9AhiZpBfvyv3Hi2Bvj2wrfIWcHUfLUM2Atxc71PLE+yIXR3zV5PBQUgqhNG5xUlBtMll1Bdqr10UwBCvGmtdkw+cJ3uwiKXaslZIYtQ09E4ioVdgQGrpVJE/lW5f0KMbK6/KRTq48aFm7dpPuwIlKW/ZohY4SvdehpYi1xx2YTtn+OYCMb7gkSMPJu5HhCOuimeTwgzfJ4EYN0EE0frKabihZeHwkwjMitk2QcVfzG/wFE2NGTk27ikQhAuRwVc320hxSLewrZhTP1iPvU8S3pZB65bJtfj4FzcSjLp0UCM7TB/h/XRB4/bcm61E5w6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32e+y7Q5WwfqF2pc+DBFUE71BmQEdQl+uDdB4hpPQso=;
 b=V6ntvN1M/nKDEhrCJhzShhpniwM22MMDI1GNT9lEJJc97fvN5fLvKSTTjxkyncMxtcNi9f0pJ8GpmM9EUdxjDBqSjWwGVZK3yOFAg/Ea7GMKIO7USIZm/ZZaj2Oomcs+FmmIJIXolXlURmsAwRCEjUiY3G1EP4EqCtDI4V9tYkQAL0dzFy3Lr/Fk5q+3Abn8+Y1cPZFB+1tTXiPwa+0Zu8KECKZi0UHO7CGTdGg0vfnS6RSPfBT8mtrcTOgdBT5uYhaEPh5mPjU44E4qjCsfGFNFMF2l1AJmveJS2h8gNZ7zK7zEefjBrMvX/47+PjhCmepwC6696UhonVrizl+VCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32e+y7Q5WwfqF2pc+DBFUE71BmQEdQl+uDdB4hpPQso=;
 b=sL0QkJLlnvx6QQ7D34whT7nAQNqatZK/shJmdLGS67r1AggqQ1PdxmJX3HJGWwPYR918NeB7x9BtoBDzKwFoE7qNT9LJzi+ZTriGFQxP2UufIpOK+HBgnsqL9fSBNHy1gZJOmKDohHsYjNl2UZ647dkkrZ774Q5q4nDMpwDGtuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 06:58:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:58:40 +0000
Message-ID: <59b686c6-42f5-4cde-8199-dae64722bfd1@amd.com>
Date: Wed, 22 Apr 2026 08:58:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: deduplicate ring preempt ib function
To: Leonardo Cesar <leonardocesar@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260421200311.15624-1-leonardocesar@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260421200311.15624-1-leonardocesar@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff6e2dd-b700-4531-4c37-08dea03c956a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: BFVaOGRwUoq7JSQeSy0PCUGeHyGHoXDyHyfzgxkr02yyJIv0+WuhdjjKzeHsRIQA5zTzLjic8+mclU+p60hYb9hO9Yc2JDn26E2g/lDV68d7ERpukzOBbG0YQcL7V9JC5e8L7jKxVjC5mvtR0/nRAnKAK4R0kzkbYeal79fAs3GyFf/8WnXzpJeAh3QJfr2L19U8ZszkQQLv72fl3ZTZXvjDO+mWXKFOkrv5Kes5yCvATp1h/zFWTYqOHJ8ficNiHrxXYV6TMvasHis0WWvpQELcp7tz0aBJlbPrQMfFbA+98UYsg5aL5FL6XIOie46McLgHIpH6B5BD5lWJ0omeuGSjrtC9s/d8DOYQKOMF145olUmfYk1nMELkO6UtToZKHxQ/aqNQLO7gSztmjXKuVBnHWD7ObGsNI5c3wlyyNQx70wAiBAIHOlzEORZ3wdGJhNX9GN/ZbvvvT9Q7NlPpj2z3jf+saCcrp5Merv0UOLsbJN6CIAqxwz2hmpYAmZ+Mm53GMFprL1H+fJBVvXL5NRJU/v10NPrPyHcV5PVaCRW6PudhPnNIvTt6wlRmH2EVlC79rFKssItWKmJKyIXZVcgeot6rsaHIA3LTB+dAjq+gDyZY6zjXPz/ovUxOKbhj0igWkaq9H0PP3MS+1FydlhNk1dzEFguC5qYJU+WNbc8p27VXZqA40fazHFEc5BbN0ssqDbL2kL6EQZ4V3tsMltPjsnM9Yu8e86oY0HqscJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZjS3dTdVQ0c1NFRlJXUUI4aXdNOGFJaWp4M2hQODBRY0NYZVBOcGF6dE8r?=
 =?utf-8?B?Z3FGNEdwRDcrWUpJUE1ZcjdVSmdDb2pId3lKN1JPQkpQUnJPTVJERHg2R09p?=
 =?utf-8?B?cWpjSGpZQWxTaFN1K2lGcXYyZUsyTE8vbElGRGxXTUFxTjcxbjJtajVMbzNH?=
 =?utf-8?B?WVYrU1ZNUzhGQjJ3VlpBa1hNWHY1YUxBdXk5cEZ6NEtwSnhpK2tVNXFJT3VC?=
 =?utf-8?B?dUUvUWtYVy93QW13a3RGYklEYkVJZy9PSzRuWlY0a1lZK3AvN2dEdVE2R01h?=
 =?utf-8?B?eXhzL1VTUDZmelQwNEdqSHdGbjRJK3hFT011N2txenVBNW45TVkzUHVUS0FG?=
 =?utf-8?B?SHowUEduc3JtWGk0RjZkM3Z1Z2hJSnRRWjdYMzJyNkZ6amNzTS8yOVd5Q3ky?=
 =?utf-8?B?YUYzazZYWFlma0g4NHpxTmlyWkV1TmRDa0Ezdzd2VCsxcndEcGFRakdFWVpw?=
 =?utf-8?B?TjBGbmxsR0pKQ3dxT3RZeDAvZFhkMEVmK2JFWWxtd2N5V1pXaUxLSWVZOVZC?=
 =?utf-8?B?TUV0bHFvZkgvRERBbDhRaWdjc0s3RVZET0xSV05rdkw0c3YwbUx5UlJqVkxG?=
 =?utf-8?B?S0N3bjFSM0RzYSswd0VPV3l4bGZpRmlWYldQNXVpMUlCV1Z4MlFNQURFckNI?=
 =?utf-8?B?VHI0dnVORHkxWUdLMk5wMlJjdVB4T3BtcDBuN2k2RW1UVFpJdWZTL1VJTkpt?=
 =?utf-8?B?d3AvNlBzMldQdHhVMTJHdFI1SUcrcjlxTnhYVGxBbk55S0JEcGVuemVUM0F5?=
 =?utf-8?B?VExqNzZKeG9rbUpzeHUwZllTVmZWQnB0cmdsV1g1dmp1dXptcUVqL3pDdERV?=
 =?utf-8?B?UTJuc3ZhWFBQMEpIUTRyTkpaRGtKV0Q4TGRHeEVPckRuUGVRTDg5V0RYNHAz?=
 =?utf-8?B?TUlFTGVWNFNxNDl0Qnp2aWVTT0ZUODRSanJWeDNVallkMmU2YnRBMXo5VHk5?=
 =?utf-8?B?M0tqYjA2b2JYQ1ZUSG9FN1VJdXptWEhER1ExOElub0FZVXRrc2tIQlU1NHY3?=
 =?utf-8?B?WmVnRTBnREUrY0s5NnBVK0xVU1p6cnh2OC9GekVlNFR6RXNhSk4rY1B2bHRh?=
 =?utf-8?B?RjVHQmNpT0lNb2JvaHp0MUUwV25vME9WbDd2L3poN2NBcVBTNU1kdjJnSkNl?=
 =?utf-8?B?WDcwbjZXWGpHbHA3MUJQYzdUMUk4MGFMRnpKYVFMcWVrSjZ3TUFCM0VxYXE1?=
 =?utf-8?B?Q05vT0lQRk1YanVoaW51ZHAxUEE3bVFiTG5kb2N2MWF4VUlteWdPTFFoeUxC?=
 =?utf-8?B?bC9YT1RteFpYSzJ1MmswV1BIVUlQeUdQR1R5TWdMZDlaekxMVmdFbG1CSlFB?=
 =?utf-8?B?dkprZnBXbEwxZ0l2TzFwYjlkVzJoNnhuZzZnNFRQWDZJNEcrM3k2T0xSUnNH?=
 =?utf-8?B?Szl5d1UwSVJWTW5LL0QrSER6bFQ5bGIxc01DUUN1dEpERjA2bzdXcjVlSkkv?=
 =?utf-8?B?V2R0U21mVWczbEJRMU5kWElocFR6SHA1eHBWdEJ4QjJmUkZBa2tJbkJ0WFdC?=
 =?utf-8?B?Zmsvb28zblVMK29pSmVpR1lGZmVUeWVQd2NhRHBaSlNETFRuRUpSTnM2YU5n?=
 =?utf-8?B?Zmp4MWVGT3hEdUdrN1hhTWdBK1hNNUgvUnlVemswbXRocTEvenRXN2ltdDhM?=
 =?utf-8?B?YVFlTzNuekpNRzBoR09OU3dNQnByU2M4MTlPRExHRUx2ckNTU1ZjL1Y1eXNN?=
 =?utf-8?B?UUhKNHgzSnkvOExUKzVVVVozclRDRVRjRUt6UEVBclRvTUlNZ0tyU2pJSlRa?=
 =?utf-8?B?N0RmTHRPQ1ZqRjZJdzVDMDRNU3FKWkZITjVpcjBTNEw2ZGlDME1qdWtEbGc1?=
 =?utf-8?B?UHdMM0l0VE1yTFphTmd6SzRLTmU3TDNIVVA0QXJUM0g3NGNMcWsrT1VhRERC?=
 =?utf-8?B?L2lQS1YzNmxRWldmdk1DZUtoc1hzU2R6K1A5cUJobFlTZFdFdGJtMEpSb0l0?=
 =?utf-8?B?c0RGYWNncURRSHhEQ3lxR29McGc3UFJGeEJMeFQxc1hsSDRwT2s3T3YvN2Nk?=
 =?utf-8?B?OG9DQkhmbFZWcTI4QnlmckVZL3ZGaTJFZGdWL1NsYUlNbS9sMnkwUVNiVlAz?=
 =?utf-8?B?Rkd3a2pvMUgrSHV6YUdTMys3NHkwbUlLQzNRaVJERE5lYmpyaTI4R1FjMnlQ?=
 =?utf-8?B?cmdxZ2FUK1ZHZWU3TENjYlYrUTJsMDQxbHIxaDdDeEVVSkRZQTJOcWFlTXh4?=
 =?utf-8?B?alJoTWZFU2h6dUNtYTBsQWM2dnJuR01uYlV6WVpMdkpNb2VPdk1KUnFwQ3BG?=
 =?utf-8?B?TjZYN3VOdWRoUG95SzdhRSs4RWg0Y2hUeGNTcFdjM1RJWS90U1l4ckhpV0tl?=
 =?utf-8?Q?FiN8VsjkG4Yr6RyyY/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff6e2dd-b700-4531-4c37-08dea03c956a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:58:40.0601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8urSH/3xJo7r78S0nWzVfU5CgXmzLlzebP+jdcbsOuoVb9JAusvJ100ihqOMyN4O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
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

On 4/21/26 22:03, Leonardo Cesar wrote:
> The ring preemption function is identical for both gfx_v11_0 and
> gfx_v12_0. This patch refactors the code by moving the core logic
> into a generic function inside amdgpu_gfx.c to reduce code
> duplication and simplify future maintenance.

Yeah that one looks reasonable. As far as I can see there isn't anything HW generation specific in the function.

Question is rather why we have that for gfx12 in the first place. @Alex IIRC we support preemption only for a very narrow use case on gfx11, could that just be accidentially be copied over?

> 
> Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>
> 
> ---
> v1 -> v2:
> - Removed wrapper functions for gfx_v11 and gfx_v12 and updated call sites directly.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +------------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +------------------------
>  4 files changed, 55 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2956e45c9..a157cbd8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2684,3 +2684,54 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>  #endif
>  }
> 
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +       int i, r = 0;

Just a style nit: Variables like "i" or "r" last please and don't initialize vairables like "r" while defining it.

Regards,
Christian.

> +       struct amdgpu_device *adev = ring->adev;
> +       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +       struct amdgpu_ring *kiq_ring = &kiq->ring;
> +       unsigned long flags;
> +
> +       if (adev->enable_mes)
> +               return -EINVAL;
> +
> +       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +               return -ENOMEM;
> +       }
> +
> +       /* assert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +       /* assert IB preemption, emit the trailing fence */
> +       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> +                                       ring->trail_fence_gpu_addr,
> +                                       ++ring->trail_seq);
> +       amdgpu_ring_commit(kiq_ring);
> +
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +       /* poll the trailing fence */
> +       for (i = 0; i < adev->usec_timeout; i++) {
> +               if (ring->trail_seq ==
> +                       le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i >= adev->usec_timeout) {
> +               r = -EINVAL;
> +               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +       }
> +
> +       /* deassert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, true);
> +       return r;
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
>         switch (mode) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5097de940..1ba848bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6206,56 +6206,6 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
>         ring->set_q_mode_offs = offs;
>  }
> 
> -static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
> -{
> -       int i, r = 0;
> -       struct amdgpu_device *adev = ring->adev;
> -       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> -       struct amdgpu_ring *kiq_ring = &kiq->ring;
> -       unsigned long flags;
> -
> -       if (adev->enable_mes)
> -               return -EINVAL;
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -               return -ENOMEM;
> -       }
> -
> -       /* assert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -       /* assert IB preemption, emit the trailing fence */
> -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> -                                  ring->trail_fence_gpu_addr,
> -                                  ++ring->trail_seq);
> -       amdgpu_ring_commit(kiq_ring);
> -
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -       /* poll the trailing fence */
> -       for (i = 0; i < adev->usec_timeout; i++) {
> -               if (ring->trail_seq ==
> -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -                       break;
> -               udelay(1);
> -       }
> -
> -       if (i >= adev->usec_timeout) {
> -               r = -EINVAL;
> -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -       }
> -
> -       /* deassert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> -       return r;
> -}
> -
>  static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>  {
>         struct amdgpu_device *adev = ring->adev;
> @@ -7295,7 +7245,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>         .emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
>         .emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
>         .init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
> -       .preempt_ib = gfx_v11_0_ring_preempt_ib,
> +       .preempt_ib = amdgpu_gfx_ring_preempt_ib,
>         .emit_frame_cntl = gfx_v11_0_ring_emit_frame_cntl,
>         .emit_wreg = gfx_v11_0_ring_emit_wreg,
>         .emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 65c33823a..6cf244349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4611,56 +4611,6 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
>         return ret;
>  }
> 
> -static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
> -{
> -       int i, r = 0;
> -       struct amdgpu_device *adev = ring->adev;
> -       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> -       struct amdgpu_ring *kiq_ring = &kiq->ring;
> -       unsigned long flags;
> -
> -       if (adev->enable_mes)
> -               return -EINVAL;
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -               return -ENOMEM;
> -       }
> -
> -       /* assert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -       /* assert IB preemption, emit the trailing fence */
> -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> -                                  ring->trail_fence_gpu_addr,
> -                                  ++ring->trail_seq);
> -       amdgpu_ring_commit(kiq_ring);
> -
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -       /* poll the trailing fence */
> -       for (i = 0; i < adev->usec_timeout; i++) {
> -               if (ring->trail_seq ==
> -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -                       break;
> -               udelay(1);
> -       }
> -
> -       if (i >= adev->usec_timeout) {
> -               r = -EINVAL;
> -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -       }
> -
> -       /* deassert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> -       return r;
> -}
> -
>  static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
>                                      uint32_t reg_val_offs)
>  {
> @@ -5539,7 +5489,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
>         .pad_ib = amdgpu_ring_generic_pad_ib,
>         .emit_cntxcntl = gfx_v12_0_ring_emit_cntxcntl,
>         .init_cond_exec = gfx_v12_0_ring_emit_init_cond_exec,
> -       .preempt_ib = gfx_v12_0_ring_preempt_ib,
> +       .preempt_ib = amdgpu_gfx_ring_preempt_ib,
>         .emit_wreg = gfx_v12_0_ring_emit_wreg,
>         .emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
> --
> 2.43.0
> 

