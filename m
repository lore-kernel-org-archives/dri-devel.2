Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE67C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BB610F367;
	Tue, 15 Sep 2026 08:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T8waihPP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E6410F367
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYUzTUUl2ALaRHr4io+e4bVqcXxTrncaIvJPfKVYtAgsZbQCXUuMkljZrJNdUAk43G4HSKRZyFNjd25SBEcbvDxO+YTULpyNBh7o+EXSz0iMnKawkTnuOODUK49ePRqrqrkpeG0MDimz1c2wFBQ+nLtA81XZQgtodG0awM8Xn88sY/iAcK7H6uu/GSwojATkxlgetBaBphULJY41aSazyVzWYUCea/wtq4vu8QAAReR9Nub0x5y9kZc1fJhSfOGkGA0dS7eX3CClgTr5sOQN+U6sK7LGNNTvSmXN0onSykbG9FCIdgGKK4w0tpDLUleeWY/IZoHpyJiphqzcVyqraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtumm/eJXylVjf83g2EXxaJAtPVmLa5sucl9kvPfQ/o=;
 b=qStFD6EqIgbg9bh7bDK/CInTwYR1qh/zTh819jzHpRPwoOXONZ6kM7vcMySzEWhWCRePYYQqMNprkPaNGzZcTnzgJP2iy8x5nTXBMwPDV3otVWQDiaSYquOdXNNcd6L0QGwiltfYXi4ClMA0ViqN5kQFgiDKkjOEQ5R3dxbYwz7SX+RfNAvhXcZ1hFXNh5kV11eMfY8Mpm+sTHDKWdif1FJfePch/4p3cJ4lA6boP3Ob7+BkaO/Xyr2jgjlNRYwlvNbvTlwiGdqeFAMeibVYneVrd8JDx20PTpjTigcm9zPSAbswGWDHJwLG91LOwbXn5MJ8ccTfIn//1DJsb+yVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtumm/eJXylVjf83g2EXxaJAtPVmLa5sucl9kvPfQ/o=;
 b=T8waihPPzcbD1xgKNcLfAfD/e0g4XS7+80iwI25vSuRGeWpXURDFgcsN7+d2RHFBqxXYD2Z8Y9iKSI5pqqgZelldul3NQAwq5yotvUAlsbHzXGzlYG1SQTz4hbrpA6zmDpoqkMUeawBxEqBg7FUIoQTZSSSEp0CGvvGSa7/yUco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:41:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 08:41:07 +0000
