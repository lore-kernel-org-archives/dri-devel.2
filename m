Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D87C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193D310E905;
	Tue, 25 Aug 2026 07:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S5dlJUSQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF59310E905
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBnpgCMCtQz/aeTCgJMfWn+lpCMhUdOM76Upwem7bHr4TxwVrd1b1ud5V0XbvTKzeehSq/TBqadZuZzDZXLSQKArgMltV/g1Lt4H7iZenGLy7rStwZRh1e/KFVxS3gjQPAhe2gZyKPTU7VGIYCoG1na5nl+zzP8b1ieIE8Ut0ZeUODmxkGKn2gjRVZh+ibkyOTJSbE+asWtpIq+Mu0XyeVjjsCwCKXmqK5dX59jXRPiBrF8qO5Lkqa9DJoqh/cijmxR7F2gJNQt/zSifEs/nEyvMd1z04chRPlsb3nfvVYBmcZ1GPP9zwlxle9KsvJ9NxckjXhPYrC8iY7eBPMutNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIPvn/PlqSF4wDTGBXPsTpvZyADG7nqLeaQtSDlbDXM=;
 b=KvTpKT5Jg2ft0N5P09jXTOGUz1a10OEmYRI3ezV3AYqF9gohH9KFZSKxYoWGz1JWmlUguaMej45xLxo7JpOXU8WTaEEJaSMiWRAB0x2z+GDLQHO7qf6l1RObCTopz0oR8pOIJ+7mLBPsdRE7+ce/21gLIRTYcnQ7mBGnEXv/EEbzFa70iYe9+WAm3PJ9q8zqrST/PnctxijenftalYMN3m0uU0r6jMDUwLfDgCriRlKELVPmGbvvPjzpdb+5iVtc3cwkwNUi6WP5lA0hCe2MPhTrsBIyonqnTH1izF9FAflOiBfvkV/sMET4xIbzTyRg2dC62XYCNoFJz/1yKx75LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIPvn/PlqSF4wDTGBXPsTpvZyADG7nqLeaQtSDlbDXM=;
 b=S5dlJUSQCeu4UEaMihgat18/1Eh/9BQF21mEV9NSJ/EA+Jd8sqVhbvVUP4SHxM1IpatGWwc6nnp2tnPIu7HFNyCu7E2Em1/DJqgwQ/fjygbw5yKs1daPdBj8buGp1xYh7pFyauFKMfI21U7cuFEh7pZa0VK86iJtSdRPQLKH2EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:43:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 07:43:34 +0000
Message-ID: <e9e3314c-288e-4e32-9c88-8460d7a43872@amd.com>
Date: Tue, 25 Aug 2026 09:43:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf: heaps: Zero system shared heap pages after
 conversion
