Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719A606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h+Q2tTOv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ECA610E329;
	Wed, 11 Nov 2026 04:55:33 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2451B10E175;
 Wed, 11 Nov 2026 04:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgImxC78O2FEfIHus+IFzbe5DyVkhbN7JJqAthsQQtru6w7qsx2pv6qyWXSYj7zSWDoXNyJpkaK0O15o40D5EIoamNpYzf3JAH6ddRy/R770WMy2XAE9kLgq9np1uJCOVIYRw2hC79Rvuuz53vUsFrjBk2xqo8t0hZj6QpoT9xdkhD8BOT97TCvVlnFhSnDClLBTKMPH2zBQiMtgH35kk2U3G+1POt75uL1P71KRNH5Tx9ArLBjp0VbvPOGt688kqlC+vGewdZEc9XWmSM8G6BxOIuO7hJFDyrPmEwzqzjhyiY7i5f1ReGVJVcy8SOydTX+yBWHDLQRropV/mF697w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqTHIu6+x0SnIUJShchgeunMBsRXEc9wtd+6Sp77rdo=;
 b=doY6xVfBbLV6AJAHGIQd0/ZGLs0gLx+J1NRm7FsYVGizCWP77DISipcO6sC9DCpW8/XMVzjxrwETurRJzq9dlcjmmhyLYJdwOVCqbqpik8jtwWuXev0NI5lPlqqdJRlUzMMeRDG49Al3pvG93oDi1tGBxDOIaV7aR6FaStZ1ImAkUhj8hSaf/CIilg6M1brb0glQDWv7eu4W0YlC+kPK5NP9YPsaNBdddYDkzzD0QcQqxoycHNA4jAx9mfqr/0g7/2CdPtamyLm2H9xR0ETvkIPPiV0R85UDSmcyBmdTOzv/Es+iXu1K03nWh3UbG03G7l55ezpzJQMrFDPxmhzL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqTHIu6+x0SnIUJShchgeunMBsRXEc9wtd+6Sp77rdo=;
 b=h+Q2tTOvsD7KGA2REcy2AwjASpd2fUquLUCApyEk2SjdHBOuu5fIMsIme0csC2vK+OkobcuZjdqm4gb8EBmryd1p8yqeDRLFeRozWbcF/lThCjOm8h6HJpDnKy5VjUa+acUMOv/rWdjNvW0pucTSfPIiM+Ym8YMRynCc2kHe5ng=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 04:55:22 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 04:55:22 +0000
