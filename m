Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D33CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A73110F545;
	Fri, 22 May 2026 10:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gxvC73P7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5044D10E253;
 Fri, 22 May 2026 10:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYFRx27CWF4t8p5rIPfecbsRbRwYadoT2/98r70RwNak3WQZFBM+VGh1T+IUYc6MTC8etDvL+a2BCqztY0VXfJLjaANhEhZAESKhQz9NZDoudjPbZXTvrfYbeHk6otGkO2vdNdvvcRLSkn4pjHqSEjowGp+skHLGeUe7Yt4416RKCTOgcYUq/3b6TfqMXVQNrDUr239C1NDtYppAVNjsv7NOgXg+pa2l2w7YiJnJAJIuJNmWU5GOFc48OViQU8SlOYiR6JK4iWA1Qg87zeJX8UkLMl5tlY9oezVvIMqnZr2jgVtAbWrjBtYsg3hNUQctNuQmxhjLh6lbIw/oDj1/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2LDdGx7/H5VUWnC9dhT8P3gzrSAaFQ4rADcgajzWtE=;
 b=god176xVDZgWp7T8DU5yqjxb8X/cbNlZvg38KiwFojyD8xsc5ACjorslTrd8k1ZDgURYhrdy6n4YLXYE/RxsJE3TnOhH5CA0tVmJl+y/wg43RuucusmcU+q04tVjn5JM+sY+KiRiujy/GK6ZSOTVjZqicS7nmEqk1NyT0/MIXJOmnf7wDn+GEUVb+alHDQGRaSWwaQuqO3q3h0v/GkkfBG+1WqUDmk90sohK4zL0RgXMBYOtk7BslJOgqMAKAEDwYposxAD0SuOvsGy8xm+t0LnV9ljXN295K8TsS3+SrGdj2HeMg41j3+UJBvIG4+t8UmFJHgdhSxTZWagd2sbHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2LDdGx7/H5VUWnC9dhT8P3gzrSAaFQ4rADcgajzWtE=;
 b=gxvC73P7Gng+cCUIUuI6Rp4mLygTxtUkoBjaVwJiUt5pqAzy+MapBqHvvnJqD8N/AeELbN4sLGUMfbREE6qC8ITDyK+62z75fXK5f0KCUfJkHVVvY1h7VZAB55TEOFi6YxXa8nmxM904cRbbyp/lLGxfyW0O4+uKXWZaoK7sj38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11) by MN2PR12MB4206.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Fri, 22 May
 2026 10:25:36 +0000
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8]) by EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8%4]) with mapi id 15.20.9891.021; Fri, 22 May 2026
 10:25:35 +0000
Message-ID: <e3022ae8-d08d-4114-b6c0-c8f0890a2dae@amd.com>
Date: Fri, 22 May 2026 15:55:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] gpu/buddy: Track per-order used blocks with a
 scoreboard
