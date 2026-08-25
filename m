Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0AC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E69F10EA5D;
	Tue, 25 Aug 2026 13:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="pIkwRcdv";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022107.outbound.protection.outlook.com [52.101.96.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E72B10EA5B;
 Tue, 25 Aug 2026 13:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeMVfJP6OqZF7ahaRRIHu2TZYXQWEHopKImxKdQC12VoE3xpOD08KLB7qRixWv9hZdv2GMzia3v0VG7wqzL0378zHcTDEhN5QRC11loD5Aowy0P96LGkA6xK+P/bpNCJdkDSSJaOPXj02cJjpJAcVlZUAF2wtPsVw6O4R4lPOAw2e0tvrcx0VFHPd7nib9aY+9P4kTXeR5yQufg87GIZxT8GGpOwGMuMWKigAhYMKtYUFl4unbAl255SmA25S7ZlV314kP9CK3drmu/K9Sy1zuE9naPY/x2QbdkscvYtgbicbWb3QfUrrSw7tBbPToxZxdqVbRBXZKEO8Knvz+DgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aOHmqvt3HhXbYAytzUPI0BTFjMnVX7Ixc2lBhvuSC8=;
 b=n6AqM6Da6WtGP9v4dj5H+j+Oo8carVgx0sSSa6RzFMKKcdzz1/luuoEWJdIK630jbb4FQEw6gyrwupwoG6O3/Qq4Hqyfwa85j6+hEJPZb1FyDGTSaEggg+lqV1LE1Z7gH5aYqp9hZLo3t0qRCOrk2csLtQDnCqT+rtDUlb6YaIqhw1OTq62qwjkesYLAG81AZvKhxjlTeHp8NM3zhrJmx6+r/34zCuiEi2KWNm7+1ZcT3QuBDMnnI4glSvXrj+YQ6bmBC4nMzMy+s4K5QMPrG7F4DMyppZOJIvqQOGHXzTpQhxtpPEJWEjxZGxuMEQG+FSYVM3czYUpgdAD9gjqQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aOHmqvt3HhXbYAytzUPI0BTFjMnVX7Ixc2lBhvuSC8=;
 b=pIkwRcdvI924GYXJtBALBVC2JT675tNJ+D1kButjhLjEI4ts1SD0I3dfGzSztKCLxs5uHXWeOS/Z3ZTq+tVdetce60qz13NAeGKk5hI6b3C8DmJimpee1pQancZvg1SQSyl/ulSR9kmEgT1Me+wW4ttqXkeMd3kVR4OwFssaiK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB7280.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:33:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:33:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 14:33:42 +0100
Message-Id: <DKY2AIA7ELLI.1REFFZGXL78Q5@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 6/6] rust: hrtimer: Make HrTimer repr(transparent)
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Jani Nikula" <jani.nikula@linux.intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Lyude
 Paul" <lyude@redhat.com>, "John Stultz" <jstultz@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-6-90411c6217c7@kernel.org>
