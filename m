Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E08C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC4610E566;
	Mon, 13 Jul 2026 08:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s13VzNj2";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013054.outbound.protection.outlook.com
 [40.93.196.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E636910E566
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsTIewzb2/YGdw551IGNPPmehyq4GToJOAR91EHNZyTYkU3zvRESlAcEf27PhcTs2V06UssVV/lUKp9UE2N7DLI/BXIIADuLHtE76Q8jT5GiPHxYmGw0kr/PHj5QOFugZnX9ar5hWwy7C3LGTJhBKsmAc/M891btAz8EwK2fra8JBtW3t6vyRaPSgn6XGIERIIaJBZIssKPcppKMYl9E79p/h2du+H+VybU+JISn1T4aNdlmqkmmG7GHet62OJx5THOlZhAD7Y7zYw1ZIu082qaIRTKNCgHg5PyyVgin503CpWkxqiUWQ+vS5AJMC0dRlTxyYogudkWMf3XTjeLMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sv3npmGQWYqD6WtVLdqFoaTLmVMIu5h1LORGsv9yCc=;
 b=mI4g5fPTzAgAMPFNuFyvZTNueSc7/j0jdnTMaPv9sgKQDaC1o6V6JaT/v2yNOiTmYy8PpIjz1H8jNR/FD2KvZhgC0FmkTTuxw65ClREu4x8LWTfxuxcZjaFg3FlUwkflLzZRkLcB3B0EYDUqnpqG/trscVRk1rrHHkCswBZJWqxLmCpJknWiEnIq63IhKKRw8T00NzGwgLEhGVMvrwX2vKxqffSXYff+Ryymh5efae4zVuOXrFNRKjtIHMOSfqCtftbCR0sMLif2vmcxdxWCgVolJJQ+B+KeRg/t5pr82XfMhKgwOE6t+3+Ft16BpNcDhBVZJ4wE+dGoAldm9YNncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sv3npmGQWYqD6WtVLdqFoaTLmVMIu5h1LORGsv9yCc=;
 b=s13VzNj200TkjoW41DYPUseeD+/VP5+V4lokjpzt9F6MCf2jeY9oGkgAqeThwrPIXJaVqTUw8rgnsCKnq+gIlPXt/hXrktQZEV/fcwUMqQRPFSkkuQTjMgtuHnuI+ywiMX0Pln5OxJVQzsv+95soaN7eV4w4iS7YdPoIk/8SaKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Mon, 13 Jul
 2026 08:02:28 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 08:02:28 +0000
Message-ID: <4901dc21-c281-4e60-b2a2-061100a5c8a9@amd.com>
Date: Mon, 13 Jul 2026 13:32:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: buddy: avoid repeated builds of root dfs when alloc
 range
To: =?UTF-8?B?5YiY54Wn546J?= <liuzhaoyu.zackary@picoheart.com>,
 "matthew.auld" <matthew.auld@intel.com>, joelagnelf <joelagnelf@nvidia.com>,
 airlied <airlied@gmail.com>, simona <simona@ffwll.ch>,
 "francois.dugast@intel.com" <francois.dugast@intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <ak+ECwsuSljmvyKd@hostpc>
 <b4d697adea96d7ca99cf63e838b5ea9e285776bc.b951c3b7.46d1.48aa.a1ab.5d328bb9162c@feishu.cn>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <b4d697adea96d7ca99cf63e838b5ea9e285776bc.b951c3b7.46d1.48aa.a1ab.5d328bb9162c@feishu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dca2282-f19c-4054-e1ed-08dee0b5151d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YlV/jxU5J8QuABdPvh9cFW2+l55YDL7xzI7HYsUCd7sIVg+dE3uEleBs0m9J0pEz6d5JnaNR11FpbHWOLUcnjOH+j9UoPGAW5E0ZQhg4XIGbAziDPSy0enrISE9HLRZonezmEb9d+9vHRK4tMAli+FR0bzFYHr07GhF+Wxzk7gFiiPCgYQw/Y3W6/ovkcDbtmELp0eWFbusimEe6x/RPwFJtjxO2TK7LOY8xlBWEIO8Y6twGxKfWoOwxIoCOJ5ERqfQV3+cOE5qGHo5zWqvHOfZRBYM3qPyrY6NO17ENKqzJPvoE1SImJoHNpaFOQueoy6MrqE1ZlbJbIyvRLsoloGu+miC2o9PeU5TSqpnqHu192a1bxlm8/RJBc42TRdzuqmtWfD03+IU12j3P6/O0K6hWbylZlnfm8OSl6s4haKka8GCwXFnQITMYntraKjEcclHHWFQEr+z1ckucA1pbWVxhhAwMpjdgDT5HYrYV95ig2X/oDxs+4XzRiQ9x3KLXx7b1t2H/3T8e7zOsCCzbgxaW3+G+C6FLwyobBioBelSerRk4dU67KKjvtNsaqgB4MVlTkrGNks7sEz9fMoXUYe/YRkiFBhaAwcVTMlnxPitH51hD9jpprx21rCg7w+YeStoSFRgFHb2M3fq2YTdNF19x3TICjg28h5ekJBbAfpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWNQRGkwOXM5VG5tNitVSzBIRzVNRmRWRkNPdk05Tmp0V1F1RmhaZEI1Z2M3?=
 =?utf-8?B?cTBUeENNRmlyNXdwczBMQ1VZaWZBKzFUTEltN2Y5ZkJhZzBYUE1DczQrUmQy?=
 =?utf-8?B?QTNPQXBnVVBkcFVjcStvRHNFbWtVZVA1ZHRHdCtVa3lsUU4vZWxZMGt6ZzJ5?=
 =?utf-8?B?eHJuMVRMTTF5TjVnanYzMDFwem5vOCtRV2gyd0JoSEJ5WHcwdGZjd1pqT0Fr?=
 =?utf-8?B?ay90Qmwwc0JQS0NOekNkWU9VR3o0dWtXNmRTTG5qOEtaOEd5SHZUZEZ4cDdq?=
 =?utf-8?B?NndwM0tlNmZtN24zZUZKUjdhL3VOcVgvRXZyNnpJRkpNSDg0aElwZDNuR0ZX?=
 =?utf-8?B?bXBSOVJkSVRZWktLVlpHdzhMekFvdFllNXMvQkd6UndHZE1YV3ZIZ0tjaFRZ?=
 =?utf-8?B?blhmcjBzYVMxeDNiazJkU2kvMHpHMkVXbVhEamg0SjNZdVZEdC9aYm5WS0kv?=
 =?utf-8?B?WG1SeWE5Umo2bnRQN3BncEZLQ2MzdU83YitsNmJJOXRmanZVRmRMS2MwNFpp?=
 =?utf-8?B?YU53ZXVaVG1FM2p5Q0dSOUduVWQzWkJtUXZ5Nm0vZDd0dXBtNXloS1RQelA5?=
 =?utf-8?B?NmhjWkIwemE1WVhUUjdZRUVrTHA4aFlJRGVSMXZDK1BoM2R0RnV4NTBCQ1hC?=
 =?utf-8?B?QlNicDNXSkVyK3JwUmhlWTY2aFJGTVBWNlM4UjZDRHJvWS9zaERJcmk3Q09P?=
 =?utf-8?B?K2R1aUVJR2VGVHZiMjJmNkVMRmVBQUFPT1lKMHV2N09UQkE0ekZHVzcwL2F4?=
 =?utf-8?B?aVQ4UEFSbFpqeFlONU1KSnc1Umg2V1RaZ2FJSHU1RmdRTTQ5WVZWRy9OYitT?=
 =?utf-8?B?R0xSbGJxNjhHZ2hLVGhSd3hNMmN2T2pocm9hcUVkVTRGclFWaWxudE5mODBl?=
 =?utf-8?B?Sjc3V3VkY2FqL3JUWi9raWVtTC9rNGg3YnErSVUwTUYwcEpEdS9zNXRqT3F6?=
 =?utf-8?B?VWF5UVhuTXo1a2JKV1lHdVpGaEVTWnZWbDhyd2ZZNmpoaFhJRTIwWXcwc2ly?=
 =?utf-8?B?ZVVLSVg1Q0V6cFBNb21wd20xaHJ1c3NYdTZaS0taeURQcXBHcW03dEZmRWJC?=
 =?utf-8?B?b3ZBaFZmK2pqSEoyOFdMMG9XaHdsRjdzTk9BdW1wMVUwQThhVDRweWN1Q2x6?=
 =?utf-8?B?MnF1ZkUvTGpNU0pZc2JFTEdqZFc5WnJ1Qldha3J5NlJ5UjlWOFNGTFREcFdS?=
 =?utf-8?B?MnpvNlJscHlENDlmVEdvZGtDeEFxTG5hZm5QWW92UkR4VkY2c2Vxd0pubDhV?=
 =?utf-8?B?SWg4VWxRTmp1RkU2Q1hCVmtvaTF5YUVTM2w2R0NWYnhOYkFKeDNVcStCanhL?=
 =?utf-8?B?Y3RFUDl6UUxCWFltWmFZOEpJTVM0UCs0SEdhMVhIWGFNNXlWYSs4a3B2cUZy?=
 =?utf-8?B?UnNXamJNYlFvTlE4SThtSkZLbEZueUtHYW1yZWtBdkZaSG4zY3hJVGcwc3F3?=
 =?utf-8?B?b2tZdTlGK3NvUVREWnhrOGdvbVQ3bmQ3TUZsZStGdXVvN3hhd1FTNmtFSjV0?=
 =?utf-8?B?MU0zeHBQRTZvbDMxUFdrZDhPZ21NSExvczNhQ1ZOcVRHZlFjUE4xSGQyYjlk?=
 =?utf-8?B?bmw3c2gwSzk1WUp6aFcrTFhPdEZUWXg3am96WjVmbjVjblA3VFJLL2F5aWlz?=
 =?utf-8?B?RzZJSUtRK2RvdXN5LzA3U1pzWWE4MDdiUVJsdDlDeXVpZExOckVkSGRGVXhj?=
 =?utf-8?B?S0c4Smd0Ui9ZU1VPZnVWUFZ3N2ZYMUpBbFNpZ1NtU1dwUGxTVkpjdXRmcmkz?=
 =?utf-8?B?TWl2dTVta3Z3WFUzWTZtbkVBbU5YZHpvT3JmMG9nMTJJVm1nMzFCbFkwWUpk?=
 =?utf-8?B?UzlWUWkyNWlOb2JZSHVFMHlpOVFjZy9wZHJMY0dROVhEdGdBc3hUVG90TGRX?=
 =?utf-8?B?TXQrS01NdkJya1ZUSHBIdDF1TDZ1L3gyRTlPVFljVStBN2lTN3BMUHdGWVU0?=
 =?utf-8?B?MDlDWnk2TmNpbFM2cW5WM1JJdlZRQXhWVlBpWGltaEt0TEJaRWpKZ3d5M296?=
 =?utf-8?B?bmllWmFWbVJxNzZYcHoyMXlITXFONUIvbDQ3akFUZGpDTVJESlUzSC9xKzlF?=
 =?utf-8?B?d2g1VWRtTTQyLzNMNzJtV3JPNjhOYzNkVEZCaDZNNlo0SXZzdkRTS2d3TjRM?=
 =?utf-8?B?KzArOE9TVUdyZmt0emtmRm1EQjUvTXZsdUlnM2RIN24rZVA3cjhHUlA5Wk0r?=
 =?utf-8?B?SWlZZkZvem1iQTY3a2dSSlJScEtZbTJ5Unk2WHB1MmhFa25tK0d4c1A2OVhV?=
 =?utf-8?B?MWlZVnB1TGYxSU1wSVJnK1JsRzZRRUk5UHYzaEczNFlLZk1kdTAxK0NJbDVu?=
 =?utf-8?B?STlQRDJhL1h4ekVmbStVOXViZm9ZS1lCWTg3NHRPWHRQd2pkL3p5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dca2282-f19c-4054-e1ed-08dee0b5151d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:02:28.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mMgOj/YE4hAd69HlLSadJAOs37JTRSbGm/s14huMyIAd8993lQ875xuYCRLcgfUZOpqUbwEhytpANLpE9uo8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
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



On 7/13/2026 12:01 PM, 刘照玉 wrote:
> [You don't often get email from liuzhaoyu.zackary@picoheart.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Please help review this patch.
> Thanks!
I was wondering whether this optimization provides a measurable benefit 
in practice. Since mm->n_roots is typically quite small, the previous 
DFS list construction only adds a few list_add_tail() operations per 
allocation.
On the other hand, the new approach introduces an additional helper call 
and branching during candidate selection. Have you done any profiling or 
benchmarking to quantify the improvement?

Thanks,
Arun.
>
>> From: "Zhaoyu Liu"<liuzhaoyu.zackary@picoheart.com>
>> Date:  Thu, Jul 9, 2026, 19:20
>> Subject:  [PATCH] gpu: buddy: avoid repeated builds of root dfs when alloc range
>> To: <matthew.auld@intel.com>, <arunpravin.paneerselvam@amd.com>, <joelagnelf@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>
>> Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
>> The buddy allocator previously pre-built a DFS list by inserting all
>> root blocks via list_add_tail() before every allocation call in
>> __alloc_range_bias() and __gpu_buddy_alloc_range(). This is wasteful
>> when the allocation can be satisfied by the first root or by sub-blocks
>> produced from splits, as the remaining roots are never consumed.
>>   
>> Introduce __get_candidate_block() which unifies the block acquisition
>> logic for both __alloc_range_bias() and __alloc_range(): it first
>> checks the DFS list (populated by splits during allocation or
>> pre-filled by the caller for trim), and only when the list is exhausted
>> does it lazily fetch the next root block through a cursor.
>>   
>> When the caller pre-fills the DFS list (trim scenario), the cursor is
>> initialized to mm->n_roots to disable root iteration entirely,
>> preserving the original behavior.
>>   
>> Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
>> ---
>>   drivers/gpu/buddy.c | 61 ++++++++++++++++++++++++++++++---------------
>>   1 file changed, 41 insertions(+), 20 deletions(-)
>>   
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index dc81fe0301ce..2cebb87020c7 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -700,6 +700,41 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
>>           }
>>   }
>>
>> +/**
>> + * __get_candidate_block - Get a candidate block for allocation.
>> + * @mm: GPU buddy manager
>> + * @dfs: List of candidate blocks. Populated in two ways: (1) pre-filled by
>> + *       the caller before allocation with blocks available for allocation,
>> + *       and (2) extended during allocation by block splits, which add the
>> + *       resulting sub-blocks for subsequent finer-grained allocation.
>> + * @cursor: Pointer to current root index, advanced when iterating roots.
>> + *          Pass in a value >= mm->n_roots to disable root iteration entirely,
>> + *          restricting block acquisition to @dfs only; this is used in the
>> + *          trim scenario where only pre-split sub-blocks should be considered.
>> + *
>> + * Return: Pointer to the acquired block on success, ERR_PTR(-ENOSPC) when no
>> + * more blocks are available.
>> + */
>> +static struct gpu_buddy_block*
>> +__get_candidate_block(struct gpu_buddy *mm, struct list_head *dfs,
>> +                uint32_t *cursor)
>> +{
>> +        struct gpu_buddy_block *block;
>> +
>> +        block = list_first_entry_or_null(dfs,
>> +                                        struct gpu_buddy_block,
>> +                                        tmp_link);
>> +        if (block) {
>> +                list_del(&block->tmp_link);
>> +                return block;
>> +        }
>> +
>> +        if (*cursor >= mm->n_roots)
>> +                return ERR_PTR(-ENOSPC);
>> +
>> +        return mm->roots[(*cursor)++];
>> +}
>> +
>>   static struct gpu_buddy_block *
>>   __alloc_range_bias(struct gpu_buddy *mm,
>>                      u64 start, u64 end,
>> @@ -711,25 +746,18 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>           struct gpu_buddy_block *block;
>>           LIST_HEAD(dfs);
>>           int err;
>> -        int i;
>> +        uint32_t cursor = 0;
>>
>>           end = end - 1;
>>
>> -        for (i = 0; i < mm->n_roots; ++i)
>> -                list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>> -
>>           do {
>>                   u64 block_start;
>>                   u64 block_end;
>>
>> -                block = list_first_entry_or_null(&dfs,
>> -                                                 struct gpu_buddy_block,
>> -                                                 tmp_link);
>> -                if (!block)
>> +                block = __get_candidate_block(mm, &dfs, &cursor);
>> +                if (IS_ERR(block))
>>                           break;
>>
>> -                list_del(&block->tmp_link);
>> -
>>                   if (gpu_buddy_block_order(block) < order)
>>                           continue;
>>
>> @@ -1023,6 +1051,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>>           LIST_HEAD(allocated);
>>           u64 end;
>>           int err;
>> +        uint32_t cursor = list_empty(dfs) ? 0 : mm->n_roots;
>>
>>           end = start + size - 1;
>>
>> @@ -1030,14 +1059,10 @@ static int __alloc_range(struct gpu_buddy *mm,
>>                   u64 block_start;
>>                   u64 block_end;
>>
>> -                block = list_first_entry_or_null(dfs,
>> -                                                 struct gpu_buddy_block,
>> -                                                 tmp_link);
>> -                if (!block)
>> +                block = __get_candidate_block(mm, dfs, &cursor);
>> +                if (IS_ERR(block))
>>                           break;
>>
>> -                list_del(&block->tmp_link);
>> -
>>                   block_start = gpu_buddy_block_offset(block);
>>                   block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
>>
>> @@ -1109,10 +1134,6 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
>>                                      struct list_head *blocks)
>>   {
>>           LIST_HEAD(dfs);
>> -        int i;
>> -
>> -        for (i = 0; i < mm->n_roots; ++i)
>> -                list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>>
>>           return __alloc_range(mm, &dfs, start, size,
>>                                blocks, total_allocated_on_err);
>> --
>> 2.34.1
>>   

