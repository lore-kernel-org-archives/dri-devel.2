Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621BEC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B62C10E31C;
	Tue, 11 Aug 2026 12:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UpEhtCfz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9FF10E097;
 Tue, 11 Aug 2026 12:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKUppURcIyru/pBGWxQ78Q9CiME8pbvaCrP5V6M7gEuvRgPkLaUwSH3oQQwjZLQx+btcdTdXlRxPINu82mDRaZ/sHa2OEkZbL7pXWD+c5QCOjhbY8QnGhIwPnYu+IeBzI+yI6aCm/qrHh2IrbRuQ/ETrWZvKjyfq3Ls2yKPRBIYyI+E78AwGmWq/JYxoW/W2/Pqk3l89WxfBfn6V/JEj9RtS0ZtusFhpysHBJIg/BQ/wpL/bohRrlqBW5Vzuu4Tdu/QVSrM4K66D70kz/Psmqc28jzdohreEuJVzLuortF15kiWJE6lZWjOFYQDfQHYE34GSOP1wA68baswp75xSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhrdI/mOw1B0hGpoXPnc2QrzxIr1Y7LLMapy6f785jA=;
 b=gcPzGhPB7zxGiOOrv6Tz1hNCoQXzAO6ZnS0Qqhtqbb86+1AGjmN1IXkTOh2VW5ol+tBuZ/B3vMDmg1LG1YuuXadpTfmjW4NUti7+Vp3nOfD38ZBneWj/OLJRwQm1RGhc9f3zsircyvReKBNB4F32q1961XAv+SvIUqWcQzFlnF9mM42NK3S9UGo/O3Ius/ulI62s429764+1aNd2ihV3+asuKr80dVvg0A5Q3NCfB+/czqk0GMTiqWmJLezx7Klj/uhEZdvuUOTepx3ueNpGZLfyInZpbXP20piWRDXztIFVKebouKjyjH5URcau6I11uYxCI3pWp/rQq+46plBuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhrdI/mOw1B0hGpoXPnc2QrzxIr1Y7LLMapy6f785jA=;
 b=UpEhtCfzbXF5zDQnBrmJdqwb3cT9IspH5eo95V/7/KYzo9e59aRFa7FHZdLrA2oOsbSGJ7t8+4Vm9jbQ3JOUaMghda7hUzZsFUWToA9Q1pGh3i60XPXK5fBTs5OQbGAl36CelrKwsIcVGXxI0wNRsqacTGXuS8msAagKAx3Qqfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 12:07:35 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 12:07:35 +0000
