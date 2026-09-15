Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C435AC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0073E10FA7F;
	Tue, 15 Sep 2026 07:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AI0FAngo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D449910FA7F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXFUvK3fFKBaGZjPU0FJvTDb/hLjIeE/ugMEkqV8EKR+N0ut1t8aLzdrz5wvb1yZ1AHBoDfqMSYrV+osfdm4ngZZdUT9pUNoxXckEaduwTNMUfrElpKJnBwW8cSUplHavX4lULSYwDzjkWEZuOM3M+2X7DN9lVzanS9+hj+SJVS9vFGaopjHonkkby7oiRjQv5EO88/2kFI0sWXLCqOQNMEl6x+5FjZ+o2cEcRUFa/WsH64N/YWfcngP41zGb7/aIxlBiQuC4YfayXYWS+FpGFeowqlCbKy1AnhPg42EK9EMw54nlM/ICafwrK49OdNKyGgT0WE9HiICRblGtQdRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6D+oIo9QMy5V+zuu/9ytYjExTq8iCyWSn6jpCoV7Vc=;
 b=HPg9rFwFZ/1S5qx1f9I7yseXnEFsUgkca2W6O89va428GsFQQwqbeXy79CbVH17BVJMA8yfyQ59Zu2gUjwYAHegS9Mc99cziD2ZkJZyoaLFVTe/G/wUX9hqEH7saYdygKxrJJYnXdxuYt7WOhlqaHD1dne3hjtlENLEybFRyjGfyoEdopYtVD+1rqybAODN+i0ZcOcVCA/8LsdRlcQnic5+O/CfkIdSOeRHX8QOwljyx21/r6R7BeA7lPe3A7ASKExb9ax+jxWjKCaFdR7mP19U7MkIJ7PGufN2oXpQT0MUXYSsPTRiftFn2/n1blfQDG0AUAEwnwBIr9txr0sCfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6D+oIo9QMy5V+zuu/9ytYjExTq8iCyWSn6jpCoV7Vc=;
 b=AI0FAngohX0TGYLLs7yeF8Ly3y5cNP5tonjTAHRvs0nobXpmD4K8k+xQg0pfoxeoh4yAelKaJ1SpmYwzwDUosJsl9/jZAjI6bd2GuwVcFxO0K3XONkR0lKT8YzIQKfQv0nr3jMAvzjD0qMC2IanD1gHpG7bqILAdi9OoLx5DLMJP1/h1PQ3uajDPIBML1KocQnzCbZe1xazHyJ66qmfkq2OUTHjfUWSMW4ybzi/PPpW/EZl8VZcQSTwfnoxvrkcSIfjnN3mfz+cBQtcBE2e+EsBgB7pAQEFIlFe86qaRWmbvKJJtklc6JXoB0qB53lc4Q3SvpmK/bboGGG2EDvqzBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 07:39:38 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:39:38 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 16:39:34 +0900
