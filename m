Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E620BC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160CB10E395;
	Mon, 14 Sep 2026 10:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Z2a5XJ04";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36FF10E395
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXDV9CdS2vklAjgZ7NgwrcvGDYjaq4dxgVShTnCYf+3QH1oIoa/WI+am36FHfcs2Vx9gmZ5711F0GFDVeUPBqDlO60BrdCag0MLy7Yi5OS6KMEpY6LOOYwG6uDkK5uTPg7+UoIgzbqabM6RR4vzpmz0bMoQZeLE24ZJGoB1KSyL1EWpO0iNPWH89dpHiOTPkNMs6gaKnt4sTACf8RX5kVP/c8hsf5dgKd+cj1xjdvNZJVVjKy0YSS9zti168owmJDEbsvozpwpjlxkcdiitPlu9QA2YTDcomOZSKE6+d3TuNzud9NZimwVmKb2rRyn+VO9sKFU1o9TOuynyebGZkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYRtcGDYkkRviq5o15+S8PLSQ0aqsRdZm3yvBYfB+bE=;
 b=iju7NcaTifPVKl2OZP941gkBjKzBmnEoEfAz3WCjWgA52d3b4F8nWGFQvXsAsWb2D6pzZ3kBmQdJxGEYMSUPkR0kTKm/G+sfwuB9vIGJIYos5fbAJ1uZK8cEdMkPil2kRpEeX+/x5/qwaOd3uz97Cwo3SaExGTGmfCwWbeT0KQ0d7FQXc6qJyl3D/4sTcLbGZKIW/K7KDuv5yvEc96ONIi5KK/GWF41yNcgn6fzEoawZRGdmqcSHQq62kwy16TV4OWO5s3jsuIP2GgYAYqEBGJlpurLenv9y9A5cleKAzCp9A/P/vqZ88Xd/M6fYpSNaeaV0L99v04gNkzI+2Dp0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYRtcGDYkkRviq5o15+S8PLSQ0aqsRdZm3yvBYfB+bE=;
 b=Z2a5XJ049lZNTdrNk9RmVvz0YvZE0YGkZbLjLOPKamy/dvLTEZF+GwPF/Omd9H1tE9fgjfh8hhUg7TwlB/CvIZ/m/UodkA7uW8jHTVgn59zbZA9PEcOCcieyLzGPFRZcmzN5MTW5jZm7tBkDlsqmflqHI07z7bUmRSUb/Hzbo6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB2294.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 14 Sep
 2026 10:22:05 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:22:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 11:22:03 +0100
Message-Id: <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
Cc: "Matteo Kloiber" <kernel@matt3o12.de>, <aliceryhl@google.com>,
 <ojeda@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