Message-ID: <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
Date: Tue, 15 Sep 2026 10:41:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
To: Davidlohr Bueso <dave@stgolabs.net>, sumit.semwal@linaro.org,
 phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com,
 tjmercier@google.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260914212258.2657788-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 965fccf9-de8c-4324-49c1-08df130515f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: E8+IFICcM41894Gr0gC8mrB5Jl3eiyG1bMsWmeKYA6c2OgMEYc0r1pAvrnklmPLNYx3Sc9f17xn7KjhRF3wgumstF/LEgN5bUIyxULjQkfHceu4ldXSU304/MAf9StLnKcT61Ivt8x5UHzrM/zSiyuPweJtmkucVCdXGOFljdLHq9X6ZC+sqYaMVw7NToByGQgoM0wp79+F1aYlAmMn7ooVu5Ojq8/cMjzK3OORcbT67SeU0oK3UbQEkrwcajA1u8jxM4smj2p0rPd1HcHxI/bJ+zDBEL+pMAp4JHLkJC2oniOHs/qJOYMrThKccVbmBGQep5OPH4PGSpodcN5TcEJGutAyP86MVBguxYr8CcGVauqIVDfxfHyFSW8Ep3QojOnM9pYUDIH33KgReYUwLb9v9nFI6LTXEA1CMDc2F4YBu5hvWoNtdgj+qj3Kl4q2WcjTGdFXVZpfZfAbAJtM/UKw70//eAHgf/u0KNVx8rHkpY6a/8T3hMUihLXBla8UtwrwWe7Wzh447vtw1xaNID3ZfLhRbU1t8yxd0qoxVIbznHbnZHSt4hGXhp90MQXjpDNoz50s2a4vXzSs+Vyp82VnH0OIVzf7F1s2d2VcJv6X70+0OTmu5ShCaUgAaI7skUdydMKM+AcEUZn4ncKAYewhP3plCo0Brei3cVh6vyE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NBWmVDaG53cFROZThYcUJRR0ZEUDVZbDVCOVp2VjRxc0tIODJBcnNZb2hk?=
 =?utf-8?B?Q1lUQ3Fmd1QwcXgzbHBzMUF1cFppYU5YTGVBVWgwQzcrWTYxOTg3TlZtVG02?=
 =?utf-8?B?RVZMU3M0d1B2NWxJTTBVSi9Xc1Fvb0Q5M2ZiYmR5UW9Sd3JrR3JpL3N3UjFU?=
 =?utf-8?B?YlRSMTB6ME9heCtWNk1OblpIc05mNG96T1BJWGtqbVk4c1ZnSjNxbUR6YThx?=
 =?utf-8?B?U0xvVGNiSmtJS2ExRXVqVWZpQld4aHFwZzE0M3kwcEJxTDNwVnFRUlVBWTVL?=
 =?utf-8?B?S3JwUkdnMnBLQjc5dzlDdUVPcU5FNjEvMHd1U2xtSWxIRnlPSFo3SUpveWhz?=
 =?utf-8?B?bHNXRVJVTVF4TFFYdmdPK3hEL0NXc1RkcFJrbGJNMjhrTTdCc25YeDhSNWl3?=
 =?utf-8?B?VWthRzFGSHNESHM4cU5hOC91N1dIMlpLWG5JRU9ndDM2Y2lFa3JUeENZMCtN?=
 =?utf-8?B?a3lBdGtvSnA0QXFBd1pnRUVIcE1RdnFFQjdtYWU1eWw1QmZXcGQ0cHpvdTEx?=
 =?utf-8?B?MzJjSlUzaUhsZ2drRWVCYSsrS1hVam0yazNhOVo1dzg5ZkF1MnlMb3JqVExG?=
 =?utf-8?B?QU5XcG9ScTNyNEw5VzRFQ1JVK0R3U2VkNVlXUzRNZXhEWUxKV04yRUZNQ2JN?=
 =?utf-8?B?dEFOb1NoQU8rOFhTMUthTkdaSERTbGFpdER6cW52eVEvd1hZQWZEREVhTURy?=
 =?utf-8?B?YTVObnJhV2lZeUFveEppRWR1ZjhoMExldUZJbjhZdmtaenZZR1BHbExyN2s3?=
 =?utf-8?B?eFNSdURId2puNEQ2NkYwdENnZkNXNTMrTFNXaHNTN3I0ekRmdlYvQjRtdkxC?=
 =?utf-8?B?S1lPQkVHTjFEcW4zUFlpL0FjRUZFYytIUkxzNzNuTnFxaUlMSHVraWlSVlRx?=
 =?utf-8?B?QW9sN2IwekxlMXVXVExkbGloMFdQbVlacXJaTndhRThwQzN1UmVNVTE5elFT?=
 =?utf-8?B?VmdaNWV6SEJOT3ZUK0FSUTNMa2RURVA2SHpHRGtBVXArRkpJcUJ6bVgwQWZ6?=
 =?utf-8?B?ODJtWlJMd0tWbG1NV1Vjc0FIajUwZlBJTE5ROXAyVHlaWmxINVRsa05WY2Ft?=
 =?utf-8?B?bS9LMGxSY0ZFNTcwUHVlRDh0Qm5EMmNnQmcrNWVzQWRLTitrb0xVQXlCZWFW?=
 =?utf-8?B?QTJxUDVpTlN0YTNCbUY2WGVZanIxbTd5d2tUOWQxdVBTaEFpOGhUTkpqaXdx?=
 =?utf-8?B?R21nTkpiOVc1YkYwR2lZSkZldkFjR1Nha05mU1Z3bUR1TDhEeWEzNWYxUE9p?=
 =?utf-8?B?NnpWaHVsZGozeGJXVFFLOTVTN2tIN2VLREkzcmhEVFA3NjdVcHkvK3BKV3ZQ?=
 =?utf-8?B?eGc2UVVYMlhNQThXOFhYOUFvTFU3S2ZsZVJJaHhyS29CRkpOR0lwbmZVRzJC?=
 =?utf-8?B?T3ZIdXd0SU93L3F6OHNlczJZVVlFV0xJZkFHcElVQU1YWDJJYkxlbENjcFdR?=
 =?utf-8?B?aG1hUmFDOUs3U202WUJtZXhDUzYwVk9uY2RIdkdQLzlmUjFFak9VZFp3ZVEv?=
 =?utf-8?B?K0xtV2NzMTgyZ3VwcnNwbzJpVkpZczNqU0lkSzV4VGlQbjZENmttUHJEU29S?=
 =?utf-8?B?N0RLZ0FJdnQrcFhSbDQ1U2g3SGwydUZKbWU5L3hOVS91L2R6RmFwSjBKN0JB?=
 =?utf-8?B?MEJvTmlHWGZveXUrSGF4UTNUSXNDZDNwcUdtWHRSckZtd3F4YnN1YzltRlJt?=
 =?utf-8?B?c2JOb2NyajQ1SUZJT0FuT2RQMnU3RzRRdkIrUGxwbnFQTVlwSkJjOGo5dXAx?=
 =?utf-8?B?UGphcmVxd0M4OHFNU3YrYkdsdUIraXQrMi9tb05GNFNjMGY0YWJBMnh4SmMv?=
 =?utf-8?B?c253d2IwZ0grelM2Qm9aNnRzd0d2KzM1STVJak04dmNtZjBGREhaQzlEUUpK?=
 =?utf-8?B?cnJXUFpocmxVS25XVjB3WHBBM0lMQkphNVNrTkQ5NjBYbmlMR2toYXFCUkkv?=
 =?utf-8?B?bjU2UU5kd056OVI1MlNxZ1ZHYjk5bFh5REtzUVJtSStpaW1hVjU4SXFrWm4y?=
 =?utf-8?B?T2JYMTRuay9sazllTVhCbG53Q0FraFpkN29LTHVsK3NDS3ZVS2tOTDJMemN3?=
 =?utf-8?B?MURDaHAvMFhBNllFZHp2MFFpakpqQ3BNWVVDazhNU0xGd1pUQ0hIeGtrOXRB?=
 =?utf-8?B?c0hxVjdNREFXSjRoaENzc2FWdGNESEhQNG5EcU9NUThEbUN5eWlrd2w3QnhK?=
 =?utf-8?B?NHc1VEtsTkVuakowRjdDai95TVNRZGdhbVdxKyswSGVQdUZ1eFB4WnlqbVZV?=
 =?utf-8?B?NXN0RDdvYXd0UEpONFRZWFJXWS9FN1B5Z2t3em5MUG1KNTgvaVFVZVBMTEJl?=
 =?utf-8?Q?b0wHv824TZQLciAARZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965fccf9-de8c-4324-49c1-08df130515f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:41:07.7025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0URKhefsaUtcut73sfEKMtxJgvOYsScdV9lQmtYCM48EizUmuF0trCNUl5Irzs5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
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

