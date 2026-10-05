Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645A2CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEAD10ED2B;
	Mon,  5 Oct 2026 14:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZdsigpz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A3B10E281;
 Mon,  5 Oct 2026 14:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVgB2yjdtgE8gFG56nnTxG50TnGYG76vkRgsj/Pw7UNvHjJDM4BY08uRvf9YIIEn+yoWM0DzIblcMrsIZ01sckk3XJj1TP68TLetj0x/09nXEydaKxB+rjuERBvcmaufrSaFY4jqUFPZ94TRXaPoak4cveRDZ4/A76zLSpSxUMyZZ3uG/hSxgYGvqtPHItv7FgEszckiy25s/6OX31t/+iqsCRof6wppsU2w+2mgixs8JhUjTfHG4Zy61NuOcvxof6kpHkDOPhIOcWec4tifNna3/lqGaldFsHXYjmmW30KB+UnMNqcgFnx7z2B72Q7e/P8Uqh3rf66s21aQQPgrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqfag06ZTiQu0BZ8nWgglkpM8Owt3/viHznNny77Rek=;
 b=uW4jCKsGTfg8S5VgGs8L0fmh2dU1ofQx8y6OodjKWPnX6YEbikH7TTDENCm5Fb7XFZ0G0aAF5fzytLjCBNn0ImIGFIxr8fCCds2IFI2mVZ7/F3v7I3bfz6m+V1ddtwIFc8MfybW/I1Lpbk0xkmKF3skGHPYgnw7ifuiEWpjDiOhuX+U+b+530nhpn/3ORLUc13fdjJ0z3DsqqsMKMMiIHtXx8tlbS/3ZonCO/a4kk7YbPUEIgCq/9+bdVCP9GFUbvbV1f1zoDYlzuQWRMlG7WW89ZXWspxnZ7NfHFWGnfyUxsERDvVSXAE1ohQvDpAARZEL17qKDpaFClf8QFpMo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqfag06ZTiQu0BZ8nWgglkpM8Owt3/viHznNny77Rek=;
 b=AZdsigpzUk78+35BU0BzkiD8Ii8IE0u9eEyayrlMNwGk73MFhtl3KdPDIqYBA2Oj5vqrRXBDFY+K5v/x6qCPIN9kJD3FOgdJsNPltbLrMDb9SAKQpOo7V7iJP6wzP5NlY8rMr/7plAEVu4amyB7172lFCuhMFGAv7QWWgb0QdLE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 14:14:26 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 14:14:26 +0000
