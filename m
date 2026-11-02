Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11D606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=knl4XejJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BB010ECE4;
	Mon,  2 Nov 2026 10:51:02 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37A810ECDA;
 Mon,  2 Nov 2026 10:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbU3fRt1QGyOo/lQ1my0CCgNC3zT6VXI3E42dpP702eRWMW1xNvVsS10T9CoIFCmo7qsV98orKwuFeJwmWW6CJD5kWLG/Mx1E11Qv0/ASzUM/r1yFKFTeZK5P6choLcCOawd6AUPA4bv0wV5iM0CkK0aqPFgr2pySKK9ro35HYO95W1LOplwiFa1ihXqhlJJaQMjqvLmdDARz2D+WDUoW4eT3ggqNnrdExCWQRbS2t2LkoTZxzDYqv5Q3ojfO3oAVQKkPWIudvfYU5D0YhM92gJF3CX/3xgAvfkE1oDk3DyKOHeEQhKWotQcdBahNmLopEpl697m5HCXcZk6vRF9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNyaGdPIXT/ukIKVBvACsoO98qldG5mzL8IY8NXX5UY=;
 b=XZRHawfNkhoEFMAZaC5XnFv0SgLzjBaLKAi8mnuxJ1dx65hH4SieL18ncA1cE5qYPltOkqjtqiLOvNB440lB4LnQOpzHQ6ZOF9f2pxoLGQl3DDB0zZjzteZlW9hJvVz1cwUvpRV18TcdbrOnyFWrdprl3YRhv3fWJekP9rAinAA6RKYlsRJfUltAbliU7oWC53HzMkkZJHjDO0ggd3XwIQ2xntwlGZmSh0X7IbJP5XP3k3+unnhoPaEZjt4OYaAnSOa/wPX9rmTG/NNWK0e17NqNKaMFHEZyMSFm9+cgU/VVtvnh3B+0NjREbHQeoSSHXx5UI+4uc8p4tCJZTvDO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNyaGdPIXT/ukIKVBvACsoO98qldG5mzL8IY8NXX5UY=;
 b=knl4XejJJL9V2lEcURDAHujvWf7Oi92p0tY8c4uZ/AevX3yu4YlUOS73JO62L50cmApGrK+w+xYwDCcP6sXHsGyldLE07fDIVDUdx9cprWHaoQNGsgT1j0Vsc4ooQgljNYV1cQp/Bc7LDzfxnyqKDPyg0ltoSV4l2oaVP1f3Hhc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:50:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:50:50 +0000
Message-ID: <8c2b893a-b666-4678-88f0-4e6b33142e1a@amd.com>
Date: Mon, 2 Nov 2026 11:50:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] drm/ttm/pool: Add ttm_pool_alloc_node() for
 caller-selected NUMA node
