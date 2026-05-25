Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4335CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B80710E04F;
	Mon, 25 May 2026 09:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="twalLFMQ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB33310E04F;
 Mon, 25 May 2026 09:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9EHIBSZ8eylmk35PzUKW73+mzksYkGvfKX+RrxCxwM5uORnD85zlY4mJlSGkDKXiUTFojETmdYTIraHG+nCfAg3a/6+3u1JqNT5Y4yztLdZn/Yny5VFz0I20m2N58+l3G1B1Y4DrL75kmo/wuUe8Zq4kPtIGAcjFyjH4d/ZCwca1NGWJe29dUwBpOyCcfe6Er//Ba8OyhwidwaJjJYbCjNh+/2x9ZdKThltGFZi/vFpw0I1WnRpt5QD0FKm9SUGjY7VfJmBEqEwNJOoXMPOJZ/8uHA/7HWHp6kS5ub9IHbgLC6rz4YV9LaL5JbFfJqQg24DrDZlk4M90pveZHbIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sX9kBzdbn+W2kOBJSb5t2exILaWALqkUa0IHyGymQE=;
 b=UeXvobSeSJZ3s35bz2kwSKaPpRjps4L0xO/2bBGr5w6qoRoAquH+Ckwv+tVyyib3XKvbfmOv/sIFuS4PlsyxOhDW4gTqhangk07UnUCOhI9hJnz5g0/B6/Ng91k7Sx3aXzGNBNNMmyvQsLR1Pf9DzhsZ/XPLlW0tbr6FIM+DrXyp71z259ResqHc8j7ZHQjtJZ97vwXIWg6BTL2QJN+RG0rZF8J+CvH6L/VG+3z8v7Z3eO2hRC0k3/6W3jBpe0tYlJTBkVkUdqnqFh13WxzwsPEDMiIpJ+9kVj4Y1yushyNWcAOK0BysgFmFr9m6K+gTPYiekl0O+KOvxBuF0Hez2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sX9kBzdbn+W2kOBJSb5t2exILaWALqkUa0IHyGymQE=;
 b=twalLFMQrnUfFk4HF47ZtmUXi1FeILNZ63wDCqkkneo4e/ODWi93C9O52Gsi/wycaCvbBmvirNcp7pSwDiuqYzX715b4u0LvfvEqjRcyrqkOB9Z/wpExAKFHv9Df64yIcsV1JCXLD07OLJZzGRemZNuuS+hTtszGtZBLQUBYefE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11) by LV3PR12MB9403.namprd12.prod.outlook.com
 (2603:10b6:408:217::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 09:11:04 +0000
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8]) by EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8%4]) with mapi id 15.20.9891.021; Mon, 25 May 2026
 09:11:04 +0000
Message-ID: <394c16c1-2c3c-4a70-9d08-1e5ead02b424@amd.com>
Date: Mon, 25 May 2026 14:40:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] gpu/buddy: Track per-order used blocks with a
 scoreboard
