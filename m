Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AD9CA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEC610F599;
	Thu,  1 Oct 2026 07:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="krhaS3cH";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC6310F588;
 Thu,  1 Oct 2026 07:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jly2eLCpsPs7NqIa+fyJaa8ECoIHXUvSLhDL7rjyknzyvPmulf/Wc4nKljO7pIlsAKEyU6scBb2QiGejIIhqo36OXIuV5S5kY/tYjXA4VmrEe2aTeUEU8SMer6mZzvBMQFa/V/6DN7vRy8OZJ3zkPJVhBn3EpB1bu+0uJiZcEUs0qgoJCJXEYyQbfxfmrQfXKqLNXCzBOO9M/3/ReblwZ9TQ9pdxNHXsacfGTP2Z0gUaanT6aY5ICXdV1UTOYQ1a+mUdJ2wZMJMAj1JK/wPPiYdSmIMhCn1fgsPpXdF6/jwkmhsB1RD1Q3LxM35N7qNV5ihWGkSGsuTAcokykQCRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B28Rx9qjJTF+t2XlztnyKuGIXN6faO8SmdEZpaozPs=;
 b=X0SqdDiJw1WtA01M/rEhcirI8jty4sy30DQ7sHt8eNo5XfJOGe8d3RS+YaN/hO4jRRh1uV76797kKeVMrIlEVrD4PZOi8P9UZmFUnr2yD25+JJ0/z4Y+mdfkckRlw3JIVmGMT4g3M4g86WksOjj4BxpWleIg+ZmWMg+cjcQS39ADl5pdfjXw5xQXWraumY9415s0ccg8PzADdBBnLAI7f6BaGLu4BSNP6isU+yNpKx+9iLO2r6o8X/a4XvEIPe4fdSV61op5e4C/HOtE0UsVRcGgqFPomlV0BzZbPZ2tLi8nYDUIo+mqmznwzpNESuDhEbxz7P4t5L1vwpxTy3w+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B28Rx9qjJTF+t2XlztnyKuGIXN6faO8SmdEZpaozPs=;
 b=krhaS3cHXtH8Tak1bPKhLQApjL3VAHvMBUkjMBVlvlIx3L/dlEgi6jIciXDBT5osNb0loO46ofZ/d4ievSvIIMftMGBVvCqo+AI6Cz7uZaaHkVO2UfTAoROWeirUEoSbmizcWw+TAf41ro3Z65L7bIRRXu/uOdRM7fQXBOcVzXc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 07:06:42 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 07:06:42 +0000
Message-ID: <f69f88dc-0003-4ffe-ab99-94f533894ad2@amd.com>
Date: Thu, 1 Oct 2026 12:36:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu/buddy: add range-restricted contiguous allocation
 fallback
