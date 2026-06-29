Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF743C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368D210E723;
	Mon, 29 Jun 2026 07:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CzCOQs35";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42AB110E723
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUN8R+a4wtK392bRb5F47kcfavKSS2bs5JiAEsbY8tNqRIc2Uj50hF8Tjtj6KXO2a+0HUW+gHy1sD7m142ZZM6xX8PJ8Od14/sSWhJq0ur1RtrJbtZ92aaqGhx9KTfPN9vsvu8RFjA9OFiSUS1cvobhJgf9uwZJ9BRgytveHLa2+lfm61qt8f483OTLwpXIo4TMYgNKaJX/KGuaqREGshR2P3UwO7P3W++FvLt9kDSMftXy3GdJbIzGBYdGs4Ma7OmL+RVgT6pxE3qHcLXDRPr6I0q9Ut/HmUwTHj2BMLD+OS848X43hduxrv0PG4kZcBD0O7gLofO+0HstvSO+FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X4253alAa6pstqYuuUv6nkI9Q19klW9YmygxHrYT4w=;
 b=LWWFDkb7LtIPmPa3wZYjKMjpMcHxvMkV5gj5RoUBp47k2QJRSn7lBK7JExNbe4MOrwBA19SkAZ5ttAEzEzirH5u+KoM8o9t01E06D8L7aY27kSE3SwqXaLWb7bvxp0qSY83oW94rxCRFDvnDjnRvdyeOi+jY2jlxxpVqQDsm7vyIdE3/B8y0AQdwzIMffjE4xofTg0giQxQTqglaKqwUXwOO3PGwPEMQfDJgnzAIcgzF7xHPM3e370uGj0uE1pzHYfC+c32XJofN4ZF5dUBjEVDYz1+TXwXQ27ZHZu0qT6IMNsU2A8ZXtwC4OJCT+merpv30bWtrqgUvEGBGrqiCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X4253alAa6pstqYuuUv6nkI9Q19klW9YmygxHrYT4w=;
 b=CzCOQs35IjjSIdgZo2by0Rw6ClcuhC8v3clRMq4F4MALQ/j5uxZ+VgUYgJfZg83WlGifoqKyR+cmVNbzApH4ScLp0FsgMnfs8UzYGYnIyWGdKTIyo5IoWJS6q0fcxJHiZmMYTIWypUAqyYwUcIgBRO9PAa4lg5/p/6ZwwR0gz+YI201lvixmaSKGESKHTsfKgjN8KAAYpvkyofA6APSLIGn4PsgO4Zi3QL2f6LyWqsf4mvTwPP2raYeU6uQe0bJqBkmMecidhk3GwahFZKRPVKDB/N/wNvc+l8FpDn6LWWEVNy5qYH444p0Mi8qo1MpvhR85I+oxG+zdCodqMs7YeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:17:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:17:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:17:35 +0900
