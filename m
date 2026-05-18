Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8EECD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFFB10E733;
	Mon, 18 May 2026 08:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f/mk6jGI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9135310E730;
 Mon, 18 May 2026 08:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0+QOs7wn5hA+ktPGcu9wcaBnNEbCNTwmWwHr+ps8yRB4r/vee5+eyoJyuR2I2VGJCfDI4I+52FhkUBAlGWokdn3TqBA5qvsepRyiuC7uzs2OKrZztZ5cKzd7OG1RFOQ5hXAXi5OzncLmpnpbVvVjVnpFBclQgPFBsZgiFJPCnCKUnRnhCHaLiGmtUAnDtFWnkb9+p5a5u0Gb1nijD9z8VpJIgxq1x8w5y09JA56CBBrqJo9SzpzSHCKKlZMVZMtKKt6ht0EoMDZuyXXwt3gbrOnLF3XqTKvnJ7j6gioCG06GFt1j5q5TgpWCXR1saemf+UG57cbXLtlbflggdPIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbJWtxhKyylnCW3eIbSl6zsvAO/O2ItTfyuzbb6Kjrw=;
 b=Rlpu16PCMlBIxql95Wtztl0wnS5Vke5knQvsmCqho5vR4aeIfFl4JzPUdeaCYbn9JbuMM2GTcZrU+AP6Vpkk/gCLizo043aKCf9BIFY3sD4808ozXR7Boj2ZckvDWb5dHfPht1jTVFDy0cHX5EWc2VtKtyy5NHZ6DPAGwdM1IFtBT6m8G37iXWq+bEzlAOzAXCPXz2vbGitxVR6RHfs/qb+/PMvbNouOt6+Am/2h66Ts0Vu9vdFVjmB+xVlAE1lAq9pzqQUmxnpkn226wIi166Xqn9PO3noM6ID26FUp3LFnfYckqwJQ3xzqih5cgUN79CvlZ82LAeBkvoZMZnM8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbJWtxhKyylnCW3eIbSl6zsvAO/O2ItTfyuzbb6Kjrw=;
 b=f/mk6jGIIZ1QVyCb52ZHODTFkPKbovHz0+FcrR+5FKJ5KZv+6ZG1UUYIwu3P+4xF8ksbv2JwXE8dgAc1I5vxYTBnCPeL5w5Lo9rdAQ9Xue0mKDRR04f42s8IIeS2FIdrVTUwnrqhr7bBS26FA2M3eoUQmy8oadBpCZxly+Dt6gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 18 May
 2026 08:34:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:34:36 +0000
