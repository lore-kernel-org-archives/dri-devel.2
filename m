Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9037606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0VofeTgZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289BA10F705;
	Tue, 17 Nov 2026 13:14:20 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEE710F705;
 Tue, 17 Nov 2026 13:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWX6rjch1PH4puRBoyJpJB+LvkDuhAt44ICx8kWh887RmViIGRR2ZJ6sRrovVw0kHATBNgsrYKX1fZOlrvPwqIOqol6zbPzdsh3r/dju2qWtgTbLWs/UjBz4qz05mB0PUkKAaNDQXIQZ3WUEVZ93Tpn97XSKpiX885JdkzNwxGsEVChAcWTabBjXJd/+CCVzHtEfVLwNuFhaAwiwxZicuDHuBc37NGjAjNPqprNdE1qYrbYMT8DhSUgjo1iDeezh8iY2IIilAMD+KTnWqCl+O+9NL6qAHJ9RGTVlH+5ZAkDzF2YiCs9HKxl/U80WxwzyAZsWrJt5jDNOUkByQ3BePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s/XQOJ5uS+C28PzioBEC7/ooVxDeP6V+N6H77ufnrw=;
 b=Jj7Thhr/MhrLAH/rJ53RfO5V3vkV62gsyznE8sTcCa6QfEfIkex5EAtXuo/EGby2YBHh0eIN57CjBk8BndDlMcblF04B855OMaliLBcB5KATRP4OEP6SE2i3m+QqAZc6UElyJnlerlvSqmd+eIYCfrftsSpJKYk//4GgpuXFuFcHsgUtIFy63qipRylM018GmCOHHV+YLmDWzsSuyIt6gcudTVMUQg62Hs0X4jLVsgMOzFA87Yo34TFzahS9BK3FmCWHcS6WBsx6Gk2EBEGbUW4CPAo8laWWvkH6kM5/un5Z0iAlT8Jq+iRyly2Kf2ykRBXxfutu1teYAr0azcE2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s/XQOJ5uS+C28PzioBEC7/ooVxDeP6V+N6H77ufnrw=;
 b=0VofeTgZPS8WR35dla9Ah4c+b2gwvUNGwQ2miDtNgTOTHdx6Sd7dgA0nq9OG7SqkZmAER6NYKTv3tgkXL5VYWxUUFVUOFok4tMbEclFRI3t5JQyJqr/4RFcGTcfXk2tAGz6KlExUQDqC+WAwfmXWEdRjGatynyFsz5fAR4Z/BE0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:13:26 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:13:26 +0000
Message-ID: <fb5c1552-e47e-4530-bf7b-20763e338fdb@amd.com>
Date: Tue, 17 Nov 2026 18:43:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 William Palacek <William.Palacek@amd.com>
Cc: intel-xe@lists.freedesktop.org, Joel Fernandes <joelagnelf@nvidia.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
 <91f03c24-2bee-4872-bf09-ca54f81ccf50@intel.com>
 <3d156a96-ca2d-479b-b6af-d31b862b9467@amd.com>
 <8b622510-5dff-4adc-abe9-db7b782692e2@intel.com>
 <da65f083-ab85-4f14-8be6-a720b9f6efc6@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <da65f083-ab85-4f14-8be6-a720b9f6efc6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0260.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::8) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ee99b3-6d57-4385-b5c0-08df44ac9066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|5023799004|4143699003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261102130727099003|261009223027099003|7136999003|22082099003|18002099003|11062099010;
