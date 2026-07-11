Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37311C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 10:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0742B10E32F;
	Sat, 11 Jul 2026 10:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7nA+XVS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E5910E25B;
 Sat, 11 Jul 2026 10:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCvqlXqiL1tsvhohgB5rAGvEPexSwxN3QPU7B9LIANnogz9du0UWmdKq+fzNKeTYpdu5FC8dQuRAue2NxnMZDahY3RZleMVdC3hM3Aogt9xrfKrW02gJ1cMpaNfMO+qEAiLrmIEOlGUq47R+Hni/wnMd0IWEAFlb2vLrjwj6f7UdktgwmX2fNjvTJOyJZY/VDzgzZ+uwNw+VuRUW6u2hzhLFdEBKb/08JyNUeZeNVavhQXUqId/DQav0rA96AxWp9e6tw2foREa89kR71aiZlLjJ3fKf6CziD1AL9Ls5fNpjXecmLrsw9CcIpqnQZUsuZienvgHDabz77vRrplx60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai6vy7TkoMZyuPtcxflq53yptLS9EotaB74S1nchYQI=;
 b=E336lEAVEdFN7SAJmTQiXUgJWEmqzMgWHcEpUA2PhpPtxOvByWHvXcTqQ+9MiRA6twHtrciEzpsYIBHMWTNOEfNfCRLVygtKblxuoFL4H1FBPO2cev7ifaPgBcrrcRqxct9BEBtcvefKy+AIhaBGNs3qgr2dZ4R6f8UubpKpP0w9rq9RfNSJb5rfzsgrwNMTFb7lYwlv9JjJRXItoX6efUDqGXhL+m2SW4HK5NE86SqUZTNjDLdeshTojstlQ5rRO9ehLTlLOb9nU/2jEPnVGsP5V10t99vWWZJUgVKM73x60yVAhbfvrJexYnwIDtYtuX7K7Vj+ubkBPIbx70jdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai6vy7TkoMZyuPtcxflq53yptLS9EotaB74S1nchYQI=;
 b=m7nA+XVSN2i7muyk5INtz7C5KmdVBMzyS3f92K3bt5wS6nBjLohQjVDOI/QM8IP8YLM42g0RPyPqZ4sUNckWb5uSd4WxQ1e/8Kq2WXX/m5OjQqN4nlHzv/zk4GqF1J429ksgkkbAZkGDyRU1AZ9SO9ACsS44aghI+xtUfX3VC6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999307.namprd12.prod.outlook.com (2603:10b6:8:41a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sat, 11 Jul
 2026 10:33:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Sat, 11 Jul 2026
 10:33:25 +0000
Message-ID: <971f7948-b241-46cc-980f-61df43af22bd@amd.com>
Date: Sat, 11 Jul 2026 12:33:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/33] drm/ttm, drm/xe: Minimize dma-resv hold times
 and defragment sub-optimally backed BOs
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999307:EE_
X-MS-Office365-Filtering-Correlation-Id: 3002876a-04c6-4c86-74ba-08dedf37d6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XrN1TKwpLqNlLWWYZjTdu4bcaKg0eqBsiz/DrOcApqOI2GuRxdVYolSCdvqQF7qta3Bl1Jo6hm45f6vD8+OJpwn0R+OVEeppd2mg89caWJlF1UEFz+AW8eLuN7ops570K1NP9UA69UJb1MvXxDPUpg6QK+ONZmz/VjZZ5v+Dl7dzTGZnXup3eA2zZ3xljvYs3qEWONgXmTX2ghlVGazWiySlNcZ6/5yHEdm+l7YOHMuAWS2+j/VjZi2AFIYPsEswwVwhQ0DGeOyg/Nlsfjow5otrWcijgZ7gxvogM9sGfphAX91KvcAqnbGgT/xvZZuyfyBOUJvakiDCMnrWa0LuC+JftBHQ9Bh7ACLdu5anyL04YSzV4rSmVcgwaj50Mbwnk0vgs0n2CBoDLweXm5A7gtLOP/3ADol1OuatXvOqHbqTsvKfodRmaNsLlW3J27ekPRS/Wu3YiREXa2oEcUvyOTbeF+2YlLAsbBp79//6k+lpIX1sQ0hvnfkRC43HC9EapA5NUAyHJprOaEtuuvDugIZl0f8T3V5Dw1P1uzPf4bolBTF0P4wRyGceBvVy3sudD7Z6QsfgouZH0m5ClbmXH/zabuQuEVuJ3t/nHtmGV8dKF1RL5GqGYomYM5xNlTEd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5QVXRtOVVRQ3pmWXgzUmdsRmlvUDRGRjVoUWRSaXlBaTQxMnFtek5LaTRY?=
 =?utf-8?B?WXo3eURvVEZlWEhTeXBHKzVIVi8zQXdKY0E2clJuSnEra09UM3ppdmVTc2Rh?=
 =?utf-8?B?U1AyajFXZ2paZWI1K1hyeU5WSVNwMCtSRWtWQkgzVURkM28xck1HZnhPSGpY?=
 =?utf-8?B?TmFGOWh5VTFPR1FwSVAzbEZvaFNhYTFPWE1sVzA0NXlGdGl2RlE5a0RHSGxY?=
 =?utf-8?B?K2cwNkhqUUlSL1VGNi9Ia25pS0QxZzFjM2RIbFJJSngrREI3Zk1JQWlVTHZv?=
 =?utf-8?B?RldiNEE0VzFPbTQxM1BWNHVxbmRlcWRPckxFc0xxTDlha1ZPR2x6YzZsdUR5?=
 =?utf-8?B?SDJVd3FKdTIzU0hEeHZjbUlMQkk5VUYydjdHeTI1YnlWc3ZBQ2NoWitmb1VH?=
 =?utf-8?B?QU84Z3dNc051Qys5eEpBemU5ZVcxTnZuUHUyQ1RMMTFTYkM0NnlBbzhGakxB?=
 =?utf-8?B?a1J6RlFWWlFzMENxZ2wxU1dBZDVoZHNwZ0dJR3dsQU9FbHVML0tqR1hPYVNv?=
 =?utf-8?B?bERQaFNFYUczVDlsWWlGaTA2VTlPR2ZqRzNWYnMzczgrZmlBOU9GUkhOSUo1?=
 =?utf-8?B?R3NnMFl0Z1Framh0eGRIdjNQbzgrTTR4ZDQxUTRXZHZoQklDbDVwL0gybDhm?=
 =?utf-8?B?cmloaGU5U1RrN2Q5bk1uZENCWWNCanlrbzdoY1B4MjM0TTRycXVwd092SXVU?=
 =?utf-8?B?NnE5RHUrZmUreTZXRGRsVkFkQUpEUEEyRnNGZm45Yk5DZjcwWUNnaWZ2WWlt?=
 =?utf-8?B?TzRySmlkYUg0MnhwNWJTTnVqZ0FZZmxka3JrS25OeDZuUVRHWnc2NUpOUGtt?=
 =?utf-8?B?Nks5TFp3emlKcXUwQkluNGo2NDhYZkx4NEVMUWROcEVCUXlFdGpTcG1Nc1lF?=
 =?utf-8?B?dDhTdFNTTjFiazErRGcydU5hYmlXdnVGWUFocVVpZ0tLbEtpd25URHpmcGVQ?=
 =?utf-8?B?ZnhGT3RIWlovQ05GdjFkTHhWTjJHTzBwV1RCZG1waHFIMFRZeVZZa1dmeFRN?=
 =?utf-8?B?Ti9PRFZqdVFSYjl6MlZKckJBcGx0a3MxOXZvWWJGMmpDM2pEelZ4V1pwRWJJ?=
 =?utf-8?B?YjhuM0s5U252TkRsSjlPSzNoWUxnc2J4cmNoZ1NuSEdrbVUrQ2cyOXhnWnZ3?=
 =?utf-8?B?NE9DL0VHc1VyRVVhQ29td3NTckRUNDE0SGozYUp0SzJ2ekg4QjdmeG5pazJT?=
 =?utf-8?B?ZThuVW1XUVg1ckh0MXhvK1EyeHQzbi9KQnkxTnk0eUQ0cDlLdGQ2Qm1DV2xw?=
 =?utf-8?B?ZmNxQUFTTkhqWlVSamwwR3Q5S2g3ZHZFUWlFcTFxYWNoQVNoaWtMUDJuUDVs?=
 =?utf-8?B?a1lvb1ZqcWZuR0hvTTVBc01mQVAyOVQ5TW9GVUpwNnlOeWZ2NE0yRW1rYTJ1?=
 =?utf-8?B?dkpLYllzczNDK3cyUlN5dkUwcFErQ2oyV2FSMWEwOHJheTgzVHdIQWh0aWNF?=
 =?utf-8?B?eFNVV1l4S2F0RENHcm1QTm1OaUMvMWpSeURkZW9ack5idE9yalVBSGZ3QTZk?=
 =?utf-8?B?UndtSEVxYlMwNEVwTDRwMlIyWlV6WEpUSDRidS9VbmxPUnVITWFnZUdJRHZ6?=
 =?utf-8?B?SHBiUWp5SHdiN1RXMkd2YWlJckFhNnQzNjZKSmM5a3VTZWY5SjJ0WWNsV2NI?=
 =?utf-8?B?OW95cjd3SkdVdzV5eXdoVTNFM21zOUFBU1VkMUN1ZjBpa2UvU1ByZFNFaXVr?=
 =?utf-8?B?dnNxUjJ6RVlWOThwSXVYNmhobU5PbWVqczdSd2VxMFJZRW1maVo3dEovR3Ev?=
 =?utf-8?B?WUt1SVJtMm9seVNaN01qZk11SlY2UW1HeVpDb2hrOFI3TWtJYWVvS1ZOMXpk?=
 =?utf-8?B?VVEzdEV0bVIvSHcweHpMVEMyQVdRc0JwYXVQN1plNzRkMG8rWDhtTUlwWlR6?=
 =?utf-8?B?Z2ZUN2tMV2hzRHpSZ2dpZjlQdGNUVmpEbHMwQ0d0TnFwRUtqeVltRldxWWlI?=
 =?utf-8?B?dEU4dkZkdXNsbTl3blZlMlgvT3ZRcFdXUlRPak41aitBbW5ITTk1di8zWitR?=
 =?utf-8?B?Q3hqYjV4MXczRTZuejFVcmxnUFpIYy8xMnQ2dXRIeGVCcVpSM2NlVmdoWXFU?=
 =?utf-8?B?OElGMWRvN1JZcWJMakF1Si80aWlJQ0l1ZGYrMFhFVXhwRU9wVWo3dmFrMFJS?=
 =?utf-8?B?N3lpa0VUVVNNWVJDQmd3YTlsMFZXcTd3NjFUWWhyL3dEb2FFeVpxM05aUFpH?=
 =?utf-8?B?SGtKcFp4ak82ZWloWnZRY0Z1V2hydVhVWWhxZjE1S0lRRVh2VDlWSzYrekVK?=
 =?utf-8?B?RzFuZllyZlhBZ3FGL2czTldsa3VxQnIxTWdOalhGTkRLNFY4cWphNzE1aHdM?=
 =?utf-8?Q?+yIS90MzGRgzKccTkA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3002876a-04c6-4c86-74ba-08dedf37d6f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 10:33:25.7033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3LxMkzU4YHR77Nl4fWnvHLH9EJoTamSYHOr5kPiB2ocPbQVDM60mjAX/LdzCM/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999307
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