To: Matthew Auld <matthew.auld@intel.com>,
 Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260522092600.32818-1-francois.dugast@intel.com>
 <20260522092600.32818-6-francois.dugast@intel.com>
 <e3022ae8-d08d-4114-b6c0-c8f0890a2dae@amd.com>
 <38cc3449-b51a-4b54-bed8-8802e7b37299@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <38cc3449-b51a-4b54-bed8-8802e7b37299@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::15) To EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB999132:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5dd8f5-eb10-4b9d-8c76-08deba3d8bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: j+iFILGzER/mIXWJozKfSmC9emBM65oK5D6MTdpDdyhI5QFSG7m9Rr1iQkWmCYSxq2HSym826YdtMMKxmzPuwWF8fvsGFd6tu0s1bkqKMCvdrIXdch0REOGdwNEdE6QEWMSU1lVGjhC/UkM75w6Oll49OjKREwH1AgvYq5KrOMaQDjICChwpbDnSSlghIxvwSFyU8DIIXQ9ewNtAZ2FC0ErMPJD7DMw5ZCSfrk8CMLzfeT4tKOvIHRT5paab5+ujIFYzvFLe5HvpfQu4N+3LxTGDxB9qC3Qdb3jF7+9Z1r2jGgWrKUyno/kc0ZWs7ZiBkQPtUzhD+7EuDO7NU9x5zwwIX+yD/D+/E6HqZ2A00v1GjCi7yEwazsSvLFfgAHyFtUkW+aXeEqXPSca1h85V0IjKgnvT7m6aDPZnzSO6pyzZuF6CsFiLw7g6zb43R8Uj4NSi7xDJZwRIW6PL98XkHS1gVeYyH2i4ipIsD6HrhbCi4fwDTpmJf3pTf3H7sC0vNex1AGht1IF35xJ6fGFKlQB5whxZFb6qrtHMtn1ufpUL6UGgVrPwP68WAxWPKvWSD48e4VLmjI3h9I11ThWqtpLHnSirH3vvoSi1vorCn/K02Ar1hCbjgj7qz9zaC5jcsOD5xRHhHN37uVYE7b2evy3Cc/p8zCOCYg7xIOv22LMlkJST8DnBExxP4kNxeUnd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGVvbk1wNEU2Mm14dXZRTWZPeDNZYWFKbHpzWkQwd3hxTDZLVXZEbmFlVTgv?=
 =?utf-8?B?OUVBL3poREJLZ202M2tqKzc4V3ZEQXVvWHU5ZWYyQjhHb0psbUZiYXhRQlcz?=
 =?utf-8?B?U012SUtvNjFYY1QrY3dwQ0ZlVUo5VW5rd0JrZXJxZkVtZWhZaGozb0tSZmZB?=
 =?utf-8?B?M1RiY1ZXbWhKOENsb1VHc0lIbmNPSFpMTEMySVk0cVM2dXl3RUUvbnFlZzZ3?=
 =?utf-8?B?cC9ZMHJKaGlIT3pjK1YyaFpCemFsTHFPcFJDNS9hOEhWTVNIT3QvMlNwS1Vj?=
 =?utf-8?B?QVpMajJKK0drdTBLYS9hemxEZXZoQ3RrS1BWRE0vU0xzdWI4LytuWktwNDRy?=
 =?utf-8?B?ZmZCU0lMWllSVDlkd1ZtNGJLdTlaRWhZcHdKZUwrdm1JcWJ0MG5oM21Nd3hG?=
 =?utf-8?B?RmhNU3ZHVnN5SFRFUWhwYmtwMnJIVGFvQitNM3ljR3dQVHFUQUprc2lSWHRC?=
 =?utf-8?B?VllWZ2dQdXh4bE0vUVZVcjRuc0tsL2Nzc1BMOFF0MG96blZlVWhTd2xVQWpS?=
 =?utf-8?B?NXBiWFR3eWJGeTh5MWcxYVJLV3JRWm5od25ZSklZRTFrZTBBT1J0aWc1c1pX?=
 =?utf-8?B?b09ZcStiRXB4TzJYUkk2eE1XQWFaT1NML3I2SVJpU1UxaVRHN3RlUjJtY2FG?=
 =?utf-8?B?L05Xb2k5TUt2QzJFNWV3QzFiai9ES2s3OGtIVElzWlFBcEtEbGRpMmk4STZn?=
 =?utf-8?B?V0doM3V4bXdVK2Y5blY5bVlGWHA4a3JDUEQzN1o2UzJNQjdoLzlLRGdKRFA5?=
 =?utf-8?B?UWg5dDc4T1ZkN2o0M2pMdlE1VmhVL05IRGFBdjBsTVh0U0g0ZXdMK0RmUWZv?=
 =?utf-8?B?QTZ3YldmVHVQY25qS2UrY0NSRHlNc3llTDIvSGc0RUx3K1JiVUdia0pHTU0v?=
 =?utf-8?B?VG85WGtuNWlKQjVoUmNhdFJrY0tKL1FKYzdNYUFtaTVQcDFuZnFXbnc4S2s0?=
 =?utf-8?B?NEg5WThnbTFjRGMwcEluTCtyK3dBODdaRTcvOTFqTjl3MHRLOGk4Mmk3RzZW?=
 =?utf-8?B?bUpnOVQ1TWNLcXJlc3NWM3JRNklwdVFyTitWb0Q0ZzZXU2V2eVNTQ0ZUSnly?=
 =?utf-8?B?V1BqZ0Z4VUFkRWJvVFlKSUlYMU95L0FWdDFOcWFyS0d6RUczYWVPU2lYUXhI?=
 =?utf-8?B?bktNNXdnMFVvNDUvalJTQ3k4OXVxeFZFTm54anZOOGVsTVdqdFNpNnRkSDZQ?=
 =?utf-8?B?M3hrbUk3clpKZGd2KzVJaCtUZGliSUUxVS9ISjloS05Ja0JHZjdCMFc1YzJt?=
 =?utf-8?B?TmFxek1weW0wWkJQOHNLakkwR2dKTi9DNHJ4MVJORTkvU1NtbG5pZ1dLZllD?=
 =?utf-8?B?M1ludlZhbEhmUUIxSHRxamkwakFINGRLUlZSRS9pZDc4ZjQ4L3NUVzlBTGlV?=
 =?utf-8?B?T2Mrdm1QZkh4bmlBY3lUTEc4Tk04UHdrQ1d5aWdSb1lZcFpSSTFiYy9jRmlw?=
 =?utf-8?B?RUN5TmcySVZDbzBOSVg1NUlIUFlTcEtwOG90ZlJPcWpUcWhva25md2xobGpa?=
 =?utf-8?B?Y012QlpvRUhuMUFGRnVzSDZaSnhKeERkN2w4ckwrWElBT0FuTnVOOWRVNHI4?=
 =?utf-8?B?dFpxODZ2d25peENzMWNsdTlNemZONGJlN04wVDhyOU9IdXdYMFFpOHkxNTRV?=
 =?utf-8?B?cU5uZHByd3lvYjk0VzBVdGdsZWpERDlEWDZuSDAzZ2VVd3ZkTFNwQjhvZHUx?=
 =?utf-8?B?Qm83Mm96eUVtZmp0OHQ2SE5jMGVRcGNNN0RQdmUyRmdib2laUHVaMWRGaDRZ?=
 =?utf-8?B?VGtPbmxaQkpxYlZBTVpnMmRzditBL3lOa0xXVUJCeUdadVZ1RUdNSGxlamZS?=
 =?utf-8?B?c3JtWkhHYXNZaGIwenVEZ0t6K2l0WEE1TThhUVJsTkFtUGp2WnAzandGZ1U3?=
 =?utf-8?B?R1oyT0NMQW8zY1ltaVVuUUFpZENxakNmUUlLT1Rodzdma0pCY3NKWFNldzFZ?=
 =?utf-8?B?aDkydi9na1JCTElobGJ6Sy91QWdmRk9kUzNMRzArOEJ3N1BOUUl4eVdhMG4v?=
 =?utf-8?B?ZSt4L3JHVEUvVGVOZzdGUjZLamJFbnVvM2lmczVVdlFZb2NTdEJJTEd6WlVn?=
 =?utf-8?B?emlwWHJFUFpTd3pXOEN3allPSm1FMG1yODd4Y3ZMOWVZc1N2MUNqL3B0ZmZ6?=
 =?utf-8?B?cTdFOExPR0VOU0JpK0dQUmtZK0hZakVIWVpmb1Ztc21qazFuRldmaG43b282?=
 =?utf-8?B?ZWwxUEtJdWo0dnkxbFlXY2ZmemZGUTM0NDlXU3JEVXUyeXRNaW5NV3NIMUlz?=
 =?utf-8?B?c1gweGJvNm1pcWIvYTQ5bVpoMlhSZ0VlTzFzK3VJNU9wT1ZMSUs5OCtOSFFi?=
 =?utf-8?B?KzJEckdWMzQ2RnhtQlFTMGhXbjhrZitveGo4TUFPcTZTTmYrOHZsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5dd8f5-eb10-4b9d-8c76-08deba3d8bea
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 09:11:04.4900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vKE0OcqNETKeyWJxpJmwE5xpqmniqO4/KzZ6ojnox8k4FYEPDsNLq1Y44zyqUyZn0XmDgKxSgGL+2GYFWmDkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
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



