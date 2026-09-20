Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206A4C982E1
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 12:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C522F10E125;
	Sun, 20 Sep 2026 12:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="FAGgLc+F";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020114.outbound.protection.outlook.com [52.101.196.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CDD10E125
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3h4QLBJqT9Q/AF4Ok37eCVECOVnI6HP0lp5MJLlXYBhAMCeqTsR6ITg2eOJ7/2HvuBh925NLikIutKfJP0QaR/Ns0P2ESJBLZxt42FKWDqArl3cscg4tnf4RMxfZPVTlIePUbEvRmgEsrAwwtkR8qQ8pofDKsqbOiOMql0fPubCk7ADdV2djMGoaQGEbHbGwZp6gbPra+h16jn6eqgndd052vacziBBR0peg7XKXw+ppDS5LJ8ws992IOWQS5Xe9NplwTUvktiFYZ1Gh9zLieTVGWqiMm70ojagzotUqa3c7TKm1d+L9XBhWxyk4yBNFKaDAybe3zo7EWkbG9A3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmSyQQQGdDRmzfIVi6FTGnkxtD5CxUHOSdAKKBwkLe4=;
 b=h+nZOu47kIijlW+K2z5uCBcbOIe5czxvRNZQz1sNqow0X6K6MXQrhSPsIjdZSJEey7ubQooano38nOyPM2aKPp13i5vCx1k1ffh0IPq1iAXoGtQiqYm3QF0GrVcRlFi9zi8EtF1YzpMZ3dsXzBjO5R5tcHnMsrq2Fn/h31wU5Fr4OgKbD9XL1/CuyZT68ESEIuIcCyNRhKYwCGpi8SQ0a1YnSk7iAZsuPpzxIeslyTtet0eKn9BB19MSvQmJIJnCqiNZIrUhEZifhAPLkOJFwQfls28Rh8/1bxrc3BzuxIc64y6/6rroO4z/OPziZ0uvsBnOrZ4Em4pcjv0EamvpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmSyQQQGdDRmzfIVi6FTGnkxtD5CxUHOSdAKKBwkLe4=;
 b=FAGgLc+FT7b/9SvscGkJFhswEPuLIPcuKMS/QGxpvptKvT+geZmMIgy9OS0OeJseFBYERwH/lCYwh0oBfawR5C6OhKlomcOG3n2ZVuKmhWR3nQ1jJRG7GkmPIxFhFM+IjQgvNNPB1xSlq2Dke9ZiibtEacf/zhZGvh/hWp+yr0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOBP265MB8329.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:46c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:20:11 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 12:20:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 13:20:10 +0100
Message-Id: <DLK50D524P11.3CZN924YW8HHQ@garyguo.net>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
 <DLHGQN9VQ3TE.JYI851RVF7VD@garyguo.net>
 <DLIN1ZH244ZA.3JVCE0YKWAQ6B@nvidia.com>
In-Reply-To: <DLIN1ZH244ZA.3JVCE0YKWAQ6B@nvidia.com>
X-ClientProxiedBy: LO4P123CA0249.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOBP265MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c86ad7-8507-4fb1-c908-08df17118467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: XVUFdfQ9YxEGD7mZ0m6Olgye7UX4jZ9Y349JaxjZ5dnqtv8z3irKZRbEhbm5JGhcIYxgz+//ErfQ9iTmyzUDkYouRWrLj/ssCP4e/guWh7qQBX48nGM8VbgeyO2pNwzKwsr4y2tYWjj+b0lxaOtajLt8TlgFyVBaLUMMwLl59bOKw5dGJdSwDGGC5AQBo2PYyi2uUmdCD6du+hZFV26h9yiVmrexDnKWHm2L/ZGSA8yi87lgaBkUFFJzQz4Gjj7mbubtEmtNauhZvEIM1vLwU0zdqJOTs5MNbNvYz93d9JVLhKe9MifqgZt1xpgrey2SF0/onaLih83PRnl580X5aPGR5ooqtC702Ur2Z/5+eSI44foDyYl1vqsfyEa/8CCDo6wt0ByTbXv6+h44wPZmKzWm8TWYVB5hw8yepp6ia6QA24Ox5PzW1PG23ajkYoh+Odp6VjLJknG7yf8k6KhqvzQzI6Ak5Oc7llCWzPGhq4iszMQRdZ9bGbjiOzclc2yHg036Lguwu1rfHBy7sJrFg7r6st2MhbsUQmgszDPXv/UeLfXunAF+FUhue93GLohQ7Em8vdSjm6Oo6KjbOSAJlr8UD6l66CqSebgpTMcdVZ7UTSBfWA/pHIY4W6TxNIUd1nYqc9i3grfPV5vTwfkUNHEkqeWHuHVA8qgVWxns9dY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhmSVRhOXZvT2lxV01Bek1lV0UwRjNoM2oyNTg1S05Sa3RkMVVRZEp6bnJr?=
 =?utf-8?B?YzBtNWE1T1Z4YlFYRERKWlMvL0lpQ2ZhdFBaMmpjc0hiM2RsNjNiQXhnRG9p?=
 =?utf-8?B?Y05KeEhkWnVOZWdvY1R5RVNzS1JTdDhSS3VVY0dqUExsNzJYWG5mcG83aWFY?=
 =?utf-8?B?WDlnVXVnSDg1YnpDVjgwOHJOSWpveTdFRXBOblg2bkU1VGdvRE9JdFkvVFFX?=
 =?utf-8?B?SWthVm9nMXFUbHljUHI0cFM3UWxWSmZtTmxLUHlyYThVYjdLZWh3dFNQVDF5?=
 =?utf-8?B?QWJJc24rcWRZWW9vZ3hycHBCWThId2ROaU15cVQyL3M4Wm1INUZMVVhzalRv?=
 =?utf-8?B?WlV0ZWlHYlcxZldFeit3ME82YXhORE5YVk9GVFg2UkVwWmNTTkY1cDM3Zk9z?=
 =?utf-8?B?WkliTzlqeklwMHRqd05xeW1LT3I3N2VCeHVDQk9KWGlRVWZmK1lhUWR0NXlH?=
 =?utf-8?B?N2J0cHZJejVyR1NjVldHVjM5blk5dTVVWHZVZ0IwNElaOGFCdm50Y2d3ekw3?=
 =?utf-8?B?bFdWRTVXa3NDN2tuTWkyQysrd2pwcHNZYTkxWnplU1lsajc3ZDhsSmliTEl3?=
 =?utf-8?B?N0d1NFFhaENrdDBqYVVjdnZvTDk3eUw4N1dNbXZjQWFwTENzKytDKzNkdWU5?=
 =?utf-8?B?Yy9kK3UrUGhndFdyWThqbTZCdCtTanc3UmhRa0lZVTJQT0ZEd25aN0E3K2lj?=
 =?utf-8?B?b0xuZitkcEtOYmhNOEJHZXB0S1RndjgwQmtWblRJT3ZyMnNSYm0yS3NtWXJU?=
 =?utf-8?B?R0RxazRBRlFHdVYyVjFPREp1RjhseFN1S2xwa1o1dXgyVEdJWFhoRFpzMUsv?=
 =?utf-8?B?bXhpaitSY2VGLzI2YzdNcWFuM2F1czQ2NmtQMHdjWUo0aUpuMzYxZ1R5QWlM?=
 =?utf-8?B?ZmRiamxRMXNQK0N4dzZTRWk5OEFmMW8yZlJZMkE1eXVFS09SbVJEVzFMTEVW?=
 =?utf-8?B?bWY0NXpUZHRwdGdZT3U0QVBrS3ZpYlc4YzYxaUJDR2FZV3YzdUFEcCt0WklP?=
 =?utf-8?B?RUp4VTBjUklnN0YybEZPK2xKRDI5RFEzMUZ4dFhVV1grU3JwbW5UeW1hMWtR?=
 =?utf-8?B?RGNxYnprNmpQbHRKdHliSWQ1QlBKa1FnZlNDcTRtR0k3VUJZcDNhRkxLRFo4?=
 =?utf-8?B?UVp3Q2NlNldYL3U4SDdxZjNJdVZ6UEVsMXUrTk4rTFZ4TDFFL0k4Z0ZtcW5L?=
 =?utf-8?B?ZFpBaG9MQ2lXTzdRZ2tSZGhENVoyaTZNZytUTnVTNlJkUk9CUkowZ1poRmFi?=
 =?utf-8?B?MlhXMFNpTlMxOUhZOThCOGRIeG9aK3NOSTVud3J5NTVNUTRHN2I4cThLM2Ex?=
 =?utf-8?B?eDdJenhuOFVvcFlBaXI3WjZvTGV4T1c1MEt5ZDhjVHJGb3JLMkszSi9YZjFq?=
 =?utf-8?B?ZU8zb1FLc0JTZ2hKZFNRQWkvb1Evam5uSEhaTGNKdHVNUEsrTmNVcTRJTWFZ?=
 =?utf-8?B?blJRZythWVFxRTNvMjZMN3Z1QlBZNExZbGQ1SXFlbWp2Z2tkWnV6aXl4MnBj?=
 =?utf-8?B?ZkR3RTVvdlpuVGZaaFpsVXE5WGJ6NklMUGx5djdzdjduNnJBVTBERmNvMmR6?=
 =?utf-8?B?cG1xSjJ0TjI4Q29XU2o1M2cxT01hMGRXckN3R2VBSzVPQ09iQ2JpZU1XWDFk?=
 =?utf-8?B?TVNMelNPYnNPSDVGQkx6YkhVd1I5WnZWN2RKRE96L3NwVnErZjFVcDJ2Mnpr?=
 =?utf-8?B?M25RNWZCWmZEZHdhUTl0L1JJVGdYdG4yVnBLWUMyblpCRkpUaXZVRGIvbEtj?=
 =?utf-8?B?ODNCRkZ0V0xmL3pQeUtGb2JPREw5c3pCWmtXbFNKMml4SXNIVWFySkVsVFVG?=
 =?utf-8?B?NVhNeGpNUDg2aktsVy9MNlk1VzBDS2N5NDIwczhzcERSSTI4TTgzNlNiMVVm?=
 =?utf-8?B?Z25KQko4dnVSUHV5SEdHVVU3K1hxdTlUdHI4bVZZYmYrV2tqdXhjdFo2L2VB?=
 =?utf-8?B?cDZwSXVRTkRWV2dqVHk4dTdpcTZ2UG4rTE5HT0FJNUlkY2J1QU1icFVaTjNQ?=
 =?utf-8?B?SW5qUENVNis5c1ZhV2VLbzRRWHUyYUEwMTdqZVo5VDg5eUpsZlBDajY5TGpj?=
 =?utf-8?B?dDdWSEFSUFZuaWFoVityb216dlVwVFd6UXlyU0FGMTdIcXRHUERDaVQ5L2FT?=
 =?utf-8?B?RXFrZ1YrYVArYitIM1p5K0JCWHkrU1hVNkFIbjJ5S1JmeE5yOXF5VlZXMUpF?=
 =?utf-8?B?c0FQUE05Ulh2YXN0WTdpZHpwb3A2a0RuYWR0YUYzUWhSZHgyUXYwVWgwM3Fp?=
 =?utf-8?B?WmM4eWR6Rk1ZbU1JdmtUWHltMExNekhQSFpkWjkweWpnRVpvK1FVRkpSc2Mw?=
 =?utf-8?B?S1VtaGpNSzNhMDJEenlrdHFZN09lcm1pcUFMZnlzSGdaQWV1anlEUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c86ad7-8507-4fb1-c908-08df17118467
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:20:11.4378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1oF65VYoFyDBLMhZyITmECp8iOLAYKlJ4gs/N1HRKiQmvrFhmz1zOqxWZNb9akai/Fvnmnx1CZjaJ/FLC9ieA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8329
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

On Fri Sep 18, 2026 at 7:03 PM BST, Alexandre Courbot wrote:
> On Thu Sep 17, 2026 at 9:53 AM BST, Gary Guo wrote:
>> On Tue Sep 15, 2026 at 8:39 AM BST, Alexandre Courbot wrote:
>>> On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>> unfortunate because it disincentivizes using it in interface boundarie=
s.
>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for consta=
nt
>>>> value) takes a const integer expression and widens it to i128 (at buil=
d
>>>> time only) before passing it as a const generic value to a new trait
>>>> `FromConst`. The value is then converted and appears in the
>>>> associated constant `FromConst::VALUE`. The trait is implemented by
>>>> NonZero, Bounded, and Alignment and lets values of each be constructed
>>>> from constants without a verbose turbofish syntax.
>>>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>>>> `cv!(1)`.
>>>>
>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>
>>> I don't think we have any user but nova-core at the moment, and it
>>> benefits from this in several series (patch 3 here, but also ID pool an=
d
>>> later r000). Miguel, is this ok if we take it (i.e. the next revision)
>>> through drm-rust-next?
>>
>> How about a topic tag shared between Rust and drm-rust-next? We could al=
so
>> remove the old num casts API as part of topic tag and fix all existing u=
sers as
>> part of merge.
>
> Not opposed to the idea but IIRC there was already some pushback to the
> idea. There doesn't seem to be an urgency to remove the old num casts
> API that justifies doing it now with a more complicated merge path.=20

Sorry, what pushbacks? I thought that `cv!` is what everyone agrees on. I s=
ee no
downside of this compared to the turbofish const conversion APIs.

I am not opposed to delaying removal for the next cycle, but IMO the `cv!` =
macro
should be present on Rust tree so it's visible and improvements can be made=
 from
there, so I think we should do a topic tag regardless whether the old API
removal happens or not.

Best,
Gary