To: Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com
References: <20260522092600.32818-1-francois.dugast@intel.com>
 <20260522092600.32818-6-francois.dugast@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260522092600.32818-6-francois.dugast@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0320.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::7) To EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB999132:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b75dd9-98e1-4789-bac8-08deb7ec7481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: T2A9rkhOO/ldrYrVHogDe535m0stfxsJSe3JO6ajVpqGNs1s+2wUfM62Vah9EX6kqDgGWemlMIBp2zXEgBXYN9Qq1BgKYWYDAmIZNazNxD9ET8rHczX3Z4cJLgNgBRK8YFbtoKkatF7njGL4H4nS5H0Bxekshrd6JCKIKdyJOZ3Fb3XJlcnUCsJQNrMKM8wiaAuNmCKrsje0l7koDC+YBI4IsT5HCapgQRJqzV6DULbpmvTKmOstXyssEW0Vve1vuuQwGuVrFRy96MVshwtAzHF7BGjK78tkA19q14O6geXo38BZjHmRwXQ7c05Rmonjt6N8dtJ8t9lXBMpPv5TX0Q6ZeyIWcFVLciNdO8bOqJEz5ilrsKr6lMD63Ik6h/xNxrHcjUWSD7882sWirTV2zMS+3LoFkbX7Afl3GbMCwumId5966XxozxUPzYF7xSUWdRsb/Cf4cnrpwqAMA1CG2X02i8434x6d4Hd9XxcTv9hqnsUQm8se3Zii0pQ/iC8RyYRDsCnCWcVlf0pGFZeMXQjPHjl0VnHyXTqZqmXzjcpTY/N0CiacU1LgLYoono/BrOqxg+iJtlGkCpEV8mzJrX6hkjDdu87D02mErPeTFmeTrSTqS6K0/Xw7fGdACE1XOoctKVz+Spi0dueL2tN35cLk4FRCJZ8RSqwrrXqVxiqkPWg/sKJcNoxd+UocdcZM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEVxNDZELzZVRU9ndjYwOERoU1dzd2Q5SGRwSS8xMENJS3Q0ejVvRCtrN0J1?=
 =?utf-8?B?OU1EcmtLd3VBYVgxakVHODJOaFU5MFpMVW1iYkxNWDIvREdjSVk0UGc2U21U?=
 =?utf-8?B?dFFFTndhMksvWE4wM3BtZFRyWllZaXpicFBONWR3LytYbng3M05jUTkwRElX?=
 =?utf-8?B?ZmlFejZ3bkFKUEx2TVljNDJta0g3cWxSa0RTRzFtSHVJWHBKWDI5TzlaSFAz?=
 =?utf-8?B?dDkzMkpsRVI3US9FWUQ1K3lrTTlFbVFLMXZBM0lZL04wakFMVFo4a3NDYXJC?=
 =?utf-8?B?SDFBZmptaU9aL1ZJT0FuZ0pnVkp6R1NIc2IxUUdSRFp6ajc4MmQ1L2tsQXZ6?=
 =?utf-8?B?L0J1akxxVjl1VzRPMU5vSUlqWkRBcTA2c0NWVGwrYWpPVnY2dmVPalFUYStD?=
 =?utf-8?B?TDBueHJKeXV6ZHZJU0Vjbzgxdy9XUk95ck9PZVo5T25peGp3MmowRmVHczd6?=
 =?utf-8?B?OUdKVUFSbkNPR2EwK3RFQXJKT2J5VUlsYnFYcFIzSTJGSzkrZlEvdFl4dEl6?=
 =?utf-8?B?WHd5UHU3TFFTOWZKNGdxak9nUnAzQ1c3YU95ZjE5ZXBmbGNaZ0lSZkV4NUVh?=
 =?utf-8?B?YkFudThQWlFWL29qcUdUU2FpL0V0TEtyNmhLVkdLeVYrSGVQaHQwR1ZXcmgy?=
 =?utf-8?B?V0dKQTNrNlo5ZGQwS3JieFpIWVZHN3gvWTNXRjY3MU9VYUlmTW95dEZpQkhl?=
 =?utf-8?B?V1VSbnJ3QjdrMlRGZStOcG0yNDBOVVNKNmswS3kzUkFiOUJlNGczSjc5RVVm?=
 =?utf-8?B?OWZWWjVhdUYydzh5aGxPbmR0MGNzNFpQQUdJMGVER0VBODFXMjNOTE9WSGF6?=
 =?utf-8?B?d1gvQm9lRWZMM3ljWU5KeGhLMXM3WVU1NVFGU1lDZWJ5b2I0eHM4cUZGNzI1?=
 =?utf-8?B?Yjdtc3VjMnhjOG1jTkFPQjRJdzdjSitPY0xGVG5meEd3Nk9abnVFNkNSaTdt?=
 =?utf-8?B?SXNXWXNydkNab3ArbFB4bzVOYkd6NkkycUZzaUUybWRpRFRIbmVZTFlqWlI2?=
 =?utf-8?B?ckh1aFF2RmdOVDhHQWVqT1BNWFpJZlFJRktSbnk5NUxUUW9QeWJmTzdhaU1a?=
 =?utf-8?B?R1gzOEs2M0FpSjA5cEFoZmFlTExkZis5OXFTMk5BeExPbW5sZ0x4R3ZuMFVB?=
 =?utf-8?B?TURDdFJ4MmwzYlNIOEtKUnJsamRRbVk0ejJCM1hvbk1RVjNhK1I2OU0rdnZY?=
 =?utf-8?B?eVc0NnBNUmtWY1BrN01wNW4wUVJaZDNCU0s4L2VWelRFcVlkcjlKbzBxQnZF?=
 =?utf-8?B?Q2c3dDEwaDZURTdBQUVvQitQRHhsSVpJczVrNVNjRFI3WWVBTGtBbStQMUNv?=
 =?utf-8?B?ZDIwZGhpMXZnclJIZlcvNlMwRXczQ2JZZGZJNzVrV3RZNmo4bnNHZlBPeGhp?=
 =?utf-8?B?Vk0xWnYvc2hKRlpOK09SY3pmTHZXMUxWbkhuNDRMNnFkUHVsY1hXbUlkQy9s?=
 =?utf-8?B?NTNhN3h0TjVWczVBN0RXVkwwbzlFdFJ2TEh5UmFySC84UkpEd3FJRWJ1akpS?=
 =?utf-8?B?aTg1bS9BbTFQejVwbWpNSm1lb1NSSmNBSThKY2NvNkdvckJsVmo0MGtZcUZh?=
 =?utf-8?B?RWs3Y3Z1VWRPeHh1OEVXRFZ3Y2pnQ3BuN3MrSDFPcWRWVXYybzFvY2lsd2V4?=
 =?utf-8?B?OVBZMGxqMXk3VFdzeVRIa3FSRkZ1d1I2LzR6R1JKYWtJVi9ZT2pPaStQbk01?=
 =?utf-8?B?Sm0rQjY1MU1WaVhTZ1hsUWVvVTlCV05jblprTlhPU2ZWV2FIeXI3Y1BOeUNt?=
 =?utf-8?B?VHpxMGNZTjdac1lCTWVKMWdJSlliRmVXSTBFQWpDUDVGMHJXa0tEMXQzMEFo?=
 =?utf-8?B?a2VjMStlaWtOdkxDcWFPQ2FKandPdDQ4ZlVBakdUSjI1NE02ZFd1ZXQ3NjRp?=
 =?utf-8?B?d2J4ampwMS9CMER0R0xOdGNnQVgrQlBiL0swbENzSWFjclVUWHk4aUtMV1dN?=
 =?utf-8?B?NXp2aU1NOGpkK2U4UHhMQjE3bGhHWTZ4SUMzeHBBWkZsc0RML1RFUG0yZ1Zx?=
 =?utf-8?B?YnBYa1JMS2IyZkhkUDhicDJhZ0Jmb2pycFFGNWJPY3JtZUh6R2hkZVh0cDk2?=
 =?utf-8?B?VHBvL2JDY2h5TDRucExySmFjVHd4czlPM2FwNHBCWHVqSkQ2Q2FMMjJ1VDh3?=
 =?utf-8?B?MnhPM25yd2JFNk9qL1FSZk9hSUFYQWVsZVpXaWhuM2p1ZHBjQ3pYc3lMSzZ1?=
 =?utf-8?B?S3hlQVhhSGh2NGxPM3M1YjQyeGU4UkZpOHNhNDRsUHRKY1NhS1VQbHREb3Vj?=
 =?utf-8?B?VWV4ZlNYUmNmNVlDWmhnYVA0d2JqbURGbkpOVXRpSk0ydWx2b1VKanlFRVN3?=
 =?utf-8?B?RHhGYURGV2MydDZLbTRjc3U2R0VJV0xLK3M1cmhwMUM2eXRudG9oZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b75dd9-98e1-4789-bac8-08deb7ec7481
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 10:25:35.7718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juzyN511McNwKyWUE2948ePUID1O6F1qvjJDQOMySxg5/i/Dl2g+8Hlt5NLZJI5ctThSqvYYbumBdI1/dbBS2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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



