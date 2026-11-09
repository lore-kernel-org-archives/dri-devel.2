Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6C606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y/P4b37e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9286110E6A1;
	Mon,  9 Nov 2026 06:41:13 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CCC10E680;
 Mon,  9 Nov 2026 06:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZSsN8bWlZu/D+AzYBRfVlyBIHyxEV9/mmE/VLPhweJ3tXEhQoJdGxZJXF1dz6hK8iEeJKiBYTB8l7lB5cUPBNHrDZcotcoyRCkZ3t9d0vE4XxiXNyfEqSUbPqMpwEOKDNaFovFjEuHf8O2baEZSQr2Z6+7BMG5nsd9D4hSyGd3WY6NSV+2S5mpTG0SEf09xbOa61AU5zykfK/EO6wt6K+8PDS9I+L/0/VmV+jCdgwEjbfW4Vz6HaIH7YFYHGRMu1Ctedux9OJlcjZzlotmUIsf//0nG7mhIA82tU/+ofz25s5ApkVnjwE+IYA4vgmN6MO9sn95AlsSVCXBn+mST0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW5fgzL3TdtSArO1Vdu30HgF8DCJ3MF1SLMAxa0u5vE=;
 b=eynhEv/kHddiSFxvUQQo5/Qss0tr9Z5sxWfbF3u8UHVIxsVMt96oIEOk4NNRm+YvC2/qzdmlVqjR0ZUHzZshiEmcPEtoqFsPDj7JJOwpqMSrVJYLs/nQb7vioP/UbKOnoSxAoaCGXDAp8gdnivynHGAMYta0L1QnOM537jIAa8F9a14CWx2iKc0BItXT45oirNFE0SSbX3j6ptj1RLA8tZ+bPQgoNqVzp02tO/0FGi50mohj17YVZf9jLyz3DFtw/e1BI71FVHxhpunckX0qxew20eqZbIWPuT+hzgDUOBP2QRlrHizRDPyg9dwwOBitvYwoPbjggbb/gTumpFxgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW5fgzL3TdtSArO1Vdu30HgF8DCJ3MF1SLMAxa0u5vE=;
 b=y/P4b37e/s2vSUr+sKxjeykhbQxTou05bSyUkIDUUKSI6Ha+l9s3QYncaw8io9iedsUD0sySmRIurrdMmJgeP9qdE466eaM6aC0Ud3feUGByitXVr70BYTEnYBswvdOYWeMBlnKZmTR4RdrmrukLVOepLHc32M7DnI3qely+hh8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 06:41:04 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 06:41:03 +0000
