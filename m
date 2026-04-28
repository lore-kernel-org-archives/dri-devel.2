Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF6FFF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8082A10E660;
	Tue, 28 Apr 2026 06:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iSe4HN7S";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA82010E2FB;
 Tue, 28 Apr 2026 06:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLhDlsmkrSo6IlLcTUSvBywTgwXdrHvzR9PHhoBWT5Lsq7r8YpxatdzU5EXZZ6hg8Ckj+SVQx/1a+EZi5eu5LZ/PCmXfbszrzqN/mYpbzuWJ6Jx6alW/6+Ms+BBJu5m1WiFnmYWSvB3ufQmXztTx7dovybb15xNvOZfHm+4cbUkg86/8S/npGgpC+uBfDwHARTaKBx7NQ+xnmU8xvDNyd/3FFqnpBI39jL1uQgSV2aAbqSiaV0z4XYiAUKcqA+o7oW1j7inJpyWkRT6UpKBhA4Fs8OMbzcMmiX4ub/PIg6U6Ie0zTlwsr+qBozwj2wPxOtZbWlaiDhJx4GEAYhp89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEpTfCZQplF9UhKXjvS5ll4Ca8fP93twvrXVz0tFdAs=;
 b=UOc/XopOD5jBZ8iPYetIRYRL0I/PFqdjEvzlXC8xDr/olQNs1gqgb8K9rSFKQ0/8kkrNfPNf1guoTROFWfZRDNUGyKH6Ayy9klqpoTopw3U2x1Av34yw/XyNT3u5RzU1Anz+M84ukHgVgpkzQJ1FNhIY1w+sNti6V0Fu5/MHweYz1lTOzGOnA8Olzxmoa/UGQJc7N84VHh7ApYJwuIxGGQ7MrWEB0sE2T/Wxd0RFS3U1ve/lN6/YN+eQclW3/k8S+dpaUjgNRS7eLeVfzFQYepU7Rf9+U3HwlCRp/Hfwdw7vIVPLlvSXEsHPHlYJb8H5lmoj7TASJAGblzozn2tz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEpTfCZQplF9UhKXjvS5ll4Ca8fP93twvrXVz0tFdAs=;
 b=iSe4HN7SQGq66Xf5wnKkueFECq9tl/NHsPOwh2CrFaV2mgx91kVyNTtVgTYtGGmIdnax6rJ0WNWQUbPuTjwHaZpiWuGINMnSYGBnXHtfyTOXWe948cpxDPN4H18Wgs1m4L9sHx0mrla4RSiq8RY4SikLtJGm61HowkH8p3bWHK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 06:40:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 06:40:20 +0000
