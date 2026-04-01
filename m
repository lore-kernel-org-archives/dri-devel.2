Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E71D35170
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36DD10ED2E;
	Wed,  1 Apr 2026 10:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/7+wfUe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EC710E404;
 Wed,  1 Apr 2026 10:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtWOwvW5bb+i8fHpDtc6s19v8/G7DHs6zxoE9lBKZniWDZPxhgLOM25guAp8lIMiuTJ6oGW2Se12ZV2ulD6qpzJy3nJaIrZAZ/TsNB7/WmwNjYTtjU97Mb8QyuC8/G8+jLLiHBbli5/62XkC8cilM8NSU6qJqSHpkfIvA10GwSm2r/IBlAI1SJWheoLbfadtXOvDDsDwMe7uXnHZl5FE84xmxlVPqh0Q5Aurl339ctznCVI7QffbostNwF6fpKUrOTiHBkaF360Unl5QERDnPDdanfhdw4A+aShQwTGz0q956qvAC1kRrVtAZLuS9nwIbndjqIXWzOsFFRradIavRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqwEbyFPka5c/Sb3msPGNg8KiIv4M5pb2vgm7VMzIJc=;
 b=dvLTvgzyipE7fEq/vRy5aE+43n+n05DXaum6XZp36zjjQPbZILVetIDd0TTXzg4vPdV7es89wJZl2DD/Z2kGyMzoNNnCTBMmCot5mUB4JdejWU459gQLiHVU2lrGxI5LzkcmX2cE8mKPuFzRHmW3utk3XqnlE9COqlkk8BpSzEYY/03IYzpyemB5+cgGz+LfMdzmuTv/Lby1ZjvPA1ST9wCs3k5apRx2JMgez+hDq1aRZRe2bTir6Y21qOXRvwaJbAl5UoFO0yQjRLp4UP92Oz+mkug/gN6OYsfKn9qeOgl/+nVYsGj5zxeVqG9eSIfnCLxSxgbMkqUhIMswXm2cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqwEbyFPka5c/Sb3msPGNg8KiIv4M5pb2vgm7VMzIJc=;
 b=h/7+wfUeIOgff+1TUbPreGqeiUCmIcwAbZmAug5kkrY864cLec/X06byIbiR8Yr/KZX6QHz8VL7Mpvl9EgaV+5hHnBKcAcgbJO9ix49QmgQHoXTkCBrtlHiS4PT351M0MeGFpPDPYgIAIyhbEbkl4jDA9vvZ6hZr01vnyRx6s90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:16:26 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 10:16:26 +0000
