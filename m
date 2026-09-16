Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65F4C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E923A10E3A9;
	Wed, 16 Sep 2026 08:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJ66coFX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC17A10E3A9
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3Y4+3GdmRAbx6Koo6md8EPHAlWzqGHLy6RYOPlCeJFs9GAwK+KM/r4L3aoLDsKGpGjmwNHOWrjMIgDyp5GieVWz8rwoUMO48q1jy5WhskRHqgaZmv2kBa4EM9SkLDgu6nvr8EaP4xaprXe0UdUCmZ7mSVNuggjzbd628PB0NwoB6bkQ6nc4LaDu5ay8vf5p5PopCG/xPZ0ws3Ri9VHZ6c/cZR0YcyFK0Cajhhzp+iauMPNL241tIbrcig8/iB1JkutxvBU+mxAlxm0hJrlPcUt0YFv/rOVQDRX+LdZpiVEudYFSs+CBj3mlEBiluVQ1mB+ODpgJZIUAELpBBxdERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysBGJL30wYTtmgTjZ3DDb+wymfmS9yr2BlfOOR8VdGs=;
 b=PkyQnwbmMHYTO9JdKIXBCZazVtSQQrN1RzBFwjeoW1gLpEyyZr6cezE67zZjG9XrsKhaf69EUr6a3TuEZAwfYar9R7ajRsN+5gnmATtOZn3BZBh2nlBUCy5k3tHNlhWQQAyp5UoYPRVh1izWPG1BDaP8dU4z5t+QzwQMBlYf4K3YkVErjASHnKppgmxs3S9YgeRi3Svk0dYCTGOmF6F/DGp5cpJRVN0G/kx2+5RoMz2uQQmRvTlwDPaf9hQcF+stN+DY5i+VIuWHE/b7JCI0iJgwJAtXUaJQOKfkvTGvCy6a+kBEgqZb2mmknPtvGkrgDudpIFXJZAhtzme0HpK84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysBGJL30wYTtmgTjZ3DDb+wymfmS9yr2BlfOOR8VdGs=;
 b=ZJ66coFX84G/JGHDFvLiB2Ve3s6+ALZdIUioRE3H2bUNAzkKJ4AcNmwlY2e7Y23McbiWTckfXsLJVzrZ2xpMvYzlRaD+looJL1DbAef5x+tTvOwZVzOHSzpDpsgFnKWl0HLOcvRe2Zqo1Uj/4ICjRVtDUolSxVbBoc0yJBQQKAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 08:41:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 08:41:15 +0000