Message-ID: <763ceb36-58f7-4ac6-835a-dfd4c949f963@amd.com>
Date: Wed, 11 Nov 2026 10:25:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261104072847.2617886-1-arunpravin.paneerselvam@amd.com>
 <398b34c3-3ccf-4568-9129-debcf554f06b@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <398b34c3-3ccf-4568-9129-debcf554f06b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::14) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b70fab-81e6-4fc6-84fc-08df3faffdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261102123227099003|11063799006|4143699003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|56012099006|261022105027099003|261026140227099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p8ClWtnxSrVbz9717yOeU9FuFiYyghGEK57kp5iTe8WyF1ibCkrcc1x0S99FJuTIgqiGR6Jq0SAg0zz3zO6UjGAcW4nQ8Ykljx2GT0vS/EndCVvkmOA/PgKyiQZVQJ/XQPBjC1sxkeCdtzC1PBkkM9mh/3DoR9F1K2y//xX+7sFvEO9gnTbWlnFDlGM3zfhakGAUIQRvlCaSHahEuC4bDbQgO4mlTP6ttJ58g0Fbao+WGgkvWvp1fgB/fM+Xij1hRxmx5paM/qh9Ek1fmrHatYNMkAS+PBo+GC7PycCAfYSZieWGY/8yMgb1y2DaMHBNoef4tD0btgp931gyth1WWKIwU+2cOvYCoJ/8ORNzhCPB4SlQZpFIzyWy943nPEVUbkCBs+uPB5mUXXQecb/TGhLolqqRVxmVu/p03kc+6ZHOBqkksKrHGDaZQb0iVFKc+ivG0j1RRLgUnEkdkpYc8C0/k4yjJkuPmRMvqo5Hhj1HJFQhEKMQd9mJib5PXxuU2odefXZkQNb5wsGnxg49WYpCTW2jXc0WeEaEDlYrMPmxBWwcpF8gojI2rxgOqmWcPnDP3yKSNmhhhQF6H8xkb5J4eloaATpFH8dvFkHdsPnAl5+WNzroseBbsctHKSr+a6HY6AIVn6EQdYIQDAq4bdkYSYKIg95i4HPyHIYjP/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261102123227099003)(11063799006)(4143699003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(56012099006)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhjSGhaMmZaeVQrMUZ5L1pJTGt4ekFOaTF2bVFOcGpEY3JPZUhyNzh4ZkNR?=
 =?utf-8?B?OEYreUhtOUo5VFVnZFU5NnhIYTNYbm1JQjFBaDZZVjVxcEZyK0ZCemhQNDkv?=
 =?utf-8?B?dXZRSU15VG55eW9TSG1zMWs3RTBRdWNjMFJtRm1pckZIUStSMHJvaW9wTkxG?=
 =?utf-8?B?ODJkbURzeTFTUE9nTTduNDVLUHlCSldxL2w3dUxhVHFCdnQ5V0VQbFl2SGpl?=
 =?utf-8?B?WVlsbkMzUXhZM1VBUE14ditxbUhDc3ZDa3doNVpuTE8wSmJWRVM1bURPai96?=
 =?utf-8?B?OTMyV0REN3JPa3RVaEVxSnRZbzdFeU1TcnIvZVlCWVpzck9UMmlMOFFZTUsr?=
 =?utf-8?B?cU85SW5mVnRqUUhoamR1RU1KTnNFMVJLWUM3d2MrTzk2ck9zM3BHUjNiRWVi?=
 =?utf-8?B?TmM5Z200S3doUVhlWHVTcE1TT2V0WDAxV0Q1cWxZbk5oazFMNWUzM3h4T1Iw?=
 =?utf-8?B?ZDNOTkpDVStFMEhuNFY1YmxBM3VNMzhRVW9Ra2ZhUCs3aTZFWjgrTURYNVdB?=
 =?utf-8?B?OTVHczdYQ2NROUQ0NHBqWnVtbERYOHkvT3JUd2JiZHpmYzUxdkxhd2FtaFFo?=
 =?utf-8?B?QkFySGpWdm1Ja3d0UFRnWE40TThZelZYeW5iZnA2TnNwMlZ5TUtYbTdzZVBK?=
 =?utf-8?B?Q2ZDYzhMYVk0Q2ZiR00zNlFsR3ZFTnFoSldpV0hJSFY4c2pvMFN0MElPeWg4?=
 =?utf-8?B?cXNoUk0yTDkvY3k4RWI4RElqNjdSRHVHZ3ZxOGJraXRKS3pxbkJhOXZ3OTE0?=
 =?utf-8?B?dzgrVWo4YnRWYVNGZ1h0dWM1U3VINDluR3JBNVViY1NzL2Nma3dhS2hTcE1i?=
 =?utf-8?B?L2JuTVZ0WnNoWmxmNGYyS1U4d0ROdW5iUXRZRDVBVXNUUlpvaDJmQVNsWEVs?=
 =?utf-8?B?YThNckczNTdQb1hqQ1pJOWNiTHFHQzVZVWNOWG0yakZzaVlMTzJUbktzM3Jw?=
 =?utf-8?B?Tk9kN2x5RGU3RTY1VVBib0ZJTmxETTVEWWVHUTlNVXZ5a2h4L1laZnR1RU5t?=
 =?utf-8?B?ZlllSmx2aGpWdUtBTnFZelNWSjV4UTlEamMyNDY4dVRhb0l3Y1IvN1gzdjYv?=
 =?utf-8?B?RDI4UlpJTkVCTVRYUFpxV1EzVHN3WE1sM3pNbEFiTlpvN0lQczJxcS9RSndJ?=
 =?utf-8?B?MkRNRmFOWTBDM3kwNEFGQ0FXZzM2NTU1WE5UcGU3bW11aXo4b2NmV1ZHNzJM?=
 =?utf-8?B?aEx1a3dzbERKVkRKVTdVNHM5V3plejJiRndIMlROdXBBSHZkTmFpSFhGbHBD?=
 =?utf-8?B?Z0RzWTNzSjNzdUE3RmdKV0FRNHRFM09OZEhPN2NDMFFsVWxZaHhPQ09LSS8r?=
 =?utf-8?B?eUxSSUM2VjJJc085d3Y2bVNXWHhubVlaajNSdGZOcWRrTjFDQ1VLOEpIczF6?=
 =?utf-8?B?VWRwNkU4VzFpSHBsR3dPbnVyVFBDNEcxWDNxcTlXNjJFaG9salhFcmk5RWZ1?=
 =?utf-8?B?clRXQmgvWkdpdTBLaStJcHJLTFRjbGoySzBoeUc5YlpOZmw3dEJUbHpIYURG?=
 =?utf-8?B?YWNHZ1NrTEZEeU1KU2tYMm9DVGhRVW8yVWhERUhIQUUxbEl3WVp0ZktGK1hi?=
 =?utf-8?B?RGczQVFJTnhESFNXaWl6Tm03cE1NcWZHSFJjekk4NGxZdjBCZTZOUWk1SmZm?=
 =?utf-8?B?L3pZSkVoQmthTEhXVFMyZFhiVmxLNGEySzhKT3oyV0QwV0JOdWY5TyttRGFK?=
 =?utf-8?B?ekM4UDhtWlkwNlRWM1JoSTRxZ3cySUh1RTlvM1J4cXVPRWZEeXd6S2swRWZE?=
 =?utf-8?B?S3l3QmNGT3pOWFdiTGIwR0JSVWVIellKODR4OFJBWWViUmZ0MHJDSDVUSGlw?=
 =?utf-8?B?R3ZncllpQjBaamtsc0ExL0p1NjVpMGdEK3U5dkxpemhzY3dzYTdSSGttWktu?=
 =?utf-8?B?c2svVGNHZ21vNXdaK1pDUGFKZ25SZm4rMTg3OE1nc1Ztd21teldmYjc0MnZI?=
 =?utf-8?B?VkliM3R0dHlZakZERzVwSDlKaHpkOFcweVZSQVFCL1hMQ1IwVWV5ZjlQcUZn?=
 =?utf-8?B?RFNQYjJuK21zWUpaOVY1MU1HV29iYTgvVlZ4NXhzanRCQWxaNmEvTXQxdWFE?=
 =?utf-8?B?dWVxTC9NSGJ0VXdTdEQ0bzNSREdSYTZ4YWhWQks2SXR0T0tGY3EwVlQvK2h6?=
 =?utf-8?B?Ylo3MjBzL05zaHlsV3VqRWppcHlhd20rZHFNak9MeEVyM2xnV1U2NExmc2N3?=
 =?utf-8?B?RGRjQWtWdUpOdUM5VjBlcWNqN2VlYVY4VFdUakxWeFBnU1hNaVJRVjV1NVcw?=
 =?utf-8?B?N3F1Vy9UV1BWRVp2eW5qZTJJUGlhakZhbHM3MlVsOVdJaTk2MzViaEFrUlF4?=
 =?utf-8?Q?9kPER1hQ9RC0FSiV1C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b70fab-81e6-4fc6-84fc-08df3faffdd1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:55:22.3720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HVIkP6YJKvfOIT85YvyR/DjjyAKTbq5YmtI118LEelFGNZCNu6fSgw+tfT5w8cjqvL43rN7Vj6Peui4+NpdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/2026 9:55 PM, Matthew Auld wrote:
