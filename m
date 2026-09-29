Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89E3CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDFA10E112;
	Tue, 29 Sep 2026 10:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DI/GHPzQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E6510E112;
 Tue, 29 Sep 2026 10:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ9/AyPMLW3RF3PqA8AP0wD/+UWl6cqiczzTtflpRhOwzkozclx7sHHXWfJRz9RypUPGRB1xRk8PjNY3j1rCBqi+qwFHdglUt8rjO1tspnUsOdNx9lW7Yf3YYVg0vmZm6BkFYUWLi6ty2gXhsDhNwEa9O4QnH5LARssJePI1IuC17cy77LlJlxCyllfm/c7H4VKoId+Vu7tHI1QYxUqy6OEHWaMx+wan1nvk/gWgBPssbsJhrKg8J2+sTAN8skGRvPvX5MvjTKjJyD+uuBSGF/4NLexNIv0Iks+YfdctRLAzm9naQH4mV4QNAPgw42PsWDIHmIPQevlPPpsBma46JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9undN1GbI+uVA77mMb8zF1Bwn7/E3VAfCJwL0Lq0Lk=;
 b=jymdDDhQ2fY7qv0grjMG/IPMtn9upUIi+IHCRMT7kLiT4Rf2fUAXEls9St5QpOwXGkT1IZh1mT35FAA5gmWAPiWYW1wu24YVeU+F7b3WlzLwyFcR2M6RHeOk7eKIgZM5dWqd3JNBC3P0LDSYlVvnilIoUqSTqhOwkOTZciJDr94fGxtkBQZpXHHanhRvbp681CLS965cu1j1RQXc1K0JXYW7KjQPpgMye8dP7SCG3gu1RWYYjclU3RK8LKE28gH09RuN0ZTefztPb5HLd0wO5eaLZdadE0FZsypMptELT2YjQK5KD5589y5y0HZxv3jjV3dgLf5DsstGb5D7GiK4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9undN1GbI+uVA77mMb8zF1Bwn7/E3VAfCJwL0Lq0Lk=;
 b=DI/GHPzQsbn4Vrua47SUIzAYm/2R5TWirqvT6zBnuxJvRQ2QV/9vMGcZ+dehb8A1HstIg1yc13LdZrpdDDhIzr8XqsM+nn2cfp0Vs9sbEvk7Y4i818NMJgvQuzD0eyEBAk/MWwAWOtmhubdGpwOfoKDnPVvQO8tqlndivUnrxFk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 10:27:04 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 10:27:03 +0000
Message-ID: <81ef54c5-1cb7-4608-a779-90a2d9bd6d12@amd.com>
Date: Tue, 29 Sep 2026 15:56:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu/buddy: fix missing split-undo on
 allocation-search exhaustion