To: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Natalie Vock <natalie.vock@gmx.de>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
 <20261102101803.455921-10-himal.prasad.ghimiray@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261102101803.455921-10-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a5e229-16e7-4623-5ea7-08df38cf28d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|261021121427099003|4143699003|11063799006|56012099006|261009223027099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: iowHCuuYQX6FwCFJMvnc4v46HxX4Kx2VcAx0ZWmxAWTeriyBSQJnibwwWER7nCCjQVtghYhcavOBnTiSp/hrW9qpZoLdTNiMi8RQK1cHoRIRVmOHf2DVIK0RNmA9jydGopJUuxepq/tANBmu/FV9glKyfc1h63abWy3nlrX3eTxUARmChbqG4mcuxFhQwfd4G6V9Lq6T9vRXysNKRdi24E5iCuMawV7mFRDQql4vV9bdC+u4n7hj2PlUvA6x6VQps+YHUtT2AoQk/ijRgKrn5PN7of25synPxZfYI1BS6e3rTiHYLcBzxDFxE8idXV9iPqdJg/DArxQYfHCoSDWsJwAELLYePOl3xgzUELIgwBB1tsvuCFW9Z7WensuvyWqCLgOXPulu6LgbMSWBeErrwbeoKQ/dYfrRlj5GKobMBa0352HtGkXTrLNkQNWTlH5HTnQHFpqAMDNP9n65GopbsrspiWzJOHJtaPvwwdxCgBHAcJ94xCt56Dhqsx6IGFb/C7nc1PVg1aanjp+gNG6tEfq8SibdGu29r1eW2ZYYYKN2MSWw94Khz7XlVqDJ+kLxD12l8BB/7XnkU9NmsO7Hgir9BSWNHrEQlS0JiTzxCtTB43wllwHi4YWrltSN39l/kdlO2Be/r00qBwew3Ai8a5aVA7C179UL4zg3AKYab5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(261021121427099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkN5RE1iK3FnbDZ0djR4TnVIc2VLdzVEVUZyUnlibWo0V3RRQVJVZStXZ1lv?=
 =?utf-8?B?U3EzRWNqVDFtbzlNbTBRQXBveG1JWElFcWhsVkYrSWVYN1FwQ2FtVnd2WWk4?=
 =?utf-8?B?YUYzS2JHQmxhL1JNTk90OXNDSzVKVkFPMk5sRjNzQnYvZWRjbDZ3UFp1NzBP?=
 =?utf-8?B?ZFdJYWlBcFI1K00xb1dhNGsyeHNHZ2VqbUw0bkkwNmx4MUw1YjdLUGFvL1R6?=
 =?utf-8?B?TzZ1bnFFajRqSkdMc3NUMndaRXBiUGJTdTg2N3BwSmpmUnp0cDdwejVYUXdo?=
 =?utf-8?B?NG1QUnhSMllKanl0dncwTUlQZkZjMEJ0MHowMXRhb1V3akg4aTRNeUZUTXJt?=
 =?utf-8?B?bmpNTWNoaDh4cUlxUmR3M3dDRFpDNk1xSWVlQjVQVTdaeC8wU0MxYWFTaGM4?=
 =?utf-8?B?eXMwQ3JtME5yL2xpV2RPU2NLakZZRzVNQU8rQ2RNVjJwa2Fuc05ORVVMWWNM?=
 =?utf-8?B?L2hCK3hubnFIVnRUanMxTlIySUJHeTl3cjNJZHBROTJ2ais3TlBuUmdCNjF6?=
 =?utf-8?B?ZC9GTDFLSlEwdWxxQmNJalJpVFVBWllxQ252dUtzd2s5TUxrbVF5eS9ja0t2?=
 =?utf-8?B?NzZIWjhwU05jdTBZdXROMFkzdFpvRmxGZW9rZVhmK1V2R1dvSmNPcHNxT2Zp?=
 =?utf-8?B?UG41VHNEVjQvb3NZL0FTNnNma01QSU5IM2FMWUhVOTRzemhwd1g4MURRazlz?=
 =?utf-8?B?NlR5Y1BGd2ZoQTN1WkJoZ1ZtczZkWDNncE9aS21aMyt1bWJ6Wk5YSHU1ZGlG?=
 =?utf-8?B?WDB0dDVPU1Y0Zkx2cWo3MzlrWXZ2KzB2aHg5bCtTeU84SVJhczl4ejVwUTdW?=
 =?utf-8?B?Mk5PeUJIQ2tKUHBJRTdzQklYZmJLandxNWdGVC8rWVppWUU5M1RXcHgrR09a?=
 =?utf-8?B?YTF1S05aUGJKZFJPUkFjNFUwNHJCWVM4L1NlSWVVMmRsWHh4djNtQ2l3VDZB?=
 =?utf-8?B?RkUyQjhWYStMUTdVWUdEZW9EZjNGbXlhbE5QbVVmQTRpeUd5cnhPdDNYTDQ0?=
 =?utf-8?B?QWNvdWNKY0N1bDFDRDdFaUJob1JkbTJmd0djTzRsV01GOEtqNFIyd2xUL2dF?=
 =?utf-8?B?ekRnWU0rYjVEdWVIbytvRURpcVYvLy9FeVZJZnZzcys0bGkzaENiZDFxd2Vj?=
 =?utf-8?B?V0NWeFYvNU4rZDU2T1RFK09FSFBlZDA2dFcxbkdHUWNhVWIrQTRva0xsMitM?=
 =?utf-8?B?YUNOL2I5N0tmbmR1aUdpYzNCRDBtaVpscmV1cjZWZXd4d0J0UWdrUmI1T3V3?=
 =?utf-8?B?Nnh0Mi9RUVpxQVZwdEQyT0Vhb2ZETG9RcFBXTW0ram1aNEJxVHhTa2hCWXdJ?=
 =?utf-8?B?MVZ5UEZJVVZxR1FRQlJNaHRFbW1GdFNtMWgyZXlJTWlNd3p6UVZsY25aTFFJ?=
 =?utf-8?B?cGRDUFFUNHFVd3lZa3czaWhkTTNrZmh5VmxWb1RhSFRnaDJVdUJ0SW9tS0JJ?=
 =?utf-8?B?a3Y0cU84T0VObE9xZjloZ0Z3R2hwOW1ZTFB1c05iM2Y1a2l4V0k3TGxvcUdV?=
 =?utf-8?B?ZThEdHY3RlJudjIydytRQWxmMmtPSkRNMFdJamYzRXd3UjdLbVgwb1RCa3h4?=
 =?utf-8?B?c1pxaTl0TGtoMVBJWFFEMzgralN2Q1dEUGF2S3lJS1NMVU5mbk1KaWxqd3VP?=
 =?utf-8?B?cnIrWkoydmxvazMzUkJMQ0dUTm13empZMXN2NWlHVzRKOVhKdFN6MU1CRjNq?=
 =?utf-8?B?YW1nLy9hOHltaU85Ui9zQ1Fad1NRSERjUnB1bjlmU0NuaWNWaWllZ2VKTDF3?=
 =?utf-8?B?Uy9Cc0RRODhnVjhZdlcvOU5Bb3VWek5iaXExZkNSWXVRN1pkQ0tETGZLNVRM?=
 =?utf-8?B?L1V5TzRVYTZBMjZGUHQvbVo0NUVBNTk1eVZmTkw0aU9zaWMwcWhqS3ZscDd4?=
 =?utf-8?B?RWlBOFhKMVpTYnN5UUVLQ2VSbStsSWtpdms5Q0NOL2VISEdTSGxESytWS2JX?=
 =?utf-8?B?TmZpOXU5aHJzTWlpbDUwVEJudlBvZ2JpUmo0a0lSWGdSOGRnVkFuNk5zVHUx?=
 =?utf-8?B?blpML05VYnRxcDQrRFNwb1hJOENrbU9jSldZb096eEFiUDdJLzl6ZFc3NDFr?=
 =?utf-8?B?SG9sRGRqQzIvRFJJRStxYTJrZXZ4Z1lZUTRTdlVIc3huRjdJQlVqNkRVQlBt?=
 =?utf-8?B?Q1hGZ1VIMkdvK0JZakVzc3hiODJObXZ3WjVMOUUxVDNnK1hESGltd3JMV0h4?=
 =?utf-8?B?MzlxT3pkcWQrMXB2Ti9UZjhXWlpjcW0xcW9Za01XbVlCVmdtSHF6K01SR1hx?=
 =?utf-8?B?d3RVdERsT0s4VC9iaWlJVjJPNXA3U3kwaVpaRUg1akFhRWZmcDRLL0hZS1g1?=
 =?utf-8?Q?t6cUHnUcMnAKB6O+x5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a5e229-16e7-4623-5ea7-08df38cf28d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:50:50.5574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSpJl6BYle9UTxLtX3GOn9EiMN57+0jg5mvB+WUfs+p/Hx6wQmN+u5oR1M7oN4kM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

First of all please add Natalie and Arun on TTM patches, they are the maintainers of that component now.

On 11/2/26 11:18, Himal Prasad Ghimiray wrote:
> ttm_pool_alloc() always allocates on the pool's default node, although
> the internal TTM helpers (__ttm_pool_alloc(), ttm_pool_alloc_page(),
> ttm_pool_type_take()) already take a nid. Add ttm_pool_alloc_node() to
> let a driver pass that nid for a specific tt.
> 
> ttm_pool_alloc() passes NUMA_NO_NODE, keeping current behaviour. An
> explicit node on a dma_alloc pool returns -EOPNOTSUPP, as
> dma_alloc_attrs() can't honor it.

We already have an interface for NUMA node aware allocations in the TTM pool.

I don't mind changing/improving that when necessary, but that here is only adding a second path and therfore a clear NO-GO from my side.

If you want to change the nid from ttm_pool_init() to ttm_pool_alloc() then change all existing users.

Regards,
Christian.

> Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 59 +++++++++++++++++++++++++++++-----
>  include/drm/ttm/ttm_pool.h     |  2 ++
>  2 files changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 1bf37023fed6..54d2f6b5c229 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -158,9 +158,9 @@ static int ttm_pool_nid(struct ttm_pool *pool)
>  	return nid;
>  }
>  
> -/* Allocate pages of size 1 << order with the given gfp_flags */
> +/* Allocate pages of size 1 << order with the given gfp_flags on node @nid */
>  static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> -					unsigned int order)
> +					unsigned int order, int nid)
>  {
>  	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
>  	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
> @@ -189,7 +189,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>  	}
>  
>  	if (!ttm_pool_uses_dma_alloc(pool)) {
> -		p = alloc_pages_node(pool->nid, gfp_flags, order);
> +		p = alloc_pages_node(nid, gfp_flags, order);
>  		if (p) {
>  			p->private = order;
>  			mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1 << order);
> @@ -783,7 +783,8 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
>  static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  			    const struct ttm_operation_ctx *ctx,
>  			    struct ttm_pool_alloc_state *alloc,
> -			    struct ttm_pool_tt_restore *restore)
> +			    struct ttm_pool_tt_restore *restore,
> +			    int nid)
>  {
>  	enum ttm_caching page_caching;
>  	gfp_t gfp_flags = GFP_USER;
> @@ -818,7 +819,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		p = NULL;
>  		pt = ttm_pool_select_type(pool, page_caching, order);
>  		if (pt && allow_pools)
> -			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
> +			p = ttm_pool_type_take(pt, nid);
>  
>  		/*
>  		 * If that fails or previously failed, allocate from system.
> @@ -829,7 +830,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		if (!p) {
>  			page_caching = ttm_cached;
>  			allow_pools = false;
> -			p = ttm_pool_alloc_page(pool, gfp_flags, order);
> +			p = ttm_pool_alloc_page(pool, gfp_flags, order, nid);
>  		}
>  		/* If that fails, lower the order if possible and retry. */
>  		if (!p) {
> @@ -900,10 +901,52 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  
>  	ttm_pool_alloc_state_init(tt, &alloc);
>  
> -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL, ttm_pool_nid(pool));
>  }
>  EXPORT_SYMBOL(ttm_pool_alloc);
>  
> +/**
> + * ttm_pool_alloc_node - Fill a ttm_tt object, placing pages on a given node
> + *
> + * @pool: ttm_pool to use
> + * @tt: ttm_tt object to fill
> + * @ctx: operation context
> + * @nid: NUMA node id to allocate the backing system pages from, or
> + * NUMA_NO_NODE to use the pool's default node (@ttm_pool.nid)
> + *
> + * Like ttm_pool_alloc(), but allows the caller to override the NUMA node the
> + * backing system pages are allocated from. This only affects the
> + * non-coherent (non dma-alloc) allocation path; coherent/dma pools continue
> + * to use the device-local node. Intended for drivers that expose a
> + * user-selectable host memory NUMA placement.
> + *
> + * Returns: 0 on success, -EOPNOTSUPP if @nid is specified on a coherent/dma
> + * pool, negative error code otherwise.
> + */
> +int ttm_pool_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
> +			struct ttm_operation_ctx *ctx, int nid)
> +{
> +	struct ttm_pool_alloc_state alloc;
> +
> +	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> +		return -EINVAL;
> +
> +	/*
> +	 * Coherent/dma pools allocate via dma_alloc_attrs(), which places pages
> +	 * per device DMA constraints and cannot honor a caller-requested node.
> +	 */
> +	if (nid != NUMA_NO_NODE && ttm_pool_uses_dma_alloc(pool))
> +		return -EOPNOTSUPP;
> +
> +	if (nid == NUMA_NO_NODE)
> +		nid = ttm_pool_nid(pool);
> +
> +	ttm_pool_alloc_state_init(tt, &alloc);
> +
> +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL, nid);
> +}
> +EXPORT_SYMBOL(ttm_pool_alloc_node);
> +
>  /**
>   * ttm_pool_restore_and_alloc - Fill a ttm_tt, restoring previously backed-up
>   * content.
> @@ -964,7 +1007,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		}
>  	}
>  
> -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
> +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore, ttm_pool_nid(pool));
>  }
>  
>  /**
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e1994..6a0b14aca092 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -79,6 +79,8 @@ struct ttm_pool {
>  
>  int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		   struct ttm_operation_ctx *ctx);
> +int ttm_pool_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
> +			struct ttm_operation_ctx *ctx, int nid);
>  void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
>  
>  void ttm_pool_init(struct ttm_pool *pool, struct device *dev,

