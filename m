Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F069C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC11910E3EE;
	Mon, 17 Aug 2026 10:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="r9js3G5T";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D3410E3EE;
 Mon, 17 Aug 2026 10:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMgVoRXxm04Lx5cLMNVoqi5MwLabbzVBFszPNECL/5LxYeBOSQr2DM7YnfZLlxVmUVu8L6RnzCU3fv1ck+6Ok30cxPMRcK6Y4FodbFBRPzU7+uyujYcCe91dDTDgcm3aBx6wCtg5ShShIq9KUYvH81OWqftKLzlLwq3Ew0k8PeCo8vYXeeSARp/ccBQC34/42cyaWCRpPibBZhk1g5t+pRNxj/WuB2hzRNF0b6uGjbAFBCiY1ZtzFtK8V3OlOZV6Ut+SV/Y3/KDaoqQ0wUeQP3K/pdZmg7mbfC9qKz8MsqTm5S/rEsvfpqIGBKvReaIxx7VvyZzRBJ2VAZSqo4E88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEa2IODyt7bmNb5nrSbU60LhVcoiqET7hHjRvV1uVWU=;
 b=E62hV0ZX88QqhqWSHIyCAMBIbVHFJJJJDQ/M8YfwLEasLL6Z7qPWXgIpeSu6yOeu2Ln30jW8DkdYoqp4hmATXjSLDtJgcKl5F+fGzxitPuXitEBuZgSZVE7SzEJ1F3sY+D9rqh78hluPJgCGSN66YGXiWHom6viDLZLRycIDZlGjGOD8D8+RWo16PipjuQZgr8IrylPT1CttWvdCUrzamT+S0GLtAneGT0SOm1mGQh3Yb5sSwCsh/6HaAUSv+OZhgFLtuMYVvwMAfs5lrz34JDFX5By5Tm2w6Rno5tRbp8Cm63qD6CrkK3jgwYu9Mmt25fh1FbT7ihb2iNNhDVyABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEa2IODyt7bmNb5nrSbU60LhVcoiqET7hHjRvV1uVWU=;
 b=r9js3G5TkHtuTCt9w5yy6eW146+G9upKsAQ2WI7OpN239/z2YzdeyaZxLPabXeiCex8eMqqbh6LGE2Nzliv1JyjNXKbM8wiONPArbzz9d3IdtOpdNUpKWTTAAlUi5bFRZBpuhkrOmKAlGNp1YnQbhC0JNbqk5ZAxjzDv9BGjXBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2036.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:54:24 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:54:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 11:54:22 +0100
