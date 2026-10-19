Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69AACCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D1610E79B;
	Mon, 19 Oct 2026 04:51:12 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD62510E785;
 Mon, 19 Oct 2026 04:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZVEzpoTsoJ+D5M7WAykqxTBS6ZeMffGjjTtQ93qER4iLAsxBuBgtkDdAOQPeKMXRzyWZ0rczSctzkRrC8MdafrQnaEXeg352vjuUg7FuZPQPLhZqiK6EgGaifYC8TK3hAOhNdPwk/0sCdLcG+JMbCnvd78N5LRQA72RGjDa1id4ks5OhkzwfutirCDGhmUfGVf+k6vzcQwP0EzE5T9HAVUICuG1PdvRqVPCQPEOuDq/FgFkMCNOJMLAyB61phEAskSWDjzcp1cDdShFRhqcPohkXJB1IvO4bVrpi0fkyQxuP3AucTEqUNgbTzP1u2Th9fRslBhjp0kCjMyUXM0/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxAntgENbKeHN4f0UbVbkRl7WjvBXL9z7vAXhPEZr4w=;
 b=urLoeMidM7qvyczy+ZIEzV74DP5KieJok83Lq/fK46bWASq3AhQfQUq0YuQPnE4ymc3STbx/HNW8R21mH7HU/VOS3lQNqGcQAZDYUboeFsQyTRgGzUVOEud1o7Jbi285hoJW0tmvcv8nIc+igCDvC/2wu9GmEdoWupXxb/uklS7pFSN6UfDRvXRI3tRPszvlsFrey13DnRkHr+RVPY7adv0OXx5QlWcKVT6Q2IsWVKCGpNMwifGIqDrM2/KsbozM0QQ7x285VytWGBpOLX8JpVVLUfkeairU6HbaNY6SFbstp/z9Zf47ikcIuYoPkeysS+ygIyP7cHwx8+a0CiR7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxAntgENbKeHN4f0UbVbkRl7WjvBXL9z7vAXhPEZr4w=;
 b=elY3Hw6WwxdJiNrOzhbQDZJO7iRyVrq3iBExocZlqw5vSaSKRHuPVvkfxY4NphjyVHqsMhfo8nQhhw57RtXczEsEcKHBPa3KoR35UxQfMAZTv/qBsWCfYIkw5dT3RmEFb5w6toYcisS8X8maxW1IDXkvdYLVVvgDUAddpOTb/Vo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 04:51:01 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 04:51:01 +0000