On 5/22/2026 4:26 PM, Matthew Auld wrote:
> On 22/05/2026 11:25, Arunpravin Paneer Selvam wrote:
>>
>>
>> On 5/22/2026 2:55 PM, Francois Dugast wrote:
>>> Extend the scoreboard approach from the previous commit to used blocks,
>>> so drm_buddy_print() can report per-order allocation pressure in O(1).
>>>
>>> Unlike free blocks, an allocated block can leave the allocated state
>>> through mark_free() (normal free and gpu_buddy_block_trim()) or be
>>> consumed directly by gpu_block_free() during coalescing. Both sites are
>>> guarded by gpu_buddy_block_is_allocated() and paired with the increment
>>> in mark_allocated().
>>>
>>> v3:
>>> - Assert scoreboard is empty at fini(), as sanity check (Matthew Auld)
>>>
>>> v2:
>>> - Update after fix for use-after-free in split_block() call sites
>>> - Change goto label to out_free_used_scoreboard for clarity
>>> - Make drm_buddy_print() and gpu_buddy_print() symmetric for used and
>>>    free
>>>
>>> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
>>> Assisted-by: GitHub Copilot:claude-sonnet-4.6
>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>> ---
>>>   drivers/gpu/buddy.c         | 42 
>>> ++++++++++++++++++++++++++++---------
>>>   drivers/gpu/drm/drm_buddy.c | 18 ++++++++++------
>>>   include/linux/gpu_buddy.h   |  8 +++++++
>>>   3 files changed, 52 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index de18b63fef0a..dc81fe0301ce 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -194,6 +194,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>>       block->header |= GPU_BUDDY_ALLOCATED;
>>>       mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>>> +    mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>> The main consumer of free_scoreboard and used_scoreboard is 
>> gpu_buddy_print(), which is a debug/diagnostic path - it only gets 
>> called during debugfs reads or error state dumps, not during regular 
>> operation.
>> However, the cost of maintaining these scoreboards is paid on every 
>> alloc and free, which is the hot path of the allocator. Even though 
>> each individual update is small, do we really need to add extra work 
>> to the
>> hot path for something that only benefits a rarely-called debug 
>> function?
>> Am I missing a use case that justifies the hot-path overhead?
>
> The usecase I originally saw involved sampling this frequently during 
> a running workload to help collect some running stats. For example to 
> generate a graph of the "page usage" over time. So is there lots of 
> smaller order usage (bad), or do we get mostly larger page orders 
> (good), do we see spikes we all of sudden we start getting smaller and 
> smaller orders, perhaps due to fragmentation? In general we just 
> wanted some more visibility to get a better sense of the "page usage" 
> at runtime. At the moment we don't have much visibility into what page 
> sizes we are actually getting from the allocator, over time.
>
> We originally had this at this at the driver level, but it's not quite 
> as nice implementation wise, plus having it in the allocator could 
> then be beneficial to other drivers? Also the added cost did not seem 
> too bad, it's just incrementing/decrementing a counter. What do you 
> think here?
Yes, that should be fine and useful for capturing runtime workload 
statistics.