On 7/10/26 23:54, Matthew Brost wrote:
> The overarching goal of this series is to keep user-facing IOCTLs snappy
> by holding the BO dma-resv lock for the shortest possible time, and to
> push the expensive, best-effort work - page (re)allocation, DMA mapping
> and placement fixups - into the background or out of the locked critical
> section entirely.
> 
> Two related mechanisms fall out of that goal:
> 
>  - Out-of-lock backing. Page allocation and DMA mapping are the dominant
>    cost of gem_create and of BO moves, and doing them under the dma-resv
>    lock serializes otherwise-independent clients.

Saying that doesn't make sense.

The DMA-resv lock is either per BO or per VM and so the clients are not even remotely independent of that lock.

>    This series preallocates
>    the backing pages (and, where applicable, builds the DMA/IOVA mapping)
>    outside the lock, then transfers the result into the BO under a brief
>    lock hold. The user gets a fast IOCTL return; the heavy lifting happens
>    without contending the reservation.

Ok, that sounds like a really bad idea.

Why in the world would you do this? The dma_resv lock is exactly what is used to prevent something like that.

> 
>  - Page defragmentation. A BO allocated under memory pressure keeps its
>    scattered, sub-optimally-ordered backing for its entire lifetime,
>    costing TLB efficiency forever. TTM grows the plumbing to track
>    order-failure and to re-back a populated BO in place at the beneficial
>    order, and Xe wires up a background delayed worker that promotes such
>    BOs on the GPU once memory is available again - again, off the hot
>    path and without stalling the submitting thread.

