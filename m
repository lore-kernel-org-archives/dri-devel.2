Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606E8C624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7286D10EC90;
	Tue,  1 Sep 2026 11:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="ZYt2gO9o";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022097.outbound.protection.outlook.com [52.101.101.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B78910EC90
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCmFYqyLaH/KzJh7aEfH8yzO7KGYXWd46LDmbSnxwd8Ges0a1Mc0PjR4MyKbTG3b1eZ+DjI7uN7dhousfWYiVnPRlAzwHtMDz119WYcPia8p3xp24R78nbp8Ge10Z39SBwGwaqB8Bqk74eESWvxhDwxSK7aHvEk2rZ8W9fSOBxsbzuYd3lgmLF9BhR72rrJnA/2HqY6oWgC0yGxwXQ6VUWtCacjgvrjDfS2poMfNmWI2AmK0ID8eIkdXjUj62D2juNCbDt8BcsseGc9fAjZI1FOCjpKZ+5CZ3KYqg375hLde92dOqL4B56smKufUReDKrijwD5LjYAksNe5F+TNDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOq5Ujrtc3U2slahBtE/TYAwHJWrOE1Omqae1qLnqcY=;
 b=B6EUgOk/oDcgBfeKqcrAS9VIUE1Tx2sQ5ydYvkjKLwjcRbqO67qEfvIcmGKGwrr0VkmtiS7Lz+HqEY+02TNBl9n00D5U1uF48eBBi2sYY3YYNtMu1i7PtfJKTspkFf7EzUbBmXO5K6xO+2Kn7szK+CVvVhHJWcUd7p/l7rO9X+JFESNgWqXWKWtUKNmFfVahe9ZlV3aRy+o4GjuddUfYbTlzNjFBs/oITddoTjboYHAHQoabqD7XnVIvamfxiPQv+aLfbWfty9tUCqSd6Mqxb/L6IhCRGB9iXI09Q0lmwP8X0FNB0aHnmf4b2AiCyy0aPTJApxYpIEZmuXwoPrWqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOq5Ujrtc3U2slahBtE/TYAwHJWrOE1Omqae1qLnqcY=;
 b=ZYt2gO9oEL2gaAR9Y82vFZjIHwWi2ck5eO8TGB1CnZXPdNAA1bmFRqlZrtkPdt5Yn1wucZlnIr34ImQRcCHAJQrygwH61t/CYt1o/TI22jpnmgjb8YF7ERaC+GhJnSkAAE5ZxhxbDrcE5B6t8MJBT+EHSzhot35twNavZPaMmhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB2525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:50:31 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:50:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 12:50:30 +0100
Message-Id: <DL3YHAWZ9368.2E395SXR3CTEV@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
 <20260901-cv-v2-1-446bc69d2ade@nvidia.com>
In-Reply-To: <20260901-cv-v2-1-446bc69d2ade@nvidia.com>
X-ClientProxiedBy: LO2P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB2525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f28e04d-f040-4cf8-159d-08df081f39a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|7416014|22082099003|18002099003|3023799007|56012099006|6133799003|4143699003|5023799004|10067099003|921020;
X-Microsoft-Antispam-Message-Info: S3eEDFHhEy8kYGrspvSaqKh9G0qzk7xsLz/4jXzLjPxTGpehOzJ7TANqNJKWD56rd4KGuckT+pSY86jVccYfeyzRYTw1K7L5WKOVDzx6EBt8jqB21oIfIScSk2Aeu3KqEbRhPlvUQZ3ngYSu1HXHUHD5imskR1JeeW1ERLrkWaEP8drorUvigGfxgqSv1SuVI0OT99S6hRwbmOApp4zpk2VtS4tUH+aDdExkwMSs7KgttTuxNiXQ/G5iErKuaan7kLHVYofrNTTA/rI9aFQ5g37NH40PHbGlc7faIb3qLrGj0EtwiaTPbqFxCTlt6evNvBhfcFR74aIP4s7iNWD59/pixai3mQoLzQJmTCJJQeVMP3A70Lud3twm3BeEutYQ7AXzgNIfOLvbpp50BnqYmcWG/8FTJyQD02dw3zLPPtPQDsUTnPjxbqFARAXyW9MYwdxNN7fWj4wffgkrczllIRIH6192rwjUg8bv2q3pXL+rMTSBoykkEfpYq6XioOxuWNeVJrfp6zk/yDimE7u+0zvsqqrK1BjhpX4RvzGR5jn4DcdpctAva0WtDh6B0mOarC1QEtu/QDkexSLyyMfXmTxUxBdbsi3qNwTYU3o/Vgvqux8DG33tRdBfTk7N/K2R1EDmPHOJVHK7w0hexQ/fJkuQp0yMbKhKfjMaP6dCGls5URU3KOGB429aJZBv5FiNl81qnckra0yGWrpxpFzwDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(3023799007)(56012099006)(6133799003)(4143699003)(5023799004)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpDRnlYTWRFWmdMOWVjSWcva3lXb1NpSDB3TnhzVm9oZnIvR3h2aTAvcWlT?=
 =?utf-8?B?WWRoZ2ZYVmpaeUFXNnpTVWxMcjBhRmRtTVhuVjNxZWlaWEpkdGU5MyszRnU5?=
 =?utf-8?B?enJFWGU2bU9NdzRCaXorbm9ldEFFYzN5VE9ncjlFY3E0MFpxQjhWMHllcG1X?=
 =?utf-8?B?S0g2alU3SmdGNEM0aGxvaE41and6bU8rY1hrU0hMQ3VEMG9XWldUUmNlUWpr?=
 =?utf-8?B?WWJxQThVUkx1Um9hSEFPbDVFaGpEQ1BHMHZhY1pHLzYzOUdFUDRhN3E5cElX?=
 =?utf-8?B?Z2pTbDJPRUVrcXYzaUJmUUd0bHY2S0hLZExaMDBORVdOWVBhMWNOOG5CeUZn?=
 =?utf-8?B?cVFETUZPMHlVRTViNmtZbjZJRVoxSnNRaWtVSmMzVnRkZkFTZ3JiK3pxdUhv?=
 =?utf-8?B?S1V6Y3VrRyswVUw3R3BQZ1paMkpvK2g5UEVhNVpWallQYzFmZEFmUUZXQWlH?=
 =?utf-8?B?QlBlaFNkbU1HQlQ3WXA0VUVNUU5XNFBmdmRTc3VVR3pVSHZMc2cxQXM3ZVZQ?=
 =?utf-8?B?aTcvZnc0MmNVUGJDQmgyTnBKMHZoc1A1eHJYeVBqMFpTbjZQcXRkYXJITFNG?=
 =?utf-8?B?Wjl5K0tsZjhDZzd3NWE3cjJUbEtIbkNYU0huUmQ3aHU0Q0ExR3hrMk81M0x2?=
 =?utf-8?B?OExRamFuMDB2cG5lWTFhZzcwWmlZLzE4MU10WDlPT2l6Z3lQZkF1R0ZuT0dn?=
 =?utf-8?B?QVdFYmx2ak5lL1o2SmM3dVpDbTJQV2EyOFBWQnkyaGhjYUlWb0ZSQWVEOHFI?=
 =?utf-8?B?RzFlNzRzRFJNVGFnOHlqQ2pXQW9INDhwejRVR3plc2VYZHh2V1l2RE14M1RZ?=
 =?utf-8?B?Q2ltTmJIaGRraUx4b1g3WlV6dDRXb2NIL3Q2enViTVZpbWs0VnhMRjFFaUZ3?=
 =?utf-8?B?YWtkcXVlVHZEWVZkTmdsdURZSndROXJiRzEwSlZsb2dBQ1hUT2hhbEdjb05h?=
 =?utf-8?B?TjVGL0FQSEZyRXN5S3pPYlV3TnpscmNRRUpVWk9DZ1lrUXR1aU04TVp0ZUl1?=
 =?utf-8?B?L3EyeE0vWFpxZlJaNGdwZnpiZVV5QlJaL1Jicm9nSTRwOUdRbC9TUmZJUnNn?=
 =?utf-8?B?dkZydFUrLytYSFhwRWxMZW5RRElaVFMvcXdHeno2UFg2MTZIb21ycXVJNC96?=
 =?utf-8?B?cU96ZVYrQU9WZWFMNWVuSGNHZlJPUVE5SVF3WjN6WDdGc2syajR5UmhzVmsy?=
 =?utf-8?B?M214MTArODV1WWhEd0kvSTdLeGNUa0Z3MUI2bkJIQytiVSs4M1JReEpDSnV1?=
 =?utf-8?B?c2J5STF6ejMreGplSjV2dS9ZRkJiYURxREFBcllIa25BcXpRVlluT2g4WWVp?=
 =?utf-8?B?Qkk0TEFkbWxSb0FoUFBTa1NnMDZrd1prcGRMM0dvbTljY2Nwb091cG9JeFdx?=
 =?utf-8?B?WlhGOWJwY1RLMGMxS09vUG02Qzd2THBqWWVvZTFlVzlmZlJiNUtraEowQVZ6?=
 =?utf-8?B?a1FhR3F1NXhmNmE1aFBQSUxBYWNYcm5yQkxCZS9Bdk5kZVlVdVphMFBIdHBF?=
 =?utf-8?B?dktvcUREa0FycUdrakZuZnRrbjVxUSs1RmpheHR6S2s3WGlCb1EzcSt1VXNy?=
 =?utf-8?B?WEhjNjEwOS9BejNSSVE4eE9iYm1PcGg2UXIwYlFZWU5HL1dJU25aQ0ZqbXZV?=
 =?utf-8?B?TmJJNTZWbkU3K3lkTmduMlpDZ2dDZWZLS0ZaK2N6OFBiZHQ2bFlqc3A4U1cy?=
 =?utf-8?B?RzBxTnVLTzJLa2lsMGdBTnA4QjMxbXNEa0lLU25mSVpxK2tIVHpXZ2k3Y2VW?=
 =?utf-8?B?QWswWmpKTkRqd3V6UTJPZkMzSHZ6UDZUUGNENEovaHRDZ09pQW0zNkxqOW1C?=
 =?utf-8?B?VUxYQ256SkQ3bGpQaVh0NzkzaUtzeThteTFKNGxMcEQyVWswdnErazlZVjA1?=
 =?utf-8?B?Si91Y2orcTRaL05rRTFkRnNzdU8wZGpjRmtPOVErbStPNWxtSlRXTHVjaTdR?=
 =?utf-8?B?d2JhRmJOSG5RcEdETHpOaXlUbGJoQzJ3UEVyTmVnM2tvYlh3ZHJUZTVadW45?=
 =?utf-8?B?ZEE1S3QxTGpTTTg4Qm5OSWdYdktTY1ZtL1U0bWZmM01vczVDdnFVN2FxSVlX?=
 =?utf-8?B?Y3k3WDlaRGNDS0VySnpvTDhXVU4vK2l3R2dkek94RVVpL2RnWjlwU3dORnZ0?=
 =?utf-8?B?QXNSNjArUmtZa2tjdnJlelA5bGRQYWM4RU5LNmlHN3RxS3RBckZ1UGVpNndH?=
 =?utf-8?B?aWJCMWtNZWhGdlVxcDRTb2IwSTlmMkUvbUhMb09FR0R1WHh1eHBCeVQ1Snhi?=
 =?utf-8?B?TUp2d0JDTG8yYThNWjdBdlVkVjhzd281N1Q3SXJURE5IY1RUNEZkWHRXK3Nt?=
 =?utf-8?B?R1JzNEJNbnNaa1BSZ2VycTkrUS82ZmErU1B5cDQzNGJiemN4WlJzQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f28e04d-f040-4cf8-159d-08df081f39a4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:50:31.4885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRNtP+IuwgHIG1Uf2r9aGMu3L1+VR529x8PN7nR+UvIlcZ3Xgsh0OTZd6RLbyM7wa5zL5erH2w9sGHufWvoO3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2525
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

On Tue Sep 1, 2026 at 6:06 AM BST, Eliot Courtney wrote:
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> `FromConst`. The value is then converted and appears in the
> associated constant `FromConst::VALUE`. The trait is implemented by
> NonZero, Bounded, and Alignment and lets values of each be constructed
> from constants without a verbose turbofish syntax.
> For example, `const { NonZero::new(1).unwrap() }` can be written as
> `cv!(1)`.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/num.rs         | 133 +++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/num/bounded.rs |  19 +++++++
>  rust/kernel/ptr.rs         |  14 +++++
>  3 files changed, 166 insertions(+)
>
> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
> index dbe848e30efe..01ae2538b3e4 100644
> --- a/rust/kernel/num.rs
> +++ b/rust/kernel/num.rs
> @@ -2,6 +2,7 @@
> =20
>  //! Additional numerical features for the kernel.
> =20
> +use crate::const_assert;
>  use core::ops;
> =20
>  pub mod bounded;
> @@ -9,6 +10,138 @@
> =20
>  pub use bounded::*;
> =20
> +/// Creates a value from an integer constant expression, with validity c=
hecked at build time.
> +///
> +/// This works for any type that implements [`FromConst`], with the targ=
et type inferred from
> +/// the context, or named explicitly with `cv!(value =3D> Type)`.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use core::num::NonZero;
> +/// use kernel::num::Bounded;
> +/// use kernel::num::cv;
> +/// use kernel::ptr::Alignment;
> +///
> +/// let v: NonZero<usize> =3D cv!(8);
> +/// assert_eq!(v.get(), 8);
> +///
> +/// // Any integer constant expression works, not only literals.
> +/// let m: NonZero<usize> =3D cv!(usize::MAX);
> +/// assert_eq!(m.get(), usize::MAX);
> +///
> +/// let b: Bounded<u32, 4> =3D cv!(15);
> +/// assert_eq!(b.get(), 15);
> +///
> +/// let a: Alignment =3D cv!(4096);
> +/// assert_eq!(a.as_usize(), 4096);
> +///
> +/// // Checked narrowing of integer constants, including in `const` item=
s.
> +/// const SMALL: u8 =3D cv!(200u32);
> +/// assert_eq!(SMALL, 200);
> +///
> +/// const N: NonZero<u8> =3D cv!(5);
> +/// assert_eq!(N.get(), 5);
> +///
> +/// // The target type can be given explicitly.
> +/// let e =3D cv!(200u32 =3D> u8);
> +/// assert_eq!(e, 200);
> +///
> +/// // With an explicit primitive target, the expression can use generic=
 parameters.
> +/// const fn as_u64<const KEY: u16>() -> u64 {
> +///     cv!(KEY =3D> u64)
> +/// }
> +/// assert_eq!(as_u64::<0x40>(), 0x40);
> +/// ```
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! cv {
> +    (@cast $v:expr =3D> $t:ty) =3D> {
> +        const {
> +            #[allow(unused_comparisons, unused_assignments, clippy::as_u=
nderscore)]
> +            {
> +                let v =3D $v;
> +                let r =3D v as $t;
> +                // Pin `back` to `v`'s type so `as _` casts back to the =
source type.
> +                let mut back =3D v;
> +                back =3D r as _;
> +
> +                ::core::assert!(
> +                    back =3D=3D v && (v < 0) =3D=3D (r < 0),
> +                    "value does not fit into the target type"
> +                );
> +
> +                r
> +            }
> +        }
> +    };
> +    ($v:expr =3D> u8) =3D> { $crate::cv!(@cast $v =3D> u8) };
> +    ($v:expr =3D> u16) =3D> { $crate::cv!(@cast $v =3D> u16) };
> +    ($v:expr =3D> u32) =3D> { $crate::cv!(@cast $v =3D> u32) };
> +    ($v:expr =3D> u64) =3D> { $crate::cv!(@cast $v =3D> u64) };
> +    ($v:expr =3D> u128) =3D> { $crate::cv!(@cast $v =3D> u128) };
> +    ($v:expr =3D> usize) =3D> { $crate::cv!(@cast $v =3D> usize) };
> +    ($v:expr =3D> i8) =3D> { $crate::cv!(@cast $v =3D> i8) };
> +    ($v:expr =3D> i16) =3D> { $crate::cv!(@cast $v =3D> i16) };
> +    ($v:expr =3D> i32) =3D> { $crate::cv!(@cast $v =3D> i32) };
> +    ($v:expr =3D> i64) =3D> { $crate::cv!(@cast $v =3D> i64) };
> +    ($v:expr =3D> i128) =3D> { $crate::cv!(@cast $v =3D> i128) };
> +    ($v:expr =3D> isize) =3D> { $crate::cv!(@cast $v =3D> isize) };
> +    ($v:expr =3D> $t:ty) =3D> {
> +        <$t as $crate::num::FromConst<{ $crate::cv!(@cast $v =3D> i128) =
}>>::VALUE
> +    };
> +    ($v:expr) =3D> {
> +        <_ as $crate::num::FromConst<{ $crate::cv!(@cast $v =3D> i128) }=
>>::VALUE
> +    };
> +}
> +#[doc(inline)]
> +pub use cv;
> +
> +/// Types that can be created from an integer constant expression valida=
ted at build time.