Message-Id: <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov" <ynorov@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
In-Reply-To: <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2036:EE_
X-MS-Office365-Filtering-Correlation-Id: e39e07f0-530a-4fcd-3edf-08defc4de5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZzoIARB9Jo3jCml4wlYbYLmRmqisyudtvyfA167amErawjo5VOu5r9Otm8UZOgW3s5LCqM0txPXd+BZ8DUucukJa3/LwcWKCAmmFrG1IXHnAauJ7uIXmGCT2NkXd+YJOCdUURh6iq/sV3odhlWovPODhwbklgb1oSFM1iOJgSB6KwP53MykEPXWUp/t9XCJXTB1jamTKf7LjVAT5tcCCB/Dp3+lgNzBjBOcS65eATnR2nv8yMrybHgzOjnwVtRGzu/I0MUsFMD7Y3l86Rg9Ov//Hj/GUzetC6hXu8jyxCp1vrU1bDRqWhCcZtkpNW0rfpc27VFY3tszu3y4wgmAktiVXqLLf8iObtYVqNtBW0bQWHtFg6lKAAnGl5CgO5ZANjWwjVQdUNNr3mkWJXFCF+YX8YlneY0vcz4GFbqci2Jl+KKOVN+sB6W4nxBksEhCYpYfAVFe1vFn0/vaXQD5Sbk8OIBFyUY3XTl8+kb4DSw2w1o4sBGRWrmwbrJITz3+aDx/DEYhK8Nlv2OEf6iCgJANNaoYJcNMyqx0rZcjb76iXG+s3BQ8TSKncLj9I2yHdVbqJ4zFrxF+r+2IuKkipHjkE136VUD8bNCuv3xpO7VLQkBMXROTAeZLoE7UapD8kcN0ESoBYd+mUyaei1oWAQa3nuP3JV5ZXxKEJiMTjF/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVmcFpxcUNuMWR4TUFLNmpYQ2pwSC8rMnhiNFRkdVFBbUw5OG9CV2NuMEpq?=
 =?utf-8?B?K2Nnem0vekROS0Zwdm9oNWwwUWFFN2ZRU2Y5SXA5eDRDMDk2OGQ2SHV5VmJt?=
 =?utf-8?B?NkZjL0N3am05ZEhSTFlzWTJ5QXpyTHViZ1VWREZDUG9mcmZyWFhYV3N4U2xK?=
 =?utf-8?B?Ry9LNytMNVQ2WWhVZGo0R2JpdGNsd0tKZFZOWS9kdHF2d2RsMlpFcTNaWUxX?=
 =?utf-8?B?TmsrNGhaQ2tDZXd1Y2dybGJ5SVArcUR3eHYvTmpNaVlZMnBoUnRsVndNamlw?=
 =?utf-8?B?V25WU2xHQ0pNb0ZEWjNXcFd6Y3JzYnN4d2RaOHV4czZmQmRUaWNQYUxNWE0y?=
 =?utf-8?B?TFlnSENvUjhTeXRDM2pXQUV5QUZkVklJYW5VRFFZY0Y4eTdKZ21TMkQ1aXYy?=
 =?utf-8?B?RnlqRC9NYmJQZExaWE5neHliQldDSUw2NXJybGRQUUVvNzBiTHN3T0R5RHg3?=
 =?utf-8?B?R1ZyeFh5SWdCbEhkWXF1T2lZWDZtOWlCR3EwWDR1bXl0ZDBkK0IwVkZ6dVov?=
 =?utf-8?B?Ykh3V3NUKzIzVnBvenppVUV2UVRhS2FjZWxYcEkyTU9DT1hOSjhOdXBuRW5p?=
 =?utf-8?B?elZWemV6dDVtMDA4VW5MeEtya0g4QWg1S0wyMURTSHRyU2cwTGpsMUpUWEZW?=
 =?utf-8?B?WGJtblBqaXdLcE1BZ2xOY3pGd2w5TnQyWFJpL3FZZTRRTDd2enFXc0w4S0hj?=
 =?utf-8?B?ck11aHI5SThpV3BiL1c3d3RUTm13VlB4bWhsQUtPanlVQVhTMFNKTGdqNFpn?=
 =?utf-8?B?bFBEc3NPWVlEY2JIMTBkRFJnd3N5OUNuZ3hnWHd0QUlQNWprRTIySXhwak9L?=
 =?utf-8?B?NmdEYkt5V2RnbkVVeVZWU3F5TU9FQWRjTGpseHRadWxLTzMyam9lanJEZEdt?=
 =?utf-8?B?OXJwZlEzQ2Q3YkhhdU5ZWkliaG1aMWFMUGdnWWh4R2dFRmpJc3lwTDF2RXFy?=
 =?utf-8?B?Q05LMkhuYzg3T29GQU1YNlZIYU16ZlMyQ0p4dndSSnFDdzVRajYrSEpvZStI?=
 =?utf-8?B?elNCUVVvUlFoanZrY1RHWm9zU1FUYjNSMTJsY2pIR2g0U1VKcFFZa2tDNTBu?=
 =?utf-8?B?QkZicVZqcWJKQnNaZ2s1VjFMUVZHV1c5KzV3VUZQcUNLTVJ4MVgyc1pDanJY?=
 =?utf-8?B?T3I0T1dIbnJRQk40a3E4MXhiS3JWT3dOZTdxRWJ6U3I1MC9aVVlFQVlJekVL?=
 =?utf-8?B?TGZRSnJVOW55dm53eElvam5vZk5Kd2tiZFJMZENmbVh6Tit0cGlFTmVRY3Uv?=
 =?utf-8?B?RGd0ZEgzWTRlM29iMzlrT2tSOVJRS0xZRjJ0TGYvenlHallCZFRYY2Z6c3Zm?=
 =?utf-8?B?ZEx3M0JkS0M0VllBMFJCS0pENE9UZHB1RjMzaVkrNjNYZFpSMWtNREhzaUNm?=
 =?utf-8?B?NS9iYS9FWlRJdjBrb2kwMEFCbEZ5UkRGbW9JcFlVTVJlSEU3VDF6dGQwS2tn?=
 =?utf-8?B?VllVNDdNU1RoT2tuRUNnUjhjR0lKZmg1WlE1WENMNklFYTRuQ3ZDcEE3aGVo?=
 =?utf-8?B?WVdua1BaMEpneDVKeExheGV2ckRuZnBDbTlBVHVxMmt3eDVOemVydm5hS1F1?=
 =?utf-8?B?aEZlc3BQZS92T2tEc2gySDNXUGhBbWo1VjBMNk5NbHZpQ2FwbHlkaHB0Tm54?=
 =?utf-8?B?RTV0Z3ZOL2JaZTRpb2h1U3h1OGZaQjZmM21nejdPbnJ3WXI2SWpXcjFEVERS?=
 =?utf-8?B?N1o0MEdYTENPaUxhMmZGQ01lam5Ha3JLZktsanZYeDZhT1RKZ0k3MDJWS3FX?=
 =?utf-8?B?d0NYRmRYcjEydWNDdDZaRDlNNk0zTUg4SXpJNXJPU2llZmlLZ00wbDUweXpn?=
 =?utf-8?B?c2w5SjhqT282MUM5N2VYbHMwM2hSM2pIMHJwc296UGhkVUpMNnFtMk5ZWW01?=
 =?utf-8?B?dXRMYVJWTG51YjY0M0FUVlZYaTdJOCsrYVVmWko3OUpNa3N5Q2xhZndhZXJS?=
 =?utf-8?B?SHppRG1VN2JmYWtxOE9UbDRVdU5DSUp4OFQ5Y2xRbDNBYjhOc3Mwa3FZdnNw?=
 =?utf-8?B?MGd1Y2JPY1RFYWVCMzBVMkdvd2gyMHdIYmxWMlZpN3JTUDFDamZaQ2FBc1Q1?=
 =?utf-8?B?QkNFWGE0ajc2bmkzSHZEZjdxT3F3MzB6ZUlISDIvbjN4RzE3aDdsSndQeHhq?=
 =?utf-8?B?U0xhOTdKUDNKeXdZTHR2VExya1dxTHhnSGhQR1liWXdpZUZacEVpYVJmeFRu?=
 =?utf-8?B?bmt3R2ZCbWNSNUNqYzgvOFZXaWJmMmlmY2pSRmVOdGJ4em1xeDQ4M2lBcEd5?=
 =?utf-8?B?aFFFMHM5MlVIMHR3NHpTSHdydlFmeEJGSjdKczJHeTcrc0hyS0MrVW5zemEw?=
 =?utf-8?B?WG11VGdWdTA3S3AvOTdodS9wbmFRd2ZGTi9NYUVrM3FvYWFPdktzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e39e07f0-530a-4fcd-3edf-08defc4de5fe
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:54:23.6003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1jhCo/UqCLoDC7WJnwrGBVTjt4zC5tj7JwVflAeiABUgbJuZRqlY0/rIOnY8nayKCR/8vR9kf+/TTDrSFR7qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2036
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