To: Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20260928175128.257266-1-arunpravin.paneerselvam@amd.com>
 <74e8255e-acde-4270-a0c4-10e14e3d7ba4@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <74e8255e-acde-4270-a0c4-10e14e3d7ba4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::6) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 5719510d-a09a-4c69-daa8-08df1e143418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|11063799006|10067099003|5023799004|56012099006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: 0mfXw7hVaCfFRQPWW1OCCrVNJGfDou6P/E+ym5iN8wAgIWIZzeUMBAQLnf/dSChtmsKnRrxvDd+Nzup9JRL+HIXjBBtHSlqhkbyumSCBMkho/VTTxRmkQYYIc8E2klE8rn6TIhOIzYrabnUlUn5Ngl4i/hiY0eFiSBR40f9cDq6ceZ+w6VcfhNAHRUx9Fln9o5YgqESHc3FUPqM8lMXpIHZ1SPmByQZ+rReSqdhcYFSTa5ixHe4PehBPsOgqgYJYsupJxFt9floBHDnj7nhjvWJQpyE+yeJjrauo/ziji4VNKSTGxwAYaSgnfal3FoX2MiUNitQRqS9d4O0GzrG8ZUiSvshibxTUq0rxOd7C+FGFOFqKJJ393hhGLXPDNvhn/4Fjd1VYfpLvYFi3DGbshaMfDco+0thGXGPzspHB/JzuaJRhadzODEqrRE4gg/mnNM6gd/rjn72LAYFlJLjRML1iDVnRHUtBhfvFyE8A68IcbDWZE5V+vECji3UXeN5glu0/9qnlwqhtiMpn+reGshlfQhVDP5m3MJG8b4o8NNSHkzmqJHiUWfyaTB0CJkAr2FOLGouKFyZAirPYvwWvh8pNDKla9wmGokkQ94nFXfNLBHhZNEwwsVWZOF8CMfOfErt4hQbyEKhx7hHICJoW5PFe7bsVFQksSSMkrA76QNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(11063799006)(10067099003)(5023799004)(56012099006)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBleStkbWZzazI1V0NFY2JCdXJlcEFWQmJKS3p1VkplS2ErbVNTbFRIL2Z4?=
 =?utf-8?B?ejNlTG4vb3pzY25mb3BINVpwZEpXck04NjIvajVyaXcvblBYNVk5NFprVzlp?=
 =?utf-8?B?OCtGUlVlR3NkVk5JZERIMzBncmVvSHlmdjNjZWJGaVpUVFlDbmFCUnJKT1hN?=
 =?utf-8?B?K0xaTjQzWGVNU0FzZVVSaGorMTlDWkpjeTg3SUZyWm4zTW9VakdqeG1SV1o5?=
 =?utf-8?B?QlQrZkpoRWNwMTIySHNWT3BaaVc0Kys3Z0t3enN0OFZlM0FYTzB2bDNWSkRC?=
 =?utf-8?B?TXNNU0RITGViZTRjNVJWUUR6dVRZaDZjakdvRDV0UEw3OTRKUEZJeExZZTQw?=
 =?utf-8?B?KzA2Z3F5TlBhbDhXbG14NCttcUs4VGpjeUovM2xCWkRSR1ZuTDZ0MDBjd3hz?=
 =?utf-8?B?ZzNPR1lreHkxRm5nVlNJS2l3V0hScU5yTnA5NkJPVG04L01aNmJDTThSdXQz?=
 =?utf-8?B?akkzbER3Y0l2SmxOQktlSjFJQVdhM3JkTFRvMW9sTjZ0eDJMM3c2RkRxbnhy?=
 =?utf-8?B?Q1JFL25IMVN0Uml5eVBLNXM2L09yTVpEdk9GdlRxUk1KblVBbjg1T0hwRUhT?=
 =?utf-8?B?cG15QVF0V281cmxKV3lBWEl5WFdrWlhCaHVvU2crcW8zTWZpZlJIeWVaOU4z?=
 =?utf-8?B?NUVhVEJtbkFWeXJFekNucjFGanZUU3gxYlFZa0NSaVBUT1k3ZlZnUHBIaWxR?=
 =?utf-8?B?bi9YbTlqSWVSL3MyTFkwMU9tNVdLOTU0ZzlEY1RIZXlkSXNmb0UwUHhRWDZK?=
 =?utf-8?B?ZStYWjRuK2FPLzlhZ3ZMTVI0ZTV1bzkySXp6NzNGNFpTeFpHdXRVVVhYbFla?=
 =?utf-8?B?ZWgwaWxlcHI4NEVxUTJ4aEd1M0pYeDhZSWpDS2tTczQ5T3hyRXFqaHJab0RD?=
 =?utf-8?B?Y3M0M3M0czVuYjVoRkNuWHhZRU01N0JFYmZqYUE1dDlUNXRCNGJxVjNNdXRm?=
 =?utf-8?B?Y2toeUh4ZHBzUnhpc25GdmQxUXF6a29oeFBXSk5ONEZQR1NMQ0w5MTNyT05x?=
 =?utf-8?B?WTg5NFBmMVY5TUVaRDMwLyt0UHdLd3dwbHNEN0FtSXFhU3V3MEtSUzJyWVhE?=
 =?utf-8?B?V1FEOGdDVHVxUVFyZmQrZERIYnQvUERsN2dMblhoS3FvN1hPY1pnTjd4VDZv?=
 =?utf-8?B?UWp3WG5DSDJidkJvWVRWcHVRai9CQmtTS1JjUHV6a2pNM0JEV1U3TFdiek5r?=
 =?utf-8?B?YklVNFdpWis4d3E3RnU5bXVnOEtyUWhUQ2xqU1p1T0JUc3Q2ZkRocVR2Y1E4?=
 =?utf-8?B?TC9IczdFTThSdWVOSXdnU3hab3ByVVdpUWhqaDgzVkZjUC9FQjlIaEladnMw?=
 =?utf-8?B?MGZGODV2VXNiZUxlbEpIdHNSUHgxUHZlZW1EaFc1Q2hFcHlkd0ZmYk54NC9z?=
 =?utf-8?B?LzM0TSsrNHM0S2ppRzRmNzkzSkt1ZGF1MHVxVUpueTkxU3hRTlN3eEtTVGhI?=
 =?utf-8?B?ekdUMWNPd3gyNU0vbjNKMTVyQStsTUdsM2ZaRU03YksrNFRxakl1OVMvMk41?=
 =?utf-8?B?UTF3LzRjbjJvYUcvY29wMTdUM2hvY0lib1Uzcy9Kb25nMFoxNVJDd1pnWWJ3?=
 =?utf-8?B?N3k5a1RnaXk1d3RndXhpUjA1akVLTlhoT0JDZ1BabVJlR0ZqZ1ZFZWpzYTA2?=
 =?utf-8?B?ZnFxNzkxVDZ2MkZMSnFMWFB2NGR6dnI5UmVlVUNIM3pUWHFORVFpbDl4Y1NC?=
 =?utf-8?B?QnVXdFVXcnp1Z1V1bEkveTFPWGdXaTBmT3RLVytpSUk0ZktESk5JWUFSYWdM?=
 =?utf-8?B?UnVIRTAyU1lTNEE0SWhRWEltUmdabkpWV0JiUnNEWmliUS82Smw1bDlPUUpJ?=
 =?utf-8?B?azJ5V3p1UVBuT3dNalFNSWxReXQ3TVpEQlJaRVZtbFpuT2pXYWVFQUFhdDRF?=
 =?utf-8?B?cWtTQjVRRkxtQnBsSlNIMWlSbU5udm5oM0tFT2dmK3NqTzdycDlVZmxPejdx?=
 =?utf-8?B?UXp3bVRkSC83WURYL0hwUHJ4c0I1OHFZZk4rajcwT3pTTVhtZkxCVGRMcTY4?=
 =?utf-8?B?S0prTTlEcDBGVE1KdHFyR2ErUWxtNis2cmF4UFI1MTFHS1dPdnBLMVVMTXh0?=
 =?utf-8?B?Zkt4T2lKR0lEWnRVd0s3cU4xWGlKTjcwZVA4SXJFalIrbUhZOEx5SFVPT2oy?=
 =?utf-8?B?YXZubDNVdVJWRzVpTFg4c1d3OUdXaUl5WVhsVUwxTm9GVEVzbkQwZWRVSjhN?=
 =?utf-8?B?RUFHVlgwS2VrQVViakJzRlhmajhsMDFkTk5yUzdYZnhvaUZLOUdISUU3QTNq?=
 =?utf-8?B?Qkt0cEFVUmpoNzAyVXo0Znh2UzVUbUtVemJMc0pra2RXUnRjRDBvL01SaUJP?=
 =?utf-8?B?RFlMUitHRzIyVDVXL1M2eVFOdStIdVV4NmptK3pROWpZL2ZSYy9idz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5719510d-a09a-4c69-daa8-08df1e143418
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:27:03.7753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s21I9kOMV60Qc1UAiUqpfX1/64wXUmaNnxR8CSdYJp/LA179D8qbD7hUIM4dXEQg/ckyf16K6gImm8CElFdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

