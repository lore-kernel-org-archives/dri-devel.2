Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14870FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE2F10E9A0;
	Tue,  5 May 2026 07:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZ1NF+hf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8437110E99F;
 Tue,  5 May 2026 07:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTmX+CPJN0YngDrHYIQFAcDNWxz1McFJ5uAyrWjb7N3WUONNBdb4n2pruR/qgxYSK60xpiYxn56CS04OtJA3vQsbGlOjcgiPPpXIsHxr0fidRHLnlitY9ledlPJ/k10JGMXY8kwLPY1kv5pHbBawL0eftllKvs0Axt/zJq7cNvRYgo9jJt4ZT3nCSArobYkC3Xv8AWSdjToeJEnZ/4M6jacLGOG250bVJKxinMzv+inYzwHT0S8A0BrC0LCtgRkgk2ee2D4MRh4pERIOjPW5+vnSBWH7w9itzd4g6KTfwYv0GqMRROHoIbd1qs1tr/MBm8n9DAspB45+Q2TJx0woRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuAmBIYqaRtYnso/XwApHvKhytbXmjgoAfNVO7hIfH0=;
 b=mBopQ2zSWCCT1qswFlr9ychE524L+pkuhlQWITJeI5WkTpTfYwE3w4SLcCzL2QHIYovizNsO+oWmMPnhlFNquRU2trAnSUN05aOymqbP4mCtyFOY8W/GeyOHlWLCIER+tjiLH+A8Wmm9Jt9gDA71pHTnKY9Ur5WcrrLSRV/GeVy7zCV88Pkt6uy0V4M3gx00L5EGyShZnIzk4nXfsjQQAPw4yGiMyfWlhJap996Ezjwo07O0Qt7872Xx+s9a+pRrSKQPQ20/wQgTk+6v7qMYNSPLZ/lS2+RJx1qKN6qDAeOa9pdBiI4i9YBXSvULKDaBDsu3Fn0LZ6NXIueXJ4MNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuAmBIYqaRtYnso/XwApHvKhytbXmjgoAfNVO7hIfH0=;
 b=TZ1NF+hfpck1e4YJidGJsl76enO2tvBwwMhyDosPQmQjA863lYKQ4yFHtjSm4TyY8luOQCkwg/WSkoRp5oVKnLNJ7rOMHG3OkpvKztdQXrkVUZJrmMn1lkeZ/w9RUpJt0soslljC6IQl655/Zg68T0S9kCTS9WFe+JGapech19c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 07:16:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:16:13 +0000