Message-ID: <d25b60dc-908a-4b2f-ad96-19a2368a45e2@amd.com>
Date: Tue, 11 Aug 2026 17:37:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: Matthew Auld <matthew.auld@intel.com>, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
 <7d2e8cbf-ff8e-491c-8a59-d05025df8565@intel.com>
 <cabc4308-ceca-4d1e-b6c5-3838498cc3a2@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <cabc4308-ceca-4d1e-b6c5-3838498cc3a2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0195.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::14) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: f6016ae8-2446-46bb-774a-08def7a12104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: utDDxbEbj66KCKxU6PXoPki7as6Jmm5D8ahU8SJluV++VSHuu5nVLnT1lKv4JIef02uVfM92lpIsrMYM6RBrmmiRY63CRcQWsw4YKz5Z4OiQkmsywtU4eS9PomqKvLGGeP4PdhjhM2vYsncwkst2c2ptdtX0rMrKjjLwsh9iDyTbyIQQ89J69FJPODA5wFyiqk+uvjBLIKXaBt81yEPvm9EmMOddclmjdGDEJsA/Dm4WzuqjFzcCwlagAImllbDnAb3INjrRG/UzdApfeFZgIcXLym1o/6TB7Byy1Q1FtAey4eEXhgeDXvAh4spYECfaHWjirqumR5AHYbA4yjILcCinPkiRNeLW9G3woDfBhOwLQ+rBz4E4rz1hrmIew7jiRt7LxvrokPYblwTxyFoB8o9o2pS/uIpu/UQVt67UB3Hzzjaa8u18oP/e7cN6Uv46GIywYM54LIeNhlUjWgOHjly6sKHGiR4Sv9GAEgXe3jjEsKY9g0lAkJfjPuhndGVTy2P6LJWnRY0rdYEhcEye6Qk4sWuweqROK36Aqm0RD4Bc4GVrKLu3ICE6KxCDfKOe2QuIlrlXmZKHiVZQXwZLagsGNtjiMgmZ5crTxbTK3N0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENxTWVMUklrTXRpSnpLUk9wcVhqUkg2VUFFYlNLTnFOV2xZaEJWRGdLbG1U?=
 =?utf-8?B?RzcrNm16ZmZwRU13MEFKMGJsaFdxWGFXWCtsVnlTTzV6Sno3L2ZqcG91UC94?=
 =?utf-8?B?WFYyVTJvOFBML1VlNDdicjRTWTdPd0RwRTNIUE1sRUxSSmk5WFh3MERFeWtD?=
 =?utf-8?B?M0VBSzE1VVdqNFFqNmtZRFd4QUNQd0l6ejk3WjFwemZSUHVvM0QwamtxYTNo?=
 =?utf-8?B?Qm5NSkp5dk14aVJQY2ZNdVVsT0VQQTF0N0dGTVFENWhQeXIwVkZuNzIwRjRX?=
 =?utf-8?B?Rnc2SktSSXljREJvNjhpTVNBK1J1cFBrbEZ1eE9wa2xwRVZCLzBvRTcvWW9S?=
 =?utf-8?B?QUJwSVFINWhmSG5TZ0FmTTRmWGpRSVM3VENsaTcvVlkya2ZVaDN1cytFbWQr?=
 =?utf-8?B?RkpIeU1vcHRCWDZtSmJLRHdTT3BlQzhuQnVtU1c4YTV3Zy9nYU9zejd2TTcx?=
 =?utf-8?B?WFFmU3BkQWMvQXNzQkQ2azFCN1BtUVA5aWFRK0ZyeEhDNytrRndMdzBGVVlG?=
 =?utf-8?B?cVYyS1I3Q3l1WUJKQmZzdDlzdUFPQi9tNTRmdTFMOThDMDNIYWR0Tzl6TnYr?=
 =?utf-8?B?SUI4M1doTmo5NjJjWnAyblAweVVSWGZoTWpqUzJieXMxL3o3akRXL3BLOEVx?=
 =?utf-8?B?OEV0WnJZWFJGSUpUMnZlUUoyYWxkcDlYMWNzNW9VQkYyMDRzRnVEV0M1ZUtR?=
 =?utf-8?B?N0p3ZEx0S25nbkpaSG8ydWVtQytBQ3A4VGVDcEZiMFdyVmV1RXFIWFk5UkN3?=
 =?utf-8?B?QXhzQ1VBc2QzbkJ5RHR1d09maHUzN3FONk9OZE5JeGorb3RBb1lMR1NyN2hC?=
 =?utf-8?B?N09VdnpFQkpGSGRadFJOM09IazhYLzNCUHZZVHpueTAxaERYc1ltT0F2M2dx?=
 =?utf-8?B?djU2V1lsdXNUSGhOSkdoR0RUcEZ3MkZsQ0xlVUdDa0dtSGswQm1INHp5NGYx?=
 =?utf-8?B?WmJoeWhycWdKMzNPL1crSlRBb3pudVltMXZ4QTBkcmEvSjBVdDFRYzJBcXYw?=
 =?utf-8?B?cG54QTBheVlybjArV2tzbUxVdksrM2xVVWlKQ1h1NkdnTXYyQnUwZ0V0V0p0?=
 =?utf-8?B?OFBFZjIxbGFaOFpsVjV0OVh6bFlleURsZmxidVY3bTJIeFN1cXNBWnRDYUlE?=
 =?utf-8?B?SjZkZC92eUhabHRHSEpJaGRmYjMzNkFvTlRSdE5JbFI2RjV0Tm9uVmpCT3pi?=
 =?utf-8?B?cnp1QTNRbS9kTUM0ekROR3M0NUlFOXkxbDJ1SVNZN21uOEtiZmdNZWlYNEpy?=
 =?utf-8?B?QjVSNGR4VHBOd0E0V3FjRFNWTitIUWc0TlJrUktHeGY0TStHWm9QaFZsT0JF?=
 =?utf-8?B?NVduTmorVDhnUzBMMEdvV3BNSTFiZ210eTZ2QlhiSGZBbGZiamV3dUY0Y1I2?=
 =?utf-8?B?TFV4WUJkRk5ndTVETmlpMFE1VmpyQW54RldTcUY1NFRMOHNtQWI0a0g1bVg0?=
 =?utf-8?B?VmY5V3pNZTdtMnNBN3o5OHNOaHJlUGZJODJZZmR3U0lDUFczL3VoRnpJVEtF?=
 =?utf-8?B?YmxaNXBubkkvU1lIb3NlNnNnUDJtTGExaFJkMzdrYlRPcUV1QVpJdXlhRGtp?=
 =?utf-8?B?Nks5djFRY3RUeVBCR25qcmJib1VHY3NTc212TVZ4dUNjNkJWWU5vcHR1b1NZ?=
 =?utf-8?B?Qm5tK00vc3dBTklrNXZicDhVQ2k1Y0ZSZ2o0RFpYOWxwQkxqcjZiNU4rNC9q?=
 =?utf-8?B?Zy9Fd0J2Uko3M29YZCtpeWRrRE81aWVmQlhGYmxmQm9yYXdQeldIVlhCTjZz?=
 =?utf-8?B?Q0NOUlJrY0xjNUxHbHRhN0E3VUh3SVhoRU1tL2txVDVRN1FMcmJ6ZXZTNFRI?=
 =?utf-8?B?UVBDN1EvK1ljUmVFa1VuY0FvVjB1TVFZamFQclZ4djB2SEJucXVwbms0aGlV?=
 =?utf-8?B?ZU41MWFTWVZXUThIOFAxdFpYYXVVcE4wcnVJQVc4cGFnUDgrR1FTZVhpS0Jy?=
 =?utf-8?B?Znlkb2MyZTJtMFFBaXk2QVdpVWd4T1BYcUd2NWZQaDhZYVlUUExJS0UrcEow?=
 =?utf-8?B?bnlsZlVrdFhDcjIxZnR2ZzN0UDU2Z3M3Y3JvWWl0RURmeUphdlkwT2tvbVYz?=
 =?utf-8?B?ekNQNSszZlNPNUZZdlN1eGk0QmhCSnppUWQ4dkl3NndEYUlnQnhBS2dac1BH?=
 =?utf-8?B?RWEyeGFRTWNibWJOMXZyc3FVKzFHM3huVlNJOWh1RXh4VU5OdEs1cDM2ZWJy?=
 =?utf-8?B?MG5jR1hjL2dxdUJMSGIwaVB0Ty9PcDBPWityb3Z0WGl6YktVT01pT0VzS0RS?=
 =?utf-8?B?dnJ1V1dvY3g2c0ZCSm1tTzJwRUh1eVdWR3hrbGJjM3pGTXBuUWIwbU9YcWhu?=
 =?utf-8?B?aDB6M3AwMHBwdzE1QklxZ1ZERm5GSkN3WmZ5c1VNaFMxdmJtVDVqUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6016ae8-2446-46bb-774a-08def7a12104
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 12:07:35.2557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhPc6198CYlG2oSFODf79Dyv7Kp1ERgwvto5USPiliXV0h8E1v50xnQxbltVLKGi16yDpyh5G0AMX+cZ0mlK8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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



