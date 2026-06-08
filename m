Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91342CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C731910F419;
	Mon,  8 Jun 2026 13:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ylwqYdsA";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D86A10F41D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep+UUQAuaqq2VCW4LUTEZ+jlyWORGDnKrROma4RaV4qy7i+cMHky/CeqbqjhCmn43I8GLNe8uqSI7YQGUN0TwTm4UZYxLOiVb28IaGH3VTIduLirc/hUFQ/ehLV70NaJAT0661iA2g3/fjJGa5GIqPL2j+SL6RB+i+SBF1aW9gfjxAznxstelX9Z26uLgTQEObQnFPPbf5MWS42nNnHqzdPCS+2R3ffsojGsq48PJMzj25Ge0BbCPX9FAIlIaUQU3RNXAkxrHEU/UE1ySqotVSpl+P/IMP0d+qQI+hV+qvOdcjrS8ti96Alo/eEPmJVUzB5HZJoK8T83lo/V0xP0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9NUUiuF5j2bb81QIuz36SJ/RBj8+AGOvNYmi59zTw4=;
 b=PimhVdxJfJWGuZBqADoZ5LF+j8AB0QSlfICt5SzoEqD35p7gPP1/O3VJvP6dwsfThg9aN3o1QMZy8PEsTa1tb4/vY0QzJll8w3QnAoyBaDUGeqGgxkeRjpbUy5s5hjkutJ3UYmzoRSnsK+KMaCTcBEM8MSVAsLxKffL/4MtfMlRPb9OwQxcIf2O0eel1u9ya9B/5H5bWqhRFw6AK/dYim5PxB2Ovl31nSa4Of823hQF/1AyS/99sDMcp6eXMJpCavOcl3JsOxhPluh83gNPvJ3M7+xB4TyAdtWwz879N/SkccSZPjd5KnbpDWOCCS6v8JrbaR1dTEJxC0KG7GFjMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9NUUiuF5j2bb81QIuz36SJ/RBj8+AGOvNYmi59zTw4=;
 b=ylwqYdsAmJIkEdwueIDzqIm7KF39CcdQoCe5lfrfJqRUvOXBIun2zwXdkZsMazoJ7a2bbqYHSi6+wu23kOnGValkjok7dd0tyha/C2+Ai23zsuSQRqmKR1adf/OUxis7YqERT76Qr4VuXTxOn7kK+KskrYzgM/OglCYX6wIhNVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:59:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 8 Jun 2026
 13:59:17 +0000
