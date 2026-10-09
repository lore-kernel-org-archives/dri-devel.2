Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FF1CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F7410FFDC;
	Fri,  9 Oct 2026 09:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="frWgxYtF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260CA10FFD0;
 Fri,  9 Oct 2026 09:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UasHK5TCzbGKy0VMsYbNcVS64J6f7QDD4gtQ6Gemj71owvHVxMMSqC45UAF03mIBarQwGh7sp8e1IxTKdI83yN5Sw1N0wWXzpesvCDQRm3dxSxubNyq4XBsmCMwkRjmddF74IzaTpdHb/+f3OJ6+TYu8K/t/WUYpO7AdBh4CI5Z3IP7ugfjPjASX7gq+rbZAkZ7Df9L9MUaGIZib0zSK81kzfXUmWOSzBozYCU9hupQ9MDam2UfGa7fkQD6DaQfZPEW5KE6t/gxHkikAlRjJvD8DjHp7wQEvjG/++HVCbRAb6ifmbUOnJUdijCG0ZMm9Jz4EQTv79Q/XQLtT7frOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGtxhQHjstZabHFuRqpEFoFJ/Cm+EhFW99cFq1ZxnKk=;
 b=sMLmb5RfcOkM5Md1Ib36/jcBnt7nUKBAPizTQ2RkSIEBA3ZWZUkzOjzVNSFGxZfoU3TYjFS3lPrZb1hvg45qorAHQQATSj1csHL1mP3j/K9FbCQSHAvvMtBzyQfWzH4MlQ2MXdys0xK8UcXMjSFMSwzfX3tCgg9Qab/Ysgz4NQiwpoE7LlQFntSf6UAzj2Jlcy+AupTVRCT4+xZ8azpNcD/lGofDJ6JCyR69rgAjOf7gLuCbsRDQ3vNIHkbKpgFEmyHRA5faasEW0QfKUYxX0UtHWEAemM0qSjQ7QYezvc8nlPYXIAVFtmTsb0pjm7tU6/B6eDGB1KMIPdfnsLhkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGtxhQHjstZabHFuRqpEFoFJ/Cm+EhFW99cFq1ZxnKk=;
 b=frWgxYtFi+ZdH2PpLW9S/+gDsTuoldvBITChhRi36u2/6M2ZYeH2UFvisAxaRc47ARPr/rJHyANpwyPxCCgVHpcfOHi++S4k5RXf5N2q7InOSOaJTT+6Xr3R5y8grNbLJO9cIZ6PkCJu9y2zGTVn75h73qndt5r+ks5Xw9fcjpY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 9 Oct
 2026 09:14:54 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:14:54 +0000
Message-ID: <b5f63c1e-589d-4f60-869e-bb85c9d2a554@amd.com>
Date: Fri, 9 Oct 2026 14:44:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu/buddy: add range-restricted contiguous allocation
 fallback