Message-ID: <c326316a-d5c4-48c4-aed7-c019b5181d41@amd.com>
Date: Wed, 1 Apr 2026 12:16:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
To: Daniel Colascione <dancol@dancol.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <87341fsa85.fsf@dancol.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <87341fsa85.fsf@dancol.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f1ab43-4f8f-448c-7148-08de8fd7bbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 09Ppe/KMNjhxrmGoly0gfYqkmbbBrsKzZ2O1dowfWahzc17+p1M1sNbTxVjPjGgdAZiuTwxStp6AiwdKsluhLD3dpgA8tPYvsqIbBmu0I8Wcqi1z/uqdj7wp5DjO1ZxEhYGrJNv17PxAQopRSQRf7WWIZzI9yCcQt46+HNb4GVlDxjwQCCiDxBjKKJTAV7hrI0di5M/xowBkGFAZ/4U8vq9DUwwfPmCg+17wgfA4pCor/6kUcusytaILWZNQ+8WD7JCtVIndjD1ts3wkf1T6PGn9XY2bbDGk/bJK8HEvEVHHhkYCpYQ8KRoVBPj9PHwCsy/umUlUrhNn1O8HKCgl2mK2crsTudsiRrPwM3QyR/sqM4Jkw8ntgJcXBlUdnnjusJP6//yA4I/XR9x3nUTA1GFN1L6bhfpl28853id8eOA/pGIb7wDOqx++o0rLvSiErghrLeWLxKfVQiJgvO9iSO2ckdcijfnNqlOQA4nIW/C1yM6hLvyOlNUnLVWXbpBmDtYmHBpXNmNCnYYhqFCoqPQq5yv7J59AAec2QDAQVIwRO8rtTj6pvUWyk8HEvQ0+sS8I5P5KfpFu3bzYfChfdw2C/tAsuE4mWy3fXr1OGpMvL0R29suCEIy/7p3E2gF/SEUZCEkp1RdKME7MhRz1Bp/vpEolQ1D3zsBViJG5DN0xKHpQs5WOnwv99rLEWRE8pzOVpo0Q9rZJONJOrW7mDheGaVS5bVljlP4/mq43uk6RPMTueanqKbGuwzS6HRS9boXdqs/bK9RCKpHrMUj2LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXU1MlIrZkhnZnFuWWtRT3Zmd0dBMldJRVZLdTFJcG96amdBeGZDUjZvempa?=
 =?utf-8?B?ZGhTUHl6WFZNd1RQdTNWYjZmYmZhZHpJRTB2MXdhN3FaMUYzbXdJRkg2K3kr?=
 =?utf-8?B?YVoxYmEvcDR4SmdyV1l4SFZYUkF1U3pYdU9TZXNGbW1LRldWYVhhNmIwUEpN?=
 =?utf-8?B?NkNOcCswMFk5MW50RHZ0aVRtYm9XOWlXYWRzTlhSVm80Uk5mY1ExbTBBQXM3?=
 =?utf-8?B?NGFDVGRvOHFhb0VrY0RyTHFsVTNqak1BcVZtdHYwRU5GK1Z6cUI4WVl1ZnRF?=
 =?utf-8?B?bzlzVDYydHV1VWM5L29IaXkyNzF1cnhvdVNYTy9FSG1tRExTNkhYVXhZM3pT?=
 =?utf-8?B?K01ZRTBQbHI3M1gvRG5xZkVVaWhobVp1anlTak5LZVJFYnhwbkRMb2lhekdH?=
 =?utf-8?B?bWJzRThValFxMHRSRHFtWU1xWWE3Rk9RTEJwUDA3bTJJZkMwODczME1wemRI?=
 =?utf-8?B?T3ladmYyNTVQb1hhUmxnVmdOcUtxeHIvNXpDVXNYazhNalBDSGM2VUNYUi95?=
 =?utf-8?B?QXFGN2pNVEthekY2QkYwRkRsSzhKM1ZqSzRRWEQySFJRblVNZHdvbTNnMDBy?=
 =?utf-8?B?ZGpRTDQ1bCtUM1ZKRnhIVFRyOTdwOWRrYVhocXE1cjdHQ2hTRG5jVjRUa3d2?=
 =?utf-8?B?amJnaXF0L0lnMnpzazdHeW9MQVVMZEgvNjYvY05Rd2IzN3hhMjZONm5YVzBF?=
 =?utf-8?B?cllFWjVxRUVhNytVVEpFOSsyTG8zQnRPWHkvUjRPU1J6MzlRRGRLV01hYzhm?=
 =?utf-8?B?dXdzbzNybkt3cVZjcElBd3ZydlZwMmRCTURZWVhsU3NVNUpQTmhORWg4dWZT?=
 =?utf-8?B?MmpXVDNLbEZMRXV2MXRXb2QvTlpxamU0ZzZZak9EaXNsbVR5SmliTHFtYnhJ?=
 =?utf-8?B?QVlDMHNOSmxCQTFpcWswRkJiclRPUVBDWkExZXc2bTMrRCt4dTJoZDFqOG5V?=
 =?utf-8?B?OGtSaXNTZm5GOHl6YURYS0tVYkpNNS9rL2pMek4yTXdvbFdMZnRQM2NNTytp?=
 =?utf-8?B?dkZybWxDOXBZUE9hbmhTdHhxd0IrVUtDbzczdE5aVlpNZkh3M2tTUVl4Mldv?=
 =?utf-8?B?MEFIMDYxM0NxMHAyRE9MUFBXR3R3Wm9zSEhwNDF3aDQ1Y1JXOVBJeFFvWVZl?=
 =?utf-8?B?M3dnVTk4UGFXOWlGdGZ5ajRHN2dJT044bHgyUXArdTM2RnZHNlZiTzdJdVB0?=
 =?utf-8?B?U0pJZjVxMU0rTHA0alBhdEV3VTkybWJOMUkyWWt3b0lESVMwMHdEdlVTMnJF?=
 =?utf-8?B?Um9BeE84aGJwZ0NWVSsxYjZhajA3clBGYmRPK3dZZmpqVmZmV0JUcDlRaGIy?=
 =?utf-8?B?clg0YzZKb2FIQ3pHMXYzSWJMU2VRNlA0R0svZU9qWTBSYUVKaTNQMEpzNW5p?=
 =?utf-8?B?ZlhSZFdJK3dwTmVTSGFKakE3VmxRNHRjOXdvTnFCMGZKMVFiR2FHU2lRVWZx?=
 =?utf-8?B?cGUySVpiS0ZKaGVXU21uYW5xTnBQYmtjRlRjaVNtbVhyZHk4aHJsckwzS1ll?=
 =?utf-8?B?bEgxeWRhK0VUVkJPTDd3aVdIUDBZNk5SeHI3WjU3VmpMZHl5d1NlWEpoNFgx?=
 =?utf-8?B?cXJYTEM4QWh1TlBXS0tGbjVQWFF0T1VJSldra1h6TDNWSllGaitLbVZsZnV5?=
 =?utf-8?B?bmtlTmRabld1TWlyNW9KOW5mM0prU2ZOZDd5MnV2SjhQUXRWZkw2eURydFA4?=
 =?utf-8?B?a1RBNlc4cTZvVUx1RWF3aDRheVFwZzhLNkdSYnFBam1YcWdWWHBvRDNUZ1RI?=
 =?utf-8?B?a1d1SHlCdUtDQzVoMkxoRldCczJEdHdpVzRMTXVXcWR5MGlqQ0Jyakp1Njho?=
 =?utf-8?B?MmJ4VEh2YXJhUW8rV003UTlubWZjbnBpdGhmZnJHNlliR1NLR2RuMitGcGVi?=
 =?utf-8?B?eXBwYXRheUd0dnJXN2VDMU1xN1Irem1pcU5mRnMwSXY5cG1rTmErZWR5M2NP?=
 =?utf-8?B?MnJYLzgwZTdadEprS2p3VGpudGd3N2REUXBOUW9CZ3drNzhDdCsxYTIzakVC?=
 =?utf-8?B?Sy9NMVY2clc3bXUvVU5rOGhKeFNxRjBtM1BjSUpYWUMvekZQbFprVW9HS2Q4?=
 =?utf-8?B?ZHdxOXJMTG9ZY25ML0J0dU5Ba3BuKytycFFKQ2xXYVhzY2RMZTVsdlBxZU9v?=
 =?utf-8?B?N2ZqRk95UmhUdCtlWnpLbnU1ODN1cVd2aEF4QnZRbmR1YUxya2k3Z2NNR1RY?=
 =?utf-8?B?K3dEYjcvcnhLMUtpcC9zQmlnNTBNMWVCU3IxMEY4S0Q2U1RyaSs4R0FPOEdY?=
 =?utf-8?B?VisvT1hLQm93NXVEaklqUVdnUkhaUkw2bTJUanlOQXorZ3FrMkZMWmh6V3JZ?=
 =?utf-8?Q?PexumepTycrfTB8eML?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f1ab43-4f8f-448c-7148-08de8fd7bbbe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:16:26.6331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NmCeKQIZueKDb4hWglDW/cuBVd6LJNGxWPdHoN/SY7CzDhIddRzrDqmiIUZy6rI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