Message-ID: <471cd64f-6dd1-4f8a-b446-94423d9d1439@amd.com>
Date: Mon, 19 Oct 2026 10:20:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
 <3e16b7d9-b1d6-4d6c-8f58-f6716fff71a6@amd.com>
 <343cf7b2-6241-4e3c-8b37-2f0ea75c6723@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <343cf7b2-6241-4e3c-8b37-2f0ea75c6723@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0218.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: a9567dbc-b9fd-4d77-598d-08df2d9c9293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N5f5R7CeCzySZuwQn9mFWysBSNMwfQHWCfVGnwUeHy3XPbM3aQ16FwxDNXLzwViEUF/qkRFysBePyjX7xd27iY0Xx5XiLGAe8qV0Mldc2UoExnp6yrwHfpZEGlusQRniQ9z8t5atmfozyXMGNko6WzmaDyhLdypzW8uPT0s3nN/vehpyUHYdXj1NidmgSqWGEvPHau9eIO2DbGQGa/b0DRbTnnG3zkkwsyiJ8kfQpwKdlg5ddofsUDA0pP2i0GHosltTk5pYO2QaylD7lniyILoTWWD7hUQpbHe45eImtPFI9ZwzIBvOKfc0301fdx2zsd0J+gAMRTxZHD+vNK30Wen4JYWykhcYRwrIPuAXTENlVYLWkRSAkbhG7ZqM9OdRpOkK0JCi93YOrkI6qbwSnRiMxqqEpFh8jkrZtmd3yZG1vh9xNqVIYemTMSot9Kmsga4CMTWpHckljIdH2NCN9mXQcgze6L6TycYVh4uoEucN6qyW7bb+uZNpHbkbq/YvkGLq2tpzXH1kF770gVc9WzgQpRrjE3WcEQPsb5RcqpNKeXjqki/tYFGPV2hVjs//ApjVZkAocBq9m5Mo6Kv+ffX0mYI2QIaiqb5UqLLhZI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJXWnk5bVhYcmZNdUFGeXZ6R0NLaDdEaWhVWEFFTnFtb0RtNG9qaUEyRWha?=
 =?utf-8?B?VHhnMDBQYmJmUXJLUk03VlRKTHEvNE9CbENTSW8xQ3IzVklNRXBRdDBWMFNW?=
 =?utf-8?B?bitkdmg5L1ZGWk52bjBJbUUrNFNFNnlJbi9ubGRBZnFDTzNuQkJ2ZTRSM3lN?=
 =?utf-8?B?OWNVS3NJK1E0aEVXaFphOUZCbUtVeVNEa1JueVVtR1VpY1k0bWk0TFRBbjhK?=
 =?utf-8?B?T1FzOVpzNzR1czhEVytUNCsvU0FBUTVmZndYN20zaXpDZ2Nncnh2MEd0ZEln?=
 =?utf-8?B?aXYyQWdmdWlrQUpnUFRjalFkN1UvZzhCdFpHNEFQY1FaVkpMYlFlWkJlQWxP?=
 =?utf-8?B?eGd4aVVyOWxTWnpQZDF1ZGZKekxHS2JDT2RIbkFYYjRKYjJ6d0tLc0l3TWh2?=
 =?utf-8?B?U2tmK2xZaGkydEZLZ0wzUGlGcTJsVjA0bTZmeFlJc0dEandTejBXdW42anhE?=
 =?utf-8?B?MHlPQk83Szd2TDVnbWx6THNjTlFjRXBqaWNCQlRCeTdRenNXMldjalJNTktP?=
 =?utf-8?B?UDl5RDY4WlRVZ3E1RXhWcm1ObzM1V2dZTTNkWlFMeXE5SlF5dWkrWEdZUEVa?=
 =?utf-8?B?TVNCNXZ3TzFZcGlrRUI4blBHSlkvZ1JaYUVhMy9NRXdjUDE3SFNOMXQ4YWd2?=
 =?utf-8?B?Q2wrdTd5cWxEQXk4bGpRbVBaelVRYVdpV080bVpUTC81aEFsTnRQMld4aTZK?=
 =?utf-8?B?NGRRUEt2aXlncUxWQlFCRmk2N0NUZVFyeTJ0MUVjUzN0MXdaZGlUQXJpYndM?=
 =?utf-8?B?ZWpweDRidUdtWWhzVklhaWlqODEwUHd5WVQ4a0JZMFU4eFhaWjVjblVaZjRo?=
 =?utf-8?B?SUp3WXVmTk0xcFdlTkxIY0dQQlkvMVVBa3pOOEVsN1RTUVZzdEJpR3UwazdS?=
 =?utf-8?B?SlNTT1dJSzUyTlBxUzZTQjBUMC9jZWZHditWaG9UQlBRaXQrTk1XR2VSak0y?=
 =?utf-8?B?MGZrNzl5Y1JlRm1GQWlEZkswNjVhMEFwSFJCTnU2RHBnWUpIWE9lYU42OGZz?=
 =?utf-8?B?OXQ0Zmt2ZHZEejlHMW0vZWRlOXZDSTNyL1ZYRkwyb3ZnQ0NhYjB1UkZnQk1D?=
 =?utf-8?B?NXk3bXNKT2k2bFBOcnBRZXNIcDBIQ0t6U3Y1WmloS29Hb2IxYk9iYXZSaGJD?=
 =?utf-8?B?QmZvdXJ6VFlJZ05KRDdjc0QveXRIU1hGNDVmWUFQWThtRllTMTl3eGl4NEg5?=
 =?utf-8?B?dTJGajhGc25ILy9mU3BmbmZWQWFWOUFqOU01TnRCQjI4VERUUW1KUTFJMktI?=
 =?utf-8?B?Mjh6UXRHOUV1Wi9rQml2LzdFQXp6N2k1Y3lvK09PZ1ZxS1Y4dXFSMkZSa1V1?=
 =?utf-8?B?L05SRTh1YVNMVFJGTldPNlViQ1MyOVVFV3E4SitjLzdGUGRHZFYvVHdvVmxp?=
 =?utf-8?B?QVlEb3p6Vmgrck02YitOSDZyK3R2ME9LMEUzQ3lVeE1zbU9oZ3V0SzVKczV6?=
 =?utf-8?B?bm1BekFLcWdxQjFjVGdqL25qbkZUR3lCY3pmWXBZQkNVRWt6a3lkNStOb0Zh?=
 =?utf-8?B?RmJtVGROVTJiUVdDYlI4aldlWmFMVlpmTFZGeTM1SVR0cVNDVGpiYzVHVkhv?=
 =?utf-8?B?aWdZYVY0THFVKzNKbXZheDBmaHArMFV0eGJLWUZTZjljUUxLb2ZxRzc5UmxY?=
 =?utf-8?B?Zy9OY1dycUR5RTdzNHlPSit6R1BJMVdReklSa0hZWTRRemJPaURwVzlpai9a?=
 =?utf-8?B?eWJweXNxZFZmbDFuMWl2N0hyL0VKOG16V3NTUkQyZGR1bmZqSmtUcnJ3ZjEx?=
 =?utf-8?B?KzgzYWUxeW1LeDFwajRDRHRHV1RwVHdtaW1IdkwzMmxFQk1nZU5zMnpSUWxu?=
 =?utf-8?B?aVZQeFlYMFB5a3ExWXorajhiNnAxWkV5S1d5cWdVYW02TmpybC8zS3JZQU1G?=
 =?utf-8?B?aTkwUjhIaXZ6MWpEOXNtMTZFVUxqZ2RqQm5wM29kcmdMb0JsNFlDRWxoeGZP?=
 =?utf-8?B?OEc0NytzeGcrb0hZemNhTGhmQkk5ZDZmYXVHQzFjUlcxaTMzNXJXRDcrbWRy?=
 =?utf-8?B?WmF4WHkweXg3RjdZV3BwWER3Q1BLa2lVNzdWZmI5ZmUwd25hZHV5TnFKUWRi?=
 =?utf-8?B?dk5rNWROSlMzOTRldDE3L0dEYnBsS1pwWlB4MU1TQjFEMTRtWWRYT0NKV1hI?=
 =?utf-8?B?QlFnRmE4U2JNNGtDdlZWV29rR3k3Qng4QU9DQ3BRazBJQ3cvV0VkT3ZpUmJQ?=
 =?utf-8?B?MFYzSzZ1Rk1wcVUwRzhwY2dHeUdibnVSQVJHNVBXeXE1MVJmSk5KeVpXZmVl?=
 =?utf-8?B?V3VGT3drSkRDdUtXaTFBeEdsanhobnZtcGhkakFsaGhTT25jRUFEZW1kWXQx?=
 =?utf-8?B?Z0NPUFU1b1lHN2dxUU9XaUVBcHBmYTlNcXNDd2lwSVQ1STU5dEFHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9567dbc-b9fd-4d77-598d-08df2d9c9293
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 04:51:00.8595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akmr83l5j1ax4Ux2E0Aix9UrVomaVv+t0nw8nlAoJhYnDlNsoW9H31Xc8D9HyWZD4v9Zk0UOqlw8V10mEG3npQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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