Message-ID: <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
Date: Mon, 9 Nov 2026 12:10:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 dri-devel@lists.freedesktop.org, William Palacek <William.Palacek@amd.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0209.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::6) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a8d22f-47e7-45bc-5eef-08df3e2c6c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|11062099010|22082099003|7136999003|10067099003|4143699003|11063799006|5023799004|261028144727099003|261026121527099003|261102130727099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: yVU8fXHM2iv+XluRg0FlIGWLEdTIfaqf4yP1UcT3vYWpq3Le/HUEe49nPtC/ZjzG0k/Fa6lBFD/9qGlqtev1QOPLL0+PUjuWL4pPgT/l4P0XoRdCF/JNkclUNMypwrblA5EhByDGvRHy3qVtSBnEoiF4FP+iCHKum2lnZx+bw+kZ8lW6JRHwzxM1REsLceSS4oxMbx+MK+i4/YQaOMIT6zu/4qzmDXTQISId8AfuEKSMKrsPXxkHcGlAFtembCzCjAJaRh/1n4zfzVqwTDfiMCZ2Xvnx12GW/vHTc33O4gHjuSliQQ0vAJ/HMk0O3XIDMo13xOKAYyNFvHL5pSec/aUuhS2Y8XQGwLmA/labwFeChRETJV3wexymoyKRwVVc/Iut0YvKzX0VErCkq3oODjOe5W+gyCg72NLAk1k60rLoTLtMD3Kq+HOBd+lkGLZdMxGu8A1ykbYN/83CaJFo4wc1/tdFiP1D+hBHgNu0d4S8nh0QoWly0qyHghLoTLpSgKX/Y6nlmH4KEQgQuWcjs43CH1GiKUNL11jdRrEwbGQkG4SAcHp0aUnq5rDteBgyrJ2YiXhi/7rNonfTQ8lnkZXygWau2xJhHsyELpkRRSkbz+R8YPgAP9As8W4TTIFw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(11062099010)(22082099003)(7136999003)(10067099003)(4143699003)(11063799006)(5023799004)(261028144727099003)(261026121527099003)(261102130727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29LTDNCcnJ4dWVHaHhoKzZkd20yclIrSkllOE14aGRsOVdUVi9VSlcxOUZ2?=
 =?utf-8?B?MkxyTTZmbWVIdkQrUmdGVy9HLzdrMjVIanFrbzN0ZmYvL1RQRktveW5ybTVX?=
 =?utf-8?B?T1EwcmszVkdKN3FocDB0d2U2a2FxbWl5WVJZeVl3MUk1cERtN0syVHVtN1VM?=
 =?utf-8?B?WFVZZ3p0SEZuVUw3YzdzUllzdWd5WmoxSUp1UVFRV3U2bE0rdmRBbjduZFFm?=
 =?utf-8?B?RE9xMUxMWlJqQXFubHpzNmU5anAvMFRHcnovZnczYmlQSDAwRHdrMjR4R3g4?=
 =?utf-8?B?RDI3SGI0bjUzTTl5Zk96UVNDdGVIdm04K3NpanNOajdsZkFJMHhDNU9QdldX?=
 =?utf-8?B?eFpOaDBsVGFZUHN3dk5LTmQ0R1NnOEhGaFJGN1p3eTRxSU1NM2hjSVc5cnlW?=
 =?utf-8?B?WHRZTE5FMlhEYjYvekVQOUJoZTZjeE40aGp3QlBsd0RqdW1RMkp0RmRHMkI2?=
 =?utf-8?B?QnhDMGtkUHczNG9DKzA1UGhJVVY2bURWZEVzL2VrVDBEVkRHZlBzZ1dtMHlE?=
 =?utf-8?B?TUF3eHdUSktMdVA0VytwMEFUekgxOFp6ZUhLem9zL3VmRTY3V254Sm8zTUNv?=
 =?utf-8?B?T1crelNQRENNMlJyZVJnSDZIbHFycnhtZERUS0o4dEQrVTVHWWpublZ3Ulpm?=
 =?utf-8?B?N08xZlFyS3RFeDEvQitJUkRvSEJBY3RIQ2hmWlJyeFZDN2svVzE4U2VJd0ZZ?=
 =?utf-8?B?Z2hZY1p2Wko1VmtPakFBWCt1RldHK2w2QkI2ZjYydFJRTEpqU3R3amtRaEMx?=
 =?utf-8?B?YkN3N1VKSVJ1Ujllb2U1aFhXQmRMRWF6bFFDOU9qbTJFblNUMzBpY3BVYmZx?=
 =?utf-8?B?RXlJQXFrdVRPR1lHTUtQRlBlUnMybHNkcHE2MFF3UmRJUlA0eUszbFAvd3Bu?=
 =?utf-8?B?UkdhdnRISEhIZVBiRGFkS2lHUU9ldHFFejViY2gwK2REcXFjak0vTk9HNkxu?=
 =?utf-8?B?b3BteW9NSjl5VXg1SnU0NTNFZE4rMVJ3WWc2Z2ZTYU95Qk94SDhHOVhZTzJr?=
 =?utf-8?B?REtjZW5XeC95amUwb2ROOStqeG9JemprNm9va3djanFUQWR5N2tkeTE2UzRJ?=
 =?utf-8?B?dUhCYVUxYUdNSEdoWjZhNnN6b1JLRyszWDVmV2pqUHpYTDNrVVVob3JKUFNR?=
 =?utf-8?B?OThYdW9VbGZoMWg5RjN6NHk0dFF2VmJFVDdHVW8rM001M01PdmNsZDUyNmhR?=
 =?utf-8?B?RHU4Yk12d05LQkw2bXh6WnBDbWpOT1hPZ2N5bXFBNkJaTDZZencrK1dIZytD?=
 =?utf-8?B?eEJuZGpaeVlENm9MWDBSSGg1Um55TnhISU9KdzdHUmRWUlZjTnhoQ0N3UzZS?=
 =?utf-8?B?K0NBZUhJcG1KaGs1Wkh3aXdya2ZVV1F1akt5SVFiNi9YRVRCOFlzY1h2YW5t?=
 =?utf-8?B?R29KdThYenZ3L1pNWjNUWGF0WTh1L1QzdXRvalFiTXNSRWRDdnVabzR6TVJ3?=
 =?utf-8?B?UVlEU01HWjJZcTc0aTNDSVdNZklvRVdTeUVCMUpxZDJRdnBoQ3FCbkpKWlRG?=
 =?utf-8?B?b0FQTGNDWmVyUVEvdTFveUdCbFV2Unh1T0grUWt5d1cyNlZsMVhCeVhTUU9C?=
 =?utf-8?B?aFFJdXdXb1h2OWlqdy9Va1JKR0dSU3NxQVNURlUybnFzWlJsTXNjdkNYaFBV?=
 =?utf-8?B?UFN1VmZOUExyU3ErTjhTalJWZ2ZZV2hMV09oa2lpamNZKzU1MUcrcWtCZVJJ?=
 =?utf-8?B?b0ZRWEJSYlAwMTFkNGlDeWNFYisya3J6Y0hqMmRCcnRwcU9jSkpCOUdONndm?=
 =?utf-8?B?cndhemVMQjk3TlpsdS9qZkJjWGUzMWFKSEkvMGFza241YUZhaFFvR1plKzZP?=
 =?utf-8?B?MEFKbUFtT2Z6T1NaOHZUdHdyT3MzSFdvWmQvRm9SK0pjRW1vcjJRakdWUVpC?=
 =?utf-8?B?akNSTHhYZzBRaHJlYS8waC9IOHgrL1YvTmtTZWl3WlFCaGp5ZzE3TnMwa2Fp?=
 =?utf-8?B?VExkckY0aUdUQ0w0QkZlYm5qa2Q2Y1VQWXJ0VUtvd3NxSzJpYW1Ndkh5dlRI?=
 =?utf-8?B?djI0ekFXaTJXZVQ2a1YwM29ycDI3QlZBQnZBbjkxelBPbWxOYjhXVHZhMml0?=
 =?utf-8?B?eXFWaG14OVNKWGgrc2k3ZFEweENSTkF1RFE3bTNlUExESWRhRjN6L1hyUW1G?=
 =?utf-8?B?YWkrUi9JT1k3UEU3VzlXWTlLdzFqWmNlUU5GMWF0TWVlaUdGcE9ZS1NpTHRt?=
 =?utf-8?B?YkpEKzFuVVI4TFhPbW40Ukg0eVhWQzFJbUlqTXA4SEc5a09ucjFQbGpxUjdZ?=
 =?utf-8?B?QlRhTjh3eDUxVkZhV1lvUEpEY3ZpR2hQbFB1M0NQUFpYNWdwa05MY1RQU3BL?=
 =?utf-8?Q?+vS2YP640EuTep02f4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a8d22f-47e7-45bc-5eef-08df3e2c6c44
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:41:02.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X85fCzooPH5TebF3Ctz0YH3GTfBSq34OUuT+EMDBcrQryxwnXFEjcAqus0y9Wm4YGNlQeynjjXaTedlRnuhNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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

Hi Sanjay,

On 11/2/2026 10:46 AM, Sanjay Yadav wrote:
> __alloc_range_bias() walks the buddy tree depth-first, higher address
> first, and descends every SPLIT block even when nothing below it is
> free. Range allocations are placed top-down, so they pack below the
> range end and each new one walks every block already allocated there:
> O(N) per allocation and O(N^2) for N allocations, under the allocator
> lock.
>
> Track in each block the largest order of any FREE block in its subtree
> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
> or freed, and skip subtrees that cannot satisfy the requested order.
> Splitting needs no update of its own, as both children are marked free
> right after and that propagates the new value up.
> gpu_buddy_block_trim() detaches the block before freeing it, so updates
> stop there while re-allocating inside it; recompute from the parent
> once it is reattached.
>
> Skipped subtrees contain no FREE block of the requested order or
> larger, so the old walk could neither split nor return anything there.
> The remaining blocks are visited in the same order, so the selected
> block and placement are unchanged.
I am not receiving some of the emails you are. sending me. I think there 
may be an issue with my mailbox, so I need to check that on my side.
William has also been working on improving the range-allocation 
performance in drm_buddy. His patch is here:

https://patchwork.freedesktop.org/patch/763478/

Since both patches are trying to improve the same range-allocation path, 
I would like to converge on a single upstream approach rather than carry 
separate optimizations.
I have put together a version based on William’s offset-sorted free-tree 
approach, extending the search to be class-aware:

https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9

With this approach, we can remove the buddy-tree DFS walk entirely. 
Cleared blocks are located using the existing subtree_block_state 
augmentation, and top-down placement comes directly from the 
offset-sorted free trees, reducing the lookup to an O(log n) free-tree 
search followed by a small bounded scan.

@Sanjay, could you take a look at the version above? I think it would be 
better to follow this approach upstream and create a patch with the test 
cases around it.

@William, could you also take a look at the version above? Hopefully we 
can follow the same approach when porting this optimization to the older 
dual-free-tree branch
used by the ROCm versions you are targeting.

Thanks,
  Arun
>
> v4: (Matt A)
> - Drop the update in mark_split(), the children being marked free
>    updates the parent
> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>    only the final update from the parent propagates up
> - Drop the order, is_allocated() and is_free() checks in
>    __alloc_range_bias() that the pruning check now covers
>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>   drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
>   include/linux/gpu_buddy.h |  7 +++++
>   2 files changed, 46 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 28cff97d57dc..93f70c98b235 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -602,6 +602,7 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>   	block->header = offset;
>   	block->header |= order;
>   	block->parent = parent;
> +	block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>   
>   	RB_CLEAR_NODE(&block->rb);
>   
> @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>   	RB_CLEAR_NODE(&block->rb);
>   }
>   
> +static void update_subtree_max_free_order(struct gpu_buddy_block *block)
> +{
> +	while (block) {
> +		s8 max_free;
> +
> +		if (gpu_buddy_block_is_free(block))
> +			max_free = gpu_buddy_block_order(block);
> +		else if (gpu_buddy_block_is_split(block))
> +			max_free = max(block->left->subtree_max_free_order,
> +				       block->right->subtree_max_free_order);
> +		else
> +			max_free = GPU_BUDDY_NO_FREE_ORDER;
> +
> +		if (block->subtree_max_free_order == max_free)
> +			break;
> +
> +		block->subtree_max_free_order = max_free;
> +		block = block->parent;
> +	}
> +}
> +
>   static void mark_allocated(struct gpu_buddy *mm,
>   			   struct gpu_buddy_block *block)
>   {
> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>   	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_remove(mm, block);
> +	update_subtree_max_free_order(block);
>   }
>   
>   static void __mark_free(struct gpu_buddy *mm,
> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>   	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_insert(mm, block);
> +	update_subtree_max_free_order(block);
>   }
>   
>   static void mark_free(struct gpu_buddy *mm,
> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   
>   	size = round_down(size, chunk_size);
>   
> +	BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
> +
>   	mm->size = size;
>   	mm->avail = size;
>   	mm->chunk_size = chunk_size;
> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   
>   		list_del(&block->tmp_link);
>   
> -		if (gpu_buddy_block_order(block) < order)
> +		if (block->subtree_max_free_order < (int)order)
>   			continue;
>   
>   		block_start = gpu_buddy_block_offset(block);
> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   		if (!overlaps(start, end, block_start, block_end))
>   			continue;
>   
> -		if (gpu_buddy_block_is_allocated(block))
> -			continue;
> -
>   		if (block_start < start || block_end > end) {
>   			u64 adjusted_start = max(block_start, start);
>   			u64 adjusted_end = min(block_end, end);
> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   				continue;
>   		}
>   
> +		/* Not pruned at @order, so this block itself is FREE */
>   		if (contains(start, end, block_start, block_end) &&
> -		    order == gpu_buddy_block_order(block)) {
> -			/*
> -			 * Find the free block within the range.
> -			 */
> -			if (gpu_buddy_block_is_free(block))
> -				return block;
> -
> -			continue;
> -		}
> +		    order == gpu_buddy_block_order(block))
> +			return block;
>   
>   		if (!gpu_buddy_block_is_split(block)) {
>   			err = split_block(mm, block);
> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   					     gpu_buddy_block_offset(block),
>   					     gpu_buddy_block_size(mm, block));
>   
> -	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
> -	mm->avail += gpu_buddy_block_size(mm, block);
> -
> -	/* Prevent recursively freeing this node */
> +	/*
> +	 * Detach the block to prevent recursively freeing this node, and to
> +	 * keep free-order updates from propagating above it until the trim
> +	 * is done.
> +	 */
>   	parent = block->parent;
>   	block->parent = NULL;
>   
> +	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
> +	mm->avail += gpu_buddy_block_size(mm, block);
> +
>   	list_add(&block->tmp_link, &dfs);
>   	err =  __alloc_range(mm, &dfs, new_start, new_size,
>   			     was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   	}
>   
>   	block->parent = parent;
> +	update_subtree_max_free_order(parent);
>   	return err;
>   }
>   EXPORT_SYMBOL(gpu_buddy_block_trim);
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index ddc4eca84175..8037f5a0feb1 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>   	unsigned int subtree_max_alignment;
>   	struct list_head tmp_link;
>   	bool has_clear;
> +	/*
> +	 * Largest order of any FREE block in this block's buddy subtree, or
> +	 * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
> +	 */
> +	s8 subtree_max_free_order;
>   };
>   
> +#define GPU_BUDDY_NO_FREE_ORDER (-1)
> +
>   /* Order-zero must be at least SZ_4K */
>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>   

