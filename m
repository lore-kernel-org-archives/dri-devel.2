Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C6606A332
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Dx6njUn0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A7810E436;
	Tue, 17 Nov 2026 04:57:47 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9B110E4B0;
 Tue, 17 Nov 2026 04:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo3O+L2basSR0ZdrXHauSsl+MpxpzW0rhQtokVBmlc7lKkry+DeWoYRlU3/oP0QY8xF/MDf8uU1NRh14iW6iMszF9+lFCNUAF0MB9Eni4un1QvTFbnTBRcazxf5LGBOCCTP0fgXTL+bBiFgJvWmYn/k/sQqAeZQmkxX2aVsUtDAyTC8OzOl9NpfxayozQYbRg+vR84QFC+Wo+v5iiTvf5WbE1B8iDKScAEuAQ/aXOJO/qeA7QQmWLiMXIZm4qjiWAkr26vjTR8uU18xcaVFbgXoR1FsZmmv1tZYQp/3PtUAVxtUdFPp9zxOmC3pwyRgn1UKM3dSigb+8nVBVc8m2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAjcLX0gzc9IzooIs4+vELEJUBnDev/ZvXu+TXP7xbI=;
 b=ZnIQ6cNOHdEIQL8/W1TnEv0BNLb4BzUxq/xbaMviFL83WPycGmCtVaAYe0Z6g8I4geO4BOKgQ9T57BI08Qx4ZKNZZ1x1wiIGDDV6O0uayI9vo8JvzgIVo7KnaruuSltRfu2Ne+NwnIcAJh+kehOeeIX+W3EWgGdnb+Aza7QneRLcpOHfpZb9zvAMf0MPFw91tvF8OhodHnMP81NF42OkzeQ7r3IfYbqxXfGC3IuZkPYHBmi3dYMZiUSqtbWUhiVRT9hRo+Pyv5MErfRDmXalddAn4xAxqt64SsR+NsntoQf5RbjLeeZV5ZpgNlMgf81JQH30aMBwmuTFf+8gUsnN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAjcLX0gzc9IzooIs4+vELEJUBnDev/ZvXu+TXP7xbI=;
 b=Dx6njUn0SzisBggA729P3KlhIgL6RSeNzvNbB8fVvoZ4OlcLLgSOSfKlJ1l7F8KOn55VEdjXTitDqaGSrB8PIxs6wpd9ascaruqtjVAtpz/sq4XqdpydtAHdAGDgU+DYUe48hokGyNtElAB4MmwWiqJr0ccoihFtBC1CMWf3nuM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 04:57:36 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 04:57:35 +0000
Message-ID: <3d156a96-ca2d-479b-b6af-d31b862b9467@amd.com>
Date: Tue, 17 Nov 2026 10:27:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>,
 dri-devel@lists.freedesktop.org, William Palacek <William.Palacek@amd.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
 <91f03c24-2bee-4872-bf09-ca54f81ccf50@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <91f03c24-2bee-4872-bf09-ca54f81ccf50@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0291.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::18) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc8c2ba-fb9a-4869-0141-08df44674be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|5023799004|56012099006|4143699003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261102130727099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|7136999003|22082099003|11062099010|18002099003;
