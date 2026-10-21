Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mxtk439V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB4010E2A2;
	Wed, 21 Oct 2026 06:47:07 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7B710E0CC;
 Wed, 21 Oct 2026 06:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNi6FBU9704il65VsuOGcsRHT7z874/g+C/fRzQa0/JzJ87qpVLTg/KYB4DDQFh5I1Mw5QQbl8NimIavc3PTYPjLaA2TRAAbThpTLxtFIuWrBmOmzGr4vayar+Vas9Q/78rSxNtcYWkyPTfmYGk4AEsWIJKPdxYFoj63zHMc4CN8cbz8mMBDPTVcWzajPEk2Dop131qkxUWM96rzAIT3BjYWoGVdK3a0SnVwFlTXjepudRJkPFb+Pn77EgoV+Np5e+MrDMUJhVDhs4xU29o+/EWLpDF1ExjYyMmknoBSIg+O6ZqDqDasT9edd9/ieB9EIBhCD19+yWRJqpCsP64ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJcKHEcNcnoDoxmtp0cQdBiB9Im2emgCuy8VL+5ww50=;
 b=Wa+xyCYnd8s04SbvYaTbe195s4KFOQ0Ek98adlNmXUvQRAqqu0vjIqJeViBdCnxLa1akporElNhTmRTMhaeOhb9XIpbOCdAm/ZbACGFV8Lvpgx/OniKqXtjqH76jLMiaF1h+M/wL5iK2j1CT4bE21xqv+iMcp2nf30IpuhQglq0NO/vGchM7GoD43sBAdPZv+nj9l+io5vdubFj5UkV+uui2mxcNR6iN4d6YU/7n1s8Zh7A9rZ3sxgEELDVnSd6ZV6eXN3LPfKJp6jcxi7EcO2xZd3rQ9laD+AbB+tZniluBa9hwmQSufL/ZLWKLNkwrHWIY3HI/BmrOLAzZdFCh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJcKHEcNcnoDoxmtp0cQdBiB9Im2emgCuy8VL+5ww50=;
 b=Mxtk439VhtpjkmMllkIk8UIJ/Xf/SMgLeXiQamaUMsUx58PcdtuOiImHM7E7E6/AcJyg1/XosFbvRUHscAlG5Z/hvfKugPt2SLz7E0zs4st6BvFH4fsBnAyi3OldGy3rO/5By11791VthGAEs3zMUSU1LFDjzACwAGuSb+VMRA0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DS6PR12MB934327.namprd12.prod.outlook.com (2603:10b6:8:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:46:58 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 06:46:58 +0000
Message-ID: <eb837a59-b682-423f-93a7-f83de4e38d4c@amd.com>
Date: Wed, 21 Oct 2026 12:16:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, sashiko-reviews@lists.linux.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20261020055537.1640552-1-arunpravin.paneerselvam@amd.com>
 <sashiko-outbox-178464@kernel.org>
 <30e81db2-a56a-464b-93ea-c74aa161fdde@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <30e81db2-a56a-464b-93ea-c74aa161fdde@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DS6PR12MB934327:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e7f3a3-cfc0-4da0-fefa-08df2f3f1a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YLvsKPFuxa8sJeKv/9QUhitePXcjgb/GclgZdZJeLi+zkCkATLA/rbkr1GOZcT8TcCR+d4nf3Fmfj4o/PUneH3ZYXknKQpL1VaqyDl6xB+zWdk/PTKKZPmdz1mXqajhjSgZP5y80jMsB3CCobzJDKQgQ/IEH5gq8DuKGIqM7Q2SO4JqCSCX7C79hJvV6LvtJpfzdWAU5kql/2gkkXfq6I2YDMwODGP21HYijuphkMF6EGW6Vho5/IWMlHGVFLi6v7/0i2tFVa7DINUwRd6DgOK04hyBInCUBuJBptLnMA+R2veGt6Qdz7gOEe8d3gco0mnPjwdtZzE8h7Pgadl54rfG7GYtbqrSRB4nErcR55S3W+ESspRbb7H40wlC79kl8oTUFlO8993JDBZR3Z49Iov3fM2ePT7a0OPZGQ8lQjeyHYF0GBa1HbRlLjxOHRhhf8VxW/8Wsi65pDVNvByVBLA5ChChAr8RFKSwQKnuL165c6ZWwlkOTF6l2Do1obtgE29cdLDwX3R8tyleFO7MzffqNrY4PSnL5pAVrLzwVpnufT7kRsflVjz7o8l4CGk2+4UBNDmZYIVVKp0fYYF747jHDdykJ90aGK5+Q9vBTFPbH3oLYQ8Xho2jHlDciScc9x8uOUofA+GymHWBv/aILpiXatvBEV4gQsdbDhsFUTX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFhQKzBoUEhlZzI3SUdnUWFyQkdZVlpOb21RcE9kK3FVaGFwV014MlVJbkFB?=
 =?utf-8?B?STlBdi9WN0ZWRTBNUkVCWjJmbEpRLysvMFphMVhIQ2puZ0RYR1kvVHA1dWdS?=
 =?utf-8?B?QTZXQ2tiRk0raUdGbElZK2lCbWFvUmNKSGxNOTJSR3Y2OWVXMitodDl1MzE1?=
 =?utf-8?B?Vko0Ty9WU1NTR2JkU3BDS25FRzVHQ3FleEk2MU1RVUFLZmpJUjM2eWdkZmZt?=
 =?utf-8?B?M3VoVlFwVTZHSVFycFJGK01JeTFOQjRQeUNBSkh3TlB0ZTBWaFkwQkF3Skp3?=
 =?utf-8?B?MVZkVWdOTGV3ai91RVVVZXV1V1ZSKy9JL003RlMrQk11c0twOFJXYWc5ZjNs?=
 =?utf-8?B?Mi95UmZrTmdKdDU3cWNiMmhabVRtTDg0cFo3YTZxdmNDSkk3aDRUc0NYZEZz?=
 =?utf-8?B?Sm14aTNRQ3BTaDE2eDRic05SQk5KL0RvdVdFVTNiQ3VDOExmaXIxY0M2eGZU?=
 =?utf-8?B?UVdEV081ajNQa1lzTDFvSHgrZHlHQWEwdFVkY3UrL05HMFZWRGttc0JMOW5s?=
 =?utf-8?B?elRPa29oNmtFVlUzbFhZVHhkY3ZzOUdMb3AyOHNkdGFSS0NOU0s5Z1FkK0Ix?=
 =?utf-8?B?UHNXWmc2VWFvTlptTFM3NVVUQVJ1aVpPbWhqZnJrVSs0Qkd5QkUxOWdpNGZY?=
 =?utf-8?B?R2I2OFpUeXZheVdWdjd0SHhPcVR6U21WZ0gybnFLSHprRTdtU3dPUURqVW5B?=
 =?utf-8?B?N3lUZEpjYktwdVMyK0JtTFhwWkhWNVM3NGp5dUdIdXRlMG9CU3lINUtvZTNm?=
 =?utf-8?B?UFhUVmVyRGhkSFdrckl2TDV2QXZ5dlI3dVl1OVpvNWZTM2svaVphTVplTU81?=
 =?utf-8?B?M1NTWVFNTWlCOFNuZlk0ZEJVZzdjVkdBdWIxTkMwR1FWZUFST0MreHQ1Y0J0?=
 =?utf-8?B?UzVpMWwyRGNvVGI5MDZ2NWRpVitQdjVKUmpEeVFUN3EvUmJqZEhYa2VLSFhs?=
 =?utf-8?B?R2RyVVJQaGdvNDU2b2xzKzlDbE9DV2M2VFNDYmY2Si9VbUhOdEltQXVHU0Y5?=
 =?utf-8?B?TEVOT3JnY3hFUXhoMkNFSythcnpxVDUwekt2TVVOUHZUTlJGeHduZ3BHQTlm?=
 =?utf-8?B?TlI0VU1Uek84QWdsRlo5ZEl2Zm4wam9IMWVZTGRWRDBNVDdRMnpwTUtMTFJ0?=
 =?utf-8?B?dS9KRnhDZWdLajd1YWJRLys2V0RKQUVHLzNqTFBwQXVpbjJ4eWVCd1VmQk16?=
 =?utf-8?B?eXlGQ0VOcjVQNDV2aHFCNDdOK0xkalIrZUpHQ1dJMlBHa1gydndCbmcrT1ZE?=
 =?utf-8?B?ME5IdGl6MDBEVFlPMzdIV1JGbVkzdk41bjYzZ3Z1WXl2b3hTaUhhMFhZaFZY?=
 =?utf-8?B?S1FyZG5Ba0FBSXR1UkxnT0J2N3ZhVmRDSHpESUxWTEZMdDVYM3NsTUJWZmdv?=
 =?utf-8?B?dVJETmtOTk5tcStRdFd1WGttNHdmY1lWM2djVGp0Y3pvWGZ2b3F3WHdtZUJt?=
 =?utf-8?B?Uk01QmZla0hYMFcySkNZUzlMZE9JbHFhTlM5M2FHUkV1bnhBaSswS29vdUZQ?=
 =?utf-8?B?WVd5VGJWUGJRdzNUOEg2eExnYmRsOVU2R3NrTkhNeGg4K2RSTEZtMlFYdnh5?=
 =?utf-8?B?S3NQYzJWRE1lZkJuVUpyNTVBT1BlczQ4YTNJRllNQjgrY1I3cDRJSU10K0FN?=
 =?utf-8?B?OHBLTXdzbFY4aS94T2xhMTBZWGdzWDVZRjBvd3ZEQTM2RG5BSWNpYlJweTFO?=
 =?utf-8?B?R2JBb1o4eEJXR296Yjk4TnRDbmlpWTQrRGtUQXlJWTFQMDBFdWN6Ym1FL3pa?=
 =?utf-8?B?d1hpLzRPSnhqNEI5U2lEU0Z5eFFqaThnNXBSclI3TTBQejlxazJhNW1WVGRn?=
 =?utf-8?B?ejJNVlIzUGJ2QlVMemdqeHZiRG85UThFVmdUR3BQS1hiVDJoRkFVd3kvVzNt?=
 =?utf-8?B?RXZvb0VHMGlHSkpXQUpzMHBMWmFJOWx0S1hpNEFJN2E2TVNWRmF3TDdkWWFZ?=
 =?utf-8?B?RXZBTTJERmxvZ0FWc3gzLzkzNTFaMEF1UlQ2L0dFSHk3Y1A1Y0VVWStNYnVD?=
 =?utf-8?B?Tm41S0FIa1ZXY3NOTXZtVFdYK1lUbXNUNE1yRFJyT3lWZ2NrMnZ6c05odjlU?=
 =?utf-8?B?bG5tOFlKc212eVpyMjhpQ3h4NkhlS1BFZUdRVkdSSlRGYWRJbWFYbUxYZ0Zx?=
 =?utf-8?B?YWJham9JbVVsakMvbkVCSkhMWkduTWZhSDc4MTJqUDVYb2t4aHlob21PMlJD?=
 =?utf-8?B?by9QWHRkakJ0ejVRZC9uZVJJNEJmRWdwSHJ6dkJoR3pnZFhCZkxGYjJ5M0V1?=
 =?utf-8?B?TGhNckdRQm5UU0c1cUN4WnprRXdsME5JWFRTQ2IvVXpEUjI0OWpqZk41cXRV?=
 =?utf-8?B?a2VvL3NkQjZhYVZtNVoyME5DREJyNWw3NXM4T2xWMitaazJZakRwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e7f3a3-cfc0-4da0-fefa-08df2f3f1a82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:46:58.5331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWKcdlF971V3l55ELGKqnaKoRPN6/yQH9UM83dQuOP9TNA8wfcr1eW8e0XSGIqolBoavapIjCWFbjw3cweMiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB934327
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/2026 3:22 PM, Matthew Auld wrote:
> On 20/10/2026 09:00, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>> - [High] gpu/buddy: block_incompatible() mishandles split and mixed 
>> blocks in __alloc_range_bias()
>> -- 
>>
>> commit 6dff7f0e6dce9c68ecb98f2d911199843d2b4401
>> Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> gpu/buddy: restore two-pass clear/dirty guard for range-biased 
>> allocation
>>
>> This commit introduces a two-pass search in 
>> __gpu_buddy_alloc_range_bias()
>> using block_incompatible() in the strict pass to prevent 
>> range-restricted
>> allocations from splitting opposite-class (clear vs. dirty) blocks 
>> unless
>> no matching blocks exist in the range.
>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index 503f7d5934e4b..91935c71c5255 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct 
>>> gpu_buddy *mm,
>>>       }
>>>   }
>>>   +static bool block_incompatible(struct gpu_buddy_block *block, 
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
>>
>> [ ... ]
>>
>>> @@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   continue;
>>>           }
>>>   +        if (!fallback && block_incompatible(block, flags))
>>> +            continue;
>>> +
>>>           if (contains(start, end, block_start, block_end) &&
>>>               order == gpu_buddy_block_order(block)) {
>>>               /*
>>> @@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   goto err_undo;
>>>           }
>>>   -        /*
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
>>
>> [Severity: High]
>> Does calling block_incompatible() on every visited node in
>> __alloc_range_bias() before checking whether the block is split or mixed
>> mishandle internal GPU_BUDDY_SPLIT nodes and coalesced 
>> GPU_BLOCK_MIXED free
>> blocks?
>>
>> First, when mark_split() transitions a block to GPU_BUDDY_SPLIT, it 
>> leaves
>> the previous GPU_BUDDY_HEADER_CLEAR bit intact on the internal node:
>>
>> drivers/gpu/buddy.c:mark_split() {
>>     block->header &= ~GPU_BUDDY_HEADER_STATE;
>>     block->header |= GPU_BUDDY_SPLIT;
>>     ...
>> }
>>
>> Because gpu_buddy_init() initializes roots as dirty, any root or 
>> ancestor
>> split while dirty keeps gpu_buddy_block_is_clear(block) == false 
>> while any
>> descendant remains allocated. Conversely, a clear block that is split 
>> and
>> later has a descendant freed as dirty keeps 
>> gpu_buddy_block_is_clear(block)
>> == true on the split ancestor.
>>
>> When __gpu_buddy_alloc_range_bias() runs the first pass (fallback = 
>> false),
>> __alloc_range_bias() evaluates block_incompatible(block, flags) on those
>> GPU_BUDDY_SPLIT ancestors and skips the entire subtree without 
>> descending
>> into its children. If no other root satisfies the request, the first 
>> pass
>> returns -ENOSPC and __gpu_buddy_alloc_range_bias() falls back to the 
>> second
>> pass (fallback = true), where block_incompatible() is disabled and the
>> clear/has_clear child-ordering preference has been removed, causing the
>> search to split the highest-address extent regardless of class.
>>
>> Second, __gpu_buddy_free() coalesces adjacent clear and dirty free 
>> buddies
>> into a single GPU_BUDDY_FREE block with state GPU_BLOCK_MIXED, which has
>> gpu_buddy_block_is_clear(block) == false and block->has_clear == true:
>>
>> 1. For clear range allocations (flags & GPU_BUDDY_CLEAR_ALLOCATION), 
>> Pass 1
>>     sees gpu_buddy_block_is_clear(block) == false on a 
>> GPU_BLOCK_MIXED block
>>     and skips it via block_incompatible() without splitting it to 
>> reach the
>>     clear sub-blocks inside. Pass 2 then splits the mixed block 
>> without clear
>>     child-steering and unconditionally visits block->right first, 
>> returning a
>>     dirty block whenever the clear half is in block->left.
>>
>> 2. For dirty range allocations (!(flags & GPU_BUDDY_CLEAR_ALLOCATION)),
>>     block_incompatible() returns false on a higher-order GPU_BLOCK_MIXED
>>     block because gpu_buddy_block_is_clear(block) is false. Pass 1 
>> then calls
>>     split_block(mm, block), which reclassifies block->left and 
>> block->right
>>     via mark_free(). If the child overlapping [start, end) is clear 
>> while the
>>     dirty child lies outside [start, end), Pass 1 rejects the clear 
>> child via
>>     block_incompatible() and skips the other child without calling
>>     __gpu_buddy_undo_splits().
>>
>> Wouldn't leaving that split GPU_BLOCK_MIXED block unmerged keep both
>> children in GPU_BUDDY_FREE state, preventing ancestor coalescing on 
>> teardown
>> and triggering 
>> gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i])) while
>> leaking the split child gpu_buddy_block structures in gpu_buddy_fini()?
>
> Analysis looks correct to me. We assume if you get as far as doing an 
> actual split, then that must mean there is something in there which is 
> compatible, either you find it with some number of splits or one of 
> the split calls hits an error, which takes care to undo the splits. 
> But now with that compat check, this breaks, since we don't know ahead 
> of time if it will find something which is also compat. Arun, thoughts?
Agreed, Matthew, and thanks for the pointer. The split-then-reject case 
does leak because the compatibility check breaks the assumption that a 
split will always find a suitable block.
I followed your approach: after split_block(), the parent is pushed back 
onto the DFS stack, and unsplit_block() merges it back when both 
children are still free. I also narrowed block_incompatible() to check 
only free blocks.
I extended gpu_test_buddy_alloc_range_clear_guard to cover this case. 
The test fails without the fix and passes with it. I will send the v6.

Thanks,
Arun.
>
>>
>> [ ... ]
>>
>