On 4/1/26 04:08, Daniel Colascione wrote:
> TTM seems to be too eager to kick off reclaim while kwin is drawing
> 
> I've noticed that in 7.0-rc6, and since at least 6.17, kwin_wayland
> stalls in DRM ioctls to xe when the system is under memory pressure,
> causing missed frames, cursor-movement stutter, and general
> sluggishness. The root cause seems to be synchronous and asynchronous
> reclaim in ttm_pool_alloc_page as TTM tries, and fails, to allocate
> progressively lower-order pages in response to pool-cache misses when
> allocating graphics buffers.
> 
> Memory is fragmented enough that the compaction fails (as I can see in
> compact_fail and compact_stall in /proc/vmstat; extfrag says the normal
> pool is unusable for large allocations too). Additionally, compaction
> seems to be emptying the ttm pool, since page_pool in TTM debugfs
> reports all the buckets are empty while I'm seeing the
> kwin_wayland sluggishness.
> 
> In profiles, I see time dominated by copy_pages and clear_pages in the
> TTM paging code. kswapd runs constantly despite the system as a whole
> having plenty of free memory.
> 
> I can reproduce the problem on my 32GB-RAM X1C Gen 13 by booting with
> kernelcore=8G (not needed, but makes the repro happen sooner), running a
> find / >/dev/null (to fragment memory), and doing general web
> browsing. The stalls seem self-perpetuating once it gets started; it
> persists even after killing the find. I've noticed this stall in
> ordinary use too, even without the kernelcore= zone tweak, but without
> kernelcore, it usually takes a while (hours?) after boot for memory to
> become fragmented enough that higher-order allocations fail.
> 
> The patch below fixes the issue for me. TBC, I'm not sure it's the
> _right_ fix, but it works for me. I'm guessing that even if the approach
> is right, a new module parameter isn't warranted.