X-Microsoft-Antispam-Message-Info: T+lXMmOXVK/wzldgnXkVKLTdc/lHDUPFpLG6bn9jg+5l9xFiOC/pgiKu0PNgYgI6/YBMqzAH7MWDhT38azGzwoCevELWq5iOiokr7HGc4iPkNKAuTUC85PyMQwLJ6GwIcIEjtaTRaTfpyP4PqL5KaTiftZWJZgzcAeqPKuz3RFSS3N5nFVy7o/ivWFKn4hiZ0+/lj+AERAMnXapFbmFLEaYNNZCbaogzwO5nCKLLWg/gj/WHkTt3IpyerAEaZE/JAyvmQGIE/BVGyce0PL7OPsSW7yREy4CkWiMTD+JG+c1n6GA/eNYejBhinKY1vu0wzoKrqeW7jPy7kw4sL+ZkzsuUQHK3DZg0IxZaUrrLrJiJ2v/NWe3xYCXdULofl6lUriNIljMkGlHMhnyqKUL+glvn0Vd8XQxEw8kd0X1n1B7uwi46e9dpS1f5z4D+Wse155c+c2yf24SSskU8wxEIYLm8fNCZ9LxVU0gh/DhGzQrDnvPFmhzDkeBRYusAqd5hS6PE9HACRdoqj9B695LF9uV3mAaJa+Znn3A7yGe46ldKuJG2+sp1a0Ttls6R7mwyjJc0lR81X0WTOZOhjDeIfTpbq0qi0xorw1hgNGbw+KGUby4e4qLBJOLvonNVJDtu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261102130727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(7136999003)(22082099003)(11062099010)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZtRFkyblZFSU1Ya0lHWm40YUR6OWdBOVNMK0hMYktPKzd2WExXK0FzR1JY?=
 =?utf-8?B?Y2hMMEtoWDVXamVTdGFFb2pXMktrU3ZRYjVtYi9GbDM4cytGd21qZ2t0ZnNW?=
 =?utf-8?B?UHhBVTJuejhSZ2FYYXJ2bzNGbWRrREpzOEZyd0tTR1RxazNYY3dvZkZxZjNY?=
 =?utf-8?B?WXZVK0NpYVFieUJGTlJ6b3pjSG9pV3NMVGQrdUZIc1BkWXlmVXhaUFRuQjgz?=
 =?utf-8?B?dXhYRk9Cem9LZmxiMVJ3NW11ZXk0eERoNHRBL0w0VGNJYksvUXhrVUlhYWs3?=
 =?utf-8?B?NDhvdzQ1WXhreHc0Ync4OUhqRytEMHZTVWh1YW11eEN2ejVTbWRvaGdwZG9F?=
 =?utf-8?B?UU5FUE1YRFhRbkFkL0RiUmxRWlNRM0xjdE0va3BES3N4YmZCNVRIbThyRzEy?=
 =?utf-8?B?ZFVYNUhsSmtNVEpBZ1Q3VGNJdS9qVy9pdFl2dUdQZnZyUUd1VlFHNEUwMlpD?=
 =?utf-8?B?Rkcrc3l3am9CNW9vd1o3QnN4TmNCUWQ2dmNiUG16dUtTcVV1cnBjSUduWEZO?=
 =?utf-8?B?M1N6elJOeGFQcHdYUE9IaDNGK054eVhIOTNxb3k4WkliSG5FOHIvaWVOYU9V?=
 =?utf-8?B?cHhNODRIaHRoSCtNYlJQc2p1Z0ZhSlVORWxuWkc0djRYOWtxU01jdE55dDZl?=
 =?utf-8?B?TmFPRHd5OC9KT1dmdzV1UkF5Qit4Y1RnancyNTVueDBpQVM0a3ZJUVZ0RkFw?=
 =?utf-8?B?Y3VtS2JJRGhoUk5XclFPKzI3MVA2dDZrODhERDVmais3ZWxtWk5hUmE5ZHVo?=
 =?utf-8?B?ZW5NeU1wWU9PSHhQSTZrVVU4MjFQa0ozSnpIbWRtakNsci8xMzJDNEU4TFVk?=
 =?utf-8?B?UEEvZ3lFcHAwRi9TMktoUlgvS2lqbHlOc1NIZCtsaEN5QWFheDNNSS9wWDlP?=
 =?utf-8?B?bWZBbC8wby9adDFDc1dvUnZ1MG01ZkhvL0hlWE5nQi81T2VzUEkwdFJVRjVP?=
 =?utf-8?B?QnAwOUdmMU94aEJTMmI3WEREV3RtYnpEYWkzTXNucUpHeFlHejRxdFBzbDRr?=
 =?utf-8?B?QjdtbDdNZWFHN2wwbEl5V3pISEVUQ09uZldBSXFNZnZGeXJxNjhJU1pCb0RC?=
 =?utf-8?B?b2tnbTFKalJNallFRUJPTjZRbzc4aWdqVmNaYStwNFBuUWF5S1kvSURvYWtH?=
 =?utf-8?B?V0h5d05vU1BsUjBFclBvUHhQMzNac3hteEZ6WFhDOGhsUTg0NDFtenZoeWVl?=
 =?utf-8?B?dkFRME5UNlNNSGt3N0RxTklGSE1nRDVmak9BYmE0dzRXNWdHZm1iRlB6U1pm?=
 =?utf-8?B?N0ZKYldxa3F2bW5DeWxWOENNWWh5b2lRclNjYjgzaGNHQzZFMWxRRFpqZFVP?=
 =?utf-8?B?RVU2Umt5MTdCRnFQOVNVWEJ6dlN4ZU5JQ2F0eFc0ZTBVK1R6R1p2dnBJcmp6?=
 =?utf-8?B?T203ZjVYOExsU2ZrTUlIQlFHRFFpbnQ2YmVEVG1uTm1kNnJUcFFXRlBHblFi?=
 =?utf-8?B?UnV1eDV6SmNQbGVvWmo4VXQ2MzhycmpXOXVxTWpnbnFuMnMwRFE2RlV2RGs0?=
 =?utf-8?B?RGJmZVdHd1BlUGxlTTl4SWpNMit2TzgzVFZURkRuZDF1SXR2WmxaR0RMUVRB?=
 =?utf-8?B?TTNyc3pGRFhmaDVOdCtwa3hIMkRCV0RWTTFEZ3BTWlYxY2txVzRTMzZLK2t6?=
 =?utf-8?B?eHQxSGg2bDBKVVlyS2ZrNC9kejFoVzhwNHYrWCtuYndZdmtEMDIzWXlwNk9R?=
 =?utf-8?B?TStCUUhtcTZIY0Q0NHNtVEg0amd4VS9hRnhLTW1GTWpDVzF5VTVCVlplYXVY?=
 =?utf-8?B?ZzR1cFg3VUM5WVo3bVI4Y3MrSEtMNUEwcGxHVHoybFpFS3V3dE9rUkFlRGlT?=
 =?utf-8?B?MUtPdEZTN01QSUF1QkFQMzVKSG9JZHJjZGZ4eUdjNFV4NitOS1d1QWpobEg3?=
 =?utf-8?B?b0gyK0RjR29CSXZITDVqVEYvanpUUWRyai9xZTA1dTJiQjFHL3hzOVZpWE05?=
 =?utf-8?B?cTRScmdycDNFdnhEN1F4LzFIbXp5ZHg1UGpCNnpTTTloNFprWnlMQUtkR2FB?=
 =?utf-8?B?SzM0dlpKSHEzZ3MzRXBuWkpDUDZ3eHZCaXZHM1FCUk85WHN4S1JlU0FrZDJ6?=
 =?utf-8?B?S1JZT2pjWTNtVnRSYmVlZ25TUlNpREp4WVBuK0RqWWc5bm85YkVZNnBhWUtZ?=
 =?utf-8?B?a1VPeHFjd3dIUm0xRmVheEhzYmtBcFpPekpSVmRKMUU1U1ZJRWxCNW5wWUVU?=
 =?utf-8?B?Qm9SNkQrcmZJeTRuWEZCbU9DbXNkbU9uR0xGL1NwSVoyVFlkV1dwSkxpYU13?=
 =?utf-8?B?dnl0bnBOTG96L05qeTcrTG1TNnBuTVBZR1lOWWpTSURvcGtsY1FHYis4SU9Q?=
 =?utf-8?Q?NwsRPNAx+LiVJa9zbR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc8c2ba-fb9a-4869-0141-08df44674be6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 04:57:35.9161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M87wwP7IdemKIYZfUJh4ABQwyIWacD40khjF5RakJoCJX68MP5yV5Ghj3XKE7ulRqi0mD+ipfq8+qgnOtI/mQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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