On 8/6/2026 10:54 PM, Matthew Auld wrote:
> On 06/08/2026 17:45, Matthew Auld wrote:
>> On 31/07/2026 08:07, Arunpravin Paneer Selvam wrote:
>>> The current buddy allocator maintains separate clear_tree[] and
>>> dirty_tree[] rbtrees per order, preventing coalescing between cleared
>>> and dirty buddies. Under mixed workloads, this creates a merge barrier:
>>> adjacent buddies frequently end up split across trees, forcing reliance
>>> on __force_merge() during allocation.
>>>
>>> __force_merge() performs an O(N x max_order) scan under the VRAM 
>>> manager
>>> lock, leading to allocation stalls and failures for large contiguous
>>> requests even when sufficient total free memory is available.
>>>
>>> Solution
>>>
>>> Replace the dual-tree design with:
>>> - A single free_tree[order] rbtree for dirty and mixed free blocks
>>>    (fully cleared free blocks float outside this tree)
>>> - A lightweight out-of-band dirty tracker (gpu_dirty_tracker)
>>>
>>> Fully cleared free blocks are tracked outside the buddy trees using an
>>> augmented interval rbtree, enabling O(log E) lookup of the largest
>>> cleared extents.
>>>
>>> Buddy coalescing is now unconditional in __gpu_buddy_free(), regardless
>>> of clear/dirty state. This removes the merge barrier and eliminates the
>>> need for __force_merge().
>>>
>>> Benefits
>>>
>>> - Correct high-order allocations after mixed clear/dirty workloads
>>> - Elimination of O(N x max_order) merge cost from the allocation path
>>> - O(log E) cleared-extent lookup replacing O(N) scans
>>> - Predictable allocation latency under fragmentation
>>> - Reduced complexity with a single tree per order
>>>
>>> Test:
>>> dEQP-VK.memory.allocation.basic.size_8KiB.reverse.count_4000
>>>
>>> Below data is from /sys/kernel/debug/dri/1/amdgpu_vram_mm:
>>>
>>> Base (dual-tree), before VKCTS test:
>>>    order- 6 free:   6 MiB,  blocks: 26
>>>    order- 5 free:   1 MiB,  blocks: 15
>>>    order- 4 free: 960 KiB,  blocks: 15
>>>    order- 3 free:   5 MiB,  blocks: 171
>>>    order- 2 free:   2 MiB,  blocks: 176
>>>    order- 1 free:   1 MiB,  blocks: 165
>>>    order- 0 free:  16 KiB,  blocks: 4
>>>
>>> Base (dual-tree), after VKCTS test:
>>>    order- 6 free: 768 KiB,  blocks: 3
>>>    order- 5 free: 499 MiB,  blocks: 3999
>>>    order- 4 free: 250 MiB,  blocks: 4001
>>>    order- 3 free: 129 MiB,  blocks: 4157
>>>    order- 2 free:  65 MiB,  blocks: 4161
>>>    order- 1 free:  63 MiB,  blocks: 8138
>>>    order- 0 free:  20 KiB,  blocks: 5
>>>
>>> Dirty tracker, before VKCTS test:
>>>    order- 6 free:   4 MiB,  blocks: 19
>>>    order- 5 free:   2 MiB,  blocks: 18
>>>    order- 4 free: 704 KiB,  blocks: 11
>>>    order- 3 free:   5 MiB,  blocks: 168
>>>    order- 2 free:   2 MiB,  blocks: 174
>>>    order- 1 free:   1 MiB,  blocks: 167
>>>    order- 0 free:  32 KiB,  blocks: 8
>>>
>>> Dirty tracker, after VKCTS test:
>>>    order- 6 free:   4 MiB,  blocks: 19
>>>    order- 5 free:   2 MiB,  blocks: 18
>>>    order- 4 free: 704 KiB,  blocks: 11
>>>    order- 3 free:   5 MiB,  blocks: 168
>>>    order- 2 free:   2 MiB,  blocks: 174
>>>    order- 1 free:   1 MiB,  blocks: 167
>>>    order- 0 free:  28 KiB,  blocks: 7
>>>
>>> v2:
>>>   - Code-style cleanup and minor refactoring
>>>   - Renamed locals for clarity
>>>
>>> v3:
>>>   - Keep cleared blocks inside free_tree[] instead of floating them.
>>>   - Add subtree_has_dirty rbtree augment for O(log N) dirty-first walk.
>>>
>>> v4:
>>>   - Fixed checkpatch warnings.
>>>   - Optimized gpu_buddy_reset_clear() to a single post-order walk that
>>>     flips block headers and recomputes the rbtree augment in one pass.
>>>   - Propagate subtree_max_size top-down in insert_extent() so ancestors
>>>     are not left with stale values on no-rotation inserts. (sashiko)
>>>   - Drop the whole extent in gpu_dirty_tracker_mark_dirty() when the
>>>     inside-split allocation fails, avoiding a stale clear claim. 
>>> (sashiko)
>>>   - Make gpu_dirty_tracker_find() alignment-aware and fall back to the
>>>     dirty tree on steered failure to avoid spurious -ENOSPC. (sashiko)
>>>
>>> v5:
>>>   - Track dirty extents instead of cleared ones: steer dirty allocs 
>>> onto
>>>     tracked dirty windows and pick clear allocs via a free-tree 
>>> augment,
>>>     avoiding clear-memory wastage by keeping cleared free blocks 
>>> untouched
>>>     during dirty allocation.
>>>
>>> v6:
>>>   - Make __alloc_range_bias() return the highest/right-most address by
>>>     default, establishing top-down as the intended placement for
>>>     range-biased allocations.
>>>   - Honour GPU_BUDDY_CLEAR_ALLOCATION in __alloc_range_bias() by 
>>> steering
>>>     the descent towards clear subtrees for non-top-down clear
>>>     requests. (sashiko)
>>>   - Skip dirty-tracker steering for offset-aligned requests so they 
>>> keep
>>>     their min_block_size alignment. (sashiko)
>>>   - sashiko reported that the __GFP_NOFAIL dirty-extent allocations on
>>>     the free path could deadlock during memory reclaim, since that is a
>>>     GFP_KERNEL allocation on the free path; move to a per-tracker
>>>     mempool so extent nodes are guaranteed without __GFP_NOFAIL.
>>>     (sashiko)
>>>   - Derive each free block's clear/dirty class from the blocks already
>>>     in hand on split, free, alloc, trim and init instead of querying 
>>> the
>>>     dirty tracker, removing the tracker lookups from the hot paths.
>>>
>>> v7:
>>>   - Preserve mixed-block clear state in __gpu_buddy_free() when a mixed
>>>     split child is re-merged after an undone split. (sashiko)
>>>   - Prefer a fully-clear block over a mixed one of the same order via a
>>>     single ordered clear-state max augment on free_tree[].
>>>
>>> Assisted-by: Claude:claude-opus-4-8
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>
>> <snip>
>>
>>> @@ -620,13 +1100,18 @@ EXPORT_SYMBOL(gpu_buddy_reset_clear);
>>>   void gpu_buddy_free_block(struct gpu_buddy *mm,
>>>                 struct gpu_buddy_block *block)
>>>   {
>>> +    u64 size = gpu_buddy_block_size(mm, block);
>>> +    u64 offset = gpu_buddy_block_offset(block);
>>> +
>>>       gpu_buddy_driver_lock_held(mm);
>>>       BUG_ON(!gpu_buddy_block_is_allocated(block));
>>> -    mm->avail += gpu_buddy_block_size(mm, block);
>>> -    if (gpu_buddy_block_is_clear(block))
>>> -        mm->clear_avail += gpu_buddy_block_size(mm, block);
>>> -    __gpu_buddy_free(mm, block, false);
>>> +    mm->avail += size;
>>> +    if (!gpu_buddy_block_is_clear(block))
>>> +        gpu_dirty_tracker_mark_dirty(&mm->dirty, offset, size);
>>> +
>>> +    gpu_buddy_sync_clear_avail(mm);
>>> +    __gpu_buddy_free(mm, block);
>>>   }
>>>   EXPORT_SYMBOL(gpu_buddy_free_block);
>>> @@ -641,9 +1126,9 @@ static void __gpu_buddy_free_list(struct 
>>> gpu_buddy *mm,
>>>       list_for_each_entry_safe(block, on, objects, link) {
>>>           if (mark_clear)
>>> -            mark_cleared(block);
>>> +            block->header |= GPU_BUDDY_HEADER_CLEAR;
>>>           else if (mark_dirty)
>>> -            clear_reset(block);
>>> +            block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>>>           gpu_buddy_free_block(mm, block);
>>
>> Just a thought, not a blocker or anything. It looks possible that as 
>> you loop through the blocks here you could easily extend the extent 
>> range if you keep finding something contig to the current extent, and 
>> then turn that into fewer mark_dirty() calls. If you ever encounter 
>> something non- contig you call mark_dirty() with whatever extent 
>> range you have now, and then start again. Obvious case is if you had 
>> a contig allocation which is more than one block, which could be 
>> turned into one mark_dirty().
>
> For example: 
> https://gitlab.freedesktop.org/mwa/kernel/-/commit/f58b83b638fd2203de6d06a0eb0994fbe4ec046a 
>
I added in v8 and sent for the review.

Thanks,
Arun.
>
>>
>