To: Steven Price <steven.price@arm.com>, Marc Zyngier <maz@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Thomas Gleixner <tglx@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Pirko <jiri@resnulli.us>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20260820105026.53208-1-steven.price@arm.com>
 <20260820105026.53208-3-steven.price@arm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260820105026.53208-3-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c19030b-1dcf-4bd8-a477-08df027c911b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n4VXQW43vwolSZmM9GVxfxZjkj3sxmxCa23KZCkk9sj+qKONaxrzPFZzdhrT5YNwBc+dZI+vvWroM1EZWoVFL4YybKpxQRjYlNk3IMWmYsRt1WteP+dzaSs15MoXU3PDM1oPt+PRoO+Z/b5gV6OARlTHMc9MjGBF8AE5SOsjds6n+4iROHlHYCOVCNmRcBUs4EdqTFLBoyd8OREgAu7M9t3BRHl8wGufGm8HLm/oWOpR+yEI9cE9Ecp0Hc+LBDa1tefa8dFaLzzopiB8nNosejbJWxzNAPkkT4M1cUpPBci822Watv2kqmiJIVo4eW/qVZKIq/m/OM5YCXuLAXwXJx/O91N4SViywyaFR5LP9iyl6+bX1vin0wItJ6kK2Fdw0ubYOBCYeN/PmrWe+fYEgXdVHFwcmaRH8D+S9DiZS0Kldln2hlGT/fK3YPtdqLeIpEswctiCRNQrzYeU7U3UaMZ2WTTbdTiWOyCV1/4HuLN28IJngvqurXPoWUOYllIrglWB8lIrAdW3thNDqEfoA9wqgFs4qrP9REkNoUDB4LKs9raF9FIZ5PnlhddBt00ITlBoQrZpRjHVDdxn1DJcMUOMnG3AQcByPyMVbYlAcq/QwhjUhNeEuo5YXVueTjl+1spnUBgChSTkSTPlu+wesXimK6T4k5iiBXw6btHwk7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmZZbVlxbWdGNXlCNW1pc2RBR3pXVUh1VUlrcTYxTzY2QVFBZ3p1RWFmdCsr?=
 =?utf-8?B?UWhDQlQzZEdwN3NkemIyUTZUNWZkRzRQak44S0dmbm1VMlh4R3Z3aEo4MHZ1?=
 =?utf-8?B?VCtqRGZONkxUWWRmUlUyNEZ0dzdCbVMwWjV3T2RUTWdVRm9FZWE2bjIrUWNZ?=
 =?utf-8?B?eWtLYVQybVV3VE9IektZb1V5MCtkTEwwaXB2c3U0ZVdnMXNrTWZ2NjlHVFJ4?=
 =?utf-8?B?MVkydWY1Tm5STW8vSnNMQWlTSlNMaUFQN3NBZFpzME8xdnB1dndmZ1Rvcitw?=
 =?utf-8?B?RXRkMlVCa1BzQ0hZVk5PdXNLR0dMZ0NtR3ZPbG5Jb1Z4RlZHaWJvRmR2TUdI?=
 =?utf-8?B?SVJDd3N6aGtrdEVNcnY0ZkUxcFppOXU4Z0VCWERDTGlGNTBiTFVJd3F3RTZL?=
 =?utf-8?B?SE9TdEMwQXdQMDNxMThtYjZ0UGZlYlN2di9NSDJ2VzJWaVpMY1dtaEJsS0dx?=
 =?utf-8?B?NjRRdDB1YUkzYndYeHdLYWtOOW1NSW9IUXNyS3BXc1JFNE1ZS2JxRDZrcjNz?=
 =?utf-8?B?Q1FubnljNWYvYk1heFNKUmdQTDJkRU1iNDUzTCt0bVBKTldvSDlHcW9FOURm?=
 =?utf-8?B?a1FsVk9jVFRlbVFPRHJHOWFKaG5IOGcwTElOSGZtR3kwVTVLVTNma3BRSCt4?=
 =?utf-8?B?MjdSdTJYMkVUdG52RlFTWHRvd21JZWVTeWcrU0lSdDA0ajkycm1VMHNRcjhM?=
 =?utf-8?B?VUNpVi9wK0ZhTDdUUUQ5VmNXK0hPWFI4VExMTUpweEowbFdxakFOR3JrRnZH?=
 =?utf-8?B?UmdkUHNVREdpN2dRNTVLbTJCVmtDdytVSExab1N1bEZpVmlkWUFqR0o3QXF4?=
 =?utf-8?B?bFBRb3BGWUdyZXZ3bG8yTFRpRURkcnhFSE8zb0dyOHVrUWh5aFRiY2xyMnoz?=
 =?utf-8?B?c0tValBmOW5EQ3VVMmt3NVA1RnRFcG96blcreXV1cGtrcXVBV3BmVVBxWU8y?=
 =?utf-8?B?Q1dZYWs3K1A0eW9nK3A0TVZvRDE3d2k4SVplU1dlZmhhUjkzMUZPYTY0cTd4?=
 =?utf-8?B?ZzNhYXQwM0NDYnVXVHNOdVRUN09nNENGUUxRVnArTmUwY2tYVngzLzZSeHpa?=
 =?utf-8?B?UkFzcXUybHBHcEV1amR0OFRoUXdOTnY1ZThPNzlGV2FxY0JkeHRBaFd2QlNC?=
 =?utf-8?B?TkhGTWVCMUF1SHRTVFBWaWpTRE4yZGxNV056R1RYSGZLK3l0ZjZZMFdDOC83?=
 =?utf-8?B?c3AvSDdiMWVsZmVXNEZsODRZMVRuZzhvR3V6clI2TUZrSjF0MTM2cmxPa2la?=
 =?utf-8?B?QVRPcXhwc3QvQzZqOXlOU0lxR3FqRUJKSkwwd2lBd1dISnZLSW5PdmN0MFRV?=
 =?utf-8?B?dUc5c3dPck41aXRTK1drWncxdytkbFdURjliQjNvQVdGaTFPRHVMUFpiZ2gw?=
 =?utf-8?B?dEFFd0dTOTV0NFQzcGlzemRWV2ZjQWdCSWt3aW5BVlZNYXV5N0NoSlU3TjZ6?=
 =?utf-8?B?WVhFOWJnVWljYjgxRzBUZVY4ZXMvaFZCenBXMkVBUUVwUStjUnl4L2FJR3JG?=
 =?utf-8?B?U0s5bGo0VmIzNDlEWGEyZkdEQUlrU0VMRFhVNTBiRmhZM1ZLemxmNnBJUUU2?=
 =?utf-8?B?RXNOQitoQUJvU1ByZmlmWXBYVkZaM2ZucWw2a21hVDV5NUFkOWRMdk91R2Mx?=
 =?utf-8?B?eEVWT1BxVHVTUzdjM1JraFpoa3FXZDBiTjlGeG5pMHdUY3Y4MjNPcXJCaWc3?=
 =?utf-8?B?YW4zakUxaEU3NFArWE1PMGE0cEJkSlZ6Yi95TCsyMVJxVm5yNHBUbWpJbTAy?=
 =?utf-8?B?VjVvb2ljRlg4b3BqRjA0Wk5KNUUyejhLY25JMk96SllpU29aNVQxY0U2OGo2?=
 =?utf-8?B?N3JObS90STV5MjlPeGxESzJlV2xWMUxEZkhjUmQzbG1ENm5aSXgxQjNYbUI2?=
 =?utf-8?B?bEQ2cWExNU9mQWxkdld0TG9tVVdJZGZHclljMkdCVlJCR2RIbmc4WG10dHJG?=
 =?utf-8?B?elNyZW85aUcySk9pd2dnYWtoL0pWM1JlRWVCbko0VTFlN2RFL3lSYzAvWTN4?=
 =?utf-8?B?SDYraFpmYTVvMFdQb2JzTTJFUjJLM3cyMEFCNGY3VDRTZy9xYWRjbkJzY2th?=
 =?utf-8?B?c2ZJVzZOTDN4UXNmbEhVeE11a0IwMm5reWJlVmdjWUZqaXVUT20vbmM3U3Ru?=
 =?utf-8?B?MWFRWTduWGw4MUtoLzZyWlBjSnd5TmJqNlIxNVJETVp3aHBYTVZITk01NjNZ?=
 =?utf-8?B?ZiswN1Z1VTZDTWgzSjcwbWR5ZmE3aENpMUpwWk1Bdy9BTExvbkZVa09rY3dD?=
 =?utf-8?B?VTdPTE1qVmNxaHFZVVp0QUxJQlhPNGJhVFZSSSt0emNWb2IvYW4yNmQxMDJl?=
 =?utf-8?Q?6UAUIWtzkWz22yWxGa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c19030b-1dcf-4bd8-a477-08df027c911b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:43:34.5196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYuomubMPYHgSzv4H28HFCUw7l4VLe8pv68QTIe0Qf5PJrDNyvmg7CYmwmFS7IiG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
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