On 11/15/2026 9:23 PM, Yadav, Sanjay Kumar wrote:
>
> On 09-11-2026 12:10, Arunpravin Paneer Selvam wrote:
>> Hi Sanjay,
>>
>> On 11/2/2026 10:46 AM, Sanjay Yadav wrote:
>>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>>> first, and descends every SPLIT block even when nothing below it is
>>> free. Range allocations are placed top-down, so they pack below the
>>> range end and each new one walks every block already allocated there:
>>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>>> lock.
>>>
>>> Track in each block the largest order of any FREE block in its subtree
>>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
>>> or freed, and skip subtrees that cannot satisfy the requested order.
>>> Splitting needs no update of its own, as both children are marked free
>>> right after and that propagates the new value up.
>>> gpu_buddy_block_trim() detaches the block before freeing it, so updates
>>> stop there while re-allocating inside it; recompute from the parent
>>> once it is reattached.
>>>
>>> Skipped subtrees contain no FREE block of the requested order or
>>> larger, so the old walk could neither split nor return anything there.
>>> The remaining blocks are visited in the same order, so the selected
>>> block and placement are unchanged.
>> I am not receiving some of the emails you are. sending me. I think 
>> there may be an issue with my mailbox, so I need to check that on my 
>> side.
>> William has also been working on improving the range-allocation 
>> performance in drm_buddy. His patch is here:
>>
>> https://patchwork.freedesktop.org/patch/763478/
>>
>> Since both patches are trying to improve the same range-allocation 
>> path, I would like to converge on a single upstream approach rather 
>> than carry separate optimizations.
>> I have put together a version based on William’s offset-sorted 
>> free-tree approach, extending the search to be class-aware:
>>
>> https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9 
>>
>>
>> With this approach, we can remove the buddy-tree DFS walk entirely. 
>> Cleared blocks are located using the existing subtree_block_state 
>> augmentation, and top-down placement comes directly from the 
>> offset-sorted free trees, reducing the lookup to an O(log n) 
>> free-tree search followed by a small bounded scan.
>>
>> @Sanjay, could you take a look at the version above? I think it would 
>> be better to follow this approach upstream and create a patch with 
>> the test cases around it.
> I tested your WIP on our side (applied on current drm-tip, on top of
> the merged two-pass guard).
>
> BMG, CPU-visible BAR resized to 4GB, xe_pat@pt-caching-random-offsets:
>
>   drm-tip                 ~48-51s
>   drm-tip + my v4         ~0.7s
>   drm-tip + your WIP      ~0.75s
>  (drm-tip, full BAR       ~0.7s, range path not used)
> So your version fixes the xe small-BAR case as well as v4 and looks 
> good to me.
> v4(already R-b/T-b by Joel) could go in first as the small fix and your
> series replace the walk on top. Whichever you and Matt prefer.
Okay, please confirm with Matthew. If this is the final version, I will 
merge it upstream.