Message-ID: <4e0657dd-4175-456c-badd-de1c67069504@amd.com>
Date: Mon, 18 May 2026 10:34:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/shmem: add shmem_insert_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
 <20260512110339.6244-2-thomas.hellstrom@linux.intel.com>
 <f14d99d3-c1ff-453b-a280-17b8c4d5af94@kernel.org>
 <b4800086347aa3b27edc42b6536cb3a2b76a1aa8.camel@linux.intel.com>
 <26479389-459b-4cc4-914d-e7d29d5e5cc9@kernel.org>
 <c6b4031a-5625-4b1b-8a51-6e47241d32c9@amd.com>
 <bbde0793-fd21-4a9c-b85d-f13d8b787c50@kernel.org>
 <0ba9bc77-ace1-4077-a193-4540880b242b@amd.com>
 <c2881d16-a12c-4598-8f8d-3b6523266fcc@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c2881d16-a12c-4598-8f8d-3b6523266fcc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e09a6f-fc30-467c-ed11-08deb4b84b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|11063799003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: RuWpdKaUPmt8OtkhWm6gjzbjr5okvkEmDZA46I74cLcBkIf2u6RcfnhJRACG6UUBtDlSATTIMBIUnlYKdcy37BXisUMB+4L8itOUPXm2J+vmrCLuE9/O8ZTyv6u4qwdaUmX7Rjvjf/oqXORoOLTYhTw7Bq5y2WdYWzkSfrRxmI1mWwyJJrCLUtY5M8EJiVJog88luCCQX+WhkPgOqUuR5UOxe4xA14oVnLDstzfliEHPzkIfvHMceagoB1kTHMUCMqvSSmzgvdBkcNgXAt6upt7kiFJXdNtyoTAMpwzqxyR2SDv9fAvO4uf0gJFRGWl3ivSWQc2vdb+BOiASNmWr/lhSzKJgOl5aEilXqzVDwJM4PTmdNWjp1DfXbf+lRehmkmP/XBpwJ+7gGUVk+qOqWC95ez986HPOhQlXhhMOJx9F4HtEIyS2O06f+n3kp64YQRUd1U8st3ObbRpmcDe00I/FYispts8uj+9VUZ9dl7dXZazSLmhRmd8815m+2JAwvsmEoWzx+QAH2SLZEMKfbNRoHQUrbT3PtF6pnJOGz7Xb1PimchJ1zHsQyCyDZ692m7quBncY0HhTpDG8XUM/MjiA4boy17H/jQ+qd2j9XqP8643eHPC5lQnBdiA7xMc6E4TtPir17+A44QwF0sCNpDNBChVr1ZJR9D9/NCMoGwJT4sGxVELptTgE81v0u5cw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(11063799003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmcxRnE4Q09qRWFPaUxLOHh6azhiWkZuTFVibXptL3daWjJKeTJpaTI5NldO?=
 =?utf-8?B?M2NhclRVRXY4aXZhdTVJb2pKZndpb2tWTzFLdy9kcXQ1ditTTmd4TmFVb2kr?=
 =?utf-8?B?aHE3MnEvOWhSUmpBU3FpWDNzcHYwSUkrdm5hS3U0UE95cmJlUE9iV2JNV3pj?=
 =?utf-8?B?Q2x6ckhPOWdoRGVkQWpBQmJVemxoM0pWeGlmbDhENnpEb3M0akpIMk00MHZQ?=
 =?utf-8?B?Nmd3NWMwQWVXZVJwRW16WEVHd05Ma0lQclpJdzZnYTZCb2k2WlRYNWxkK1pS?=
 =?utf-8?B?V2lFb2psdFhJRW42eHo4NnI2OVYxa0FoM2FLWUp0THk0b0VKdEN4aHNCQWF5?=
 =?utf-8?B?SHNKVDZ5SCtiRXFyMGdRWFRjcXN6UFBGTjdhZThQMUNjbXdSQ211N0VJNEFD?=
 =?utf-8?B?NC9CUUdGREJWWm9rWUFzK1Q1Kzk2SXF1dEVIZlRSK3pLZ0xDU2RrY3F0R3Zw?=
 =?utf-8?B?b0tvWC9qcCtUOW83elBNWGhla2VxL1JkQ25pUlFLMHV5SjNZZFR4TktPdXBz?=
 =?utf-8?B?bFJoM1gvdUVSaUtxaWx4dmR6S3gvbWpwVm8wYURsSjFFSFo4RFFTU0ZCc3FV?=
 =?utf-8?B?Yk91U3NmTklUNDdPbGxpVU55ejE4c0tBS005d0pSU0dLdVBlTy9sOUN4TWpH?=
 =?utf-8?B?TDVvQ0grLzNKeENZTk5aMXZqRk9GNGtrQXp5b1BKWnpWQisrNElZcFFrSktj?=
 =?utf-8?B?VnBFa29nV0syN1BGdU4zWENiWVpjSFREd29ERHRMSjQ0bjFtNVdSNXRQdCti?=
 =?utf-8?B?RkcvUDJxYktLbUwrNTNhdVQ5MFZMZjlCeEtnQWdOWlZub1dicWlZb0JwOUgz?=
 =?utf-8?B?ZDJVd3NubHcwWDY0cWNiRkorUFo5cm1PRjExRGFXRmZmVEk1WDUxb2IvL0Q5?=
 =?utf-8?B?c3JTclVOcEMwdmk5KzhhQTRjc0E0Q1V6cndlVVBJV3hHenE2amFOc2haZUF1?=
 =?utf-8?B?aDhsTDJiSkp1ekQ0TVFqM0E1WGhqL1hNY2Y0S2tjcFZOZGh5My9adWI3UXVC?=
 =?utf-8?B?REhOY1ZYWWdTVlhzZUZIMzF4OGNDNTI3NEZHa0d3ZWltbEZva012SEFWUzdF?=
 =?utf-8?B?ZnRLSUdTSDhMbTdURmNKR3RGL2FRalJkMW5JZEJaVlV1U044dHpSK1N5Tnl3?=
 =?utf-8?B?djgybWgwQk83NXZwR0hRZjU5OTJiNGozVFNKTnJpNlM4cjQ5TEwrSTJYaWVD?=
 =?utf-8?B?bS9MRUN0S3VkbENqUzZ3U2RQRDQ2ZDVUNTRnRmdKNjhxd0dDWTZnQWRyZ3Vs?=
 =?utf-8?B?c2ZwQWQzVmdGZXEvUjVMUXVYaVNFeHFpcS9rbnhiNytSbEFON2sxVThwUVNR?=
 =?utf-8?B?SEV2ZU91OVJSQUdiODkxYXV3MlJNR2lXYTg2VVlrTGJ2MEFObTg0bmJabk4z?=
 =?utf-8?B?ZXFtUHFwWVFMaGJxNWtwdHNQZTlDU3VqWVJ1aUZkcFRsWmNIclcwOVpJQ2lq?=
 =?utf-8?B?bGpzblFMRGt5anA2V3NqOXMyV1owU3dDTm1VWmxBUTZXMzgxVW1lS3h6QWt1?=
 =?utf-8?B?ZXNqRjdmaFhJMWxTSWh5MHpJTUp5OTd1ZklpcmxsOHhLU2tSWXVUUHVyM2lZ?=
 =?utf-8?B?VGFPS0JHbFZTTXNkdkVkTE5lWUc4QjRaQjd0NGpCTTNBcGdxcGtUbWtuY0hO?=
 =?utf-8?B?ZE8xSitjN1dpZGhiNWdIa1gyYyt0ZmNZOEltbUk3ZmtiVWJwRGRQMlZ5ckpJ?=
 =?utf-8?B?YkxFLyt1c1Y3aC9sVlRvbDJuME96cjFyN0tBOFg5NDZGRGhLUnhyR29iSmFW?=
 =?utf-8?B?cUJTZXBRa2ZLMjdEYTU2Q3BrQUwrZ0lWcWkvMUladDJjT3kxTnAxTXlFWmFz?=
 =?utf-8?B?YU9Nc1orN1RJU3B2ZDZoZUJySXphanFGbVBWMkFlTWkvWC9VN2dWTmhnMmN4?=
 =?utf-8?B?OERha2pCN3JQODJCYUFHS1VBaFZJSUhrYVVsYmkrZVFxbnR6L2k3bXh2NlBT?=
 =?utf-8?B?cUJtdEtWZXlGT2pvUndCeVFRUFdpcm5UMjV0NmRkZEl6UnZHVE1KTDBTNDBY?=
 =?utf-8?B?Q1d1bHRWVExQZThLU1ZITGtpTlowbW9ybnhvYVZBRTBsWmh1bko0MmJiNzl5?=
 =?utf-8?B?NFpITU5Lb0UzQTIvTGY4NFFpV0o1dmREZlFXVXZneFpPYzRVU2R1alRJRjda?=
 =?utf-8?B?b01TalpKS0dnUTF2WjVVYmd1ZDRFU0k4eEI4SG0wM3I5R3VNWjRxY2pEUEpQ?=
 =?utf-8?B?MWlEVkg3RnVYQ2Fuc2x4K2JaWHpVM3JDNDhNaXBzK0o3SXhCemdoYkw1cUZD?=
 =?utf-8?B?RkJsU3o3dzQvT21tRjZBODRqYzM4cXJ3c0VzSzdKdTVNelJYaXRtWmdjTXRo?=
 =?utf-8?Q?DDV9/zPzxuXCuWVghn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e09a6f-fc30-467c-ed11-08deb4b84b5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:34:36.6477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nsr60HNI4jDvIReV6kGTjRC9hn2TsXdoMVUNMmZp9U+FyAuKFhAtlP5/K/1JG2gB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F
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

On 5/13/26 21:43, David Hildenbrand (Arm) wrote:
> On 5/13/26 13:54, Christian König wrote:
>> On 5/13/26 10:37, David Hildenbrand (Arm) wrote:
>>> On 5/13/26 09:47, Christian König wrote:
>>>> Hi David & Thomas,
>>>>
>>>> ...
>>>>
>>>> Exactly that is one of the major reasons why we aren't using a shmem as backing store for TTM buffers in the first place.
>>>
>>> What was the problem with that the last time this was considered?
>>>
>>> shmem nowadays supports THP (e.g., 2M) and even mTHP (e.g., 64K).
>>>
>>> For internal mounts, it must be enabled accordingly
>>> (/sys/kernel/mm/transparent_hugepage/.../shmem_enabled).
>>>
>>> Some distributions still default to "never". I guess if an admin enables it, you
>>> would just get THPs.
>>
>> Yeah, exactly that is not acceptable. We have some customers who already use that approach through udmabuf, so we already have some experience with it.
>>
>> And I can't count how often I had to explain that it's a configuration issue and that the admin has to enable THP to get decent performance.
> 
> A lot of concern with shmem and THP is around memory waste.
> 
> But the DRM use case of shmem is really different than ordinary shmem usage, in
> particular when it can steer the folio size used (and better control memory
> waste I assume?).

Yeah memory waste is absolutely no concern for this use case.

The problem why THP often causes memory waste is because applications tend to over allocate and the kernel compensates for that by doing on demand allocation. In other words you only allocate the memory on first page fault and when you switch to 2MiB allocations it can easily be that you waste a lot of that.

But here we explicitly allocate X amount of memory, so what drivers do when they get an 49MiB allocation request is to allocate 24x2MiB and then fill the remaining 1MiB with the biggest order available or just 4KiB pages.

So for this use case here there is no memory waste at all.

>>> If "distro default" is the only problem, I guess we could think about how to
>>> improve that. For example, just let internal GPU DRM objects allocate any folio
>>> size available and supported etc.
>>
>> Mhm, that sounds not so bad.
>>
>> I think what drivers really need is that they can give the order to shmem_read_folio_gfp() and get a folio with that order or -ENOMEM as return.
> 
> Is it really helpful to fail and not make progress on a fragmented system?

Yeah that is pretty much a must have. Background is that THP is a best effort feature, e.g. you try to archive the best performance possible but it's ok if you can't because of fragmentation.

But in this use case here the caller does want to kick of defragmentation and wait for it to finish before you fail or fallback to smaller orders.

> I'd assume you'd want the largest folio up to a specific order. Not larger,
> because it would waste memory. But maybe smaller to make progress.

What is possible would be to give a more complex structure than just order+gfp flags which completely describes the requirement of what to do before returning memory.

But I think that this just makes the interface more complicated for a rather narrow use case. The gfp flags already give the ability to say that a certain allocation can fail without a warning and that seems to be sufficient.

>>
>> In other words we need to enforce it and if the desired page size doesn't work we can then still decide if we want a fallback or not based on the use case the driver tries to implement.
> 
> In which use case would you not want to fallback? Would it be something to
> tackle separately later?

Well basically every use case which wants to guarantee rendering performance. E.g. everything real time.

For a simple example just think of virtual reality, you rather want a black screen instead of laggy rendering which causes motion sickness.

Regards,
Christian.

>>
>>> Would that make it possible to just use shmem natively? (e.g., how would this
>>> interact with shmem features like folio migration, would that be workable with
>>> DRM objects?).
>>
>> Mostly, I mean there is still the use case for UC and USWC memory but at least for AMD GPUs that is mostly negligible (we need it for a handfull of workarounds for HW bugs etc...).
> 
> Thanks!
> 

