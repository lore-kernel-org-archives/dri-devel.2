Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C834606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cA9c0bxV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A60110F22D;
	Tue, 20 Oct 2026 06:02:10 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0F110E9F4;
 Tue, 20 Oct 2026 06:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbOd1Uo8JK8wC5S7vNbDq91TbusX7ywHh9KYv7MxOLd6uJLw4yhtfptkOTJNoo7t8Zd16B21Geu/mKsMkDwV+TJCfawht7mWQisa1ntUIwdqPyIl40PUHO0M0axK/TmnSZ2n12F4jl1evY7dhZkWr3JrdPJIXJk95od4Z/1Q5WwKXM7QG/J7PIwc6Rb8+BVwZdTJjAORWelx6N8ZWmgTtA8oCr8qgBBw6H7Ed8PIz+aThZj0IWatJcAlPljd4zQ3y8TLZ+m10fh7sReGbXOKnLMSvliUtn4pf4f5X6m84Fm6dShMnsLLyfrjC4A1284HhC/D7fIo26Rra+TTjb/z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tDidC1DpfRqWj1P5mCU2nkS12lHH1u9edoZ1JeF+zs=;
 b=CpHpmNeRMa8bZCcyXGxQZvyq4VzbMAiRQUHqCfbWpuMaqSXNY89H5tLJJ5Y01z5Oxdkx+U2zbYy0OT1RV1hy0bKdvVT4+stAodXd1AuUIVTBbAbL+YkTgs9s+PzPlBzFjFWBRXu0LBwOAA7XKFK6Mit0iE0Z7QwGK0SIjxfnLhGzhvQHoh30mWbfr+msxCUhIbnv5ObezFfndm7ks34gi9Pbty/u7EvVoSa7zorTMM64vrdmLuqmweEdUUH1+MG8YP3cCYWAnhTY4f9anPMtcchCtu3Gwhk/VgC985BClzfMrv/yob+xkQgvrnkNcSj3xznl/sp4N+5MraMya/wc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tDidC1DpfRqWj1P5mCU2nkS12lHH1u9edoZ1JeF+zs=;
 b=cA9c0bxV2OGmvE3Hl1XAbentWlB5gcZXYNlJlnA12R/Jr04ROTe8SmyyZYf5TNpvrMmuQePGk0JC859dYnmdsm7VdnxK6dcj8y//veE3BbDGKCEGkvEddttOLqm3p2bf5K3VH6vjvMYS0yGLYvUCEx4+eR4snh81+OhiiuZE2KY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:01:30 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:01:30 +0000
Message-ID: <6cd8a223-51cc-4dd6-a8d2-ee2f8b1de998@amd.com>
Date: Tue, 20 Oct 2026 11:31:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
 <3e16b7d9-b1d6-4d6c-8f58-f6716fff71a6@amd.com>
 <343cf7b2-6241-4e3c-8b37-2f0ea75c6723@intel.com>
 <471cd64f-6dd1-4f8a-b446-94423d9d1439@amd.com>