Message-ID: <d8d3af91-4f21-44ea-bc90-339fa1adacf9@amd.com>
Date: Wed, 16 Sep 2026 10:41:10 +0200
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
 <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
 <CABdmKX1g=wcLHOFkRN6DLPTABrnn2uWmgCKpCtixhiV_b+9J1g@mail.gmail.com>
 <CABdmKX2GU0Eby=SEeALzeEp5ragEjU3Fw468Jv1yykD1Zdrgag@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX2GU0Eby=SEeALzeEp5ragEjU3Fw468Jv1yykD1Zdrgag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: e8540bc3-e69b-43b3-ae78-08df13ce4509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|6133799003|4143699003|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: FcYf/0fOklH/YOA8zOhr0NBxIDBdEGKx8YLu7waH3gcbjxhoN5XBzJE1eT2reO8J1kjK73D8GLTYJ8Gtk/YPXQ5b7cxB5vxaWt3rdtvC9CWg+79n/0tA+1zx0ByVbfG2vkWEIBEdf+XIismWQhaKg9vg0CWgNkQUai09iHEN94dtSiX744v3ycxtK6r/ANVYCr8KeiGCcx3FirdNgxTGPynh7c45r5D1JVpJSkjck4yt68y6yZ/Kmd9tA5e7rxHxf8KENwRsuHWAk0sV1v/XJBrlXhvKl9noM+RIrI5fvi0LrOoApnKlR2TiFdF7D4TXsP7K5QkkBQ6tNSRIrZoyr70pmHwl2iEY47m3hzb3XDH2lbMCEEte7iDW1nO7cy1eGC0tRmDsEqlcilp+YTzmUM7IDArWn6o01Vk56LeLzn5IxS8yzuVCQFo5hjE+pZZ4Ooi5HH45eg5E54Trj9kk90PuYPo7sU7oa+qAOrXsts9X69ilNa8bULWzHOViW1WxzsGXdK1sIVE45IpxycfVrfC2/TJEjM1qEseZNGatdsLgNNBlZ/lAysS8xHJUhTUjnMhT2E7AqptkBqOLHOjJ8ixeCAc3SkrB/8WqKQCzoOTapOKcFisQOgnec2ByNIdo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(6133799003)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhveFdHWjhmcDgrRDIyU3l1VFkvMVE1OW94SzI3U1gwYjgwZzArMzBMd3Nw?=
 =?utf-8?B?aThVQXNJTmZoWTgzdUVCeGFoUythRVRiTjRnVHdJMi9saDRHMkJSNDJoS3pK?=
 =?utf-8?B?ZDJKSmFQMWlyOWFCeXBhMTI0Y0wwaktyeVVzTlI2S2h2dFZBV0J2aXVFOXZn?=
 =?utf-8?B?UlVId2JsWjhrVHV3OUNBY0ZiZGhhS1RsMTVHOWYwUWJrd1Z0ZUQ4bzhhZk16?=
 =?utf-8?B?dkVBb1FCejN2VlBvYTFOTlhhTWk5QXgwSWFnaS9ySEltU3p6ZTdOYWdmM1lr?=
 =?utf-8?B?Ky9KTm53eE9FRnMraWZWZ3ptY29WNDVMYmM5MmgwMFV1RVpWcXEvWE1GMGph?=
 =?utf-8?B?T0JLdzlOT0EyTDFtY1BhMFBXTnBzNWNIZUdaeU82QjgrYjFBbTNMK1F4aXhS?=
 =?utf-8?B?UktSSmFhaDZFT29kTVhDdFRVaUkwQXFEQzg4TDN6TzhVeXNVYmtKU0laSXR1?=
 =?utf-8?B?Y0I0WWRqZFI4dENTMDZEa212VGJwR3RPeGN0OVk5YitSeVBvWnFqYU1Od0VV?=
 =?utf-8?B?bmVNTjV2bmEwQ1dza3pCSXJ6VElFY2tQb1lyd2hIYjNNL1ppdUxmTWVjUlVR?=
 =?utf-8?B?Z2YzTStzNkNmWnBKdlVRazBpVFprS1dHR2dydFRCbVVCRG1jSTFLbzBIWDZ1?=
 =?utf-8?B?b2M4em1HNU9KeTRFL3VQUERSSUFIc2luMmtKR0hLRVY4cXp3TzQ0TitKZlpR?=
 =?utf-8?B?R01XVlhQUHFjeXZTcmZuS0d0Q21PTHZub2pROVJSVkh2a2ZpeVY5dVFicDNx?=
 =?utf-8?B?bklmNEZyNEcvVlE5RHB3Y1BIOTBUNUxESXlhYi9MbjBZcWpTR1ZRSytZUlpD?=
 =?utf-8?B?cmxiNzFlTml3Zk5sQk9MaTJoMGZLamNxTVRJMlBhOXFyWFEwUlNmTW84RUVa?=
 =?utf-8?B?aUFwSUZuMk1QYlZSMGhvREl5YU1SclFDbkQrZVdiOWEycVZvMldVRnJoT2Qv?=
 =?utf-8?B?MWZrWEs4NXZMSW5FelljU3g1NVlXcVQvSnhTMDFtQ0cwVDBKMldWb0RwR0Fp?=
 =?utf-8?B?TUdUQWhJVUZlL2VqaEIvZWNFK0R0d0JUS0F2ZVh3dzFhaHlLbGFVbTU4MlNJ?=
 =?utf-8?B?TXNRcE1lbXFMb0hOVElDKzNmemRRS3NoV1djZCthcDZ1NFg3TXI0c3EvUVE3?=
 =?utf-8?B?VTFLVTdJaGtyZGowU2dnQXZDN29hdWh1d3cyUUl1NkJxKzIwZkl2VktxY1Fv?=
 =?utf-8?B?TUR0aFEvelk2L204N2Q3NFRLeTR6anVVKzU3eHNET2pZSlB2QU9uY21jWFpQ?=
 =?utf-8?B?UHpzWDg0UExrdlVaL1Z5MHdsemplQVRuYnZFOTJhYVNxdmdIeEtxS25GcGV5?=
 =?utf-8?B?dThRWlpYcS9iU3F4WDQweDFUbDVScWNPK0hEbWkwWkFSK1ZNQy9hMjd6Szdj?=
 =?utf-8?B?bklvVk91S2ltUjlsNWJTSGdMTnZ4YnM0MnJzUktyckhXWWJmNitIdzZIYVR6?=
 =?utf-8?B?VTNGb3pjRzU1OXpUc3BFcGxMZkVBRllMV05GZjdoeGxJeDMvMUorVWx0ekZB?=
 =?utf-8?B?VC9CNW92NjdJTEVCQ3lMZXhDQXdQcDM5Z3N2WkVuOXZ5TlVYdDlYbldXZlVP?=
 =?utf-8?B?YjVXeWRHUDkzdUNndSt0MEsxM3QwMUpuZTFLKzhiTWlhZzN5V1RKNHVLajRn?=
 =?utf-8?B?bXBRd0lxOWduWVJmV1ZDOFlRbGp4NVh4Uno5eFY4MmJpN1RoakUwendwQzE0?=
 =?utf-8?B?M3hJVVRWdHBHUzB5WXQwQW5FOHNaTzhvUnBVa1ZOMzF0Z2VDVWpMZWl6bHl6?=
 =?utf-8?B?LzFpMkJXaW5NMW1FUC9pSFRFaHM0TEc0UTUrSnJSRDNSa21UWlcrY0Myd0xE?=
 =?utf-8?B?SVRRM2wvMnJsY2t2OHpkTWthUDZvNWQ3ckl6d011ZWFQS1VRbG9YaFVPUjI3?=
 =?utf-8?B?ZUlheUtoK013ZWdHTjk0RndUWUxyK3UvWnBQUGtHbFVPY0hrYkZxUzNMYjNW?=
 =?utf-8?B?SzBsYVU3VWZid2R6RGFxQ3N2aDh5SVJ1eGltR0VCcnNzTlRhNCtXQmYySXhE?=
 =?utf-8?B?ZzgvZE10TTJhWUYvQy9nNTRaN3M2QTk1aVVobDBKRHUvYlF5VFlhWUpzUTFK?=
 =?utf-8?B?R3p0Zk9mSzQyT0NkOUNGZ0RoclQ0ZWpNY1pZd2YvN2FUc2hpdGNPWTVxcWF4?=
 =?utf-8?B?ZnJua2s4Y3hMOEhjSHpVRkJPeEkxSSszbFpqQmM5bUI3VDhrZVZCODZtMXBB?=
 =?utf-8?B?TGk3U0ZHUUlFanBMWk1ObjZuTUNuMlBLNEJGOHB4RUZtT1V0S2FqYzBtSUZh?=
 =?utf-8?B?R0oyd1VLcWU1UWw1OHhlT3gyamtLNE5ZSkpYMm1qa0tIcVYrUk9odCtuMDFi?=
 =?utf-8?Q?pHys/ynecy4iZmdnSH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8540bc3-e69b-43b3-ae78-08df13ce4509
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:41:15.4873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQ0bqOOC60pA/RXaVMPukW53JGT+ZQdtsRhEaEQMc+DKjDm0EGoeOXXyGlrhLRHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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