Message-ID: <b86fd371-289d-479f-bdfe-b2d6136d8d21@amd.com>
Date: Mon, 5 Oct 2026 19:44:19 +0530
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
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <254159a2-66f8-4fce-b185-84e81d126e25@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9060b1-1367-455e-83c5-08df22eaf63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: BGYsUN1YbLIJFTWtpuuLMhW9FL15njOyMp3HBcqix9XAlKFedzuHkLzrhAUgUgAeZRADJ821g92+pPVhFOZg8+BqR86vRoxAqsfNBaMtvuPn/d0W9uqsX3NM5sCjpqlRhGeY7IWH5hul89tm+YP2ORCmyj8hGyq4Xe9UDh9kTLOdxEMBM3YDGonKcWivTlgSG6qmEzhMgR/cIA9eCnqo9SqwiTeMDnEgsDLc9OyvTVFNnM/N6DD75a5QHiTW90davEGddneEiQNAa2YAAEl4tkhFZC+nkJa/TT13d1r7/lmacFA8LeLbdw0yPH3JEylCfzM+l0A/R3Tr2xTxTD+QX2EaQ0HBLaiH4ZRKLX3y/zMhuck+oveGJvQxjyZcB2u4pkfEFHHt6rIzyVPlk47kiUuUWxgHvAtGTrt4WV1MWNyrpmIz9xong7Nwr1fy13VF4u65TqcEO/1pRIpAiliyxcHMWad355GDgljcXnM8uqqYDjqrsBXgE0z+JTgA2wWJNdKDEXKax2TN0wteHXwPQBryk8enak/u3eQUpp0fgCK7+8fHSoeDXc8ug33k80IeCLOb2Ise0VNvqB9KNlNqIuRheGNWwEbEWsGBdA04pW6gmxANCpRpeyiCwIQxzSSlbn2pnxK3iuGqienkVWiRQUzl8r0eMSua/fZW70W/cZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mzk3VHFVdHVnTGdvWWIzSEM1R296WGlqRXdVajk5c1pRS1ZDME5TY0RrTUh4?=
 =?utf-8?B?ODMrSllrOWE1MEY0L0pGaktWNVNHUTBhUHgxWmtZVTlIUzlxM2htL1hnSEV4?=
 =?utf-8?B?NTVTdmd2MUV6ajdnNzN4U3lQbTZUQ1MvV3R1dWV2UHpzdkRWbnVJUytTazdV?=
 =?utf-8?B?M3B6NXNrbHYxWWV4OUM2bE5ocmtkdW5XVlBsMHpBbUM4RGxvOGM3bTFEM3ZK?=
 =?utf-8?B?Q09XS3lkamxJWG1Jd01qU3IyQ0RBRGEyM1NzNkVGbXVRWmtZMjVzKzMvdTlH?=
 =?utf-8?B?ckZRcmlmTjhwa1kyUURJNU93SklzR1lpalp1S3BOSGpnb29kMXViYXYxUGRW?=
 =?utf-8?B?eDJlZHlHZVR1K1ZCMFNKTVQ2emk1ZnJFR2Q3MG5UTEw2b3Z2aDZWL29aUVBE?=
 =?utf-8?B?UzdyOHExd1VQaXpwcjNGR29JNjhTdXI4OUFSTkRBcmx3ak02L3VkMFQ4ZlpX?=
 =?utf-8?B?NHlqREJXWlZxcHVCYWxWTXM0MVFSekVPaHNZN1J5aVNRQ0J0elA2UFJRNmNv?=
 =?utf-8?B?STdPNFV6b3R5emNFcSsrZHZTc1IrNlRZWlo5VWJKZEhLZUlBOGhiRkI4a1pY?=
 =?utf-8?B?ZWJnVFJOS056MTNNOVlmWGNHMG5seWN3ZkgwVXdRdkp3aXZqRjlhQTNmL2F4?=
 =?utf-8?B?M0wwbHM5N1VZNlhaRzBTMmNRdXg4ZmJiOFBISEZBNnJMTytHTVBPTXhnMWVp?=
 =?utf-8?B?RUxWb2JpYlhka3l4akE5SHEvK3F2MW8wUlBjeC9qalhrYUNwaitvVFR6dG9J?=
 =?utf-8?B?V3YwY3JjUThHK09KTlJ0dGUxSXVZNjh5cWVScGU5cFNkMllqQ0x0Q0c3Sytz?=
 =?utf-8?B?Zmw5NlNUUzJNZDBJdVhuV1RsTlpoUGc0Q3dlYlVTVENLNmZ4aDgrRWZWSEtq?=
 =?utf-8?B?L1FVRVB6dlBqUUhWcm04Ny91alRMMFFIN01kUU1tdjBtcnZiVlVHaHBESXdp?=
 =?utf-8?B?UnJjSWsxdUthOVFFNFJwNjdCbm1YMFZiYTQvOHVVcHlaSkRFSWJwZk01dTNN?=
 =?utf-8?B?dDV0V1dNaVI5UXBWU29hMi9zY0tGMU9QczRoUWRhamhwanJLUDc2a2h1aSsr?=
 =?utf-8?B?NFdnZGhvOXVHVWtOK3NrYnBQbmwxUm94NXpZQkE5MTluOU5JeFltT25uK3kz?=
 =?utf-8?B?eVVveXZGaktiekdYeGpXY1FjMXJmMGxqUk9jN085Umx4NlVjeitwRWpUU2NS?=
 =?utf-8?B?YmpvWUdUWmFPMjZmUGhlMUhOWlNuY0xZM1duS3c4U3V6YlB4ZEdZUGtOaFg1?=
 =?utf-8?B?R3ppRWROTkNCOG1sbVNCKzY4SjZaMkZLY1pycTQ5YlF1cDFQeE0xNzZpdDRo?=
 =?utf-8?B?MHJJbWJabjMzL2hZM0JWamdXMkxXZFBRZnN6NFJ0cXhJcCtQUlZwTG14VS93?=
 =?utf-8?B?cUNGVnV3eW11SXQrWGtCaEg1YzE4cU10Kzd6RVd0Rkt4bEdrQVlmaE5ZVU5G?=
 =?utf-8?B?MVhQbm5pUXdWMWpnY1R2MVNyejZIYklLWkdwSXhQN2dkWjJwRHk2eDV5bEN0?=
 =?utf-8?B?SHFFaURPcTRsUkZkYU93dGc1WHRBL0ZHSnVaWjQxMjUwYkc1TVVkclpIQ0tP?=
 =?utf-8?B?a0lxelU5amFqYmtZdE4vS3NuS1hhcjRibDJmRFpJNzlab0h5bzBXU1diSHdH?=
 =?utf-8?B?MU43bE9raVdQMzFuWlgwaUR6dFk5ZStwbHVlUTlTU21hb1Mxc3lPT2YrNWow?=
 =?utf-8?B?UlNPeUIxY3dsK1Zma1duNlJrbnJqUnkybHFOQkVRY0NVQW9ZcldFRWhXYUVv?=
 =?utf-8?B?c1p6OU1wdDNTU09tZ2k2MWxEOTVtUFFyMkVUSFhzcVJ6VjVtaEsxN2VlR29N?=
 =?utf-8?B?WkdHeGVmcVhIVEFDMjZZalcvWHYraFEwS0V3T2NXNVEyY2VUZTNaakRwb3JC?=
 =?utf-8?B?T0RERUx2aFN3MFY1UzE3VTN6YnIzZHl1M09yMXJsSldJOHk3c0VpQVRmS3VZ?=
 =?utf-8?B?ejcvUGtTR1hiUGlsUktPcE94bTg2UDBNQ2MxODJmR3BHaDU2bXoxT0IvMmZV?=
 =?utf-8?B?cC9WOFA3NzBKM1N3ODBXYVBlQ0VMby8zdVl3TEhlMUo0WnpLN3hMdklnaisz?=
 =?utf-8?B?RFRlQ2tpVVNldnpBNkJubTFrRXhVcldPT0MyL0dudmJobWlaRFI5bFRiLytM?=
 =?utf-8?B?dGtSYXI1dWNVNnp5Z3JwQ2Q1d0Z6WWQrcXVJUEdsNXlrTXJaa0dOU1AwcHhW?=
 =?utf-8?B?M2FuQ1dOU085akNpcmdhQXJjbCthQkVSN09aTjVzOG9HNWc4aEdYUW1lUmIw?=
 =?utf-8?B?eUZUQWxGRkRKTWFRd2xDVXhESGlxQnhERFA4ZVZUQlNKdGFjUkpqWStyeFAy?=
 =?utf-8?B?QjJWbEp3SGJpVlBhakg3aG5CWWc5MVRQRWh5U2ExYnZYUG1nWU9vdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9060b1-1367-455e-83c5-08df22eaf63a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 14:14:26.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41QxH8HWTsg/kqp4nguF+5auFcQMoPhxFpQrg+o/UFIulz9ZIKfwCS1WJUIgq8DEAaZNyx+vG8Jx7X0FveNNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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