X-Microsoft-Antispam-Message-Info: /iqmGFXbqBSTyc0UkIMdmZKcnpywSeTQW+EKbE6mid9plVairtgmn0oieCTfDX5prkMngsqdXKtGuz9E9BL4RNH4Wn9NkqvhctTe8oQkeyhilfaJLGg+6vKKM0TDd3fmET99zh6+cHjpxmLDl063Ls0fCYJowU5dfNVRjro10U4iH7DqPy8QyssNwwot+PvV22MdFwQ2tGiLyRkCol4jWXdmlGA9wDlPamc9IJqbK8I0HQIS0+zeZoCFAKLjXsEjO2vSOuPlnHowfanVVWRy3oN5wnpXT7vn+zwchnEclCGBL/yvwc5Y2lIyNUoZXBSP7UcmMheVOHVWpU001/RVLzTk+OaQLNsRxfsueEuheAgkWOINsDBU0ODgQmdPWDZ3yWhicPeG2zA2+peTC2G7ieQ5MvjpOsZ78TrSZtNw8TiAmdMl8Vj6gt6XhCwkCVctHcLFo9mc1GwtA3D1AybbguJ/vdGkqbKm1Wnv3Pb/oSeDriIlcknxb0FbbCBerpRD+gyCym38HhJVzvU6T0vEsGhcic+9iGDTPxY9urz7Pt0b35G25wazSK+GZEijebgQDbuhDsHvvmde3sUy1vQh8x3wyixo//A1Oh09MS0pF19JTduIINNGNuwXndjFdtr5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261102130727099003)(261009223027099003)(7136999003)(22082099003)(18002099003)(11062099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXR2b0YxZS9HNmUxOCs3aytzdnNzRE4vZnBHSEFmR0h3Tzk1cG1lRDArN2xP?=
 =?utf-8?B?TE1QbFJiYWpyVks0WjJxaTlxQWZGNTU5NUI0THl2L2NoRzhjQTcxSCtuRG43?=
 =?utf-8?B?dkV3UlFETVNoUFVhaDV6M3dxOWRZQmdSZ3ZFUUw2SjYrZVRVRVlZcnFJSXdJ?=
 =?utf-8?B?cGNPUTc1bFp3SXVDbzIzMnVkY2Nra3laOTdTcW5qYXJ2cEJhUU44V3MxL3Jt?=
 =?utf-8?B?VnRCMlJlZWhQZXE2Mlo4VzYxVXEyaEtlM2xLYTNWdjBxaDYxMFUxU3I0L0RO?=
 =?utf-8?B?R1NNaEZrbFlpZFkxWVdmNTM3T0FGeW1JRHVmeldEZlY0UmEzZHRlREgvNEpr?=
 =?utf-8?B?ZzdGbW1rN0FLYUtCRzk1MmI4dmNhS0I0RjBScGtKUWZ5ZERTR1ZWNjlZZk1Q?=
 =?utf-8?B?TnZIR1psU2dQWXJjNkZlZzhCejg1UEkyUmxqdVJuM09Sc2NiNDlnVWxYQ3lO?=
 =?utf-8?B?V1p2V2w0QlJ0RU12ZXVtR0dtMUFBMm9ma2tuYmlKQnhqSVZJNWFibXlWSGxP?=
 =?utf-8?B?Q3dpdVNvc1NRbnR6RUJqa0ZNWVpOdEdxanlnVU9ra0czMzlqaG85bHAzcmxX?=
 =?utf-8?B?NlEvUS9tL2VuNGdiV1FQOE9aeXplck9TbHlhRWVJclg3by9aQy9RQlNxa1VB?=
 =?utf-8?B?UmFma1V1U3FxUFFRU1YyZUFLU3B2akozMkpNUlQydnMweDhOSHNjall3L1JK?=
 =?utf-8?B?YjN2Vml5Ly9pYzU1cGZocXJkRDQ1V2xhZ01GdnQxaWVvY0k2L2dHNjY1aFgv?=
 =?utf-8?B?Zll6SUxRRGZicnNNY1NkVWNEd2hZaUZuL2dKcU1Ea3duRXVJTzc3U1RlaHRo?=
 =?utf-8?B?MXk1Sk5oZXhITEQrZjFxNmQ4eDNERm55UEd6SUhoMVh5OGF5SC8wSjFTdkZ2?=
 =?utf-8?B?dFJKR010Z3lhTGo3bXNpamNYQ21vcTFUVzVydzBtL2R2L2hxZWF4ZUltazBx?=
 =?utf-8?B?dTZtcGpldXZ1SitGTEN1ZHhjNFVPWnNNeHZKVHhLdWxLbGVraWxDNmE3OUhl?=
 =?utf-8?B?WGhQMEpXbWNVNW9aTWpTUWh4Z3ovc2ppZjQ5THM0akZpNUQrNGcremNlU2ky?=
 =?utf-8?B?UFFLSVNVSHZsTHRCKzYzaG5XQXgzSjliQWlTWFJSSFRiOGFHTlJNeDJVU0g2?=
 =?utf-8?B?VGp5c1hpT1gyNElhZ0p5VjdLdGV2bTVrZXNta2hyT3hjSFcyQ0JDQWdMZU1p?=
 =?utf-8?B?b0JvOCtBT2lHajJyQTFGLzhYWWVUZXJaZmI5bVQrVXJrMWZXT3ByU0s0SWFZ?=
 =?utf-8?B?aG1zNlRUb3JNUVhQZVEvWE93Y3pvSlBLSjV1Zm9zTlorSjRvdTFRRDBnTXVy?=
 =?utf-8?B?Y0lVb21uZWhUeG1jQVFIOEp4aG4rT1BuT0dpZ1V5Mi9vaUVJVU1GMHBqMEJN?=
 =?utf-8?B?dDZTSnZXUVFmdktKb0RBeTFUdEpBaFVMQzBYbndOdFRISHlmd3FHOXVnbWx5?=
 =?utf-8?B?cTFHNjIwTDZoMHVBRjJ4Vkx5S3kybkRkOWJVM0Z1RWNQMHpqTlhCVGNzQkNk?=
 =?utf-8?B?L3RrdXQ3Ukl4dUFjajEzRTdvZkpORXI3SUgvWWQvM1JvOEE4azNIZGVkQm8v?=
 =?utf-8?B?MUdJckpvSStiL3dEazFBcTlYdUUrWFhua240UWU4WGEwZTN3WFJkWjVhZzND?=
 =?utf-8?B?dUdBRHlwckVMRWdCcllUTWV2OXJtWlFwNmFpeklCZXQxdzl5eFBjMzVWSzdr?=
 =?utf-8?B?UU4zL1czc2QzY0pBRWFMbUtwc293djNTOTVlZHNPbHZGVXlpZ1VhbDdxUm5M?=
 =?utf-8?B?S2lqMWdXYmNXWWtUSXIwajR3WWFqeXpjTFBOSm1ObVU5bDJzYTMzZUVoUmVL?=
 =?utf-8?B?UUtXVVRWMmhiUjRibE9pQ3dxVitIQUk5a09rek82V3FnM3pxOTdxT2xYS0ZS?=
 =?utf-8?B?TVlRdDV6b1duOVVucnNhNDFzSm9zaytUcW9uV1BzV2t1Wkg0UUpuWXAyQktW?=
 =?utf-8?B?aHpUbk1VOHdlS1NacFVrZkpEYlY4ZXA2citkS2p0L3BySzlSMm00S05jNTVa?=
 =?utf-8?B?OVN3WWZORnNxUmRHQlFZRmRTNmNDYWVtUi9yRkpJV21GK0gwUnlQRFo0aUNo?=
 =?utf-8?B?dFZzRnVKeGp3cnQ0WExhOEtsUVlMTUJhK25OUXcvVzBESmFNM1FoK1VPNXI0?=
 =?utf-8?B?OTFrR3A1TWs0UXZsRzBJcnpkMjBIdnNmUFNPN0JtOEtBNmtTckdxNHh6M3Bq?=
 =?utf-8?B?TmZONXE0Zkl4OXo5aExaaEFYRkhMY0Z2R0szS1NSamZVZmFKR3BFVnNmYm9u?=
 =?utf-8?B?M1hUOGlRU3FSOWYwNHNibG1IRXRvMGpZWEZ6SmdlRVVuQjJvWEJEdlYrR2Zn?=
 =?utf-8?Q?pW1uYOJXplrCr0eR+/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ee99b3-6d57-4385-b5c0-08df44ac9066
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:13:25.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz5E6oBwu9W3fALVPfVnBEImF1xtNHkUv/SpTDLMJWlNRAZlMQhEkjz1Ppflb+UB5F6uEx+FQJSMq9rZKBhOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/2026 6:36 PM, Yadav, Sanjay Kumar wrote:
>
> On 17-11-2026 15:27, Matthew Auld wrote:
>> On 17/11/2026 04:57, Arunpravin Paneer Selvam wrote:
>>>
>>>
>>> On 11/15/2026 9:23 PM, Yadav, Sanjay Kumar wrote:
>>>>
>>>> On 09-11-2026 12:10, Arunpravin Paneer Selvam wrote:
>>>>> Hi Sanjay,
>>>>>
>>>>> On 11/2/2026 10:46 AM, Sanjay Yadav wrote:
>>>>>> __alloc_range_bias() walks the buddy tree depth-first, higher 
>>>>>> address
>>>>>> first, and descends every SPLIT block even when nothing below it is
>>>>>> free. Range allocations are placed top-down, so they pack below the
>>>>>> range end and each new one walks every block already allocated 
>>>>>> there:
>>>>>> O(N) per allocation and O(N^2) for N allocations, under the 
>>>>>> allocator
>>>>>> lock.
>>>>>>
>>>>>> Track in each block the largest order of any FREE block in its 
>>>>>> subtree
>>>>>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is 
>>>>>> allocated
>>>>>> or freed, and skip subtrees that cannot satisfy the requested order.
>>>>>> Splitting needs no update of its own, as both children are marked 
>>>>>> free
>>>>>> right after and that propagates the new value up.
>>>>>> gpu_buddy_block_trim() detaches the block before freeing it, so 
>>>>>> updates
>>>>>> stop there while re-allocating inside it; recompute from the parent
>>>>>> once it is reattached.
>>>>>>
>>>>>> Skipped subtrees contain no FREE block of the requested order or
>>>>>> larger, so the old walk could neither split nor return anything 
>>>>>> there.
>>>>>> The remaining blocks are visited in the same order, so the selected
>>>>>> block and placement are unchanged.
>>>>> I am not receiving some of the emails you are. sending me. I think 
>>>>> there may be an issue with my mailbox, so I need to check that on 
>>>>> my side.
>>>>> William has also been working on improving the range-allocation 
>>>>> performance in drm_buddy. His patch is here:
>>>>>
>>>>> https://patchwork.freedesktop.org/patch/763478/
>>>>>
>>>>> Since both patches are trying to improve the same range-allocation 
>>>>> path, I would like to converge on a single upstream approach 
>>>>> rather than carry separate optimizations.
>>>>> I have put together a version based on William’s offset-sorted 
>>>>> free- tree approach, extending the search to be class-aware:
>>>>>
>>>>> https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/ 
>>>>> commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9
>>>>>
>>>>> With this approach, we can remove the buddy-tree DFS walk 
>>>>> entirely. Cleared blocks are located using the existing 
>>>>> subtree_block_state augmentation, and top-down placement comes 
>>>>> directly from the offset- sorted free trees, reducing the lookup 
>>>>> to an O(log n) free-tree search followed by a small bounded scan.
>>>>>
>>>>> @Sanjay, could you take a look at the version above? I think it 
>>>>> would be better to follow this approach upstream and create a 
>>>>> patch with the test cases around it.
>>>> I tested your WIP on our side (applied on current drm-tip, on top of
>>>> the merged two-pass guard).
>>>>
>>>> BMG, CPU-visible BAR resized to 4GB, xe_pat@pt-caching-random-offsets:
>>>>
>>>>   drm-tip                 ~48-51s
>>>>   drm-tip + my v4         ~0.7s
>>>>   drm-tip + your WIP      ~0.75s
>>>>  (drm-tip, full BAR       ~0.7s, range path not used)
>>>> So your version fixes the xe small-BAR case as well as v4 and looks 
>>>> good to me.
>>>> v4(already R-b/T-b by Joel) could go in first as the small fix and 
>>>> your
>>>> series replace the walk on top. Whichever you and Matt prefer.
>>> Okay, please confirm with Matthew. If this is the final version, I 
>>> will merge it upstream.
>>
>> Yeah, ack from my side.
> Thanks Matt for Ack.
> FYI Arun: I need to send one more version just for CI because CI was 
> not run on v4.
Also, rebase on drm-misc-next.
>>
>>>
>>> Regards,
>>> Arun.
>>>>>
>>>>> @William, could you also take a look at the version above? 
>>>>> Hopefully we can follow the same approach when porting this 
>>>>> optimization to the older dual-free-tree branch
>>>>> used by the ROCm versions you are targeting.
>>>>>
>>>>> Thanks,
>>>>>  Arun
>>>>>>
>>>>>> v4: (Matt A)
>>>>>> - Drop the update in mark_split(), the children being marked free
>>>>>>    updates the parent
>>>>>> - Detach the block before __mark_free() in 
>>>>>> gpu_buddy_block_trim(), so
>>>>>>    only the final update from the parent propagates up
>>>>>> - Drop the order, is_allocated() and is_free() checks in
>>>>>>    __alloc_range_bias() that the pruning check now covers
>>>>>>
>>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>>>>>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>>>>>> Assisted-by: LLM
>>>>>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>>>>>> ---
>>>>>>   drivers/gpu/buddy.c       | 56 ++++++++++++++++++++++++++ 
>>>>>> +------------
>>>>>>   include/linux/gpu_buddy.h |  7 +++++
>>>>>>   2 files changed, 46 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>>>>> index 28cff97d57dc..93f70c98b235 100644
>>>>>> --- a/drivers/gpu/buddy.c
>>>>>> +++ b/drivers/gpu/buddy.c
>>>>>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>>>>>> *gpu_block_alloc(struct gpu_buddy *mm,
>>>>>>       block->header = offset;
>>>>>>       block->header |= order;
>>>>>>       block->parent = parent;
>>>>>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>>>>>         RB_CLEAR_NODE(&block->rb);
>>>>>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy 
>>>>>> *mm,
>>>>>>       RB_CLEAR_NODE(&block->rb);
>>>>>>   }
>>>>>>   +static void update_subtree_max_free_order(struct 
>>>>>> gpu_buddy_block *block)
>>>>>> +{
>>>>>> +    while (block) {
>>>>>> +        s8 max_free;
>>>>>> +
>>>>>> +        if (gpu_buddy_block_is_free(block))
>>>>>> +            max_free = gpu_buddy_block_order(block);
>>>>>> +        else if (gpu_buddy_block_is_split(block))
>>>>>> +            max_free = max(block->left->subtree_max_free_order,
>>>>>> + block->right->subtree_max_free_order);
>>>>>> +        else
>>>>>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>>>>>> +
>>>>>> +        if (block->subtree_max_free_order == max_free)
>>>>>> +            break;
>>>>>> +
>>>>>> +        block->subtree_max_free_order = max_free;
>>>>>> +        block = block->parent;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>   static void mark_allocated(struct gpu_buddy *mm,
>>>>>>                  struct gpu_buddy_block *block)
>>>>>>   {
>>>>>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>>>>> mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>>>>>         rbtree_remove(mm, block);
>>>>>> +    update_subtree_max_free_order(block);
>>>>>>   }
>>>>>>     static void __mark_free(struct gpu_buddy *mm,
>>>>>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>>>>> mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>>>>>         rbtree_insert(mm, block);
>>>>>> +    update_subtree_max_free_order(block);
>>>>>>   }
>>>>>>     static void mark_free(struct gpu_buddy *mm,
>>>>>> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>>>>>> size, u64 chunk_size)
>>>>>>         size = round_down(size, chunk_size);
>>>>>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>>>>>> +
>>>>>>       mm->size = size;
>>>>>>       mm->avail = size;
>>>>>>       mm->chunk_size = chunk_size;
>>>>>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>>>             list_del(&block->tmp_link);
>>>>>>   -        if (gpu_buddy_block_order(block) < order)
>>>>>> +        if (block->subtree_max_free_order < (int)order)
>>>>>>               continue;
>>>>>>             block_start = gpu_buddy_block_offset(block);
>>>>>> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>>>           if (!overlaps(start, end, block_start, block_end))
>>>>>>               continue;
>>>>>>   -        if (gpu_buddy_block_is_allocated(block))
>>>>>> -            continue;
>>>>>> -
>>>>>>           if (block_start < start || block_end > end) {
>>>>>>               u64 adjusted_start = max(block_start, start);
>>>>>>               u64 adjusted_end = min(block_end, end);
>>>>>> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>>>                   continue;
>>>>>>           }
>>>>>>   +        /* Not pruned at @order, so this block itself is FREE */
>>>>>>           if (contains(start, end, block_start, block_end) &&
>>>>>> -            order == gpu_buddy_block_order(block)) {
>>>>>> -            /*
>>>>>> -             * Find the free block within the range.
>>>>>> -             */
>>>>>> -            if (gpu_buddy_block_is_free(block))
>>>>>> -                return block;
>>>>>> -
>>>>>> -            continue;
>>>>>> -        }
>>>>>> +            order == gpu_buddy_block_order(block))
>>>>>> +            return block;
>>>>>>             if (!gpu_buddy_block_is_split(block)) {
>>>>>>               err = split_block(mm, block);
>>>>>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy 
>>>>>> *mm,
>>>>>> gpu_buddy_block_offset(block),
>>>>>>                            gpu_buddy_block_size(mm, block));
>>>>>>   -    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>>>>> GPU_BLOCK_DIRTY);
>>>>>> -    mm->avail += gpu_buddy_block_size(mm, block);
>>>>>> -
>>>>>> -    /* Prevent recursively freeing this node */
>>>>>> +    /*
>>>>>> +     * Detach the block to prevent recursively freeing this 
>>>>>> node, and to
>>>>>> +     * keep free-order updates from propagating above it until 
>>>>>> the trim
>>>>>> +     * is done.
>>>>>> +     */
>>>>>>       parent = block->parent;
>>>>>>       block->parent = NULL;
>>>>>>   +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>>>>> GPU_BLOCK_DIRTY);
>>>>>> +    mm->avail += gpu_buddy_block_size(mm, block);
>>>>>> +
>>>>>>       list_add(&block->tmp_link, &dfs);
>>>>>>       err =  __alloc_range(mm, &dfs, new_start, new_size,
>>>>>>                    was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>>>>>> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>>>>       }
>>>>>>         block->parent = parent;
>>>>>> +    update_subtree_max_free_order(parent);
>>>>>>       return err;
>>>>>>   }
>>>>>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>>>>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>>>>> index ddc4eca84175..8037f5a0feb1 100644
>>>>>> --- a/include/linux/gpu_buddy.h
>>>>>> +++ b/include/linux/gpu_buddy.h
>>>>>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>>>>>       unsigned int subtree_max_alignment;
>>>>>>       struct list_head tmp_link;
>>>>>>       bool has_clear;
>>>>>> +    /*
>>>>>> +     * Largest order of any FREE block in this block's buddy 
>>>>>> subtree, or
>>>>>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver 
>>>>>> lock.
>>>>>> +     */
>>>>>> +    s8 subtree_max_free_order;
>>>>>>   };
>>>>>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>>>>>> +
>>>>>>   /* Order-zero must be at least SZ_4K */
>>>>>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>>>>>
>>>
>>