On 9/15/26 19:26, T.J. Mercier wrote:
> On Tue, Sep 15, 2026 at 9:26 AM T.J. Mercier <tjmercier@google.com> wrote:
>>
>> On Tue, Sep 15, 2026 at 8:44 AM Christian König
>> <christian.koenig@amd.com> wrote:
...>> Even on arm64 phones free 2M pages aren't likely to be available for
>> very long after boot, but lately we have been doing more proactive
>> reclaim triggered by userspace before launching workflows that desire
>> large dma-buf allocations (and also at other times during application
>> lifecycle in general). That somewhat increases the likelihood that
>> high order pages will be available. I agree there's no guarantee we'll
>> get any, but without __GFP_RECLAIM the attempt is pretty cheap and the
>> payoff can be pretty benficial which Davidlohr's allocation and
>> mapping measurements demonstrate.
> 
> Oh I forgot to add that this behavior is similar to how slab
> allocations are done for slabs requiring more than an order 0 page per
> slab. A large optimal order is attempted first with ~__GFP_RECLAIM,
> but if that fails a fallback to a smaller min order is done. When the
> optimal order allocation attempt fails, the cost is just taking the
> zone lock for a quick peek at the free lists.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/slub.c?h=v7.2#n3373

Well from a lot of experience with AMDs ROCm stack and Intels XE driver I think that this is a really bad idea.

The background is that there are a lot of operation which can fragment memory to a point where only 4k pages are available, e.g. for example storage I/O can do that trivially (the kernel compile is a really good test case for that).

Now acceleration HW usually has a very specific sweet spot where it works best. AMDs GPUs for example can work with 1G, 2M and 4k in the L2 and everything between 2M..4k in the L1. On Intel it is only 2M and Nvidia has 1G and 2M (but really don't nail me on that this is just as far as I know).

So if reclaim of smaller pages into larger ones isn't requested what you end up with is unstable performance, e.g. if you only run application A everything is fine, if you switch to application B and then run application A you see a performance penalty of up to 30% which eventually doesn't go away over time.

On the other hand when reclaim is always enabled for multiple different orders you start to see stuttering when allocations are made because the core memory management tries to fulfill all those different orders.

We literally had tons of bug reports regarding those problems and it is one of the major reasons why we doesn't use DMA-buf heaps for HPC use cases. Instead drivers even communicate the sweet spot to for example TTMs allocation backend.

I don't have much of a problem when we say that this is just for Android, we never do reclaim here, instead reclaim is triggered solely by userspace on application switch etc... but the general idea of DMA-buf heaps is that it should work for everybody.

Regards,
Christian.

