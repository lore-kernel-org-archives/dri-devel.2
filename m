Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2E3F94CD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3FE10EF41;
	Wed, 22 Apr 2026 07:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OL7lp+xI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110DC10EF0F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dthVVIERdlj1mFuE7Y/zMhw5JoLjOEDcdaYejbWtBHhyXKxQJDDzlP1DJq4P9liOW//tqH1HD++XpR/eJyrhxHutDzUpbETfOgeaC9T+bPquIS6HW0Zj5TMN6dqf3p3x9thB6PyjjgJcEDoVidGTqNPNLBSkmjXIKDEU9rWQhcdntYffiD3moiefYiJyyE7MguQ0PeqEU2CJ0ubMEL4Maq7awOEm+v2c7vbTcu4OLLok+USydcjGU+IAVWKIX2QOY/8q7aGa7bLqotkXgyS6Scl7edlDrbr8eUyXTApYsSaTp0j1+umTx3UOf+gnkLcTzSVEhdVEInar3rH9Z2OqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g4Ec19MTbsH0oDk7b4Z1+P9GZg8iPha3ZsaOisTSz4=;
 b=fiSeUrrvf/GiCB7VFqR/BWt2tolvAPdOO35hUgaOCVMqJjs5aQDUkWbVJZdq1mqmoP40r4vOs987oMFUiZtcU5azGAzkZuo6LdRmoUzwDO+w4flJgInyewRqtcyr99bcQo+Dj0UMxARhjuNv0UIMuRbxFeH1Xi2/kFDp9ABAmTMNCN8dzw4kAsBvmE1ddkD/6JU1qBuqc38nIn1MLeqCwjep1w+mYxM7zR/rikN4nxbEH6/y87yi/hAueHdRr+50P3luxts/motpWXiaB1LeWBAAJL9aBv24AameK2FaMvewHfIFz4gvMUk/vKp22kqdk9QnVW3L7ukWQz9sW51slA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g4Ec19MTbsH0oDk7b4Z1+P9GZg8iPha3ZsaOisTSz4=;
 b=OL7lp+xIOSvAL7lL1ttATmtvS66gbdxT1UFpjIatgmj9Kek9j2+g3XAa92/B80zho9tDGSXqUidsg09vrA3VoUV1ZAy1Uyac1RYDydgPeTInqcDYRV5gIHj5boq7PFh5K+88NlNanLvrNM4L3Z4GK26t9Bw0PBIDlpP66KTR9bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 07:10:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 07:10:10 +0000
Message-ID: <9034246e-3971-4fad-94b7-80f4ad0e29db@amd.com>
Date: Wed, 22 Apr 2026 09:10:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: system_heap: Optimize sg_table-to-pages
 conversion in vmap