In-Reply-To: <20260825-expires-v2-v1-6-90411c6217c7@kernel.org>
X-ClientProxiedBy: LO4P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: dd508568-6bcd-4704-1ceb-08df02ad7ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|7416014|23010399003|18002099003|22082099003|56012099006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: qcPKO0q0uvzwuF5rbd+L61voojAIlFrqnxD/t5DDUECbkeho4s4jRGiC+DaJlTlDjX+/xqb5hoshlIWNfvhDatlRszfay4Lpcfs4p0xOqnW6/ZJcC2po26B3MNsGCLVJLMevtMtnQSGc9+z3sVileDuZQ3SWe30kRRdSPpjW0Kw04/oOALJU/aB7iOHf+dpM2033l10Xy2o1uyqCUZ42tCTIR9ZeR3cGnN9FQF0Kl7S+2ZX/JT02TezL+ytFNUGOHKnz1XNP8WW2Kc9bF0ZDBeVSBidhDQZaEJPxLvJU4Xgv141UUcT3oZLLH8Vs9coUe31ZIhRkaH7BWI6vJjOcgg8G1Z+CyJl/QWnL4Ek+NbfW7Nm82yq4UgZJkZOtb7JTcnjOer49378KllfiFMOOiHsmiygfa8LHLQQ/YsIZsH6sDoMT4FNzGfKns+/Qa19/n7iVHTlBjxj0ohr2pRcGKuT4CTXtI+2P/Ed/t7f7yB4XDIu2kZJrKImPc1BKclqKGrNFBciV3IZh6Z/270w+AcBh5TxuTp73ezEbr0wcO+0cInCKfaDYpiS8IMunx664KBfeL5r/JU+RBLlT5kOcmeTY/a1hFu9RyD6PxYiVqtmtwsGbSnoIfQlBzW+h/NztSg3UHm7tdMl2Wyq0iT1DbOGw75ngz3KBaYQ4jpXeKP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NHOS80aEtHbVZ6Z1lUbDZOaThhTjZXRThqV0NxWVppNkRnTDVpVW1OL3hM?=
 =?utf-8?B?TzA5Q2JtRFFnMVFtWm1lKzhwZ1p3bXJhUWxqM0cwSzVSbXMzeXVzNG54WnMr?=
 =?utf-8?B?ZXJPMC9zVVVleGlGZjliSTh3VElCQlFGSE92V2tFZDJ1cG9vM3FWTkpPUVZx?=
 =?utf-8?B?djZQRWlqU3Q3V3VGYm1Hd3JSL0V2VUdxZEcwc00ySGhRbkhSc0IxSnp4Z2dn?=
 =?utf-8?B?ZFFpQ2RSbGRUSmVUSjhjVjdGMkZVMTZ3dUVVdWZUYUREb0xWemZ6RW9jMXln?=
 =?utf-8?B?Y0E1M3VHRFp2RnpUY0sxSHpkYXB1TVF6WEwvcEFOdmo2aUEwVWk1Y1N6dWZW?=
 =?utf-8?B?R2JyeXkwaG9yd3hkMjRCMDYvYU5PeXRFWDBGc2ZCK3IybjM2b1FtME5yRWN5?=
 =?utf-8?B?SjlpSVNtSG0vcHBWZGFNczBtZ1FpVmN1VEJ3cGtQdmpoRllyL3E1YnRtNWNt?=
 =?utf-8?B?Tll3Zm1ITlZZRCtVSklKeE9ZTlc2UEdXYXNSL3U0WHdSZEhIY3Q1UTVvSTJn?=
 =?utf-8?B?NktSV3NLS29qWGtYNDYyQUg5MURTQ2tFSjIwbSsrRG9ueCtac2Q0QjJTdkZL?=
 =?utf-8?B?MGpkcW5ZVUFKRGNTUFlBOG52UC9XMXplRnl0b1pzeUwvV09JdDRlUHJiNTg3?=
 =?utf-8?B?SWNUOWdIRHQyaDNXNDRFeG1IbGVuMldMN1I1YUNNZUZsY3FYMVhXcUdrZ0NS?=
 =?utf-8?B?NUlSTjVZMGxaRTdkYmY2cnk1c0RWZGhSMytLZ21DM0IyNkJHRXQrSUx2SEhT?=
 =?utf-8?B?eFVzdnZoOGppWUQ0d3dIVjZTb3dvd1A4MTRHYm9PcCthWVNoaUNtLzhUejRP?=
 =?utf-8?B?SzNxb3NzWSsxZFBTeGQwMnREc3I5bzBHclh2WEFkeWZ5Wm9tbjkrZUovaXlJ?=
 =?utf-8?B?N1kwNXZrL3N0bFVnSFp1RWcxMThFaHNvRGhUa0oxTmZVMHF6V1k3NS9ZMUhK?=
 =?utf-8?B?MXJxYUxUdzVWaDVZYmVXeWxXVDhzemUra3VlWGpjRmFISnAwVm1WUGxNQXh6?=
 =?utf-8?B?R2VUdk5LTi9OS3ZLZ05UOWdJb3BXYzJIVTU4dTBRQVYyTHB1OU90L25hUGd1?=
 =?utf-8?B?RnVOZ2IvSTc2UHgrTlAxV2htYUdhb25zcjF0dHp5bEZieUJMYXVSdGM4ODFR?=
 =?utf-8?B?elpkbWl0cFMzZTZya3lUTmo0M3lBeGlzU01OalZkaWhFNmI1b3RMSDZxUEMy?=
 =?utf-8?B?dWVqY1RvaG8rNHpHdXNnbWthVmhXRWwyUkVrQVhBRzVucDkzUzBlTDNlMkJK?=
 =?utf-8?B?S0NaallnOHpLWURyN3dJZGE1bUlPMDNxcngrN2Zwd2Z6dnRDSVZDMk1DTlVs?=
 =?utf-8?B?NlJKUnZiOHplektmcmdkQ0hyVGpXSlVucDJUNmdmTzVWV2ViTUpVaVRYN0lK?=
 =?utf-8?B?V28xU2VlVlE2dGxoSjNQVTViZ01vMU50VUtncHpnWE1zN1BKcld2c3V4UDFr?=
 =?utf-8?B?NFhKbTFMdVlDb0UwV251Q1NWOXJJSFNGMGJCSzBzQUpnTitXWjVGQkUxMXVF?=
 =?utf-8?B?SGxIK244c0xiVllvWE4zWVJ1T2JjK281MTZVa0lORURWL0ZoTjhuUnNXaGpz?=
 =?utf-8?B?RWhPR2ZVT1E5WFRCQ0E3MGJnMy9neG8rS3ZNdFFqZEViSVJGWTdUVHlpanlY?=
 =?utf-8?B?b2RKMUszclF6UklGSkFjUmFnZHZpTlo0Rkd5MjRLNko5TzZMLzVSaEFQemNa?=
 =?utf-8?B?aENIaEJLampVNHF5U1ptNXptcFNBZWJKbklTNkJ6dDIyRlE4WkI0TTR3RlVM?=
 =?utf-8?B?UTkvVE04aWlQSzBlVk5RalhOenRlNEY1d1VjZkxEWkVtdi9mN3Z6SzdGeVBF?=
 =?utf-8?B?WldWYk9DUUZMZnNtR1VZNlhqR3ZwUHFXc0pITk9SNWVKdmNpZGxXdWhpamcw?=
 =?utf-8?B?WXZWdFh5dHUxK3pzbDk2UzVWN2pqNzdJNjR3YjVya3V5c3ZSM1h5T0FhOU44?=
 =?utf-8?B?NkZHYlBISzIrM3dOZ2Q2VC9sNUVCVnkzbGlNUStsMmFaVHpyRm9FWE0yclh6?=
 =?utf-8?B?MGtaY2pBRi9GakFPaW9ZOVp0MkgxN1pkRGNnWTB2VUw5SFdNekpVSFRXMGRj?=
 =?utf-8?B?amx5UnVyL1YreGhRdmlNTXRFM1hlb05jWDlab1g5Y2JVZEFMSjFpM3JGMHFG?=
 =?utf-8?B?N0h6VGY0b0lBTEs5RHQzRW1WS1Z4dWwzRkpBMEN5NDdTVWdtbEZPb0tob0NZ?=
 =?utf-8?B?RGZNcWtRVXNDRmoreFJSbXgyOFYxZUVjdm8wRXZYWUtzbFVBbmE5amwweTRy?=
 =?utf-8?B?VnpMUXpSNUFMTnNyOVZ4MmJ5b1VDQXE5NmZyeStlUis3emNJRG5rRVA3ZEsz?=
 =?utf-8?B?K2JuZEkrd0w4MUU1eVRjUTIwQytYZWQ0NXUwRXRBdE8yYjVrc2ZjQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dd508568-6bcd-4704-1ceb-08df02ad7ba8
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:33:43.7811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kuQnonWFd5qHaB4psT3k05F4vu7ie8tCrYTx74z6g7C9ZFhLJj2MaO9r9ro1wqH0hHcadgjBa2RyBuEUDDNCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7280
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