Content-Language: en-US
In-Reply-To: <471cd64f-6dd1-4f8a-b446-94423d9d1439@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0095.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::16) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d925305-d349-4a9f-cc29-08df2e6f9601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M/YJ1LA5QnPDQMXet7fbgtf41MitqTSZfMSILHFP0VuGONr23JdI+kLWV7hrfdIZqulitbvUT3uytH9JHsdjCLcyg4KMe8aMe43d/Zwywn5uAXoGcwCZxpmPAlZQbgBXAiTQlktT2gp60LQQ/5qwKPMlVKIoYcrx7+M66vcvvrxmNKFdV2tgR06KwgQXCDEI3Fmlrqs+xfhQ/9zdkiijaItUbwaIfeYQsx/JQjwovdUVMLD8wnRpZjZLY8DI+4i1BtnuA87jISRj2CKjH7wSve9OlrEt3V3K/Zjf25CAbdA5GW/9qWywcLFvDqJ/I54Y9IBRpMNshzbsQEzUgAQRv6W/euZsrdcTxlWcbL/k+NbATdjxhtRjhiELvK30bR1xbLw5GwuDi6c0e3LZhAaUOBnmjyaj9M9eyICkrdRE2ZaNa0zZ5vyzOKSe2RELvqOqqYgXxMWLyoHjC5jwdHHLgYTyOn3u0Cf+H248d/4W4hdmplYFGU5ozIDROhyGkFlfYHkJ+vvx6beQ0ovfwimNd3aD7JBwEX63bg3bn11JX69pLxVE1t9VjFMXg4g1cWARjV4eYAi1KC5+0zRMDwnbO3DsJIWeGl6VNhXzt5hDNLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJkVVpmV0F5RVpRdnZJRk96NmhXSnQwczYrb0tsb1VsZzNnU1VHMXFqdnRy?=
 =?utf-8?B?MlQ1aER6VHpUMkFtaU1oY0pCUDNSWWIzTnNqRG16S2Zudm4rVmg4WENSUTB3?=
 =?utf-8?B?MnliQ3JoRTRZeTV3UzE5NHdrV3M1eDZjMHZUMTZEMmRHc01VQmlTdStwNy9I?=
 =?utf-8?B?N3JwRUMxSGRLaEFFeENPZThaUTQrd3lWQUNFL0NsdmpiN0Zwa1lycmVnaGZB?=
 =?utf-8?B?L0NmSXlkalVnUjRXQ0g3NW1uWFZmNnViejJLUmJjQ1VWaC9JMm1nSUV6bVBz?=
 =?utf-8?B?UHgybEJkVnkzQnhiRURiQk4wZnZ2LzlYMG5SWVBkWjFFcHpwVGJNeis4UWZ2?=
 =?utf-8?B?c2tNVTRnUDcrRGxIdUJRSklvRHJZS2d0eVY5NG1VeXFES21YT0VuMGI2V2xo?=
 =?utf-8?B?SlJHTjhXaTNnT29ScjZsdHRmTzliWXVEQktJak1zRUIySzlvQXk4cE5NZ1Zv?=
 =?utf-8?B?TzBYdGtrS3BkQXhhWW0ybTkxbGxjaTZFaHVaR04ycy9yTTMvMHJYZmIzSlVZ?=
 =?utf-8?B?S2xibndTUm8wSVlaUGc4RUdTVHRsaGxiaFFuT2hlTUVidlFLdkpvNTh4NFRK?=
 =?utf-8?B?VDJGUlV2WkNoZVBKQ25rSk4rdFlzRmg4TzQ5cU11QncvMkw1RXBTMTBPS1Y1?=
 =?utf-8?B?dk5BRmR0dVJLRnQ5VnA5YlZLN3RwYWw4cE9uSGwwWkhvYjI4TVY2RHNlWXcw?=
 =?utf-8?B?aUpGR1A2YVRVN20xcWorRVdMRStOVWgrR2dXTE8xaW9KV2pQQlZvcDh0ZHZR?=
 =?utf-8?B?TnBHWStDUFNhbVR1RDNST1dObUdDY2V1MWo0U0crUW9vVlp4c0U4SHBwTmxj?=
 =?utf-8?B?d1VHSWQ0L3g0WnpUWFpXUUdHMmc3SVNyWDJKWHhWdlVqU3hFVktvTkZtaWRB?=
 =?utf-8?B?VDF4MzRVQzFNbmhobzd1b2tmQ2lBNlhZeDB2cE5lWGhnTHZicVdTd2F6b3BX?=
 =?utf-8?B?cnFwNFRwVFo3VDA1UlFWNkVCVzUrNG1YVmM2Y2UwNkFnSXg1djhiYUZ6djJL?=
 =?utf-8?B?WGZHSFdWWFRxOWNSTGxlQ3VweXBidTdVTDhsS1NsbnB3S0xJMERscXBES09Z?=
 =?utf-8?B?K0ZMTmhkQ2RGZURzMVdscStnUG05bzBMUit3RVVNMEJZaFhBWGZENWZDYU1j?=
 =?utf-8?B?cyt4RkVNUmIvTktLVVBBNXp4ZlM0ZUwyWmFwajRNRjZKcDFVaVpuclFVdWcx?=
 =?utf-8?B?YklWN0ExcFhpb0ZvdWhqaGdKL3dYeHhpazBDYk9ZZUtWeEVrMVJMQ1ZheVEy?=
 =?utf-8?B?bHJzdTFDUEdHWTZGVFJQQ2o1V2xwSnlkQW5XSlhiNm9USkxHdEx1QzRqdGpR?=
 =?utf-8?B?d212UHl3QlJVWlNVR2RGa3hyU0I1UUFndEl3bVNsdGV4N3Y4MG9mK25TRnUw?=
 =?utf-8?B?VzhPSktLU2ZpS1E0eS9GUC9BNFVhYUZPcklVNlJVTFdWTTVCek56VjVWZTNs?=
 =?utf-8?B?L1BkM2NnUWY5ZHFzWGMzVTVJZStoUmFJLzlkMUxtZ3M2YUJYS3Z2M0pLaHAx?=
 =?utf-8?B?cytQd3F3N21RbzJWUlF0WFh3WlhxTHJKOWthdEsyU094SndYeWpqY1hyV3dn?=
 =?utf-8?B?L1hDTDQ3aDVsMFJnMUxHSmxsdjNxMGhNbGd4eSt5T2oxU0NFd21hY2xxakFu?=
 =?utf-8?B?ZkxrR0RRZGJ0ZVIvNDdwNGIrNmkzU29lRjlKd3FZK0h0WDladG43NkF4S01X?=
 =?utf-8?B?UmlPQU9DZG1rZW43VlJ1TEQ2T0NIOXVRRm1mREtLWjczdXZpeWxDQVQremJJ?=
 =?utf-8?B?RW5FSnJWK3pWc1JxWWJDMnhNaUVXcGFNYlRQK1dQUVlEbk9sTytROFNwSm5o?=
 =?utf-8?B?di9nbnZNT0FFN1czWWNEKzFnOFBITHdGbS9ORmFieEJubE55eE4xVFhUclNa?=
 =?utf-8?B?TGY2VmxoRFNPQVQzUjk0SFR4ZGxkSGt5b05Zb1U0dCsweHYwdFRPNUtwalJN?=
 =?utf-8?B?RkZYd05hbkx0UjU0QjBCOVBZcjlOblBDaGd1ZlhuWDVQcGZkNzhWTEd2cmUr?=
 =?utf-8?B?aURIUXJ3TEJTT3ZEbThodmYyYndSN3BlNDRlczNPcjJJTUhzbWFLOUNQZFJj?=
 =?utf-8?B?WEpPb3hud003SGsvbGg3RytvdDRWVVZOdzI1Wk1HK0dHQ015c0U0U3pxSHl4?=
 =?utf-8?B?aDFhTUZLNnJsblNZSUpvc3AwYklQR0hXZkZKMnFMa1FrUjR5a01tTHBTQkph?=
 =?utf-8?B?RHRtbzllalNsNnRaRzc3L0YzSldWWHhuMjJkRitRNzBaWEZtK3BEaUNYcTBv?=
 =?utf-8?B?MFd4WUtOcEJqYXZPRktwKzQ1cmVOTTlPbFZKQ0hvOEY1Y3R1OFBaQWhzUEdR?=
 =?utf-8?B?OTJ3ckMrMnM1cXBDajFYeHkyK3pDeEo2V2ZhdWVpalVUbDdTSHF1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d925305-d349-4a9f-cc29-08df2e6f9601
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:01:30.4048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCObKZDkcDiEmNxoowhhmsqinu9uEeFxH8s4oaP9FwvsFsADchZkxBLuwIhGWtfIq0CaUo18kbAJhX+lNMEawg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matthew,

