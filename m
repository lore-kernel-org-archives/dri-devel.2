Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F66C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCAA8961D;
	Mon, 28 Sep 2026 08:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x7FUOEDo";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC848961D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyczSjpJ8aE/Cua7npMcAikJg7bKapXtbvM9BPbkz4ejP+rvY+eOoS1WhAsPf+xrgYMRdWcAgHKB+1U//TZrn67x1aRi39w2IcVqjmm28dKc++/m9JX9r3uwALdgplMgtK0+k0POzefJAzLc3BPZBkdg4q3rjxrOHFlz2DUmQbzvTxp/v5sM6QydXTGXn5g8mld7gZMe3R4+A7wL6JTzp3jYOICIgpDxDGRTXwXtQmJSEAUgH2ZlQRkjVAjkvsaWJvRnn7fwwbmqCCekWvf5dw3kZE5vBhWfT0ogBKcB3IGNgneM63OhXaRfGXc6NPuNB++3i7QJPSjZAI2RebfhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouPWJjKRJ3M/+J6cWZnzKaMUDBb7jkODhZYdrMyzF6g=;
 b=gEB/qmvReNiu775MB3DUCZCOtQZz+x6LN3IaTfstqspQoIjFPzsAaALqR0S4HGvYiLvSJbn+vXCG8rznJy71vjITjPjQ88/7u3xoOYUEJr8/B0n4ofzhGUZJHLcQFZKw2/N1/JFoLM/l3OHdFiEMMvmt4OXylJSRcaQ1mI4Gs2v4mVocnSQwGhS5RdvmY0vHu+08ttkVsB5YLa3801PSG14NcB/89Rkmx+Th2mS7Gpi07HmGLrVMbtBY0JE1nBjrou8+W6gtsnjXqp00MqUYuPKzQzq2ngVbv1ocktZgiTdYLk/je4v1DkyT0S522WuGL/OF3XR5r7fhASbGbIq/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouPWJjKRJ3M/+J6cWZnzKaMUDBb7jkODhZYdrMyzF6g=;
 b=x7FUOEDoCtp+A2NQRsip7i/fQOXV3LvOYcbcdtM/y3mN47WJS8kJIhRGaXHTPG4otgUAhFwUiGs99iJ3todYtuf3Thp7jG2nCzdG6bO6YTQ1UnleNfzk8FwXt8eQLYi+x6NKS7C+X26rcpPy91KWdgY/g1F9Lg2oiP4FzBBas64=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 08:27:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:27:36 +0000
