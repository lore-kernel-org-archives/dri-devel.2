Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C241099B30
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 20:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A50910E1F6;
	Fri, 20 Mar 2026 20:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="EXF9gdyP";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020134.outbound.protection.outlook.com [52.101.195.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D9110E1F6;
 Fri, 20 Mar 2026 20:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgvbCNwAus+YnJ56yupDRJ3vt+6KgWFXiiRU28r/5vp3ath9Eb88o/Q5ebh4T3j8UNs5i8GpYsSkO9SSx0Kzcv1aRnapnhkvmIjjw2HVE9MS3F5teFzXLdtpVKx6QQiu5l5sJbiNaMlOnphWfV66r1zziBgdjs35zlis4TwOE+I6h2MCMct8c4FZcyNsV4UQ10p00h6aSbPATh4jJegSTT6LZ/M+KA6c+9UZF+4TzvLusNFWaldrBxre1AnIVOHog4LRGx98sNxNnDeWG7VzM29Zew2kETwjU1L98WSpFId0uzAm14KoBRQ1FbvqTr2v0v8pLfFEAy22gWchNHxb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPWOrNh1yPHXW0f4I2x61PqPT/42ZaBP7i5KtgNZy34=;
 b=yYWGg3YQNo9lHTmg7jBhz3zhoaZtzJiPg/xegbnz4Rfj+uMC1dZxcMDNdQqjfkbpCbWSNtB6E5J2AHiJjcBb1M0AM6l7bMicdE9+Y5EtapZNMb9RQ8/tc05M74xu0uht4l1yIeYPGKDkCFSHm4JWhi0e2cU2sBjwHh+1R8c1fdulENcsDEZv/uXWUf+JCuwIjOSifsculrubKy7DD/BiG+Jc8nX5Aekf/1xXQeDHJrsyoAjdl8LKkTPwjKC4LL0jgu3hZ1GTs4HULbGn5GKp48VsP3zZHj8sBoMueGeC3V39qncAH/WKpvmzQwDfWo4Nc2dzXmw/X6SWA7bwNEEI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPWOrNh1yPHXW0f4I2x61PqPT/42ZaBP7i5KtgNZy34=;
 b=EXF9gdyPffiGi2U7WUXkrAycxMr098M7Z2rFNoMdzJxLMx6UGB2+9tHH7hihJcckApm4irm+98bjkYdTOl1lXqdhx6pOs798TRiI44Bnzz0JV1ExYf55+wcZC7z71qJ6GIKHHs4KUnK/kUhoZA/uqf2CSHLsY+6tyJx6EqMgx/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LNXP265MB2555.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:135::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.24; Fri, 20 Mar
 2026 20:55:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 20:55:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 20:55:31 +0000
Message-Id: <DH7WQPG7477S.7X4F1EV760NE@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] rust: dma: introduce dma::CoherentBox for memory
 initialization
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-5-dakr@kernel.org>
In-Reply-To: <20260320194626.36263-5-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LNXP265MB2555:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc84756-fae6-46e5-846a-08de86c30694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|921020|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7L75+CYXlTOQYTv5VGCe9PraPEJtRdE3Oo7Fq6HmrSS2/foT98kLZ0LMrkpVuKnHa2n+bevMSeo8ssRvyJ2BDc5Guijcaxm1172PuikVZgugkZgeiCK/hXCOu5NZBsNU1VNDOl7kGx8MH6ekZyMUo1aEFov4b6DkdxZSzHZqXcjsePnT/xvafJSdc2/mKp5ZqJwLK7LsuO2zsxj0EIdrvez1d1axohkTRVU/c6u87Tobhs68nzsoGrdJ97jhn1m3cckGa03Ix48Og/RrBi+mLx2UjMrhbW4w2OclQ+c/W1aaegZjPgo4joZr99+JtJmVvNoelOPcZavyU0Ijy7OVTJ/NH+RE6Yr0ocThPne2Ymok7hVb6wpDsmtW/WPomLzYBoE43nstmRbehhWutv4dkbGoVvJbyARTHJ1K8Pl36Lg7CzE5BBRrmF8Fxblcvf6zGuwlSorQZYQkTdVi973rmPqJp93qgPJV18d6x1r8P4VX3vjGjLKbczbqEsrZ/UDrTuzHnD4ECXyiXf5xRGTk/Y1VzQoZuk6Gq0BMWLfCALS7C2SKFOyJ0NgxG5vGN2DM4fKA3jxuxfzKzgSvRrt19IhSqXVT6K6kf8SVs+P9XIw8zCyhe5TqNSost6yhlnz2fiURgqmH8Gp2c3ihWzgzz9WTpRxiGZrqVlP5el3kDjUg7Pj2+fOEUjdxdywZdrCke0lLtRUtMTnQteGC/kmJ+ov1gB8B+Imsrbs3X6VjwODiELV7YJ78k8wwZmBUXEknfcm3UefyyvppiXkroSodPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(921020)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NtaEQzTmk1MFY4SDZsZHF1MmtCUlJGOGJ1cXJjUzNWdVA0dTZhNHprTkI0?=
 =?utf-8?B?aHdFdVA1aGsvVnY0cnNEYVZsQ3FKQ3JTaTI3aEp3VUwvQS9BRFBZN0w0bGZ1?=
 =?utf-8?B?eEhCdEdSNkp2SlNKT01PZFJoeXRuWnBENUZKY3dHR1pyUGxRM01HbE9DVnpX?=
 =?utf-8?B?dGVjNDhnWCsyNGRHRkJDMGVPdEgzZ0wyWnlGUHp2N3J4TVpUcmg1dTdhTUsw?=
 =?utf-8?B?Y2MrelN0UjBQNk9BYzM4WG9SUTlzRy9wL1g0R2ZPeklNOXQrYlNHQlVsaGQz?=
 =?utf-8?B?ZkhJQ1BhSlVYcDJQbklwMjdsQnlBZWdSVGU0OGRFcWJLSzgrUk9zR2tZN1Rl?=
 =?utf-8?B?WnhlOFp6bSs2WUtRUTltUmdsalU1Wjg0TnBtcmZGcFJXTFhSdk1WNzAwMFBk?=
 =?utf-8?B?WmxxZU5zdEo3aHk5WTNWK2F5cXUxaVdLaEc1cTVqZU1mZ2YxRDN2dVRYcHYy?=
 =?utf-8?B?ektpSDU1a3BqbmVtLzBEM205c2NtNkZOSGtodFBhUXR3UTA0dmlrejREU25u?=
 =?utf-8?B?bXp1WTdaSnZHUU85cFJzTlMxWUtwQ3hveE5mVUxCNmhrLzZUVCtBN2gwTkRm?=
 =?utf-8?B?ekF6VWNWYzlQTnYyQTJUaXBKM2tBZnpnSW1wYnpUcDNBR29RR05NUmZoYnlB?=
 =?utf-8?B?aHBjTmlEUWtybkgwKzQxRWtUdGVYWklVR3FQRWxzTVlNS2pBelJXbUNLcm1B?=
 =?utf-8?B?WXM0WG80VFdNOWc1QjdqVXdZZ2Jhc2Y1U1hUdDJ3NTBFR1VpS0V6K1BVVTcz?=
 =?utf-8?B?eHQ3YnBBdUkrbU5nTS9iQkZHbGlrZjBUSWNkcTBNZ1lLV1dMLzQya0gxOGJT?=
 =?utf-8?B?bVB3TlJCNU10S2hXWExqN2luYy9HaEZrR3h2TlI5MDdjaHZIWGVRMFdxb0pn?=
 =?utf-8?B?bG52QlRPVmY1TURPMFJZNDVFQjFsVGNOWWlIazU0WUlPNFlQMVZFUkFoZkR1?=
 =?utf-8?B?bVpLTFVaUEVqbTNqVU16YXhCTkI2UFladEpSUi80clQxbjRsMXlBYnd2R2tI?=
 =?utf-8?B?YmlmcXA1d0YzZDUrbjE5dWMwMnVqVXdyVUR1SURUaXREdWNJN0NxNE1nRUs3?=
 =?utf-8?B?Q1dKd1ZlcVl5Si9GU0haQjVyRGpONVlVN1FWSVNFb2ZRWityYXB3am9aU3Iy?=
 =?utf-8?B?aW14UFJ0NTZMNlZtVUVVbVpkTm13ZkMyeDZUZTZUckNjaWUrMmtVc3p1UEpW?=
 =?utf-8?B?YUF5TE11VVZ3Q2ZNRWpyUjhjVEJCbjBEY0dUU0NhR2xncnFacWVGbjRueWti?=
 =?utf-8?B?eDBaeDMvUmlWM3ZvRklORkZ0Z25PTnZDWE1UdmdybjZEaGpBOGVWckRyaDc5?=
 =?utf-8?B?WXk1UExjYis5VXRzY0NPckxPcGFoc2pqaGVkeWFpMjAyYWozWmRIZXVwdVNw?=
 =?utf-8?B?TDFYbEpjeTZWZVlYZkptT1Q2aFVBTWhnTXhjZDBWQ21sM1ZWWTBIaVU1aXN3?=
 =?utf-8?B?dE5SS3NGOWFaSUorOU9ZQThnODNyNWhTVXJyL0xnVC9YUVliTkZBTDZFZVds?=
 =?utf-8?B?YjRObzVNbEJFWFdEWHpSbkZZczNDZXBXdDl2dnV3UGxXbDc1blY0SjFGVVZO?=
 =?utf-8?B?ZkcxTVJMZVFLdTVoaUFneTlDWXpaWklSdmtOVU52akxySWJ1MlZwRzdKRUx4?=
 =?utf-8?B?eXJuamdiTFJ2aW4raVlhMkxFeWR6Rk9EZ3RyRURsdnc4UmpyUmZLQnUvRVBq?=
 =?utf-8?B?Qno0WXNMVXYxdC9iajFudFdQUEVlWVEyd1RNZk1ENUZJc05rMjExdzhnYzZ4?=
 =?utf-8?B?emMvVzN3M3pEM0FlZURIWUVHb1YyUXFrQVRUU0g5MGZPMnZNU1RxSjZQclVH?=
 =?utf-8?B?cnFlY21COHZpb0RxUjN4TGJqT1hmU1paRlJrL0R0M05US1NnVlRVcDc4T0ZX?=
 =?utf-8?B?OHpXc0Z0N0tsVUJqTnkwbHZBcmREOHFEN2MrcWxaMGsyMEVJWm92azN2ak5J?=
 =?utf-8?B?aHZwSUxKdVg2bStKeEN6WVRTck43ZTlBajBSNGRwVEI4amVad0xXdWp6T2dB?=
 =?utf-8?B?bHYwTEZZdndndTltb2dvQnVZUDdPWXBnK2l3UmxZVFN4SWd1cjMybjVZaGRL?=
 =?utf-8?B?ZmpqVnpPQkhHOGJhSU4xd2t0SDdqVzMweDhpcC9ZUm5zUmI5Z3g4RjN4MFNY?=
 =?utf-8?B?UEZmOVpFbGhCcDFzSDRqMngzTkIwMllYTVdxNU9ucWJZNmJtSlIramluckE4?=
 =?utf-8?B?VWliSEd0UDNPMnZNa2VrWjJUMWViQ0VTNVp0NlBGc3lxTFB3djhqZWEvVmNP?=
 =?utf-8?B?Yy9VSjJLRjJVOGwvY3hLQWk1Q0JwUjdKZTVFNkxZMVYvWmI0L3RudTIwb2tY?=
 =?utf-8?B?OGlyaVg5R3R3aUNKSUNCaHpPbEx3Q1RWcWsybEFsQmhxMVFJWmowdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc84756-fae6-46e5-846a-08de86c30694
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:55:32.1169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXDl2mVL82LGU4+RmZkR+yabF/0PldSUkXK01fZf7l1uxkyMycHSXf2xphfkCp5WYLuFKvsU9QY3AflCWvyEXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP265MB2555
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