On Mon Aug 17, 2026 at 8:03 AM BST, Eliot Courtney wrote:
> On Fri Aug 14, 2026 at 11:53 PM JST, Yury Norov wrote:
>> On Fri, Aug 14, 2026 at 05:08:43AM -0400, Yury Norov wrote:
>>> On Fri, Aug 14, 2026 at 01:54:24PM +0900, Eliot Courtney wrote:
>>> > > 1. Provide a nz! macro to create constant non-zero things. Provide =
some
>>> > >    constants for common alignments
>>> > >
>>> > > Potentially, we could use build_assert! for cases it is provably
>>> > > non-zero but not a literal (although tbh not sure this is a good id=
ea -
>>> > > at least not do this initially).=20
>>> > >
>>> > > So either: nz!: const { NonZero::new(value).unwrap() }, or, nz!: so=
me
>>> > > build assert gated construction of NonZero. A general nz! macro cou=
ld
>>> > > also help ergonomics for other use cases too.
>>> > >
>>> > > That looks like this:
>>> > >
>>> > > pool.alloc_area(nz!(8), Alignment::AL_8)?;
>>> >=20
>>> > Actually found that if we implement SizeConstants for Alignment then =
we
>>> > can get Alignment::SZ_4K etc almost for free.
>>>=20
>>> Then maybe pass SZ_4K directly, and allow the alloc_area() to
>>> calculate the alignment:
>>>=20
>>>         pool.alloc_area(nz!(8), SZ_4K)?;
>>
>> Even worse, you can advertise the function like: allocate a contiguous
>> set of channel IDs enough to represent XXX bytes of memory with YYY
>> alignment. And that way, you'll be able to do:
>>
>>           pool.alloc_area(SZ_8K, SZ_4K)?;
>>
>> If my understanding of the function is right, it would be a clear
>> improvement, because the user now doesn't think about ID channels pool
>> as a set of bits, but an abstraction over the memory access technique,
>> which it really is.
>
> If we pass SZ_4K directly, we are back to using plain integers, which is
> not what we should be doing for rust interfaces according to Miguel. Let
> me send a new version of this with my Alignment constants + nz! macro
> idea, IMO it helps with the verbosity.

I'm still not convinced with the `nz!` idea. Having to have a macro invocat=
ion
for each call is excessive.

IMO we can just support zero-sized allocation by always succeeding, similar=
 to
how ZST allocation is handled in memory allocation.

Best,
Gary
