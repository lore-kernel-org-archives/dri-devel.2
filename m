Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB62CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F7B10E722;
	Tue, 13 Oct 2026 04:49:08 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620FF10E719;
 Tue, 13 Oct 2026 04:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNSwl3KVp6NsaKL2pxvwjl2LAHak1NLUTVJPItIe3Dni2TjabXN/ayWw0pWuRQ+Bdw/nnVtUn9a7Owg3cKVPgWocXc224vQ5cMckWMgLg6X7/dRiMWe009nk6G3S24qP0q8FSIHDfXyEegc9TO8ImPEbU73/K3930YA2vbx+fTzsbYUcIpiae1SN6vsF5K73ZmH6ZeF+HVu8oOZieRAFBuVTS05QgvAyi2+P9rQgII0Nl+Lme0h0oeYdzmEpbN6BTcaZ5Sw/pvK4zWyNSWUAcsOb1PKJvcoHfWUU2xMrhiXGyXMjxIcP0TcpwoFcRriNk0R7zzY+oTUXkVQVQ7//Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5aHT2zgNAcdIyoZTpPdh2LoaPu5RpSqUGGZBdzSvsE=;
 b=myT4Y53G1ztXlyZfH5aRz0a8THt0Hgf21+Vt2kIaX/LA5zZ0ZoaJAFwmd740YXGSsB3J/Z+mhjXzTDE75vF3a4GiPJVcXNbJqWjJfOCbclwhVRT8dV0WGO8CWwjORnoEpsliqG0qrAxYKRuokRd95gn4GRaVxS61NyGUVbQKcc5EYzQEBSr8cN9uvZOV2JKtXXD2t5x5SzQffcd6RkmYGEkIQgl2ouQDfNG8zFZ8Y0okO2jY8FCHMj+/VDhe6ngEFzXmXTfzp96v7sgkLY9TUGqSJH2bQx7HDGSuS0Qv0ORSWP5msAEejFIHD4MXa/4G6vFgXqU0ykwBHumGmgQbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5aHT2zgNAcdIyoZTpPdh2LoaPu5RpSqUGGZBdzSvsE=;
 b=AtRHqv94taibztIU1pX3R5lSYhkiQrQ4yqdomO1w8rJa9zN3pys/GMRWqUKpGRicinRXbdTmrFQF+UJ2J7yT4hp4DgZ8P+KMDN9KHjgsRFAfFTc4gRw+dFChhYp3NvUV+gE1Wbu+czzErR/839SjMoZO7wVCG7Saq5zLwx5arY4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 04:48:58 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 04:48:57 +0000
