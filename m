Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7865CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4338310E87D;
	Tue, 16 Jun 2026 07:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PMJGNUmT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2531D10E87D;
 Tue, 16 Jun 2026 07:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC6cH3RTUkE3Lnxmxl1Cs8lQmIgUZG8qhZsYLQyQvWXjSQTJfJEM8qSF2Zu78Dr2hXPhmRp9QI77SxRX27jgv6sa9GwGq5HqOpmGNIeSypaTtLc0rZF32eETkaQXChg3fclC1mUZsZTOvX4J/t2beHdBZNN9xdACme60LAlxYutlScr7q7UeVIZlqjChVLrRFIWx7nKRHQ1SNQvHJa6GJpoLyYB2X+pN2IcawlstOENU0/qmLPWeXWmD69d7XXNY7c5vdNBd6H6EDHBwH2TxiyltDX3iwqp3JHPEUqq+g9zxFa7cwEMRMVcwChae6ae1+1+dkS4V428bZuP8Egoojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B61FrdVikfBlz85AL+WNx8It+xPH7SG4CwRhLhY/bt4=;
 b=eaJY3xqnHri2RrF+jVkuNipewrncV2/OWTcJn0Sl2WoYVHXXaVKS+7/nXu7Tnl3rZXL3y7iXO0fgrqSHR2QYAWk5p/9yQfGa46UOuLQBkM2jtyDx9oubDRlH4150w4S6MtpKh/Nxh3SLxA3AIec9FB5Oy1G7N/NlI1TxOkKBxYiNahwbvvXPfx6Jn/i1176MFtvFYO6uKI/MLW9Rgj+hF36IbgUKCslfrI0DnhDikQK1ozHUgIkhXJfthoeaUES4rL3ING7AjVP1rVJGIt6YVZ+4Na56Ek8PPOwQ5z9duFy81hgbuJtCHc2S3EfevqvbzEmOXOUANrkJrQM3HCX8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B61FrdVikfBlz85AL+WNx8It+xPH7SG4CwRhLhY/bt4=;
 b=PMJGNUmTdiNg8QU2cgxRKuKBBC42Ubju/HMu9J1xPFBLACjrie7pWRd0JbXOUXRwjRHG9XF8Ckc9J6cGYgDDXv/ZSsfHYIHRsTY/PUBid8dyVrtWGCZexfYliKfdvNFrKguYjQLjoPunuRHzx95Tn4eqamnZ2WxvW6zqId8QxWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 07:31:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 07:31:12 +0000