On 9/14/26 23:22, Davidlohr Bueso wrote:
> With 4KB base pages, the system heap allocates buffers in 1MB, 64KB
> and 4KB chunks. The conventional Intel VT-d second-stage and AMD-Vi v2
> page-table formats, and Arm SMMU's 64-bit long-descriptor format with
> a 4KB translation granule, define 4KB pages and 2MB/1GB large-page
> mappings, but no 1MB leaf. A 1MB chunk therefore requires 256 4KB leaf
> entries unless it can be combined with adjacent chunks into a
> suitably aligned larger mapping.

Yes, it was an intentional design choice to *NOT* optimize for AMD nor Intels IOMMU here.

> Adding a 2MB allocation order provides naturally aligned, physically
> contiguous chunks matching the 2MB leaf size, without relying on this
> being accidental for separate smaller allocations. The new cost
> is one failed order-9 attempt (keeping current large allocation semantics)
> per buffer when 2MB pages are exhausted.

We have plenty of experience with this with TTM and the overhead this results in is usually not acceptable.

> Two benchmarks, measured on an AMD EPYC 7313P.

Why in the world are you testing the system heap on an AMD EPYC system?

AMD clearly doesn't recommend using the system heap on those boxes for ROCm, so I'm really wondering what combination of HW you have here?

Regards,
Christian.

> 
> (i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
> measuring map/unmap: with the v1 page table restricted to 4K/2M/1G
> (amd_iommu=v2_pgsizes_only), a 1GB buffer goes from 1024 1MB chunks,
> only one of whose 2MB windows was superpage-mappable in that run, to
> 512 2MB chunks with all 512 mappable. dma_buf_map_attachment() costs
> decrease by ~16x on average with ~32x for the worst cases. Unmapping
> that buffer drops from ~500 us to 1.25 us.
> 
> (ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+close
> across various thread counts decreases by factors of ~3-7x alleviating
> allocator's zone->lock contention by being PMD order and therefore is
> pcpu list eligible. Once the buffer size is large enough then the cost
> of the zeroing takes over.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index c8959eadc71d..621cf238ef97 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -55,14 +55,15 @@ struct dma_heap_attachment {
>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>                                 | __GFP_COMP)
> -static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
> +                             HIGH_ORDER_GFP, LOW_ORDER_GFP};
>  /*
> - * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
> - * to match with the sizes often found in IOMMUs. Using order 4 pages instead
> - * of order 0 pages can significantly improve the performance of many IOMMUs
> - * by reducing TLB pressure and time spent updating page tables.
> + * The selection of the orders used for allocation (2MB, 1MB, 64K, 4K) is
> + * designed to match with the sizes often found in IOMMUs. Using larger order
> + * pages instead of order 0 pages can significantly improve the performance of
> + * many IOMMUs by reducing TLB pressure and time spent updating page tables.
>   */
> -static const unsigned int orders[] = {8, 4, 0};
> +static const unsigned int orders[] = {9, 8, 4, 0};
>  #define NUM_ORDERS ARRAY_SIZE(orders)
> 
>  static int system_heap_set_page_decrypted(struct page *page)
> --
> 2.39.5
> 