On 9/29/2026 3:20 PM, Matthew Auld wrote:
> On 28/09/2026 18:51, Arunpravin Paneer Selvam wrote:
>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> __alloc_range_bias() and __alloc_range() only undid splits made during
>> their search when split_block() itself failed. Their DFS-exhaustion
>> failure paths (-ENOSPC, when no suitable block is found) skipped the
>> undo, leaving the buddy tree needlessly fragmented over repeated
>> failed allocation attempts.
>>
>> Fix by recording every successful split_block() call in a list and
>> unconditionally undoing those splits on every failure exit, via a
>> new single-level gpu_buddy_merge_one_level() helper (the original
>> __gpu_buddy_undo_splits() cascaded merges upward, which is unsafe
>> when called per split-list entry).
>
> At least for __alloc_range(), I thought if we do a split it should be 
> always guaranteed that some eventual side (left or right at some 
> depth) will be marked as allocated, unless the split itself fails, in 
> which case you might need the special undo path.  So I don't think you 
> can ever have two free buddies on the -ENOSPC path, in which case you 
> don't need any "undo splits", you can just trigger the normal 
> gpu_buddy_free_list_internal() path, which is what the code currently 
> does? What am I missing?
You are right. Whenever  __alloc_range()  splits a block, some side 
always ends up marked allocated, so on the -ENOSPC path there are never 
two free buddies left behind - freeing the  allocated  list via  
gpu_buddy_free_list_internal()  already merges every split back.
So I will drop the undo from  __alloc_range()  and keep it only in 
__alloc_range_bias() , which allocates nothing on failure and so has no 
list to trigger that cleanup.