Yeah the module parameter is probably good for testing but really won't fly.

> 
> With the patch below, when I set my new max_reclaim_order ttm module
> parameter to zero, the kwin_wayland stalls under memory pressure
> stop. (TBC, this setting inhibits sync or async reclaim except for
> order-zero pages.)  TTM allocation occurs in latency-critical paths
> (e.g. Wayland frame commit): do you think we _should_ reclaim here?
> 
> BTW, I also tried having xe pass a beneficial order of 9, but it didn't
> help: we end up doing a lot of compaction work below this order anyway.

Well as far as I can tell that allocation behavior is completely intentional and just the lesser evil.

I can't say much for Intel HW, but for AMD HW the difference between higher order pages (2MiB) and anything below usually comes with a 20-30% performance drop. So falling back to anything below 2MiB is actually only the last resort to avoid the OOM killer.

The real question is where is that heavy fragmentation and sluggishness coming from? Even when the find / > /dev/null creates a lot of 4KiB allocations the kernel should be able to reclaim them to create larger pages again.

And then finally I agree with Thomas that userspace shouldn't make that many allocations on a normal desktop. That should also be a good place to start investigating what happens here.

Regards,
Christian.


> 
> Signed-off-by: Daniel Colascione <dancol@dancol.org>
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index c0d95559197c..fd255914c0d3 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -115,9 +115,13 @@ struct ttm_pool_tt_restore {
>  };
> 
>  static unsigned long page_pool_size;
> +static unsigned int max_reclaim_order;
> 
>  MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool");
>  module_param(page_pool_size, ulong, 0644);
> +MODULE_PARM_DESC(max_reclaim_order,
> +                "Maximum order that keeps upstream reclaim behavior");
> +module_param(max_reclaim_order, uint, 0644);
> 
>  static atomic_long_t allocated_pages;
> 
> @@ -146,16 +150,14 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>          * Mapping pages directly into an userspace process and calling
>          * put_page() on a TTM allocated page is illegal.
>          */
> -       if (order)
> +       if (order) {
>                 gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
>                         __GFP_THISNODE;
> -
> -       /*
> -        * Do not add latency to the allocation path for allocations orders
> -        * device tolds us do not bring them additional performance gains.
> -        */
> -       if (beneficial_order && order > beneficial_order)
> -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +               if (beneficial_order && order > beneficial_order)
> +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +               if (order > max_reclaim_order)
> +                       gfp_flags &= ~__GFP_RECLAIM;
> +       }
> 
>         if (!ttm_pool_uses_dma_alloc(pool)) {
>                 p = alloc_pages_node(pool->nid, gfp_flags, order);

