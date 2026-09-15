Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815C6C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62BD10FB13;
	Tue, 15 Sep 2026 08:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dKlpGG3I";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D4010FB13
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on5qCV4iCIk+0YdCKjCSNaUrq7GnJaeTi3Hyk/go2WhcuTKkYFBunjBxBdjFjDsItqNDQklyyZDnDwecJpRi8cHUFd96dt5kr5+hElv+5Yk5NlyzxKYYS9qWpQRXpZNiQli4NgeTEQtZCyf8B8awShEyz0x1SS3pF2lHpJj3rCDRa0KnADNAT5zdpPp2uHWqs70xWOkSOClngq8njoWAJqOnmwnV39I8ux+SXDYb4lzHc0a5EmLYkyoW/Ts1YddP20uaY1VMNr+q8bfn8scCMTIN95OTPm8nfz15w2Av40uamAxNNMWn0hris6HgkGMMzwx7Fh3tAsXHtu/UlzIG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QD6DsQ8l6iGFrBzsCAFSrik327hKuVR4MZ/saNPxuQ=;
 b=hr89IUt2wo/X1m0XElAKQ0PP9QoquT8d+HACKUiDodFb0fA1OtAGObfaYsix2W6GdlT1MNjZVWofNzOV5SQxywpXXG333Xpf0V/0dXXVTQ9JiDMIMdiutu6B07E27DstduBqjgDBpd9c3ABZFa4u0Q8/ziE7bVEMrfg4C7ryONY1J6/gJnT2C02Du1d6qMNJIvDfgjJApEL7B1Gaf8CGuwvzamYfEw8V7hfSmMA1eO0wCaYzZ73MatSGJdoQx6SZ7iCG/lyiU0JttyL0ijM8+7IQE/E5zLmOPhkiF/8/AvrqbHGWoKiHJUqVhwNUHWr4AOLxxKN1VaECkGG18h35XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QD6DsQ8l6iGFrBzsCAFSrik327hKuVR4MZ/saNPxuQ=;
 b=dKlpGG3ITplY/WJeGZmnSPsxHOP5khtjqleml4Ed/zAMlQWksgCzXxjNA/aHiZWHBt0JD4kA3A60nyRDxZmST/1nXVD/vhu94K0eNE/nrW4qtOCFGXK6/5fp9pFT68rMoP6wxP5kvh093jR4L/uvdHoCJk/OpskDmDAD3cNait4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:45:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 08:45:42 +0000
Message-ID: <3cee59e0-18ad-4803-bd7c-4d9bb5c23215@amd.com>
Date: Tue, 15 Sep 2026 10:45:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-buf: system_heap: fix the allocation ladder on
 non-4K base pages
