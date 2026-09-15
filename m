Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A651C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FB310F494;
	Tue, 15 Sep 2026 15:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="apzKIN0G";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD2010F494
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcE9/gcDJbP7r/vpiRKnYiD+wgxYOTZpG7ZFI3dUe23SetAnDHKPBKe9AA1jvchmlZrJxMuIRAl5LR1F/kt3lip7AOY02eHkxfsh707m39cqggLn3MtGL5BpHS/sJfxqM1a5CngGqKSPZKJ4H7c12UqrpigJnjvMl0MwBp9J3PQsN4ZhUrtsnIr2xGHI63AGTzw0FG+7SP5Nt9IwHLEpE7B6WeHqTjKl/yW9P1TkVQt74I81E3kg+LJZR7z0Iek7pgA6Abt2AajfApdpJvZlBYpBng6zR0eziIkWg4vf9LyI/LdeCPXjuix5RwRAdi4zhqh/Pr0kLl1JQPqH9iWwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmX4cOdA3b0w0Us2W5v48sMIIgFyEkE7KoHE4nOrpJk=;
 b=VQIu/sCtfUVVrIOYSIhAx2FfqReu+yZmDMeDhm9y1xNWThab4YedqL/FGwMO+yOLwyWbb8ijVJXn6qg8KJ2cPvpWYqSjQD0JTjccz8Nz6o3K6NH69760w7A2NNqRkILNEdFlZhPwlUQb/P3s0NsiUrpdUZnR2eQZqMSEKyKmvxy2eiMEEM2vS+pvdZ2eCgsnkGj87QQ6d0u+AQB9m3ZoccvddlTxnQCXIOCsWwoykRgq/Wm9oDQQu5aXJbhNH8l/F4yPo/DEumPmoEwpe2HmC7lY7bYz+cn1sw9kwDKUPwNHk9znVAv26YR9vtkdoM5Rk5BxgjKOLAG2UOztuQDFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmX4cOdA3b0w0Us2W5v48sMIIgFyEkE7KoHE4nOrpJk=;
 b=apzKIN0Gn4ChcR/lKu92LpM+NbIJGHgW/9yAwkQ9fhh3ahi5BH/oHKOI5mRNSQuh1cJCMiy3pnB7zW75C8Q2T5YH1mejNkoHYvSO/0FYygDf4xAAMXzNx4LmnXfjGpm6FnQJ2A6QpcEsTobm5OcmTWxC5zYag+B+B7jcyB/MOLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY0PR12MB628325.namprd12.prod.outlook.com (2603:10b6:930:130::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:44:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 15:44:29 +0000
Message-ID: <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
Date: Tue, 15 Sep 2026 17:44:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, sumit.semwal@linaro.org,
 phasta@kernel.org, benjamin.gaignard@collabora.com, jstultz@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
 <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
 <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY0PR12MB628325:EE_
X-MS-Office365-Filtering-Correlation-Id: eb61c810-0399-497c-994e-08df13403ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: AE+ddL1z+Vo2f9w8QmabRYvmc/UpJRDgOCtg5N8o+zGZ2b/cWis5vEKOyvSSYyi2uqUlYPlinMEgtgor/db1nbzOyM7EWWzdtB9T/Gy2CSf4CWzWY8vfQdeoZHGHj3+JcCWKg+ijq+tjSKJexlw5dMzODNiH+NRxs4WLASVyrXaFswOMfOfU7y4e1WEY5VmP4tUekJq2s5CSUekYxcAUmiY1u+wlSkVt2jqaOTb5KpLoOd5sVW8ciRdO0+HfGTqKZC27wg2kWmS07GGH49XutsRrroEbxYR6IO+xs2lC2OyqPr1w9KQu7b12VINtwUUM52u7UL7hfYx1rFI8NcBh9ujakWOeX5wmJ2YCwhG+u8E360dAJ3A04OxRFDT5eeDEXRNl9TJM3duD62m6ZGVlhVqJHiOPEMw5904wci6ihNi2siXwcvTfgp2A7rl33hohF+dw3myhAjFOcj8QpZJb8Iv9sKAN2YO3HMLSZMwdXQAwCZ9UCgMd6J0Uc3WzcFdSrZZGVDi2AomAG2NIo7Jc+VDBP9861OueJObMyhMs/yGMkZyOXYcDB27QpQI/yjzyKRjt7R8QH65q5/EV45awRqKAK1mIfJ9yerKAf7DFH1zKcOFpDBq222byQP2K/UUKjqmxbqvGcVhPCOftZZjy1Y/iHKDkZIciPnrx6FOgz+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDh2VmxrRXdubTdVenBSZjVob2lGVUF3S3dZMmxlL3J6amF5aktCeElCaXA1?=
 =?utf-8?B?aWZMYnNaUmZEMU1mckIzZkVmUk1NM0pHZnBwU1JEdFRCS0svTHg5UVpLMGM1?=
 =?utf-8?B?K2pCdzVLSExrRXl2WjQzb0xvbHViZ1hWMDE3M0c3cWZCVEdhcjljNGFDOHlI?=
 =?utf-8?B?ZlZmOWs1czVJNnFtNTlybVRaZllBckwyWXBuTkZ5MjhVRUxMQ1BPejR0NE1U?=
 =?utf-8?B?anRsdUJrT1kwRzlpN1RlWkt6c2NuODYxSXg5L2g5RVlJOXRURWVKVGxaWEQ4?=
 =?utf-8?B?N1lldHFOdStPYWk2V1ViUmtkTE1uZDdUcHlXVmJ2MmkyYkpKbkZiR0JhQ096?=
 =?utf-8?B?NDJGdlR2TnlHdmNPenorb0ZKalRITi9SaUJ1bS9mMkszTmFyRjBrVWhoemJR?=
 =?utf-8?B?dHBoRWRIUURQaUluaW1ST1ZSM0lFQ1lNM1JtV211eEJveTBack15czRNMDE2?=
 =?utf-8?B?MFFaNVJiWnE2RVBJUTZjam04dk9KOGF2c0xzS2FwYWFUb2xETlVnWUpkMkFT?=
 =?utf-8?B?RGM2Y1U5TGZMazZEaDUwS1FVSjd4YWZtSWc1VmNWUlNMbk41TzVUZDBpRUFr?=
 =?utf-8?B?N0VqS2huNjJsL3NEcnVRcm9EYVFHNTBkVWs0K3lPeTNmZkc4Vm5ETWFkN1Bo?=
 =?utf-8?B?NGh2U21Mb2V3ZlB5MHY4T0RwYUVZWXVkYlZ1Nm1OQmt4enBRUlRXSVV0clky?=
 =?utf-8?B?S1V0Uy8ydzFPd05iRTk1K0c4Njk5dS9xK1l0aEpxUVA5OWY0MGJqSGhoeTR2?=
 =?utf-8?B?L1NYcmEvSG9HbDhBYjF4NU90Q256Wm05dTRGMWtpYWJBMjg5bzJFKzZiUjY5?=
 =?utf-8?B?aG1pZzIxQWpzSWpDbEdJVExLbUpBamI5RFJCMEZSeDUvYnovV1p0d3krV1pu?=
 =?utf-8?B?M2xNUXZHSzBTdVNqdWFzMGZDZllHTlRpZVZDNFVJNVYyRnAwWnF4Z0pqNG9n?=
 =?utf-8?B?bXJHSkF5MXk2enVVL0MvalRWT0lOdFI5eDNKVnRXbzQxdE43V0xGOHlESjE4?=
 =?utf-8?B?MnljZkQzQitCUHRaMkxHSjhYSXV6eWQxZFAwNEVOak4xeFhIcDA5ZGRuU1N2?=
 =?utf-8?B?V3BXbEhGVXVJNjFXeVZPMFJsZmdkeGtZalBueG1tcXg1eGhqQWpFMXdUMGxJ?=
 =?utf-8?B?N21zZFFyNDk5VHBzaDRGV2F4SlcvZEtmNUxpeUtGQTZLSUlXNkQ3TjAvUFdT?=
 =?utf-8?B?SXdFejdwRC9MOHJZZVVpNFFhZCtjQzhrTm5ybSt3TnVFUzlNRFRVVlVqY2dk?=
 =?utf-8?B?TmtyZUM0K1liUncvRFYwdGl6ampIRWxXVEZ0L3F3U3VLckd3cXNSOU4vZnkv?=
 =?utf-8?B?SldxK0NCUWFJZ05WRFVoQXdNeklGMTVray84MkJCN2ptdVRJblBsZ1padUh5?=
 =?utf-8?B?Y1pJUmlONFRWRVBmNHlwYzUvRTZyQXd0Z1pUMGpNRlZyVU9LSUlhVDBlRjBY?=
 =?utf-8?B?TFFiWVkvZVVCY3V6Q1lpTEpEOXkvRXhEb25xbGNzVVMyOVBCZ09CMGdZeDZC?=
 =?utf-8?B?YzVZQk1TVkwwZ2x5SVBiY1JTeXh6RCtZVVpIaG1obzVDUHg3TzVUUCtYMHp1?=
 =?utf-8?B?L21KT2F2TWlucjlNT1dITndWMGxwT0VzWWYyOEQyVUkrZVp1K2M4bTZWL2lW?=
 =?utf-8?B?K3JML0h0UG9kb2tQcjIwazArOEUyZlVQNTVmd1BRd2FDdFlrYXJSdjRBU2hz?=
 =?utf-8?B?WEEwU01DK2x0Yk96d0FXNDZaY0Z3QVQzRVhuanNVNzVKbUphZEh3SXBHMUZJ?=
 =?utf-8?B?Um5ackVucGVEZStXREFCMW5iTURXdUxnaFRNb0xhczNCYTJibmxlM0hYYkxM?=
 =?utf-8?B?OFgyWXEramtZZ21EV1dYQXZqS1lyUWd1eWNZVkRINTgvTDhzMnp4UStkZUJI?=
 =?utf-8?B?UU9qNzNLcFlkUHEyNFBzOFYycnRRVG1QckpuT05FQ3ljRmVDNjBNNnd2Uzg3?=
 =?utf-8?B?Rk1vSU1LbEhsYmhzNTJEUjBzbWoveXRVZ1VzMjNaT3Jhbm9NZXI4MzJWSndx?=
 =?utf-8?B?eHh1Lyt6eDlIVzVhQ3pkdnJmME1CTGZnOGJsTDFzdjBCclJjNUxZWm5JUVV3?=
 =?utf-8?B?NWFJbC9QS2VpbmJ2aisvTFdreGk5RjZPcENrZzdqVUVqdlMzUmZQUzVweDRV?=
 =?utf-8?B?blh1T1lUaWFzZ2tpWGZNZkQ4Q0xEMTdqWExob1dCVGtqT1F2eW9tejFJMHNz?=
 =?utf-8?B?S2VyUlRSUHhuRkpsbWlXRkdseEl0eWZ6aHpEZGFRQXdRKytCYUNqZ1VkMmVq?=
 =?utf-8?B?MGo0cW92MXN3Z3JkdTVVamxnRkhVN3ZaSElvWitNdEV1R09pRitiTjNscGhB?=
 =?utf-8?Q?M06+mgC4Wb25yIWXVr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb61c810-0399-497c-994e-08df13403ab3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:44:29.6330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yaz+r7b6icqLfHdZqby/+n4I6gxIrg7msy92up9nCGRK9wSQiVEPbBW6fauGLgdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB628325
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

On 9/15/26 17:33, T.J. Mercier wrote:
> On Tue, Sep 15, 2026 at 1:41 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 9/14/26 23:22, Davidlohr Bueso wrote:
>>> With 4KB base pages, the system heap allocates buffers in 1MB, 64KB
>>> and 4KB chunks. The conventional Intel VT-d second-stage and AMD-Vi v2
>>> page-table formats, and Arm SMMU's 64-bit long-descriptor format with
>>> a 4KB translation granule, define 4KB pages and 2MB/1GB large-page
>>> mappings, but no 1MB leaf. A 1MB chunk therefore requires 256 4KB leaf
>>> entries unless it can be combined with adjacent chunks into a
>>> suitably aligned larger mapping.
>>
>> Yes, it was an intentional design choice to *NOT* optimize for AMD nor Intels IOMMU here.
>>
>>> Adding a 2MB allocation order provides naturally aligned, physically
>>> contiguous chunks matching the 2MB leaf size, without relying on this
>>> being accidental for separate smaller allocations. The new cost
>>> is one failed order-9 attempt (keeping current large allocation semantics)
>>> per buffer when 2MB pages are exhausted.
>>
>> We have plenty of experience with this with TTM and the overhead this results in is usually not acceptable.
> 
> Overhead from compaction and reclaim to get 2M pages? That is disabled
> for non-0 page orders here in HIGH_ORDER_GFP.

Ah! Thanks for pointing that out, I misread the code that __GFP_RECLAIM is ORed into the mask.

But the question is still why? Without reclaim that is pretty much an useless feature on most x86 boxes.

Regards,
Christian.

> 
>>> Two benchmarks, measured on an AMD EPYC 7313P.
>>
>> Why in the world are you testing the system heap on an AMD EPYC system?
>>
>> AMD clearly doesn't recommend using the system heap on those boxes for ROCm, so I'm really wondering what combination of HW you have here?
>>
>> Regards,
>> Christian.
>>
>>>
>>> (i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
>>> measuring map/unmap: with the v1 page table restricted to 4K/2M/1G
>>> (amd_iommu=v2_pgsizes_only), a 1GB buffer goes from 1024 1MB chunks,
>>> only one of whose 2MB windows was superpage-mappable in that run, to
>>> 512 2MB chunks with all 512 mappable. dma_buf_map_attachment() costs
>>> decrease by ~16x on average with ~32x for the worst cases. Unmapping
>>> that buffer drops from ~500 us to 1.25 us.
>>>
>>> (ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+close
>>> across various thread counts decreases by factors of ~3-7x alleviating
>>> allocator's zone->lock contention by being PMD order and therefore is
>>> pcpu list eligible. Once the buffer size is large enough then the cost
>>> of the zeroing takes over.
>>>
>>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>>> ---
>>>  drivers/dma-buf/heaps/system_heap.c | 13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
>>> index c8959eadc71d..621cf238ef97 100644
>>> --- a/drivers/dma-buf/heaps/system_heap.c
>>> +++ b/drivers/dma-buf/heaps/system_heap.c
>>> @@ -55,14 +55,15 @@ struct dma_heap_attachment {
>>>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>>>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>>>                                 | __GFP_COMP)
>>> -static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
>>> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
>>> +                             HIGH_ORDER_GFP, LOW_ORDER_GFP};
>>>  /*
>>> - * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
>>> - * to match with the sizes often found in IOMMUs. Using order 4 pages instead
>>> - * of order 0 pages can significantly improve the performance of many IOMMUs
>>> - * by reducing TLB pressure and time spent updating page tables.
>>> + * The selection of the orders used for allocation (2MB, 1MB, 64K, 4K) is
>>> + * designed to match with the sizes often found in IOMMUs. Using larger order
>>> + * pages instead of order 0 pages can significantly improve the performance of
>>> + * many IOMMUs by reducing TLB pressure and time spent updating page tables.
>>>   */
>>> -static const unsigned int orders[] = {8, 4, 0};
>>> +static const unsigned int orders[] = {9, 8, 4, 0};
>>>  #define NUM_ORDERS ARRAY_SIZE(orders)
>>>
>>>  static int system_heap_set_page_decrypted(struct page *page)
>>> --
>>> 2.39.5
>>>
>>