Message-Id: <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
In-Reply-To: <20260902-cv-v3-1-0f90659e711d@nvidia.com>
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f76297-b8e6-41c6-afb4-08df12fc7eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|3023799007|10067099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: DM6y3509ByyDDYJjhh+mE47TivDqY9bDa0l+zEPMMrM/kFx0eqYke+ZYkFwOFVmJSYxreLI+hur50NuBQ64BKIDWK7Gp9S4EaayQRgH/Ml5ISALz5C+2MSPpSGFLsgCKadAPbCU4gon2yiDP87pjLqwGK+9o2wLkqkTidPPdz0CS/bE5bnYdSGhrY2pV/f9gw8rpbf4zIQyxIkBlwQ5MbMiGVFET2u3ugyYH46pqHPyLHE1ZAeW8EcHx0SnYKUOQAwn+kjTCEkDkBDBaauOItDxBP/7oy9fUdn3EE3dHVCBO/6iFRJnKk3VLKFG6gHOLdSwcFLedNUaVLNxteAuRsE+mHOdPie9A0qVnLGiZMrem3syHM8SRGedfmpl+lpWGd/y8sFjy1hbSzv0HlpVb6/fWVUWPpeLXV0zYdi40Ek9TAO8xCMZTy/Qx1KZYHSUvQvOq2Btzadb41BBn0Jv8b7gr8NW2bRBnaHNiOuI+lMY661MkRFx4X7yjr7GizGK0zKoDQX84m+n4EONUG30B6FdSAcIrVsFRUQNWlW2tSLvpNhyOXXdvFxSRdIseo7OEF9Gb4g1SVM5nqU6ePonhbFcF9FjepV5103BaojEabqqITT7UlButbbV0d12SU4m5i0fTIGxHJIR1wzdo4W9LKnMvVSkOq50ePZeGDYar0Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlKL24rVU96cGR6UExjYzFIT1hqcUd0WlRnQ00wdVltS2EybEpKNDUvSldM?=
 =?utf-8?B?UWF0R3dpd3JhdHBVNnJRVzdqVHB0TEpaRkY3b1I1VkpEYzdOaXRvS3htWGlL?=
 =?utf-8?B?QWlQb1N5djhBZjQ4M1JGYUtFQk9KbTg1dzJMaWFFNjZOV01IdW03YzF5RnZ0?=
 =?utf-8?B?cWo2eFpwbXZ6YytpN09XLzRmWW1Kb05BMStXVzRQYlFqdGhWVlNUdVBBNTAw?=
 =?utf-8?B?bnBNa1l2c0NNdDRyQmhyU1dReHFvaTU4VVlaV3BlNXpwNVVmMVpUc1hJMWNB?=
 =?utf-8?B?TEt4U2dMdDJkYWIrZkQyUHp0b1BaOHpjU1ZjWEFxUWRybmpiV1pnUldQK2Ey?=
 =?utf-8?B?c044WFg2NWdtVENYRnYrQTV0eWloV1VpSFpXNHNJOUtKV3lKQTVMUHdVS1N0?=
 =?utf-8?B?cjgxZ09uSEg5bUltUkFvenFlSVVSaTBrWFRMM0puNDlYd1RLL2ZCMkx5NG1s?=
 =?utf-8?B?ZWhNTVRWdTAyK0FJMk9hQVBHUlF4V0RLQkJwWkdPRmlMclBOekFjb0tCTnlw?=
 =?utf-8?B?dWMrZVlEendHQk9NSktBV3FjamtMa0NHTE94TnlNRFlQNjd1QUVHMXo0Tys2?=
 =?utf-8?B?ZHJOajFMenlGSjdKQjNCdHQ1OHVpQW5uN0plQWtXQnVDNWExNVMrQzV4bFJJ?=
 =?utf-8?B?aXU3NU11WWJqcG92VDIxTDdNUS81TFBZbVY4RExzY25jbDFUbU9hR09IaUFx?=
 =?utf-8?B?QmxPRFZtUkhRdlJJd3RablJCUTRlLzlBT1NLTkE3aUVmc05tRDArelhCb3RG?=
 =?utf-8?B?RFNxeUdvd2paUjVNaHB5c01pQlpmdTZiVUIvUVd5RzNXYUVRd3NCMjE5elp2?=
 =?utf-8?B?RGpSNlo0TjhaYUIzZmhaWGFpRkNEVERhNnJoRE1jYXFqdXVCRDNEWFdRcGlP?=
 =?utf-8?B?Wk5oMUJrTi9QaHFFQ1FUSzZraDZ2SVJkdDhLTkdsTEJJRGsxTGdvR3NYdmRC?=
 =?utf-8?B?S2FWQWM1VDdreGNlbm1Cc0s4Q2dZSC9zU3B6S0lyaER5TEVxYjh6dEZRcVJk?=
 =?utf-8?B?TGR6eTEyQTNOcng5UWY4QVNUUkRsbFhRL1N3RDU5My9BdjhFRktDSm05c3Vk?=
 =?utf-8?B?ZjgraGREaTVWQWJZNm9UMFFSMXo2cUcxVnB4M3F0K1F6V2hGbUUyRVhONUlu?=
 =?utf-8?B?VFNuK29zeXlJUDY0VG9mUGw0UjhjMkdWTHZDd1dyZlJVc0xERHFqUDBWZzNX?=
 =?utf-8?B?LzBQUW9zZFpaRkpkb1NDVzNKMjE5YUYxNDhwYXRKNk9BeVhqWFc0aW1meTVL?=
 =?utf-8?B?MlRZdW4zTENNNTlxZ290RnZqU0szZWVxbVluQzQzQ2UzUVBwQ0ladjlINzhx?=
 =?utf-8?B?R2FqdVRnK3NOU1Uzbk54eVN1bi9SeGtjekYrVitoQ044SWt2UnVSRjROZ09w?=
 =?utf-8?B?MHFFZTFqNmRtdHhyZmt4UExFOWQxQVdNUHhZdWNDRnNsOSs3bHhNMWtlY0o3?=
 =?utf-8?B?WWZnS0RPWVdSa3M2aFo0dmRzcWpuS3o4OWEvKzVDUTA3MHhhMmEyY0M5SEhT?=
 =?utf-8?B?ekJvc25oRUNvZXpxTzA4YlRFTGRNTTQ1M2wrUFk1YzhJWjE3Z2FSVXFMUHQv?=
 =?utf-8?B?cU5JMVV0U2w5b3owSDJsUTZ0S082MnRCU1IySkdVT25yZm8rNzRoYUNuaWhX?=
 =?utf-8?B?b0ZaNUZKcGpteHFENUZWYjd2c0NkajdPTDdUVFBSdkpCTGlRYU9pSVBzYmJu?=
 =?utf-8?B?WnRsOTd0Tmp1OENxTEdtQk45aUZtZDRWZFN1cFJ6dUU0UXcrcHhoL3MrMVVL?=
 =?utf-8?B?WjF6Y0t5NEQvRXdSNjJDamxsYk9BMmVrV2lhNS9rUFZFdkVrZm9TQ0kvZ29X?=
 =?utf-8?B?OUY3MzQwSVp5QzJGUEUxT0FPQ0dXQVR3R2FyUmorcXBpQjE5WjN0b3k1cWRr?=
 =?utf-8?B?Vi8zRlU1cXBQRkdrWTJ2NzVxWUx0WTVXbVcwUVFKMmZDZWZxc1ZLSlovTElS?=
 =?utf-8?B?N0RkTHFnb2JyL2JpdjRxVkNwMzhodmpyc2RMalNwTzNzNVdIMGFvb3hJYTlU?=
 =?utf-8?B?Zk94OFNPeXdZQ1ZxaU9WaFZVampwb3dDZmR2alhBV0RDMjRMNTVsZzh5dUZa?=
 =?utf-8?B?RUFFaDBLZTZJclA5NEZUbW0yL2dneGRKOVl0YjFVRlRMS0Fvd3l5TXoraURt?=
 =?utf-8?B?KzlkNnNzS3B5bnJQMTM1RUVwaHEzUDBGQXVwU0JZaHZ4VkdSWnFuK2ZtdjRn?=
 =?utf-8?B?MVg2aEkyTWRXNi9jL2gvQnhTMytyUDcrTTQwcE5PcUxEQnRtVEZ0U0NUQzgx?=
 =?utf-8?B?VkZnK1VSNzRqU3lkMVgwVmVwSENNcmZtK2psR0RGeWUweStaL1RrejdkUXNH?=
 =?utf-8?B?T0lZdVdobkR5MTljNG5tU09zdmF4KzFrQW9oUnhVQ010dFlheHcwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f76297-b8e6-41c6-afb4-08df12fc7eb9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:39:37.9470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18DOQaZ8AGsb4RxagVimKDIeayZY8YBwEjy2xodJ9qRkWcG8WB/gU7Qy+z+Gdo7b5SmG4m7Pja9SHg/ZOAPMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
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