To: Davidlohr Bueso <dave@stgolabs.net>, sumit.semwal@linaro.org,
 phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com,
 tjmercier@google.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-3-dave@stgolabs.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260914212258.2657788-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff7b0fc-d564-4367-9b4f-08df1305b9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8xqwMAgAo47Kx3d5geHn9qJciKWgQHXpBK+ZfaZtEwVV6la0Hlf9cC9i0gBiRfc1ae0CqOaw0Ihen6hTX7ij32ceQc+7SgGzrjkfbytuHQ+l9kVdplZ5PnqRjN3OytysfQibPkpUWfCD9FnBslNHXcN+w7AWeDn7yl0SuUFEz/Je/jje0UMo9Q2HwQVdwgnD+cb0QhkYComkfcWv9wrMkh+aD8fG6TEY29BYv/mMwNDeSTXJdsELNm3r5a0r+6moJq6ULx33xu4FSf/cgaUjM0FHkcHtMV+7EmecFi/S5BkBxusmcPvmUi/+dXUJb4BlZ6L/HKKPB2rLFWHvo72WC1KighLSi+TUaz+kk45X0o4HC6K4KKVAWceIo7ZV4JnlmzdXVnJ403AK8DiKrRG29/4f6Ue7EpyHFhnnD/w8b9jUR2Lsg6j+zNEv+EbZ2J94w0GYHSOmFyHYm8qebiSvF9T+7tBBU23GIG4ROImKl5em4w5lwfJ5kjqAdSbMN4iTkUhArxH9CTkfmEpmFOagkGOShkWluJTbg8dcA2VKmX7r9TjO8YPg45rklpNyXh+8ZLKDQqwdpXMgU3X4F3G2swvT2hau/2X52l+A27POYBdh0QiDuZhepMVE24mniVmFGvmW2B5+IdAanCGXx1FTpxCaf4YsDxwjekzE5vfYH8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZRVU5sd1FmV1c3WGx0MUV0MnE0TmxvS3hhVWMzSVdmbTgrWUs2WmpPNnUw?=
 =?utf-8?B?L3BKSFdTYnlPNmtMZG1wTm1JN2lrL2JrL1drZFJQMk9NZ2djVlNMNjNXSVhn?=
 =?utf-8?B?SEFmSCtqRFd5WWYxNFB6L2syS2wydko0ZVBYTGZ0OE4ydXNucFp5cjRGYVJy?=
 =?utf-8?B?TVJHRDdSTHBPUEZVc09GOUV0QzVTNUMxZVZmcytLL1B6Tm8rQUxLb2ZJZ3hw?=
 =?utf-8?B?eVBtWkdrY2xRQzFNN0tuZzdIUmk4WlVXSERQMnpCbVlTSDQyZ3lNRUthaXh1?=
 =?utf-8?B?V2hpbDJudWQxQzRENHZrYzBDd3FMSkxxQjlYc0pwNU85QkY1RURVQTB5a0VL?=
 =?utf-8?B?cW05enpjUlQ2UGVaS0V6aGZhbTh2Q1FoRERLSlljK2kzQjlQcmhpWXNmWHJN?=
 =?utf-8?B?M0xyR1UzUWpmN2JTNEEvNUlaeWQ3YmYyTTJkOXk2V0QrMmlwdlZ6QmJscG4r?=
 =?utf-8?B?aGtMTmw4QWRkaWREaWwyY0pHQWJXOWhDM0QxVER2K2Q1bThlNHJTbjc3d1dj?=
 =?utf-8?B?UUhOMTZNYi9JcFAwMkRPbGI5WUVKUjFyVzZLYjFxbS8ycUNiMUtyVlBuM2Fu?=
 =?utf-8?B?QmIydU9SK1A4b2lMSTBPa3JYV0xla3E0bWRYSEZlOWpkOEIzY1ZLNVAvNjRH?=
 =?utf-8?B?eTlSMnZxMjJmNUswMmdzTEJ4eVVCY0xrdlZqYlZZemFWeHpNMWt5WlF3QXBs?=
 =?utf-8?B?THdZdzJVcU8rVkhUWUxwd0dvMXVxd25OMFliRExxdFUvNyswU0ozaFBXQ0JC?=
 =?utf-8?B?Ykh6MUxUYjJhbXk4cnBncWNyYk9VYm1kY3JDNXZpMFg0THQ1ZkVrMVZKQ1c0?=
 =?utf-8?B?RUJIcnZiZk9qekJZeStrNkhzazljYkVCY3B0dmdqZXlUL2JlaTV6OVVnQyt1?=
 =?utf-8?B?TzUyOURqcVJmMGs0SmRnalVxbkNOSVRyRWpEazN6ZnN1K2JYZ044QlViVGZs?=
 =?utf-8?B?N09QSThLUlpjWVFxbmFYME9mR0M1QmVjcGhWci9BTHFEQ3JPbnFoM0NxR2F6?=
 =?utf-8?B?NGU4V0JlLzJtTG5jS1ZQdXMxaytpRC9yTnBlOEsxWGQ4ZmVRb3doWkZoZFhF?=
 =?utf-8?B?dXJkSHppNE5STjBITjNpMHZad2lRNXRGcHdpbkR3K2pjTmpYU1BjSEVQMmF1?=
 =?utf-8?B?ODk4cFdDbFBFdWVTTWZxV3F5YWoxa2tuVGlxSkg0WGM3anIvUkZOelg4SFpN?=
 =?utf-8?B?aTZTM3J6aUNoU2FWYXJCZm5qUytseU0zWkF5bkNndk52WHhDRTJHWmM3UmFD?=
 =?utf-8?B?ZVhFTXVqWnRhVnp6WGdWek5JcG5QNER2NHlJODlvUFhtaGFZQ09TS3hMT251?=
 =?utf-8?B?aXZKV0RzbHMxSWVybmxraFp6S0ZpU0xmR29LT2lHdzMxbHBnMWV3Y1FIT1Bi?=
 =?utf-8?B?dnVVRTdGWEo3RjNkOGZPU0FJcGlvWDR6VXM5OWVUUEVsbXRvQkdPaEw2SlN3?=
 =?utf-8?B?endSenRtNTcydHVaemNvUkd4SUxTTWpEL2VmTnQ5Uld5S1JSUitpSjYvUUE1?=
 =?utf-8?B?OXJSeElWV3ZzMFlkSm9DK1lRQjltNWNEdlhoM2RpTU1DTkFMUEFPMWNYdHBk?=
 =?utf-8?B?bVdHbmh6RWVsamdXZ0hsS2dndmFuMTRkMTRTVk84WFNzSndpRkFQR2JQUWlp?=
 =?utf-8?B?cGdBK1FSSlJ6UzNqZ3VpdVE4bW54Z1pwVXVYOTJpY3VHYU8wSnlxc01wbkJJ?=
 =?utf-8?B?b3FyMlBBdkJ3S3pWNE40L3Vtcys2a09GTTZBdmcxSVI3S3hrWkZORXpvOE80?=
 =?utf-8?B?RjdlLzR1YU1mbjkwcXY2Yy9wRnU1bjAweEx2M1lMb2Zibzc4MThZVVcyeWIy?=
 =?utf-8?B?MlAyUTVMdGpjZmxKYTlxS21kZnEvNWpPMVFQZ1N5UEcyRTl2Z1RUOG9UTVEr?=
 =?utf-8?B?NWZOYmc0TjdFblkwTk4rQ29aaFhTWHNsRHNKcTRxcFlvOWZHN1RHY2dXdDFk?=
 =?utf-8?B?azdkTHJOWWROL1hubVdrVTQ0anR0Ty9rS3cvM2pVeWE2VVk4TGZCYW5WT0hN?=
 =?utf-8?B?MXdJK0VRQ2x1UHpLREdoMndDOU9RV09odWZZVmhnRUFscjVlQ1gxeWlRZFdl?=
 =?utf-8?B?eDZNWVhxZXVrdEE0RVMrWnkwREwwcjJOMWlBZFVGZmZDWTR0SHZXSUF0R3Zj?=
 =?utf-8?B?M3VmVSt2YlBmK2pmbi91VC9FQlBZbTFtclFwWHdYNHpHZlBYNklJZy9VbGN2?=
 =?utf-8?B?aGlZaUIrN3dCdTNwd1B2Y2hVZDVjOTU1YlB3VGsxamFTd3FwS2gvMkhndFpq?=
 =?utf-8?B?OFhMVzdZOWVxY3ErSE9SUktXWWhHblZLWC9yNkFvMlBaMHZvTUkzQ1c2Z0Zl?=
 =?utf-8?Q?+Ku8remO+M8BP1bEcD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff7b0fc-d564-4367-9b4f-08df1305b9b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:45:42.2691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyfaVgxJc80kxx4MWoeXbJ30br4V/dMu8kCeuE6XGhMfM7BT2p7u54XSqfr2HHxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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