Can you add a comment referencing the `cv!` macro and advice against using =
this
directly?

> +#[diagnostic::on_unimplemented(message =3D "`{Self}` cannot be converted=
 from a constant")]
> +pub trait FromConst<const V: i128>: Sized {
> +    /// The value that corresponds to the constant `V`.
> +    ///
> +    /// Fails the build if `V` is not a valid value for `Self`.
> +    const VALUE: Self;
> +}
> +
> +/// Implements [`FromConst`] for primitive integer types and their [`Non=
Zero`](core::num::NonZero)
> +/// versions.
> +macro_rules! impl_from_const {
> +    ($($type:ty)*) =3D> {
> +        $(
> +        impl<const V: i128> FromConst<V> for $type {
> +            const VALUE: Self =3D {
> +                const_assert!(
> +                    V >=3D <$type>::MIN as i128 && V <=3D <$type>::MAX a=
s i128,
> +                    "Constant cannot be represented by the target type."
> +                );

nit: as this forms part of compiler error message, this should start with l=
ower case and
not have ending with period, to be consistent with other Rust error message=
s. I
probably should have mentioned why I made the change in my alt version.

Also, `const_assert!` would have an additional `const {}` wrapping which wo=
n't
be necessary because we're already in a definitively const context. Probabl=
y not
matter though.

> +
> +                V as $type
> +            };
> +        }
> +
> +        impl<const V: i128> FromConst<V> for core::num::NonZero<$type> {
> +            const VALUE: Self =3D {
> +                const_assert!(V !=3D 0, "Constant cannot be zero.");
> +                const_assert!(
> +                    V >=3D <$type>::MIN as i128 && V <=3D <$type>::MAX a=
s i128,
> +                    "Constant cannot be represented by the underlying ty=
pe."
> +                );
> +
> +                core::num::NonZero::new(V as $type).unwrap()

This unwrap duplicates the zero check, which is why my alt version does a m=
atch
here instead.

Best,
Gary

> +            };
> +        }
> +        )*
> +    };
> +}
> +
> +impl_from_const!(
> +    u8 u16 u32 u64 usize
> +    i8 i16 i32 i64 isize
> +);
> +
>  /// Designates unsigned primitive types.
>  pub enum Unsigned {}
> =20
> diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
> index 2a2b0a4bca5e..0cfb3ef16a6d 100644
> --- a/rust/kernel/num/bounded.rs
> +++ b/rust/kernel/num/bounded.rs
> @@ -14,6 +14,7 @@
> =20
>  use kernel::{
>      num::{
> +        FromConst,
>          Integer,
>          Unsigned, //
>      },
> @@ -272,6 +273,24 @@ pub const fn new<const VALUE: $type>() -> Self {
>                  unsafe { Self::__new(VALUE) }
>              }
>          }
> +
> +        impl<const N: u32, const V: i128> FromConst<V> for Bounded<$type=
, N> {
> +            const VALUE: Self =3D {
> +                const_assert!(
> +                    V >=3D <$type>::MIN as i128 && V <=3D <$type>::MAX a=
s i128,
> +                    "Constant cannot be represented by the underlying ty=
pe."
> +                );
> +                // Statically assert that `V` fits within the set number=
 of bits.
> +                const_assert!(
> +                    fits_within!(V as $type, $type, N),
> +                    "Constant cannot be represented within the given num=
ber of bits."
> +                );
> +
> +                // SAFETY: the asserts above confirmed that `V` can be r=
epresented within `N`
> +                // bits.
> +                unsafe { Self::__new(V as $type) }
> +            };
> +        }
>          )*
>      };
>  }
> diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
> index 82acb531b17b..ecb73bdb0c5f 100644
> --- a/rust/kernel/ptr.rs
> +++ b/rust/kernel/ptr.rs
> @@ -166,6 +166,20 @@ pub const fn mask(self) -> usize {
>      }
>  }
> =20
> +impl<const V: i128> crate::num::FromConst<V> for Alignment {
> +    const VALUE: Self =3D {
> +        const_assert!(
> +            V > 0 && V <=3D usize::MAX as i128,
> +            "Constant cannot be represented as an Alignment."
> +        );
> +
> +        match Alignment::new_checked(V as usize) {
> +            Some(alignment) =3D> alignment,
> +            None =3D> panic!("Constant is not a power of two."),
> +        }
> +    };
> +}
> +
>  /// Trait for items that can be aligned against an [`Alignment`].
>  pub trait Alignable: Sized {
>      /// Aligns `self` down to `alignment`.