To: Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
 <254159a2-66f8-4fce-b185-84e81d126e25@intel.com>
 <b86fd371-289d-479f-bdfe-b2d6136d8d21@amd.com>
 <05785392-b9fd-4d3a-82c5-37b4b6cb5f91@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <05785392-b9fd-4d3a-82c5-37b4b6cb5f91@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::10) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6665ab74-ce53-45f5-91d4-08df25e5c7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|5023799004|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aWvlQg8FTba27dIfDQXlbQiRZbYKFGh4IOocWwqpnsE/76U0HqjXqUOCUL68LeDfG0oOj883xgr2fw0jBYa0VOSASUwWKvbSe+UsHpR/ypbWBMe1yHVxPGFCcxpPbYk6Ub2ygOvWR2AhYds9IfY9ETqVJ2vPFMZzfpcd6eNa9mhBCfbJi8/RUbHs7eysSS1aqMLfoL+iDf4pRGYVR+QHPppdeV4cQ3SE3tCmMDq1YT0GZ+A9vrDi4pXIQa+G9byMXkefAPekru09/kIq20jd1jn9tD8TR//Qy11WPNqUVS1FIPR+i/JNUBPI4f9QFvqF4g3z2JZ0w85t5CQItS7NaHZwfMkt7B4iEd8QrDnmhewdoBa3F3WJkPAQLvl51N6MMG0WZaRR1Hn3d9GOlBtShCJQvYISW8D7SP41CoGsHnHWnZtn4rWBsMVkAD8xikEPzfvj8MC6yT+5oLiNZCsaL6zEyKp9RkGm04wMDtSQ/MiiOO9s+AvKROMH+ic0aHJspQrx/x9LWiiz02jB24GN79UT6M26mhyf8tq+iDY4ZsvJvfpJ4LYXZ/20nQMqslsX7o1maY8Ud1FFMRZIMpdE2kD6gcGqu0+DBK3Ia/ZLwNlTq3pjzzj67LoDbfmDf+yGBODX9fGttgahBSeFgHKnUppalA8tpyw8KrAqxsmSWGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25peFl4S0pYVjVyMktTR2Z1NU5KTExWT2FrMmZUSUlhWlR5UytJbG91cXRs?=
 =?utf-8?B?Y1dtWFpqampia0FjVTFOMDlxOGQ0c3Y5OWo3MjFlV2FkWnBTUnc3NmNrSUZj?=
 =?utf-8?B?QXlhRDdhelpERXZsanlyOElJQlJYSWJBT25YT3czTTE0dFZaTXNvT0tMS01D?=
 =?utf-8?B?U3hQcTAzMnNhZTF5bi9PNEMzQXJRcmM2eWRCWWtad24zOUdqbTVGOW1ML283?=
 =?utf-8?B?VUtkRXdQUFVlT0IyeWkrL3llRmtMR1YvQVl2MS9reTBlZEx2RFBSbG81MXZk?=
 =?utf-8?B?aDNBQ2RQSDdHT1F3bUxIdlM2U3dDdDJLN0w5NEl6cm9MdW4vUkIvcXlWNjd5?=
 =?utf-8?B?U3RtY1JmKzczWGt5cTg2NXEvMTFFYkVONGtVNE9CaFdSUDhYS1J0a3lYbTQ2?=
 =?utf-8?B?OXNpSnRrM3h3Q1JTbG5lRDRtVjZnNHEzWEtHc0RvdGZIVDRQcjBRTEJ6Tm9J?=
 =?utf-8?B?TDZYMGFkWTNlaC8yTU5BUnI1aXd1blVsaUowQjhxaEJhUlNELyt3aTJWUW15?=
 =?utf-8?B?OVRIV0trcVZIYURQMGNDajlWU0pMOWR2ZXJSWWNBVWpWSHIyUnNBZUdsdy9R?=
 =?utf-8?B?Y3hsWW0zazZLM0NheDVwcWtHcU94Y2djSDhUYzJaVHVVYW55azNDMnRhVEZq?=
 =?utf-8?B?WVNUT2FxWkYvaDVFSUFIcVhzVXI5a2lNQ3FpVC83YTArZnNSOFFRRXVoU0h1?=
 =?utf-8?B?dFlGb3FkTnVZN3VHaEF4QnN6NzNyVW55RTJwTUlKL2FLbHhxMkUyNEs5dFVE?=
 =?utf-8?B?WTh2MzBzb2dFeVJpdmt5SXNCdzBmMENtTGxJTE42UkNTcEMyNEVFaldud01W?=
 =?utf-8?B?S1hqaHFabG9VcTgwZkI3OFRCT2xhQ1N4ckY4ZjBzbG5MSDVZOGc1eHU3Z2hm?=
 =?utf-8?B?eGVhVWdkZHlMQ2VtaXZrNWhiajVLOThIUWlKbWhRa05VVmlIZDB2bzNaMVJQ?=
 =?utf-8?B?ZENsU0JVRE5WMmhoTVVMVTZaTXFOWWUzd3BKUmdGTExxaGpSUVhKZTlhR0Q0?=
 =?utf-8?B?MzhUUGIzRVU2c1pOZ3AvWWI4c3RaRU4wY1BHMy9FTFZ6OWpxRWY5M285WGdQ?=
 =?utf-8?B?S1RWLzJUdkw3czAvUkhnN29wV0YyRkorOU02UCsvSElWNnRiOFFERzF1bGNF?=
 =?utf-8?B?T2Y5UHZtQkx6U2pOYzE2eGkyU0ErU1ZXb3oxRXJjL1BkZzJsYVBHNk5IdFk5?=
 =?utf-8?B?bkFXUXROdE1jS3ErNmJPWkN2RHo0a1RNK3NxMHdXR2VlZnBoa0RZSHVWdk9W?=
 =?utf-8?B?ZW1xUmNnVDVDVjkvMjJqcWh3QUx3REpwWlZ6TXlsMXFDS0hUejc0MVVUWVdZ?=
 =?utf-8?B?d29QSlhxeFVMS1JnTkw4N0F6Q2xHTk1Yd3duY3g2OEEydE1WUGpYdVBzSFhN?=
 =?utf-8?B?ZDBqL1FveXBBY01BTXNvQXBrVW52NTVrSTUyaVZCVEMxYytwcVcxWGZnRnFH?=
 =?utf-8?B?MGhrT2ZRbFRKVEQzSXg0RE5aT0NnWUJwektFZm82NEMyMTZUd0N2bUNlQ2ps?=
 =?utf-8?B?TThsU2NyZmJQdDhqSU9hY0IvMFNCUEVXeEJqMWw4S0lOZURYc2NSR1VORXRs?=
 =?utf-8?B?OFh2cG5OMUl3Q20wSEtUby9IMmpad05MM0RMeUYxcmlvNDJCTlpBWFVuSzI0?=
 =?utf-8?B?b0xNNTZYNjNzaU5wUFh4MGU0S2N2SS9WcTVTRUhhVEZpaEQzOFE2K29xR2xB?=
 =?utf-8?B?Vkx1aFo5djF4VUVKNjlkUEtFVzVtR1ZqRmVUYkJrTWpud05VZjdRTW1mQ2xN?=
 =?utf-8?B?M2dUUlg1NWk1UFRUNklOK0drK0xrYk9PSXZyNFJtY1Bvd0g3ME9UMm5icFlv?=
 =?utf-8?B?ZDEzT1J5SzkxdlhGY052MndnKzdEQ3RYMGF0MkxxTjQyamcwWmVGWmJhNis3?=
 =?utf-8?B?QTlZSDVwSEprNW1qTmZka3ovMkxWWm5lRVZheTRueTNvNTFzZmhNRVFQQ0VP?=
 =?utf-8?B?cE90b2R3Z1h1bitUZ1VIaW4wc3hGWjNTWXljWUtzd3NQNi92TGVtRG1iZThC?=
 =?utf-8?B?cmxnRXVNTEdPTU4zTk5aY0dkTWp0by9NVkFlVUFSVjdDblk0R0hRUGEweDFC?=
 =?utf-8?B?RzJZUFRFcEFkeHNYVU9Ha3cvTUJoSzhZdnpVSlVvTHlLMThodjg2cE1MNGxQ?=
 =?utf-8?B?WkUvZnkxVFJqVGhsbnprNkVsekkvRmxIQUorWGFYMFh6SWU2UUtxYjhHbnIr?=
 =?utf-8?B?VjlSYXBKV09NRCtlVEY3cVdkUGtiK1FNakdJcXhzeW8reTN2RmlNL05YZldr?=
 =?utf-8?B?UUxZdUJlNGZPNndiRlJvSjR5djduQjczdi9ZRDJ6UFc5NHl2em1aQ0NvY2hn?=
 =?utf-8?B?bWVqTXU4N1gvVkYrWmRia2V3NENxbWkwNTdYZ2tSVmRqVGt5QXRGUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6665ab74-ce53-45f5-91d4-08df25e5c7e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:14:54.2876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zcUCUuati1P53cu3Mphlz27k/aEDlJstpNAhY8PzdugFyT3pu9oxPdQGTG0ma4sG0YJQrEbOksLhYLkpWMB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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