Message-ID: <ea7da508-131e-4146-a737-5e8778866e03@amd.com>
Date: Mon, 28 Sep 2026 10:27:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: respect the device's maximum segment size
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260926071258.77202-1-kmehltretter@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260926071258.77202-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 605640e3-590f-49a9-ca8e-08df1d3a59c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KcQocDpSZZl+oQZGQwBj3yQYtWR1ra7JyWELVeoXZxUPjj8d4hzxUft3yOjpaTkT51k4OnWuZNWvqVG/Foev7wy3/rEuQtMCPDFG8PldAQGmxq2aNmX1cPWD348s0fjGZ79MIT6imgkkywNt18c8t/ZVjcrC2TG6sAebeBJq6fWC4hLSm9aN7Im5TYTq8D3EXl6SGvuQG/J2PvSAm126V1mEvSX6kCEWZZRUeW+SHadpC2MU7ytbUJLRuyCiObt/XXWrSUgFfNV997bQCNt0e58mjN5eVowbZT5lAoZwBgNUaYy0S20ryAGg8TbT4brhfBelaxVekLPlPSpn9355DwNhxQGtEeV0DZK+3dD4cHVK1owfqIbIdxDsTSYOF3vhLiEj4j053Ajr8NBUpjTq0RCzVJ6J2g+VmI6P8M+7r73M8ZXykr0R1mGSWdPChYSE6PFTnubevMX/on8H97gyb5ivbxnAO+KD2apjgdoP5r4N9p0MatMOL2BNG1S5C/SI3F7BmxxCFNVcaTs4QYkl5o0NfB5bZTBcUx4b8iosMkvbUnljwzO1tigFTaY5CXPAB4HLddaJ92uHCiBY1v+/Ts/wgXRCnzw1bf33DpWMc7b4EvUQp5ZG+0fnYs1xbb5OaIBCWyocHNz6/6ihhHxsztmKMomAda6MGg/4irJmMAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lVSFdqUDJnckhXTEwwNFR1R1ozbTN2dGE1dHlIazlOQlZIdEVRQk9tL0Y4?=
 =?utf-8?B?YVZmL3VFOUFSQTM5Y1pWY1Y4T2Jnc1VscnVwTkhBQUM5OStSZlBCejBtRjhr?=
 =?utf-8?B?YTBkaExXNHl1TndPT2p3UEppejNOL1lBaEhZL3RReW5RV2gya2VNbys0UjlC?=
 =?utf-8?B?cnZCcXZOMTlXRFE2emtxdkpRM3lzR0dQWW1QSWs4OUQ1Y1J1WVpLNW1ubHVU?=
 =?utf-8?B?SndteXg5ODRSOXZqMXNyUkdneFA4TmhvSkxBSnNwQVk2ZlpWYitZaGpsZmtD?=
 =?utf-8?B?cy9ET2F4U1JpZVN4dGwrM1U1bTNFN0xlVjlKeWxsUnRaeExJTjdUekdhSG1a?=
 =?utf-8?B?MVAvS0xyelBpcFpLY0xETHRza1hXbTRBZmxNdE9UM3VHN0w1MDRUQ1FzN21r?=
 =?utf-8?B?Zm9TalN2YVlXUjRiN2drTzBYRnZlUFRYNStWZzRhQk5kRi9iQU1oU2xXSFJ1?=
 =?utf-8?B?QXdsb25PZWxzcUNYSUhWcFN1K1RJQ0hHR0F0bnpxb1NyOU5vSkVJeW9xd09q?=
 =?utf-8?B?dHJqSkQ0bDkwS3U2cEZJY05rcTRjQ091WmUxcDc4c2MyekM5TlJIR2dPVUNl?=
 =?utf-8?B?d3N4U1lnZXFCMlZzOHNvOHlaR005L004K2cyWUtxL2JMNy9LdGJicGZRQmhi?=
 =?utf-8?B?c1U5eURrSUN5YkpsWkF6bWlTR1BHekcveHdhZFA5ck5TS05MTGRzMmxSWjl1?=
 =?utf-8?B?RGVUbFhRVTc2eUZwRU4wZ0hrQXNsenh3dDZtMnZ0MVJqYStLTVpaNUxBUWhv?=
 =?utf-8?B?UlRSUFhzSG5LV2Q2SkZ1SnRLVXVvRm5KWU5DYndjQ2J3SWlMa0hDYnRCTEQ0?=
 =?utf-8?B?dllPZWs0N1lJWXNwQUtmS3pzKytSdzNzWTFvVDJJRHBpalg2SEwyMFNLUkxk?=
 =?utf-8?B?RXdNaGVwN3E3UjlnNFowWTBpbWJ6RGYvYjgrUE96b0Q2dFF1N3h3Y24vRW9u?=
 =?utf-8?B?VnZUc3JvR3BHa1E5NHd3SC8wTmdRU1BkL3RiN29ta0IwYmY4ZkU5bWVBc3BG?=
 =?utf-8?B?SXMreFhob0w5TVNIUUp3TW9jblZ0WVcvc29nSXJZaVJTT0R2Nmk0cm9DdWhI?=
 =?utf-8?B?MlhXdTNvUUtvbVJFZ1k3Mk5CWU9KZ3BCdTh5Nm5ReFExRTBOUGVMUHRyWG1w?=
 =?utf-8?B?NmUyVkRKQlZ3YmhLUEVOaWw2dWpQclk3ZHdYemFxVXY5OGpzY1cwd3VjeVZ2?=
 =?utf-8?B?ZVBsL1BwajE2MlpVaXpZZVg5T04vZE8xWkVRSDk1TEJqc1VkWGxoMWg3ckNy?=
 =?utf-8?B?SmczV24wMWNVdG9JWitQSWtEYU9rcXFPTWNkbmQwbXQxL2gxQXRNTjZGRUJv?=
 =?utf-8?B?N3ZTSmZFQnRxNXN0MmV1UDN3L2pQbTJMLytjQjVCY3FWYkRUcmFjWjFPQXRH?=
 =?utf-8?B?RWZmQnhwOTl6M3UvTHVsaFFpVE5zT1pnS1JMZmZjenJUdWJUSUtxbmpGN2Ny?=
 =?utf-8?B?TTUyNW9TaG1reitqU3VhZG81WHNmdlFzci81WU1KcWlFN1U3NzJPL2lPSEdo?=
 =?utf-8?B?Tk5LKzN1MHJpcDlsQzhlNENLOEFLWVlPOXlhOEhvMFcyQVRHUXlnYzVCUkZP?=
 =?utf-8?B?c1l2VTY1eWV3Z0Y5QVJqUzVnWW56OVhFNVpkWTZCaWhIVlNscjIwOXlmdzlF?=
 =?utf-8?B?MEZra0pTc0EvT2poU0xLWGM3QkJid2NEWm8xL1VHS2orLzgvbmFmY0VXd2dR?=
 =?utf-8?B?V2MvcVlwWVhQZFBuRUhSZEE5SDRHbmlyaWp3WEt3bEd1dkZhNWxObjZXb2t5?=
 =?utf-8?B?SllPUWY0Unh5UzZWbDdZNFhDdEN6bzl3SmhZdDN5cUFPT0NmRWhMY0NOL2FZ?=
 =?utf-8?B?NTVoVnJoYlIzRTFpRXNGM0xIeEZkWEhmOE0xWWhrT1pGaktzdDJ4M3hGbTgw?=
 =?utf-8?B?RzNFOXQyU2tSU1AyK3JtWUY0OVVxSlFub2I1ak0yOUh0NXNSUHlaNFdIeEZ2?=
 =?utf-8?B?bDFDU3B4Nm43UHRjUVpmRk4xSThlb3N3SFNVM21kemlRZ3R3eUtuMVBTblFV?=
 =?utf-8?B?WC9IVnlmcW9tQkJBWEhaTXlDVlVlSERsZGdBNzJVZTNybTlyb1BpZ1ZGekJB?=
 =?utf-8?B?R2VIeUJwQTFZMFFKRG1wZTJ3ZFZLMFc3TGFHWlBYNGFobU55bC96aEh3c0hK?=
 =?utf-8?B?N2hjdTBHaXM5VHBkRU9HQzQyWG96UTAvSjJVYTFrT2o5Y2lGa1gzelQyeEVT?=
 =?utf-8?B?TXF5a011c0tXNHEwRTdNNW0yaXVpdythNjNxc2tOMkZEaTZRVUxTSEs0QUhT?=
 =?utf-8?B?RGVQN056YWFFc1pPaTFDOEJpQUtEZDlzK0xoaUIwdC81elorbUNHN3o0VUlz?=
 =?utf-8?Q?BJE2G3ea9yUEoQUs3U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605640e3-590f-49a9-ca8e-08df1d3a59c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:27:36.2824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBr7Lmnpvp3IFxgYp8a0H9qYphmMV1degSYLN1Fmn7V58hNLvAeDHd/Ip6riLiGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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