To: Barry Song <baohua@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Xueyuan Chen <Xueyuan.chen21@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>
References: <20260406214938.24142-1-baohua@kernel.org>
 <a6d1c89a-3c71-4e06-adcb-56595071dcc2@amd.com>
 <CAGsJ_4xquCzQLbvpkC8arAN=9KhrAkdPdxnB=v85GvvQu23Xyg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAGsJ_4xquCzQLbvpkC8arAN=9KhrAkdPdxnB=v85GvvQu23Xyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 7689d6db-51ea-4d19-b5c9-08dea03e30b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f9uQLdc8vu5UxmNPBWeNu8ORlTbDvV7qYkWz7YDMq7agJQLJnKMxK0YEhkxZMptMFmeEHD/XS2MqsDEzfBDpWJudTzKt9Oofye8vifAfZXBH8AlVObMubLNfsLqpvw9ITv52cdZ+NYWfnN5CHfQKepUJrWnMCWd8b24UHjNcCpLNK6WMcn4DDAr1+HIy4YsKvM4HeltUt7KF/FAu0hNhMr41l0GiOn3pjeZVZnFcDOdVP91/ATa12kebRGcKm2sdfxtJZu9AxZ/YOXDS8csY+HobH3CKMpIURJq5g3NgPmYs3u3U3tKNjm4VRJ2nxI30iuVD8GrqM8he6+WfR5Amv4mziRbQb2474VmWaXF7MR9LPIdv5EirGC03p7YS2Mi5eBlmUoNR/CFfDUQu9sUvUSRdwUSlTuBF8etwR3xTA3PZIf1+6y1eSvjlI7FHkHs4mypwiQ+rpDVLwnS5nZvsg8+BqdzQIhfuoJCnMQiXmVPA7FaD8jMY3Ji0AxCPQWTajUaot/Tt3GOBfPwQ5zGU2jh+giVYOgmzUELcDBFaoNQGXeFaFw8vtzhb3qW2tMFC/hQgCb0p4eDrb9+MGneeIhMhGHvy8FJZ/ZupX+85c3dFo9Wg7C4ylNNE94S+5VjLfg6OJg3er0XalvLm45HK/1CtHrygouK6OzTeI4ezXOWOoC9tXTI/PkjwIS9LpR4IpCrGSaoKbW4v2vVyvfpmXy2xIA5LhskNI8EHLtmlW+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEpCaWV6TGRKQlQwSGc1bnpiWERpSm9EbkRhSzdlOXRubzc5UTM5dTQxS2dI?=
 =?utf-8?B?VXBRbHJ2SEIxS0FUWkM1MXdyaXlnRXgvcFE2S1Vqc1BDL1hXeFNaanZvMkc1?=
 =?utf-8?B?T3pmWlZMTGdYcXZmMTVIemh6MXA5WlNlTzFXTkFBZWIzTWVCVkNPdThqc2JX?=
 =?utf-8?B?eWlUTUFHTE9jYkFlM0YyUHBJWWE3T1RsYWVaZk9Hc01LUWhWMEkwUWdVT1Zs?=
 =?utf-8?B?MDdHQlZVcXAyYm1hM09jeCt4dU9SMWZBOHdjeXoxMzhTRHR6L0c4QlFNRGI5?=
 =?utf-8?B?VXNjRW9mcnZFNWJyeFN0Mm9jbmI0OUdwZUtiQ2xhZXVkaklHek1ZQTg5WUZi?=
 =?utf-8?B?R0w3MW5XY294cXRvY3k4QjZCMlVXWW5aUDEyd3RJcXdvQ284WStnV0pxcThD?=
 =?utf-8?B?a3AzUUxodnFSR3JTZXFpVjBmTjkxOWVtRi9jQkpXVDRPZXV4ZDJjbVdEOTF6?=
 =?utf-8?B?bVVYa2hxQWo0UktzYjRLVnkyL2xzOEUxc3FSQTA0VmIzalFWYmlMUnpxT3JL?=
 =?utf-8?B?YTJGNmVTUXl1NzhUSkJYcVd5QWdQK09yNXFnZXVqZU1FaU1ObWE4cnI3WkJ1?=
 =?utf-8?B?TFlwT0pFbFI4akVYcURFaVNYY3lscXptTFNEWnZVeXZTUzMxWmZqdXVtdDZm?=
 =?utf-8?B?VXlIUW1kR2NjYWIvaUNOZnR4WndzV01IMWFNcHVidlhiVkRPeDNxaWhRbkpE?=
 =?utf-8?B?S1RxV1FSV3Y3d0crMTY5Z3ZReURzeVlvSmdaRWtqNFVObDNYTlRrcjhWK2U3?=
 =?utf-8?B?dWt4c2ZGVkpoNStUTE9tcHJKaUEwQUZhU0p6V0lkRk9RcURWTEZSR2NGZEJl?=
 =?utf-8?B?RFFFbzhJb21JeHJlSlRwVjgvVnBUdENtS0FsYjBWTk4zQ0lKOC9SZlczRDZE?=
 =?utf-8?B?OHU4ckdRSTkwMkRJSzdrc1ZNUVNXMmFxYmVSU2IyUjFWVEtCSGJTdG9yS0h3?=
 =?utf-8?B?cTNkOXVQcFcxTWViMlI4MEROd3o3WTMxWWd3WkxVQjNIWUI2ayttOURwQzZr?=
 =?utf-8?B?TTNQUjBPZHY3dVNqeThrTnZxTlRCeWQrTUsza1FVZjQybi9KT0dBL2JDSHha?=
 =?utf-8?B?dVRXbFF6cU1qOFU1UStnZTVDNEtsdTNvaDBDeVFzNWpHdG5HUjJZMzMyRmI5?=
 =?utf-8?B?TVNGOEJFWCtPeHZpZWxjY3dRZFJLcWdQZDFDUVdoSlBVQ3JBR0FMU2VQQVAr?=
 =?utf-8?B?bFpjR0J5c2xqVjNQVXlxVTJPZ1lyaFQ5SG5Pb1hmS2J3WWl1QkhwZ3h0V0tS?=
 =?utf-8?B?dVRSREJna3pUOUpqMTFPczcyNEFjdjQ3bU9RYnpoSjNZYnlTbWZ0ZjdvbVh5?=
 =?utf-8?B?TE41RUhjUzNlUGxFVGNPZ0R0ZGlyV0F1QUNxb1JnZFF6SWk1aHBZa09kaWNr?=
 =?utf-8?B?WU9yZGRzc1BpRVZZR0l5Q2NRK2tDUGVPeFJMYjZrYXRSeHY0QkRpNS9JYzNO?=
 =?utf-8?B?VWJUaXEzenZRVk5KZEpBenJTQVkvREYybE5YUC9PNjBlVHYyMitweWdWZzlP?=
 =?utf-8?B?TzlGZExKNG42UnR2ZnZZY0h5bFhhZXpEeGJaMWV1alhrTjNaODRuUlNvcC9v?=
 =?utf-8?B?MFRvdG12TWFNZG1ISGlpTmI4dVpGblNiN2E3SVlWOVVFYXJCQW9GM2t3MjhT?=
 =?utf-8?B?eTViOXg1ZVJDTzlweFk1c1crQ0oyU0lkSmoveVFMek9QTDdkRWxVNURCTEl3?=
 =?utf-8?B?Y1hUd3dQNDlHZmdqL0J6Smp6WGJrb1NBdTFRT213NnlEaVlEUncvRnpNRE5t?=
 =?utf-8?B?bVBxQ2VlZEpiTlZQSzdpalBBK2ZWZmNUNWJ2cUx6R0xzV3ZPUGZVcU9DZm52?=
 =?utf-8?B?U01Jd1Qva1RLRDg3RGFCaVpTZVdxK2U3WllHL011blo4ZjVOOUo2THRtN2pk?=
 =?utf-8?B?TkRKbVBNNE9Ya2piRWt2WEhuajdHaDNZUTRwOE1zazJtNlVLWW1XTGwycXND?=
 =?utf-8?B?QzN5V1QyMTZxU1U4S1p3UGlVU1NvZzhzK3gwWnZIVG9FVndLUDNVekwvR0ls?=
 =?utf-8?B?U0VrWmM3Sm5vY1A2TDc2cDdVUUxhZWtjMlJCSkpEc2xRSWNia0pmb1ozdThu?=
 =?utf-8?B?LzNRVTBJd3kxVkx2WDhXTEFiN0M5elVlM3hkd1hiZEZEZ2ZlNmpOOC9TQ2xp?=
 =?utf-8?B?NDNGY3RGT1pxTThUU0F3M0NTaXM1NmJuQ1ErQU5sYU1KM1lDUjVXRHBtT0Rs?=
 =?utf-8?B?QUxOdlFMTnB5N1krbG1wNjdIbzFCMnMyREwzSGJRNFdMYjR0bFQ4am15SENL?=
 =?utf-8?B?VmFRbjFYSXhITFc0cGE4UFN2endzU25yS3dUeXNHekhIY21PdUlhMGZwYTZK?=
 =?utf-8?Q?FYAWNnUP68Jhcg5VQM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7689d6db-51ea-4d19-b5c9-08dea03e30b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:10:10.1827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFuI70+QeGW0SdZoFSRKmzVPEBCVBgfjOIdSXisfGsn/TdnVNGNfp/8UQHVqLAU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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