In-Reply-To: <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
X-ClientProxiedBy: ZR0P278CA0089.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::22) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB2294:EE_
X-MS-Office365-Filtering-Correlation-Id: efcbb828-5013-4fb9-0567-08df124a067d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|7416014|376014|1800799024|10067099003|6133799003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: yOcqdK/eu3nuawZ43IYtw3QptthGRaaTmqK0sidpTGaZtrAlcK1S4hSSY1TAVDvsxshmZzLD0wUkITiMoa8lsUp0QRu0DpGApSf9fA27NL+YMmJF2NPlACYIZZxLMnsK6zkx0ZMIuaQPsKaKccObbjux7X6L9ajM2xeuwJWTmhYzGwIV2mphLW05X7W8sa2Dk3kIUILvZ6rLKoQjItUNzpBc+S6n3eJrvvYn1FxjUB6mb9hHEgN5iYhsYXxbKQxTLn8xIC1486wvj1oVtzY8atRiMlrKIuXGRne5nPir9OOK22Vw1pDmMka5DcJq59DkdhYAZ9CQkEkfc7WNLYrNbic0xqCEKS8pu1dOn31kGPQ8obtNtFzCoWrlWIdxNr0clmLGYcVEoYO0c9QGm4AmSQ+1v70z9RWc9HOSqAqgcLt0ilmMxrvKJ2rphREy4PF8807z96BiFRKm1k4okzagdJnCKJd5cbiDYpchEl++1cE0nXeml6J24UFH+a6cuG8WvlmUtKLqOq9P5j71Koym4SPLpdKv/9CHA6MvgVmX891+Nm01BU3KmZkAs7WLeFudlWmffix3R/wvPWdhtUc0PNGqPD62q9M3q37mUN0V6DMKmqEFkGT2j3bzjnvNy6NKu6YDDddv51MCFdTW9/DpoTdm0zLLG065hVYJ99m8juA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(7416014)(376014)(1800799024)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGorc3ZSNEdkRlVldnVySnB5YzRTanBWbVRxQzB1RVVQdmcrUkovaDhHb3ZU?=
 =?utf-8?B?dmsrV3NGR203bXNmYkJKT1JEOXIrenE1RzFoNVBaejZzZmd6VlJyV2xtTzNB?=
 =?utf-8?B?SWd2NnlCWk5tR2dmQmNqZ3VtbjVCcUh2NUNvTnUyNnk0Njh2Q3JTbFd0MzRI?=
 =?utf-8?B?NVdYeEF4QnRpTmJWZk5Hd3ZsUzhsTDNLQzhIUXRzV2YwUEp6Y0lQTUR0OHlm?=
 =?utf-8?B?cUl5MzRQbC9iYnNwSGtyRlYzL1g2UGlxOG5Ib1oycHBKdWdDRURqMmRMeHFv?=
 =?utf-8?B?YTYvUHYwb1RVU1JZWVNIL2VVT21WbFhMeGhSb2kza2NDMTZuS3dtdWE5MXlK?=
 =?utf-8?B?U2NDYU1sQVBIZGVzQkFIdUZJQXNxZjBEWWRBN3RGeGlKSTZYR1V4RFdOQTd3?=
 =?utf-8?B?VHZKcFQ4QTlQSGdxQjhRMll6NXNnUGZ6QmREVkFCMUl2VmZCTGdpTGI0Q3ls?=
 =?utf-8?B?SXBRTDU5OVViQUQ4UWE1U1A4UG9weVhIdnRQckpuUFpjbkpJa3B5MHJkN0pQ?=
 =?utf-8?B?UyszMm9tRlBjalVQNHFVd2xzQXNKZmp5VmdLcU0wVklQN2wwL2NFbVYyMVE0?=
 =?utf-8?B?a0VsM2N6ZE5sRXJFUHZYZFE3SzNqem5JenlKQkp2MytxemNMN1hUYTllaExt?=
 =?utf-8?B?UlpsSmtNWnBzQUprcVlnZHR3VHUvVStNZy9SOCtoVURhREcyRjRIK0lJN1lD?=
 =?utf-8?B?NjVtWTNPVHhWbDhyV2J0ZVBzeUl3aE9YcVV2U0xKWmdWbytPSlJudFVsbUcr?=
 =?utf-8?B?SGlyWTEzSFhrNzR6VW44MGczUjhRZUYzNHlac0dKemt2L3g0TEhiK2ZzYkhG?=
 =?utf-8?B?UERscXFJWElpTVNZWU9FdU1uWGdHZWpCaUt4VFM0cnFKVlFWanhncU54TUZW?=
 =?utf-8?B?bVRyTllGZjFQdXlHOWlvMG9wSFRYcnViekpMZzFQaHJlQ0NtS0x3dzY2K0s2?=
 =?utf-8?B?dkVyOHg2VzVXWXQ5dWJkUFBIMkg3Kytqemo0b1M3cEVzKzNPVFFPN0VhTG0y?=
 =?utf-8?B?bjZpeHpGb016Zm1VR25TaHVvU2p1K3BZM2V3aFcyWjRTQzNNMzFpM3F0eDVU?=
 =?utf-8?B?MkFHTVRHRDhZYjVkL040a3czdmNoWDJFcEZxTjkvMmNuMTRPNklJcm1rOUFr?=
 =?utf-8?B?RC9jT2pGUEg4ODRxNEx1Nk5kQnNvb3pvYnk3QTh4amIxcEtESlJOeFpBVjVy?=
 =?utf-8?B?TjdVTk9xOTZrUkdYcEpLVjlGa0JMTW94WW1NcUsxWGRFMm55c3Y0T1NoaFJT?=
 =?utf-8?B?WEljUXZERmc2MFFaTmFrekJhdURjc09LcGFlWHhlTjM4WE5Yb3RaSHFhMUdq?=
 =?utf-8?B?bC9hWXVJUXYrVXArcXZqUUFRU2dINmQ3eXhLSDkvblppVjlEZi9LRjd6cWlp?=
 =?utf-8?B?bzFpWlhOZmlKeUlmQUVOZkNGZUYvaXBaekQ3VkpyM1A3U0E2QWtKckk4OGEw?=
 =?utf-8?B?QXVIeGp5d0FsL2FNbWxkd2VYY3lRN29SdERPazZLb01SK2VSODdiTXh5enZs?=
 =?utf-8?B?UFNWc2ZWRkpseGpLL0k2aTc0a3Z5c3Q5MDE4emwvaUhBeXUvUE1memk0WS9l?=
 =?utf-8?B?K2xIbVJrQnFrZTZSMFFRaWZMM3ZMMnRsN1hXRGd6dWNjSEtuYjI1TXRZZHcr?=
 =?utf-8?B?b0tNekF5TjlCK3IxbHk0Z0xiSGkwZVN1dFVJN2xsRjhsbFpXREJ4aTZBV0VR?=
 =?utf-8?B?Y0ZHckgzZlBNRDduTGZUU1hnSVgzV3ZLYllwTHlEaWJUYU5hWVFybWtXcVlG?=
 =?utf-8?B?OHZWN2czbE5DTDJrdVRsOUlnZE1YVXlrcHVhd0xlVjQ0WW5YVHR1YVhObUg5?=
 =?utf-8?B?MERhT3F4Ni9CQmlTUTd1MTFzaFNZRUVQajV1bzNzLzFjZ1ZrMEV0a1V3VFRV?=
 =?utf-8?B?YktBNG4wR3o3dkpIc01QY2pLTWxHc0Z4MVZSa0F5MzF1Z2VGaWp1Vm5idHUv?=
 =?utf-8?B?NGREOHVhd0Q4c3dkQjJMTGxiSHZBaWF1NWhPSDJVVGNIODVLR244bnJDeGtO?=
 =?utf-8?B?L2lnaVJBcXVQS2pKaEU2Tm9EN0RXRjdoOTNOQnl3NS9OTjFrOVRNOHdTUk50?=
 =?utf-8?B?cTlKZVRzanJrQzdyeC9vU2lJaG9YeWNIUnFIRmxPSmhsWjJiSS9qVUxUWXZR?=
 =?utf-8?B?c2RMYlQ3aU1SK3VPb1dGTHhST2QyQ0VFWXJQSGJ4U252SVBDS1QwamN5WlV5?=
 =?utf-8?B?b2lmQmQyYVFKVTcraW9RT3Y2d0Fhd05mUW9kQ1AwZEJCNUU4Z0NFdHVSSWZ2?=
 =?utf-8?B?Wk1NbXMxaGpTMEJrc2U2ZkhJTkhIaEM5TFdvZFU2ZDA2T01zb0UzQUY0Zjd0?=
 =?utf-8?B?OWptRzZDM3NIcTFoNFBpUllzb2hqT3lueEhNWHhVUlBCYkg4QzhpZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: efcbb828-5013-4fb9-0567-08df124a067d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:22:05.6534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lG4giFXkxdAKmF+AO97HPKS0ra49m1/FtrI0MlpckY/D4BvpCcxxGSMss5OHL9qInAVh1VbBjFf323AhWlObIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2294
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