On 8/20/26 12:50, Steven Price wrote:
> The system_cc_shared heap allocates pages with __GFP_ZERO before converting
> them from private to shared with set_memory_decrypted(). This assumes that
> the conversion preserves the contents of the pages.
> 
> For Arm CCA with MEC (Memory Encryption Contexts) the key used to access
> the page will change, and so by default the visible data will change.
> The host could ensure that it zeros the page after decryption, but
> rather than relying on the host's behaviour it's best if the guest
> simply zeros after the decryption rather than before.
> 
> For CC shared buffers, defer zeroing until each page has been converted
> successfully. For other buffers keep the existing behaviour.
> 
> Fixes: 78b30c50a7ac ("dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index c8959eadc71d..f14930904089 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -376,7 +376,8 @@ static const struct dma_buf_ops system_heap_buf_ops = {
>  };
>  
>  static struct page *alloc_largest_available(unsigned long size,
> -					    unsigned int max_order)
> +					    unsigned int max_order,
> +					    bool defer_zero)
>  {
>  	struct page *page;
>  	int i;
> @@ -388,6 +389,9 @@ static struct page *alloc_largest_available(unsigned long size,
>  		if (max_order < orders[i])
>  			continue;
>  		flags = order_flags[i];
> +		/* Decryption can change the contents, so clear it afterwards. */
> +		if (defer_zero)
> +			flags &= ~__GFP_ZERO;
>  		if (mem_accounting)
>  			flags |= __GFP_ACCOUNT;
>  		page = alloc_pages(flags, orders[i]);
> @@ -438,7 +442,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  			goto free_buffer;
>  		}
>  
> -		page = alloc_largest_available(size_remaining, max_order);
> +		page = alloc_largest_available(size_remaining, max_order,
> +					       cc_shared_buffer(buffer));
>  		if (!page)
>  			goto free_buffer;
>  
> @@ -461,9 +466,12 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  
>  	if (cc_shared_buffer(buffer)) {
>  		for_each_sgtable_sg(table, sg, i) {
> -			ret = system_heap_set_page_decrypted(sg_page(sg));
> +			page = sg_page(sg);
> +			ret = system_heap_set_page_decrypted(page);
>  			if (ret)
>  				goto free_pages;
> +
> +			clear_pages(page_address(page), 1 << compound_order(page));

To be honest that looks horrible.

If you need to backport that fine by me, but in the long term we clearly should have that in the initial allocation somehow.

Regards,
Christian.

>  		}
>  	}
>  