Message-ID: <334d4642-a7ce-4d04-ab14-6b95653e6f86@amd.com>
Date: Tue, 16 Jun 2026 09:31:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amd/display: Pin native scanout to VRAM on
 large-carveout APUs
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, natalie.vock@gmx.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
References: <20260616071037.26718-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260616071037.26718-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b7fb17-23c5-4b6b-6b09-08decb793e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v7gd4lIfjvfnocj6Y62/kXoPQNk1gvNDujyPpK4f9goBCaOHTS+SnhzGRLem+coVGAjoMXm1uStHnu/0kVnXEbO1Nnx2c4540DWVF0+ScbZmvZMsGjvc/NGlsDhkUBAlxkwcKza8ZjZxKToiCG4QLdySO+pLnsQh5Kiw5FVd7y1tXqJH/2lXASrj6KgWwT3QxhuLIPKRJF7IyblDMuzE342lfY1zaL1Crx4MNupEd9Cbl3ym/P5YUtSsEQjX05dX8yEoVFolgyOKGAQH69QXtkmDo26eYfvdNCLh4kVo6KXFPc7jYehGWtHZCTDtLh/8ks40yG0zWFQHnMYbw7js6OqKU21dasx6sfpOEi1TAhVwHop9EEtl8Rojpvtdnhj8nI8OYfqLH0yJp7VYyy0P/k10hGc+/s70CqyWoWtfqZrAwmJV2cnwf7z3A5zKjrd4td3/VSL6DnRWkaotwitKAFGpwRDGbuGT+GMDnBT7h6G9bYKuMjBICFExFZbgDfP+lMV7KeFw9dmcxPUtPTYXnmGxUmhTn+8ltFVhwisB/7YhSCQ48622cjmXEwj79InNN0PAEzv3uXscgmaxYkIAgWdYS1oCHZktNg0erTKeg1AG+OWAyKclQlL0OjpX18CyUgfHb/qBkIybh9UQVps2Ibn2dVCofgb0mKD0q5smNJz2eik1bE6z3V7QJg31M9Q6stUOAPnnU8+CNpzyV0Fp8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFN2dDJZSXFFTmtNbDB1YzBSeVdMWHJUVjlsMHQyMzNrZk0xRllWZXZRNExO?=
 =?utf-8?B?dWhuRW1iZ1RhTkJkWHJLN2tiQWNqQ29Zdm1qMjVneDVzejB3VkdNRUI1TDhm?=
 =?utf-8?B?cVFuR0ZXdUwyTnlwZWFaQ1hsZG44M1F1QW9hbHoxMkpxNGRqN2dWSE5aUTlK?=
 =?utf-8?B?VE1YVE1iZTlnSVJLcTQweGFtU1RhU3hYNnRMc0FTQTM1MmJGY2Z4TUFqVUln?=
 =?utf-8?B?TnhaQnF5ZWl0SFBQR2ptRkUrKzJvczdSTm5WK253c0k5OHlMK0IwWndxWlRR?=
 =?utf-8?B?WDBiYUxBbDNkd0luRVAwdEJMdWc4YitHUFI2KzBqeUtYeWExaFRUUFM5OTBz?=
 =?utf-8?B?V1l6TVBHMWNpTU9RMXU1aVpvaEI5VWNDYkhNMC9iZmN5ZTVyUm1TQkZKemMx?=
 =?utf-8?B?bGVRY3NxTWF2TXBodTJyL3diMzFxRFNwbW50YlZRNjc0dmtYTGV5VW5ISnFN?=
 =?utf-8?B?bnhrOC9wWXZTcWllNkJuWFdBbnVqWXNxTW5NbHRLNG5jakg4WitlQTRwSzE4?=
 =?utf-8?B?N2xyczFGaXc3eSs0WDBlOVZJTDBSY3BDMC81K3BNeGJXVHgzeGNXN3U2bDVF?=
 =?utf-8?B?dUtCem1Yc0xoK1Q2TjVUSEZpVThKUWxGL1ZGWkRxMjNiYnlIRkgwcGxvdHpz?=
 =?utf-8?B?TlVoR2FaVnNhWmFqRnVrSTNtdHNZNnVtY2hJTEpkaHNYOW9Sdk5tTWVlOUM4?=
 =?utf-8?B?YkhQVnE1MzNXcVM5Tmw2Y0g2c3RsRFV5QWFBMDZZc1hwb2Z4bWVteGUweUVD?=
 =?utf-8?B?MmFuTW92N2JBbnduc2EwaitpdjZEWGM0VzN0MDh2M3lsK1BlUmZiOUF0d2R6?=
 =?utf-8?B?M21IeGFna0txOTd5UFFNN3hxS3lxaHE1MVRJOWtKWVRydjFEeDJheTc1NWFr?=
 =?utf-8?B?N1NVQTg0VytJQTRLOHZ2Njk3NjlOMHk2RWpkUTFrYm5aNkJGUUtxUFo2V1cw?=
 =?utf-8?B?YUg0RmZyV2lXb1I3a3ZiUzZ1bmMxaUF4Tnk1VDdwUENqQ1lEVXFIVkhhdVJM?=
 =?utf-8?B?Y2wzMlErbXkxNjlubjkxaTRHaVJUNTZyYzNDMGt6SW5qR1JBd3F2ci9xUmdm?=
 =?utf-8?B?N1Z6ZFluRlhxNG9pNCtjUzBPUjErQzZ1ZHZBS29CTS8yS2NnRkM4WUYwSDM3?=
 =?utf-8?B?WU5PTzVWUXdWU1RDWlRNRmpDTVhMclI3SGNETnIxemVJMVBod0k5R2ZxamdS?=
 =?utf-8?B?VGZ2TzNVYWFQVWVjd0JqTUJXblpEd2R0VjdoTENpTXZVdk0rSXQvd2xZVytE?=
 =?utf-8?B?ZDlKT3VlVmJsc0VJdThDdGVqdUllUG5CdjFpOEhDYVNkWHl6ZEJVZ3lqa0Zu?=
 =?utf-8?B?Vk5aZzRwM3NhaFZGdW56RFJnYWtsSGV3cXQwR2MvS2RmOVBackx4azBzODUx?=
 =?utf-8?B?d2RlS0tVekhTNjRWQS91aGhKaTUvQm1aQmd2OWw3eVRqTTB5Z2x4eG8yalUz?=
 =?utf-8?B?a1NGdUsvbmhlMGplNEVmOGE2MlJrbUxsclFxU3c1Z3hYdnpFSEllb3ZMZm5M?=
 =?utf-8?B?UlNtVzNXckMxbEJuZWFrWnRPZlJETndXbUU2MVlTVHpwWnU0cWowWGpPTzFU?=
 =?utf-8?B?eitUcWlKQ3EycURUQllPRkZDeDhlOVFsUG11RnlrN0JpWlFWeW9aOCsxd1lV?=
 =?utf-8?B?c2VWTEVJY1BDWEpwZVJ6d3BrOGNKU0JKSnNKa0JwcXZwUFhKUkdYQ2IvRVd4?=
 =?utf-8?B?RWhmSXljNmRUayszY3FFKyt3blVYUkJ1dm5JQmNaR3BNVnM1OTgvZ3hKUmhy?=
 =?utf-8?B?K0E0RU1aNjVXQjBMaTBncDJEdlNZcnJtK3MzVE1ITXBOa2dpdVp4a2VYWjE3?=
 =?utf-8?B?RURScmp3RFlVMUc4YkdmQTltczNOM3REcXg2VnlDbUpZd1BlR0VnSklLOTJ5?=
 =?utf-8?B?V05zYmpkQ3ZuS1FsK05ERWxqbGxTM01wTmh2bzV1ZEwrdVNKbjdBbFJlYjRZ?=
 =?utf-8?B?M01JUFdPVTZSU01uc0ZSY1lyODhTWUhwM2ZBTnNRMVNIY21vM2pSVU5Fb0VV?=
 =?utf-8?B?bnBlYS9PTUJIMVplOVFDZVRaaldkTVd2WW82NklsVXp4bUZQMU50RXpLR3o2?=
 =?utf-8?B?bW4rS2NuUWNGV3JsNHNjcDJzaVFtZG5rd0JlblNobHh2M1haT1B2ZjB3NDAr?=
 =?utf-8?B?aGxNVFhJbUFhN1ZkdXVVQ29CZnlTUkVwRXlPZlZLZEYvY1BmaEZuYWNWSWw4?=
 =?utf-8?B?aDdoRHFtVmxVZC83OE43OUM2L0JLYlVCNjJDUzR6QlFneXIxcW1TWDkzZEVI?=
 =?utf-8?B?UjBOTVVoVVB2dUhZdFZ4eEtIWTZRa0dRb0lTQ2x5aUNwWlhUK1prVnFvZm5o?=
 =?utf-8?Q?aEznJZAl4b03db1R7z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b7fb17-23c5-4b6b-6b09-08decb793e29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:31:12.9125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCfWas36qysnt8WCZqPJG6sckELEExl9euzgfF1fG/BdYrSs5MnnYOkxarRS+G06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
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