On Fri Mar 20, 2026 at 7:45 PM GMT, Danilo Krummrich wrote:
> Currently, dma::Coherent cannot safely provide (mutable) access to its
> underlying memory because the memory might be concurrently accessed by a
> DMA device. This makes it difficult to safely initialize the memory
> before handing it over to the hardware.
>
> Introduce dma::CoherentBox, a type that encapsulates a dma::Coherent
> before its DMA address is exposed to the device. dma::CoherentBox can
> guarantee exclusive access to the inner dma::Coherent and implement
> Deref and DerefMut.
>
> Once the memory is properly initialized, dma::CoherentBox can be
> converted into a regular dma::Coherent.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

See some nits below:

> ---
>  rust/kernel/dma.rs | 154 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 153 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index db645b01bdd0..cefb54f0424a 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -20,7 +20,13 @@
>          FromBytes, //
>      }, //
>  };
> -use core::ptr::NonNull;
> +use core::{
> +    ops::{
> +        Deref,
> +        DerefMut, //
> +    },
> +    ptr::NonNull, //
> +};
> =20
>  /// DMA address type.
>  ///
> @@ -352,6 +358,152 @@ fn from(direction: DataDirection) -> Self {
>      }
>  }
> =20
> +/// CPU-owned DMA allocation that can be converted into a device-shared =
[`Coherent`] object.
> +///
> +/// Unlike [`Coherent`], a [`CoherentBox`] is guaranteed to be fully own=
ed by the CPU -- its DMA
> +/// address is not exposed and it cannot be accessed by a device. This m=
eans it can safely be used
> +/// like a normal boxed allocation (e.g. direct reads, writes, and mutab=
le slices are all safe).
> +///
> +/// A typical use is to allocate a [`CoherentBox`], populate it with nor=
mal CPU access, and then
> +/// convert it into a [`Coherent`] object to share it with the device.
> +///
> +/// # Examples
> +///
> +/// `CoherentBox<T>`:
> +///
> +/// ```
> +/// # use kernel::device::{
> +/// #     Bound,
> +/// #     Device,
> +/// # };
> +/// use kernel::dma::{attrs::*,
> +///     Coherent,
> +///     CoherentBox,
> +/// };
> +///
> +/// # fn test(dev: &Device<Bound>) -> Result {
> +/// let mut dmem: CoherentBox<u64> =3D CoherentBox::zeroed(dev, GFP_KERN=
EL)?;
> +/// *dmem =3D 42;
> +/// let dmem: Coherent<u64> =3D dmem.into();
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +///
> +/// `CoherentBox<[T]>`:
> +///
> +///
> +/// ```
> +/// # use kernel::device::{
> +/// #     Bound,
> +/// #     Device,
> +/// # };
> +/// use kernel::dma::{attrs::*,
> +///     Coherent,
> +///     CoherentBox,
> +/// };
> +///
> +/// # fn test(dev: &Device<Bound>) -> Result {
> +/// let mut dmem: CoherentBox<[u64]> =3D CoherentBox::zeroed_slice(dev, =
4, GFP_KERNEL)?;
> +/// dmem.fill(42);
> +/// let dmem: Coherent<[u64]> =3D dmem.into();
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +pub struct CoherentBox<T: AsBytes + FromBytes + KnownSize + ?Sized>(Cohe=
rent<T>);