I have sent the v5.
Could you please review patch 1, as it needs immediate attention due to 
the DAL CI IGT test failure and should be pushed to the internal branch 
ASAP.
The review of Patch 2 can follow later when you have time.

Thanks,
Arun.

On 10/19/2026 10:20 AM, Arunpravin Paneer Selvam wrote:
>
>
> On 10/13/2026 8:36 PM, Matthew Auld wrote:
>> Hey,
>>
>> Yes, going to go through it now. Did you already look over the 
>> Sashiko reports:
>> https://sashiko.dev/#/patchset/20261009100546.1103622-1-arunpravin.paneerselvam%40amd.com 
>>
>>
>> Are they all false positive? I wanted to hold off reviewing if you 
>> were going to re-spin.
> I am preparing a patch to address the issues reported by Sashiko.
>>
>> Also, on the "bugs" tab in Sashiko there was one open buddy issue, 
>> which I sent a fix for:
>> https://lore.kernel.org/intel-xe/20261006110706.1636971-2-matthew.auld@intel.com/ 
>>
>>
>> Please take a look at that.
> Sure. I will also take a look at the buddy fix you sent.
>
> Thanks,
> Arun.
>>
>> On 13/10/2026 15:31, Arunpravin Paneer Selvam wrote:
>>> Hi Matthew,
>>> Could you please review the v4.
>>>
>>> Thanks,
>>> Arun.
>>>
>>> On 10/9/2026 3:35 PM, Arunpravin Paneer Selvam wrote:
>>>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>>
>>>> Range-restricted allocations (the visible-VRAM aperture) skip
>>>> dirty_steer_window() and reach __alloc_range_bias() with no 
>>>> clear/dirty
>>>> eligibility guard, so a dirty allocation freely splits clear 
>>>> extents (and
>>>> vice versa), interleaving the two classes until no large same-class 
>>>> run
>>>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>>>> search instead: block_incompatible() rejects opposite-class blocks 
>>>> in the
>>>> strict pass and relaxes only when the strict pass returns -ENOSPC, 
>>>> so a
>>>> request still succeeds when only opposite-class space remains. A KUnit
>>>> regression test covers the interleaving pattern and fails without the
>>>> guard.
>>>>
>>>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>>>> decoupled dirty tracker")
>>>> Assisted-by: LLM
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> ---
>>>>   drivers/gpu/buddy.c                | 71 
>>>> ++++++++++++++----------------
>>>>   drivers/gpu/tests/gpu_buddy_test.c | 65 +++++++++++++++++++++++++++
>>>>   2 files changed, 99 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>>> index 2f2aaadafe35..6566bad4fef1 100644
>>>> --- a/drivers/gpu/buddy.c
>>>> +++ b/drivers/gpu/buddy.c
>>>> @@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct 
>>>> gpu_buddy *mm,
>>>>       }
>>>>   }
>>>> +static bool block_incompatible(struct gpu_buddy_block *block, 
>>>> unsigned int flags)
>>>> +{
>>>> +    bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
>>>> +
>>>> +    return needs_clear != gpu_buddy_block_is_clear(block);
>>>> +}
>>>> +
>>>>   static struct gpu_buddy_block *
>>>>   __alloc_range_bias(struct gpu_buddy *mm,
>>>>              u64 start, u64 end,
>>>>              unsigned int order,
>>>> -           unsigned long flags)
>>>> +           unsigned long flags,
>>>> +           bool fallback)
>>>>   {
>>>>       u64 req_size = mm->chunk_size << order;
>>>>       struct gpu_buddy_block *block;
>>>> @@ -1258,9 +1266,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>        * This range-constrained search hands back the 
>>>> highest/right-most
>>>>        * address that satisfies the request: the roots are seeded 
>>>> high-to-low
>>>>        * and the right (higher-address) child is descended first, 
>>>> making
>>>> -     * top-down the default placement here. A non-top-down clear 
>>>> request is
>>>> -     * the only exception, where the descent is biased towards 
>>>> clear or
>>>> -     * clear-containing subtrees to satisfy the clear preference.
>>>> +     * top-down the default placement here.
>>>>        */
>>>>       for (i = mm->n_roots - 1; i >= 0; --i)
>>>>           list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>>>> @@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>                   continue;
>>>>           }
>>>> +        if (!fallback && block_incompatible(block, flags))
>>>> +            continue;
>>>> +
>>>>           if (contains(start, end, block_start, block_end) &&
>>>>               order == gpu_buddy_block_order(block)) {
>>>>               /*
>>>> @@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>                   goto err_undo;
>>>>           }
>>>> -        /*
>>>> -         * Top-down is a strict address-placement policy, so when 
>>>> it is
>>>> -         * requested we ignore clear steering and simply descend the
>>>> -         * right (higher-address) child first. Only a non-top-down 
>>>> clear
>>>> -         * request biases the descent towards clear/has_clear 
>>>> subtrees.
>>>> -         */
>>>> -        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>>>> -            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>>>> -            struct gpu_buddy_block *prefer;
>>>> -
>>>> -            if (gpu_buddy_block_is_clear(block->right))
>>>> -                prefer = block->right;
>>>> -            else if (gpu_buddy_block_is_clear(block->left))
>>>> -                prefer = block->left;
>>>> -            else if (block->right->has_clear)
>>>> -                prefer = block->right;
>>>> -            else if (block->left->has_clear)
>>>> -                prefer = block->left;
>>>> -            else
>>>> -                prefer = block->right;
>>>> -
>>>> -            if (prefer == block->right) {
>>>> -                list_add(&block->left->tmp_link, &dfs);
>>>> -                list_add(&block->right->tmp_link, &dfs);
>>>> -            } else {
>>>> -                list_add(&block->right->tmp_link, &dfs);
>>>> -                list_add(&block->left->tmp_link, &dfs);
>>>> -            }
>>>> -        } else {
>>>> -            list_add(&block->left->tmp_link, &dfs);
>>>> -            list_add(&block->right->tmp_link, &dfs);
>>>> -        }
>>>> +        list_add(&block->left->tmp_link, &dfs);
>>>> +        list_add(&block->right->tmp_link, &dfs);
>>>>       } while (1);
>>>>       return ERR_PTR(-ENOSPC);
>>>> @@ -1361,6 +1340,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>       return ERR_PTR(err);
>>>>   }
>>>> +static struct gpu_buddy_block *
>>>> +__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
>>>> +                 u64 start, u64 end,
>>>> +                 unsigned int order,
>>>> +                 unsigned long flags)
>>>> +{
>>>> +    struct gpu_buddy_block *block;
>>>> +    bool fallback = false;
>>>> +
>>>> +    block = __alloc_range_bias(mm, start, end, order,
>>>> +                   flags, fallback);
>>>> +    if (IS_ERR(block))
>>>> +        return __alloc_range_bias(mm, start, end, order,
>>>> +                      flags, !fallback);
>>>> +
>>>> +    return block;
>>>> +}
>>>> +
>>>>   /* Return the highest-address free block of at least @order. */
>>>>   static struct gpu_buddy_block *
>>>>   get_maxblock(struct gpu_buddy *mm,
>>>> @@ -1924,7 +1921,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>>>       if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>>>>           /* Allocate traversing within the range */
>>>> -        block = __alloc_range_bias(mm, start, end, order, flags);
>>>> +        block = __gpu_buddy_alloc_range_bias(mm, start, end, 
>>>> order, flags);
>>>>           if (!IS_ERR(block) || !steered)
>>>>               return block;
>>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>>>> b/drivers/gpu/tests/ gpu_buddy_test.c
>>>> index b75d32ca6ca0..3eaa261571bf 100644
>>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>>> @@ -1597,6 +1597,70 @@ static int gpu_buddy_suite_init(struct 
>>>> kunit_suite *suite)
>>>>       return 0;
>>>>   }
>>>> +static void gpu_test_buddy_alloc_range_clear_guard(struct kunit 
>>>> *test)
>>>> +{
>>>> +    const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
>>>> +    struct gpu_buddy_block *block;
>>>> +    LIST_HEAD(high_clear_a);
>>>> +    LIST_HEAD(high_clear_b);
>>>> +    LIST_HEAD(low_dirty);
>>>> +    struct gpu_buddy mm;
>>>> +    LIST_HEAD(barrier);
>>>> +    LIST_HEAD(result);
>>>> +
>>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
>>>> +                   "buddy_init failed\n");
>>>> +
>>>> +    /*
>>>> +     * Lay out a 4 MiB aperture as three regions:
>>>> +     *
>>>> +     *   [0,  1M)   dirty free
>>>> +     *   [1M, 2M)   allocated  (barrier, keeps the two halves un- 
>>>> mergeable)
>>>> +     *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
>>>> +     *
>>>> +     * A dirty (non-clear) range allocation must take the low 
>>>> dirty block
>>>> +     * and leave the large clear extent intact. Without the guard the
>>>> +     * top-down search cuts the higher clear extent instead and 
>>>> returns a
>>>> +     * clear block -- the interleaving that fragments the aperture 
>>>> and
>>>> +     * ultimately fails a large same-class scanout allocation.
>>>> +     */
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, 
>>>> chunk,
>>>> +                              &low_dirty, 
>>>> GPU_BUDDY_RANGE_ALLOCATION),
>>>> +                   "alloc [0, 1M) failed\n");
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, 
>>>> chunk, chunk,
>>>> +                              &barrier, GPU_BUDDY_RANGE_ALLOCATION),
>>>> +                   "alloc [1M, 2M) failed\n");
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * 
>>>> chunk, chunk, chunk,
>>>> +                              &high_clear_a, 
>>>> GPU_BUDDY_RANGE_ALLOCATION),
>>>> +                   "alloc [2M, 3M) failed\n");
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * 
>>>> chunk, chunk, chunk,
>>>> +                              &high_clear_b, 
>>>> GPU_BUDDY_RANGE_ALLOCATION),
>>>> +                   "alloc [3M, 4M) failed\n");
>>>> +
>>>> +    /* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) 
>>>> stays dirty. */
>>>> +    gpu_buddy_free_list(&mm, &low_dirty, 0);
>>>> +    gpu_buddy_free_list(&mm, &high_clear_a, GPU_BUDDY_CLEARED);
>>>> +    gpu_buddy_free_list(&mm, &high_clear_b, GPU_BUDDY_CLEARED);
>>>> +
>>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>>> +                   gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, 
>>>> chunk,
>>>> +                              &result, GPU_BUDDY_RANGE_ALLOCATION),
>>>> +                   "dirty range alloc failed\n");
>>>> +
>>>> +    block = list_first_entry(&result, struct gpu_buddy_block, link);
>>>> +    KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
>>>> +                   "dirty range alloc cut the clear extent 
>>>> (offset=%llx)\n",
>>>> +                   gpu_buddy_block_offset(block));
>>>> +
>>>> +    gpu_buddy_free_list(&mm, &result, 0);
>>>> +    gpu_buddy_free_list(&mm, &barrier, 0);
>>>> +    gpu_buddy_fini(&mm);
>>>> +}
>>>> +
>>>>   static struct kunit_case gpu_buddy_tests[] = {
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_limit),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
>>>> @@ -1606,6 +1670,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>>>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
>>>> KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
>>>> KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
>>>>       KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>>>
>>>> base-commit: f146c6086b792cb2c6b3ce5106f0cce62e408df8
>>>
>>
>