Regards,
Arun.
>
>>
>> Regards,
>> Arun.
>>>       rbtree_remove(mm, block);
>>>   }
>>> @@ -203,6 +204,9 @@ static void mark_free(struct gpu_buddy *mm,
>>>   {
>>>       enum gpu_buddy_free_tree tree;
>>> +    if (gpu_buddy_block_is_allocated(block))
>>> + mm->used_scoreboard[gpu_buddy_block_order(block)]--;
>>> +
>>>       block->header &= ~GPU_BUDDY_HEADER_STATE;
>>>       block->header |= GPU_BUDDY_FREE;
>>> @@ -281,6 +285,9 @@ static unsigned int __gpu_buddy_free(struct 
>>> gpu_buddy *mm,
>>>           if (force_merge && gpu_buddy_block_is_clear(buddy))
>>>               mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
>>> +        if (gpu_buddy_block_is_allocated(block))
>>> + mm->used_scoreboard[gpu_buddy_block_order(block)]--;
>>> +
>>>           gpu_block_free(mm, block);
>>>           gpu_block_free(mm, buddy);
>>> @@ -398,11 +405,17 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>>> size, u64 chunk_size)
>>>       if (!mm->free_scoreboard)
>>>           return -ENOMEM;
>>> +    mm->used_scoreboard = kcalloc(mm->max_order + 1,
>>> +                      sizeof(*mm->used_scoreboard),
>>> +                      GFP_KERNEL);
>>> +    if (!mm->used_scoreboard)
>>> +        goto out_free_free_scoreboard;
>>> +
>>>       mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
>>>                          sizeof(*mm->free_trees),
>>>                          GFP_KERNEL);
>>>       if (!mm->free_trees)
>>> -        goto out_free_scoreboard;
>>> +        goto out_free_used_scoreboard;
>>>       for_each_free_tree(i) {
>>>           mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
>>> @@ -464,7 +477,9 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>>> size, u64 chunk_size)
>>>       while (i--)
>>>           kfree(mm->free_trees[i]);
>>>       kfree(mm->free_trees);
>>> -out_free_scoreboard:
>>> +out_free_used_scoreboard:
>>> +    kfree(mm->used_scoreboard);
>>> +out_free_free_scoreboard:
>>>       kfree(mm->free_scoreboard);
>>>       return -ENOMEM;
>>>   }
>>> @@ -500,11 +515,15 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
>>>       gpu_buddy_assert(mm->avail == mm->size);
>>> +    for (i = 0; i <= mm->max_order; ++i)
>>> +        gpu_buddy_assert(!mm->used_scoreboard[i]);
>>> +
>>>       for_each_free_tree(i)
>>>           kfree(mm->free_trees[i]);
>>>       kfree(mm->free_trees);
>>>       kfree(mm->roots);
>>>       kfree(mm->free_scoreboard);
>>> +    kfree(mm->used_scoreboard);
>>>   }
>>>   EXPORT_SYMBOL(gpu_buddy_fini);
>>> @@ -1505,15 +1524,18 @@ void gpu_buddy_print(struct gpu_buddy *mm)
>>>           mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm- 
>>> >clear_avail >> 20);
>>>       for (order = mm->max_order; order >= 0; order--) {
>>> -        u64 count = mm->free_scoreboard[order];
>>> -        u64 free = count * (mm->chunk_size << order);
>>> -
>>> -        if (free < SZ_1M)
>>> -            pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
>>> -                order, free >> 10, count);
>>> +        u64 free_count = mm->free_scoreboard[order];
>>> +        u64 used_count = mm->used_scoreboard[order];
>>> +        u64 block_size = mm->chunk_size << order;
>>> +        u64 free = free_count * block_size;
>>> +        u64 used = used_count * block_size;
>>> +
>>> +        if (block_size < SZ_1M)
>>> +            pr_info("order-%2d free: %8llu KiB, used: %8llu KiB, 
>>> free_blocks: %llu, used_blocks: %llu\n",
>>> +                order, free >> 10, used >> 10, free_count, 
>>> used_count);
>>>           else
>>> -            pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
>>> -                order, free >> 20, count);
>>> +            pr_info("order-%2d free: %8llu MiB, used: %8llu MiB, 
>>> free_blocks: %llu, used_blocks: %llu\n",
>>> +                order, free >> 20, used >> 20, free_count, 
>>> used_count);
>>>       }
>>>   }
>>>   EXPORT_SYMBOL(gpu_buddy_print);
>>> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
>>> index eef995e08a37..1536e59c6fe7 100644
>>> --- a/drivers/gpu/drm/drm_buddy.c
>>> +++ b/drivers/gpu/drm/drm_buddy.c
>>> @@ -47,17 +47,23 @@ void drm_buddy_print(struct gpu_buddy *mm, 
>>> struct drm_printer *p)
>>>              mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, 
>>> mm->clear_avail >> 20);
>>>       for (order = mm->max_order; order >= 0; order--) {
>>> -        u64 count = mm->free_scoreboard[order];
>>> -        u64 free = count * (mm->chunk_size << order);
>>> +        u64 free_count = mm->free_scoreboard[order];
>>> +        u64 used_count = mm->used_scoreboard[order];
>>> +        u64 block_size = mm->chunk_size << order;
>>> +        u64 free = free_count * block_size;
>>> +        u64 used = used_count * block_size;
>>>           drm_printf(p, "order-%2d ", order);
>>> -        if (free < SZ_1M)
>>> -            drm_printf(p, "free: %8llu KiB", free >> 10);
>>> +        if (block_size < SZ_1M)
>>> +            drm_printf(p, "free: %8llu KiB, used: %8llu KiB",
>>> +                   free >> 10, used >> 10);
>>>           else
>>> -            drm_printf(p, "free: %8llu MiB", free >> 20);
>>> +            drm_printf(p, "free: %8llu MiB, used: %8llu MiB",
>>> +                   free >> 20, used >> 20);
>>> -        drm_printf(p, ", blocks: %llu\n", count);
>>> +        drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
>>> +               free_count, used_count);
>>>       }
>>>   }
>>>   EXPORT_SYMBOL(drm_buddy_print);
>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>> index a28f7d7637ca..e037714563d8 100644
>>> --- a/include/linux/gpu_buddy.h
>>> +++ b/include/linux/gpu_buddy.h
>>> @@ -180,6 +180,14 @@ struct gpu_buddy {
>>>        * called on a free block.
>>>        */
>>>       u64 *free_scoreboard;
>>> +    /*
>>> +     * Per-order used block scoreboard: used_scoreboard[order] 
>>> holds the
>>> +     * number of blocks of that order currently in the allocated 
>>> state.
>>> +     * Incremented in mark_allocated(), decremented in mark_free() 
>>> (guarded
>>> +     * by gpu_buddy_block_is_allocated()) and in __gpu_buddy_free() 
>>> when an
>>> +     * allocated block is consumed directly during buddy coalescing.
>>> +     */
>>> +    u64 *used_scoreboard;
>>>   /* public: */
>>>       unsigned int n_roots;
>>>       unsigned int max_order;
>>
>