To: matthew.auld@intel.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0248.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::19) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7bb957-581a-4212-5768-08df1f8a8b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: m0YGUP6lGBYFrnj/Wb8pNn84PnkpGKt+16qPZzbpk8jfA7BAofD/XOpeqGmoO7FOWEzdqfXTsQh0hK00TGvNkEOhvON/1OVTj7gucjle97O9QhD7IEkaP8aoKsA2hga0h395rRxIkBAAhxO6SRmuiWq9pjAnQZR4zNAxb/CcT8Hzp+DwgVNDQFw1O/oWyxJPFI7McJoQpPVNUyike4f6h5X6+EBJ0lqj3io8QeSxx+WOgJl7NUMQO1NRU3Lxcg29MgiyblRxMH5o6bjIAtsK45JU+t4CNDU01q/AFTP3IlAfZN0dMrp7AaVr92VLKVt9sRU0ylo0inTBovh8ux51ev5sPeAgWr/J78tdD9rnEGILLE6yN5u2w1K35bc6G02vnr3Vx6+yJ8sugrqSmif5HsJc74z/R4zqNhvxcdwsEks45yzPidJMVdfroS4oejgusq/31aVQnScGKnfxmhIzMM/N1Y3LEVUk5E8OpgxZTZSLtNm6jLXQ9Mndo+Q/9P73CUZPN9+tUoIl31qsIjoD1Fq+mXBPHVbWd8eNqgesYQ81AzY7ybqyL4gXeRB6vzYrYB4M+RMGNuBFqnwHgmQ8N0qwpZTPLug19mNP0zEZUjvvbrJSTtf8j9vTIk/QOAZY9jNJK/LTyujOIRaXX0GUhDKrg+/PFkzRytRXNKA/PwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFSaHQ0aDBuVEpVYkZmcmNoRmJlZVNvenZQdmJkaWh0MUttM1JsSlM1TUhy?=
 =?utf-8?B?Y2lSRGorUU9GZnBaQmczdXVuSG5URG84T2phNFErUzRONmlEckExZnVIbDhR?=
 =?utf-8?B?dUZBeWYzVy9BaUNESitIcWRqZ3lFL2Roa3JueVE0eDEveHdrMW94VHdydWpw?=
 =?utf-8?B?cjFSU0hDajNzRHRhdGtBMnA1RUgzNjdkZCsyTWVmM2xxcU1Qd2lJV01RNWMz?=
 =?utf-8?B?VWlJVzZGWTN6RTBRa3BsMldwS3BYWXB6R3pISHpSQmg0K09HVnRtK0tlMGFW?=
 =?utf-8?B?cmdyY0FzU01RWGtUS0dQWGdqYjhqTUN4UjNJeHJCMytxQmFraGcwcG9DYTln?=
 =?utf-8?B?V25xclVUaXMvTmlib0RLSUJnWE1qSDVxb1VYMEs3RjAxNk5MY1U1K2lwMXRi?=
 =?utf-8?B?SFVwL09mWXhwekhZUzFaTmlyTWpMaUV3K3ZxbmszMHM2bDBObmZxeDhWTUtC?=
 =?utf-8?B?MEM4bGtxdlZnYW9aUmp0L0dnQkFpcnE2Z1U4aXdXRHlaWlJiWXByYXdNNkpT?=
 =?utf-8?B?OXRMcktySGlYQmppZGt1dE1HMmp4NEpBNS85TWtuU3BxNTlCd2s2bm1OeHFx?=
 =?utf-8?B?UmdrUFFhWmZsbnBNT0M1T3ZZeGhlcTFXSklLUmd4MmMxeitLYkhYbmVpSkc2?=
 =?utf-8?B?bHQ0RU1ybXR6Mnc2QkZ2am9TaytNVUlHQys5cUZHdlQrNEVhTFBOTTJLWHp3?=
 =?utf-8?B?d3VxeGhxakpCeWt0d0FMNWd5MDZBeUlESVJDSG55L1ZGRjEvRnk3YnNic2JF?=
 =?utf-8?B?Um50M2lpRUpKb3ZBQ0VvV1g0eFhQdytGT1RNNnc1OFdXcXFNQjF3STMxcmIz?=
 =?utf-8?B?QkVHQWk3cU9tQ0w4RmNTZmxBZDBTSndlWUQ3d3BiMXdvSjlua3lJN2dkcG9F?=
 =?utf-8?B?MVFEVGtVVG5OV1JJYjczMTZ3SmUyaHE5c0ZzbG5hVlg4aWE1aG9uSzVKSENR?=
 =?utf-8?B?RWo4TC94V2dGVkNVSnVZQTUrcnlzQXIvNDc4c2xsNUE3YTNaMEpubXlzMEVH?=
 =?utf-8?B?dW9kQnlNRkxVUDBhOVh6cWI1cHRhMTV3SWdkV1QzeEg1UlhXYWRUSXU0amlx?=
 =?utf-8?B?RE14L2hsUEdwVk5BWFRqZEovUDZVYlI2STdQS29CUXZ2d2VYU1d2VVRMSHYy?=
 =?utf-8?B?YjhnNmhQMktLR2N5bGN4VFVDRk5USThXbkNFUTExR2kvTHFBOGo0SXl0VWhs?=
 =?utf-8?B?VlBaRnpUTlVHVk42clJnZ3pGaU9CMVNLeklIOHR3RHNaemVyVUNHNWN6RW55?=
 =?utf-8?B?ajdmVFJhRjl0eUhqTEZtUmxDdlRMU1FieUx6M1J6clJjNFUyQnRHbHJYV2RR?=
 =?utf-8?B?VEtzeE5UT3ZkTWhrUFRMeUd6ck1OY0k5QSsxeHRRV2pYTG5oZitxbzZUQ0pT?=
 =?utf-8?B?dWlyTEMvU29qWGVZUHRieHR6TXZQdmNsdmRKbTFFMTc1UisrUnlGNkpiS1dJ?=
 =?utf-8?B?emFwL2NTZEZQVDlobjVJWGFqWlFEK1ZqRlpmeURSTnlGQitqRHVZd3V6RU96?=
 =?utf-8?B?WXcyN2p5UHdmcFVUalRpaHZHdStBZXFvdVJENkdRY3VBcEV1ck80Mlo2RWVi?=
 =?utf-8?B?WVlzS1c0bFBEYnBWdDBubmw5dlVJNmp4ZWdnM0NXZEJUNU5MUXhSL09rNkl1?=
 =?utf-8?B?NDc3cTR6YnJYSmlvRE5oZFNUMXd6bzZNdEZYWGtEMndqTDZoU0FQc0diUnQ2?=
 =?utf-8?B?YUtEQlhMMEVDM1ptR1FHNXlkNFpIKzVTdVlxMGt0M08wdTNGUHE4blAzQ1Rq?=
 =?utf-8?B?clEySktOc3hmQjFmUWtPT3ZSSU1XOUtXa0RSSFlMZVQzUWNFcEF5eVF1bVdy?=
 =?utf-8?B?L2REdlpQTkdqTXp5bWJXK1NmenJLdFlDdUdLQmNoL3hMWVhUR1BvZkZ3MDhn?=
 =?utf-8?B?dSszVHhpVEpGV1RLQkRnakNqNG9BRE11WFBOdFZJdktvZTJtVGRDbTMxdlo2?=
 =?utf-8?B?M3VwNzNTcDRwRlRUVjVwMFlBREZBbkdEVHV5TTJrRGZWUGVCbSs1UTJPTkpG?=
 =?utf-8?B?Ry9TbVloNTVJSE5lRmtzRmJNaTQrV0xYQ0UrSlhkRk90Rkk3azI5TFIyQXR1?=
 =?utf-8?B?VGFheEdEQ1hSelVEOTlzM0ExRVREbDBINzNGNmJXc0FNNEs2ZlhoOGZtbVd3?=
 =?utf-8?B?L2g0U0xFZXZCcDFpMnI5QTAzaERlYlJpQU1YQ1FUM2lTTWVacDEwNFFLc1pV?=
 =?utf-8?B?NDRkb2hiY2IreTJudUZBS0trd2lWc3ZCQTNFLzNESmg3N01sK2x4ekwrc09q?=
 =?utf-8?B?MzhUM040UmdaVk5WUU9CZlltaDUrbEdmbW1kK0JRcUlOeXZIZ3NjbXVZaHdq?=
 =?utf-8?B?MytmbDZsS3QyUklPSDlXUmMrUURTMUJrZHFkTEdrV1VkMGNKWVNEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7bb957-581a-4212-5768-08df1f8a8b9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:06:42.1384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr7YnuQcUa76JgK2V1BcEn9JxPfCsq/NmFwo7YGIjClzHwW23HpmIng0LkvDhp90XsvcmQgrlukfde6kzMB0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886
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