Message-ID: <59f9d505-c839-4193-ab1a-30af8ddd6ee9@amd.com>
Date: Tue, 28 Apr 2026 08:40:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: deduplicate ring preempt ib function
To: Leonardo Cesar <leonardocesar@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260427191556.9672-1-leonardocesar@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260427191556.9672-1-leonardocesar@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4dd8e0-81b7-49b5-2005-08dea4f10452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: cw3GcKeDOgWX8onQke9T6E7zBSAIy2a2IYsC0HfJunMAeq0QuYuTMQXPvMlu07jA1XG8td4xUPSBx125dWNeMNrV2UcAnCo2jKMLEwa3D2Ec77elh2pB1ApV+YAUZoa/9eNxk6CF4rLdRrx3l2bZNFBNXPyF6URwG2bDHl9lQ34XceWi0bMGK1pVYJAeDooIoF/IGSS82Ar0uR92CTjvfmzG3obRuPezQH1msuOWNkhenZ1a6vzeyu6SdHA7cjAVenYxqhynjQsYnkMPGRdGUR+fJhNoo0PmYjUFimirT2avUEaEHXiNna6XSCUKPQHrVwX3OmuBKVt+4dEA9eRRlWRfRBn+rUC4UmLLGg+eDKbXLTqE9V8aAzA5LqbaZi71lZIh1sw5D4EDCDfXiMkD95K2XCqbeBs4wph1AcnN4SIas610kXVURNvExnwpoS5qj3Gvd6FnZpfhDkeog3+Te3m/y293xHpNTsTFjhhBEchn3GRmITs6t3xgOmPXqJNero82xeWP9b4pUkgDvw4Va5ZNwAjdyppNSmRuIuqp0+ySOrHndcfpce4IOpQqwb8Ij7+A2G6iJrqKxOL7EsTm9LsNAcGbvIne0m/UtiJztHBr+OBawxuSf1ZZqoD/Ylmkiv6NOzmseUSi9lSWG0y30JXMleSHO+gAGcJUcltSxUix0GaVH1k3TSIcasFACn0t847Ws5iCzijnYCC0obca+SU79hBjZQOgpDYQNqlMcd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1M4TGU5R2QwWGsvYW93TW9BUEE1d0FhazRocGRKRGNtWWtJOGgrdjZleUhJ?=
 =?utf-8?B?cFZoNE5YUFVFbE92cCsyQXNBRGJ1WS9kTktSWW9LcjllY0FjSTRsUm1hTzFI?=
 =?utf-8?B?SDdxdkwrSTF5YmcvYlllMTZYMTh5ZWFZR2dXQVYxRXh2Rnk4K1cxcWpFUnVR?=
 =?utf-8?B?UUdWdUJlaWVUSmh4ak02K2ZDVEc3S3lOdUtyZnpLMnpvT2tmUGV5dzBIdXlZ?=
 =?utf-8?B?dDF0VXZidW5sVzhRWkVJOVpjblVHUnNpWWZNOXVPS3pQQjV4YTdaaTVRbWFy?=
 =?utf-8?B?Z09lOXhNZlNBWVhLVGx1ZUJOcEZna0YyNytXVHdWcHdNUTBSRjdTTVN4bDRG?=
 =?utf-8?B?S2tEYk9uamJYaGhZVHB3bHRDcHQ2YXovMEFxbWRiK3J3bjhDNWpWcStxdmlX?=
 =?utf-8?B?V05WL0licGMxSVZCeFFCanhzYjNmYTFTYXhMZzh4a0RXeTRaSThiQXRHNDNK?=
 =?utf-8?B?a1JHSVFnWGJUdWw1cWJEblUvOGJRd2ZxZTRxSklsM1c5VWN4Nm9pSmJuWG1v?=
 =?utf-8?B?NTBEcUhGdmpzWHIwaVJvSGZTTWZpdituQml1VWpJY0Z6ZzlKdVdpMHo2dGNT?=
 =?utf-8?B?cG9hR3cvbEh3VVdiRWR4MnMzTWxzYmF6aHhPdlV2R3pabE1GUWtVVUxRQkVt?=
 =?utf-8?B?MTVXSjBEZmNyMXZaVUo2VVNqTmRDQ1E5dDh1ajlKR0R2Q2ZqTjE5QnF2Y05Y?=
 =?utf-8?B?ZzFvZVZzQTRsN3dQQnBySkswYURJVXpzTUpHbm9meVo2aGU0YTJBL2ZLUjQ1?=
 =?utf-8?B?d1J1MDU5ZVZ4cUZlOUdaSnFrOEhjbzUzYXpka1kxN2hadk1uQjBmbU9hQVNi?=
 =?utf-8?B?Z3VPS3BlV0ZwTlU0UTZBMzlSQldCOElHSnpsc0djQ2EvN05ESm9Wbk51emN6?=
 =?utf-8?B?OVB4QUh4NmwxbG5BV1BSNG1aN3V3bUdRUkhWMUtlUkVTRjYyWDN3NzZhay9B?=
 =?utf-8?B?ZkgvajFNZ0NncW9CS1hWVWF1K1BBM2tvVmFpNU9TK21YZVhQS3Yyd1QvNURu?=
 =?utf-8?B?eTNtSjRkYlBoQ0dJY1g3Q0xzTU9CMWlXUzlqd2hwWEVFa0VrTlpaUWdGbkxz?=
 =?utf-8?B?dVNrbFVqRWxOdkZERktJbFVDQnFIcGRRblZkUGNwb256YzFkZXh1dDBkUGs0?=
 =?utf-8?B?MjFFNmszMFVMRnJwRFNyUTNBVTMyQ2V0SGFSbDhpbDJvRXhoSXpNMHh4Zk12?=
 =?utf-8?B?MStDandSV0ljVUc3Vmtyd0tlMU43TnppSzY5aUVSa1h4YWpQM09McVlkQmZJ?=
 =?utf-8?B?cHRDbkdKOXFPbkd3SnBSbnkxeEkrZEJUMGxMM0YvamxFOFM2L0VjcTE4WHc4?=
 =?utf-8?B?cXE5YmdqdTlHTGw2Vk5QSTFTYkZnblB0d1F5akpoMGJoY0xwa0h1TVNZakJN?=
 =?utf-8?B?SGZTejFxRmltaHdrWVlZajdWa2VWdksvVlhUL1gzWlZUWXVRTXAreitPSC9n?=
 =?utf-8?B?MGhQWEhxS3JVU0h1SWR4a2d6RXlvSi9aejY0bEw3MGRtUHRGY0NvaDVyQ1hi?=
 =?utf-8?B?cUVZcG1IZVZRNExDeElVcUcxVEFidjBHK3FsOGp4MTlHWUJ4Um5zVFU2emk2?=
 =?utf-8?B?WUdYMjlIaEhGUXdWd1RmUTk2Y3dONFNRcmNURnkrQi9yUGl4Z3JkTkZuWVMw?=
 =?utf-8?B?TlJjZFpZMzJGa3dHOTJWcDd6Yjg3alJBT2MvZFQxOE51ZE50VVBDc09YbDh3?=
 =?utf-8?B?aGp4dmZIanRsN1hPN01qclpzaU1mWGE3NWsrT1hrWGRIdmREYWtBRVByenZ6?=
 =?utf-8?B?VktWK0ZPU2FGMVc5QlI2WXVyMjc0ZDdCOFFsL2RyZnQ0aktnOFZlbUNSZFQx?=
 =?utf-8?B?UnMrRlJWT3RWQTdsVEtzM1Y2YnRqNGNVWWM5eU5QclVCU1RaUzB5QjFHd0JT?=
 =?utf-8?B?aUllQkJqSVQyaFNYaUZJZU9vcExnclUrN0E2aW5pbHkxYnhRNVZsTTUxRkdq?=
 =?utf-8?B?V051b0wycVVJQjdTRExqL0p1Y2Q3MWpaZ3VQL0dhR1ROUUpjTHhGUUFCZytR?=
 =?utf-8?B?ZnVDeTBKTEZLTDFSbXdxR2k0RkRqZTN0T2RGd0FudkRTZkhGb25sS2Y4elRG?=
 =?utf-8?B?Q1diU3RzSjU5SlQ2NHZYQ2M1cE9TNjFiUmpRVlRVME5YbE5nTWtwbmJnTjFa?=
 =?utf-8?B?RmZkY1B2VU54a0VXakhiTUtlSm9SUzRVZHdOWEo2cSs5ZUQ3NTIydEY0dVNo?=
 =?utf-8?B?cVFwL2ZoaFBBeGFSbUNNTVc4WVFUUU1xd0JnV2lpOEpFbzNsQVlPQitsNlA2?=
 =?utf-8?B?cUlxclVGTEZnUmNHbnRIRGhHaW5saDlSMVorM3k2RERZajZ6M1F1QWNRenMv?=
 =?utf-8?Q?4E4JYq9UpcJkHhZklc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4dd8e0-81b7-49b5-2005-08dea4f10452
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:40:20.3084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZOC9wOuVQ3Zya47VE0MA/ZLeCzFtOM85uJ88cvY0FPNTbZutCrHK6TpcGe75nNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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

On 4/27/26 21:15, Leonardo Cesar wrote:
> [Sie erhalten nicht häufig E-Mails von leonardocesar@usp.br. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> The ring preemption function is identical for both gfx_v11_0 and
> gfx_v12_0. This patch refactors the code by moving the core logic
> into a generic function inside amdgpu_gfx.c to reduce code
> duplication and simplify future maintenance.
> 
> Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>
> 
> ---
> v2 -> v3:
> - Style fix: Move variable declarations to follow reverse christmas tree and do not initialize 'r' on definition.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 53 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +-----------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +-----------------------
>  4 files changed, 57 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2956e45c9..45d41f24d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2684,3 +2684,56 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>  #endif
>  }
> 
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +       struct amdgpu_ring *kiq_ring = &kiq->ring;
> +       unsigned long flags;
> +       int i, r;
> +
> +       r = 0;

Well that disables the automated checker warning but isn't any better than initializing it on decleration.

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

Please completely drop r by just reordering the code here.

E.g. move amdgpu_ring_set_preempt_cond_exec a bit up and then have:

if (i >= adev->usec_timeout) {
	DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
	return -EINVAL;
}

return 0;

Apart from that looks good to me.

Regards,
Christian.


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