On 5/22/2026 2:55 PM, Francois Dugast wrote:
> Extend the scoreboard approach from the previous commit to used blocks,
> so drm_buddy_print() can report per-order allocation pressure in O(1).
>
> Unlike free blocks, an allocated block can leave the allocated state
> through mark_free() (normal free and gpu_buddy_block_trim()) or be
> consumed directly by gpu_block_free() during coalescing. Both sites are
> guarded by gpu_buddy_block_is_allocated() and paired with the increment
> in mark_allocated().
>
> v3:
> - Assert scoreboard is empty at fini(), as sanity check (Matthew Auld)
>
> v2:
> - Update after fix for use-after-free in split_block() call sites
> - Change goto label to out_free_used_scoreboard for clarity
> - Make drm_buddy_print() and gpu_buddy_print() symmetric for used and
>    free
>
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> ---
>   drivers/gpu/buddy.c         | 42 ++++++++++++++++++++++++++++---------
>   drivers/gpu/drm/drm_buddy.c | 18 ++++++++++------
>   include/linux/gpu_buddy.h   |  8 +++++++
>   3 files changed, 52 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index de18b63fef0a..dc81fe0301ce 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -194,6 +194,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>   	block->header |= GPU_BUDDY_ALLOCATED;
>   
>   	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
> +	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
The main consumer of free_scoreboard and used_scoreboard is 
gpu_buddy_print(), which is a debug/diagnostic path - it only gets 
called during debugfs reads or error state dumps, not during regular 
operation.
However, the cost of maintaining these scoreboards is paid on every 
alloc and free, which is the hot path of the allocator. Even though each 
individual update is small, do we really need to add extra work to the
hot path for something that only benefits a rarely-called debug function?
Am I missing a use case that justifies the hot-path overhead?