Message-ID: <808d1a18-9bcb-43a9-bc15-723d84395d05@amd.com>
Date: Tue, 13 Oct 2026 10:18:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu/buddy: Prune exhausted subtrees in range-biased
 allocation
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <cover.1791802549.git.sanjay.kumar.yadav@intel.com>
 <ef9c4d0b6368b736ce639cfe6258f43b0ab6ca10.1791802549.git.sanjay.kumar.yadav@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <ef9c4d0b6368b736ce639cfe6258f43b0ab6ca10.1791802549.git.sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::9) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: b83c7772-30ee-4a9b-65ca-08df28e54a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261009223027099003|56012099006|5023799004|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9Qt5iL9wPq3jkuQASvEfWijYHSMadZTpg+Rms3bPxGr1mLlglQP6H/VLYj4W9PAxsknHP8X4kHHPitlgDNFqRK3W4kT6CO+vb2YEkeS1jGiZmJpBtgIaV0pFum+kEr3CvLrQv6eiGtwsTICuXzEDLzYh3BYhpe39aBFJD65R4Mg38ynXruGgLBsUdXfb/I0fGBwkhm8y61pylJmBfz+gn7HyYI6t6HhEfSmNCJVqYyFWGye/HuWSgMUEwwGK5doOtC4idt2fY0/gvVLtwXb4WZNKVHNSBzXITh1lt43kR+wtxaa34Fn9HjUJjXIVMkMMJq3k6b59kpnZdfGi1RZwaLaIq5Paqgpl1y0jInDYgL9gkOu8R/Aexq7fvosPsAlpl5r//pPbkUSN8r7SHzT27+pFTxXhAItYFdOTmtZPbipMDq02vFzvBnowmCRlrlFyDq+/bIlrD6+Yoa6N5shhl7FoymiUgsVnOvSOZNeVlZiQMM9h4eb/40enHtrfI9VvdhlB9hdPkLIDJNhjR+7hflre13LevcL0W58jF/so/I+2NY2gR97+8JdSO36qHQe+O4Q+UEmTzzDlBkhNKMwmiwiz31r/r8iFeknCWrL2LAUVwfoc7P1U7xPvEFGsJiW46A8kVf6c9v0MM/Za6ljhMJdqaIEMXHk6ujkU1W8YeNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjF1NVdjMjB4T01DaTdIQkowMXlWdkd5TXlDb1l2bWRHNEQzby9KTENpVmpm?=
 =?utf-8?B?OGVqOHdueTVNYXBFRC84akxMTmgvTkh2a0VEdHhmV1JPQnVLZzZDdThUTlNG?=
 =?utf-8?B?TUU5NElLeDRmQ0RJQllXWWtYVG93dmtreTc3Rnh4aTJuRWlyQzF2VTVtZWsz?=
 =?utf-8?B?bmdtWE11NEpZN2hqVnM2N2ZYVUFEOWlKZ0tVeTUzZHc4UkRFODZGSEVSSVpq?=
 =?utf-8?B?RVVUdDVScEIrakc4dXloQUZqNktZMS9tWUJmV09LV3VjZG5obVlMenZwK2d3?=
 =?utf-8?B?UlNSQndISlZabzJ5SytxRC8yRWNxc0hNTjlIL0dTeU02dHFjcm9LckJNQnh1?=
 =?utf-8?B?dXorejM5UkJacGlSemgxbUtmSWgyQTh2QUE2azE5b2pqMkkrUnJTdmdLQ1JH?=
 =?utf-8?B?L1huWE9WQ0x1UlFHamFvWkdqaWl5Y04xQUFva2c5bUpFS1RxNUZVeldSeUUx?=
 =?utf-8?B?bEZDd2duQlhCYnEwczY3MEpITTNSZFREZFZDTjNaRmFDMFd2aWMyRDR5MkhY?=
 =?utf-8?B?c1I2RjBITXpyQjZ6T0xtVjE4UWY3VDJWeWdHeFlJVjdZcE1kREZibU03MXpK?=
 =?utf-8?B?ZVY1MC9mV3hOMnprNlpGSEVrdW1SNW4zcnpRVkRzRDhIR2h1eHZXYkNxM1hD?=
 =?utf-8?B?OEJ2TmpzeXk1U29VWXhvcEZPZU1VMzhoT3lCMXhJRGhTRmliRnpZM2ErYytX?=
 =?utf-8?B?TXNrQ0JSMlpjZGdaVTdhL2ZtdmVxZ1B2M3JFOVRacCsvUHlDRUtHNnE5ckZl?=
 =?utf-8?B?VDNEcGpQOUh1eWdwaW9QZGg2Wk5NR2p6cmlWWU9hRFFJczlsdzQwUVZwQ2NO?=
 =?utf-8?B?UDQzb05uMDBnOGdna2dlYjFma2FTd28reG56UmlXVndBTDkzWkUxVFB1UFBp?=
 =?utf-8?B?U2VWRnJNZFM1RGRSYnZTR1RyQlhpOVI2MHc1RzA3OGsxYVd5YmZ1YUU4QWht?=
 =?utf-8?B?S3JqQXV6R1Z5ZTV5MWY5NmtTWkdxWXZ1RHBGWm1XazRVNTJYYWl0b0JWMXB1?=
 =?utf-8?B?cjBDOFZtYmdKeERONHdiemt0Rk1HclNhRGhLeSs5S2pNUWtPQ3dFdkRhNWp3?=
 =?utf-8?B?WEZPWVNrSnZ1MzZnN2swS1l2M3J2Ym5OQlFqWU0xQUJaZmNzWGJ2UDFqeFBC?=
 =?utf-8?B?Y0Y4TFpzK1ExRmhnZTdVWXN2NjZkRGI4c2xacytTd1dnMXkxR2FhaVIrY2R4?=
 =?utf-8?B?Y3FLWnhGWTFSVkRweW12a2FWN2VHc2ZsUFZ0dTlTSHJjV0FUL0xDMHFSeXhY?=
 =?utf-8?B?NjFlMHpvTjR1bmx1My8vdWhkbU9JaGZOU2d4QzN0OUc3UkdiMlp1UXk5WEpN?=
 =?utf-8?B?MzZOa0JFa0FjY2cwVHNWeCs5QVdPaXJDWDNJSTVuVlcvZVNuOTU0Z3hzTGVQ?=
 =?utf-8?B?OWVnVnczTnVFVmt1QlV1VWxpOTB6THB6NVNVd2xPak16c2R3enVsREk3a3lj?=
 =?utf-8?B?TnpWWnhxbEl6c2laRGFsMCt3NFREUitPNTBGcEJUaTN1MUlwUU5DWXFUVE52?=
 =?utf-8?B?U0tBSm5HRHkram5WRVZpOVdlK1E0Qnd5U3VZS3FvKzE1bHR4QXZIb1pqaWxI?=
 =?utf-8?B?NXd0R09KQm1ZYlpEYlJLdE9jZGR4SGRES0VwNlRDaHZleDNNYzNZQ0xoWWRE?=
 =?utf-8?B?RzVMSVhZR3pTdE53ODJocm5lbkhWYmJUa3lieGVYbGZCWm9lcGJ4akc3SnIw?=
 =?utf-8?B?WEdaWUVxV3Y3eVF4NHFNaElWUVBhd2FuZ05LcjR1U2hDNUt3N09XWU5RVHRZ?=
 =?utf-8?B?N092TzkxdW9BaE8yeisyeXZtVmM3bFhQbEpRcGJ1NDZGeWZEaDAvbTBURkdy?=
 =?utf-8?B?MHpyQXBnVElKTzQwMVdGTkRHUE9jbWQxQ2ZZK2dpZFpieXVUMUVqRlFZT05l?=
 =?utf-8?B?Z2R2eGhPL2x3Q2NYbEFoS0VNTnhXZ0xiRXZWSHg1RzQrYUlQT3FCeTE4MVRP?=
 =?utf-8?B?R2dWZEtSUUxTdzdzTWsxT1h5bGplUktmRytzaEgxczhRQXJhUW1ITEFmSU1F?=
 =?utf-8?B?ZjJGK0NJaWxMTlQrL0o3bytvYWw0emZOdkphUXpIU2hkL1FwU1V1YkJvNFln?=
 =?utf-8?B?N1BvakV0SXVQL2NPREVuMGhNdGx4Um5Ua0RpdG9QV2k2ZDFYb1FDT2RuSkFa?=
 =?utf-8?B?blR6UWZJOW90UCt4dmN4dXowOHNTczdlK0Z1Uldkaytva2FQUVFudjV4TzVF?=
 =?utf-8?B?N3JkbmJyWlAvbmkrUWFna0o4aXBPcnpuY2tGVU9yK3ViS2NJcTY2d1RGVzRi?=
 =?utf-8?B?ejBzUGpCZzdLUlJWdjFLUmE5WkVzZ2cyYSs0R2FnSzBMOElCRXhqQU80Q3A3?=
 =?utf-8?B?amdYRUZ6ZFZ5cndNVWU4UE10MDRaTTQrRW96VEJET041U2ViWlVyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83c7772-30ee-4a9b-65ca-08df28e54a95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 04:48:57.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgdEPzCFni7R/k7PGNDss702jh0+PJDYvOKS+axw7r+PyETQiZUtzJ1KJJdusNH+n/+PEnQ96JxqAp0dQx/P3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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