On 10/6/2026 3:27 PM, Matthew Auld wrote:
> On 05/10/2026 15:14, Arunpravin Paneer Selvam wrote:
>>
>>
>> On 10/1/2026 11:58 PM, Matthew Auld wrote:
>>> On 30/09/2026 07:21, Arunpravin Paneer Selvam wrote:
>>>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>>
>>>> A range + contiguous allocation (e.g. a scanout FB confined to the
>>>> CPU-visible VRAM aperture) rounds its size up to a power of two and
>>>> requires a naturally aligned free block of that size; on a fragmented
>>>> aperture no such aligned block may exist even though enough contiguous
>>>> space is free, so the allocation fails with -ENOSPC.
>>>>
>>>> The non-range contiguous path already recovers from this via
>>>> __alloc_contig_try_harder(), which stitches an exact-size span from
>>>> smaller adjacent blocks, but that fallback was unreachable once
>>>> GPU_BUDDY_RANGE_ALLOCATION was set. Give __alloc_contig_try_harder()
>>>> a [range_start, range_end) window and route the range + contiguous
>>>> case through it: each candidate placement is confined to the window
>>>> and aligned to min_block_size. Non-range callers pass [0, mm->size),
>>>> where the guards are no-ops, so the existing behaviour is unchanged.
>>>> A KUnit regression test covers the fragmentation pattern.
>>>>
>>>> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
>>>> regression.
>>>>
>>>> v2:
>>>>   - Drop the split-undo patch; the range-bias search always 
>>>> descends to
>>>>     an exact-order block or fails the split (already handled), so the
>>>>     extra undo was redundant. (Matthew)
>>>>   - Verified this fallback alone fixes the kms_plane regression.
>>>>
>>>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>>>> decoupled dirty tracker")
>>>
>>> Patch looks more like totally new functionally/feature, so the fixes 
>>> here is maybe unexpected? Did something in that fixes commit change 
>>> something such that the try_harder is now needed, but that needs 
>>> some expansion with bias + contig? Do we know exactly what changed 
>>> here?
>> That commit removed __force_merge(), which previously helped recover 
>> larger contiguous allocations on demand. As a result, some range- 
>
> __force_merge() got nuked, but IIRC I think that was essentially 
> because we now "force merge" on free, so shouldn't we get the ~same 
> result? Or is the fact that we force_merge() on every free giving a 
> different layout of pages, and with some very some specific allocation 
> pattern that difference subtly results in -ENOSPC, somehow?
You are right - merge-on-free reclaims contiguity just like the old 
on-demand  __force_merge() , so that is not the cause and the layout is 
effectively the same. The real change is where clear/dirty segregation 
lives: it used to be an inline guard inside __alloc_range_bias() , but 
the rework pulled it out into dirty_steer_window() , which only runs for 
non-range allocations. So range (aperture) requests now go through  
__alloc_range_bias()  with no clear/dirty guard at all - clear and dirty 
allocations interleave and fragment the aperture until no large 
same-class run survives for a 4K scanout pin (-> -ENOSPC). Restoring 
that two-pass guard is the real fix.

