Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D71606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUGNDJx3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E60410E893;
	Fri, 30 Oct 2026 10:31:44 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF9E10E897
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWN4+jktE1NDsKopo38Ipqn+t9EJUBhTD01je2NWCog9OeN06YIJ8vQsq7UnoCMKw3oa/WYhD95frJlAB4lLLNXDnQ5oWGXLnhnRAKWxm+HE40KHpBsoUtZZoJinQyPUI7bXTPsoXcgX18TuuXo4jWkpv8ubBLwX/BhTUPuAr0d56zoWWoJIVuyLgkTgXfWmRX4raTE0EUeuyblX9MbQ2cTGsCwMbG+YxHaVtx8YYMlev6AQHR29+7Ti7PTE9TToOIrAEI+NNLVjNvmfSU81+FB8HzKNYerk0AXh7VfFwiOSGZIwgHmvd9eLajOHxkjzJtqpt9txbMGAx5UNlKTrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1PEtyQFDKI17N3Oug+jj5YFYX/vX3AJ4K8mfrteOfw=;
 b=iHqRtjXDgO9X0PiWl/CbE8JEas/wfl934ZNl9zO4lUzhsq5wQcXxGPBDI4kHh+Tlmg1YYRHnJjPOy1OPzO/AS+k3OjrIS8x7kI+VnKdVdlxR0YnxPPcyeKUZJNsExb9tJK4FKPFnZ/bKkD3F4Y53oVouMR0owyhNPYCF+5dxekLQU/W7GHzBV43cCm8Jic9Yu/YjzYfaW1AyIABJBYyHkWvwJuPPSyJDnhGgD1PtOikh60p4uRvB40nINmiO9YIi4L5fiUuPeSHGgaRgKNZSSNPwdyIkVzane+10TBaL5Ike7zBmb0wDFNV+e98wSKVZTHHjauzP2CfovzS2SeSgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1PEtyQFDKI17N3Oug+jj5YFYX/vX3AJ4K8mfrteOfw=;
 b=AUGNDJx3Az4I1mjidKq368TfG9jMDKBWA8ufmgEIMIFfhAXoquo2cf/00Ft5mX/mFZkvpxubFjf1g2smOWicL/UpGs2kVF1HpTVewE0W0AfvIYL0J3UQQ82cKtl5nFxi7MaMh7clhoPTZTAGO6qukxKFi+Oe1+PODpv5ovEzfv0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:31:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 10:31:34 +0000