On 9/26/26 09:12, Karl Mehltretter wrote:
> get_sg_table() merges physically contiguous pages without accounting
> for the mapping device's maximum segment size. This affects both
> importer mappings and the udmabuf misc device mapping used for CPU
> access.
> 
> With DMA_API_DEBUG enabled, DMA_BUF_IOCTL_SYNC on a 64 MiB udmabuf
> reports:
> 
>   DMA-API: misc udmabuf: mapping sg segment longer than device claims to support [len=65884160] [max=65536]
> 
> Use sg_alloc_table_from_pages_segment() with the mapping device's
> maximum segment size. Keep a PAGE_SIZE minimum because the allocator
> warns and returns -EINVAL for smaller limits.
> 
> Before commit 5bf888673e0d ("udmabuf: Do not create malformed
> scatterlists"), each entry covered one page.
> 
> Fixes: 5bf888673e0d ("udmabuf: Do not create malformed scatterlists")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> 
> Notes:
>     Tested on v7.3-rc4-70-gfe2ec83746e5 in QEMU (x86_64, TCG) with
>     DMA_API_DEBUG (all_errors=1) and DMABUF_DEBUG, A/B against the same
>     base:
>     
>                                             before        after
>       DMA_BUF_IOCTL_SYNC, 64 MiB udmabuf    1 report      0
>       vivid import, 4 MiB udmabuf           2 reports     0
>       vivid import, 2 MiB hugetlb udmabuf   2 reports     0
>         frames captured                     5/5           5/5
>     
>     vb2-dma-contig rejected the non-contiguous import in both runs.
> 
>  drivers/dma-buf/udmabuf.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index df6dd00462423..09f1eb8432f19 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -139,9 +139,13 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>  	if (!sg)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->pagecount, 0,
> -					ubuf->pagecount << PAGE_SHIFT,
> -					GFP_KERNEL);
> +	/* The SG allocator requires a segment limit of at least PAGE_SIZE. */
> +	ret = sg_alloc_table_from_pages_segment(sg, ubuf->pages, ubuf->pagecount,
> +						0, ubuf->pagecount << PAGE_SHIFT,
> +						max_t(unsigned int,
> +						      dma_get_max_seg_size(dev),
> +						      PAGE_SIZE),

Please return -EINVAL instead when dma_get_max_seg_size() returns that the segment size is smaller than a page.

In general I think that the sg_alloc_table_from_pages_segment() approach is because of the broken design of the old DMA API. Stuff like that should be handled by the iterator going over the DMA segments instead. But yeah that is not something you can fix in one patch.

So apart from the error handling the patch looks good to me.

Regards,
Christian.

> +						GFP_KERNEL);
>  	if (ret < 0)
>  		goto err_alloc;
>  

