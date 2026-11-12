Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7B606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hfWc2vQf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AEE10E2E0;
	Thu, 12 Nov 2026 14:45:25 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65410E2E0;
 Thu, 12 Nov 2026 14:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WToMESBOWbJfkFJ93PR/hlkCDnfZb2EHzC/6ONbGFxhyfIdPqGStpNXPAN1KIYXnuZQdpIoLaIoQ7vLS7TxMCXI7Tq3pS/SVMCH1fNdFW8/YbR6mF9hj5zErk47bdokxDmxLwUSezBH+BuJ0lgwDJzI53FafEyAkyq5hc2qLJZ12gvzRvHSPuDKSXkcAmQrCkam42IRv3u+KtygXnny7UoNYzZYoo4j2axnVD3NqRJGgD1MZlvZ24yMITBNEl8AqCcuzk4xVhhz50emdapM4Wwx06gUuRJXbE0LSKNeetbknGui52eV7gBcJ0dpFCwSpLvwaglREKG6ZmLRIuOKv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBmOGyw8ko6mmD67yRH/KG2oh2tCmkQKNOue80ODZiw=;
 b=HArbDDY40xMGnikm1ow1Tr4oiaV3FzDvGDesShsH74MmkzNx2cKI75HKWdEgIoGC4hjh4xmff2A0SujyFCN/7Kw8mvyLQuSWuKrN1EVTIOIXnyv+Q787gYN82EDDRBkEimg5o12T5tADXWHrjWnlHzZ4Ixk8ugbLnuQkWIL6v1VASxGTav7SUcuEHddvTrGVnFzFaZYKuvWMlSfK/Ahu5nGcwczAlRyOc4dv5nIzgTJT1nWtCEwM3IpKlUbKHOzFNrXvfLf9/goHT4WwHybkqFNJMtYjwPycxkwrdpwaiVYDTMWviU9dcg8eVWUNgIQDCz/0OYljOG9bXFrNlDcRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBmOGyw8ko6mmD67yRH/KG2oh2tCmkQKNOue80ODZiw=;
 b=hfWc2vQfYEESA4q6HkrrlQb2BmDFUqW+YLzm2KZllP5nIu8VKcSxTl1nikXlrqzK1kB/raQTheTkbI//yAyAm5LgQg/88uq2BAax9aGIgdKsKq+2fKB8tFObtDYimuojfE3weEqtJ9vnfElWjN8vBMC0xKI2Ud3NJcd9OZJTVoo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:45:15 +0000