On 10/1/2026 11:58 PM, Matthew Auld wrote:
> On 30/09/2026 07:21, Arunpravin Paneer Selvam wrote:
>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> A range + contiguous allocation (e.g. a scanout FB confined to the
>> CPU-visible VRAM aperture) rounds its size up to a power of two and
>> requires a naturally aligned free block of that size; on a fragmented
>> aperture no such aligned block may exist even though enough contiguous
>> space is free, so the allocation fails with -ENOSPC.
>>
>> The non-range contiguous path already recovers from this via
>> __alloc_contig_try_harder(), which stitches an exact-size span from
>> smaller adjacent blocks, but that fallback was unreachable once
>> GPU_BUDDY_RANGE_ALLOCATION was set. Give __alloc_contig_try_harder()
>> a [range_start, range_end) window and route the range + contiguous
>> case through it: each candidate placement is confined to the window
>> and aligned to min_block_size. Non-range callers pass [0, mm->size),
>> where the guards are no-ops, so the existing behaviour is unchanged.
>> A KUnit regression test covers the fragmentation pattern.
>>
>> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
>> regression.
>>
>> v2:
>>   - Drop the split-undo patch; the range-bias search always descends to
>>     an exact-order block or fails the split (already handled), so the
>>     extra undo was redundant. (Matthew)
>>   - Verified this fallback alone fixes the kms_plane regression.
>>
>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>> decoupled dirty tracker")
>
> Patch looks more like totally new functionally/feature, so the fixes 
> here is maybe unexpected? Did something in that fixes commit change 
> something such that the try_harder is now needed, but that needs some 
> expansion with bias + contig? Do we know exactly what changed here?
That commit removed __force_merge(), which previously helped recover 
larger contiguous allocations on demand. As a result, some 
range-restricted contiguous allocation requests
that used to succeed now fail with -ENOSPC (the kms_plane regression). 
This patch restores that capability through the try_harder() stitching 
logic, so the Fixes: tag reflects a
regression introduced by that commit rather than new functionality.
>
>> Assisted-by: Claude:claude-opus-4-8
>
> Assisted-by: LLM
>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/buddy.c                | 88 ++++++++++++++++--------------
>>   drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++++--
>>   2 files changed, 126 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 2f2aaadafe35..5265e1f6a318 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1685,26 +1685,14 @@ static int __gpu_buddy_alloc_range(struct 
>> gpu_buddy *mm,
>>                    blocks, total_allocated_on_err);
>>   }
>>   -static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
>> -                    u64 unaligned_offset,
>> -                    u64 size,
>> -                    u64 min_block_size,
>> -                    unsigned long flags,
>> -                    struct list_head *blocks)
>> -{
>> -    u64 aligned_offset = round_down(unaligned_offset, min_block_size);
>> -
>> -    return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
>> -                       NULL, blocks);
>> -}
>> -
>>   static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>> +                     u64 range_start, u64 range_end,
>>                        u64 size,
>>                        u64 min_block_size,
>>                        unsigned long flags,
>>                        struct list_head *blocks)
>>   {
>> -    u64 rhs_offset, lhs_offset, filled;
>> +    u64 rhs_offset, lhs_offset, filled, aligned;
>>       struct gpu_buddy_block *block;
>>       struct rb_root *root;
>>       struct rb_node *iter;
>> @@ -1734,20 +1722,24 @@ static int __alloc_contig_try_harder(struct 
>> gpu_buddy *mm,
>>                              flags, &filled, blocks);
>>           if (err && err != -ENOSPC)
>>               return err;
>> -        if (!err && IS_ALIGNED(rhs_offset, min_block_size))
>> +        if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
>> +            rhs_offset >= range_start && rhs_offset + size <= 
>> range_end)
>>               return 0;
>>           if (!err) {
>>               /* Allocate the unaligned RHS offset using round_down */
>>               gpu_buddy_free_list_internal(mm, blocks);
>> -            err = __alloc_contig_aligned_retry(mm, rhs_offset,
>> -                               size,
>> -                               min_block_size,
>> -                               flags, blocks);
>> -            if (!err)
>> -                return 0;
>> -            if (err != -ENOSPC) {
>> -                gpu_buddy_free_list_internal(mm, blocks);
>> -                return err;
>> +
>> +            aligned = round_down(rhs_offset, min_block_size);
>> +            if (aligned >= range_start &&
>> +                aligned + size <= range_end) {
>> +                err = __gpu_buddy_alloc_range(mm, aligned, size,
>> +                                  flags, NULL, blocks);
>
> Did you consider doing a bias-range for [start, end] using 
> min_block_size and using what it returns as the starting point, 
> extending left/right? If that fails advance start and try again? Maybe 
> what you have here is much better for the case you have in mind?
I took a closer look at the alloc_range_bias approach. My understanding 
is that this would repeatedly bias within [start, end], use the returned 
min_block_size block as a starting point, and then extend left/right to 
build the requested run.
While that should work, every failed attempt may require splitting 
higher-order blocks to obtain a min_block_size block, followed by a 
free/merge back when the extension fails.
The free-tree descent evaluates the available starting points through a 
tree walk without any splitting or allocation just for enumeration, so I 
kept that approach.
Please let me know if there is a case where alloc_range_bias would 
provide an advantage over the free-tree descent.

While evaluating it, I found two issues in the current try_harder() 
implementation:

1. It only searches free_tree[size_order]. This is insufficient when 
min_block_size < size. For example, for a 128 KiB allocation (order-5) 
with min_block_size = 4 KiB, free_tree[5] may be empty
while two adjacent order-4 (64 KiB) blocks covering [64 KiB, 128 KiB] 
and [128 KiB, 192 KiB] are free. These blocks still form a valid 
order-5-sized contiguous run, but they can never appear in
free_tree[5] because they are not mergeable buddies. As a result, a 
search that only considers free_tree[5] will never find this placement. 
v3 addresses this by walking the free tree from the
requested size order down to min_order, while reusing the existing 
extend/stitch logic and min_block_size alignment checks unchanged.

2. The search is not restricted to the requested range. v3 confines the 
walk to [range_start, range_end], skipping candidates at or above 
range_end and stopping once the walk falls below range_start.
This ensures that range-constrained allocations only consider free 
blocks within the requested window and avoids performing allocation/free 
attempts on blocks outside the specified range.
For non-range callers, the effective window remains [0, mm->size], so 
the behavior is unchanged.

Regards,
Arun.
>
>> +                if (!err)
>> +                    return 0;
>> +                if (err != -ENOSPC) {
>> +                    gpu_buddy_free_list_internal(mm, blocks);
>> +                    return err;
>> +                }
>>               }
>>               goto next;
>>           }
>> @@ -1759,15 +1751,17 @@ static int __alloc_contig_try_harder(struct 
>> gpu_buddy *mm,
>>             /* Allocate the unaligned LHS offset using round_down */
>>           gpu_buddy_free_list_internal(mm, blocks);
>> -        err = __alloc_contig_aligned_retry(mm, lhs_offset,
>> -                           size,
>> -                           min_block_size,
>> -                           flags, blocks);
>> -        if (!err)
>> -            return 0;
>> -        if (err != -ENOSPC) {
>> -            gpu_buddy_free_list_internal(mm, blocks);
>> -            return err;
>> +
>> +        aligned = round_down(lhs_offset, min_block_size);
>> +        if (aligned >= range_start && aligned + size <= range_end) {
>> +            err = __gpu_buddy_alloc_range(mm, aligned, size,
>> +                              flags, NULL, blocks);
>> +            if (!err)
>> +                return 0;
>> +            if (err != -ENOSPC) {
>> +                gpu_buddy_free_list_internal(mm, blocks);
>> +                return err;
>> +            }
>>           }
>>   next:
>>           gpu_buddy_free_list_internal(mm, blocks);
>> @@ -2021,11 +2015,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>       min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>>         if (order > mm->max_order || size > mm->size) {
>> -        if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
>> -            !(flags & GPU_BUDDY_RANGE_ALLOCATION))
>> -            return __alloc_contig_try_harder(mm, original_size,
>> +        if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
>> +            u64 range_start, range_end;
>> +
>> +            range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>> start : 0;
>> +            range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : 
>> mm->size;
>> +
>> +            return __alloc_contig_try_harder(mm, range_start,
>> +                             range_end,
>> +                             original_size,
>>                                original_min_size,
>>                                flags, blocks);
>> +        }
>>             return -EINVAL;
>>       }
>> @@ -2058,9 +2059,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>                * Try contiguous block allocation through
>>                * try harder method.
>>                */
>> -            if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
>> -                !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
>> -                err = __alloc_contig_try_harder(mm,
>> +            if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
>> +                u64 range_start, range_end;
>> +
>> +                range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>> start : 0;
>> +                range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>> end : mm->size;
>> +
>> +                err = __alloc_contig_try_harder(mm, range_start,
>> +                                range_end,
>>                                   original_size,
>>                                   original_min_size,
>>                                   flags,
>> @@ -2068,9 +2074,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>                   if (!err)
>>                       return 0;
>>                   if (err != -ENOSPC)
>> -                    return err;
>> -                goto err_free;
>> +                    goto err_free;
>>               }
>> +
>>               err = -ENOSPC;
>>               goto err_free;
>>           } while (1);
>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>> b/drivers/gpu/tests/gpu_buddy_test.c
>> index b75d32ca6ca0..2c445870b808 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1251,6 +1251,77 @@ static void 
>> gpu_test_buddy_alloc_contiguous(struct kunit *test)
>>       gpu_buddy_fini(&mm);
>>   }
>>   +static void gpu_test_buddy_alloc_range_contiguous(struct kunit *test)
>> +{
>> +    const unsigned long ps = SZ_4K, mm_size = 16 * ps;
>> +    const unsigned long range_end = 8 * ps;
>> +    struct gpu_buddy_block *block, *prev;
>> +    LIST_HEAD(allocated);
>> +    struct gpu_buddy mm;
>> +    LIST_HEAD(pin_lo);
>> +    LIST_HEAD(pin_hi);
>> +    u64 total;
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
>> +                   "buddy_init failed\n");
>> +
>> +    /*
>> +     * Idea is to confine the test to the sub-range [0, 32K), which 
>> a 12K
>> +     * contiguous request (rounded up to 16K) splits into two naturally
>> +     * aligned 16K slots: [0, 16K) and [16K, 32K). We pin the first 
>> 4K page
>> +     * of each slot ([0, 4K) and [16K, 20K)) so that neither aligned 
>> slot
>> +     * can satisfy the rounded-up 16K allocation, yet the freed 
>> remainder
>> +     * still leaves a contiguous 12K hole at offset 4K, which is 
>> page-aligned
>> +     * but not 16K-aligned. A 12K contiguous+range allocation must 
>> therefore
>> +     * fall back to stitching that span instead of returning -ENOSPC.
>> +     */
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
>> +                              &pin_lo, 0),
>> +                   "failed to pin low page\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
>> +                              ps, &pin_hi, 0),
>> +                   "failed to pin high page\n");
>> +
>> +    /* No aligned 16K block is free; the range-aware fallback must 
>> stitch
>> +     * the unaligned [ps, 4*ps) hole instead of returning -ENOSPC.
>> +     */
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, range_end, 3 * ps,
>> +                              ps, &allocated,
>> +                              GPU_BUDDY_CONTIGUOUS_ALLOCATION |
>> +                              GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "range-restricted contiguous alloc failed\n");
>> +
>> +    /* The result must be exactly 3*ps, contiguous, and inside the 
>> range. */
>> +    total = 0;
>> +    prev = NULL;
>> +    list_for_each_entry(block, &allocated, link) {
>> +        u64 offset = gpu_buddy_block_offset(block);
>> +        u64 bsize = gpu_buddy_block_size(&mm, block);
>> +
>> +        KUNIT_EXPECT_TRUE_MSG(test, offset + bsize <= range_end,
>> +                      "block [%llx, %llx) outside range\n",
>> +                      offset, offset + bsize);
>> +        if (prev)
>> +            KUNIT_EXPECT_EQ_MSG(test,
>> +                        gpu_buddy_block_offset(prev) +
>> +                        gpu_buddy_block_size(&mm, prev),
>> +                        offset,
>> +                        "block at %llx not contiguous\n",
>> +                        offset);
>> +        prev = block;
>> +        total += bsize;
>> +    }
>> +    KUNIT_EXPECT_EQ(test, total, 3 * ps);
>> +
>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>> +    gpu_buddy_free_list(&mm, &pin_lo, 0);
>> +    gpu_buddy_free_list(&mm, &pin_hi, 0);
>> +    gpu_buddy_fini(&mm);
>> +}
>> +
>>   static void gpu_test_buddy_alloc_pathological(struct kunit *test)
>>   {
>>       u64 mm_size, size, start = 0;
>> @@ -1534,10 +1605,13 @@ static void 
>> gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>>                        GPU_BUDDY_RANGE_ALLOCATION);
>>       KUNIT_EXPECT_EQ(test, err, -EINVAL);
>>   -    /* CONTIGUOUS + RANGE should return -EINVAL (no try_harder for 
>> RANGE) */
>> -    err = gpu_buddy_alloc_blocks(&mm, 0, mm_size, size, SZ_4K, &blocks,
>> -                     GPU_BUDDY_CONTIGUOUS_ALLOCATION | 
>> GPU_BUDDY_RANGE_ALLOCATION);
>> -    KUNIT_EXPECT_EQ(test, err, -EINVAL);
>> +    /* CONTIGUOUS + RANGE should succeed via the range-aware 
>> try_harder */
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, 
>> mm_size, size,
>> +                                SZ_4K, &blocks,
>> +                                GPU_BUDDY_CONTIGUOUS_ALLOCATION |
>> +                                GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "range contiguous alloc hit an error 
>> size=%llu\n", size);
>> +    gpu_buddy_free_list(&mm, &blocks, 0);
>>         gpu_buddy_fini(&mm);
>>   }
>> @@ -1603,6 +1677,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
>>       KUNIT_CASE(gpu_test_buddy_alloc_pathological),
>>       KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>>
>> base-commit: 744f262401cc2e1f3827496c72a47e072d31a852
>