Message-ID: <1e798600-5a76-412a-959c-94313629baf4@amd.com>
Date: Fri, 30 Oct 2026 11:31:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: videobuf2: add opt-in DMA-BUF CPU access
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede
 <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <673c04ad9dcc4f12685c076193ebad9e48e5f08d.1792392288.git.kmehltretter@gmail.com>
 <CAAFQd5Djx0kjeFpzPWEgRV5_MhiJAW8tg-2C+cYxqMf45u_-RA@mail.gmail.com>
 <20261021175900.GG15441@killaraus.ideasonboard.com>
 <3084b9bc0d4b5593d2bfbfecb0ce272cb813ece9.camel@ndufresne.ca>
 <atmKXkOJiGJXgRz-@gmail.com>
 <7e4c7707880e9092180d28484ecf674be29b40a0.camel@ndufresne.ca>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7e4c7707880e9092180d28484ecf674be29b40a0.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:208:23d::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: 367ae278-f511-46ff-31ec-08df3670f86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|56012099006|11063799006|261028144727099003|10067099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|4143699003|261026140227099003|261009223027099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: wX/Rcxz2tqj3na7pLwBmt/68jn+6sNhh++WH9m0RXpao4lPBk37DnOBZ8XhDSWks9sxaCXA7MRoEMtuttrZU2XJGh+XDrqfiyBlUn5aobHWvDfqHmYzX4wvKYRSOLeVu855g1fj7BCodflZScNwFg4/quTphs9kJyMr+Xr8DzxxQ8ikb/SseB1xD+5ILprAyBfo0lmgShJZAz/2k99raYQGBWIV6mMVdHbkoCXCLOQutMhzv+voN/0kzzMCpbOlBsnTCyOsLOMt0CXl4PDiR4ycrSpYRzo0K/0+NLas98Yetndv7E9WWV+afvHt+S0Dl0pFbC0XFSVHukC0b8uQmJYu6smk6bfJtXZUgSdA+vGNkcJkXFIBQwOnMDoAO1reiAhCafhn4BnWbM6XFlFB53BeZfGZXHTzYKfNUohm9OK0Ec6FNIJ3FLhR5tVss5Wma4i1fv7+uxy7+cAwRryCkIuEXons6sOxyb1vZ+11gYZTpdA+SAv72gzy+3hXzUzo7A/K5p3txWJZuDbVy7cHoKPEfGZOMnacAXNinUWsjG3ElhDOJ9vBnH5Hs3x2kTIWpULtdUTqZClfcP3aa/6sAHD6hLTiDMaQCMHyMV8TpqHK+vU1YAjErAoiWsZ06J1Df3SoYk2cb7WVDtlNh1PCFPPQJwk6nPoqh9Nx4jvHqpVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(10067099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(4143699003)(261026140227099003)(261009223027099003)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxNdTU2T2VjZUNPNUIxekNYbHc0dlJKQkczcmRQMDFyNDh5MGhmMHBpMU8v?=
 =?utf-8?B?YWJJT0x3dm1WaWRpQ25DNEMybXhKOFpOTlliT3NnSXNZak4rWmpVaUhROGhD?=
 =?utf-8?B?YUJiZ0hmeGZmaEpTSjREc3J4NU9lTDZZTUM3bDE2aURwWWEyZEZBQkJYamR4?=
 =?utf-8?B?WFpTTFM0aWQwWExIbTI1aGpMYWdSbjQyYVg1UUIxWHZXZDkzTTFJL0J3NHZO?=
 =?utf-8?B?RUVodVJPQnRDUFlDSjRxSVliWFpOdG1YbDRlK1RmS3MxOGllL0xZK1JURnBt?=
 =?utf-8?B?MGFjVGZyK09pNXE3NmMzaE1GMnA0QStRWnN0MXVwcGFWVzVYNmNwcVBKY2pV?=
 =?utf-8?B?d0JzTHFvdGZpblg1K2V0bUpwRFRESW5UcktpdlZUUG01cGN5OWZUZVAwSkFM?=
 =?utf-8?B?UEZwR1d6S0krZU4vcm03bHRNckNSMmFWSGk3QWtiSTNVUTZjREZ6R2hmRGRu?=
 =?utf-8?B?RXM3UnI3KzVzSHFrOEhNMDRDRTRxYkN1VUNZUEdoaWhacmJhekFTUzhUekpM?=
 =?utf-8?B?L2dHaVFVRGU3WTdKdG45ODNDT1lpMFFmTGEvRjBad3BzenFpQS84WVlCTDFn?=
 =?utf-8?B?aUM5dCtReU5kaTQ2YXVnQkVCR25RVTY4Y2RnRHBSTmhaN0dhWDdzVlFsNFRo?=
 =?utf-8?B?ZTJwVlF4d1JCdnE5SmlWMUErNFByT1VtSjllVVUrdmY5OHMrOEFtYnMzZkdF?=
 =?utf-8?B?d1J6NEhsK08ySVJWcldndlNFUUVQaDI3clhWSXJaQi9QSzdkMDMwd2Y1akdY?=
 =?utf-8?B?eVdDYjY5OE9lNWN5VFhzN1F5ZmpGTmZNcURES0ZKM3FhTXYvemJGMXZFMWlH?=
 =?utf-8?B?TzJmTGFmM1VPSEZlNXppOGFsOFlUZXYveFVHZ0JGSWZ1d21NWnFHRFRrWlIr?=
 =?utf-8?B?Y05HN1ZPWXNhVEUzOHBpU1lsemc4UWtsMW13L3lGU3QxN0NSN3EwajNXbXll?=
 =?utf-8?B?bjRXWWhtRmtXeXFBa0M0UkxCL0IwaHhyU2JEMUdlbDFUT0NGZkhFZjFETnYy?=
 =?utf-8?B?OTZOL01ZRk9NU2RzY2d3Q2hxbWkzWHU2MGNUZ0NhVldmbkY2N3BqZWlYcy9q?=
 =?utf-8?B?UTNwZjNsbEZ0c3VEZk1tbHE4RnVFbnc0dG1hNGlZcVhCQ29hVjlaeVgwc1ZM?=
 =?utf-8?B?NU83U01DaHJvekkwbXZwYmJzVzJhWW8yb0RRVFE0U3ZuRDFxVGxzUVlhcVFK?=
 =?utf-8?B?WXQ1Z0ZKZjNvd1VxZUZMYURYNDJzWXU0Y2xsQWdSUjJTQXIvNXY1U2FreFBZ?=
 =?utf-8?B?VnUxcmpWVFFKR2tDZW1kb3FKZkJvQlpxWkZHWWVhMGtMNTJ6ZnVkNnJzeWVY?=
 =?utf-8?B?Qmt3bnZ1cVFmdjlrYkFSb1ZaK3hnWkIzR01IMmZSU1k5Tzc0V2w1NU9JVjlP?=
 =?utf-8?B?b1k5WjdybGJSc1UvcjZERUFVcUVWNEwwRytGWTgxUGJsMU9YMklhbk1qNlhx?=
 =?utf-8?B?MnVmVWtjdGJ3TWRNUlVVWlJhU3ZibFlTSUd0bzJZRlh4Y0JCb3FkQkJFVjI2?=
 =?utf-8?B?eHFIaVNNWXNUalhRdnpVa3BiWHNCQVVYTWRFcnJiQ1BCVjNsbmxWZlhCMEsx?=
 =?utf-8?B?LytTcmR6eDlGVVpDamc3MmhFY0J6M0NjM29JY2dSSk1HNHZmbVNrcHdJbHh5?=
 =?utf-8?B?V3pyYUxwdFFUVk5XVlVWenh0ZUFsb0VXWmVBRlhCZkNLcC81MG5NN2RrN1FR?=
 =?utf-8?B?dVZqTU9VQmhDUmw2R0tzUXZ1a09xaWZlTDBCY3NVUEt0TGxwZUZsczZmTmhK?=
 =?utf-8?B?VVZ5T1BvWTNWNDlybzhRWithR2IwNjM2TUxVaEk0RVV6YjdPUy9LZ1owakdq?=
 =?utf-8?B?ZFMvL1RabHh1OUthK3lTR1E2OXNGS25zSGVpRG51Y1ltUUxyMCtrb3hDaGx6?=
 =?utf-8?B?Zkg3M2Mwc2FiR2VxS29pb25rTEhrNCtCT012QWt1TWUxMmVMK1pKOGxSQWpQ?=
 =?utf-8?B?dnhZZVhYMVlUc0J5Wk5xSGNoUVR1bkhEUVVuQU5UeUdWdHA0c2s5d0RORnFX?=
 =?utf-8?B?N1hwdDU0RmwwQWlxT1JzN0wzeWM3UkZmeTFoNUJCYUpqblQ0RWM1b21xOCtG?=
 =?utf-8?B?NWhEZnNtQ0txN1RJbUJPOEQvSFVCU3Z4Tis5RXA1aDdyamg3dmtrN29vQlNp?=
 =?utf-8?B?YmpSWWFZNDJycUt1YmpXZDdmWlUrZkVCTnh2UWhabi9pdk1NNXZDQXROTzgr?=
 =?utf-8?B?N2xueFlBQ2drNDU4ajdjeUJOcjc5SmhURlJJSEhiNFJQN082cXRvMWt3QmFi?=
 =?utf-8?B?R3JRZVNLbEo0QjkvZHZmR1ZWVU05cWZoNEFLL2MrMG5NOEkxWjdnTTNtNFg2?=
 =?utf-8?Q?uCTwHFqWmo9sRY6CoL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367ae278-f511-46ff-31ec-08df3670f86c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:31:34.3052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nhqbc1suTAB8i0SaUxwEYLslD7jTJUSbkDMAdYtlA3qfXT/tjC4kWxesnP8XEjlH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 02:40, Nicolas Dufresne wrote:
> Le jeudi 22 octobre 2026 à 06:04 +0200, Karl Mehltretter a écrit :
>> On Wed, Oct 21, 2026 at 05:03:19PM +0100, Nicolas Dufresne wrote:
>>>> I think the dma-buf API doesn't give us what we need. Cleaning the CPU
>>>> cache through end_cpu_access() when the producer is done writting to the
>>>> buffer is right in some use cases, but not in all of them. It assumes
>>>> that the next consumer will access the data through DMA, which isn't
>>>> always the case. What I think we need is to track the state of the
>>>> cache(s) in the dma_buf, and perform cache management operations
>>>> accordingly when needed. In the uvcvideo -> display use case for
>>>> instance, the dma_buf should track that the CPU cache is dirty when
>>>> finishing CPU access, and should be cleaned on the display side before
>>>> performing the DMA. In a use case where the producer would DMA to the
>>>> buffer, cache management would be skipped as the dma_buf would see that
>>>> the cache is not dirty.
>>>
>>> I also second this as the only viable option. Its not only about uvcvideo, but
>>> any memory imported by a driver doing DMA (which is not also the exporter). That
>>> includes udmabuf usage. These days, cache artifacts are visible with Intel
>>> display controllers, and Intel mobile GPU drivers. Note that GStreamer properly
>>> signal CPU read/write using DMABuf sync ioctl.
>>>
>>> For most Intel laptop user with GStreamer 1.28, these example produce artifacts
>>> on movement. To me, the solution is to track the cache state according to the
>>> access signalling (either userspace or driver), and let DMA user/consumer decide
>>> if a cache flush is needed. There is a obvious challenge in keeping this state
>>> coherent whenever there is multiple consumer, of if some broken application do
>>> concurrent write. Result for the last will always be undefined, but the dmabuf
>>> CPU cache state should not be undefined.
>>>
>>
>> For a persistently mapped attachment, where would the transition to
>> device access happen? 
>>
>> dma_buf_map_attachment() may only run once, while the importer can
>> submit the buffer many times. Would this need a new per-attachment
>> operation before each submission, or can an existing event be used?
> 
> In my perception, the mechanism in place, attach/detach and begin/end only work
> for very specific cases and breaks in most other case I can think of.
> 
>>
>> I tested that distinction with one persistent V3D attachment on my Pi
>> 400 and Pi 500+:
>>
>> - If end_cpu_access() only recorded dirty state, with no sync before
>>   submission, V3D read stale data in all 64 frames on both boards.
>>
>> - Synchronizing the attachment immediately before submission produced
>>   64/64 matching frames on both boards.
>>
>> This only covers V3D, but it seems that a dirty bit still needs a
>> device-side use event. Is that the model you had in mind?
> 
> In my mind, we need to introduce new API. The problem with the being/end design
> is that it only works for specific pattern. Typically, on begin_cpu_access, you
> want to do specific action that ensure the CPU will see the right value in
> memory. One of these action could be to flush a device write cache for CPU read
> access. But unless only the exporter see these calls, and unless the device is
> the exporter, eveyrthing we have fall appart.
> 
> With the new trend of always allocating from unified memory using dma heap,
> udmabuf and other non-device specific allocator, both device cache just breaks
> everything. Just like, an importer that need CPU write to be flushed breaks
> today. This last one seems obvious, just flush, but if the data came from
> another device, you might just kill the performance.
> 
> I think if its just for the CPU cache state, to let importer that needs it know,
> we could introduce some sort of a bit mask (and some locking probably?) to help
> solve that. But we still leave the concept of device side memory cache broken.

Well the documented approach is that when the devices want to access a DMA-buf they must do so coherently with regards to what the CPU sees.

When a device has special requirements that when the CPU wants to access or has accessed the backing store it can use begin_cpu_access/end_cpu_access to do the necessary actions.

But the inter device requirement has always been that when you complete a dma_fence that the devices internal caches needs to be flushed before the fence signals. The same is true for invalidating internal caches before stating an operation.

So when a device for example can't import a buffer with dirty CPU caches then we intentionally doesn't support that.

Regards,
Christian.

> 
> Nicolas
> 
>>
>> Thanks,
>> Karl