Message-Id: <DJLCLH7GDSBW.28J4PZW0FD60B@nvidia.com>
Cc: <engineer.jjhama@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH RFC 0/4] rust: dma: bridge zerocopy-derived types into
 the transmute byte-safety bound
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "SeungJong Ha via B4 Relay" <devnull+engineer.jjhama.gmail.com@kernel.org>
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
In-Reply-To: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
X-ClientProxiedBy: TY4P301CA0111.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de2e158-953a-409d-ae2c-08ded5ae80b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OHX/pO0OxdgHr8uGDMKWb4husl/V+xrzTzCrtBCtPg/swM/odfyZ1GBFZ3TuDLqa/iNfbX793qQYrHa4LPrmoxxpyj+3efFgXKT+VcJge6uq/d+oa/98+aPDBlU+zRQt11gaeS7VjMtWNUNsgyriOzNo0GCgIwo6j1KN40RE9O2VL9Bx/9a8MpxUJRDToUiKsf27gT4l9gLw2QDgVrxuYZA/v5j5puMrnuDB6ALFhuKEgXsa+4Y0ljR/5/eJ+vpUB+LjxedOiiWrs2jpKTms5ZmjdcchRjFCbvQIKBgrIWmIiG8WiTePwJOzPxHIb0JAkWTJD7JPqaVYDdOpA4oEPagpxphb2x0t4troC2lmcoNTGETBAQu6A/neSNsw91DHQ+p4htYwL+E3whaitSovy+rPiPEKnFCq/x++5ucAkLNtJbiCmV9RHw92kuKpy2apmJcQlHjoaROl3GrkXPDjDVxub1RNM3sOAF3ys3b9TKIXYGNYckvXGVmYtoac7cLNFDKc3n6TuKdMiN6lN0Jh+CO25EAFvoUv587qupXsL029XSDlQ/38RzYXbp2JB3fU+UswDbDOoEbQKINnXAs6ptZTGKtpP0Qrh70/DTwRssW2Zl7FnnyreNyISef5u0doMVQsFRlkb8+QWJX+pE0U/fXtVA1Ol4gdWI3poOd+2Uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWMvNG9UUVo5NXpwcE1FVFBnSFQ1YzVwSzFaeGoyMEJxM25GclVFTnRHUEZ4?=
 =?utf-8?B?dERvcWZWZUFsdVNNRVB0ZHUrRlM5aUN2c2pJT0NRbmZzaHgzckpibXpPc2R0?=
 =?utf-8?B?cmdVWC9pdlZoS24zcktJZEE4N1pyUHdRdUxHNmpZeU1tNFBTNGJQbTR6YVNM?=
 =?utf-8?B?U3FoN01XMk45dGxoemc1UW01WXhmNkpJVEJwSXNtOGNCVVhpNWxSVm4raHNT?=
 =?utf-8?B?cUtLYVRVMys0ZlQ2YjJFTnhoTTcyL2pMeGQyWGdWb0xudjBPeWVhS21vTi83?=
 =?utf-8?B?dDFWR09lenBZZWI4QlhOb2NIa1piUnRDTjkwV0tWd29GYkZ1aUJHc1Urd2Rs?=
 =?utf-8?B?Y21kMWhoK01ITUUydDdnT2tlU01YK2VIbE5WVEo2aWpqY1JicHFaN2hyZkRq?=
 =?utf-8?B?UjdrcENrMzlMU2JITzc4SjFJZ2hONFczL2FNeHZRT3BmbEkwbUNvZCt3VUww?=
 =?utf-8?B?NnBXUTVlOFgwV1BEdWJ0SGhmMmYrUENMT0hnUGdNcnhMeEtBSjBBS0JZKzlM?=
 =?utf-8?B?Uldtc01BOVcvMkdKR3hhdW40Vmp5eWw0RlR5MSs1TFFMRlpQNy9mSGV1bEhY?=
 =?utf-8?B?WHArU3A1d3R5YUZsT1dRUnBUMnI3aTZaUXZtSWlWcVp0YjVHVk1DajUzV3dI?=
 =?utf-8?B?NUhwOTdYYXdIVzhseHBaSHpsYmlzOXlNQ0dRamZlVTlyeXFtclhyYnpnUGpW?=
 =?utf-8?B?WHh2SXlKM09VSG53RjRjOGdiV25xOEZUYXRUYkR5Vm0rSFVGZlM5KzhLRlNL?=
 =?utf-8?B?UGxxOWwrMEgvbHMvbm1ad2RIN2NTcW9QVUQvZURyaWhuNm81UWZSd1JQd3R4?=
 =?utf-8?B?YklUditzaXhhbTkxZU9RYlNDMWVMSzBmM0w2SU5Gb0lWSXdkNW9kSmZhQ0tT?=
 =?utf-8?B?dzhjWnZmZkJNTXozTDhWenhHVUtua2prVUhON1o1eW1jZERxR1BTbWdlYW1C?=
 =?utf-8?B?NDIvM0dzOGVUU2MyUXFYTnVGNWh1dXdrazlqcnQ0NmJyU2pRaUswcU4vS3lv?=
 =?utf-8?B?alV6QXdrUzliazFSNTZVa0o0dXRla0VLMjFBYjQ1Y2FsUjZoRlIzc1VVckp2?=
 =?utf-8?B?bWNxZHJ5V3JQR0tNbzB5OURzNmhvOXVnZjgzQVAyQVQxbnRVTFh0ekt5S3da?=
 =?utf-8?B?aWxBZ2NEUUpnWDBXTGFwbFpFRzQ1c2IwTm1Gb21TeGpUWTJrdUQ3Z1RMMllT?=
 =?utf-8?B?MFVrUHIxN1pGS3J6d0tJaVVscE9ydXUvUklMMHpaK0g0TkdLYWZrWnJQeURt?=
 =?utf-8?B?TTRVeDgwUWw4UE1IajZoUWsySEpKazRoMlhGbEYxQUZtMkRESXlXT043RXZB?=
 =?utf-8?B?bC9FYmxyYWhHUmltZlNjbSsxZnpZU3l4VFYwdVdTOW9CQTcxN3JLcWtEUDZR?=
 =?utf-8?B?NE5ERkY4bzU4ODRGTThyREViVXlrSHBGNGhwQjJOWkpqWGoxVTVRa3FDWXZX?=
 =?utf-8?B?SENCMkt0SStOY0JwL2xJM0YwZ2ZTZXVvNzNwNjJJRU1aa1M2ckx5WVZuV3pr?=
 =?utf-8?B?ckhyNkUrdlYxWEltTExhQ0V5RzA5aUFyTGgvc1Rqb1hhdTg2Yk5RZVBtZ1NS?=
 =?utf-8?B?RFc0ZjgzcFUxdk1Nc2tCaW0xVDhiOWlpTWwxZ012RDRsNmJITzhoYVBUNDQy?=
 =?utf-8?B?YmFPTG14R2hyNFY1V3QrcFFNZzhJb2p5RkxySVBPRU01Vkx1UmdrSWRxVTJH?=
 =?utf-8?B?VGtndGpUNmVvbjlJT0hTYkRQNFFFMytCcGlmalQ2TGFaZmJDNU4wdytsLy9D?=
 =?utf-8?B?QUduOXk1b2ducmg2ZytLMlJaSU55NVNSODdYcTU1Vnp5NThwbExuUUJFeVJo?=
 =?utf-8?B?TG9lR2FkUVRzU1NSRjdJTWViV3l3ZWR5bllNc1JHTDFhamhWTDF3RVlFRWxG?=
 =?utf-8?B?L2JOemYzZGFRdm5Vd1ExQ3JPYTBlMHhZbmdVcmF2WlBIQlptbHRJRFZ4bVUz?=
 =?utf-8?B?V20ycldFNmIrS3Vwb2FkZGdvUzF6WWJXVFZFaDd2a2pITjNOelozQ3N5VHJq?=
 =?utf-8?B?cHp4SlhiTDBYUVl2Q2pIeTZKcHAvdEJGYVV6NGovbjBpSncra1dzNDNlNjBF?=
 =?utf-8?B?emxZUWlMNDBtZnNqNm0vLzRyNVdhTzA2enkzbWwzWUZudmI4bWtEeGJXejBJ?=
 =?utf-8?B?VXR0dGZRQk55YXBvTmRyMEx0K1IvV1lmUjZvYTdJaytwcmJFblQ5TGI0d2l1?=
 =?utf-8?B?Z0tmbExmVmUvK2FSUnREM1habFVtV05ReStNZEduUFhkQXVsU3A5dDZPVFhm?=
 =?utf-8?B?NUdsRHFlZkNDMTIvbFV1MkdIQXk1TkNGK3pmTlNzQlpvS3dGeTJPTHo0Kzl5?=
 =?utf-8?B?M1ZwNkRveDFKNXF6SlNvQVg2bzZRTE45c3NINFFVUHpTUWxobTJhVWZyOUdK?=
 =?utf-8?Q?ZC+GkIPj4nf7Nz8pZswzBpoj4Jq1Ik+T7L2DxWTVWRs/E?=