> On 04/11/2026 07:28, Arunpravin Paneer Selvam wrote:
>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> Range-restricted allocations (the visible-VRAM aperture) skip
>> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
>> eligibility guard, so a dirty allocation freely splits clear extents 
>> (and
>> vice versa), interleaving the two classes until no large same-class run
>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>> search instead: block_incompatible() rejects opposite-class blocks in 
>> the
>> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
>> request still succeeds when only opposite-class space remains. A KUnit
>> regression test covers the interleaving pattern and fails without the
>> guard.
>>
>> v2: the strict pass can split a block and then reject both children, so
>>      a split no longer implies a compatible block exists. Sashiko 
>> reported
>>      the resulting leaked splits; fix as suggested by Matthew:
>>   - Push the parent back on the DFS stack after each split and merge it
>>     back with unsplit_block() if both children are still free.
>>   - Make block_incompatible() judge free blocks only (split nodes keep a
>>     stale clear bit) and take the requested order, so mixed blocks that
>>     can hold a compatible block are descended instead of skipped.
>>   - Extend the KUnit test with a coalesced mixed block and a check that
>>     a rejected split is merged back.
>>
>> v3: igt@kms_plane@plane-panning-bottom-right failed on Radeon RX 9070 XT
>>      with -ENOSPC: the range allocator's strict pass split mixed 
>> blocks to
>>      look for a wholly-clear (or wholly-dirty) leaf, discarded the mixed
>>      leaves it found, and ran unsplit_block to merge the splits back, 
>> whose
>>      per-allocation cost and residual fragmentation starved the large
>>      pipe-A scanout. Fix: accept a mixed block at the requested order 
>> as-is
>>      (caller re-clears), so the first pass no longer splits and discards
>>      mixed blocks. This clear/dirty compatibility relaxation applies 
>> only
>>      to range-biased allocation, where keeping blocks intact reduces
>>      fragmentation and preserves large contiguous spaces. The 
>> now-unneeded
>>      unsplit_block helper is dropped.
>>
>> v4: a higher-order free mixed block straddling the range edge was 
>> split in
>>      the strict pass then abandoned, leaving both children free under 
>> a split
>>      parent that never coalesces, tripping gpu_buddy_fini()'s 
>> free-root assert
>>      and leaking the children (reported by Sashiko). Fix: in the 
>> strict pass
>>      don't split a free block that only partially overlaps the range; 
>> the
>>      fallback pass consumes it (either class accepted).
>>
>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>> decoupled dirty tracker")
>> Assisted-by: LLM
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/buddy.c                | 83 ++++++++++++++++-------------
>>   drivers/gpu/tests/gpu_buddy_test.c | 84 ++++++++++++++++++++++++++++++
>>   2 files changed, 130 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 28cff97d57dc..d9749cbaf05d 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1240,11 +1240,23 @@ static void __gpu_buddy_undo_splits(struct 
>> gpu_buddy *mm,
>>       }
>>   }
>>   +static bool block_incompatible(struct gpu_buddy_block *block, 
>> unsigned int flags)
>> +{
>> +    bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
>> +
>> +    if (!gpu_buddy_block_is_free(block))
>> +        return false;
>> +
>> +    return needs_clear ? !block->has_clear :
>> +                 gpu_buddy_block_is_clear(block);
>> +}
>> +
>>   static struct gpu_buddy_block *
>>   __alloc_range_bias(struct gpu_buddy *mm,
>>              u64 start, u64 end,
>>              unsigned int order,
>> -           unsigned long flags)
>> +           unsigned long flags,
>> +           bool fallback)
>>   {
>>       u64 req_size = mm->chunk_size << order;
>>       struct gpu_buddy_block *block;
>> @@ -1258,9 +1270,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>        * This range-constrained search hands back the highest/right-most
>>        * address that satisfies the request: the roots are seeded 
>> high-to-low
>>        * and the right (higher-address) child is descended first, making
>> -     * top-down the default placement here. A non-top-down clear 
>> request is
>> -     * the only exception, where the descent is biased towards clear or
>> -     * clear-containing subtrees to satisfy the clear preference.
>> +     * top-down the default placement here.
>>        */
>>       for (i = mm->n_roots - 1; i >= 0; --i)
>>           list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>> @@ -1296,8 +1306,19 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>               if (round_down(adjusted_end + 1, req_size) <=
>>                   round_up(adjusted_start, req_size))
>>                   continue;
>> +
>> +            /*
>> +             * Strict pass: don't split a partially-overlapping free
>> +             * block; rejecting its child would strand the split. Let
>> +             * the fallback pass consume it (either class accepted).
>> +             */
>> +            if (!fallback && gpu_buddy_block_is_free(block))
>> +                continue;
>>           }
>>   +        if (!fallback && block_incompatible(block, flags))
>> +            continue;
>> +
>>           if (contains(start, end, block_start, block_end) &&
>>               order == gpu_buddy_block_order(block)) {
>>               /*
>> @@ -1315,38 +1336,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   goto err_undo;
>>           }
>>   -        /*
>> -         * Top-down is a strict address-placement policy, so when it is
>> -         * requested we ignore clear steering and simply descend the
>> -         * right (higher-address) child first. Only a non-top-down 
>> clear
>> -         * request biases the descent towards clear/has_clear subtrees.
>> -         */
>> -        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>> -            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>> -            struct gpu_buddy_block *prefer;
>> -
>> -            if (gpu_buddy_block_is_clear(block->right))
>> -                prefer = block->right;
>> -            else if (gpu_buddy_block_is_clear(block->left))
>> -                prefer = block->left;
>> -            else if (block->right->has_clear)
>> -                prefer = block->right;
>> -            else if (block->left->has_clear)
>> -                prefer = block->left;
>> -            else
>> -                prefer = block->right;
>> -
>> -            if (prefer == block->right) {
>> -                list_add(&block->left->tmp_link, &dfs);
>> -                list_add(&block->right->tmp_link, &dfs);
>> -            } else {
>> -                list_add(&block->right->tmp_link, &dfs);
>> -                list_add(&block->left->tmp_link, &dfs);
>> -            }
>> -        } else {
>> -            list_add(&block->left->tmp_link, &dfs);
>> -            list_add(&block->right->tmp_link, &dfs);
>> -        }
>> +        list_add(&block->left->tmp_link, &dfs);
>> +        list_add(&block->right->tmp_link, &dfs);
>>       } while (1);
>>         return ERR_PTR(-ENOSPC);
>> @@ -1361,6 +1352,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>       return ERR_PTR(err);
>>   }
>>   +static struct gpu_buddy_block *
>> +__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
>> +                 u64 start, u64 end,
>> +                 unsigned int order,
>> +                 unsigned long flags)
>> +{
>> +    struct gpu_buddy_block *block;
>> +    bool fallback = false;
>
> Can we have fallback = true when !(gpu_buddy_clear_avail(mm) && 
> mm->dirty.total_dirty) or something, and just do one pass in that case?
>
> In xe we don't yet use clear/dirty tracking so everything is always 
> dirty so no point in searching twice.
>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Thanks. I have sent v5 with the suggested changes.

Regards,
Arun.
>
>> +
>> +    block = __alloc_range_bias(mm, start, end, order,
>> +                   flags, fallback);
>> +    if (IS_ERR(block))
>> +        return __alloc_range_bias(mm, start, end, order,
>> +                      flags, !fallback);
>> +
>> +    return block;
>> +}
>> +
>>   /* Return the highest-address free block of at least @order. */
>>   static struct gpu_buddy_block *
>>   get_maxblock(struct gpu_buddy *mm,
>> @@ -1924,7 +1933,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>         if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>>           /* Allocate traversing within the range */
>> -        block = __alloc_range_bias(mm, start, end, order, flags);
>> +        block = __gpu_buddy_alloc_range_bias(mm, start, end, order, 
>> flags);
>>           if (!IS_ERR(block) || !steered)
>>               return block;
>>   diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>> b/drivers/gpu/tests/gpu_buddy_test.c
>> index 2c6f1da1a6d1..9aaca2fc6a02 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1606,6 +1606,89 @@ static int gpu_buddy_suite_init(struct 
>> kunit_suite *suite)
>>       return 0;
>>   }
>>   +static void gpu_test_buddy_alloc_range_clear_guard(struct kunit 
>> *test)
>> +{
>> +    const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
>> +    struct gpu_buddy_block *block;
>> +    LIST_HEAD(low_dirty);
>> +    LIST_HEAD(high_a);
>> +    LIST_HEAD(high_b);
>> +    LIST_HEAD(barrier);
>> +    LIST_HEAD(dirty_res);
>> +    LIST_HEAD(clear_res);
>> +    struct gpu_buddy mm;
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
>> +                   "buddy_init failed\n");
>> +
>> +    /*
>> +     * Idea is to lay out a range allocation as a low dirty block, an
>> +     * allocated barrier, and a high naturally-aligned clear extent, 
>> then
>> +     * issue a dirty range allocation. It must take the low dirty 
>> block and
>> +     * leave the clear extent intact; if it instead cuts the clear 
>> extent,
>> +     * a following same-class clear allocation can no longer find a
>> +     * contiguous clear run and fails with -ENOSPC.
>> +     *
>> +     *   [0,  1M)   dirty free
>> +     *   [1M, 2M)   allocated  (barrier, keeps the halves un-mergeable)
>> +     *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
>> +     */
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
>> +                              &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [0, 1M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, 
>> chunk, chunk,
>> +                              &barrier, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [1M, 2M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * chunk, 
>> chunk, chunk,
>> +                              &high_a, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [2M, 3M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, 
>> chunk, chunk,
>> +                              &high_b, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [3M, 4M) failed\n");
>> +
>> +    /* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) 
>> stays dirty. */
>> +    gpu_buddy_free_list(&mm, &low_dirty, 0);
>> +    gpu_buddy_free_list(&mm, &high_a, GPU_BUDDY_CLEARED);
>> +    gpu_buddy_free_list(&mm, &high_b, GPU_BUDDY_CLEARED);
>> +
>> +    /* Dirty 1 MiB range alloc: must land at [0, 1M), not cut the 
>> clear extent. */
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, 
>> chunk,
>> +                              &dirty_res, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "dirty range alloc failed\n");
>> +    block = list_first_entry(&dirty_res, struct gpu_buddy_block, link);
>> +    KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
>> +                   "dirty range alloc cut the clear extent 
>> (offset=%llx)\n",
>> +                   gpu_buddy_block_offset(block));
>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), 0ULL);
>> +
>> +    /*
>> +     * The 2 MiB clear extent must still be intact: a clear order-1 
>> range
>> +     * allocation has to succeed. Without the guard the extent was cut
>> +     * above and this returns -ENOSPC.
>> +     */
>> +    KUNIT_EXPECT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, mm_size, 2 * 
>> chunk, 2 * chunk,
>> +                              &clear_res,
>> +                              GPU_BUDDY_RANGE_ALLOCATION |
>> +                              GPU_BUDDY_CLEAR_ALLOCATION),
>> +                   "clear 2M range alloc failed: clear extent was 
>> fragmented (-ENOSPC)\n");
>> +    if (!list_empty(&clear_res)) {
>> +        block = list_first_entry(&clear_res, struct gpu_buddy_block, 
>> link);
>> +        KUNIT_EXPECT_TRUE(test, gpu_buddy_block_is_clear(block));
>> +        KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)(2 
>> * chunk));
>> +    }
>> +
>> +    gpu_buddy_free_list(&mm, &clear_res, GPU_BUDDY_CLEARED);
>> +    gpu_buddy_free_list(&mm, &dirty_res, 0);
>> +    gpu_buddy_free_list(&mm, &barrier, 0);
>> +    gpu_buddy_fini(&mm);
>> +}
>> +
>>   static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_limit),
>>       KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
>> @@ -1615,6 +1698,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
>>       KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
>>       KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
>>       KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>
>> base-commit: 49f40f15d20f5b4073d517da7efbcea079f1b9e3
>