On 10/12/2026 4:40 PM, Sanjay Yadav wrote:
> __alloc_range_bias() walks the buddy tree depth-first, higher address
> first, and descends every SPLIT block even when nothing below it is
> free. Range allocations are placed top-down, so they pack below the
> range end and each new one walks every block already allocated there:
> O(N) per allocation and O(N^2) for N allocations, under the allocator
> lock.
>
> Track in each block the largest order of any FREE block in its subtree
> (GPU_BUDDY_NO_FREE_ORDER if none), update it whenever a block changes
> state, and skip subtrees that cannot satisfy the requested order.
> gpu_buddy_block_trim() detaches the block while re-allocating inside
> it, so recompute from the parent once it is reattached.
>
> Skipped subtrees contain no FREE block of the requested order or
> larger, so the old walk could neither split nor return anything there.
> The remaining blocks are visited in the same order, so the selected
> block and placement are unchanged.
>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>   drivers/gpu/buddy.c       | 31 +++++++++++++++++++++++++++++++
>   include/linux/gpu_buddy.h |  7 +++++++
>   2 files changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe35..7a975873238f 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -602,6 +602,7 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>   	block->header = offset;
>   	block->header |= order;
>   	block->parent = parent;
> +	block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>   
>   	RB_CLEAR_NODE(&block->rb);
>   
> @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>   	RB_CLEAR_NODE(&block->rb);
>   }
>   
> +static void update_subtree_max_free_order(struct gpu_buddy_block *block)
> +{
> +	while (block) {
> +		s8 max_free;
> +
> +		if (gpu_buddy_block_is_free(block))
> +			max_free = gpu_buddy_block_order(block);
> +		else if (gpu_buddy_block_is_split(block))
> +			max_free = max(block->left->subtree_max_free_order,
> +				       block->right->subtree_max_free_order);
> +		else
> +			max_free = GPU_BUDDY_NO_FREE_ORDER;
> +
> +		if (block->subtree_max_free_order == max_free)
> +			break;
> +
> +		block->subtree_max_free_order = max_free;
> +		block = block->parent;
> +	}
> +}
> +
>   static void mark_allocated(struct gpu_buddy *mm,
>   			   struct gpu_buddy_block *block)
>   {
> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>   	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_remove(mm, block);
> +	update_subtree_max_free_order(block);
>   }
>   
>   static void __mark_free(struct gpu_buddy *mm,
> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>   	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_insert(mm, block);
> +	update_subtree_max_free_order(block);
>   }
>   
>   static void mark_free(struct gpu_buddy *mm,
> @@ -772,6 +796,7 @@ static void mark_split(struct gpu_buddy *mm,
>   	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>   
>   	rbtree_remove(mm, block);
> +	update_subtree_max_free_order(block);
>   }
Just wondering if touching mark_free(), mark_allocated(), mark_split() 
which are hot-path functions, could have any performance implications.?

Regards,
Arun.
>   
>   static inline bool overlaps(u64 s1, u64 e1, u64 s2, u64 e2)
> @@ -869,6 +894,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   
>   	size = round_down(size, chunk_size);
>   
> +	BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
> +
>   	mm->size = size;
>   	mm->avail = size;
>   	mm->chunk_size = chunk_size;
> @@ -1280,6 +1307,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   		if (gpu_buddy_block_order(block) < order)
>   			continue;
>   
> +		if (block->subtree_max_free_order < (int)order)
> +			continue;
> +
>   		block_start = gpu_buddy_block_offset(block);
>   		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
>   
> @@ -1881,6 +1911,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   	}
>   
>   	block->parent = parent;
> +	update_subtree_max_free_order(parent);
>   	return err;
>   }
>   EXPORT_SYMBOL(gpu_buddy_block_trim);
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index ddc4eca84175..8037f5a0feb1 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>   	unsigned int subtree_max_alignment;
>   	struct list_head tmp_link;
>   	bool has_clear;
> +	/*
> +	 * Largest order of any FREE block in this block's buddy subtree, or
> +	 * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
> +	 */
> +	s8 subtree_max_free_order;
>   };
>   
> +#define GPU_BUDDY_NO_FREE_ORDER (-1)
> +
>   /* Order-zero must be at least SZ_4K */
>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>   