On Tue Aug 25, 2026 at 1:16 PM BST, Andreas Hindborg wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> HrTimerCallbackContext acquires a &HrTimer<T> from a
> NonNull<HrTimer<T>> while a &mut HrTimer<T> can exist at the same
> time. This is sound only because HrTimer's sole field is
> Opaque<bindings::hrtimer>, which puts every byte behind an UnsafeCell.
> Adding a field to HrTimer that is not Opaque would make acquiring that
> shared reference unsound.

HrTimerCallbackContext is removed in patch 4, though?

Still worh preferring `#[repr(transparent)]` over `#[repr(C)]`, but the
motivation should be reworded and the comment on `HrTimer` should be remove=
d.

Best,
Gary

>
> Make HrTimer repr(transparent), which prevents multiple fields, so that
> such a refactor fails to compile instead of silently introducing
> unsoundness. This does not guarantee the remaining field stays behind
> Opaque, but it rules out the likely way of getting there.
>
> repr(transparent) cannot be combined with repr(C), so drop the latter.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Link: https://msgid.link/20260813134834.1562995-5-tomo@flapping.org
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs         | 6 +++++-
>  rust/kernel/time/hrtimer/arc.rs     | 2 +-
>  rust/kernel/time/hrtimer/pin.rs     | 2 +-
>  rust/kernel/time/hrtimer/pin_mut.rs | 2 +-
>  rust/kernel/time/hrtimer/tbox.rs    | 2 +-
>  5 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 2a9abc9f5d8c..ab7c568b8855 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -427,8 +427,12 @@
>  /// # Invariants
>  ///
>  /// * `self.timer` is initialized by `bindings::hrtimer_setup_ext`.
> +// `repr(transparent)` is not merely about layout. `HrTimerCallbackConte=
xt` acquires a
> +// `&HrTimer<T>` while a `&mut HrTimer<T>` may exist, which is sound onl=
y because every byte of
> +// this type sits inside `Opaque`. Being transparent rejects a second fi=
eld at compile time,
> +// but it does not enforce that the remaining field stays `Opaque`.
>  #[pin_data]
> -#[repr(C)]
> +#[repr(transparent)]
>  pub struct HrTimer<T> {
>      #[pin]
>      timer: Opaque<bindings::hrtimer>,