Message-ID: <f57eb557-4725-42ac-a157-742304e2344b@amd.com>
Date: Tue, 5 May 2026 09:16:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: Felipe Sousa <felipesousa@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260505021417.32520-1-ulissespaixao@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260505021417.32520-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 701c571f-04b4-4d6d-65ba-08deaa76304b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: a9Ht4IWpRvtV/N3FOft3yIpRJDqAS6S+mENAbmcjPRgn+IzEwVLFBusmW2I3oJTIX+9K0bEk4AXTQMHtoiaertOGGpfYmZqRxVdNTqpskLsO0ggI1EnzESmIOpO03Rc07+YcS5FKwfvJbI794rlkhhxBhIpWLp0t+aDGlxhoCN1fvrK2X24Fy7jevCB9TeoIm+XiEI7w/9jedGV9UoGcW+6HLmnIHLCVhc0VrXtxz+IkdRhw1AlrMNhxaJSjbog6YjDeOho3kdlgxRtdi6s9RnaOUc9KE34U4bR+DkBBKKHCavUaOjMoKNW2R+1LrZYLapG1ASKF4t65fZVzqFi51DuEdiTQGkMgyfPN7yCa0mYRhaxoQAO+KD6XemtPr/RVzomd/6aDC2gVPukUlEEMhV2hPdygFgwDPmxoNAGiZLOgMsB/GgrvulrmgQNszSphb50rfkKhC9dP+irIbUPA7dCOJUCwun81jRlZPKcu8Xks266PA4IEduvHfyTJBHF4u+4x1Ne6Dsu/7WfAHFMuBV5P2zR0kYAUA8BIxGnxhdKEMCDypumtLfE+osc1UNk5qKEoIuypqPydksoj9rFd+DjfpaFCzxsCLRvbYHZvdfMNUOIlTkN9mjXymRHy7ba5fy5wcxA+e7n4T9DMoZUwJSGVlvoUZ+qYyNrH9jaPJSqMJMKh5CIVuVGKUcLSdYbC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0dyLzVHUnE0Mmoza3owZGpxOGJIY2c1bkNiZnpFbTJBVVhxeUVLYmVtdmlo?=
 =?utf-8?B?cTEwZkxyYkNrNSt5MWgzVWVpc0tQSllhcy9UVjdkbDUwM2hjTWZuQkZlQ002?=
 =?utf-8?B?MjBLb0llK05UN3dEVzdjL1ozWTd0cjVobWp0Q3R1WWsrcERGRzMzNFRDUVhw?=
 =?utf-8?B?UmIzRURKQlZCTERZcXB2NXpCaVc3UnZGZUlobHNTRUMxR2NvZ05WcWVhWUNX?=
 =?utf-8?B?OHlrQXhDRWV4eDRrSEQrS1V5eitWUUxJa0VQblBJbm1hbksvQ1ExRjd2cFdw?=
 =?utf-8?B?anpRYjV3TUNlZmQxeVRMUDB1TlJwTU5BaEJsTEZlSk1ZNno3SXBPUis1eS9o?=
 =?utf-8?B?RWN3dDV6ZTh4Q3BIS2J6V2dGRUZvWFk0eExDZmp4NmgxdVN0YkdZYmIvdTJz?=
 =?utf-8?B?cUo2QUZFNUYzeEY2UmZYbUZkOTNkVkpBRHViMVc0NmZzWkk4bHFGL29YY25I?=
 =?utf-8?B?Q2NXUXNuNStnNXBRZ09VOXdGbVR4Q2FuV0FLaGpFUjFybytrNWJxajZJUGxC?=
 =?utf-8?B?dm9iNUNCQ2pOaHdWWE5qN1NJN3lmRi9Sb3c1ZHRabjBldDlUNUJHdExHSGZ1?=
 =?utf-8?B?YkFWSkpRemI2UEtqNE9TLzZ4WmFvcGcvQUtaUXlSUHFRcTFTV0pXcXRYRlUx?=
 =?utf-8?B?RlJvN2swaTJxVnlDSXBaNWVuZkZQbHRLaGxHeTRrRnJqWG00aEE5WVF5aUV6?=
 =?utf-8?B?TitvbjBVbU5jY3ZzNm51eXJLczVjTTFUK2FrY3Z1aTBuT0VrRTJWNm9VUHhK?=
 =?utf-8?B?SUMxVStsbkZGYVVqTUVhWFVqMk1aNVJhbGpidXBkNllzN3NabTQzWmJ2UEFE?=
 =?utf-8?B?TlBTSE9lOGczRWJGWkpaZC96Rm1qa1ZnODB1MUVtcHhLak9aLzBWWFFNT200?=
 =?utf-8?B?cTFsWnRBOElGZytuQ0Vxc21kU2hGRjZ5OXZ5Zy9XZllqaG9LTGZ6Sy94L0xy?=
 =?utf-8?B?djhMY1JxMzA4WmlWY2tYTjlobGl6T01ERVpmdGZSMTVWQzlQR2lSN0FPYmdQ?=
 =?utf-8?B?cnRuSHk5alFFL05ZZzFCZDBwaEhvazdkVE9BSi9PZXBQOER4RFpQTm04bytt?=
 =?utf-8?B?dmhjTkpWQzNKYy9GWkIzSGlzdTNhZGI1c08yYnk1RFhPMjMxK3poMVdaVUlG?=
 =?utf-8?B?eC94NnhBcnNLM3FUTGRPeG1iRjJubUJQSlJsZzljdjNTdjAvd1ZoalRab2xo?=
 =?utf-8?B?Q2Fva0ltakowdFYxSXh6bkRFTlRra2phZC9ZQ3E1bGpLQi9yK1R5aUthdGdn?=
 =?utf-8?B?V1NsTUJ5cnYvZ3d2YzZ3bDVYUUJxMk1rditSb1ZRMlpiV3dEczFyMml6MGRq?=
 =?utf-8?B?T0VOcVVmRkJIaHphd1Fha3o1aW5kdjh0TUlFdi83TU5TSzEzUjJteTd2c1VS?=
 =?utf-8?B?di9EdVpoY2d1VWQrQklOaU91MWZSTHdtZkx3TUtKcUtQK1c0STNWR0U2K2dZ?=
 =?utf-8?B?bVpOckRnaG5DMGRhT000bFNybCtBNUdPMXQ2RDVNVUd4TXpNdDI2WnNmcUQw?=
 =?utf-8?B?dVJkZmtGS1FIbmNXOFV0aG1xSXNaQ2dBMWlUeGZpd2dNSGlLNkdHZXl3OWV4?=
 =?utf-8?B?MFRXM1BManJvMFR3MmxiQWI1VWNDTG5GSTFpUnZoTXVUY3B6c1dsT2lXZFhJ?=
 =?utf-8?B?RzJJSkhCNFBqUTRHQXRoZ2RndFJFUkxjZlZNaFJwK0RlS01KN1NjL3VlbStI?=
 =?utf-8?B?d1owV1dUM2J4Q2lCaEZjTk9yT3NqOFpzWlZFZHlrUDZSZElGNkpLMThEVkFw?=
 =?utf-8?B?T1VQLyszWE41cGlsTzZlVjUvSEJCWXI5OEs4dU0yVFdMdWRFdHpMQ1JDUkkw?=
 =?utf-8?B?bU8wd1JvTjZGd2QxQ3VlL0NSS0FXNWpPaTlja1FNQjhSU3pEZkNJWmRqWTNk?=
 =?utf-8?B?cDJXdnNBUlAxUEphUkN6YjYxbDg5bXppa2l6cmlOTjhjRFErZWpqRENMb0J1?=
 =?utf-8?B?Uk5NTVBTVXBzMDJpUU1hTTRKcW1SVndiUnV5TjVuZzhrWTdTQmVPSFcrTkUy?=
 =?utf-8?B?ZWF0Ujl6a0g2Tks0R1JCSm00MTd1c2hJd2F4U3cyc1lvY0Jza2hySlNpVHc2?=
 =?utf-8?B?QTlIZGw3TGJiTXRlbHQ5Zm5Wa2d5OFljZExCTXNZakZYZUpIaS9jZWZLMnZt?=
 =?utf-8?B?Y3ZhVlFmZHJlRkdiUzMrSG5MQUcrekE5cHVFcnQrcmdKTStVVUs2MGk2RnMz?=
 =?utf-8?B?MVlxaVVLTlZwWm90aXlZTFZtRmVvR1pGVXU0bmc0aDcwVTlzK3BGL1diK04r?=
 =?utf-8?B?cjYweTZKZUhsNVlTTDh4b2FZVDR1U2R0bFJSemUvbkVPY2xxRTJFY0RCSHFC?=
 =?utf-8?Q?QgVMicgvQ0J6bE8jWU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701c571f-04b4-4d6d-65ba-08deaa76304b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:16:13.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5PLn54T9s5n90hsHOkZVLy55jRaYSuiGpEcnd+2RZmNbqYI1N7/R5Uudvmj4nXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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