Message-ID: <a51e97bd-39dc-492f-bd7d-f137423277df@amd.com>
Date: Mon, 8 Jun 2026 15:59:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] udmabuf: emit one sg entry per pinned folio
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
 <20260603-tcpdm-large-niovs-v1-2-f37a4ac6726c@meta.com>
 <bdce2488-fe77-4f36-9ed6-dd2c785fa7c1@amd.com>
 <aiMY8CpckM8Jav0g@devvm29614.prn0.facebook.com>
 <0c86f5d3-b5e9-4cac-aa9d-30c5c8ecca66@amd.com>
 <CAKB00G3opAoAYswsq2uz0Q6jgku8u4NthKOzCbSumZ0qK7QxcQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAKB00G3opAoAYswsq2uz0Q6jgku8u4NthKOzCbSumZ0qK7QxcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:208:32e::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: b38fb79d-df85-40fa-3e40-08dec566214a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|10063799003|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sowkkH5VJNgpxW0cbgb7TBleErXgSgCN+YosuSKXQZi2tW5oYouxuvGqXxqCg+tfv3Md81Nvob6w1CQrlbOIQmUxp8QiQrF9+yET3ehts3DjCLXe4nSur/YAJy6UJMhFWBoZLfVu2UZTAildwfjEhNPNOzNj0UADq4KqImVVzjLV3xHO5XqQovwEQr36nGlHw+TVSpyRGyMAaNUXCRvXGhl2pdZCvd+sm0kHJNlYfnAbbrX53/qVXhLU9mxWj+HNJmM1yfndtAV/eLstiTMYl786U2WuGWLsP5xe2Y4rOhRgRf4Vfuk1kZ5ED+PQBtt3tZq876JhI6lafz5a1wIr40sOBIsF+23w3cjRAwJHpayBSaDNp6DFrXwKk9AB83YLUx+tfUsSZ6ta1Hn8/RiLUA28i6kuIYhfjeXo5NaXAceRZ8BVfOJdCr/T9aoUdPzqzz79Bzcd57PC0G57Df//dACXThWXVHKKlYkLj2TNem43YPTnD6of9ehD6MCOs3gVSL/r1HETjjZwLwXuqK+BqPlPRu2UqrZ7R/3LYXUlbRnqi5aYFCztE0eH/UhX5JxLMlrulrdXf9Ojuxvv/y7VwsOR+D/jdjcYy4a0sRJUQhIYJVuB31aXOpP/3j4DymtGCSPx/ZzbhSgdxW2EDeJirb1b9OsKlaB83KAhn+IcHkQZSgs78Syiqa20FYJJ3Rpa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10063799003)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNLRGZCMThncjlIbHkrQjRldXFoMFpENVRyU1NkdjgzaSt0L3RtMXlMdU5W?=
 =?utf-8?B?SWdsL0NkYk9Hb1VNZWpQenFHdEJpR0ZwUHN0MGg0Tml5Q0dESi9JVkVteW9v?=
 =?utf-8?B?OTFPZ2I5VXkrdHNpQXdiaUQzOTlaOVNZS2FERWw5eDRQUzJLVVp1dy9CaHhJ?=
 =?utf-8?B?UTVFSWRRWWhxYUVWY0dGQndDTVJTaktTb3pyUmFqVTlORGFoaEo4S1lERnF4?=
 =?utf-8?B?L084OCtNeTdqSW43N2gzZXF1VDdUbEtJNUhkY0NCWEFwbENPNitleW9OQUdU?=
 =?utf-8?B?N1o0VmhpWW5BU0RIQ1ZrbktmYkNNWWZhWmwzVFRVRzFjYnhIOHlPdDRQaUE0?=
 =?utf-8?B?aEN1R3EwQlloaDIwQzE0MHdiczhsODFOMmYyVmpSMXNrM0pZdm5oT3crSVlU?=
 =?utf-8?B?U2tWY0RmbkdQYmFRczhPaHVxRmE1UysvSUNPZEZyU3B4YzZpejJON1ppM1RG?=
 =?utf-8?B?TUYyV1pTejFUSlBld0t0aXdWSjcybldPTnBEb3l2QXE0aEdFazdPVDA5dmd5?=
 =?utf-8?B?bXFLcndLOU9maXpTWkFGS216MEhJc3ZSdG90ejhSU2U4WmVSdUs3M21oMzRo?=
 =?utf-8?B?Q1ErZG83WlFadUNQYXIwUmx0Z0RjSTBDZnIwYUdEdncrRzcxdDhaVFFrVlRR?=
 =?utf-8?B?elhJQUc5U09BUTNvcUt3disrSWFTQU54R0liYmxSdGpEM0tKeE1FSWVwR1hH?=
 =?utf-8?B?ai8zUml1YS9rOWoyeExxbUFWREx2ckZHbEdMTmZwZ3NudnZOMlZIeFFwSkhh?=
 =?utf-8?B?OE9FNlE3MStYSHdWblk2dy84Q3FtQlorOFJ0aGVaZitSekNzbkl3VmE0SEdr?=
 =?utf-8?B?L2R4VHhEKzIvYmRyVFFzZnNmUHZkWERtL2ZTcE8rOVcyRGlpQTRya0h5ZUcr?=
 =?utf-8?B?akRFODhud1I2OUF2bGx4ZHgwVFhERTNmeU4vSGMwYU9Da2xtMmpJeEJPWkNG?=
 =?utf-8?B?VmFBZEhjaGRObWJWcVZ4S3IrcVBPbERsT2ZldVR0bFNiS1pRQm8wUlpFbHhj?=
 =?utf-8?B?OHRDbXdETElCQ1I3bjhXaFVmbnhmbHU5dzFBa0N3ckR5dVNYOTNDdmpkcHNh?=
 =?utf-8?B?QUtJditLc284QVBRRjkxU2k2SVcvalh4d2MzZENTdVd4WHQxYnV5ckVMd1BZ?=
 =?utf-8?B?V3RxSFdZT3NhRGVrNno5RkR3NnAzU3FWQTlCVC9TdS9VWEk2eGxjVmRaOXBw?=
 =?utf-8?B?QmJiWkd5ZlhkL2I4bmgvd045Y3JmSkhYUGF1U0ZDT0VibDlKU1IrK2tTVFZo?=
 =?utf-8?B?aVdqZXZhck9wSTNHTlU3Kzd2OUE2RDNlN2xhYXpEWUdESExRK2FpK3RqNHND?=
 =?utf-8?B?Vi9XRHc5MURzdzNoR09xdW1mTDlBWnBja0RUczRVN2JoaDFKUkxqT2gvWkVs?=
 =?utf-8?B?eHVxZEYrL05CbVVicG5reklIVzhlZWE0UDBsOUJhT2dZMHZUOXpOOU0rU2V5?=
 =?utf-8?B?RURWNCtGbWprUkpHSWVIeHhiREpobHlVeTA4UkQxYmEvWk5PaTZ6c25TeXhT?=
 =?utf-8?B?a01YKzlWNG5xR2h0SXBBVkhtVWhYZ3lyQWU1YkU5WmY3T1FLeEVxQ0V4ejNt?=
 =?utf-8?B?QXA3dnJ2c0s3Y3ltRmJhbERGeE1zWkM3Vm5YbFYzRkducmN6OWlub2EvalRO?=
 =?utf-8?B?by81c2dZUEJhaHZOb2Y3WlA4Q1EyeFRhbUdUOWlsdkk1VzVkVG8xS0tObloz?=
 =?utf-8?B?NG1weDlMZytnZHdNaDFqTEU0c3kzMTZmdDVsWGZpMzdlam12Z3llczQzNXAw?=
 =?utf-8?B?a0V3T2NaMWE3WWVWSmZKdkM1TU0wYncyYTJIaFhaUE9nN2lGZXlvWmtGWUt1?=
 =?utf-8?B?NU9iRlgrUytrVWI3NmxRckQvTVJHNGpMTllzZWV3Rmd2ZlJEKzFSY3Q5TVY3?=
 =?utf-8?B?UHhJQXkzakFPZENvU0svSE53OG5nYnhGVE52eTRkU2FYdnVPOVlQbUh4UnBh?=
 =?utf-8?B?ODFxUmw3MGJpYXlGT1l3ZXQ5TjlMK3lxNWZWTEx6ZzY0WUE2VFordnczZHha?=
 =?utf-8?B?dU5qbTVaVGNjUFJOWGpGWldHK0RSL1dEb0VINFY4ZEpSZkxuOTBSQzArQkR4?=
 =?utf-8?B?WkhQZGNOZW54VHBWMXAvb2tybW9kcG51NnpLOWxxL0xYeWw2dXpMamV3TmxB?=
 =?utf-8?B?TUl5K2g1SGRBcnhMNXExWG4vblhWbFBKRHpMTzdXSlh6OHZpOElPalIralRO?=
 =?utf-8?B?WXk3Y05ZZzVOYkYvMEMxMFY2Q3ZidzA1aVN6dlN1UUxkdjVjaUl2dXBDUGpD?=
 =?utf-8?B?bTdHMy92VEh1V2l4MEdvYnAzOThwOE8xN0wwKzJKZVVrNU9kMEMvb2VuUlkr?=
 =?utf-8?Q?PdsqcNFJ0NuxrrF4q5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38fb79d-df85-40fa-3e40-08dec566214a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:59:17.2139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LayaBdD/cYOWVZImWkl8CxH4yZCvqOtvYxYU4HMkb9l2Xtpo9PMeB7WUm8lajznT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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