Hi Matthew,
Could you please review this patch.

Thanks,
Arun.

On 9/30/2026 11:51 AM, Arunpravin Paneer Selvam wrote:
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> A range + contiguous allocation (e.g. a scanout FB confined to the
> CPU-visible VRAM aperture) rounds its size up to a power of two and
> requires a naturally aligned free block of that size; on a fragmented
> aperture no such aligned block may exist even though enough contiguous
> space is free, so the allocation fails with -ENOSPC.
>
> The non-range contiguous path already recovers from this via
> __alloc_contig_try_harder(), which stitches an exact-size span from
> smaller adjacent blocks, but that fallback was unreachable once
> GPU_BUDDY_RANGE_ALLOCATION was set. Give __alloc_contig_try_harder()
> a [range_start, range_end) window and route the range + contiguous
> case through it: each candidate placement is confined to the window
> and aligned to min_block_size. Non-range callers pass [0, mm->size),
> where the guards are no-ops, so the existing behaviour is unchanged.
> A KUnit regression test covers the fragmentation pattern.
>
> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
> regression.
>
> v2:
>   - Drop the split-undo patch; the range-bias search always descends to
>     an exact-order block or fails the split (already handled), so the
>     extra undo was redundant. (Matthew)
>   - Verified this fallback alone fixes the kms_plane regression.
>
> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
> Assisted-by: Claude:claude-opus-4-8
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/buddy.c                | 88 ++++++++++++++++--------------
>   drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++++--
>   2 files changed, 126 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe35..5265e1f6a318 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1685,26 +1685,14 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
>   			     blocks, total_allocated_on_err);
>   }
>   
> -static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
> -					u64 unaligned_offset,
> -					u64 size,
> -					u64 min_block_size,
> -					unsigned long flags,
> -					struct list_head *blocks)
> -{
> -	u64 aligned_offset = round_down(unaligned_offset, min_block_size);
> -
> -	return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
> -				       NULL, blocks);
> -}
> -
>   static int __alloc_contig_try_harder(struct gpu_buddy *mm,
> +				     u64 range_start, u64 range_end,
>   				     u64 size,
>   				     u64 min_block_size,
>   				     unsigned long flags,
>   				     struct list_head *blocks)
>   {
> -	u64 rhs_offset, lhs_offset, filled;
> +	u64 rhs_offset, lhs_offset, filled, aligned;
>   	struct gpu_buddy_block *block;
>   	struct rb_root *root;
>   	struct rb_node *iter;
> @@ -1734,20 +1722,24 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>   					       flags, &filled, blocks);
>   		if (err && err != -ENOSPC)
>   			return err;
> -		if (!err && IS_ALIGNED(rhs_offset, min_block_size))
> +		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
> +		    rhs_offset >= range_start && rhs_offset + size <= range_end)
>   			return 0;
>   		if (!err) {
>   			/* Allocate the unaligned RHS offset using round_down */
>   			gpu_buddy_free_list_internal(mm, blocks);
> -			err = __alloc_contig_aligned_retry(mm, rhs_offset,
> -							   size,
> -							   min_block_size,
> -							   flags, blocks);
> -			if (!err)
> -				return 0;
> -			if (err != -ENOSPC) {
> -				gpu_buddy_free_list_internal(mm, blocks);
> -				return err;
> +
> +			aligned = round_down(rhs_offset, min_block_size);
> +			if (aligned >= range_start &&
> +			    aligned + size <= range_end) {
> +				err = __gpu_buddy_alloc_range(mm, aligned, size,
> +							      flags, NULL, blocks);
> +				if (!err)
> +					return 0;
> +				if (err != -ENOSPC) {
> +					gpu_buddy_free_list_internal(mm, blocks);
> +					return err;
> +				}
>   			}
>   			goto next;
>   		}
> @@ -1759,15 +1751,17 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>   
>   		/* Allocate the unaligned LHS offset using round_down */
>   		gpu_buddy_free_list_internal(mm, blocks);
> -		err = __alloc_contig_aligned_retry(mm, lhs_offset,
> -						   size,
> -						   min_block_size,
> -						   flags, blocks);
> -		if (!err)
> -			return 0;
> -		if (err != -ENOSPC) {
> -			gpu_buddy_free_list_internal(mm, blocks);
> -			return err;
> +
> +		aligned = round_down(lhs_offset, min_block_size);
> +		if (aligned >= range_start && aligned + size <= range_end) {
> +			err = __gpu_buddy_alloc_range(mm, aligned, size,
> +						      flags, NULL, blocks);
> +			if (!err)
> +				return 0;
> +			if (err != -ENOSPC) {
> +				gpu_buddy_free_list_internal(mm, blocks);
> +				return err;
> +			}
>   		}
>   next:
>   		gpu_buddy_free_list_internal(mm, blocks);
> @@ -2021,11 +2015,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>   
>   	if (order > mm->max_order || size > mm->size) {
> -		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
> -		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
> -			return __alloc_contig_try_harder(mm, original_size,
> +		if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> +			u64 range_start, range_end;
> +
> +			range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
> +			range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
> +
> +			return __alloc_contig_try_harder(mm, range_start,
> +							 range_end,
> +							 original_size,
>   							 original_min_size,
>   							 flags, blocks);
> +		}
>   
>   		return -EINVAL;
>   	}
> @@ -2058,9 +2059,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   			 * Try contiguous block allocation through
>   			 * try harder method.
>   			 */
> -			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
> -			    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
> -				err = __alloc_contig_try_harder(mm,
> +			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> +				u64 range_start, range_end;
> +
> +				range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
> +				range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
> +
> +				err = __alloc_contig_try_harder(mm, range_start,
> +								range_end,
>   								original_size,
>   								original_min_size,
>   								flags,
> @@ -2068,9 +2074,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   				if (!err)
>   					return 0;
>   				if (err != -ENOSPC)
> -					return err;
> -				goto err_free;
> +					goto err_free;
>   			}
> +
>   			err = -ENOSPC;
>   			goto err_free;
>   		} while (1);
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index b75d32ca6ca0..2c445870b808 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1251,6 +1251,77 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
>   	gpu_buddy_fini(&mm);
>   }
>   
> +static void gpu_test_buddy_alloc_range_contiguous(struct kunit *test)
> +{
> +	const unsigned long ps = SZ_4K, mm_size = 16 * ps;
> +	const unsigned long range_end = 8 * ps;
> +	struct gpu_buddy_block *block, *prev;
> +	LIST_HEAD(allocated);
> +	struct gpu_buddy mm;
> +	LIST_HEAD(pin_lo);
> +	LIST_HEAD(pin_hi);
> +	u64 total;
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
> +			       "buddy_init failed\n");
> +
> +	/*
> +	 * Idea is to confine the test to the sub-range [0, 32K), which a 12K
> +	 * contiguous request (rounded up to 16K) splits into two naturally
> +	 * aligned 16K slots: [0, 16K) and [16K, 32K). We pin the first 4K page
> +	 * of each slot ([0, 4K) and [16K, 20K)) so that neither aligned slot
> +	 * can satisfy the rounded-up 16K allocation, yet the freed remainder
> +	 * still leaves a contiguous 12K hole at offset 4K, which is page-aligned
> +	 * but not 16K-aligned. A 12K contiguous+range allocation must therefore
> +	 * fall back to stitching that span instead of returning -ENOSPC.
> +	 */
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
> +						      &pin_lo, 0),
> +			       "failed to pin low page\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
> +						      ps, &pin_hi, 0),
> +			       "failed to pin high page\n");
> +
> +	/* No aligned 16K block is free; the range-aware fallback must stitch
> +	 * the unaligned [ps, 4*ps) hole instead of returning -ENOSPC.
> +	 */
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, range_end, 3 * ps,
> +						      ps, &allocated,
> +						      GPU_BUDDY_CONTIGUOUS_ALLOCATION |
> +						      GPU_BUDDY_RANGE_ALLOCATION),
> +			       "range-restricted contiguous alloc failed\n");
> +
> +	/* The result must be exactly 3*ps, contiguous, and inside the range. */
> +	total = 0;
> +	prev = NULL;
> +	list_for_each_entry(block, &allocated, link) {
> +		u64 offset = gpu_buddy_block_offset(block);
> +		u64 bsize = gpu_buddy_block_size(&mm, block);
> +
> +		KUNIT_EXPECT_TRUE_MSG(test, offset + bsize <= range_end,
> +				      "block [%llx, %llx) outside range\n",
> +				      offset, offset + bsize);
> +		if (prev)
> +			KUNIT_EXPECT_EQ_MSG(test,
> +					    gpu_buddy_block_offset(prev) +
> +					    gpu_buddy_block_size(&mm, prev),
> +					    offset,
> +					    "block at %llx not contiguous\n",
> +					    offset);
> +		prev = block;
> +		total += bsize;
> +	}
> +	KUNIT_EXPECT_EQ(test, total, 3 * ps);
> +
> +	gpu_buddy_free_list(&mm, &allocated, 0);
> +	gpu_buddy_free_list(&mm, &pin_lo, 0);
> +	gpu_buddy_free_list(&mm, &pin_hi, 0);
> +	gpu_buddy_fini(&mm);
> +}
> +
>   static void gpu_test_buddy_alloc_pathological(struct kunit *test)
>   {
>   	u64 mm_size, size, start = 0;
> @@ -1534,10 +1605,13 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>   				     GPU_BUDDY_RANGE_ALLOCATION);
>   	KUNIT_EXPECT_EQ(test, err, -EINVAL);
>   
> -	/* CONTIGUOUS + RANGE should return -EINVAL (no try_harder for RANGE) */
> -	err = gpu_buddy_alloc_blocks(&mm, 0, mm_size, size, SZ_4K, &blocks,
> -				     GPU_BUDDY_CONTIGUOUS_ALLOCATION | GPU_BUDDY_RANGE_ALLOCATION);
> -	KUNIT_EXPECT_EQ(test, err, -EINVAL);
> +	/* CONTIGUOUS + RANGE should succeed via the range-aware try_harder */
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size, size,
> +							    SZ_4K, &blocks,
> +							    GPU_BUDDY_CONTIGUOUS_ALLOCATION |
> +							    GPU_BUDDY_RANGE_ALLOCATION),
> +			       "range contiguous alloc hit an error size=%llu\n", size);
> +	gpu_buddy_free_list(&mm, &blocks, 0);
>   
>   	gpu_buddy_fini(&mm);
>   }
> @@ -1603,6 +1677,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>   	KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
>   	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
>   	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
> +	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
>   	KUNIT_CASE(gpu_test_buddy_alloc_clear),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>
> base-commit: 744f262401cc2e1f3827496c72a47e072d31a852