X-MS-Exchange-AntiSpam-MessageData-1: aDOyATptAP0Nsw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de2e158-953a-409d-ae2c-08ded5ae80b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:17:39.5081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uvj4rAvua7BL1wGVhhSrDdtxKtqen9aWBAzQ8xzeCI7TvVDewsFM9xAMtYtucyo1dqR5NhRRl9jreFVr3b+gQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

On Mon Jun 29, 2026 at 2:10 AM JST, SeungJong Ha via B4 Relay wrote:
> DMA-coherent allocations (CoherentAllocation/Coherent/dma::Pool) bound
> their element type on kernel::transmute::{AsBytes, FromBytes}. This RFC
> lets a type satisfy that bound by deriving zerocopy's byte-safety traits
> instead of a hand-written unsafe impl.
>
> The bound cannot be switched to zerocopy wholesale (some DMA structs are
> unions that IntoBytes cannot derive), and a blanket bridge impl is
> rejected by coherence. So the series bridges the two per type:
>
>   1. add the bridge macro impl_transmute_via_zerocopy!, which emits the
>      transmute impls only for a zerocopy-derived type.
>   2. re-export zerocopy::Immutable from the prelude.
>   3-4. worked example: convert nova-core's GspMem and msgq POD types.

Can you give more details about what the macro is for? My understanding
is that it is a temporary fix for the generated bindings; if so, I'd
prefer to apply a definitive solution (like using
`#[derive(zerocopy_derive::most_traits)]`, or updating the bindings
generator tool) rather than something that will be removed later.

I also notice that the macro is in the Rust `transmute` module, but the
only user is Nova; so it should have been either be Nova-local, or used
by other Rust modules.

But intuitively I'd say that we can (and should) probably do without
this intermediate step. But please let me know if there is something I
missed.