I don't think we have any user but nova-core at the moment, and it
benefits from this in several series (patch 3 here, but also ID pool and
later r000). Miguel, is this ok if we take it (i.e. the next revision)
through drm-rust-next?

Some nits below.

> ---
>  rust/kernel/num.rs         | 138 +++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/num/bounded.rs |  19 +++++++
>  rust/kernel/ptr.rs         |  14 +++++
>  3 files changed, 171 insertions(+)
>
> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
> index dbe848e30efe..9435459376a4 100644
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
> @@ -9,6 +10,143 @@
> =20
>  pub use bounded::*;

Can we move the new code at the bottom of the file? I'd like to keep the
`Integer` definition on top.

> =20
> +/// Creates a value from an integer constant expression, with validity c=
hecked at build time.
> +///
> +/// This works for any type that implements [`FromConst`], with the targ=
et type inferred from

I am wondering about `FromConst`, do we want to make it public, or hide
(and possibly seal) it?

Basically as it is anyone can implement a new type that works with
`cv!`. If that's by design, then good, and I don't see any potential
issue with that, but IIUC we also agree that this is a temporary
workaround so we might not want to allow extensibility if it isn't
future-proof.

If we decide to make `FromConst` more discreet without sealing it (which
sounds like a good middle ground to me), then we should remove mentions
of it from the public docs and mark it as `#[doc(hidden)]`.

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