On 6/16/26 09:10, Matthew Schwartz wrote:
> Native scanout buffers on APUs are pinned with the VRAM|GTT domain, so
> under VRAM carveout pressure a swapchain can end up split across VRAM and
> GTT. The scanout buffer's memory type then changes from one flip to the
> next, and amdgpu_dm_crtc_mem_type_changed() rejects an async page flip
> across the change. The result is repeated async page flip failures,
> observed as choppy updates under carveout pressure, until the buffers
> reconverge to a single domain.

That's intentional behavior.

> Pin native scanout buffers in VRAM only so the swapchain stays in one
> memory domain. Restrict this to APUs whose carveout is larger than
> AMDGPU_SG_THRESHOLD, so small-carveout parts keep their existing VRAM|GTT
> placement, and fall back to GTT when the buffer does not fit in VRAM, so
> the flip still succeeds and the swapchain stays in one domain. Imported
> buffers may only be pinnable in GTT, so leave those on the default
> domains.

The display guys need to take a closer look at that, but it sounds like what we used to have before and that caused problems.

We somehow need to change the DC stuff to allow switching between VRAM and GTT frame buffers to fully fix this.

Regards,
Christian.

> 
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> Hi,
> 
> This came up while testing my kernel patch to fix mem_type detection for
> async flips here: https://lore.kernel.org/amd-gfx/20260611154438.571685-1-matthew.schwartz@linux.dev/
> 
> I found a new issue where splitting a swapchain between VRAM and GTT
> causes a noticeable stutter in gameplay if gamescope is using direct
> scanout and tearing is enabled while a game is already running.
> 
> Once a swapchain is split across the VRAM carveout and GTT, the scanout
> buffer's mem_type changes from one flip to the next, so
> amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Under direct
> scanout with tearing that rejection recurs every time the displayed buffer
> crosses domains, which is what surfaces as the choppiness. 
> 
> With this patch, I can enable tearing on top of an already-disabled frame
> limit mid-game and no longer reproduce the choppiness.
> 
> amdgpu_gem_info confirms the swapchain converges to a single domain
> instead of splitting across VRAM and GTT.
> 
> Before:
> 0x00000f81:      3981312 byte GTT exported as ino:275 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88248 signalled
> 0x00000f82:      3981312 byte GTT exported as ino:276 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC     write fence:drm_sched gfx_0.0.0 seq 88224 signalled
> 0x00000f83:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:277 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 88236 signalled
> 
> After:
> 0x00000f82:      3981312 byte VRAM VISIBLE pin count 1 exported as ino:548 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC        write fence:drm_sched gfx_0.0.0 seq 822258 signalled
> 0x00000f83:      3981312 byte VRAM VISIBLE exported as ino:549 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822255 signalled
> 0x00000f84:      3981312 byte VRAM VISIBLE exported as ino:550 NO_CPU_ACCESS CPU_GTT_USWC VRAM_CLEARED VRAM_CONTIGUOUS EXPLICIT_SYNC    write fence:drm_sched gfx_0.0.0 seq 822261 signalled
> 
> Does this seem like the correct approach to take for fixing the observed
> issue? I wanted to start with an RFC to make sure I didn't overlook
> anything obvious or miss any better methods of fixing this.
> 
> Thanks,
> Matt
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 23a9faa2ea89..b99f938e58ec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -932,6 +932,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>  	struct amdgpu_bo *rbo;
>  	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
>  	uint32_t domain;
> +	bool pin_vram_only;
>  	int r;
>  
>  	if (!new_state->fb) {
> @@ -958,13 +959,35 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>  	if (r)
>  		goto error_unlock;
>  
> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> -		domain = amdgpu_display_supported_domains(adev, rbo->flags);
> -	else
> +	/*
> +	 * Pin native scanout in VRAM on APUs so a swapchain stays in one
> +	 * memory domain. A VRAM/GTT split changes its mem_type between flips
> +	 * and amdgpu_dm_crtc_mem_type_changed() rejects the async flip. Skip
> +	 * small carveouts that may not fit, and imported buffers.
> +	 */
> +	pin_vram_only = plane->type != DRM_PLANE_TYPE_CURSOR &&
> +			(adev->flags & AMD_IS_APU) &&
> +			!rbo->tbo.base.import_attach &&
> +			adev->gmc.real_vram_size > AMDGPU_SG_THRESHOLD;
> +
> +	if (plane->type == DRM_PLANE_TYPE_CURSOR || pin_vram_only)
>  		domain = AMDGPU_GEM_DOMAIN_VRAM;
> +	else
> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>  
>  	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>  	r = amdgpu_bo_pin(rbo, domain);
> +	if (r == -ENOMEM && pin_vram_only) {
> +		/*
> +		 * VRAM could not fit the buffer. Fall back to GTT where
> +		 * allowed so the swapchain stays in one domain.
> +		 */
> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
> +		if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> +			domain = AMDGPU_GEM_DOMAIN_GTT;
> +			r = amdgpu_bo_pin(rbo, domain);
> +		}
> +	}
>  	if (unlikely(r != 0)) {
>  		if (r != -ERESTARTSYS)
>  			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);