I have accordingly moved the  Fixes:  tag onto that guard-restore patch, 
and kept the range support in  __alloc_contig_try_harder() as a new 
feature -  it still helps, but it is a safety-net fallback that should 
land on top, not as the root-cause fix.

Regards,
Arun.
>
>> restricted contiguous allocation requests
>> that used to succeed now fail with -ENOSPC (the kms_plane 
>> regression). This patch restores that capability through the 
>> try_harder() stitching logic, so the Fixes: tag reflects a
>> regression introduced by that commit rather than new functionality.
>>>
>>>> Assisted-by: Claude:claude-opus-4-8
>>>
>>> Assisted-by: LLM
>>>
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> ---
>>>>   drivers/gpu/buddy.c                | 88 
>>>> ++++++++++++++++--------------
>>>>   drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++++--
>>>>   2 files changed, 126 insertions(+), 45 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>>> index 2f2aaadafe35..5265e1f6a318 100644
>>>> --- a/drivers/gpu/buddy.c
>>>> +++ b/drivers/gpu/buddy.c
>>>> @@ -1685,26 +1685,14 @@ static int __gpu_buddy_alloc_range(struct 
>>>> gpu_buddy *mm,
>>>>                    blocks, total_allocated_on_err);
>>>>   }
>>>>   -static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
>>>> -                    u64 unaligned_offset,
>>>> -                    u64 size,
>>>> -                    u64 min_block_size,
>>>> -                    unsigned long flags,
>>>> -                    struct list_head *blocks)
>>>> -{
>>>> -    u64 aligned_offset = round_down(unaligned_offset, 
>>>> min_block_size);
>>>> -
>>>> -    return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
>>>> -                       NULL, blocks);
>>>> -}
>>>> -
>>>>   static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>>> +                     u64 range_start, u64 range_end,
>>>>                        u64 size,
>>>>                        u64 min_block_size,
>>>>                        unsigned long flags,
>>>>                        struct list_head *blocks)
>>>>   {
>>>> -    u64 rhs_offset, lhs_offset, filled;
>>>> +    u64 rhs_offset, lhs_offset, filled, aligned;
>>>>       struct gpu_buddy_block *block;
>>>>       struct rb_root *root;
>>>>       struct rb_node *iter;
>>>> @@ -1734,20 +1722,24 @@ static int __alloc_contig_try_harder(struct 
>>>> gpu_buddy *mm,
>>>>                              flags, &filled, blocks);
>>>>           if (err && err != -ENOSPC)
>>>>               return err;
>>>> -        if (!err && IS_ALIGNED(rhs_offset, min_block_size))
>>>> +        if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
>>>> +            rhs_offset >= range_start && rhs_offset + size <= 
>>>> range_end)
>>>>               return 0;
>>>>           if (!err) {
>>>>               /* Allocate the unaligned RHS offset using round_down */
>>>>               gpu_buddy_free_list_internal(mm, blocks);
>>>> -            err = __alloc_contig_aligned_retry(mm, rhs_offset,
>>>> -                               size,
>>>> -                               min_block_size,
>>>> -                               flags, blocks);
>>>> -            if (!err)
>>>> -                return 0;
>>>> -            if (err != -ENOSPC) {
>>>> -                gpu_buddy_free_list_internal(mm, blocks);
>>>> -                return err;
>>>> +
>>>> +            aligned = round_down(rhs_offset, min_block_size);
>>>> +            if (aligned >= range_start &&
>>>> +                aligned + size <= range_end) {
>>>> +                err = __gpu_buddy_alloc_range(mm, aligned, size,
>>>> +                                  flags, NULL, blocks);
>>>
>>> Did you consider doing a bias-range for [start, end] using 
>>> min_block_size and using what it returns as the starting point, 
>>> extending left/right? If that fails advance start and try again? 
>>> Maybe what you have here is much better for the case you have in mind?
>> I took a closer look at the alloc_range_bias approach. My 
>> understanding is that this would repeatedly bias within [start, end], 
>> use the returned min_block_size block as a starting point, and then 
>> extend left/right to build the requested run.
>> While that should work, every failed attempt may require splitting 
>> higher-order blocks to obtain a min_block_size block, followed by a 
>> free/merge back when the extension fails.
>> The free-tree descent evaluates the available starting points through 
>> a tree walk without any splitting or allocation just for enumeration, 
>> so I kept that approach.
>> Please let me know if there is a case where alloc_range_bias would 
>> provide an advantage over the free-tree descent.
>>
>> While evaluating it, I found two issues in the current try_harder() 
>> implementation:
>>
>> 1. It only searches free_tree[size_order]. This is insufficient when 
>> min_block_size < size. For example, for a 128 KiB allocation 
>> (order-5) with min_block_size = 4 KiB, free_tree[5] may be empty
>> while two adjacent order-4 (64 KiB) blocks covering [64 KiB, 128 KiB] 
>> and [128 KiB, 192 KiB] are free. These blocks still form a valid 
>> order-5-sized contiguous run, but they can never appear in
>> free_tree[5] because they are not mergeable buddies. As a result, a 
>> search that only considers free_tree[5] will never find this 
>> placement. v3 addresses this by walking the free tree from the
>> requested size order down to min_order, while reusing the existing 
>> extend/stitch logic and min_block_size alignment checks unchanged.
>>
>> 2. The search is not restricted to the requested range. v3 confines 
>> the walk to [range_start, range_end], skipping candidates at or above 
>> range_end and stopping once the walk falls below range_start.
>> This ensures that range-constrained allocations only consider free 
>> blocks within the requested window and avoids performing 
>> allocation/free attempts on blocks outside the specified range.
>> For non-range callers, the effective window remains [0, mm->size], so 
>> the behavior is unchanged.
>>
>> Regards,
>> Arun.
>>>
>>>> +                if (!err)
>>>> +                    return 0;
>>>> +                if (err != -ENOSPC) {
>>>> +                    gpu_buddy_free_list_internal(mm, blocks);
>>>> +                    return err;
>>>> +                }
>>>>               }
>>>>               goto next;
>>>>           }
>>>> @@ -1759,15 +1751,17 @@ static int __alloc_contig_try_harder(struct 
>>>> gpu_buddy *mm,
>>>>             /* Allocate the unaligned LHS offset using round_down */
>>>>           gpu_buddy_free_list_internal(mm, blocks);
>>>> -        err = __alloc_contig_aligned_retry(mm, lhs_offset,
>>>> -                           size,
>>>> -                           min_block_size,
>>>> -                           flags, blocks);
>>>> -        if (!err)
>>>> -            return 0;
>>>> -        if (err != -ENOSPC) {
>>>> -            gpu_buddy_free_list_internal(mm, blocks);
>>>> -            return err;
>>>> +
>>>> +        aligned = round_down(lhs_offset, min_block_size);
>>>> +        if (aligned >= range_start && aligned + size <= range_end) {
>>>> +            err = __gpu_buddy_alloc_range(mm, aligned, size,
>>>> +                              flags, NULL, blocks);
>>>> +            if (!err)
>>>> +                return 0;
>>>> +            if (err != -ENOSPC) {
>>>> +                gpu_buddy_free_list_internal(mm, blocks);
>>>> +                return err;
>>>> +            }
>>>>           }
>>>>   next:
>>>>           gpu_buddy_free_list_internal(mm, blocks);
>>>> @@ -2021,11 +2015,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy 
>>>> *mm,
>>>>       min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>>>>         if (order > mm->max_order || size > mm->size) {
>>>> -        if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
>>>> -            !(flags & GPU_BUDDY_RANGE_ALLOCATION))
>>>> -            return __alloc_contig_try_harder(mm, original_size,
>>>> +        if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
>>>> +            u64 range_start, range_end;
>>>> +
>>>> +            range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>>>> start : 0;
>>>> +            range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end 
>>>> : mm->size;
>>>> +
>>>> +            return __alloc_contig_try_harder(mm, range_start,
>>>> +                             range_end,
>>>> +                             original_size,
>>>>                                original_min_size,
>>>>                                flags, blocks);
>>>> +        }
>>>>             return -EINVAL;
>>>>       }
>>>> @@ -2058,9 +2059,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy 
>>>> *mm,
>>>>                * Try contiguous block allocation through
>>>>                * try harder method.
>>>>                */
>>>> -            if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
>>>> -                !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
>>>> -                err = __alloc_contig_try_harder(mm,
>>>> +            if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
>>>> +                u64 range_start, range_end;
>>>> +
>>>> +                range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) 
>>>> ? start : 0;
>>>> +                range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>>>> end : mm->size;
>>>> +
>>>> +                err = __alloc_contig_try_harder(mm, range_start,
>>>> +                                range_end,
>>>>                                   original_size,
>>>>                                   original_min_size,
>>>>                                   flags,
>>>> @@ -2068,9 +2074,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>>>                   if (!err)
>>>>                       return 0;
>>>>                   if (err != -ENOSPC)
>>>> -                    return err;
>>>> -                goto err_free;
>>>> +                    goto err_free;
>>>>               }
>>>> +
>>>>               err = -ENOSPC;
>>>>               goto err_free;
>>>>           } while (1);
>>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>>>> b/drivers/gpu/tests/ gpu_buddy_test.c
>>>> index b75d32ca6ca0..2c445870b808 100644
>>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>>> @@ -1251,6 +1251,77 @@ static void 
>>>> gpu_test_buddy_alloc_contiguous(struct kunit *test)
>>>>       gpu_buddy_fini(&mm);
>>>>   }
>>>>   +static void gpu_test_buddy_alloc_range_contiguous(struct kunit 
>>>> *test)
>>>> +{
>>>> +    const unsigned long ps = SZ_4K, mm_size = 16 * ps;
>>>> +    const unsigned long range_end = 8 * ps;
>>>> +    struct gpu_buddy_block *block, *prev;
>>>> +    LIST_HEAD(allocated);
>>>> +    struct gpu_buddy mm;
>>>> +    LIST_HEAD(pin_lo);
>>>> +    LIST_HEAD(pin_hi);
>>>> +    u64 total;
>>>> +
>>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
>>>> +                   "buddy_init failed\n");
>>>> +
>>>> +    /*
>>>> +     * Idea is to confine the test to the sub-range [0, 32K), 
>>>> which a 12K
>>>> +     * contiguous request (rounded up to 16K) splits into two 
>>>> naturally
>>>> +     * aligned 16K slots: [0, 16K) and [16K, 32K). We pin the 
>>>> first 4K page
>>>> +     * of each slot ([0, 4K) and [16K, 20K)) so that neither 
>>>> aligned slot
>>>> +     * can satisfy the rounded-up 16K allocation, yet the freed 
>>>> remainder
>>>> +     * still leaves a contiguous 12K hole at offset 4K, which is 
>>>> page-aligned
>>>> +     * but not 16K-aligned. A 12K contiguous+range allocation must 
>>>> therefore
>>>> +     * fall back to stitching that span instead of returning -ENOSPC.
>>>> +     */
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
>>>> +                              &pin_lo, 0),
>>>> +                   "failed to pin low page\n");
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
>>>> +                              ps, &pin_hi, 0),
>>>> +                   "failed to pin high page\n");
>>>> +
>>>> +    /* No aligned 16K block is free; the range-aware fallback must 
>>>> stitch
>>>> +     * the unaligned [ps, 4*ps) hole instead of returning -ENOSPC.
>>>> +     */
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, 0, range_end, 3 * ps,
>>>> +                              ps, &allocated,
>>>> + GPU_BUDDY_CONTIGUOUS_ALLOCATION |
>>>> +                              GPU_BUDDY_RANGE_ALLOCATION),
>>>> +                   "range-restricted contiguous alloc failed\n");
>>>> +
>>>> +    /* The result must be exactly 3*ps, contiguous, and inside the 
>>>> range. */
>>>> +    total = 0;
>>>> +    prev = NULL;
>>>> +    list_for_each_entry(block, &allocated, link) {
>>>> +        u64 offset = gpu_buddy_block_offset(block);
>>>> +        u64 bsize = gpu_buddy_block_size(&mm, block);
>>>> +
>>>> +        KUNIT_EXPECT_TRUE_MSG(test, offset + bsize <= range_end,
>>>> +                      "block [%llx, %llx) outside range\n",
>>>> +                      offset, offset + bsize);
>>>> +        if (prev)
>>>> +            KUNIT_EXPECT_EQ_MSG(test,
>>>> +                        gpu_buddy_block_offset(prev) +
>>>> +                        gpu_buddy_block_size(&mm, prev),
>>>> +                        offset,
>>>> +                        "block at %llx not contiguous\n",
>>>> +                        offset);
>>>> +        prev = block;
>>>> +        total += bsize;
>>>> +    }
>>>> +    KUNIT_EXPECT_EQ(test, total, 3 * ps);
>>>> +
>>>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>>>> +    gpu_buddy_free_list(&mm, &pin_lo, 0);
>>>> +    gpu_buddy_free_list(&mm, &pin_hi, 0);
>>>> +    gpu_buddy_fini(&mm);
>>>> +}
>>>> +
>>>>   static void gpu_test_buddy_alloc_pathological(struct kunit *test)
>>>>   {
>>>>       u64 mm_size, size, start = 0;
>>>> @@ -1534,10 +1605,13 @@ static void 
>>>> gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>>>>                        GPU_BUDDY_RANGE_ALLOCATION);
>>>>       KUNIT_EXPECT_EQ(test, err, -EINVAL);
>>>>   -    /* CONTIGUOUS + RANGE should return -EINVAL (no try_harder 
>>>> for RANGE) */
>>>> -    err = gpu_buddy_alloc_blocks(&mm, 0, mm_size, size, SZ_4K, 
>>>> &blocks,
>>>> -                     GPU_BUDDY_CONTIGUOUS_ALLOCATION | 
>>>> GPU_BUDDY_RANGE_ALLOCATION);
>>>> -    KUNIT_EXPECT_EQ(test, err, -EINVAL);
>>>> +    /* CONTIGUOUS + RANGE should succeed via the range-aware 
>>>> try_harder */
>>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, 
>>>> mm_size, size,
>>>> +                                SZ_4K, &blocks,
>>>> + GPU_BUDDY_CONTIGUOUS_ALLOCATION |
>>>> + GPU_BUDDY_RANGE_ALLOCATION),
>>>> +                   "range contiguous alloc hit an error 
>>>> size=%llu\n", size);
>>>> +    gpu_buddy_free_list(&mm, &blocks, 0);
>>>>         gpu_buddy_fini(&mm);
>>>>   }
>>>> @@ -1603,6 +1677,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_pathological),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
>>>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>>>>
>>>> base-commit: 744f262401cc2e1f3827496c72a47e072d31a852
>>>
>>
>