Thanks,
Arun.
>
>>
>> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
>> regression.
>>
>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>> decoupled dirty tracker")
>> Assisted-by: Claude:claude-opus-4-8
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/buddy.c | 64 ++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 58 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 2f2aaadafe35..b741160d3d16 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1240,6 +1240,52 @@ static void __gpu_buddy_undo_splits(struct 
>> gpu_buddy *mm,
>>       }
>>   }
>>   +static void gpu_buddy_merge_one_level(struct gpu_buddy *mm,
>> +                      struct gpu_buddy_block *block)
>> +{
>> +    struct gpu_buddy_block *buddy = __get_buddy(block);
>> +    struct gpu_buddy_block *parent = block->parent;
>> +    enum gpu_block_state block_state;
>> +
>> +    if (!buddy || !gpu_buddy_block_is_free(block) ||
>> +        !gpu_buddy_block_is_free(buddy))
>> +        return;
>> +
>> +    block_state = gpu_block_cached_state(block);
>> +    if (gpu_block_cached_state(buddy) != block_state)
>> +        block_state = GPU_BLOCK_MIXED;
>> +
>> +    rbtree_remove(mm, block);
>> +    rbtree_remove(mm, buddy);
>> +    mm->free_scoreboard[gpu_buddy_block_order(block)] -= 2;
>> +
>> +    gpu_block_free(mm, block);
>> +    gpu_block_free(mm, buddy);
>> +
>> +    __mark_free(mm, parent, block_state);
>> +}
>> +
>> +static void gpu_buddy_undo_splits(struct gpu_buddy *mm,
>> +                  struct gpu_buddy_block *block,
>> +                  struct list_head *splits)
>> +{
>> +    if (block)
>> +        gpu_buddy_merge_one_level(mm, block);
>> +
>> +    while (!list_empty(splits)) {
>> +        struct gpu_buddy_block *parent =
>> +            list_first_entry(splits, struct gpu_buddy_block,
>> +                     tmp_link);
>> +
>> +        list_del(&parent->tmp_link);
>> +
>> +        if (!gpu_buddy_block_is_split(parent))
>> +            continue;
>> +
>> +        gpu_buddy_merge_one_level(mm, parent->left);
>> +    }
>> +}
>> +
>>   static struct gpu_buddy_block *
>>   __alloc_range_bias(struct gpu_buddy *mm,
>>              u64 start, u64 end,
>> @@ -1249,6 +1295,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>       u64 req_size = mm->chunk_size << order;
>>       struct gpu_buddy_block *block;
>>       LIST_HEAD(dfs);
>> +    LIST_HEAD(splits);
>>       int err;
>>       int i;
>>   @@ -1313,6 +1360,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>               err = split_block(mm, block);
>>               if (unlikely(err))
>>                   goto err_undo;
>> +
>> +            list_add(&block->tmp_link, &splits);
>>           }
>>             /*
>> @@ -1349,7 +1398,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>           }
>>       } while (1);
>>   -    return ERR_PTR(-ENOSPC);
>> +    err = -ENOSPC;
>>     err_undo:
>>       /*
>> @@ -1357,7 +1406,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>        * bigger is better, so make sure we merge everything back 
>> before we
>>        * free the allocated blocks.
>>        */
>> -    __gpu_buddy_undo_splits(mm, block);
>> +    gpu_buddy_undo_splits(mm, block, &splits);
>> +
>>       return ERR_PTR(err);
>>   }
>>   @@ -1580,6 +1630,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>>       struct gpu_buddy_block *block;
>>       u64 total_allocated = 0;
>>       LIST_HEAD(allocated);
>> +    LIST_HEAD(splits);
>>       u64 end;
>>       int err;
>>   @@ -1605,7 +1656,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>>             if (gpu_buddy_block_is_allocated(block)) {
>>               err = -ENOSPC;
>> -            goto err_free;
>> +            goto err_undo;
>>           }
>>             if (contains(start, end, block_start, block_end)) {
>> @@ -1634,6 +1685,8 @@ static int __alloc_range(struct gpu_buddy *mm,
>>               err = split_block(mm, block);
>>               if (unlikely(err))
>>                   goto err_undo;
>> +
>> +            list_add(&block->tmp_link, &splits);
>>           }
>>             list_add(&block->right->tmp_link, dfs);
>> @@ -1642,7 +1695,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>>         if (total_allocated < size) {
>>           err = -ENOSPC;
>> -        goto err_free;
>> +        goto err_undo;
>>       }
>>         list_splice_tail(&allocated, blocks);
>> @@ -1655,9 +1708,8 @@ static int __alloc_range(struct gpu_buddy *mm,
>>        * bigger is better, so make sure we merge everything back 
>> before we
>>        * free the allocated blocks.
>>        */
>> -    __gpu_buddy_undo_splits(mm, block);
>> +    gpu_buddy_undo_splits(mm, block, &splits);
>>   -err_free:
>>       if (err == -ENOSPC && total_allocated_on_err) {
>>           list_splice_tail(&allocated, blocks);
>>           *total_allocated_on_err = total_allocated;
>>
>> base-commit: 90780f2c3d30187116128f71bcf92c8ab63400e7
>