On 4/7/26 13:29, Barry Song wrote:
> On Tue, Apr 7, 2026 at 3:58 PM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 4/6/26 23:49, Barry Song (Xiaomi) wrote:
>>> From: Xueyuan Chen <Xueyuan.chen21@gmail.com>
>>>
>>> Replace the heavy for_each_sgtable_page() iterator in system_heap_do_vmap()
>>> with a more efficient nested loop approach.
>>>
>>> Instead of iterating page by page, we now iterate through the scatterlist
>>> entries via for_each_sgtable_sg(). Because pages within a single sg entry
>>> are physically contiguous, we can populate the page array with a in an
>>> inner loop using simple pointer math. This save a lot of time.
>>>
>>> The WARN_ON check is also pulled out of the loop to save branch
>>> instructions.
>>>
>>> Performance results mapping a 2GB buffer on Radxa O6:
>>> - Before: ~1440000 ns
>>> - After:  ~232000 ns
>>> (~84% reduction in iteration time, or ~6.2x faster)
>>
>> Well real question is why do you care about the vmap performance?
>>
>> That should basically only be used for fbdev emulation (except for VMGFX) and we absolutely don't care about performance there.
> 
> I agree that in mainline, dma_buf_vmap is not used very often.
> Here’s what I was able to find:
> 
>   1   1638  drivers/dma-buf/dma-buf.c <<dma_buf_vmap_unlocked>>
>              ret = dma_buf_vmap(dmabuf, map);
>    2    376  drivers/gpu/drm/drm_gem_shmem_helper.c
> <<drm_gem_shmem_vmap_locked>>
>              ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
>    3     85  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> <<etnaviv_gem_prime_vmap_impl>>
>              ret = dma_buf_vmap(etnaviv_obj->base.import_attach->dmabuf, &map);
>    4    433  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c <<map_external>>
>              ret = dma_buf_vmap(bo->tbo.base.dma_buf, map);
>    5     88  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c <<vmw_gem_vmap>>
>              ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
> 
> However, in the Android ecosystem, system_heap and similar heaps
> are widely used across camera, NPU, and media drivers. Many of these
> drivers are not in mainline but do use vmap() in real code paths.