Regards,
Arun.
>>
>> @William, could you also take a look at the version above? Hopefully 
>> we can follow the same approach when porting this optimization to the 
>> older dual-free-tree branch
>> used by the ROCm versions you are targeting.
>>
>> Thanks,
>>  Arun
>>>
>>> v4: (Matt A)
>>> - Drop the update in mark_split(), the children being marked free
>>>    updates the parent
>>> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>>>    only the final update from the parent propagates up
>>> - Drop the order, is_allocated() and is_free() checks in
>>>    __alloc_range_bias() that the pruning check now covers
>>>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>>> Assisted-by: LLM
>>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>>> ---
>>>   drivers/gpu/buddy.c       | 56 
>>> +++++++++++++++++++++++++++------------
>>>   include/linux/gpu_buddy.h |  7 +++++
>>>   2 files changed, 46 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index 28cff97d57dc..93f70c98b235 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>>> *gpu_block_alloc(struct gpu_buddy *mm,
>>>       block->header = offset;
>>>       block->header |= order;
>>>       block->parent = parent;
>>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>>         RB_CLEAR_NODE(&block->rb);
>>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>>       RB_CLEAR_NODE(&block->rb);
>>>   }
>>>   +static void update_subtree_max_free_order(struct gpu_buddy_block 
>>> *block)
>>> +{
>>> +    while (block) {
>>> +        s8 max_free;
>>> +
>>> +        if (gpu_buddy_block_is_free(block))
>>> +            max_free = gpu_buddy_block_order(block);
>>> +        else if (gpu_buddy_block_is_split(block))
>>> +            max_free = max(block->left->subtree_max_free_order,
>>> + block->right->subtree_max_free_order);
>>> +        else
>>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>>> +
>>> +        if (block->subtree_max_free_order == max_free)
>>> +            break;
>>> +
>>> +        block->subtree_max_free_order = max_free;
>>> +        block = block->parent;
>>> +    }
>>> +}
>>> +
>>>   static void mark_allocated(struct gpu_buddy *mm,
>>>                  struct gpu_buddy_block *block)
>>>   {
>>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>>       mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>>         rbtree_remove(mm, block);
>>> +    update_subtree_max_free_order(block);
>>>   }
>>>     static void __mark_free(struct gpu_buddy *mm,
>>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>>         rbtree_insert(mm, block);
>>> +    update_subtree_max_free_order(block);
>>>   }
>>>     static void mark_free(struct gpu_buddy *mm,
>>> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>>> size, u64 chunk_size)
>>>         size = round_down(size, chunk_size);
>>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>>> +
>>>       mm->size = size;
>>>       mm->avail = size;
>>>       mm->chunk_size = chunk_size;
>>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>             list_del(&block->tmp_link);
>>>   -        if (gpu_buddy_block_order(block) < order)
>>> +        if (block->subtree_max_free_order < (int)order)
>>>               continue;
>>>             block_start = gpu_buddy_block_offset(block);
>>> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>           if (!overlaps(start, end, block_start, block_end))
>>>               continue;
>>>   -        if (gpu_buddy_block_is_allocated(block))
>>> -            continue;
>>> -
>>>           if (block_start < start || block_end > end) {
>>>               u64 adjusted_start = max(block_start, start);
>>>               u64 adjusted_end = min(block_end, end);
>>> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   continue;
>>>           }
>>>   +        /* Not pruned at @order, so this block itself is FREE */
>>>           if (contains(start, end, block_start, block_end) &&
>>> -            order == gpu_buddy_block_order(block)) {
>>> -            /*
>>> -             * Find the free block within the range.
>>> -             */
>>> -            if (gpu_buddy_block_is_free(block))
>>> -                return block;
>>> -
>>> -            continue;
>>> -        }
>>> +            order == gpu_buddy_block_order(block))
>>> +            return block;
>>>             if (!gpu_buddy_block_is_split(block)) {
>>>               err = split_block(mm, block);
>>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>                            gpu_buddy_block_offset(block),
>>>                            gpu_buddy_block_size(mm, block));
>>>   -    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>> GPU_BLOCK_DIRTY);
>>> -    mm->avail += gpu_buddy_block_size(mm, block);
>>> -
>>> -    /* Prevent recursively freeing this node */
>>> +    /*
>>> +     * Detach the block to prevent recursively freeing this node, 
>>> and to
>>> +     * keep free-order updates from propagating above it until the 
>>> trim
>>> +     * is done.
>>> +     */
>>>       parent = block->parent;
>>>       block->parent = NULL;
>>>   +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>> GPU_BLOCK_DIRTY);
>>> +    mm->avail += gpu_buddy_block_size(mm, block);
>>> +
>>>       list_add(&block->tmp_link, &dfs);
>>>       err =  __alloc_range(mm, &dfs, new_start, new_size,
>>>                    was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>>> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>       }
>>>         block->parent = parent;
>>> +    update_subtree_max_free_order(parent);
>>>       return err;
>>>   }
>>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>> index ddc4eca84175..8037f5a0feb1 100644
>>> --- a/include/linux/gpu_buddy.h
>>> +++ b/include/linux/gpu_buddy.h
>>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>>       unsigned int subtree_max_alignment;
>>>       struct list_head tmp_link;
>>>       bool has_clear;
>>> +    /*
>>> +     * Largest order of any FREE block in this block's buddy 
>>> subtree, or
>>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>>> +     */
>>> +    s8 subtree_max_free_order;
>>>   };
>>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>>> +
>>>   /* Order-zero must be at least SZ_4K */
>>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>>