These examples are excellent.

> +/// ```
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! cv {
> +    (@cast $v:expr =3D> $t:ty) =3D> {
> +        const {
> +            #[allow(unused_comparisons, unused_assignments, clippy::as_u=
nderscore)]

You may want to add `clippy::unnecessary_cast`, in case one does
`cv!(v =3D> u32)` where `v` is already a `u32` (which would happen in
macro or generic code).

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

Can we document the arms a little bit? In particular the `=3D> u8`...
business. No need to document every single one, one comment for the
group is fine.

> +}
> +#[doc(inline)]
> +pub use cv;
> +
> +/// Types that can be created from an integer constant expression valida=
ted at build time.
> +///
> +/// Implement this trait to make a type usable with [`cv!`]. Use the [`c=
v`] macro, not this trait
> +/// directly, for creating values.
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
> +                    "constant cannot be represented by the target type"
> +                );
> +
> +                V as $type
> +            };
> +        }
> +
> +        impl<const V: i128> FromConst<V> for core::num::NonZero<$type> {
> +            const VALUE: Self =3D {
> +                const_assert!(
> +                    V >=3D <$type>::MIN as i128 && V <=3D <$type>::MAX a=
s i128,
> +                    "constant cannot be represented by the underlying ty=
pe"
> +                );
> +
> +                match core::num::NonZero::new(V as $type) {
> +                    Some(value) =3D> value,
> +                    None =3D> panic!("constant cannot be zero"),
> +                }
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
> index 2a2b0a4bca5e..f720eb44e7d3 100644
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
> +                    "constant cannot be represented by the underlying ty=
pe"
> +                );

Is it possible to leverage `cv!` on the primitive type to avoid this
`const_assert`, which is basically a copy/paste of the one in `num.rs`?

As a bonus you would also get a value of the right type and don't need
to use `as` twice below.

> +                // Statically assert that `V` fits within the set number=
 of bits.
> +                const_assert!(
> +                    fits_within!(V as $type, $type, N),
> +                    "constant cannot be represented within the given num=
ber of bits"
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
> index 82acb531b17b..ac1662c3c8af 100644
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
> +            "constant cannot be represented as an Alignment"
> +        );

Same here if that works. Otherwise let's add a `CAST:` comment to the
`as` statement below using this `const_assert` above as justification.

(also realized this could probably be done for the `NonZero` block as
well)