On 6/8/26 15:55, Bobby Eshleman wrote:
> 
> On Sun, Jun 7, 2026 at 11:42 PM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> 
>     On 6/5/26 20:44, Bobby Eshleman wrote:
>     > On Fri, Jun 05, 2026 at 11:30:07AM +0200, Christian König wrote:
>     >> On 6/4/26 02:42, Bobby Eshleman wrote:
>     >>> From: Bobby Eshleman <bobbyeshleman@meta.com <mailto:bobbyeshleman@meta.com>>
>     >>>
>     >>> get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
>     >>> underlying folio was larger.
>     >>>
>     >>> Instead, walk folios[] and emit one sg entry per folio. When folios
>     >>> represent large pages (as is for MFD_HUGETLB), each sg entry is a large
>     >>> page. Normal PAGE_SIZE sg tables are unchanged.
>     >>>
>     >>> Required by net/core/devmem to support rx-buf-size > PAGE_SIZE with
>     >>> udmabuf.
>     >>
>     >> That doesn't explain why this is required.
>     >
>     > Sure, can definitely add. Devmem currently requires dmabuf sg entries to
>     > be length and size aligned when it allocates niovs for NIC page pools.
>     > Though udmabuf is not violating any dmabuf contract by emitting
>     > PAGE_SIZE entries and the above restriction is probably more a
>     > shortfalling of devmem, by emitting a single entry per folio this patch
>     > allows udmabuf to be used by devmem for large pages.
>     >
>     >>
>     >> Please note that accessing the pages/folio of an sg-table returned by DMA-buf is illegal and strictly forbidden!
>     >>
>     >> Regards,
>     >> Christian.
>     >
>     > It seems both devmem and io_uring zcrx at least introspect through to
>     > the sg-table to build NIC page pools (not accessing the memory itself,
>     > however). Is there a better way?
> 
>     That's an absolute NO-GO! We need to stop that immediately.
> 
>     Touching the underlying struct page of an DMA-buf exported sg-table is strictly forbidden.
> 
>     We even have code to wrap the sg_table and hide the struct pages on debug builds to catch those issues, see function dma_buf_wrap_sg_table().
> 
>     My last status is that the NIC page pools are build directly from the DMA addresses exposed by the sg_table.
> 
>     Was there any change I'm not aware of?
> 
>     Regards,
>     Christian.
> 
> 
> Oh no change, your mental model is still current.
> They just go through each sg and use sg_dma_address() on each.

