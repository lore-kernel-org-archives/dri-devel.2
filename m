Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBABC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B0010F09E;
	Thu,  6 Aug 2026 04:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EkK9a0UL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5656B10E284;
 Thu,  6 Aug 2026 04:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vb6SJFKwMPCHmEbVxA+as/8NEcTy0+ZjM8KxtDk//DpxL0fVfDc5uG6fZWbGVUCA3Vt3JDI4iOW0iRCtDm9QNWlSbFLxf2MILXa9uRXN7RPdOGmXgunT+0EJaFRW/sb3kZtT9x4Oj1s1KQAQRWSVeCD+nxOuc4SGEej6UBySamdXm3MgVh9rnFRdLKBZI86h8oKpoXcHIW5I/H2F5NVyKoB5GrxAG5JXneLWsmH2zmH+hLfDIfbHpLYfIDSzIJjYNFtGhHsSdkE+WTlkbve9uhFkYPG+Dif39Xx2RXMYmEKrSdwD1Aap/xvnnJfR4R1q53enMqRPpJzObZkyGSjJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRAbkOWBz+v6FchGdmaCA/n+qX/TQ3tpivNwsF/EHH8=;
 b=SoVMueLahADgVCqmUDpRNC7HQJztRhIiG54jv9ZgRo6erI9yoZ5PAePU7cUfvT3p1UQaquHZ8foRj4NrOagu7v9YgiHTsFdXrrkaaxLD7lYP2GgLCX278e0bWmszIbKbXsp+3JUQOIKjO0MAlnXihbjrsOUdAVkL2ml2DZo2qiVj0TEBFTTi6/64rs2/zpGG3P7EVVcea7IvNW2DVaZJ1cN2U7nOgwo2L+ZIHy8Ag2fu9rB60aNfhKwCx5madzp0Wd6lWnfrSdkdn1HoV6D4CdhjN9a1lPiBJbUDoRaQ4E8Bwbxc3po6+a3F7klqDEbnVADycflH+XBMTp0ylUifhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRAbkOWBz+v6FchGdmaCA/n+qX/TQ3tpivNwsF/EHH8=;
 b=EkK9a0ULINTeRnKIrJ7omaSCFxNqEQxjAgMXxBfgR384Tei3AOoXGnfC032YY9z0kM+jo8xu/FbqvLuJ2bM+vjNoQ5HK7vXblMDpAKA29hXMDHpmnhvBsCrzzA1TbnurM3vU5t8JtCZj6lUYkOOe0dB/ILxS0AtfOwJ+wJrT0pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 04:50:50 +0000