On 10/13/2026 8:36 PM, Matthew Auld wrote:
> Hey,
>
> Yes, going to go through it now. Did you already look over the Sashiko 
> reports:
> https://sashiko.dev/#/patchset/20261009100546.1103622-1-arunpravin.paneerselvam%40amd.com 
>
>
> Are they all false positive? I wanted to hold off reviewing if you 
> were going to re-spin.
I am preparing a patch to address the issues reported by Sashiko.
>
> Also, on the "bugs" tab in Sashiko there was one open buddy issue, 
> which I sent a fix for:
> https://lore.kernel.org/intel-xe/20261006110706.1636971-2-matthew.auld@intel.com/ 
>
>
> Please take a look at that.
Sure. I will also take a look at the buddy fix you sent.

Thanks,
Arun.
>
> On 13/10/2026 15:31, Arunpravin Paneer Selvam wrote:
>> Hi Matthew,
>> Could you please review the v4.
>>
>> Thanks,
>> Arun.
>>
>> On 10/9/2026 3:35 PM, Arunpravin Paneer Selvam wrote:
>>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>
>>> Range-restricted allocations (the visible-VRAM aperture) skip
>>> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
>>> eligibility guard, so a dirty allocation freely splits clear extents 
>>> (and
>>> vice versa), interleaving the two classes until no large same-class run
>>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>>> search instead: block_incompatible() rejects opposite-class blocks 
>>> in the
>>> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
>>> request still succeeds when only opposite-class space remains. A KUnit
>>> regression test covers the interleaving pattern and fails without the
>>> guard.
>>>
>>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>>> decoupled dirty tracker")
>>> Assisted-by: LLM
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/buddy.c                | 71 
>>> ++++++++++++++----------------
>>>   drivers/gpu/tests/gpu_buddy_test.c | 65 +++++++++++++++++++++++++++
>>>   2 files changed, 99 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index 2f2aaadafe35..6566bad4fef1 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct 
>>> gpu_buddy *mm,
>>>       }
>>>   }
>>> +static bool block_incompatible(struct gpu_buddy_block *block, 
>>> unsigned int flags)
>>> +{
>>> +    bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
>>> +
>>> +    return needs_clear != gpu_buddy_block_is_clear(block);
>>> +}
>>> +
>>>   static struct gpu_buddy_block *
>>>   __alloc_range_bias(struct gpu_buddy *mm,
>>>              u64 start, u64 end,
>>>              unsigned int order,
>>> -           unsigned long flags)
>>> +           unsigned long flags,
>>> +           bool fallback)
>>>   {
>>>       u64 req_size = mm->chunk_size << order;
>>>       struct gpu_buddy_block *block;
>>> @@ -1258,9 +1266,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>        * This range-constrained search hands back the 
>>> highest/right-most
>>>        * address that satisfies the request: the roots are seeded 
>>> high-to-low
>>>        * and the right (higher-address) child is descended first, 
>>> making
>>> -     * top-down the default placement here. A non-top-down clear 
>>> request is
>>> -     * the only exception, where the descent is biased towards 
>>> clear or
>>> -     * clear-containing subtrees to satisfy the clear preference.
>>> +     * top-down the default placement here.
>>>        */
>>>       for (i = mm->n_roots - 1; i >= 0; --i)
>>>           list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>>> @@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   continue;
>>>           }
>>> +        if (!fallback && block_incompatible(block, flags))
>>> +            continue;
>>> +
>>>           if (contains(start, end, block_start, block_end) &&
>>>               order == gpu_buddy_block_order(block)) {
>>>               /*
>>> @@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   goto err_undo;
>>>           }
>>> -        /*
>>> -         * Top-down is a strict address-placement policy, so when 
>>> it is
>>> -         * requested we ignore clear steering and simply descend the
>>> -         * right (higher-address) child first. Only a non-top-down 
>>> clear
>>> -         * request biases the descent towards clear/has_clear 
>>> subtrees.
>>> -         */
>>> -        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>>> -            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>>> -            struct gpu_buddy_block *prefer;
>>> -
>>> -            if (gpu_buddy_block_is_clear(block->right))
>>> -                prefer = block->right;
>>> -            else if (gpu_buddy_block_is_clear(block->left))
>>> -                prefer = block->left;
>>> -            else if (block->right->has_clear)
>>> -                prefer = block->right;
>>> -            else if (block->left->has_clear)
>>> -                prefer = block->left;
>>> -            else
>>> -                prefer = block->right;
>>> -
>>> -            if (prefer == block->right) {
>>> -                list_add(&block->left->tmp_link, &dfs);
>>> -                list_add(&block->right->tmp_link, &dfs);
>>> -            } else {
>>> -                list_add(&block->right->tmp_link, &dfs);
>>> -                list_add(&block->left->tmp_link, &dfs);
>>> -            }
>>> -        } else {
>>> -            list_add(&block->left->tmp_link, &dfs);
>>> -            list_add(&block->right->tmp_link, &dfs);
>>> -        }
>>> +        list_add(&block->left->tmp_link, &dfs);
>>> +        list_add(&block->right->tmp_link, &dfs);
>>>       } while (1);
>>>       return ERR_PTR(-ENOSPC);
>>> @@ -1361,6 +1340,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>       return ERR_PTR(err);
>>>   }
>>> +static struct gpu_buddy_block *
>>> +__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
>>> +                 u64 start, u64 end,
>>> +                 unsigned int order,
>>> +                 unsigned long flags)
>>> +{
>>> +    struct gpu_buddy_block *block;
>>> +    bool fallback = false;
>>> +
>>> +    block = __alloc_range_bias(mm, start, end, order,
>>> +                   flags, fallback);
>>> +    if (IS_ERR(block))
>>> +        return __alloc_range_bias(mm, start, end, order,
>>> +                      flags, !fallback);
>>> +
>>> +    return block;
>>> +}
>>> +
>>>   /* Return the highest-address free block of at least @order. */
>>>   static struct gpu_buddy_block *
>>>   get_maxblock(struct gpu_buddy *mm,
>>> @@ -1924,7 +1921,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>>       if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>>>           /* Allocate traversing within the range */
>>> -        block = __alloc_range_bias(mm, start, end, order, flags);
>>> +        block = __gpu_buddy_alloc_range_bias(mm, start, end, order, 
>>> flags);
>>>           if (!IS_ERR(block) || !steered)
>>>               return block;
>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/ 
>>> gpu_buddy_test.c
>>> index b75d32ca6ca0..3eaa261571bf 100644
>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>> @@ -1597,6 +1597,70 @@ static int gpu_buddy_suite_init(struct 
>>> kunit_suite *suite)
>>>       return 0;
>>>   }
>>> +static void gpu_test_buddy_alloc_range_clear_guard(struct kunit *test)
>>> +{
>>> +    const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
>>> +    struct gpu_buddy_block *block;
>>> +    LIST_HEAD(high_clear_a);
>>> +    LIST_HEAD(high_clear_b);
>>> +    LIST_HEAD(low_dirty);
>>> +    struct gpu_buddy mm;
>>> +    LIST_HEAD(barrier);
>>> +    LIST_HEAD(result);
>>> +
>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
>>> +                   "buddy_init failed\n");
>>> +
>>> +    /*
>>> +     * Lay out a 4 MiB aperture as three regions:
>>> +     *
>>> +     *   [0,  1M)   dirty free
>>> +     *   [1M, 2M)   allocated  (barrier, keeps the two halves un- 
>>> mergeable)
>>> +     *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
>>> +     *
>>> +     * A dirty (non-clear) range allocation must take the low dirty 
>>> block
>>> +     * and leave the large clear extent intact. Without the guard the
>>> +     * top-down search cuts the higher clear extent instead and 
>>> returns a
>>> +     * clear block -- the interleaving that fragments the aperture and
>>> +     * ultimately fails a large same-class scanout allocation.
>>> +     */
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
>>> +                              &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
>>> +                   "alloc [0, 1M) failed\n");
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, 
>>> chunk, chunk,
>>> +                              &barrier, GPU_BUDDY_RANGE_ALLOCATION),
>>> +                   "alloc [1M, 2M) failed\n");
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * 
>>> chunk, chunk, chunk,
>>> +                              &high_clear_a, 
>>> GPU_BUDDY_RANGE_ALLOCATION),
>>> +                   "alloc [2M, 3M) failed\n");
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * 
>>> chunk, chunk, chunk,
>>> +                              &high_clear_b, 
>>> GPU_BUDDY_RANGE_ALLOCATION),
>>> +                   "alloc [3M, 4M) failed\n");
>>> +
>>> +    /* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) 
>>> stays dirty. */
>>> +    gpu_buddy_free_list(&mm, &low_dirty, 0);
>>> +    gpu_buddy_free_list(&mm, &high_clear_a, GPU_BUDDY_CLEARED);
>>> +    gpu_buddy_free_list(&mm, &high_clear_b, GPU_BUDDY_CLEARED);
>>> +
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, 
>>> chunk,
>>> +                              &result, GPU_BUDDY_RANGE_ALLOCATION),
>>> +                   "dirty range alloc failed\n");
>>> +
>>> +    block = list_first_entry(&result, struct gpu_buddy_block, link);
>>> +    KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
>>> +                   "dirty range alloc cut the clear extent 
>>> (offset=%llx)\n",
>>> +                   gpu_buddy_block_offset(block));
>>> +
>>> +    gpu_buddy_free_list(&mm, &result, 0);
>>> +    gpu_buddy_free_list(&mm, &barrier, 0);
>>> +    gpu_buddy_fini(&mm);
>>> +}
>>> +
>>>   static struct kunit_case gpu_buddy_tests[] = {
>>>       KUNIT_CASE(gpu_test_buddy_alloc_limit),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
>>> @@ -1606,6 +1670,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
>>> KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
>>> KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>>
>>> base-commit: f146c6086b792cb2c6b3ce5106f0cce62e408df8
>>
>