On 9/14/26 23:22, Davidlohr Bueso wrote:
> The orders for large base page sizes are calculated incorrectly,

No, they aren't. This system heap is just only optimized for 4k page size and doesn't take anything else into account.

And yes that is a fully intentional decision.

What we could do is to make this architecture dependent, e.g. on ARM we only use 1M/64K while on X86 we always use 2M, no idea what others use.

Regards,
Christian.

> and
> currently only hold for the 4K case. Order 9 is intended for 2MB but
> will be 8MB on 16K, for example. Adjust the orders/sizes accordingly.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 621cf238ef97..341631e4a9ec 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -16,12 +16,15 @@
>  #include <linux/dma-heap.h>
>  #include <linux/err.h>
>  #include <linux/highmem.h>
> +#include <linux/log2.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/minmax.h>
>  #include <linux/mm.h>
>  #include <linux/set_memory.h>
>  #include <linux/module.h>
>  #include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> 
> @@ -55,15 +58,18 @@ struct dma_heap_attachment {
>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>                                 | __GFP_COMP)
> -static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
> -                             HIGH_ORDER_GFP, LOW_ORDER_GFP};
> +#define SIZE_ORDER(sz) \
> +       MIN(MAX(const_ilog2(sz) - PAGE_SHIFT, 0), MAX_PAGE_ORDER)
> +
>  /*
>   * The selection of the orders used for allocation (2MB, 1MB, 64K, 4K) is
>   * designed to match with the sizes often found in IOMMUs. Using larger order
>   * pages instead of order 0 pages can significantly improve the performance of
>   * many IOMMUs by reducing TLB pressure and time spent updating page tables.
>   */
> -static const unsigned int orders[] = {9, 8, 4, 0};
> +static const unsigned int orders[] = {
> +       SIZE_ORDER(SZ_2M), SIZE_ORDER(SZ_1M), SIZE_ORDER(SZ_64K), 0
> +};
>  #define NUM_ORDERS ARRAY_SIZE(orders)
> 
>  static int system_heap_set_page_decrypted(struct page *page)
> @@ -384,11 +390,13 @@ static struct page *alloc_largest_available(unsigned long size,
>         gfp_t flags;
> 
>         for (i = 0; i < NUM_ORDERS; i++) {
> +               if (i && orders[i] == orders[i - 1])
> +                       continue;
>                 if (size <  (PAGE_SIZE << orders[i]))
>                         continue;
>                 if (max_order < orders[i])
>                         continue;
> -               flags = order_flags[i];
> +               flags = orders[i] ? HIGH_ORDER_GFP : LOW_ORDER_GFP;
>                 if (mem_accounting)
>                         flags |= __GFP_ACCOUNT;
>                 page = alloc_pages(flags, orders[i]);
> --
> 2.39.5
> 

