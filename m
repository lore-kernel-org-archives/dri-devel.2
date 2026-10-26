Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496D606A327
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=co0hNVNv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0851810E06F;
	Mon, 26 Oct 2026 05:25:25 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012023.outbound.protection.outlook.com
 [40.107.200.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE50010E06F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/+89pbe+fVNM48NvFVSKfkFPJ+vMUrGXSQWfOycuUmn7sSIatd7Lc447kaDpisEBlL+jEEhdw7hULn8nFeh/UyJ1eyvjQMtcBcFFLSNpflBwmGdbka2xr92Om6StNnxtjrdY5riw+/dFQglNHmEARC76MRsheugm/Irt6L1trajlXObJmjvkKhogEEXzNies1JnGABgqr9S+xT4oabQ1igL38eCobqFi85v21S7CAklCCSx5j2SdaaXXXn/GYDFJVXdrtmNiv4n4L8KZdYl26mSK1uhiGo8hIJUnolyVopDzvtZLCx4kiU0RsYHhYwmLEr3DzJfvlkW2tV+dpnWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZWgfAH/mQf7FpTQCuLrusXK9yG8z4VnlzGzWuTPqms=;
 b=C86dmk+mcViFMaLO3HLfg4VTOuqc+jinN45v9wWBlFxJkC03XDP5pdH2yaBoMvwLc3jbEoYOql3ZWY4GLbCA88IJM4jSW9kOQxioFUs1cDzHuDfVRIigGZ4HGHG26fXCeXh6cHdh31A6xjE//SugdJYXxx1uLt7Gnf/O5Gnv5K26gSW9O98J/jPQmSN5VJ65u8ZcogXAbxYiLeAEekJmFjDja90UNgj8OxFuZRQqFtZHRJOOXDTOkidVlRzjtdPI9v9OfWlPSPkufvBDvvThjlAYEPmMQ8E980aXPOf6XaOrdxDtQOgKgI25BsotobaI253drXtSQ+hT2ig1rs87Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZWgfAH/mQf7FpTQCuLrusXK9yG8z4VnlzGzWuTPqms=;
 b=co0hNVNv9Xvs5ALZBGECqtG3cBNHL/QdSKz3QeVWDIEiGzYK1gwWsmt97lvciA9k+0ttxffD+6CdImLzk6AYcvnZBc3LW9EnnVSy4wB1mfjZVkx4Iqtt7zy8IIJb5dCvEVmUR5DRym2xb393q7dVgsHNnQp0zuClnpIgvFriFvcnAU7Y1HXYuEOLAgrMDxWpWxPkMKCZFmllCyCdf/cM7mAvxln3Fn094J53IaLIt7ASGbdLOvSTV024zavfQACFY9pATLC8vsplBA7gAvbZr/MPaodycxsCiqtF00mL4tqTrxjNqyWEdjUxnFPsZf+2FasHyyuy9Ey5dVql1IcxiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 05:25:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 05:25:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 14:25:08 +0900
Message-Id: <DMEIQ7CIQSGP.2HW2RV3W54MTV@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/7] rust: alloc: add ArrayVec
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-2-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-2-e8b92b91aa5b@nvidia.com>
X-ClientProxiedBy: TY4P301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da351c1-08b5-4924-f93c-08df332181ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|10070799003|261022105027099003|261021121427099003|261021135927099003|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: p+DZF430RVmnsPtnjnQ1dq3h2yhInwiW/+PEdT2hbGSzM9Ssj2MoDX7weAHMKNOdWAc9G/VGj0mBydZVCWzNQy0RjIu1LuQ56UEi4hQUJXF2z5l5zUIQiiFHDIDPIISMjvEtS2PxUtLA3RJ+eQFNPPdlCgLARnOGKa9cdkYmEEgOdttpoNpT7QGPR7ecuXX7PWQMlzoF5XrvcBn997a3fz/r36NTr2xcY4Y9M4kJNdUsvlz88eqnr6ZKICSLTQwslnq0/przBU+SW8UatKxtDHfShCRSNMAgsGAEx9BSPEgj7J47zYuTF6Ji2sjCC+cZFwMkEt6XojDQiNaGODT8A6XfFfB8bKbQAxDrkeQtvRgwk1S1+wOWpNBxAWhYPEw4I8aMqG7dUWBnVgww+Ig49wkpMHZcgih8uf0VC7EY2qYAP+ulYd3zoj72EwxsphOvTBSVcq3dU08wn+tQUcZKU+jUrXbmfYFbwjKyFM3hJsqIFiDOPhJuCTEKbkfNbIJ6jCIAaJgs+nYLah0CWWqQRshkg/1HlPlr/pjIwAp5INrBdWx1xvwbbm9zkH3qZeTJbfjMFUgD1y7bfSQfpobJBZaDNufQliZILXn+Zc60aQJio7G/OWVVnXTLr9JvoRomqoQVz8vcoNiEfOEZVMK8E5KRRnThnlALyDdZe7sW4XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10070799003)(261022105027099003)(261021121427099003)(261021135927099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1d3bFVma1JDaW03aFozK1V4QjZWYVBORXl6TDdjZVdFQnBmZTNVNHYxUGdz?=
 =?utf-8?B?NkRhdHozS1VJZ3ZxckVWSFFDWkVrTzNFMUk2SE8wN1hySnQveExucVZJUEFW?=
 =?utf-8?B?SnYrd1hRc3d3cUtVYUREZjFIYTBtWUZJZVBDRDhYZEd4ckc5c2pEYmJmcHIr?=
 =?utf-8?B?czM3L0VKYmJqNjI1dGhIZnJqYi9DRXBIeStxZG81Vk83bFF3VUZXSmM4Q2lR?=
 =?utf-8?B?VldzY3hUY3dKdWRZYk8zcGo4L0ZHUGtpbDJRSnNEaCtFaUtITlVta09kQk9N?=
 =?utf-8?B?Z2VxeVN4Szc3NlBmVGhMeWZTdE5obGkrSG1nQ1YwVDhXcmIvZGNtaVF4ZkFX?=
 =?utf-8?B?SUlnc3JWS3VPZFl3QlFBeHUyWWJUT2g5ak1aWG9wbXVMZysrYWZrL3h4NG9K?=
 =?utf-8?B?T2grOUNUSzN3VWZvc2hScFhJYnp3emN4VTJNbGxCVEk2dE5ZUGp0N3AxRTZX?=
 =?utf-8?B?YmRHdnoxY1hxdGZsZVEvWDhaZDc3ME55NzRXeUZxYUVBcXpLaS9CanVWQjZY?=
 =?utf-8?B?VnZYemw0Zi96TmVMT2I3R2tSTDR4TGpMYUdNZ1JQajlGTVd2cW5KcTk1KzI2?=
 =?utf-8?B?VjZoYm00QTJNQVpTOHFXVDZ2ellDK1FFUlc3bzJaK2JuYXhmOW5CL3JSRXky?=
 =?utf-8?B?a2gxOEVRYitJZzVreUhnbE9jNzU4KzNoTW5zdjQ2NHlqQUljckcrZkR6c2Mw?=
 =?utf-8?B?R0pBaGlyWWVtYytyUWhxQUNxU0p5VDg2Yk9yZmZoS09iR0lMQVRFNUVMYzFv?=
 =?utf-8?B?TUNGQ0JSdWRXcDRtc1dNb1BIdnFSUzYxalhta084Qmh1cUR0WXJQQ1p5QXkz?=
 =?utf-8?B?bUdLK01ReW5yUHZRaUducUVkM09EZ0psNXhDa3lUU3hERitjOHROd2RRY3Ir?=
 =?utf-8?B?MFFndzcxZDFTVDFnd2VYK0I3LzVaSUlWUGwxRVlZaEU3YmpZU1FCSkd0UUI4?=
 =?utf-8?B?NmxadStqdjdBenhRZmJ0VTk0TjZDd1dXWEJUNDJxam9Ob1R1ZWFoT1V5dzR6?=
 =?utf-8?B?aVgyS1F1akdaQXFWMTRRMzJUcTBQaDc2ZTc3M1VIdy92MmhBM0NGdmM3NWhJ?=
 =?utf-8?B?RmVxcU16UXdHQjA1enNRelV4ZGRYREkrUCtTNzJlTkU5cTg1dy91NmZtcjVJ?=
 =?utf-8?B?NVptdWROQ2d6OE01WDRKbTk4eForZ0QvVm41ZTYvQXU4dTBBZlJsNkNDVko5?=
 =?utf-8?B?bGpzKzFLV0Y4TDk4Q0J6SW5CTHoxSzUvUEdoWFVKeWpGa3BEcHk2cXRzd2t0?=
 =?utf-8?B?RFBWWDBzU0NDeGYvcmFUZ1pJaDluRGxkOWxrWndiVXEzOEUwY3ZORE1WMnFL?=
 =?utf-8?B?VDRnY3RJTEVGVUVyY21GQWlSaS9PNTJHdVN2WFVVam9OaGNLY1JJNXF1WVZj?=
 =?utf-8?B?UkVuWWpYOEN1VGtQYVRabkIyMVQxcjVXNlZLK1VpWGpXTGJFSXZIZlZUTktY?=
 =?utf-8?B?M0RGWlBmR0RtVzMwRW54VGlBQmx4dXRwMlMxSmRGWmNUZzlCREVKQzVVZUxJ?=
 =?utf-8?B?Y3pqSmI0eVQ2eEMzYlkvVHhzY245SHpta1l0Z1lPdi9jbEw5Vm4yNU14cXFY?=
 =?utf-8?B?NFN3SVZqSjF5RlcvazFxb2FISjN2dDlYamJjVXI5L1JFVTBtY1VoSy9Hbm5q?=
 =?utf-8?B?OHc0cUxHVkpPMmhPeDFoOUxFSUcxTDIySGNKTVFlWlFwbVVxK3Z2UGF2NDh2?=
 =?utf-8?B?N2RxY04wblRpNEsrQVV4OC9nTlZnYWhYOExLN1Awbk5uekVpL0pTVnNWdEpC?=
 =?utf-8?B?OXJlUnZSK3laOU9aa3p4d1BCN0dJbm14OWFLaG0vM0sxTXBRQU1JcjYzK01n?=
 =?utf-8?B?R25QUnhpSHRFeStiQlhnUXhYcWJtRFJsc0ZVekVOcHZOZUI0ZUUzME9DOEt3?=
 =?utf-8?B?VVlTN2lva0xTZDdtYnVXLzZnZjVneUhQSjMvbkRCWGtTczJSdFVEb001UFNu?=
 =?utf-8?B?ZkR6dS9DNXU0TTBxc3NzWEpDYUJST1FYSFJBa0FJblF2NTkxOXc5Tlk5K01n?=
 =?utf-8?B?TDkxcHg5RHRrTDVtL0l2K2dvcVcwQUF3ai9reTJQN1dROUluMzhrWGJWQi8x?=
 =?utf-8?B?Yjc3T3A3b0VsOUNCbzlsMEdmYnRpMEhoYnBGb1M5SUZ1WFRaOUZwcWhsTnpn?=
 =?utf-8?B?YkpJcFlLTUNUSTlBejhvNW82S2ZrSk45anQyVWk2SzlpS3pQSTlqZFhVdW0z?=
 =?utf-8?B?NFVhVDN2MWZycXRLNlNCb2lqMjlMbnloRnBKSjJMdTM0QlRMT1VQNThlRHdu?=
 =?utf-8?B?UkdzRVNSaUJrVkNKZDAyUEdsQzhDd1hXMHJIVkhjWUsyMzMyanJQckpVTEs5?=
 =?utf-8?B?WkYvT1Q4SFl2QmZTN2VZLzBXTzZIcGk0TWx0WVZLMlpRdzNveFFGQ0JsNGt0?=
 =?utf-8?Q?RncPF82b339JPNXsd8awuQ+tLSCMQmJLI4Bu49nBODlUI?=
X-MS-Exchange-AntiSpam-MessageData-1: pVw4iLL2oiBVrQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da351c1-08b5-4924-f93c-08df332181ac
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 05:25:11.3727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UH2z3SVAvAwfzviZ9Dey5854IoB77FF5rYpgiRhKHc9Gm/h6n6FePfpXxgNzR3KmQkZ8HxgwdZRNpYcdwIPRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 16, 2026 at 10:53 AM JST, Eliot Courtney wrote:
<...>
> +/// A fixed capacity vector that holds at most `N` elements.
> +///
> +/// # Invariants
> +///
> +/// - `len` is at most `N`.
> +/// - The first `len` elements of `data` are initialized.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::alloc::ArrayVec;
> +///
> +/// let mut v =3D ArrayVec::<u8, 4>::new();
> +/// v.extend_from_slice(b"abc")?;
> +/// assert_eq!(*v, *b"abc");
> +///
> +/// assert!(v.extend_from_slice(b"ab").is_err());
> +///
> +/// v.push(4u8)?;
> +/// assert_eq!(*v, *b"abc\x04");
> +/// assert!(v.push(5u8).is_err());
> +///
> +/// v.clear();
> +/// assert!(v.is_empty());
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[derive(Zeroable)]

Do we need to derive `Zeroable` here? AFAICT we have no user and this
forces `T` to implement `Zeroable` as well. Worse, the derived
implementaiton does not check against `MAX_STACK_SIZE` before returning
the built value on the stack.

We also have `new` and `Default` that do basically the same thing,
without the constraint on `T`.

On a related note, it would be nice to have a method to initialize an
empty ArrayVec in-place. Currently we have two instances of
`ArrayVec::init_with::<Infallible>(|_| Ok(()))` in this series, which
imho justifies having a dedicated `init_empty` method for that.

> +pub struct ArrayVec<T, const N: usize> {
> +    data: [MaybeUninit<T>; N],
> +    len: usize,
> +}
> +
> +/// The maximum size in bytes of an [`ArrayVec`] returned by value from =
[`ArrayVec::new`].
> +const MAX_STACK_SIZE: usize =3D 512;
> +
> +impl<T, const N: usize> ArrayVec<T, N> {
> +    /// Creates an empty [`ArrayVec`].
> +    #[inline]
> +    pub const fn new() -> Self {
> +        const_assert!(
> +            size_of::<Self>() <=3D MAX_STACK_SIZE,
> +            "use `init_with` instead of constructing a large ArrayVec on=
 the stack"
> +        );
> +
> +        // INVARIANT: An empty ArrayVec trivially has all its elements i=
nitialized.
> +        Self {
> +            data: [const { MaybeUninit::uninit() }; N],
> +            len: 0,
> +        }
> +    }
> +
> +    /// Creates an initializer for an [`ArrayVec`] populated by `f`.
> +    ///
> +    /// `f` gets an empty [`ArrayVec`] and can fill it in place.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::ArrayVec;
> +    ///
> +    /// let v =3D KBox::init(
> +    ///     ArrayVec::<u8, 4096>::init_with(|v| v.extend_from_slice(b"ab=
c")),
> +    ///     GFP_KERNEL,
> +    /// )?;
> +    /// assert_eq!(**v, *b"abc");
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn init_with<E>(f: impl FnOnce(&mut Self) -> Result<(), E>) -> i=
mpl Init<Self, E> {
> +        let init_empty =3D |slot: *mut Self| {
> +            // SAFETY: By the initializer contract `slot` is valid for w=
rites. Once `len` is zero
> +            // the slot holds a valid empty ArrayVec, since `data` requi=
res no initialization.
> +            // INVARIANT: An empty ArrayVec trivially has all its elemen=
ts initialized.
> +            unsafe { (&raw mut (*slot).len).write(0) };
> +            Ok(())
> +        };
> +
> +        // SAFETY: `init_empty` fully initializes the slot and never fai=
ls.
> +        unsafe { init_from_closure(init_empty) }.chain(f)
> +    }
> +
> +    /// Appends an element to the back of the [`ArrayVec`].
> +    ///
> +    /// Fails when the [`ArrayVec`] is full, handing the element back in=
 [`PushError`].
> +    #[inline]
> +    pub fn push(&mut self, v: T) -> Result<(), PushError<T>> {
> +        self.try_push_init(v)
> +            .map_err(|TryPushInitError::Full(v)| PushError(v))

nit: could also be `self.push_init(v)`.

Pretty minor stuff, so as long as my first comment is somehow addressed:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