Well out of tree drivers are not a justification to make an upstream changes.

Apart from a handful of workarounds which need to CPU access as fallback DMA-buf vmap is only used to provide fb dev emulation.

The vmap interface has already given us quite a headache in the first place and there are a couple of unresolved problems regarding synchronization and coherency. 

When a driver would be pushed upstream which makes so frequent use of the dma_buf_vmap function that it matters for the performance I think there would be push back on that and the driver developer would require a very good explanation why that is necessary.

So for now I have to reject that patch.

Regards,
Christian.

> 
> As I can show you some of them from MTK platforms:
> 
> 1:
> [    6.689849] system_heap_vmap+0x17c/0x254 [system_heap
> 8d35d4ce35bb30d8a623f0b9863998a2528e4175]
> [    6.689859] dma_buf_vmap_unlocked+0xb8/0x130
> [    6.689861] aov_core_init+0x310/0x718 [mtk_aov
> 96e2e5e9457dcdacce3a7629b0600c5dbeca623b]
> [    6.689873] mtk_aov_probe+0x434/0x5b4 [mtk_aov
> 96e2e5e9457dcdacce3a7629b0600c5dbeca623b]
> 
> 2:
> [  116.181643] __vmap_pages_range_noflush+0x7c4/0x814
> [  116.181645] vmap+0xb4/0x148
> [  116.181647] system_heap_vmap+0x17c/0x254 [system_heap
> 8d35d4ce35bb30d8a623f0b9863998a2528e4175]
> [  116.181651] dma_buf_vmap_unlocked+0xb8/0x130
> [  116.181653] mtk_cam_vb2_vaddr+0xa0/0xfc [mtk_cam_isp8s
> 0cf9be6c773a8f14aab9db9ebf53feacb499846a]
> [  116.181682] vb2_plane_vaddr+0x5c/0x78
> [  116.181684] mtk_cam_job_fill_ipi_frame+0xa8c/0x128c [mtk_cam_isp8s
> 0cf9be6c773a8f14aab9db9ebf53feacb499846a]
> 
> 3:
> [  116.306178] __vmap_pages_range_noflush+0x7c4/0x814
> [  116.306183] vmap+0xb4/0x148
> [  116.306187] system_heap_vmap+0x17c/0x254 [system_heap
> 8d35d4ce35bb30d8a623f0b9863998a2528e4175]
> [  116.306209] dma_buf_vmap_unlocked+0xb8/0x130
> [  116.306212] apu_sysmem_alloc+0x168/0x360 [apusys
> 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> [  116.306468] mdw_mem_alloc+0xd8/0x314 [apusys
> 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> [  116.306591] mdw_mem_pool_chunk_add+0x11c/0x400 [apusys
> 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> [  116.306712] mdw_mem_pool_create+0x190/0x2c8 [apusys
> 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> [  116.306833] mdw_drv_open+0x21c/0x47c [apusys
> 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> 
> While we may want to encourage more of these drivers to upstream,
> some aspects are beyond our control (different SoC vendors), but we
> can at least contribute upstream ourselves.
> 
> Best Regards
> Barry