Ah, thanks! That was a near heart attack :D

Yeah that is perfectly correct, question is do you then still really need this udmabuf change? I mean the DMA API usually merges together contiguous DMA addresses.

Regards,
Christian.

> 
> Best,
> Bobby
> 
> 
>     >
>     > Best,
>     > Bobby
>     >
>     >>
>     >>> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com <mailto:bobbyeshleman@meta.com>>
>     >>> ---
>     >>>  drivers/dma-buf/udmabuf.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
>     >>>  1 file changed, 42 insertions(+), 5 deletions(-)
>     >>>
>     >>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>     >>> index 94b8ecb892bb..f28dd3788ada 100644
>     >>> --- a/drivers/dma-buf/udmabuf.c
>     >>> +++ b/drivers/dma-buf/udmabuf.c
>     >>> @@ -141,26 +141,63 @@ static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
>     >>>         vm_unmap_ram(map->vaddr, ubuf->pagecount);
>     >>>  }
>     >>>
>     >>> +/* Return the number of contiguous pages backed by the folio at @i.
>     >>> + * A udmabuf may map only part of a folio, or reference the same folio
>     >>> + * in multiple non-contiguous runs, so folio_nr_pages() can't be used.
>     >>> + */
>     >>> +static pgoff_t udmabuf_folio_nr_pages(struct udmabuf *ubuf, pgoff_t i)
>     >>> +{
>     >>> +       struct folio *f = ubuf->folios[i];
>     >>> +       pgoff_t j;
>     >>> +
>     >>> +       for (j = 1; i + j < ubuf->pagecount; j++) {
>     >>> +               if (ubuf->folios[i + j] != f)
>     >>> +                       break;
>     >>> +               /* Same folio, but not a sequential offset within it. */
>     >>> +               if (ubuf->offsets[i + j] != ubuf->offsets[i] + j * PAGE_SIZE)
>     >>> +                       break;
>     >>> +       }
>     >>> +       return j;
>     >>> +}
>     >>> +
>     >>> +/* Count the contiguous folio runs in @ubuf, one sg entry per run. */
>     >>> +static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)
>     >>> +{
>     >>> +       unsigned int nents = 0;
>     >>> +       pgoff_t i;
>     >>> +
>     >>> +       for (i = 0; i < ubuf->pagecount; i += udmabuf_folio_nr_pages(ubuf, i))
>     >>> +               nents++;
>     >>> +       return nents;
>     >>> +}
>     >>> +
>     >>>  static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>     >>>                                      enum dma_data_direction direction)
>     >>>  {
>     >>>         struct udmabuf *ubuf = buf->priv;
>     >>> -       struct sg_table *sg;
>     >>>         struct scatterlist *sgl;
>     >>> -       unsigned int i = 0;
>     >>> +       struct sg_table *sg;
>     >>> +       pgoff_t i, run;
>     >>> +       unsigned int nents;
>     >>>         int ret;
>     >>>
>     >>> +       nents = udmabuf_sg_nents(ubuf);
>     >>> +
>     >>>         sg = kzalloc_obj(*sg);
>     >>>         if (!sg)
>     >>>                 return ERR_PTR(-ENOMEM);
>     >>>
>     >>> -       ret = sg_alloc_table(sg, ubuf->pagecount, GFP_KERNEL);
>     >>> +       ret = sg_alloc_table(sg, nents, GFP_KERNEL);
>     >>>         if (ret < 0)
>     >>>                 goto err_alloc;
>     >>>
>     >>> -       for_each_sg(sg->sgl, sgl, ubuf->pagecount, i)
>     >>> -               sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
>     >>> +       sgl = sg->sgl;
>     >>> +       for (i = 0; i < ubuf->pagecount; i += run) {
>     >>> +               run = udmabuf_folio_nr_pages(ubuf, i);
>     >>> +               sg_set_folio(sgl, ubuf->folios[i], run << PAGE_SHIFT,
>     >>>                              ubuf->offsets[i]);
>     >>> +               sgl = sg_next(sgl);
>     >>> +       }
>     >>>
>     >>>         ret = dma_map_sgtable(dev, sg, direction, 0);
>     >>>         if (ret < 0)
>     >>>
>     >>> --
>     >>> 2.53.0-Meta
>     >>>
>     >>
> 