On Mon Sep 14, 2026 at 10:58 AM BST, Danilo Krummrich wrote:
> On Mon Sep 14, 2026 at 2:45 AM CEST, Alexandre Courbot wrote:
>> On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
>>> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>>>> It also means that without patch 1, nova-core would split the firmware
>>>> into hundreds of 64KB SG entries, which is not breaking but still
>>>> something we want to avoid. The correct fix is to make sure that
>>>> `dma_set_max_seg_size` is called by the driver, and while we are at it
>>>> we also want every driver to call `dma_set_mask_and_coherent`. Ideally
>>>> we would use the type system to make sure that both functions are call=
ed
>>>> before any DMA operation can take place (using a safe interface), but
>>>> I'm not quite sure yet how we can do this.
>>>
>>> This sounds sensible indeed. Should I open a thread regarding that on Z=
ulip?
>>
>> Probably not necessary, the mailing-list has a larger audience and is
>> the right place for this. I expect people will jump in here with their
>> thoughts.
>
> The problem with those is not that they must strictly be called before
> allocating DMA memory, but they must not be called concurrently with othe=
r DMA
> operations, such as allocating DMA memory, as it would technically be a d=
ata
> race.

Do they really have to be called *before* allocating DMA memory, not do the=
y
just need not be called *concurrent* to DMA memory allocation?

If it's the former, we can require these to require mutable reference inste=
ad,
so the probe takes `Pin<&'bound mut Device<Core<'_>>>` which still derefs t=
o
`&'bound Device<Bound>`, but Rust will require the shared reference to not
co-exist with the mutable reference.

Best,
Gary