Received: from CH0PR12MB5026.namprd12.prod.outlook.com
 ([fe80::a495:f203:dd7a:3e25]) by CH0PR12MB5026.namprd12.prod.outlook.com
 ([fe80::a495:f203:dd7a:3e25%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 04:50:50 +0000
Message-ID: <666d161a-18d1-4719-a91f-c28be5052a25@amd.com>
Date: Thu, 6 Aug 2026 10:20:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: matthew.auld@intel.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Anand.Raghavendra@amd.com
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
 <4b184070-a4b6-4c3b-b587-19a7d9fbffc5@amd.com>
Content-Language: en-US
In-Reply-To: <4b184070-a4b6-4c3b-b587-19a7d9fbffc5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0129.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::14) To CH0PR12MB5026.namprd12.prod.outlook.com
 (2603:10b6:610:e1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5026:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b6d12a-0098-4c3a-b787-08def3764947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MVGARVBOqaVymK33WemrmrkseR0ZMNbKRlPmIQ/8sKje/Ig/ih1da0mO+F1KnE+gXkxjRVtFdn6ehT7KnQyR3qouDMMjuw0VkABxysgFKcYrl6qF6ZKG37Uo/VM5UTyazJqFGphPp/FSK56sCUz2QZKcnvNPI/ipb11Eg2W7u2y6FRAwHfkSfzQGk2iW7Gz6wDEdBXcLyQ99Tf/QGIMsGw0ilr877MZXP8zDRVI0owecESC2O5ClV85+/0vn4eg/AgKn0xAPfUq9/wA6TDIYdJW+yU34YFx2R0JutggUI8gyNWvgrWOgV32FDbcJCH3F3cBt/lQfyJNVyFJu20UMZ6Cvuj2RObuX4ugjogqkxKIyf9l2cVyeOJ6rZqLmFgftAQX+5qVeqC2gZcK5RizmH/GoekzjOJQf2XL7x7WF55uO+YvK1eRCNV82HgAcVfEgvp6Q6Ztce5gBnM15j6mCl9prcFba0YS7ZidJlwMbtzkXuZSHAEZM6Du4ePv4s7WOXtKzo6VtLdYMp01JbEjFyriMROekopHPVxGfMAbR9j+Mkhp/e5kQgeSOKgP89o3SIMNyBO/ZykNZ8bEfZwToO6gKHxOLD3XUAg8I/637uJ1OY6jHG0c80SWl87yFgZEcAAbwPPzVGYbixGYlPxe5tBY4MSwp47V3EHlgVMpZfH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5026.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWwwb1NocGdXbTJXc0RLUlJ1YUZSLzkzOVBGVDNEYWErMkZNdU5RNWRDMEpk?=
 =?utf-8?B?d1BVdHJPdUQrRk43NjRQWlplU0pRNVR4SGlqbjErcXJ0Q3Z4VHBjcjQxcEx4?=
 =?utf-8?B?LzRKU0o5VlpqZGQ4TDJSM005aU9HSFZmQlVQZXJIQjZVMjN4dTY0K2duVmNI?=
 =?utf-8?B?MTJoNGtUYmxxdmhaZ0lncE5XUU5hU2s1Z3RMdm4vLzIyRHVRcGpkVEtGcjMx?=
 =?utf-8?B?QTNRcG1Kb1lIdzJDbi81SXhySGlGam9VK25pbjh3eTBscHpVbU81eWNYUnR1?=
 =?utf-8?B?YnE0bENuL0QvbVJDeEZSZEZZZGV3YTVYL0o0UUViNXcxUUtuVTYwVkZmcTdD?=
 =?utf-8?B?OExJc2lwY0J2bi9jeHJHaVliR0FXUGQ1cnkwVWxDaElaRkxlTVI5RjNBWUxh?=
 =?utf-8?B?ZmU2TG1iQlRXWDZUUXJnTzlpejYvZjNBeCtDd3hsSGJMWXFNRXdVWEJwYU94?=
 =?utf-8?B?dDRMZ05EVUcwZlNzN3JNclBwNkVQSFVkVTloQkpXamRBREozSlVqdWRkamVo?=
 =?utf-8?B?MUQ1WE5DeGF0aXdxdm5sRU4xaC8vZ2JxQUQ5UldBNHVzTmgwSy9wVERhbGZu?=
 =?utf-8?B?eCtiNWlmSkdNKzdhYTgxRTJ2a3JWVXZneG9wR2pEUGNNY25UQ1d3RXl0cWZM?=
 =?utf-8?B?NUpha2lmdXA3UEwzRnFzeEtCWU1PUGY4cGptNVp3ZHJwVFVsT2poaG0ycFdo?=
 =?utf-8?B?Nm9WcE8weEJQbTVGR3VNdTRkZWEvVDUxcmYrVFVmNElIMmtKcGF0TkZFT3hY?=
 =?utf-8?B?UU00clVXeEpvdURmNFJrOXJyUVJVaWVla3dZUUpKTElYdnZIc1NCK2sxWVpj?=
 =?utf-8?B?eFMzeFY5UUE3L3FBRTY5S3hXczBrSWc5WXo5d2VreFB6K1pINXdrWDRSczlo?=
 =?utf-8?B?RFZGK3ZsUkV1NE83cHM0UngwNTNCYjlDZ0lTbk1NWnVPVSs4dzBEVHNlRGZm?=
 =?utf-8?B?ai9vZ0UvRVVibm81WjVURnJ4Y3I2c0ZaMCtVREgzVG1CbU9UdkpKWnlsL3d3?=
 =?utf-8?B?dDhHc0tDck1waDcwa1RoQjRVU2N3SmtwOWJCUUF1ektLMEJjWGlhV1BoM3Nj?=
 =?utf-8?B?N01wSGQvWEh3VXpJcTAvVE5sK0RZelRic0dtUFJLcTRzeEtkeXlFK1JsREVr?=
 =?utf-8?B?N1RoL1VJUk10UFFyRW14WStveEVCUS9ZbmlrL2tKTlp1a0Juci9ZQUpVRXlR?=
 =?utf-8?B?MXo3Sm5LalpkZ2NVdXMvSTk2ZzRKY1IvT2pWQmQ1YWdxeWwvYnc3cDhvMlIz?=
 =?utf-8?B?dzQyUDYralhoWW8xRWdDMEhWUzBUd29pWmVrNkptTWRFand5OEhCUURuaFRX?=
 =?utf-8?B?OUpvQ2N4V2xMRW80Q3BkMTQyNGZMd0FRTk1YMFN5UWU0dUlXcmtabTBZMHdl?=
 =?utf-8?B?WUlFdnNuT3doeU4xZThraytzTUdJa2VqalpvRjdRMzJGcnMzZ3grcTRkdkth?=
 =?utf-8?B?Y0VBdjIxb0FUWVcrTWgya0praTVTcVBXZVp0Rnlrd0RJbnJNQlA4ZHZaS1Ro?=
 =?utf-8?B?Q1JHRXNUM1QzNkNncGFoYUUzTFlaN3k0a05ua1JiSytJTTc5aURSZ2dBKy9l?=
 =?utf-8?B?SER0Wk1XRUYyNEtDMlJEUFJVZzZybjJWd1EzeHF4YnlRVGI2QzVyWEJnZytl?=
 =?utf-8?B?Ly92dmIzV01MUE5LdVRwbXM3dTVCZzVMNW1lbE84a1RHUm12bkM5UUpiTFNt?=
 =?utf-8?B?d3FHL05IVEZSajJlQ1ZYa1h3ei9mRHY0VUxQeC9QdTU4cUdjUFN0STc5YXZZ?=
 =?utf-8?B?NkVObjB0OTJRT1FDS081RWJxNjZveTMzbHRnM2pjb0hkZFZJTkd0Y0NReFgy?=
 =?utf-8?B?dmZ1U0xIa0xRdDVmc25KOXNnaXZaRGZTVVdYallHREwrSXZtQUVuZ1cwTmwr?=
 =?utf-8?B?VzFlTUU3a2FwYUxNdzBKUFlNR2YzL1BES3ZwWTdZRlVmempBM2IwSTFYUWxV?=
 =?utf-8?B?TGpZUytQWjNaekdKNVlKZFlOSmRKcENrVk8yVnB1M3dDZE55dW02elhPeE44?=
 =?utf-8?B?ZkpYc1ZqSDN6dWlQKzJkSythc3llVGhmSEphaWErbVVyRHFULzdxdDZOVHNP?=
 =?utf-8?B?ZnlFYzZLT0llcDJ1V3AwL2tFZkpqNjVxUnZKNDZDMG9yTGdwOGxLd1dlWTAx?=
 =?utf-8?B?S3JOWk84WjcrYkoybmJqUUxMQjFWZS9PTG1ZZEtkSWxya3VqVkhvMTQ3WFhv?=
 =?utf-8?B?RExaQldkMStsc3lpN2ozcVk3ZlU5MGNIcTJrRVlZblJUYWFXcU1wZmRCZEJl?=
 =?utf-8?B?YlZsd1JRYVoyVFBnSzgwMWgyb3V4b3Z0bWY3aHIzUys0THQ4VUc3VEh4ck44?=
 =?utf-8?B?bjFTNEdLRGJqcHpjcUU5N1QzVlIrSGNIVXV2bFJBc2ZxWmF1emNHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b6d12a-0098-4c3a-b787-08def3764947
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5026.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 04:50:50.1531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wy/CYRJnf2GJZO91gxg2i0qDtus3qMB830bj7qvZf9QhPjfMIBnTrws3usaTMp2Z8fB1efwA0qRSUc8BrUlQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
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

Adding Anand, as he is working directly with the customer who is waiting 
for this fix to be upstreamed.

@Matthew just checking whether you have had a chance to evaluate the 
changes on your hardware.
If you notice any regressions or issues, please let me know.

Regards,
Arun.

On 8/3/2026 1:54 PM, Arunpravin Paneer Selvam wrote:
> Hi Matthew,
>
> I have posted v7 with the Sashiko's review feedback addressed along 
> with few additional changes.
> Could you review the patches ?
>
> Regards,
> Arun.
>
> On 7/31/2026 12:37 PM, Arunpravin Paneer Selvam wrote:
>> The current buddy allocator maintains separate clear_tree[] and
>> dirty_tree[] rbtrees per order, preventing coalescing between cleared
>> and dirty buddies. Under mixed workloads, this creates a merge barrier:
>> adjacent buddies frequently end up split across trees, forcing reliance
>> on __force_merge() during allocation.
>>
>> __force_merge() performs an O(N x max_order) scan under the VRAM manager
>> lock, leading to allocation stalls and failures for large contiguous
>> requests even when sufficient total free memory is available.
>>
>> Solution
>>
>> Replace the dual-tree design with:
>> - A single free_tree[order] rbtree for dirty and mixed free blocks
>>    (fully cleared free blocks float outside this tree)
>> - A lightweight out-of-band dirty tracker (gpu_dirty_tracker)
>>
>> Fully cleared free blocks are tracked outside the buddy trees using an
>> augmented interval rbtree, enabling O(log E) lookup of the largest
>> cleared extents.
>>
>> Buddy coalescing is now unconditional in __gpu_buddy_free(), regardless
>> of clear/dirty state. This removes the merge barrier and eliminates the
>> need for __force_merge().
>>
>> Benefits
>>
>> - Correct high-order allocations after mixed clear/dirty workloads
>> - Elimination of O(N x max_order) merge cost from the allocation path
>> - O(log E) cleared-extent lookup replacing O(N) scans
>> - Predictable allocation latency under fragmentation
>> - Reduced complexity with a single tree per order
>>
>> Test:
>> dEQP-VK.memory.allocation.basic.size_8KiB.reverse.count_4000
>>
>> Below data is from /sys/kernel/debug/dri/1/amdgpu_vram_mm:
>>
>> Base (dual-tree), before VKCTS test:
>>    order- 6 free:   6 MiB,  blocks: 26
>>    order- 5 free:   1 MiB,  blocks: 15
>>    order- 4 free: 960 KiB,  blocks: 15
>>    order- 3 free:   5 MiB,  blocks: 171
>>    order- 2 free:   2 MiB,  blocks: 176
>>    order- 1 free:   1 MiB,  blocks: 165
>>    order- 0 free:  16 KiB,  blocks: 4
>>
>> Base (dual-tree), after VKCTS test:
>>    order- 6 free: 768 KiB,  blocks: 3
>>    order- 5 free: 499 MiB,  blocks: 3999
>>    order- 4 free: 250 MiB,  blocks: 4001
>>    order- 3 free: 129 MiB,  blocks: 4157
>>    order- 2 free:  65 MiB,  blocks: 4161
>>    order- 1 free:  63 MiB,  blocks: 8138
>>    order- 0 free:  20 KiB,  blocks: 5
>>
>> Dirty tracker, before VKCTS test:
>>    order- 6 free:   4 MiB,  blocks: 19
>>    order- 5 free:   2 MiB,  blocks: 18
>>    order- 4 free: 704 KiB,  blocks: 11
>>    order- 3 free:   5 MiB,  blocks: 168
>>    order- 2 free:   2 MiB,  blocks: 174
>>    order- 1 free:   1 MiB,  blocks: 167
>>    order- 0 free:  32 KiB,  blocks: 8
>>
>> Dirty tracker, after VKCTS test:
>>    order- 6 free:   4 MiB,  blocks: 19
>>    order- 5 free:   2 MiB,  blocks: 18
>>    order- 4 free: 704 KiB,  blocks: 11
>>    order- 3 free:   5 MiB,  blocks: 168
>>    order- 2 free:   2 MiB,  blocks: 174
>>    order- 1 free:   1 MiB,  blocks: 167
>>    order- 0 free:  28 KiB,  blocks: 7
>>
>> v2:
>>   - Code-style cleanup and minor refactoring
>>   - Renamed locals for clarity
>>
>> v3:
>>   - Keep cleared blocks inside free_tree[] instead of floating them.
>>   - Add subtree_has_dirty rbtree augment for O(log N) dirty-first walk.
>>
>> v4:
>>   - Fixed checkpatch warnings.
>>   - Optimized gpu_buddy_reset_clear() to a single post-order walk that
>>     flips block headers and recomputes the rbtree augment in one pass.
>>   - Propagate subtree_max_size top-down in insert_extent() so ancestors
>>     are not left with stale values on no-rotation inserts. (sashiko)
>>   - Drop the whole extent in gpu_dirty_tracker_mark_dirty() when the
>>     inside-split allocation fails, avoiding a stale clear claim. 
>> (sashiko)
>>   - Make gpu_dirty_tracker_find() alignment-aware and fall back to the
>>     dirty tree on steered failure to avoid spurious -ENOSPC. (sashiko)
>>
>> v5:
>>   - Track dirty extents instead of cleared ones: steer dirty allocs onto
>>     tracked dirty windows and pick clear allocs via a free-tree augment,
>>     avoiding clear-memory wastage by keeping cleared free blocks 
>> untouched
>>     during dirty allocation.
>>
>> v6:
>>   - Make __alloc_range_bias() return the highest/right-most address by
>>     default, establishing top-down as the intended placement for
>>     range-biased allocations.
>>   - Honour GPU_BUDDY_CLEAR_ALLOCATION in __alloc_range_bias() by 
>> steering
>>     the descent towards clear subtrees for non-top-down clear
>>     requests. (sashiko)
>>   - Skip dirty-tracker steering for offset-aligned requests so they keep
>>     their min_block_size alignment. (sashiko)
>>   - sashiko reported that the __GFP_NOFAIL dirty-extent allocations on
>>     the free path could deadlock during memory reclaim, since that is a
>>     GFP_KERNEL allocation on the free path; move to a per-tracker
>>     mempool so extent nodes are guaranteed without __GFP_NOFAIL.
>>     (sashiko)
>>   - Derive each free block's clear/dirty class from the blocks already
>>     in hand on split, free, alloc, trim and init instead of querying the
>>     dirty tracker, removing the tracker lookups from the hot paths.
>>
>> v7:
>>   - Preserve mixed-block clear state in __gpu_buddy_free() when a mixed
>>     split child is re-merged after an undone split. (sashiko)
>>   - Prefer a fully-clear block over a mixed one of the same order via a
>>     single ordered clear-state max augment on free_tree[].
>>
>> Assisted-by: Claude:claude-opus-4-8
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/buddy.c                | 1318 ++++++++++++++++++++--------
>>   drivers/gpu/tests/gpu_buddy_test.c |   32 +-
>>   include/linux/gpu_buddy.h          |   97 +-
>>   3 files changed, 1034 insertions(+), 413 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index dc81fe0301ce..a5d68cd8b78d 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/kmemleak.h>
>>   #include <linux/module.h>
>>   #include <linux/sizes.h>
>> +#include <linux/slab.h>
>>     #include <linux/gpu_buddy.h>
>>   @@ -34,6 +35,441 @@
>>   #endif
>>     static struct kmem_cache *slab_blocks;
>> +static struct kmem_cache *slab_extents;
>> +
>> +/*
>> + * A single reserved extent suffices. Every allocation uses GFP_KERNEL
>> + * from sleepable context, so the underlying slab alloc almost always
>> + * succeeds via reclaim; the reserve only backstops the rare case where
>> + * it still returns NULL (e.g. the current task is an OOM victim),
>> + * guaranteeing a non-NULL extent without __GFP_NOFAIL. Because each
>> + * alloc can independently wait for reclaim, the reserve need not scale
>> + * with the number of extents added in one locked section (e.g. by
>> + * gpu_buddy_reset_clear()).
>> + */
>> +#define GPU_DIRTY_EXTENT_POOL_MIN 1
>> +
>> +/*
>> + * Dirty tracker
>> + * -------------
>> + *
>> + * The dirty tracker maintains an augmented interval rbtree of 
>> contiguous
>> + * dirty address ranges, decoupled from the buddy free trees.
>> + * Each node covers a maximal coalesced run; adjacent extents are 
>> merged
>> + * on insertion so the tree always holds the smallest possible 
>> number of
>> + * extents.  The augmentation field @subtree_max_size lets the 
>> allocator
>> + * locate the largest dirty extent in O(log E).
>> + *
>> + * Free trees (mm->free_tree[])
>> + * ----------------------------
>> + *
>> + * Per-order augmented rbtrees of FREE buddy blocks, keyed by offset.
>> + * Every node carries:
>> + *   - subtree_max_alignment: largest natural alignment in the subtree,
>> + *     used by aligned/range allocations to skip unsuitable subtrees in
>> + *     O(log N).
>> + *   - subtree_block_state: the highest clear class (DIRTY < MIXED < 
>> CLEAR)
>> + *     of any block in the subtree, maintained as a max augment. A 
>> value of
>> + *     >= MIXED means a clear-or-mixed block exists; == CLEAR means a
>> + *     fully-clear block exists.
>> + *
>> + * Block classes
>> + * -------------
>> + *
>> + * Each FREE block falls into one of three classes, determined in
>> + * mark_free() by querying the dirty tracker for the block's range:
>> + *
>> + *   clear   -- HEADER_CLEAR set; no dirty extent overlaps the range.
>> + *   mixed   -- HEADER_CLEAR unset; range has both dirty and clear 
>> bytes.
>> + *   dirty   -- HEADER_CLEAR unset; range is fully dirty.
>> + *
>> + * Clear allocation
>> + * ----------------
>> + *
>> + * A clear (CLEAR_ALLOCATION) request prefers clear -> mixed -> dirty.
>> + * Climbing from the requested order up to max_order, 
>> rbtree_last_clear_free_block()
>> + * returns, in one O(log N) descent per order, the right-most 
>> clear-or-mixed block
>> + * (fully-clear preferred over mixed) at the lowest order that has 
>> one. Only if no
>> + * clear-or-mixed block exists at any order >= the requested one 
>> does it fall back
>> + * to a dirty block.
>> + *
>> + * Clear state is reported to the driver per whole block via 
>> HEADER_CLEAR, so a
>> + * fully-clear block of the requested order lets the driver skip the 
>> clear pass.
>> + *
>> + * The effective selection order therefore depends on the driver's
>> + * free policy:
>> + *
>> + *   1) If the driver never clears freed blocks, no free block ever 
>> holds
>> + *      clear bytes, so a clear request always falls back to a dirty 
>> block.
>> + *   2) If the driver clears every freed block, cleared ranges 
>> accumulate at
>> + *      the high end of the address space, so picking the right-most 
>> block
>> + *      yields clear -> mixed -> dirty.
>> + *   3) If the driver clears freed blocks selectively, fully-clear 
>> blocks are
>> + *      still preferred over mixed ones at the same order, and the 
>> right-most
>> + *      candidate wins, giving a clear -> mixed -> dirty order.
>> + */
>> +
>> +static u64 extent_size(struct gpu_dirty_extent *dirty_extent)
>> +{
>> +    return dirty_extent->end - dirty_extent->start;
>> +}
>> +
>> +RB_DECLARE_CALLBACKS_MAX(static, gpu_dirty_augment_cb,
>> +             struct gpu_dirty_extent, rb,
>> +             u64, subtree_max_size,
>> +             extent_size)
>> +
>> +static struct gpu_dirty_extent *extent_alloc(struct 
>> gpu_dirty_tracker *dirty_tracker)
>> +{
>> +    /*
>> +     * The void free/reset paths must record an extent and cannot 
>> handle
>> +     * failure, so the mempool reserve guarantees a non-NULL return
>> +     * without __GFP_NOFAIL. GFP_KERNEL is safe under the buddy 
>> lock: no
>> +     * driver frees buddy blocks from a shrinker, so reclaim cannot
>> +     * recurse into the lock we hold.
>> +     */
>> +    return mempool_alloc(dirty_tracker->extent_pool, GFP_KERNEL);
>> +}
>> +
>> +static void extent_free(struct gpu_dirty_tracker *dirty_tracker,
>> +            struct gpu_dirty_extent *dirty_extent)
>> +{
>> +    mempool_free(dirty_extent, dirty_tracker->extent_pool);
>> +}
>> +
>> +/* Return the rightmost extent whose start is strictly below 
>> @offset. */
>> +static struct gpu_dirty_extent *
>> +prev_extent(struct gpu_dirty_tracker *dirty_tracker, u64 offset)
>> +{
>> +    struct rb_node *rb = dirty_tracker->root.rb_node;
>> +    struct gpu_dirty_extent *dirty_extent = NULL;
>> +
>> +    while (rb) {
>> +        struct gpu_dirty_extent *tmp_extent =
>> +            rb_entry(rb, struct gpu_dirty_extent, rb);
>> +
>> +        if (tmp_extent->start < offset) {
>> +            dirty_extent = tmp_extent;
>> +            rb = rb->rb_right;
>> +        } else {
>> +            rb = rb->rb_left;
>> +        }
>> +    }
>> +
>> +    return dirty_extent;
>> +}
>> +
>> +/* Return the leftmost extent whose start is at or above @offset. */
>> +static struct gpu_dirty_extent *
>> +next_extent(struct gpu_dirty_tracker *dirty_tracker, u64 offset)
>> +{
>> +    struct rb_node *rb = dirty_tracker->root.rb_node;
>> +    struct gpu_dirty_extent *dirty_extent = NULL;
>> +
>> +    while (rb) {
>> +        struct gpu_dirty_extent *tmp_extent =
>> +            rb_entry(rb, struct gpu_dirty_extent, rb);
>> +
>> +        if (tmp_extent->start >= offset) {
>> +            dirty_extent = tmp_extent;
>> +            rb = rb->rb_left;
>> +        } else {
>> +            rb = rb->rb_right;
>> +        }
>> +    }
>> +
>> +    return dirty_extent;
>> +}
>> +
>> +static void insert_extent(struct gpu_dirty_tracker *dirty_tracker,
>> +              struct gpu_dirty_extent *dirty_extent)
>> +{
>> +    struct rb_node **link = &dirty_tracker->root.rb_node;
>> +    struct rb_node *parent = NULL;
>> +    u64 size = extent_size(dirty_extent);
>> +
>> +    while (*link) {
>> +        struct gpu_dirty_extent *tmp_extent;
>> +
>> +        parent = *link;
>> +        tmp_extent = rb_entry(parent, struct gpu_dirty_extent, rb);
>> +
>> +        if (tmp_extent->subtree_max_size < size)
>> +            tmp_extent->subtree_max_size = size;
>> +
>> +        if (dirty_extent->start < tmp_extent->start)
>> +            link = &parent->rb_left;
>> +        else
>> +            link = &parent->rb_right;
>> +    }
>> +
>> +    dirty_extent->subtree_max_size = size;
>> +    rb_link_node(&dirty_extent->rb, parent, link);
>> +    rb_insert_augmented(&dirty_extent->rb, &dirty_tracker->root, 
>> &gpu_dirty_augment_cb);
>> +}
>> +
>> +static void remove_extent(struct gpu_dirty_tracker *dirty_tracker,
>> +              struct gpu_dirty_extent *dirty_extent)
>> +{
>> +    rb_erase_augmented(&dirty_extent->rb, &dirty_tracker->root, 
>> &gpu_dirty_augment_cb);
>> +    RB_CLEAR_NODE(&dirty_extent->rb);
>> +}
>> +
>> +static int gpu_dirty_tracker_init(struct gpu_dirty_tracker 
>> *dirty_tracker)
>> +{
>> +    dirty_tracker->root = RB_ROOT;
>> +    dirty_tracker->total_dirty = 0;
>> +
>> +    dirty_tracker->extent_pool =
>> +        mempool_create_slab_pool(GPU_DIRTY_EXTENT_POOL_MIN, 
>> slab_extents);
>> +    if (!dirty_tracker->extent_pool)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>> +static void gpu_dirty_tracker_empty(struct gpu_dirty_tracker 
>> *dirty_tracker)
>> +{
>> +    struct rb_node *rb;
>> +
>> +    while ((rb = rb_first(&dirty_tracker->root))) {
>> +        struct gpu_dirty_extent *dirty_extent =
>> +            rb_entry(rb, struct gpu_dirty_extent, rb);
>> +
>> +        remove_extent(dirty_tracker, dirty_extent);
>> +        extent_free(dirty_tracker, dirty_extent);
>> +    }
>> +
>> +    dirty_tracker->total_dirty = 0;
>> +}
>> +
>> +static void gpu_dirty_tracker_fini(struct gpu_dirty_tracker 
>> *dirty_tracker)
>> +{
>> +    gpu_dirty_tracker_empty(dirty_tracker);
>> +    mempool_destroy(dirty_tracker->extent_pool);
>> +    dirty_tracker->extent_pool = NULL;
>> +}
>> +
>> +/*
>> + * Mark the range [start, start + size] as dirty. Merge with the 
>> neighbour on
>> + * each side if they are contiguous, so the tree never holds two 
>> adjacent ranges.
>> + */
>> +static void gpu_dirty_tracker_mark_dirty(struct gpu_dirty_tracker 
>> *dirty_tracker,
>> +                     u64 start, u64 size)
>> +{
>> +    struct gpu_dirty_extent *left, *right, *dirty_extent;
>> +    u64 end = start + size;
>> +
>> +    if (!size)
>> +        return;
>> +
>> +    /* Find contiguous neighbours, if any. */
>> +    left = prev_extent(dirty_tracker, start);
>> +    if (left && left->end != start)
>> +        left = NULL;
>> +
>> +    right = next_extent(dirty_tracker, end);
>> +    if (right && right->start != end)
>> +        right = NULL;
>> +
>> +    if (left && right) {
>> +        /* Merge left + new + right into a single extent. */
>> +        remove_extent(dirty_tracker, left);
>> +        remove_extent(dirty_tracker, right);
>> +        left->end = right->end;
>> +        extent_free(dirty_tracker, right);
>> +        insert_extent(dirty_tracker, left);
>> +    } else if (left) {
>> +        /* Extend left neighbour rightwards. */
>> +        remove_extent(dirty_tracker, left);
>> +        left->end = end;
>> +        insert_extent(dirty_tracker, left);
>> +    } else if (right) {
>> +        /* Extend right neighbour leftwards. */
>> +        remove_extent(dirty_tracker, right);
>> +        right->start = start;
>> +        insert_extent(dirty_tracker, right);
>> +    } else {
>> +        /* Standalone extent. */
>> +        dirty_extent = extent_alloc(dirty_tracker);
>> +        dirty_extent->start = start;
>> +        dirty_extent->end   = end;
>> +        insert_extent(dirty_tracker, dirty_extent);
>> +    }
>> +
>> +    dirty_tracker->total_dirty += size;
>> +}
>> +
>> +/*
>> + * Remove the range [start, start + size] from the dirty tracker. 
>> Punch the
>> + * range out of every overlapping dirty extent, splitting one extent 
>> in two if
>> + * the removed range falls strictly inside it.
>> + */
>> +static void gpu_dirty_tracker_remove_range(struct gpu_dirty_tracker 
>> *dirty_tracker,
>> +                       u64 start, u64 size)
>> +{
>> +    struct gpu_dirty_extent *dirty_extent, *next;
>> +    u64 end = start + size;
>> +
>> +    if (!size)
>> +        return;
>> +
>> +    dirty_extent = prev_extent(dirty_tracker, start + 1);
>> +    if (!dirty_extent)
>> +        dirty_extent = next_extent(dirty_tracker, start);
>> +
>> +    while (dirty_extent && dirty_extent->start < end) {
>> +        struct rb_node *next_node = rb_next(&dirty_extent->rb);
>> +        u64 extent_start = dirty_extent->start;
>> +        u64 extent_end = dirty_extent->end;
>> +
>> +        if (next_node)
>> +            next = rb_entry(next_node, struct gpu_dirty_extent, rb);
>> +        else
>> +            next = NULL;
>> +
>> +        /* Skip a non-overlapping neighbour returned by 
>> prev_extent(). */
>> +        if (extent_end <= start) {
>> +            dirty_extent = next;
>> +            continue;
>> +        }
>> +
>> +        if (extent_start < start && extent_end > end) {
>> +            /*
>> +             * Removed range lies strictly inside this dirty extent:
>> +             * split it into the dirty left and right halves.
>> +             */
>> +            struct gpu_dirty_extent *right = 
>> extent_alloc(dirty_tracker);
>> +
>> +            remove_extent(dirty_tracker, dirty_extent);
>> +
>> +            dirty_extent->end = start;
>> +            right->start = end;
>> +            right->end   = extent_end;
>> +
>> +            insert_extent(dirty_tracker, dirty_extent);
>> +            insert_extent(dirty_tracker, right);
>> +
>> +            dirty_tracker->total_dirty -= size;
>> +        } else if (extent_start >= start && extent_end <= end) {
>> +            /* Extent fully covered: drop it. */
>> +            remove_extent(dirty_tracker, dirty_extent);
>> +            extent_free(dirty_tracker, dirty_extent);
>> +
>> +            dirty_tracker->total_dirty -= (extent_end - extent_start);
>> +        } else if (extent_start < start) {
>> +            /* Extent overlaps from the left: trim its right end. */
>> +            remove_extent(dirty_tracker, dirty_extent);
>> +            dirty_extent->end = start;
>> +            insert_extent(dirty_tracker, dirty_extent);
>> +
>> +            dirty_tracker->total_dirty -= (extent_end - start);
>> +        } else {
>> +            /* Extent overlaps from the right: trim its left end. */
>> +            remove_extent(dirty_tracker, dirty_extent);
>> +            dirty_extent->start = end;
>> +            insert_extent(dirty_tracker, dirty_extent);
>> +
>> +            dirty_tracker->total_dirty -= (end - extent_start);
>> +        }
>> +
>> +        dirty_extent = next;
>> +    }
>> +}
>> +
>> +static enum gpu_block_state
>> +gpu_dirty_range_state(struct gpu_dirty_tracker *dirty_tracker,
>> +              u64 start, u64 size)
>> +{
>> +    struct gpu_dirty_extent *dirty_extent;
>> +    u64 end = start + size;
>> +
>> +    dirty_extent = prev_extent(dirty_tracker, start + 1);
>> +    if (dirty_extent) {
>> +        if (dirty_extent->start <= start && dirty_extent->end >= end)
>> +            return GPU_BLOCK_DIRTY;
>> +        if (dirty_extent->start < end && dirty_extent->end > start)
>> +            return GPU_BLOCK_MIXED;
>> +    }
>> +
>> +    dirty_extent = next_extent(dirty_tracker, start);
>> +    if (dirty_extent && dirty_extent->start < end)
>> +        return GPU_BLOCK_MIXED;
>> +
>> +    return GPU_BLOCK_CLEAR;
>> +}
>> +
>> +static struct rb_node *
>> +dirty_tracker_descend_right(struct rb_node *node, u64 min_size)
>> +{
>> +    while (node->rb_right) {
>> +        struct gpu_dirty_extent *tmp_extent;
>> +
>> +        tmp_extent = rb_entry(node->rb_right, struct 
>> gpu_dirty_extent, rb);
>> +
>> +        if (tmp_extent->subtree_max_size < min_size)
>> +            break;
>> +        node = node->rb_right;
>> +    }
>> +
>> +    return node;
>> +}
>> +
>> +static struct gpu_dirty_extent *
>> +gpu_dirty_tracker_find(struct gpu_dirty_tracker *dirty_tracker,
>> +               u64 min_size, u64 *aligned_start_out)
>> +{
>> +    struct rb_node *rb = dirty_tracker->root.rb_node;
>> +    struct gpu_dirty_extent *root_extent;
>> +    struct rb_node *parent;
>> +
>> +    if (!min_size || !is_power_of_2(min_size))
>> +        return NULL;
>> +
>> +    if (!rb)
>> +        return NULL;
>> +
>> +    root_extent = rb_entry(rb, struct gpu_dirty_extent, rb);
>> +    if (root_extent->subtree_max_size < min_size)
>> +        return NULL;
>> +
>> +    rb = dirty_tracker_descend_right(rb, min_size);
>> +
>> +    while (rb) {
>> +        struct gpu_dirty_extent *dirty_extent;
>> +        u64 aligned_start;
>> +
>> +        dirty_extent = rb_entry(rb, struct gpu_dirty_extent, rb);
>> +        aligned_start = ALIGN(dirty_extent->start, min_size);
>> +
>> +        /* Check if a min_size block fits after the alignment skip. */
>> +        if (aligned_start <= dirty_extent->end &&
>> +            dirty_extent->end - aligned_start >= min_size) {
>> +            *aligned_start_out = aligned_start;
>> +            return dirty_extent;
>> +        }
>> +
>> +        if (rb->rb_left) {
>> +            struct gpu_dirty_extent *tmp_extent;
>> +
>> +            tmp_extent = rb_entry(rb->rb_left, struct 
>> gpu_dirty_extent, rb);
>> +            if (tmp_extent->subtree_max_size >= min_size) {
>> +                rb = dirty_tracker_descend_right(rb->rb_left, 
>> min_size);
>> +                continue;
>> +            }
>> +        }
>> +
>> +        /* Walk up until we exit a node via its right child. */
>> +        parent = rb_parent(rb);
>> +        while (parent && parent->rb_right != rb) {
>> +            rb = parent;
>> +            parent = rb_parent(rb);
>> +        }
>> +        rb = parent;
>> +    }
>> +
>> +    return NULL;
>> +}
>>     static unsigned int
>>   gpu_buddy_block_state(struct gpu_buddy_block *block)
>> @@ -67,10 +503,97 @@ static unsigned int 
>> gpu_buddy_block_offset_alignment(struct gpu_buddy_block *blo
>>       return __ffs64(offset);
>>   }
>>   -RB_DECLARE_CALLBACKS_MAX(static, gpu_buddy_augment_cb,
>> -             struct gpu_buddy_block, rb,
>> -             unsigned int, subtree_max_alignment,
>> -             gpu_buddy_block_offset_alignment);
>> +static inline enum gpu_block_state
>> +gpu_block_cached_state(struct gpu_buddy_block *block)
>> +{
>> +    if (gpu_buddy_block_is_clear(block))
>> +        return GPU_BLOCK_CLEAR;
>> +    if (block->has_clear)
>> +        return GPU_BLOCK_MIXED;
>> +    return GPU_BLOCK_DIRTY;
>> +}
>> +
>> +static inline void gpu_buddy_augment_compute(struct gpu_buddy_block 
>> *block)
>> +{
>> +    enum gpu_block_state block_state;
>> +    struct gpu_buddy_block *right;
>> +    struct gpu_buddy_block *left;
>> +    unsigned int max_align;
>> +
>> +    max_align = gpu_buddy_block_offset_alignment(block);
>> +    block_state = gpu_block_cached_state(block);
>> +
>> +    left = rb_entry_safe(block->rb.rb_left, struct gpu_buddy_block, 
>> rb);
>> +    if (left) {
>> +        if (left->subtree_max_alignment > max_align)
>> +            max_align = left->subtree_max_alignment;
>> +
>> +        block_state = max(block_state, left->subtree_block_state);
>> +    }
>> +
>> +    right = rb_entry_safe(block->rb.rb_right, struct 
>> gpu_buddy_block, rb);
>> +    if (right) {
>> +        if (right->subtree_max_alignment > max_align)
>> +            max_align = right->subtree_max_alignment;
>> +
>> +        block_state = max(block_state, right->subtree_block_state);
>> +    }
>> +
>> +    block->subtree_max_alignment = max_align;
>> +    block->subtree_block_state = block_state;
>> +}
>> +
>> +static void gpu_buddy_augment_propagate(struct rb_node *rb, struct 
>> rb_node *stop)
>> +{
>> +    while (rb != stop) {
>> +        struct gpu_buddy_block *block;
>> +        unsigned int old_align;
>> +        enum gpu_block_state old_block_state;
>> +
>> +        block = rb_entry(rb, struct gpu_buddy_block, rb);
>> +        old_align = block->subtree_max_alignment;
>> +        old_block_state = block->subtree_block_state;
>> +
>> +        gpu_buddy_augment_compute(block);
>> +        if (block->subtree_max_alignment == old_align &&
>> +            block->subtree_block_state == old_block_state)
>> +            break;
>> +
>> +        rb = rb_parent(&block->rb);
>> +    }
>> +}
>> +
>> +static void gpu_buddy_augment_copy(struct rb_node *rb_old, struct 
>> rb_node *rb_new)
>> +{
>> +    struct gpu_buddy_block *old;
>> +    struct gpu_buddy_block *new;
>> +
>> +    old = rb_entry(rb_old, struct gpu_buddy_block, rb);
>> +    new = rb_entry(rb_new, struct gpu_buddy_block, rb);
>> +
>> +    new->subtree_max_alignment = old->subtree_max_alignment;
>> +    new->subtree_block_state = old->subtree_block_state;
>> +}
>> +
>> +static void gpu_buddy_augment_rotate(struct rb_node *rb_old, struct 
>> rb_node *rb_new)
>> +{
>> +    struct gpu_buddy_block *old;
>> +    struct gpu_buddy_block *new;
>> +
>> +    old = rb_entry(rb_old, struct gpu_buddy_block, rb);
>> +    new = rb_entry(rb_new, struct gpu_buddy_block, rb);
>> +
>> +    new->subtree_max_alignment = old->subtree_max_alignment;
>> +    new->subtree_block_state = old->subtree_block_state;
>> +
>> +    gpu_buddy_augment_compute(old);
>> +}
>> +
>> +static const struct rb_augment_callbacks gpu_buddy_augment_cb = {
>> +    .propagate = gpu_buddy_augment_propagate,
>> +    .copy      = gpu_buddy_augment_copy,
>> +    .rotate    = gpu_buddy_augment_rotate,
>> +};
>>     static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>>                              struct gpu_buddy_block *parent,
>> @@ -81,6 +604,10 @@ static struct gpu_buddy_block 
>> *gpu_block_alloc(struct gpu_buddy *mm,
>>         BUG_ON(order > GPU_BUDDY_MAX_ORDER);
>>   +    /*
>> +     * GFP_KERNEL is safe under the buddy lock: no consumer runs a
>> +     * shrinker that re-enters it during direct reclaim.
>> +     */
>>       block = kmem_cache_zalloc(slab_blocks, GFP_KERNEL);
>>       if (!block)
>>           return NULL;
>> @@ -101,13 +628,6 @@ static void gpu_block_free(struct gpu_buddy *mm,
>>       kmem_cache_free(slab_blocks, block);
>>   }
>>   -static enum gpu_buddy_free_tree
>> -get_block_tree(struct gpu_buddy_block *block)
>> -{
>> -    return gpu_buddy_block_is_clear(block) ?
>> -           GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
>> -}
>> -
>>   static struct gpu_buddy_block *
>>   rbtree_get_free_block(const struct rb_node *node)
>>   {
>> @@ -120,24 +640,64 @@ rbtree_last_free_block(struct rb_root *root)
>>       return rbtree_get_free_block(rb_last(root));
>>   }
>>   -static bool rbtree_is_empty(struct rb_root *root)
>> +static struct gpu_buddy_block *
>> +rbtree_last_clear_free_block(struct rb_root *root,
>> +                 enum gpu_block_state min_block_state)
>>   {
>> -    return RB_EMPTY_ROOT(root);
>> +    struct rb_node *node = root->rb_node;
>> +    struct gpu_buddy_block *block = NULL;
>> +    struct gpu_buddy_block *root_block;
>> +    enum gpu_block_state target_state;
>> +
>> +    root_block = rbtree_get_free_block(node);
>> +    if (!root_block || root_block->subtree_block_state < 
>> min_block_state)
>> +        return NULL;
>> +
>> +    target_state = root_block->subtree_block_state;
>> +
>> +    while (node) {
>> +        struct gpu_buddy_block *right_block;
>> +        struct gpu_buddy_block *node_block;
>> +
>> +        node_block = rbtree_get_free_block(node);
>> +        right_block = rbtree_get_free_block(node->rb_right);
>> +
>> +        if (right_block && right_block->subtree_block_state >= 
>> target_state) {
>> +            node = node->rb_right;
>> +            continue;
>> +        }
>> +
>> +        if (gpu_block_cached_state(node_block) == target_state) {
>> +            block = node_block;
>> +            break;
>> +        }
>> +
>> +        node = node->rb_left;
>> +    }
>> +
>> +    return block;
>> +}
>> +
>> +static inline void gpu_buddy_sync_clear_avail(struct gpu_buddy *mm)
>> +{
>> +    mm->clear_avail = mm->avail - mm->dirty.total_dirty;
>>   }
>>     static void rbtree_insert(struct gpu_buddy *mm,
>> -              struct gpu_buddy_block *block,
>> -              enum gpu_buddy_free_tree tree)
>> +              struct gpu_buddy_block *block)
>>   {
>>       struct rb_node **link, *parent = NULL;
>> -    unsigned int block_alignment, order;
>> +    enum gpu_block_state block_state;
>>       struct gpu_buddy_block *node;
>> +    unsigned int block_alignment;
>>       struct rb_root *root;
>> +    unsigned int order;
>>         order = gpu_buddy_block_order(block);
>>       block_alignment = gpu_buddy_block_offset_alignment(block);
>> +    block_state = gpu_block_cached_state(block);
>>   -    root = &mm->free_trees[tree][order];
>> +    root = &mm->free_tree[order];
>>       link = &root->rb_node;
>>         while (*link) {
>> @@ -147,10 +707,12 @@ static void rbtree_insert(struct gpu_buddy *mm,
>>            * Manual augmentation update during insertion traversal. 
>> Required
>>            * because rb_insert_augmented() only calls rotate callback 
>> during
>>            * rotations. This ensures all ancestors on the insertion 
>> path have
>> -         * correct subtree_max_alignment values.
>> +         * correct subtree_max_alignment / subtree_block_state values.
>>            */
>>           if (node->subtree_max_alignment < block_alignment)
>>               node->subtree_max_alignment = block_alignment;
>> +        if (node->subtree_block_state < block_state)
>> +            node->subtree_block_state = block_state;
>>             if (gpu_buddy_block_offset(block) < 
>> gpu_buddy_block_offset(node))
>>               link = &parent->rb_left;
>> @@ -159,6 +721,7 @@ static void rbtree_insert(struct gpu_buddy *mm,
>>       }
>>         block->subtree_max_alignment = block_alignment;
>> +    block->subtree_block_state = block_state;
>>       rb_link_node(&block->rb, parent, link);
>>       rb_insert_augmented(&block->rb, root, &gpu_buddy_augment_cb);
>>   }
>> @@ -167,26 +730,11 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>                 struct gpu_buddy_block *block)
>>   {
>>       unsigned int order = gpu_buddy_block_order(block);
>> -    enum gpu_buddy_free_tree tree;
>> -    struct rb_root *root;
>>   -    tree = get_block_tree(block);
>> -    root = &mm->free_trees[tree][order];
>> -
>> -    rb_erase_augmented(&block->rb, root, &gpu_buddy_augment_cb);
>> +    rb_erase_augmented(&block->rb, &mm->free_tree[order], 
>> &gpu_buddy_augment_cb);
>>       RB_CLEAR_NODE(&block->rb);
>>   }
>>   -static void clear_reset(struct gpu_buddy_block *block)
>> -{
>> -    block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>> -}
>> -
>> -static void mark_cleared(struct gpu_buddy_block *block)
>> -{
>> -    block->header |= GPU_BUDDY_HEADER_CLEAR;
>> -}
>> -
>>   static void mark_allocated(struct gpu_buddy *mm,
>>                  struct gpu_buddy_block *block)
>>   {
>> @@ -199,21 +747,36 @@ static void mark_allocated(struct gpu_buddy *mm,
>>       rbtree_remove(mm, block);
>>   }
>>   -static void mark_free(struct gpu_buddy *mm,
>> -              struct gpu_buddy_block *block)
>> +static void __mark_free(struct gpu_buddy *mm,
>> +            struct gpu_buddy_block *block,
>> +            enum gpu_block_state block_state)
>>   {
>> -    enum gpu_buddy_free_tree tree;
>> -
>>       if (gpu_buddy_block_is_allocated(block))
>> mm->used_scoreboard[gpu_buddy_block_order(block)]--;
>>         block->header &= ~GPU_BUDDY_HEADER_STATE;
>>       block->header |= GPU_BUDDY_FREE;
>>   +    block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>> +
>> +    block->has_clear = (block_state != GPU_BLOCK_DIRTY);
>> +    if (block_state == GPU_BLOCK_CLEAR)
>> +        block->header |= GPU_BUDDY_HEADER_CLEAR;
>> +
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>   -    tree = get_block_tree(block);
>> -    rbtree_insert(mm, block, tree);
>> +    rbtree_insert(mm, block);
>> +}
>> +
>> +static void mark_free(struct gpu_buddy *mm,
>> +              struct gpu_buddy_block *block)
>> +{
>> +    enum gpu_block_state block_state;
>> +
>> +    block_state = gpu_dirty_range_state(&mm->dirty,
>> +                        gpu_buddy_block_offset(block),
>> +                        gpu_buddy_block_size(mm, block));
>> +    __mark_free(mm, block, block_state);
>>   }
>>     static void mark_split(struct gpu_buddy *mm,
>> @@ -253,37 +816,31 @@ __get_buddy(struct gpu_buddy_block *block)
>>   }
>>     static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
>> -                     struct gpu_buddy_block *block,
>> -                     bool force_merge)
>> +                     struct gpu_buddy_block *block)
>>   {
>> +    enum gpu_block_state block_state;
>>       struct gpu_buddy_block *parent;
>>       unsigned int order;
>>   -    while ((parent = block->parent)) {
>> -        struct gpu_buddy_block *buddy;
>> +    block_state = gpu_block_cached_state(block);
>>   -        buddy = __get_buddy(block);
>> +    while ((parent = block->parent)) {
>> +        struct gpu_buddy_block *buddy = __get_buddy(block);
>>             if (!gpu_buddy_block_is_free(buddy))
>>               break;
>>   -        if (!force_merge) {
>> -            /*
>> -             * Check the block and its buddy clear state and exit
>> -             * the loop if they both have the dissimilar state.
>> -             */
>> -            if (gpu_buddy_block_is_clear(block) !=
>> -                gpu_buddy_block_is_clear(buddy))
>> -                break;
>> +        if (block_state != GPU_BLOCK_MIXED) {
>> +            enum gpu_block_state buddy_state;
>>   -            if (gpu_buddy_block_is_clear(block))
>> -                mark_cleared(parent);
>> +            buddy_state = gpu_block_cached_state(buddy);
>> +
>> +            if (buddy_state != block_state)
>> +                block_state = GPU_BLOCK_MIXED;
>>           }
>>             rbtree_remove(mm, buddy);
>> mm->free_scoreboard[gpu_buddy_block_order(buddy)]--;
>> -        if (force_merge && gpu_buddy_block_is_clear(buddy))
>> -            mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
>>             if (gpu_buddy_block_is_allocated(block))
>> mm->used_scoreboard[gpu_buddy_block_order(block)]--;
>> @@ -295,74 +852,11 @@ static unsigned int __gpu_buddy_free(struct 
>> gpu_buddy *mm,
>>       }
>>         order = gpu_buddy_block_order(block);
>> -    mark_free(mm, block);
>> +    __mark_free(mm, block, block_state);
>>         return order;
>>   }
>>   -static int __force_merge(struct gpu_buddy *mm,
>> -             u64 start,
>> -             u64 end,
>> -             unsigned int min_order)
>> -{
>> -    unsigned int tree, order;
>> -    int i;
>> -
>> -    if (!min_order)
>> -        return -ENOMEM;
>> -
>> -    if (min_order > mm->max_order)
>> -        return -EINVAL;
>> -
>> -    for_each_free_tree(tree) {
>> -        for (i = min_order - 1; i >= 0; i--) {
>> -            struct rb_node *iter = rb_last(&mm->free_trees[tree][i]);
>> -
>> -            while (iter) {
>> -                struct gpu_buddy_block *block, *buddy;
>> -                u64 block_start, block_end;
>> -
>> -                block = rbtree_get_free_block(iter);
>> -                iter = rb_prev(iter);
>> -
>> -                if (!block || !block->parent)
>> -                    continue;
>> -
>> -                block_start = gpu_buddy_block_offset(block);
>> -                block_end = block_start + gpu_buddy_block_size(mm, 
>> block) - 1;
>> -
>> -                if (!contains(start, end, block_start, block_end))
>> -                    continue;
>> -
>> -                buddy = __get_buddy(block);
>> -                if (!gpu_buddy_block_is_free(buddy))
>> -                    continue;
>> -
>> - gpu_buddy_assert(gpu_buddy_block_is_clear(block) !=
>> -                         gpu_buddy_block_is_clear(buddy));
>> -
>> -                /*
>> -                 * Advance to the next node when the current node is 
>> the buddy,
>> -                 * as freeing the block will also remove its buddy 
>> from the tree.
>> -                 */
>> -                if (iter == &buddy->rb)
>> -                    iter = rb_prev(iter);
>> -
>> -                rbtree_remove(mm, block);
>> - mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>> -                if (gpu_buddy_block_is_clear(block))
>> -                    mm->clear_avail -= gpu_buddy_block_size(mm, block);
>> -
>> -                order = __gpu_buddy_free(mm, block, true);
>> -                if (order >= min_order)
>> -                    return 0;
>> -            }
>> -        }
>> -    }
>> -
>> -    return -ENOMEM;
>> -}
>> -
>>   /**
>>    * gpu_buddy_init - init memory manager
>>    *
>> @@ -377,7 +871,7 @@ static int __force_merge(struct gpu_buddy *mm,
>>    */
>>   int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>>   {
>> -    unsigned int i, j, root_count = 0;
>> +    unsigned int root_count = 0;
>>       u64 offset = 0;
>>         if (size < chunk_size)
>> @@ -411,22 +905,14 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>       if (!mm->used_scoreboard)
>>           goto out_free_free_scoreboard;
>>   -    mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
>> -                       sizeof(*mm->free_trees),
>> -                       GFP_KERNEL);
>> -    if (!mm->free_trees)
>> +    mm->free_tree = kcalloc(mm->max_order + 1,
>> +                sizeof(struct rb_root),
>> +                GFP_KERNEL);
>> +    if (!mm->free_tree)
>>           goto out_free_used_scoreboard;
>>   -    for_each_free_tree(i) {
>> -        mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
>> -                          sizeof(struct rb_root),
>> -                          GFP_KERNEL);
>> -        if (!mm->free_trees[i])
>> -            goto out_free_tree;
>> -
>> -        for (j = 0; j <= mm->max_order; ++j)
>> -            mm->free_trees[i][j] = RB_ROOT;
>> -    }
>> +    if (gpu_dirty_tracker_init(&mm->dirty))
>> +        goto out_free_tree;
>>         mm->n_roots = hweight64(size);
>>   @@ -452,7 +938,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>           if (!root)
>>               goto out_free_roots;
>>   -        mark_free(mm, root);
>> +        gpu_dirty_tracker_mark_dirty(&mm->dirty, offset, root_size);
>> +        __mark_free(mm, root, GPU_BLOCK_DIRTY);
>>             BUG_ON(root_count > mm->max_order);
>>           BUG_ON(gpu_buddy_block_size(mm, root) < chunk_size);
>> @@ -474,9 +961,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>           gpu_block_free(mm, mm->roots[root_count]);
>>       kfree(mm->roots);
>>   out_free_tree:
>> -    while (i--)
>> -        kfree(mm->free_trees[i]);
>> -    kfree(mm->free_trees);
>> +    gpu_dirty_tracker_fini(&mm->dirty);
>> +    kfree(mm->free_tree);
>>   out_free_used_scoreboard:
>>       kfree(mm->used_scoreboard);
>>   out_free_free_scoreboard:
>> @@ -494,7 +980,7 @@ EXPORT_SYMBOL(gpu_buddy_init);
>>    */
>>   void gpu_buddy_fini(struct gpu_buddy *mm)
>>   {
>> -    u64 root_size, size, start;
>> +    u64 root_size, size;
>>       unsigned int order;
>>       int i;
>>   @@ -502,14 +988,10 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
>>         for (i = 0; i < mm->n_roots; ++i) {
>>           order = ilog2(size) - ilog2(mm->chunk_size);
>> -        start = gpu_buddy_block_offset(mm->roots[i]);
>> -        __force_merge(mm, start, start + size, order);
>> +        root_size = mm->chunk_size << order;
>> gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]));
>> -
>>           gpu_block_free(mm, mm->roots[i]);
>> -
>> -        root_size = mm->chunk_size << order;
>>           size -= root_size;
>>       }
>>   @@ -518,9 +1000,8 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
>>       for (i = 0; i <= mm->max_order; ++i)
>>           gpu_buddy_assert(!mm->used_scoreboard[i]);
>>   -    for_each_free_tree(i)
>> -        kfree(mm->free_trees[i]);
>> -    kfree(mm->free_trees);
>> +    gpu_dirty_tracker_fini(&mm->dirty);
>> +    kfree(mm->free_tree);
>>       kfree(mm->roots);
>>       kfree(mm->free_scoreboard);
>>       kfree(mm->used_scoreboard);
>> @@ -532,6 +1013,7 @@ static int split_block(struct gpu_buddy *mm,
>>   {
>>       unsigned int block_order = gpu_buddy_block_order(block) - 1;
>>       u64 offset = gpu_buddy_block_offset(block);
>> +    enum gpu_block_state parent_state;
>>         BUG_ON(!gpu_buddy_block_is_free(block));
>>       BUG_ON(!gpu_buddy_block_order(block));
>> @@ -547,17 +1029,18 @@ static int split_block(struct gpu_buddy *mm,
>>           return -ENOMEM;
>>       }
>>   +    parent_state = gpu_block_cached_state(block);
>> +
>>       mark_split(mm, block);
>>   -    if (gpu_buddy_block_is_clear(block)) {
>> -        mark_cleared(block->left);
>> -        mark_cleared(block->right);
>> -        clear_reset(block);
>> +    if (parent_state == GPU_BLOCK_MIXED) {
>> +        mark_free(mm, block->left);
>> +        mark_free(mm, block->right);
>> +    } else {
>> +        __mark_free(mm, block->left, parent_state);
>> +        __mark_free(mm, block->right, parent_state);
>>       }
>>   -    mark_free(mm, block->left);
>> -    mark_free(mm, block->right);
>> -
>>       return 0;
>>   }
>>   @@ -572,42 +1055,39 @@ static int split_block(struct gpu_buddy *mm,
>>    */
>>   void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear)
>>   {
>> -    enum gpu_buddy_free_tree src_tree, dst_tree;
>> -    u64 root_size, size, start;
>> -    unsigned int order;
>> -    int i;
>> +    unsigned int i;
>>         gpu_buddy_driver_lock_held(mm);
>> -    size = mm->size;
>> -    for (i = 0; i < mm->n_roots; ++i) {
>> -        order = ilog2(size) - ilog2(mm->chunk_size);
>> -        start = gpu_buddy_block_offset(mm->roots[i]);
>> -        __force_merge(mm, start, start + size, order);
>>   -        root_size = mm->chunk_size << order;
>> -        size -= root_size;
>> -    }
>> -
>> -    src_tree = is_clear ? GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
>> -    dst_tree = is_clear ? GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
>> +    gpu_dirty_tracker_empty(&mm->dirty);
>>         for (i = 0; i <= mm->max_order; ++i) {
>> -        struct rb_root *root = &mm->free_trees[src_tree][i];
>>           struct gpu_buddy_block *block, *tmp;
>>   -        rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
>> -            rbtree_remove(mm, block);
>> +        rbtree_postorder_for_each_entry_safe(block, tmp,
>> +                             &mm->free_tree[i], rb) {
>>               if (is_clear) {
>> -                mark_cleared(block);
>> -                mm->clear_avail += gpu_buddy_block_size(mm, block);
>> +                if (!gpu_buddy_block_is_clear(block))
>> +                    block->header |= GPU_BUDDY_HEADER_CLEAR;
>> +                block->has_clear = true;
>> +            } else if (gpu_buddy_block_is_clear(block)) {
>> +                block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>> +                block->has_clear = false;
>> +                gpu_dirty_tracker_mark_dirty(&mm->dirty,
>> +                                 gpu_buddy_block_offset(block),
>> +                                 gpu_buddy_block_size(mm, block));
>>               } else {
>> -                clear_reset(block);
>> -                mm->clear_avail -= gpu_buddy_block_size(mm, block);
>> +                block->has_clear = false;
>> +                gpu_dirty_tracker_mark_dirty(&mm->dirty,
>> +                                 gpu_buddy_block_offset(block),
>> +                                 gpu_buddy_block_size(mm, block));
>>               }
>>   -            rbtree_insert(mm, block, dst_tree);
>> +            gpu_buddy_augment_compute(block);
>>           }
>>       }
>> +
>> +    gpu_buddy_sync_clear_avail(mm);
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_reset_clear);
>>   @@ -620,13 +1100,18 @@ EXPORT_SYMBOL(gpu_buddy_reset_clear);
>>   void gpu_buddy_free_block(struct gpu_buddy *mm,
>>                 struct gpu_buddy_block *block)
>>   {
>> +    u64 size = gpu_buddy_block_size(mm, block);
>> +    u64 offset = gpu_buddy_block_offset(block);
>> +
>>       gpu_buddy_driver_lock_held(mm);
>>       BUG_ON(!gpu_buddy_block_is_allocated(block));
>> -    mm->avail += gpu_buddy_block_size(mm, block);
>> -    if (gpu_buddy_block_is_clear(block))
>> -        mm->clear_avail += gpu_buddy_block_size(mm, block);
>>   -    __gpu_buddy_free(mm, block, false);
>> +    mm->avail += size;
>> +    if (!gpu_buddy_block_is_clear(block))
>> +        gpu_dirty_tracker_mark_dirty(&mm->dirty, offset, size);
>> +
>> +    gpu_buddy_sync_clear_avail(mm);
>> +    __gpu_buddy_free(mm, block);
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_free_block);
>>   @@ -641,9 +1126,9 @@ static void __gpu_buddy_free_list(struct 
>> gpu_buddy *mm,
>>         list_for_each_entry_safe(block, on, objects, link) {
>>           if (mark_clear)
>> -            mark_cleared(block);
>> +            block->header |= GPU_BUDDY_HEADER_CLEAR;
>>           else if (mark_dirty)
>> -            clear_reset(block);
>> +            block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>>           gpu_buddy_free_block(mm, block);
>>           cond_resched();
>>       }
>> @@ -679,13 +1164,6 @@ void gpu_buddy_free_list(struct gpu_buddy *mm,
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_free_list);
>>   -static bool block_incompatible(struct gpu_buddy_block *block, 
>> unsigned int flags)
>> -{
>> -    bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
>> -
>> -    return needs_clear != gpu_buddy_block_is_clear(block);
>> -}
>> -
>>   static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
>>                       struct gpu_buddy_block *block)
>>   {
>> @@ -696,7 +1174,7 @@ static void __gpu_buddy_undo_splits(struct 
>> gpu_buddy *mm,
>>            gpu_buddy_block_is_free(buddy))) {
>>           rbtree_remove(mm, block);
>> mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>> -        __gpu_buddy_free(mm, block, false);
>> +        __gpu_buddy_free(mm, block);
>>       }
>>   }
>>   @@ -704,8 +1182,7 @@ static struct gpu_buddy_block *
>>   __alloc_range_bias(struct gpu_buddy *mm,
>>              u64 start, u64 end,
>>              unsigned int order,
>> -           unsigned long flags,
>> -           bool fallback)
>> +           unsigned long flags)
>>   {
>>       u64 req_size = mm->chunk_size << order;
>>       struct gpu_buddy_block *block;
>> @@ -715,7 +1192,15 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>         end = end - 1;
>>   -    for (i = 0; i < mm->n_roots; ++i)
>> +    /*
>> +     * This range-constrained search hands back the highest/right-most
>> +     * address that satisfies the request: the roots are seeded 
>> high-to-low
>> +     * and the right (higher-address) child is descended first, making
>> +     * top-down the default placement here. A non-top-down clear 
>> request is
>> +     * the only exception, where the descent is biased towards clear or
>> +     * clear-containing subtrees to satisfy the clear preference.
>> +     */
>> +    for (i = mm->n_roots - 1; i >= 0; --i)
>>           list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>>         do {
>> @@ -751,9 +1236,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   continue;
>>           }
>>   -        if (!fallback && block_incompatible(block, flags))
>> -            continue;
>> -
>>           if (contains(start, end, block_start, block_end) &&
>>               order == gpu_buddy_block_order(block)) {
>>               /*
>> @@ -771,8 +1253,38 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   goto err_undo;
>>           }
>>   -        list_add(&block->right->tmp_link, &dfs);
>> -        list_add(&block->left->tmp_link, &dfs);
>> +        /*
>> +         * Top-down is a strict address-placement policy, so when it is
>> +         * requested we ignore clear steering and simply descend the
>> +         * right (higher-address) child first. Only a non-top-down 
>> clear
>> +         * request biases the descent towards clear/has_clear subtrees.
>> +         */
>> +        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>> +            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>> +            struct gpu_buddy_block *prefer;
>> +
>> +            if (gpu_buddy_block_is_clear(block->right))
>> +                prefer = block->right;
>> +            else if (gpu_buddy_block_is_clear(block->left))
>> +                prefer = block->left;
>> +            else if (block->right->has_clear)
>> +                prefer = block->right;
>> +            else if (block->left->has_clear)
>> +                prefer = block->left;
>> +            else
>> +                prefer = block->right;
>> +
>> +            if (prefer == block->right) {
>> +                list_add(&block->left->tmp_link, &dfs);
>> +                list_add(&block->right->tmp_link, &dfs);
>> +            } else {
>> +                list_add(&block->right->tmp_link, &dfs);
>> +                list_add(&block->left->tmp_link, &dfs);
>> +            }
>> +        } else {
>> +            list_add(&block->left->tmp_link, &dfs);
>> +            list_add(&block->right->tmp_link, &dfs);
>> +        }
>>       } while (1);
>>         return ERR_PTR(-ENOSPC);
>> @@ -787,48 +1299,32 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>       return ERR_PTR(err);
>>   }
>>   -static struct gpu_buddy_block *
>> -__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
>> -                 u64 start, u64 end,
>> -                 unsigned int order,
>> -                 unsigned long flags)
>> -{
>> -    struct gpu_buddy_block *block;
>> -    bool fallback = false;
>> -
>> -    block = __alloc_range_bias(mm, start, end, order,
>> -                   flags, fallback);
>> -    if (IS_ERR(block))
>> -        return __alloc_range_bias(mm, start, end, order,
>> -                      flags, !fallback);
>> -
>> -    return block;
>> -}
>> -
>> +/* Return the highest-address free block of at least @order. */
>>   static struct gpu_buddy_block *
>>   get_maxblock(struct gpu_buddy *mm,
>> -         unsigned int order,
>> -         enum gpu_buddy_free_tree tree)
>> +         unsigned int order)
>>   {
>> -    struct gpu_buddy_block *max_block = NULL, *block = NULL;
>> -    struct rb_root *root;
>> +    struct gpu_buddy_block *max_block;
>> +    struct gpu_buddy_block *block;
>>       unsigned int i;
>>   +    /*
>> +     * Top-down allocation is a strict address-placement policy: the 
>> block
>> +     * is chosen purely by offset, regardless of its clear/dirty state.
>> +     * Clear state is re-derived from the dirty tracker once the 
>> allocation
>> +     * completes, and the driver is responsible for issuing the 
>> clear pass
>> +     * if a clear region is required.
>> +     */
>> +    max_block = NULL;
>> +
>>       for (i = order; i <= mm->max_order; ++i) {
>> -        root = &mm->free_trees[tree][i];
>> -        block = rbtree_last_free_block(root);
>> +        block = rbtree_last_free_block(&mm->free_tree[i]);
>>           if (!block)
>>               continue;
>>   -        if (!max_block) {
>> -            max_block = block;
>> -            continue;
>> -        }
>> -
>> -        if (gpu_buddy_block_offset(block) >
>> -            gpu_buddy_block_offset(max_block)) {
>> +        if (!max_block ||
>> +            gpu_buddy_block_offset(block) > 
>> gpu_buddy_block_offset(max_block))
>>               max_block = block;
>> -        }
>>       }
>>         return max_block;
>> @@ -840,45 +1336,34 @@ alloc_from_freetree(struct gpu_buddy *mm,
>>               unsigned long flags)
>>   {
>>       struct gpu_buddy_block *block = NULL;
>> -    struct rb_root *root;
>> -    enum gpu_buddy_free_tree tree;
>>       unsigned int tmp;
>>       int err;
>>   -    tree = (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
>> -        GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
>> -
>>       if (flags & GPU_BUDDY_TOPDOWN_ALLOCATION) {
>> -        block = get_maxblock(mm, order, tree);
>> +        block = get_maxblock(mm, order);
>>           if (block)
>> -            /* Store the obtained block order */
>>               tmp = gpu_buddy_block_order(block);
>>       } else {
>> -        for (tmp = order; tmp <= mm->max_order; ++tmp) {
>> -            /* Get RB tree root for this order and tree */
>> -            root = &mm->free_trees[tree][tmp];
>> -            block = rbtree_last_free_block(root);
>> -            if (block)
>> -                break;
>> +        if (flags & GPU_BUDDY_CLEAR_ALLOCATION) {
>> +            for (tmp = order; tmp <= mm->max_order; ++tmp) {
>> +                block = 
>> rbtree_last_clear_free_block(&mm->free_tree[tmp],
>> +                                     GPU_BLOCK_MIXED);
>> +                if (block)
>> +                    break;
>> +            }
>>           }
>> -    }
>> -
>> -    if (!block) {
>> -        /* Try allocating from the other tree */
>> -        tree = (tree == GPU_BUDDY_CLEAR_TREE) ?
>> -            GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
>> -
>> -        for (tmp = order; tmp <= mm->max_order; ++tmp) {
>> -            root = &mm->free_trees[tree][tmp];
>> -            block = rbtree_last_free_block(root);
>> -            if (block)
>> -                break;
>> +        if (!block) {
>> +            for (tmp = order; tmp <= mm->max_order; ++tmp) {
>> +                block = rbtree_last_free_block(&mm->free_tree[tmp]);
>> +                if (block)
>> +                    break;
>> +            }
>>           }
>> -
>> -        if (!block)
>> -            return ERR_PTR(-ENOSPC);
>>       }
>>   +    if (!block)
>> +        return ERR_PTR(-ENOSPC);
>> +
>>       BUG_ON(!gpu_buddy_block_is_free(block));
>>         while (tmp != order) {
>> @@ -886,7 +1371,26 @@ alloc_from_freetree(struct gpu_buddy *mm,
>>           if (unlikely(err))
>>               goto err_undo;
>>   -        block = block->right;
>> +        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>> +            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>> +            bool right_clear, left_clear;
>> +
>> +            right_clear = gpu_buddy_block_is_clear(block->right);
>> +            left_clear = gpu_buddy_block_is_clear(block->left);
>> +
>> +            if (right_clear)
>> +                block = block->right;
>> +            else if (left_clear)
>> +                block = block->left;
>> +            else if (block->right->has_clear)
>> +                block = block->right;
>> +            else if (block->left->has_clear)
>> +                block = block->left;
>> +            else
>> +                block = block->right;
>> +        } else {
>> +            block = block->right;
>> +        }
>>           tmp--;
>>       }
>>       return block;
>> @@ -913,12 +1417,10 @@ static bool 
>> gpu_buddy_subtree_can_satisfy(struct rb_node *node,
>>     static struct gpu_buddy_block *
>>   gpu_buddy_find_block_aligned(struct gpu_buddy *mm,
>> -                 enum gpu_buddy_free_tree tree,
>>                    unsigned int order,
>> -                 unsigned int alignment,
>> -                 unsigned long flags)
>> +                 unsigned int alignment)
>>   {
>> -    struct rb_root *root = &mm->free_trees[tree][order];
>> +    struct rb_root *root = &mm->free_tree[order];
>>       struct rb_node *rb = root->rb_node;
>>         while (rb) {
>> @@ -951,12 +1453,10 @@ gpu_buddy_find_block_aligned(struct gpu_buddy 
>> *mm,
>>   static struct gpu_buddy_block *
>>   gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
>>                       u64 size,
>> -                    u64 min_block_size,
>> -                    unsigned long flags)
>> +                    u64 min_block_size)
>>   {
>>       struct gpu_buddy_block *block = NULL;
>>       unsigned int order, tmp, alignment;
>> -    enum gpu_buddy_free_tree tree;
>>       unsigned long pages;
>>       int err;
>>   @@ -964,19 +1464,15 @@ gpu_buddy_offset_aligned_allocation(struct 
>> gpu_buddy *mm,
>>       pages = size >> ilog2(mm->chunk_size);
>>       order = fls(pages) - 1;
>>   -    tree = (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
>> -        GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
>> -
>> +    /*
>> +     * Offset-aligned allocation is a strict address-placement 
>> policy: the
>> +     * block is chosen purely by its offset alignment, regardless of 
>> its
>> +     * clear/dirty state. Clear state is re-derived from the dirty 
>> tracker
>> +     * once the allocation completes, and the driver is responsible for
>> +     * issuing the clear pass if a clear region is required.
>> +     */
>>       for (tmp = order; tmp <= mm->max_order; ++tmp) {
>> -        block = gpu_buddy_find_block_aligned(mm, tree, tmp,
>> -                             alignment, flags);
>> -        if (!block) {
>> -            tree = (tree == GPU_BUDDY_CLEAR_TREE) ?
>> -                GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
>> -            block = gpu_buddy_find_block_aligned(mm, tree, tmp,
>> -                                 alignment, flags);
>> -        }
>> -
>> +        block = gpu_buddy_find_block_aligned(mm, tmp, alignment);
>>           if (block)
>>               break;
>>       }
>> @@ -1015,6 +1511,7 @@ gpu_buddy_offset_aligned_allocation(struct 
>> gpu_buddy *mm,
>>   static int __alloc_range(struct gpu_buddy *mm,
>>                struct list_head *dfs,
>>                u64 start, u64 size,
>> +             unsigned long flags,
>>                struct list_head *blocks,
>>                u64 *total_allocated_on_err)
>>   {
>> @@ -1051,16 +1548,33 @@ static int __alloc_range(struct gpu_buddy *mm,
>>             if (contains(start, end, block_start, block_end)) {
>>               if (gpu_buddy_block_is_free(block)) {
>> +                bool block_clear = false;
>> +                u64 block_offset;
>> +                u64 block_size;
>> +
>> +                block_size = gpu_buddy_block_size(mm, block);
>> +                block_offset = gpu_buddy_block_offset(block);
>> +
>> +                if (flags & GPU_BUDDY_CLEAR_ALLOCATION)
>> +                    block_clear = gpu_buddy_block_is_clear(block);
>> +
>> +                if (!gpu_buddy_block_is_clear(block))
>> + gpu_dirty_tracker_remove_range(&mm->dirty,
>> +                                       block_offset,
>> +                                       block_size);
>> +
>>                   mark_allocated(mm, block);
>> -                total_allocated += gpu_buddy_block_size(mm, block);
>> -                mm->avail -= gpu_buddy_block_size(mm, block);
>> -                if (gpu_buddy_block_is_clear(block))
>> -                    mm->clear_avail -= gpu_buddy_block_size(mm, block);
>> +                total_allocated += block_size;
>> +                mm->avail -= block_size;
>> +
>> +                block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>> +                if (block_clear)
>> +                    block->header |= GPU_BUDDY_HEADER_CLEAR;
>> +
>> +                gpu_buddy_sync_clear_avail(mm);
>> +
>>                   list_add_tail(&block->link, &allocated);
>>                   continue;
>> -            } else if (!mm->clear_avail) {
>> -                err = -ENOSPC;
>> -                goto err_free;
>>               }
>>           }
>>   @@ -1105,6 +1619,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>>   static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
>>                      u64 start,
>>                      u64 size,
>> +                   unsigned long flags,
>>                      u64 *total_allocated_on_err,
>>                      struct list_head *blocks)
>>   {
>> @@ -1114,20 +1629,23 @@ static int __gpu_buddy_alloc_range(struct 
>> gpu_buddy *mm,
>>       for (i = 0; i < mm->n_roots; ++i)
>>           list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>>   -    return __alloc_range(mm, &dfs, start, size,
>> +    return __alloc_range(mm, &dfs, start, size, flags,
>>                    blocks, total_allocated_on_err);
>>   }
>>     static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>                        u64 size,
>>                        u64 min_block_size,
>> +                     unsigned long flags,
>>                        struct list_head *blocks)
>>   {
>>       u64 rhs_offset, lhs_offset, lhs_size, filled;
>>       struct gpu_buddy_block *block;
>> -    unsigned int tree, order;
>>       LIST_HEAD(blocks_lhs);
>> +    struct rb_root *root;
>> +    struct rb_node *iter;
>>       unsigned long pages;
>> +    unsigned int order;
>>       u64 modify_size;
>>       int err;
>>   @@ -1137,45 +1655,40 @@ static int __alloc_contig_try_harder(struct 
>> gpu_buddy *mm,
>>       if (order == 0)
>>           return -ENOSPC;
>>   -    for_each_free_tree(tree) {
>> -        struct rb_root *root;
>> -        struct rb_node *iter;
>> -
>> -        root = &mm->free_trees[tree][order];
>> -        if (rbtree_is_empty(root))
>> -            continue;
>> +    root = &mm->free_tree[order];
>> +    if (RB_EMPTY_ROOT(root))
>> +        return -ENOSPC;
>>   -        iter = rb_last(root);
>> -        while (iter) {
>> -            block = rbtree_get_free_block(iter);
>> -
>> -            /* Allocate blocks traversing RHS */
>> -            rhs_offset = gpu_buddy_block_offset(block);
>> -            err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>> -                               &filled, blocks);
>> -            if (!err || err != -ENOSPC)
>> -                return err;
>> -
>> -            lhs_size = max((size - filled), min_block_size);
>> -            if (!IS_ALIGNED(lhs_size, min_block_size))
>> -                lhs_size = round_up(lhs_size, min_block_size);
>> -
>> -            /* Allocate blocks traversing LHS */
>> -            lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
>> -            err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
>> -                               NULL, &blocks_lhs);
>> -            if (!err) {
>> -                list_splice(&blocks_lhs, blocks);
>> -                return 0;
>> -            } else if (err != -ENOSPC) {
>> -                gpu_buddy_free_list_internal(mm, blocks);
>> -                return err;
>> -            }
>> -            /* Free blocks for the next iteration */
>> +    iter = rb_last(root);
>> +    while (iter) {
>> +        block = rbtree_get_free_block(iter);
>> +
>> +        /* Allocate blocks traversing RHS */
>> +        rhs_offset = gpu_buddy_block_offset(block);
>> +        err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>> +                           flags, &filled, blocks);
>> +        if (!err || err != -ENOSPC)
>> +            return err;
>> +
>> +        lhs_size = max((size - filled), min_block_size);
>> +        if (!IS_ALIGNED(lhs_size, min_block_size))
>> +            lhs_size = round_up(lhs_size, min_block_size);
>> +
>> +        /* Allocate blocks traversing LHS */
>> +        lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
>> +        err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
>> +                           flags, NULL, &blocks_lhs);
>> +        if (!err) {
>> +            list_splice(&blocks_lhs, blocks);
>> +            return 0;
>> +        } else if (err != -ENOSPC) {
>>               gpu_buddy_free_list_internal(mm, blocks);
>> -
>> -            iter = rb_prev(iter);
>> +            return err;
>>           }
>> +        /* Free blocks for the next iteration */
>> +        gpu_buddy_free_list_internal(mm, blocks);
>> +
>> +        iter = rb_prev(iter);
>>       }
>>         return -ENOSPC;
>> @@ -1209,6 +1722,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>       struct gpu_buddy_block *block;
>>       u64 block_start, block_end;
>>       LIST_HEAD(dfs);
>> +    bool was_clear;
>>       u64 new_start;
>>       int err;
>>   @@ -1251,22 +1765,38 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>       }
>>         list_del(&block->link);
>> -    mark_free(mm, block);
>> +
>> +    was_clear = gpu_buddy_block_is_clear(block);
>> +    block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>> +
>> +    if (!was_clear)
>> +        gpu_dirty_tracker_mark_dirty(&mm->dirty,
>> +                         gpu_buddy_block_offset(block),
>> +                         gpu_buddy_block_size(mm, block));
>> +
>> +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>> GPU_BLOCK_DIRTY);
>>       mm->avail += gpu_buddy_block_size(mm, block);
>> -    if (gpu_buddy_block_is_clear(block))
>> -        mm->clear_avail += gpu_buddy_block_size(mm, block);
>> +    gpu_buddy_sync_clear_avail(mm);
>>         /* Prevent recursively freeing this node */
>>       parent = block->parent;
>>       block->parent = NULL;
>>         list_add(&block->tmp_link, &dfs);
>> -    err =  __alloc_range(mm, &dfs, new_start, new_size, blocks, NULL);
>> +    err =  __alloc_range(mm, &dfs, new_start, new_size,
>> +                 was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>> +                 blocks, NULL);
>>       if (err) {
>>           mark_allocated(mm, block);
>>           mm->avail -= gpu_buddy_block_size(mm, block);
>> -        if (gpu_buddy_block_is_clear(block))
>> -            mm->clear_avail -= gpu_buddy_block_size(mm, block);
>> +        if (!was_clear) {
>> +            gpu_dirty_tracker_remove_range(&mm->dirty,
>> +                               gpu_buddy_block_offset(block),
>> +                               gpu_buddy_block_size(mm, block));
>> +        }
>> +        if (was_clear)
>> +            block->header |= GPU_BUDDY_HEADER_CLEAR;
>> +        gpu_buddy_sync_clear_avail(mm);
>>           list_add(&block->link, blocks);
>>       }
>>   @@ -1275,6 +1805,22 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>>   +static bool dirty_steer_window(struct gpu_buddy *mm, u64 req_size,
>> +                   u64 *start, u64 *end, unsigned long *flags)
>> +{
>> +    u64 aligned_start;
>> +    struct gpu_dirty_extent *ext =
>> +        gpu_dirty_tracker_find(&mm->dirty, req_size, &aligned_start);
>> +
>> +    if (!ext)
>> +        return false;
>> +
>> +    *start  = aligned_start;
>> +    *end    = ext->end;
>> +    *flags |= GPU_BUDDY_RANGE_ALLOCATION;
>> +    return true;
>> +}
>> +
>>   static struct gpu_buddy_block *
>>   __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>                u64 start, u64 end,
>> @@ -1282,18 +1828,36 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>                unsigned int order,
>>                unsigned long flags)
>>   {
>> -    if (flags & GPU_BUDDY_RANGE_ALLOCATION)
>> +    struct gpu_buddy_block *block;
>> +    bool steered = false;
>> +
>> +    /* Allocate from dirty tracker */
>> +    if (!(flags & GPU_BUDDY_RANGE_ALLOCATION) &&
>> +        !(flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>> +        size >= min_block_size &&
>> +        mm->clear_avail && mm->dirty.total_dirty) {
>> +        u64 block_size = mm->chunk_size << order;
>> +
>> +        steered = dirty_steer_window(mm, block_size,
>> +                         &start, &end, &flags);
>> +    }
>> +
>> +    if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>>           /* Allocate traversing within the range */
>> -        return  __gpu_buddy_alloc_range_bias(mm, start, end,
>> -                             order, flags);
>> -    else if (size < min_block_size)
>> +        block = __alloc_range_bias(mm, start, end, order, flags);
>> +        if (!IS_ERR(block) || !steered)
>> +            return block;
>> +
>> +        flags &= ~GPU_BUDDY_RANGE_ALLOCATION;
>> +    }
>> +
>> +    if (size < min_block_size)
>>           /* Allocate from an offset-aligned region without size 
>> rounding */
>>           return gpu_buddy_offset_aligned_allocation(mm, size,
>> -                               min_block_size,
>> -                               flags);
>> -    else
>> -        /* Allocate from freetree */
>> -        return alloc_from_freetree(mm, order, flags);
>> +                               min_block_size);
>> +
>> +    /* Allocate from freetree */
>> +    return alloc_from_freetree(mm, order, flags);
>>   }
>>     /**
>> @@ -1354,7 +1918,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>           if (!IS_ALIGNED(start | end, min_block_size))
>>               return -EINVAL;
>>   -        return __gpu_buddy_alloc_range(mm, start, size, NULL, 
>> blocks);
>> +        return __gpu_buddy_alloc_range(mm, start, size, flags, NULL, 
>> blocks);
>>       }
>>         original_size = size;
>> @@ -1380,12 +1944,15 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>           if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
>>               !(flags & GPU_BUDDY_RANGE_ALLOCATION))
>>               return __alloc_contig_try_harder(mm, original_size,
>> -                             original_min_size, blocks);
>> +                             original_min_size,
>> +                             flags, blocks);
>>             return -EINVAL;
>>       }
>>         do {
>> +        bool block_clear = false;
>> +
>>           order = min(order, (unsigned int)fls(pages) - 1);
>>           BUG_ON(order > mm->max_order);
>>           /*
>> @@ -1395,8 +1962,6 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>           BUG_ON(size >= min_block_size && order < min_order);
>>             do {
>> -            unsigned int fallback_order;
>> -
>>               block = __gpu_buddy_alloc_blocks(mm, start,
>>                                end,
>>                                size,
>> @@ -1406,48 +1971,48 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>               if (!IS_ERR(block))
>>                   break;
>>   -            if (size < min_block_size) {
>> -                fallback_order = order;
>> -            } else if (order == min_order) {
>> -                fallback_order = min_order;
>> -            } else {
>> +            if (size >= min_block_size && order > min_order) {
>>                   order--;
>>                   continue;
>>               }
>>   -            /* Try allocation through force merge method */
>> -            if (mm->clear_avail &&
>> -                !__force_merge(mm, start, end, fallback_order)) {
>> -                block = __gpu_buddy_alloc_blocks(mm, start,
>> -                                 end,
>> -                                 size,
>> -                                 min_block_size,
>> -                                 fallback_order,
>> -                                 flags);
>> -                if (!IS_ERR(block)) {
>> -                    order = fallback_order;
>> -                    break;
>> -                }
>> -            }
>> -
>>               /*
>>                * Try contiguous block allocation through
>>                * try harder method.
>>                */
>>               if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
>> -                !(flags & GPU_BUDDY_RANGE_ALLOCATION))
>> -                return __alloc_contig_try_harder(mm,
>> -                                 original_size,
>> -                                 original_min_size,
>> -                                 blocks);
>> +                !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
>> +                err = __alloc_contig_try_harder(mm,
>> +                                original_size,
>> +                                original_min_size,
>> +                                flags,
>> +                                blocks);
>> +                if (!err)
>> +                    return 0;
>> +                if (err != -ENOSPC)
>> +                    return err;
>> +                goto err_free;
>> +            }
>>               err = -ENOSPC;
>>               goto err_free;
>>           } while (1);
>>   +        if (flags & GPU_BUDDY_CLEAR_ALLOCATION)
>> +            block_clear = gpu_buddy_block_is_clear(block);
>> +
>> +        if (!gpu_buddy_block_is_clear(block))
>> +            gpu_dirty_tracker_remove_range(&mm->dirty,
>> +                               gpu_buddy_block_offset(block),
>> +                               gpu_buddy_block_size(mm, block));
>> +
>>           mark_allocated(mm, block);
>>           mm->avail -= gpu_buddy_block_size(mm, block);
>> -        if (gpu_buddy_block_is_clear(block))
>> -            mm->clear_avail -= gpu_buddy_block_size(mm, block);
>> +
>> +        block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>> +        if (block_clear)
>> +            block->header |= GPU_BUDDY_HEADER_CLEAR;
>> +
>> +        gpu_buddy_sync_clear_avail(mm);
>>           kmemleak_update_trace(block);
>>           list_add_tail(&block->link, &allocated);
>>   @@ -1542,6 +2107,7 @@ EXPORT_SYMBOL(gpu_buddy_print);
>>     static void gpu_buddy_module_exit(void)
>>   {
>> +    kmem_cache_destroy(slab_extents);
>>       kmem_cache_destroy(slab_blocks);
>>   }
>>   @@ -1551,7 +2117,15 @@ static int __init gpu_buddy_module_init(void)
>>       if (!slab_blocks)
>>           return -ENOMEM;
>>   +    slab_extents = KMEM_CACHE(gpu_dirty_extent, 0);
>> +    if (!slab_extents)
>> +        goto err_destroy_blocks;
>> +
>>       return 0;
>> +
>> +err_destroy_blocks:
>> +    kmem_cache_destroy(slab_blocks);
>> +    return -ENOMEM;
>>   }
>>     module_init(gpu_buddy_module_init);
>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>> b/drivers/gpu/tests/gpu_buddy_test.c
>> index 89698563c61b..f8e56da5058e 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -38,7 +38,7 @@ static void 
>> gpu_test_buddy_subtree_offset_alignment_stress(struct kunit *test)
>>       };
>>       struct list_head allocated[ARRAY_SIZE(alignments)];
>>       unsigned int i, max_subtree_align = 0;
>> -    int ret, tree, order;
>> +    int ret, order;
>>       struct gpu_buddy mm;
>>         KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, 
>> SZ_4K),
>> @@ -78,15 +78,11 @@ static void 
>> gpu_test_buddy_subtree_offset_alignment_stress(struct kunit *test)
>>           }
>>             for (order = mm.max_order; order >= 0 && !root; order--) {
>> -            for (tree = 0; tree < 2; tree++) {
>> -                node = mm.free_trees[tree][order].rb_node;
>> -                if (node) {
>> -                    root = container_of(node,
>> -                                struct gpu_buddy_block,
>> -                                rb);
>> -                    break;
>> -                }
>> -            }
>> +            node = mm.free_tree[order].rb_node;
>> +            if (node)
>> +                root = container_of(node,
>> +                            struct gpu_buddy_block,
>> +                            rb);
>>           }
>>             KUNIT_ASSERT_NOT_NULL(test, root);
>> @@ -97,15 +93,13 @@ static void 
>> gpu_test_buddy_subtree_offset_alignment_stress(struct kunit *test)
>>           gpu_buddy_free_list(&mm, &allocated[i], 0);
>>             for (order = 0; order <= mm.max_order; order++) {
>> -            for (tree = 0; tree < 2; tree++) {
>> -                node = mm.free_trees[tree][order].rb_node;
>> -                if (!node)
>> -                    continue;
>> -
>> -                block = container_of(node, struct gpu_buddy_block, rb);
>> -                max_subtree_align = max(max_subtree_align,
>> -                            block->subtree_max_alignment);
>> -            }
>> +            node = mm.free_tree[order].rb_node;
>> +            if (!node)
>> +                continue;
>> +
>> +            block = container_of(node, struct gpu_buddy_block, rb);
>> +            max_subtree_align = max(max_subtree_align,
>> +                        block->subtree_max_alignment);
>>           }
>>             KUNIT_EXPECT_GE(test, max_subtree_align, 
>> ilog2(alignments[i]));
>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>> index e037714563d8..899b84298cd8 100644
>> --- a/include/linux/gpu_buddy.h
>> +++ b/include/linux/gpu_buddy.h
>> @@ -8,6 +8,7 @@
>>     #include <linux/bitops.h>
>>   #include <linux/list.h>
>> +#include <linux/mempool.h>
>>   #include <linux/slab.h>
>>   #include <linux/sched.h>
>>   #include <linux/rbtree.h>
>> @@ -43,8 +44,8 @@
>>   /**
>>    * GPU_BUDDY_CLEAR_ALLOCATION - Prefer pre-cleared (zeroed) memory
>>    *
>> - * Attempt to allocate from the clear tree first. If insufficient clear
>> - * memory is available, falls back to dirty memory. Useful when the
>> + * Attempt to allocate outside dirty-tracked ranges first. If 
>> insufficient
>> + * clear memory is available, falls back to dirty memory. Useful 
>> when the
>>    * caller needs zeroed memory and wants to avoid GPU clear operations.
>>    */
>>   #define GPU_BUDDY_CLEAR_ALLOCATION        BIT(3)
>> @@ -53,8 +54,8 @@
>>    * GPU_BUDDY_CLEARED - Mark returned blocks as cleared
>>    *
>>    * Used with gpu_buddy_free_list() to indicate that the memory being
>> - * freed has been cleared (zeroed). The blocks will be placed in the
>> - * clear tree for future GPU_BUDDY_CLEAR_ALLOCATION requests.
>> + * freed has been cleared (zeroed). The blocks will be removed from the
>> + * dirty tracker for future GPU_BUDDY_CLEAR_ALLOCATION requests.
>>    */
>>   #define GPU_BUDDY_CLEARED            BIT(4)
>>   @@ -67,15 +68,6 @@
>>    */
>>   #define GPU_BUDDY_TRIM_DISABLE            BIT(5)
>>   -enum gpu_buddy_free_tree {
>> -    GPU_BUDDY_CLEAR_TREE = 0,
>> -    GPU_BUDDY_DIRTY_TREE,
>> -    GPU_BUDDY_MAX_FREE_TREES,
>> -};
>> -
>> -#define for_each_free_tree(tree) \
>> -    for ((tree) = 0; (tree) < GPU_BUDDY_MAX_FREE_TREES; (tree)++)
>> -
>>   /**
>>    * struct gpu_buddy_block - Block within a buddy allocator
>>    *
>> @@ -88,6 +80,17 @@ enum gpu_buddy_free_tree {
>>    * @private: Private data owned by the allocator user (e.g., 
>> driver-specific data)
>>    * @link: List node for user ownership while block is allocated
>>    */
>> +/*
>> + * Clear/dirty state of a free block. Ordered so a numerically 
>> larger value
>> + * is "more clear" (DIRTY < MIXED < CLEAR) which lets 
>> subtree_block_state be
>> + * maintained as a simple max-augment over the per-order free tree.
>> + */
>> +enum gpu_block_state {
>> +    GPU_BLOCK_DIRTY = 0,
>> +    GPU_BLOCK_MIXED = 1,
>> +    GPU_BLOCK_CLEAR = 2,
>> +};
>> +
>>   struct gpu_buddy_block {
>>   /* private: */
>>       /*
>> @@ -103,6 +106,13 @@ struct gpu_buddy_block {
>>   #define   GPU_BUDDY_ALLOCATED       (1 << 10)
>>   #define   GPU_BUDDY_FREE       (2 << 10)
>>   #define   GPU_BUDDY_SPLIT       (3 << 10)
>> +/*
>> + * GPU_BUDDY_HEADER_CLEAR has two roles:
>> + *  - FREE state:      set when the block's full range is cleared 
>> (dirty
>> + *                     tracker confirmed no overlap).
>> + *  - ALLOCATED state: set when the block was served from cleared 
>> memory,
>> + *                     informing the caller that no GPU clear pass 
>> is needed.
>> + */
>>   #define GPU_BUDDY_HEADER_CLEAR  GENMASK_ULL(9, 9)
>>   /* Free to be used, if needed in the future */
>>   #define GPU_BUDDY_HEADER_UNUSED GENMASK_ULL(8, 6)
>> @@ -128,13 +138,51 @@ struct gpu_buddy_block {
>>           struct list_head link;
>>       };
>>   /* private: */
>> -    struct list_head tmp_link;
>> +    enum gpu_block_state subtree_block_state;
>>       unsigned int subtree_max_alignment;
>> +    struct list_head tmp_link;
>> +    bool has_clear;
>>   };
>>     /* Order-zero must be at least SZ_4K */
>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>>   +/**
>> + * struct gpu_dirty_extent - a contiguous dirty address range
>> + *
>> + * Tracks a single contiguous address range whose memory content is 
>> known
>> + * to be dirty.  Extents are non-overlapping and stored in an augmented
>> + * red-black tree sorted by @start.  The augmented value 
>> @subtree_max_size
>> + * allows O(log N) search for an extent of at least a given size.
>> + */
>> +struct gpu_dirty_extent {
>> +/* private: */
>> +    struct rb_node    rb;
>> +    u64        start;
>> +    u64        end;
>> +    u64        subtree_max_size;
>> +};
>> +
>> +/**
>> + * struct gpu_dirty_tracker - tracks dirty address intervals
>> + *
>> + * Maintains a set of non-overlapping dirty extents as an augmented
>> + * red-black tree.
>> + *
>> + * @total_dirty: Total bytes of dirty memory currently tracked.
>> + * @extent_pool: Mempool backing extent node allocations. sashiko 
>> reported
>> + *         that a __GFP_NOFAIL allocation on the free path could
>> + *         deadlock during memory reclaim, so a per-tracker mempool is
>> + *         used to guarantee extent nodes without __GFP_NOFAIL.
>> + */
>> +struct gpu_dirty_tracker {
>> +/* private: */
>> +    struct rb_root    root;
>> +    mempool_t    *extent_pool;
>> +/* public: */
>> +    u64        total_dirty;
>> +};
>> +
>>   /**
>>    * struct gpu_buddy - GPU binary buddy allocator
>>    *
>> @@ -152,20 +200,25 @@ struct gpu_buddy_block {
>>    * @chunk_size: Minimum allocation granularity in bytes. Must be at 
>> least SZ_4K.
>>    * @size: Total size of the address space managed by this allocator 
>> in bytes.
>>    * @avail: Total free space currently available for allocation in 
>> bytes.
>> - * @clear_avail: Free space available in the clear tree (zeroed 
>> memory) in bytes.
>> - *               This is a subset of @avail.
>> + * @clear_avail: Free space that is clear (zeroed) in bytes. A 
>> subset of @avail.
>> + *               Maintained as @avail - dirty.total_dirty, since the 
>> tracker
>> + *               records the dirty extents. Zero at init, as a fresh 
>> pool is
>> + *               fully dirty.
>>    * @lock_dep_map: Annotates gpu_buddy API with a driver provided lock.
>>    */
>>   struct gpu_buddy {
>>   /* private: */
>> +    /* Tracker of dirty address ranges (decoupled from free_tree). */
>> +    struct gpu_dirty_tracker dirty;
>>       /*
>> -     * Array of red-black trees for free block management.
>> -     * Indexed as free_trees[clear/dirty][order] where:
>> -     * - Index 0 (GPU_BUDDY_CLEAR_TREE): blocks with zeroed content
>> -     * - Index 1 (GPU_BUDDY_DIRTY_TREE): blocks with unknown content
>> -     * Each tree holds free blocks of the corresponding order.
>> +     * One RB-tree per order containing all free blocks (clear and
>> +     * dirty alike).  The augment field subtree_block_state (a max over
>> +     * the subtree of each block's state) lets clear allocations
>> +     * find the right-most fully-clear or mixed block in O(log N).
>> +     * Dirty free blocks coexist here but are also indexed by the
>> +     * @dirty tracker for fast dirty allocation lookups.
>>        */
>> -    struct rb_root **free_trees;
>> +    struct rb_root *free_tree;
>>       /*
>>        * Array of root blocks representing the top-level blocks of the
>>        * binary tree(s). Multiple roots exist when the total size is not
>>
>> base-commit: 9c950822f0fa923ccd344d7a143872d25efe89a3
>