Received: from CH0PR12MB5026.namprd12.prod.outlook.com
 ([fe80::a495:f203:dd7a:3e25]) by CH0PR12MB5026.namprd12.prod.outlook.com
 ([fe80::a495:f203:dd7a:3e25%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 14:45:15 +0000
Message-ID: <ab679da6-b5b8-4b0b-8e36-655a9f970542@amd.com>
Date: Thu, 12 Nov 2026 20:15:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: "Palacek, William" <William.Palacek@amd.com>,
 Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Matthew Auld <matthew.auld@intel.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
 <CY8PR12MB7122075A4AE14328B90ECC9DF9732@CY8PR12MB7122.namprd12.prod.outlook.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CY8PR12MB7122075A4AE14328B90ECC9DF9732@CY8PR12MB7122.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::17) To CH0PR12MB5026.namprd12.prod.outlook.com
 (2603:10b6:610:e1::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5026:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: af0fd80d-d8a8-4236-591a-08df40cb8ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|11062099010|261009223027099003|7136999003|13003099007|11063799006|5023799004|4143699003|56012099006|10067099003|261028144727099003|261026140227099003|261102123227099003|261022075727099003|261102130727099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: oOb4N5h9LxS0scglLrZFCXYgSSun69j0KpA614xn0iZlOfY1pLDIo1S2OQFcctZSiWaky16tWrT31Z2LGHWSsgS6/Ksj6Vh14RvPBYwel0Wg33Fad2VPO7zY/yFBGRcXaIiYs4ngmHbg77zjFzPip2XRp/0UlUFiEpBnyLp3T2wghut6544fzm7k9yQpiJKmlI0L5UW9r4UXujqeuN84FtONvVlMcwJCHqk2ltTjUmL3S44iTuE77BMSUEVxY3mlCURKjXKZSqPBaadCm2u5PYZi00T3qu2aAtICnz5we0MQnjLFWls4DS6+eH4sVLj7rN4kaUbaQIGSXZ9vp44FlEGL0uwvnFL5/eIBooIjiOeiN8KLvJ1o2axuI49N49Ao6lZpMWMVlFeVCKlMmQc+/n39Wot/phUeUxjPctMMEfHSXAq6SJ2IjY6e3CVyHOx4odXQYReo/G+Gc6/nxyeTIsu+KYe5vuARPSd6td48GkG1riTqxZ5CfE8KNEQ3GuIg3vPV6+cSoA/+dCvKKpFjMA2eiMJshQI7Bx5qH+7+G1tc3QFUxOL4YiTxjYug4ALnzruvVfMgiPln81qpzK0ow6KyjxbkP1DkBM9FemQMwv20pKslgPI0atptzE0YMWod
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5026.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(11062099010)(261009223027099003)(7136999003)(13003099007)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(261028144727099003)(261026140227099003)(261102123227099003)(261022075727099003)(261102130727099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cml0VlJDNllSZmwyVFBkeDhkc0tCSGxwNDY5ZUhlbis3U25lRU5lTWlIZnRT?=
 =?utf-8?B?dUNmSUtsSmNMMW5tc0llV1M1NWkxMndwYzZjOXJJSHYrMVAxWUNhZHZ0QTho?=
 =?utf-8?B?WnB0U1lYK3ROWXVIb0JOZkZicmUvVTFXUk1IWWFDc3ZWdS9jRi8zQW54VkU4?=
 =?utf-8?B?MXVzdkhaN0F1NjlCZGlPdmpobHZXRjZMdmhIUnhBeTYxN0ZzVUVWMXc0S1ZE?=
 =?utf-8?B?U3ZhQU9sMVN3N0Zib3cxODFjWEtadVI0NkpEbVkveXVJMlZTbnlqVjRJWktt?=
 =?utf-8?B?bXgyMXJyYmswdS9JaHlndXVQdlNoSGZOQjBrMjVWdnJ1Wm9CRzFvYnUzR3RP?=
 =?utf-8?B?cVkyY3dDc3FsSWdDeXl3Z0NPYkNFcG9MWDdDSkZBRUMyUnNvNDhHUDlCN3ND?=
 =?utf-8?B?V2s2TFM5T2NJMDFTOW9WQkhZbXpzN2JqK1kwT0QrMTlrSUxDZXlXdnlqNUZU?=
 =?utf-8?B?ajFEWU1IUk84NFlPYVBvNi9DTHdrMlVEVWl6VkdPQjNZMzBYL1IrcndMbDcy?=
 =?utf-8?B?dlg2dHNvWHRBaVRxM3M4UDV4RW1jaGNEQ05kaGdFd3U1VnB5ekh3VTlXV3FO?=
 =?utf-8?B?QWhtRkNmZWw4c3cxNDduK1IxUEJvcDFLdytiNXVkSVgyVXdZd1V1VzNvNk1n?=
 =?utf-8?B?aGFwMFhtcnNvbzcwL3N4YWNDRlFCd2FKODcwL0E5NWttdlRLRVlML0F5VDk4?=
 =?utf-8?B?ZFloSnIwODI5alY3ZEhsSVlHL214NWZjUnFtV1hBdkQ1eWFqaEhYNFEzUlQw?=
 =?utf-8?B?VktzQlFVL0cvYi9pamY0L3BzcGRBbEhvaDgxOUhSN09ScDBqOFNsMnBGYW43?=
 =?utf-8?B?Tml1MVhEdGpuYkJuMGtvcGdiaUZ1YVo4UzFmOVh6RmMxT2ZlV3prTjNzbCts?=
 =?utf-8?B?UUpzUkgwblFGSFVrS1hqeC9HRHpTMHpUeXFaZUFhNnE5YVNSazJuUGhmYVdv?=
 =?utf-8?B?UHd0Z3gzZnQyNFNhSElHRUllUU04U2diL1V4Ulp5RjNiYmxrOUM2VXpEVThx?=
 =?utf-8?B?bzNOZEhqcU1ocW12VkVJVFhRQ003L0cyY056UWhPRndsb0hwS2paTlhDdFVI?=
 =?utf-8?B?dlVGTkJzVEloVDFVdHhrRWhWS1pWMHowWkhoY2FwKzRZNUxqR1lOb3ZKN0Zy?=
 =?utf-8?B?d2lOT3hTMks0V2dXWm0yV0F6VmhNQU9rMFFuVDBzWVB4SFRrdFQvcHN2UzF2?=
 =?utf-8?B?L1VMZzJoR0lWMHFCUkk1ejFzbHpxV2ladk1Eb1FPeWtpTVFTNysyVXU4RDJY?=
 =?utf-8?B?QjQ0OFZseTNrS2NJRWNkOTdkSFRsTElwenA2Wms5cWw1ZVkxSXlKMXBsWjRJ?=
 =?utf-8?B?MC9VN25uTlB4ZnV0eGlHdHkrQkxJZFdqYlBDdlF6MUlKdVJmaFBneFpXKzNz?=
 =?utf-8?B?ak9JTGlCelpvWUlaRit0V1lYQ20rcmZjb3kyc0VuZ2x4d3FQak1RS2lwNXQy?=
 =?utf-8?B?d3czOFlnanJVVC96NUcycFQza21keGJqZXhBVVNOU0RRQTcrMlRUSjRUdkJq?=
 =?utf-8?B?SExOZ3RHVzRTQWkrSlc2QU92LzZ6U2RPdk9MY1RzMFQ3WEgzS3dOVjZwYWox?=
 =?utf-8?B?QUNudFdRaGhTOTVFOFBvYmdFSFAvZVFOQmtNM0VHbVFQR2xOYURXbHYyZk41?=
 =?utf-8?B?dWFwN3AvaUN3dkloRGo0b0NGTlU0cWVHVWx2dnB6NDRLSmVyQjY4OGkzNjVz?=
 =?utf-8?B?M2N4UWF3cktkWmtmcW1NdzFyaVBiR1VQZHdmcFRrVml4WUtFOHBWVkNudzBq?=
 =?utf-8?B?S1BEUEd0ek8vOXJpU1hxWVk1ODlDYUFQYzMydWhkR2tBd1ZKYjhudG5MZThM?=
 =?utf-8?B?NTBoTU9jNWNJMnJINnNFRVZibXpiQ09wQnIzbkpkQ1B5QVpNamFuYUhMOW5s?=
 =?utf-8?B?aDBOZFgrRXRhSWZTejZWUGRTOGE4ZlR2TXpLOWRlcW1yWDYranJnOWxmeEpk?=
 =?utf-8?B?SWpsMjVFaThTeSttWDM5M3hLVlVGY0VOalNCTVBjK0dMRitwSVNNTzZXaVFK?=
 =?utf-8?B?dzNlMzE3MW0wbkFMck82S3RkY1I0OGdzajNyWFhwZ0xRTWk5VGF6YVdocy82?=
 =?utf-8?B?R2F6aCtlY1FsZDVqcXJVNlJmR2hGMGJTYmtMaTZRaEl6OEZJV1dkQjFlMWox?=
 =?utf-8?B?Z1VBOUJTc2t3YURZUll4NmQ0MVJDNjBLRXdYclVCMXhlNXBWSCt5MTlDTUdV?=
 =?utf-8?B?MllkdnVzbU1idlBrek4yZmdiUFo1ckp5eDl2YjhnTVVtaFRtZXpLdStheUtV?=
 =?utf-8?B?SnZKS2FBQUFBMUdhNGNEWC92d2tjZ2dseU1WcTY4UFlTcldQbHpuUEhoQ3hP?=
 =?utf-8?Q?a1NYRAviWEtaM8exWs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0fd80d-d8a8-4236-591a-08df40cb8ff5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5026.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:45:15.0557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE+WfApxtie17f3A7zuvVaAEhvrXLBXRZotxTzWGDyomz07ATqVOVQQeL2YnyXQ+7ibTsm5xG2yGf7WtPI/tNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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

Hi Matthew,

Do you have any thoughts or concerns with this approach?

@William - I submitted the fix separately. I have already folded your 
lookup approach into the guard here:
https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9

If there are no concerns from Matthew, could you take a look and please 
go ahead with the patch creation?

Regards,
Arun.

On 11/9/2026 7:37 PM, Palacek, William wrote:
> AMD General
>
> Hi Arun,
>
> Thanks for putting this together. I applied it on drm-misc-next (6f7098738fff) and ran the gpu_buddy KUnit suite: all 16 pass, including the range_bias_performance test from my v2 (2 ms). Your clear_guard test fails without the patch and passes with it, so the regression coverage looks good.
>
> I tried one more pattern: 4 GiB manager, range [1G, 2G) filled with 64K blocks, then every other block freed as cleared (8192 free cleared blocks interleaved with allocated ones).
>
> - 4096 cleared, non-top-down allocations (amdgpu does this for CPU-visible VRAM): stock 117 ms, your patch 142 ms, v2 0 ms. rbtree_range_best_block() scores every matching free block in the window before picking one, so it is linear in the number of free cleared blocks.
> - 4096 dirty, top-down allocations into the same range: stock 120 ms, your patch 91 ms, v2 0 ms. The strict pass walks past every incompatible free block with rb_prev() before falling back.
>
> v2 doesn't have this problem, but it also doesn't keep cleared and dirty apart the way your guard does. Would it make sense to split this into two patches, the clear/dirty guard first (with the Fixes tag) and then the lookup on top? Then I could rebase v2 onto the guard, or you could fold the lookup into yours, whichever you prefer.
>
> Thanks,
> William
>
> -----Original Message-----
> From: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> Sent: Monday, November 9, 2026 1:41 AM
> To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>; dri-devel@lists.freedesktop.org; Palacek, William <William.Palacek@amd.com>
> Cc: intel-xe@lists.freedesktop.org; Matthew Auld <matthew.auld@intel.com>; Joel Fernandes <joelagnelf@nvidia.com>
> Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in range-biased allocation
>
> Hi Sanjay,
>
> On 11/2/2026 10:46 AM, Sanjay Yadav wrote:
>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>> first, and descends every SPLIT block even when nothing below it is
>> free. Range allocations are placed top-down, so they pack below the
>> range end and each new one walks every block already allocated there:
>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>> lock.
>>
>> Track in each block the largest order of any FREE block in its subtree
>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
>> or freed, and skip subtrees that cannot satisfy the requested order.
>> Splitting needs no update of its own, as both children are marked free
>> right after and that propagates the new value up.
>> gpu_buddy_block_trim() detaches the block before freeing it, so
>> updates stop there while re-allocating inside it; recompute from the
>> parent once it is reattached.
>>
>> Skipped subtrees contain no FREE block of the requested order or
>> larger, so the old walk could neither split nor return anything there.
>> The remaining blocks are visited in the same order, so the selected
>> block and placement are unchanged.
> I am not receiving some of the emails you are. sending me. I think there may be an issue with my mailbox, so I need to check that on my side.
> William has also been working on improving the range-allocation performance in drm_buddy. His patch is here:
>
> https://patchwork.freedesktop.org/patch/763478/
>
> Since both patches are trying to improve the same range-allocation path, I would like to converge on a single upstream approach rather than carry separate optimizations.
> I have put together a version based on William’s offset-sorted free-tree approach, extending the search to be class-aware:
>
> https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9
>
> With this approach, we can remove the buddy-tree DFS walk entirely.
> Cleared blocks are located using the existing subtree_block_state augmentation, and top-down placement comes directly from the offset-sorted free trees, reducing the lookup to an O(log n) free-tree search followed by a small bounded scan.
>
> @Sanjay, could you take a look at the version above? I think it would be better to follow this approach upstream and create a patch with the test cases around it.
>
> @William, could you also take a look at the version above? Hopefully we can follow the same approach when porting this optimization to the older dual-free-tree branch used by the ROCm versions you are targeting.
>
> Thanks,
>    Arun
>> v4: (Matt A)
>> - Drop the update in mark_split(), the children being marked free
>>     updates the parent
>> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>>     only the final update from the parent propagates up
>> - Drop the order, is_allocated() and is_free() checks in
>>     __alloc_range_bias() that the pruning check now covers
>>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Assisted-by: LLM
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>    drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
>>    include/linux/gpu_buddy.h |  7 +++++
>>    2 files changed, 46 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c index
>> 28cff97d57dc..93f70c98b235 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>>        block->header = offset;
>>        block->header |= order;
>>        block->parent = parent;
>> +     block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>
>>        RB_CLEAR_NODE(&block->rb);
>>
>> @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>        RB_CLEAR_NODE(&block->rb);
>>    }
>>
>> +static void update_subtree_max_free_order(struct gpu_buddy_block
>> +*block) {
>> +     while (block) {
>> +             s8 max_free;
>> +
>> +             if (gpu_buddy_block_is_free(block))
>> +                     max_free = gpu_buddy_block_order(block);
>> +             else if (gpu_buddy_block_is_split(block))
>> +                     max_free = max(block->left->subtree_max_free_order,
>> +                                    block->right->subtree_max_free_order);
>> +             else
>> +                     max_free = GPU_BUDDY_NO_FREE_ORDER;
>> +
>> +             if (block->subtree_max_free_order == max_free)
>> +                     break;
>> +
>> +             block->subtree_max_free_order = max_free;
>> +             block = block->parent;
>> +     }
>> +}
>> +
>>    static void mark_allocated(struct gpu_buddy *mm,
>>                           struct gpu_buddy_block *block)
>>    {
>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>        mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>
>>        rbtree_remove(mm, block);
>> +     update_subtree_max_free_order(block);
>>    }
>>
>>    static void __mark_free(struct gpu_buddy *mm, @@ -750,6 +773,7 @@
>> static void __mark_free(struct gpu_buddy *mm,
>>        mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>
>>        rbtree_insert(mm, block);
>> +     update_subtree_max_free_order(block);
>>    }
>>
>>    static void mark_free(struct gpu_buddy *mm, @@ -869,6 +893,8 @@ int
>> gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>>
>>        size = round_down(size, chunk_size);
>>
>> +     BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>> +
>>        mm->size = size;
>>        mm->avail = size;
>>        mm->chunk_size = chunk_size;
>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>
>>                list_del(&block->tmp_link);
>>
>> -             if (gpu_buddy_block_order(block) < order)
>> +             if (block->subtree_max_free_order < (int)order)
>>                        continue;
>>
>>                block_start = gpu_buddy_block_offset(block); @@ -1286,9 +1312,6 @@
>> __alloc_range_bias(struct gpu_buddy *mm,
>>                if (!overlaps(start, end, block_start, block_end))
>>                        continue;
>>
>> -             if (gpu_buddy_block_is_allocated(block))
>> -                     continue;
>> -
>>                if (block_start < start || block_end > end) {
>>                        u64 adjusted_start = max(block_start, start);
>>                        u64 adjusted_end = min(block_end, end); @@ -1298,16 +1321,10 @@
>> __alloc_range_bias(struct gpu_buddy *mm,
>>                                continue;
>>                }
>>
>> +             /* Not pruned at @order, so this block itself is FREE */
>>                if (contains(start, end, block_start, block_end) &&
>> -                 order == gpu_buddy_block_order(block)) {
>> -                     /*
>> -                      * Find the free block within the range.
>> -                      */
>> -                     if (gpu_buddy_block_is_free(block))
>> -                             return block;
>> -
>> -                     continue;
>> -             }
>> +                 order == gpu_buddy_block_order(block))
>> +                     return block;
>>
>>                if (!gpu_buddy_block_is_split(block)) {
>>                        err = split_block(mm, block);
>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>                                             gpu_buddy_block_offset(block),
>>                                             gpu_buddy_block_size(mm, block));
>>
>> -     __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
>> -     mm->avail += gpu_buddy_block_size(mm, block);
>> -
>> -     /* Prevent recursively freeing this node */
>> +     /*
>> +      * Detach the block to prevent recursively freeing this node, and to
>> +      * keep free-order updates from propagating above it until the trim
>> +      * is done.
>> +      */
>>        parent = block->parent;
>>        block->parent = NULL;
>>
>> +     __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
>> +     mm->avail += gpu_buddy_block_size(mm, block);
>> +
>>        list_add(&block->tmp_link, &dfs);
>>        err =  __alloc_range(mm, &dfs, new_start, new_size,
>>                             was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0, @@ -1881,6
>> +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>        }
>>
>>        block->parent = parent;
>> +     update_subtree_max_free_order(parent);
>>        return err;
>>    }
>>    EXPORT_SYMBOL(gpu_buddy_block_trim);
>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>> index ddc4eca84175..8037f5a0feb1 100644
>> --- a/include/linux/gpu_buddy.h
>> +++ b/include/linux/gpu_buddy.h
>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>        unsigned int subtree_max_alignment;
>>        struct list_head tmp_link;
>>        bool has_clear;
>> +     /*
>> +      * Largest order of any FREE block in this block's buddy subtree, or
>> +      * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>> +      */
>> +     s8 subtree_max_free_order;
>>    };
>>
>> +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>> +
>>    /* Order-zero must be at least SZ_4K */
>>    #define GPU_BUDDY_MAX_ORDER (63 - 12)
>>