On 5/5/26 04:14, Ulisses Paixao wrote:
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

Reviewed-by: Christian König <christian.koenig@amd.com>

> 
> ---
> 
> v2:
> Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
> Remove the redundant check for adev->gfx.disable_kq.
> Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
> all gfx and compute rings without a switch statement.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 32 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +--------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +--------------------
>  4 files changed, 36 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8ca87669..67a291781 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -830,6 +830,38 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
>         return r;
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
> + * the faulty ring (gfx or compute) and triggering a scheduler fault.
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id)
> +{
> +       struct amdgpu_ring *ring;
> +       int i;
> +
> +       for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +               ring = &adev->gfx.gfx_ring[i];
> +               if (ring->me == me_id && ring->pipe == pipe_id &&
> +                   ring->queue == queue_id)
> +                       drm_sched_fault(&ring->sched);
> +       }
> +
> +       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +               ring = &adev->gfx.compute_ring[i];
> +               if (ring->me == me_id && ring->pipe == pipe_id &&
> +                   ring->queue == queue_id)
> +                       drm_sched_fault(&ring->sched);
> +       }
> +}
> +
>  static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
>                                    bool no_delay)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..0b2f6ce85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
>                                                 struct amdgpu_ring *ring);
>  bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
>                                     int pipe, int queue);
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +                                       u8 me_id, u8 pipe_id, u8 queue_id);
>  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>  void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
>  int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 2c6f1e25c..888c9f3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6688,37 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
>         u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> 
>         me_id = (entry->ring_id & 0x0c) >> 2;
>         pipe_id = (entry->ring_id & 0x03) >> 0;
>         queue_id = (entry->ring_id & 0x70) >> 4;
> 
> -       if (!adev->gfx.disable_kq) {
> -               switch (me_id) {
> -               case 0:
> -                       for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring = &adev->gfx.gfx_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -                               ring = &adev->gfx.compute_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>  }
> 
>  static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 6baac533a..3f0d29372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5019,37 +5019,12 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
>         u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> 
>         me_id = (entry->ring_id & 0x0c) >> 2;
>         pipe_id = (entry->ring_id & 0x03) >> 0;
>         queue_id = (entry->ring_id & 0x70) >> 4;
> 
> -       if (!adev->gfx.disable_kq) {
> -               switch (me_id) {
> -               case 0:
> -                       for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -                               ring = &adev->gfx.gfx_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               case 1:
> -               case 2:
> -                       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -                               ring = &adev->gfx.compute_ring[i];
> -                               if (ring->me == me_id && ring->pipe == pipe_id &&
> -                                   ring->queue == queue_id)
> -                                       drm_sched_fault(&ring->sched);
> -                       }
> -                       break;
> -               default:
> -                       BUG();
> -                       break;
> -               }
> -       }
> +       amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
>  }
> 
>  static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
> --
> 2.34.1
> 