Regards,
Arun.
>   
>   	rbtree_remove(mm, block);
>   }
> @@ -203,6 +204,9 @@ static void mark_free(struct gpu_buddy *mm,
>   {
>   	enum gpu_buddy_free_tree tree;
>   
> +	if (gpu_buddy_block_is_allocated(block))
> +		mm->used_scoreboard[gpu_buddy_block_order(block)]--;
> +
>   	block->header &= ~GPU_BUDDY_HEADER_STATE;
>   	block->header |= GPU_BUDDY_FREE;
>   
> @@ -281,6 +285,9 @@ static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
>   		if (force_merge && gpu_buddy_block_is_clear(buddy))
>   			mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
>   
> +		if (gpu_buddy_block_is_allocated(block))
> +			mm->used_scoreboard[gpu_buddy_block_order(block)]--;
> +
>   		gpu_block_free(mm, block);
>   		gpu_block_free(mm, buddy);
>   
> @@ -398,11 +405,17 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   	if (!mm->free_scoreboard)
>   		return -ENOMEM;
>   
> +	mm->used_scoreboard = kcalloc(mm->max_order + 1,
> +				      sizeof(*mm->used_scoreboard),
> +				      GFP_KERNEL);
> +	if (!mm->used_scoreboard)
> +		goto out_free_free_scoreboard;
> +
>   	mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
>   				       sizeof(*mm->free_trees),
>   				       GFP_KERNEL);
>   	if (!mm->free_trees)
> -		goto out_free_scoreboard;
> +		goto out_free_used_scoreboard;
>   
>   	for_each_free_tree(i) {
>   		mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
> @@ -464,7 +477,9 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   	while (i--)
>   		kfree(mm->free_trees[i]);
>   	kfree(mm->free_trees);
> -out_free_scoreboard:
> +out_free_used_scoreboard:
> +	kfree(mm->used_scoreboard);
> +out_free_free_scoreboard:
>   	kfree(mm->free_scoreboard);
>   	return -ENOMEM;
>   }
> @@ -500,11 +515,15 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
>   
>   	gpu_buddy_assert(mm->avail == mm->size);
>   
> +	for (i = 0; i <= mm->max_order; ++i)
> +		gpu_buddy_assert(!mm->used_scoreboard[i]);
> +
>   	for_each_free_tree(i)
>   		kfree(mm->free_trees[i]);
>   	kfree(mm->free_trees);
>   	kfree(mm->roots);
>   	kfree(mm->free_scoreboard);
> +	kfree(mm->used_scoreboard);
>   }
>   EXPORT_SYMBOL(gpu_buddy_fini);
>   
> @@ -1505,15 +1524,18 @@ void gpu_buddy_print(struct gpu_buddy *mm)
>   		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		u64 count = mm->free_scoreboard[order];
> -		u64 free = count * (mm->chunk_size << order);
> -
> -		if (free < SZ_1M)
> -			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
> -				order, free >> 10, count);
> +		u64 free_count = mm->free_scoreboard[order];
> +		u64 used_count = mm->used_scoreboard[order];
> +		u64 block_size = mm->chunk_size << order;
> +		u64 free = free_count * block_size;
> +		u64 used = used_count * block_size;
> +
> +		if (block_size < SZ_1M)
> +			pr_info("order-%2d free: %8llu KiB, used: %8llu KiB, free_blocks: %llu, used_blocks: %llu\n",
> +				order, free >> 10, used >> 10, free_count, used_count);
>   		else
> -			pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
> -				order, free >> 20, count);
> +			pr_info("order-%2d free: %8llu MiB, used: %8llu MiB, free_blocks: %llu, used_blocks: %llu\n",
> +				order, free >> 20, used >> 20, free_count, used_count);
>   	}
>   }
>   EXPORT_SYMBOL(gpu_buddy_print);
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index eef995e08a37..1536e59c6fe7 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -47,17 +47,23 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
>   		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		u64 count = mm->free_scoreboard[order];
> -		u64 free = count * (mm->chunk_size << order);
> +		u64 free_count = mm->free_scoreboard[order];
> +		u64 used_count = mm->used_scoreboard[order];
> +		u64 block_size = mm->chunk_size << order;
> +		u64 free = free_count * block_size;
> +		u64 used = used_count * block_size;
>   
>   		drm_printf(p, "order-%2d ", order);
>   
> -		if (free < SZ_1M)
> -			drm_printf(p, "free: %8llu KiB", free >> 10);
> +		if (block_size < SZ_1M)
> +			drm_printf(p, "free: %8llu KiB, used: %8llu KiB",
> +				   free >> 10, used >> 10);
>   		else
> -			drm_printf(p, "free: %8llu MiB", free >> 20);
> +			drm_printf(p, "free: %8llu MiB, used: %8llu MiB",
> +				   free >> 20, used >> 20);
>   
> -		drm_printf(p, ", blocks: %llu\n", count);
> +		drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
> +			   free_count, used_count);
>   	}
>   }
>   EXPORT_SYMBOL(drm_buddy_print);
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index a28f7d7637ca..e037714563d8 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -180,6 +180,14 @@ struct gpu_buddy {
>   	 * called on a free block.
>   	 */
>   	u64 *free_scoreboard;
> +	/*
> +	 * Per-order used block scoreboard: used_scoreboard[order] holds the
> +	 * number of blocks of that order currently in the allocated state.
> +	 * Incremented in mark_allocated(), decremented in mark_free() (guarded
> +	 * by gpu_buddy_block_is_allocated()) and in __gpu_buddy_free() when an
> +	 * allocated block is consumed directly during buddy coalescing.
> +	 */
> +	u64 *used_scoreboard;
>   /* public: */
>   	unsigned int n_roots;
>   	unsigned int max_order;