Similar to the changes I've made to `Coherent`, this can also just have
`KnownSize + ?Sized` bound on the struct, and only have those bounds on the
constructor.

This saves a quite bit of duplication where everything needs to say `T: AsB=
ytes
+ FromBytes`.

Should be something fix-up-able on apply, or something left for future clea=
nup.

> +
> +impl<T: AsBytes + FromBytes> CoherentBox<[T]> {

this and ...

> +    /// [`CoherentBox`] variant of [`Coherent::zeroed_slice_with_attrs`]=
.
> +    #[inline]
> +    pub fn zeroed_slice_with_attrs(
> +        dev: &device::Device<Bound>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attrs,
> +    ) -> Result<Self> {
> +        Coherent::zeroed_slice_with_attrs(dev, count, gfp_flags, dma_att=
rs).map(Self)
> +    }
> +
> +    /// Same as [CoherentBox::zeroed_slice_with_attrs], but with `dma::A=
ttrs(0)`.
> +    #[inline]
> +    pub fn zeroed_slice(
> +        dev: &device::Device<Bound>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +    ) -> Result<Self> {
> +        Self::zeroed_slice_with_attrs(dev, count, gfp_flags, Attrs(0))
> +    }
> +
> +    /// Initializes the element at `i` using the given initializer.
> +    ///
> +    /// Returns `EINVAL` if `i` is out of bounds.
> +    pub fn init_at<E>(&mut self, i: usize, init: impl Init<T, E>) -> Res=
ult
> +    where
> +        Error: From<E>,
> +    {
> +        if i >=3D self.0.len() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr =3D &raw mut self[i];
> +
> +        // SAFETY:
> +        // - `ptr` is valid, properly aligned, and within this allocatio=
n.
> +        // - `T: AsBytes + FromBytes` guarantees all bit patterns are va=
lid, so partial writes on
> +        //   error cannot leave the element in an invalid state.
> +        // - The DMA address has not been exposed yet, so there is no co=
ncurrent device access.
> +        unsafe { init.__init(ptr)? };
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentBox<T> {

this should be the only two places that need `AsBytes + FromBytes`.

Best,
Gary

> +    /// Same as [`CoherentBox::zeroed_slice_with_attrs`], but for a sing=
le element.
> +    #[inline]
> +    pub fn zeroed_with_attrs(
> +        dev: &device::Device<Bound>,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attrs,
> +    ) -> Result<Self> {
> +        Coherent::zeroed_with_attrs(dev, gfp_flags, dma_attrs).map(Self)
> +    }
> +
> +    /// Same as [`CoherentBox::zeroed_slice`], but for a single element.
> +    #[inline]
> +    pub fn zeroed(dev: &device::Device<Bound>, gfp_flags: kernel::alloc:=
:Flags) -> Result<Self> {
> +        Self::zeroed_with_attrs(dev, gfp_flags, Attrs(0))
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes + KnownSize + ?Sized> Deref for CoherentBox<=
T> {
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY:
> +        // - We have not exposed the DMA address yet, so there can't be =
any concurrent access by a
> +        //   device.
> +        // - We have exclusive access to `self.0`.
> +        unsafe { self.0.as_ref() }
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes + KnownSize + ?Sized> DerefMut for CoherentB=
ox<T> {
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY:
> +        // - We have not exposed the DMA address yet, so there can't be =
any concurrent access by a
> +        //   device.
> +        // - We have exclusive access to `self.0`.
> +        unsafe { self.0.as_mut() }
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes + KnownSize + ?Sized> From<CoherentBox<T>> f=
or Coherent<T> {
> +    #[inline]
> +    fn from(value: CoherentBox<T>) -> Self {
> +        value.0
> +    }
> +}
> +
>  /// An abstraction of the `dma_alloc_coherent` API.
>  ///
>  /// This is an abstraction around the `dma_alloc_coherent` API which is =
used to allocate and map