That could be quite beneficial, but so far falling back to low order allocation was only seen as last resort to avoid OOM.

Regards,
Christian.

> 
> Since v1 [1] the series has grown considerably. The bulk of the new
> material is a direct result of profiling: once the defragmenter was in
> place, the remaining dma-resv hold times and the per-BO
> allocation/mapping costs showed up clearly, which motivated the
> out-of-lock preallocation, the IOVA-based mapping path, and the amdgpu
> counterpart. Rather than land the defragmenter alone, v2 folds in these
> optimizations since they share the same infrastructure and the same
> "hold dma-resv briefly, fix up in the background" architecture.
> 
> The series is organized in sections rather than described patch by patch:
> 
>  - Patches 1-10 (drm/ttm): core TTM preparation - order-failure tracking,
>    the defragmentation move, reclaim backoff, and out-of-lock page
>    preallocation plumbing.
>  - Patches 11-14: other dependent drm/gpusvm and drm/xe patches this
>    series builds on (DMA-mapping accounting, per-order DMA stats, async
>    L2 flush, and a VM-teardown ordering fix).
>  - Patches 15-23 (drm/xe): the page defragmenter itself - BO tracking,
>    the on-GPU defrag copy, xe_bo_move() handling, and the background
>    worker with its stats and configuration.
>  - Patches 24-25 (drm/xe): out-of-lock system BO backing preallocation
>    in gem_create, moving page allocation out of the dma-resv lock.
>  - Patches 26-32 (drm/xe): IOVA-based DMA mapping optimizations, building
>    and finalizing the mapping outside the lock.
>  - Patch 33 (drm/amdgpu): the equivalent out-of-lock system BO
>    preallocation for amdgpu, exercising the shared TTM plumbing.
> 
> Testing
> =======
> 
>  - 3D benchmarks on Ubuntu and on Android, with memory intentionally
>    fragmented by a separate program at launch (plus beneficial-order
>    error injection). BOs are initially backed at a sub-optimal order and
>    scores start lower; the background defrag worker then promotes the
>    backing to the beneficial order and scores climb back in line with the
>    unfragmented baseline.
>  - IGT:
>    https://patchwork.freedesktop.org/patch/739052/?series=170046&rev=2
> 
> Matt
> 
> [1] https://patchwork.freedesktop.org/series/169053/
> 
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Ryan Neph <ryanneph@google.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> 
> 
> Matthew Brost (31):
>   drm/ttm/pool: Allow backing off reclaim at the beneficial order
>   drm/ttm/pool: Add ttm_pool_page_order_nodma() helper
>   drm/ttm: Record sub-optimal page order allocations in ttm_tt
>   drm/ttm: Introduce ttm_pool_alloc_iter for __ttm_pool_alloc()
>   drm/ttm: Support defragmentation moves
>   drm/ttm: Add fault injection for beneficial-order allocation failures
>   drm/ttm: Harvest beneficial-order pages on defragmentation moves
>   drm/ttm: Bound page (re)allocation per defragmentation move
>   drm/ttm: Preallocate beneficial-order defrag pages outside the lock
>   drm/ttm: Add full out-of-lock preallocation for ttm_pool_alloc()
>   drm/xe: Flush L2 asynchronously in xe_bo_trigger_rebind()
>   drm/xe: Destroy page tables after unlinking all VMAs on VM close
>   drm/xe: Track BOs backed at a sub-optimal page order
>   drm/xe: Back off beneficial-order reclaim under defrag pressure
>   drm/xe: Add xe_migrate_copy_defrag() for on-GPU defrag copies
>   drm/xe: Handle defrag moves in xe_bo_move()
>   drm/xe: Skip self-copies for borrowed pages on defrag moves
>   drm/xe: Add a page defragmentation worker
>   drm/xe: Add defrag GT stats
>   drm/xe: Add Kconfig.profile options for BO defrag configuration
>   drm/xe: Defrag using out-of-lock page preallocation
>   drm/xe: Add defrag profiling tracepoints
>   drm/xe: Preallocate system BO backing outside the dma-resv lock
>   drm/xe: Add tracepoint for xe_gem_create_ioctl
>   drm/xe: Add IOVA-based xe_res_cursor variant
>   drm/xe: Use IOVA-based DMA mapping for eligible tt BOs
>   drm/xe: Add per-device dependency scheduler for IOVA defrag finalize
>   drm/xe: Add packed copy-step IOVA mapping for defrag
>   drm/xe: Blit src-natural to dst-packed for defrag-IOVA copies
>   drm/xe: Finalize defrag-IOVA moves with post-copy job
>   drm/amdgpu: Preallocate system BO pages outside the reservation lock
> 
> Thomas Hellström (2):
>   drm/gpusvm: Add a DMA-mapping accounting callback
>   drm/xe: Add debugfs stats for DMA-mapped pages per order
> 
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |    2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   45 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |    5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |    3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   39 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    3 +
>  drivers/gpu/drm/drm_gpusvm.c                  |   17 +-
>  drivers/gpu/drm/ttm/ttm_bo.c                  |  101 +-
>  drivers/gpu/drm/ttm/ttm_bo_util.c             |   21 +-
>  drivers/gpu/drm/ttm/ttm_pool.c                |  931 +++++++++-
>  drivers/gpu/drm/ttm/ttm_tt.c                  |   67 +
>  drivers/gpu/drm/xe/Kconfig.profile            |   40 +
>  drivers/gpu/drm/xe/tests/xe_bo.c              |    8 +-
>  drivers/gpu/drm/xe/tests/xe_dma_buf.c         |    2 +-
>  drivers/gpu/drm/xe/tests/xe_migrate.c         |   12 +-
>  drivers/gpu/drm/xe/xe_bo.c                    | 1632 ++++++++++++++++-
>  drivers/gpu/drm/xe/xe_bo.h                    |   15 +-
>  drivers/gpu/drm/xe/xe_bo_types.h              |    6 +
>  drivers/gpu/drm/xe/xe_debugfs.c               |   26 +
>  drivers/gpu/drm/xe/xe_device.c                |   35 +
>  drivers/gpu/drm/xe/xe_device_types.h          |   57 +
>  drivers/gpu/drm/xe/xe_dma_buf.c               |    2 +-
>  drivers/gpu/drm/xe/xe_ggtt.c                  |    2 +-
>  drivers/gpu/drm/xe/xe_gt_stats.c              |    5 +
>  drivers/gpu/drm/xe/xe_gt_stats_types.h        |   17 +
>  drivers/gpu/drm/xe/xe_migrate.c               |  531 +++++-
>  drivers/gpu/drm/xe/xe_migrate.h               |   17 +
>  drivers/gpu/drm/xe/xe_pt.c                    |    2 +-
>  drivers/gpu/drm/xe/xe_res_cursor.h            |   56 +-
>  drivers/gpu/drm/xe/xe_svm.c                   |   36 +-
>  drivers/gpu/drm/xe/xe_svm.h                   |    3 +-
>  drivers/gpu/drm/xe/xe_trace_bo.h              |   90 +
>  drivers/gpu/drm/xe/xe_userptr.c               |   55 +
>  drivers/gpu/drm/xe/xe_userptr.h               |    1 +
>  drivers/gpu/drm/xe/xe_vm.c                    |  149 +-
>  drivers/gpu/drm/xe/xe_vm.h                    |    5 +
>  include/drm/drm_gpusvm.h                      |   19 +
>  include/drm/ttm/ttm_bo.h                      |   64 +
>  include/drm/ttm/ttm_pool.h                    |   46 +
>  include/drm/ttm/ttm_tt.h                      |   43 +-
>  42 files changed, 4029 insertions(+), 189 deletions(-)
> 

