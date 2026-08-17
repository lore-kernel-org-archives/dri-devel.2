Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F1C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665B388647;
	Mon, 17 Aug 2026 06:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eTHWE4U7";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD8B10E643
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyaMGfASFHu6DRvXTtH4arKndHD/IGR53RvwTLFmkXlG8invJ6BDIkTwmJeURzk4EpSz/6NTlREJconw0VzM2OQlMGpcCPC0l848EVLUnd6hsNt+G0AjD2kS9IRJt3JKsqO0gRzxLMff4K+4Kav2qlv3VZ0oSWZz3Vbq6IMkY77CzpzRrqyVd4vTOVNP4zbksGJjFn73zyRUTq/CSMCwFC/t2SkFe0MTlkBzL5JQfjihxfsjgZ3CP2CJMxbbDwNbOu7QBB6ypw5mGyMfmJzVu1kO+859BpNIZf19q3h8Gow3gvUpJTwoDSrL8tTEyd3iyeq+Wenocy9Yn4NQMP3NuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+3X26aSBY/vkTPA8xeYChNqrkJa0dDJy5I9N9pJCII=;
 b=XshkJFT3/y6uJlk16IRbZjFy9QmR/HLLD1i9X2/TJOjogxlNPRUDks0mtI1+RL099VLIe9tbOIPLHfJq/R5bHvEGP3s35vwRlLxECe1gKtMlnZyhJTSlIt/xmmcF7aywX/VyH3qsQxpmfP5yLLBe+Bh8JkeDmySLeq77r8GUuUkJmqN/UMH/bGs2YgVb6oeZb20o/w8tk898VAE6ZsIR0SuYrpHi/dQDj8iGl/6LYsy2nODFFyGMzS0CU7qthnkmSDymIwm/SLPv7jxV5iVjx+PjgdGyn3C/I00z1SGBOo+MnmKkZK5IRf5dmMkExk15nx5XHJF8IQuHOM9NNg0KoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+3X26aSBY/vkTPA8xeYChNqrkJa0dDJy5I9N9pJCII=;
 b=eTHWE4U7V5cvMaouKAzmHXE/mBWGfVVD5HQ9Zl4dA9qurRSyOwdR8Nbz1i7uSNrjWnvzqGjLxw7sy2t2Qwh1SXhHIhdejn6IE3w4Jxdia2INjuUDYwXLxr0mISrBgxUOZce/Pbz4TeDAeUT7oIV1mTP4ml78rqRTJQqKIQKUplJ0h+MipWRFXPmWWxPhTXtIpZqxzenURpKQ8up2l/mRNFVHFdgoyooNORfwvGLgpldpI1JhGMuXmls1H7ufLFqu1bG1fFz0K5oRZM7ZGaDwAS5gq+hQgHSJMu/oBHISl+sTZMP42+y2FCK1ZMbTr0wzbI383fEqQXKyCAQQYeJp5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:00:43 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:00:43 +0000
Date: Mon, 17 Aug 2026 16:00:37 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, John Hubbard <jhubbard@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v2 04/12] gpu: nova-core: mm: Add VramAddress type
Message-ID: <aoKfPchpfmTVguQf@nvdebian.thelocal>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-4-65a00b3c7309@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-pramin-split-v2-4-65a00b3c7309@nvidia.com>
X-ClientProxiedBy: SY6PR01CA0085.ausprd01.prod.outlook.com
 (2603:10c6:10:110::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a01f37e-df40-4de4-7062-08defc24df1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 0Tkk20boQhgNbqRPILXyyWaQ1ASR7FJa2Gbt7N9GZw2uZRBkwNQ+OdQ3yIAhriFwhINs/kfZFIjy5itmSAwlKtgJ7XE3zxK3jcjJH7V+bRzPzfRELSqWWZUgcsw6GIHO59tdZ0ZNCADLFfJ2A01fDqun2BvK+7BMRtPZYG18S04oSdMIsT4o7tQtkIeYQhNq+VoXRF+tJr4SBpXboo/A2mZzoGbzOO4ZBm/EUMmp6K1bKU9fWQtgSQGNMYxOUthFb6zcdWld9+V1IJFYt1afCWd4bHUNc8cdVQqR22lompooKNdPNKlmy1l+wbfIfG56eO47JhA+ysbGpgHuiFk3SOWWOZYFyemDl6te88YjHEQBqc5+Q0dDwwJNc+VZkHdb8dhr7nT3ZejiAnR0yXYNOpZyskRFBdi5Kab4hpp5zZg570XHnmHTg8LLhF2ijWqH0IahyL4PgwtCCgfGtA67M2Zu3Na7TnjvJqwnR+va5vt+CRwUqZ/jcWKSamw/B73zqZtzvg3ORex+enA4Mlagdy2Pv9WxOjJo0XS0EEhQJdoPxem9DFU5s3jAMZ5jmW+uNE/QwYv8f83JnmbNBD6T+FG2XZ/9KZ98tZnC047RlDxE21G9h7GEJIIW2QEgFXcvoUqG7UWW9hBpHyiBFyemc6yXgLS9xS2KyAwbQTupQo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSZraR13LbVwm5XhR2ajbK/qXchEGj61+seYOvyZarjEAVX8QKsqWY8lT8KS?=
 =?us-ascii?Q?gWEqn6lNZF6TnnMTGGygjXM/B0bvZdoNGwGLx/hTvcdz48UP+M/s4GD+V8jj?=
 =?us-ascii?Q?EE0zDaUDThhCNQG+qazrBNKCjmElWiN7uLTUTvQcBvfE7QnwY7Zc0yxut/Wf?=
 =?us-ascii?Q?WxSUZFduFi3TAUFi+fmpzb03YHAOAFZiQZ2J2NMd+SXclENw6l5Q6qwC6cen?=
 =?us-ascii?Q?BIahcDc5gHFrUvRdBkGX8MdopAuTYs5uZsOnC+ghFktavPy+fVm9HAIOdE1s?=
 =?us-ascii?Q?ts1Afr7RzWlNIuyPopnfOceYKt2IsubS7TpuRvQij6z9iVBv+Iomy30CIzfW?=
 =?us-ascii?Q?j2en6+0iwj1MOdBiODDP17bJSKMFv32jfBXZW1EYTvT86QKmapgKY3BLv3SW?=
 =?us-ascii?Q?WAXLUR7LT2bTtwv9uc+0seQn7KdakSCsWy7Brt560xyOoBGjD52dGKWsqHQ9?=
 =?us-ascii?Q?hB6q0TaS46x+vr5aV9M+wJ06QNLJQsjni+tRJwJ91bJ+aNN2DRd4K97biayY?=
 =?us-ascii?Q?fUsKO1ntmxdIR7c0Ul+003metsPk8ahvZr8p6gRhKaw2qd1cBvxtAnSwUA0/?=
 =?us-ascii?Q?A4ChMe03DDWgq9sbtgvRMozpv/C8o9e2oN2zV07znTWpMUwQ7dxWL5UupHRd?=
 =?us-ascii?Q?PWjo8ADp5H+tkifcYFQGonK1IoIzpwF5zU2fznAIU7c7Hpnm3F2AXTnPcQQg?=
 =?us-ascii?Q?VXMnfCzmJ/gl5Ui3BRmND1A1uQIzyR0tKp2fJDsM0O5TOsSmJJQl2MVD5JjM?=
 =?us-ascii?Q?fx2IcCKl+dPH0h42xg7Nxylp2ZvsUnHtb76lV9mS9kVNrQAFHIkq9WzU48DE?=
 =?us-ascii?Q?CRoGrCv0HUcZijZu3f9PuKvA3eqcJDR2PbQIqHCTJgJuJw+d56WiG3ya5hS1?=
 =?us-ascii?Q?E73dfgDcYdR+I/yxI0km0Zu43VfX5dPuC93OMhZeAeBxat8TO+t/+dBti5A4?=
 =?us-ascii?Q?D5KqVpWiRsyQVl/5uLo822stAeYK4S1J9ZgJdpPIhV6ZnrQAxTPRS9M3Soun?=
 =?us-ascii?Q?CCPWNFZApgajK/1Sam2sUHay/lzy8HjLrP6sK/n9umGKKagPnjSEPtD/AA3w?=
 =?us-ascii?Q?r2fj6Ur7GTfhFbkMMDCkfznqKZ7AqgQpib35BNwww55kdQHLm5XJLvFt34Vw?=
 =?us-ascii?Q?szYGXvzwT0ZejeSUXy5maulvF3hEge2quXN52gX0bPGvnZko+hcY8HMGbNzZ?=
 =?us-ascii?Q?JUawgvJDNT1dOzhZUS9TfUt5AM8u/QXCp53yQoxNIpOrMqrnng6+45/3jW/7?=
 =?us-ascii?Q?+y/ON+0Y0SMvi61mQ8Av8Iuvf632meXSVWecB3pTcTXEaN4UKcIIrCxGLFQW?=
 =?us-ascii?Q?7GRL7+rB3D/eifJB4F33eP7wEq57QGUjFzqGQsvsKB6PAD57KS825lQ7w/W4?=
 =?us-ascii?Q?2PAkZtOMKo+sr6XodrD1htudy0jIe2vIw86b2Uex/zUru8NR6oMxRB/42dCX?=
 =?us-ascii?Q?3EmeUa9UTBUMqVQQ1Tetg+idjbTUYISif4TSDDyyZUNF1j+choxUSrOhfnoN?=
 =?us-ascii?Q?aLzlwvlBqv6EjwD6Skix7ipAnGBb2+qNdVrFKlsVsPQLZon33dRhdzmt5rZE?=
 =?us-ascii?Q?8hWaMDxzDrdp8wS8xiuOUwymu3A1/OFYEfxGbqOZdatMWm+oFzuuKSVHq4pC?=
 =?us-ascii?Q?NWE6H8ePfpja9Olp5ca1LoR2L51clJ4yU0HlTZ13xQ7yQlOSU4zRR4nFT+m1?=
 =?us-ascii?Q?CvsKkunZYKx5DzanKtlIuV5nZ3YRFxr3D5xbtq5Rqq1ESmAFOYtBuOAbChFr?=
 =?us-ascii?Q?cNJwd3mBDA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01f37e-df40-4de4-7062-08defc24df1d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:00:42.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7ey6w6Nk4OWxyTF1N6UccCXl3FlINX6M8Avh93rr/mZjw9Agp4+Q+Ob0ogxVHQ2ICSGFRDJBpy7NNpzJePZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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

On 2026-08-10 at 23:55 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Add the `VramAddress` type representing a physical address in VRAM. Also
> add an arithmetic helper, comparison, and operator overloads which are
> required in later patches for address arithmetic.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> [ecourtney: create mm.rs here, squashing in the arithmetic patch]
> [ecourtney: splice the two commit bodies]
> [ecourtney: drop the Pfn fields, open-coding what bitfield! generated]
> [ecourtney: drop align_down and the IntoVramOffset/IntoVramRange traits]
> [ecourtney: make checked_add() const over a plain u64, derive the ordering]
> [ecourtney: doc wording, header, import, and signature cleanups]
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/mm.rs        | 60 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs |  1 +
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> new file mode 100644
> index 000000000000..dcd5e5e919bf
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +
> +//! Memory management subsystems.
> +
> +#![expect(dead_code)]
> +
> +use core::{
> +    fmt::LowerHex,
> +    ops, //
> +};
> +
> +use kernel::fmt;
> +
> +/// Physical VRAM address in GPU video memory.
> +#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
> +#[repr(transparent)]
> +pub(crate) struct VramAddress(u64);

Is this the best type here, or should this be bounded via runtime checking to
ensure it refers to a valid address?

I was going to ask if it should be bounded to reflect the physical addressing
capabilities of the GPU in question, but that would actually need to be a
different type as GPU physical addresses might not even refer to local vidmem.

Although I think that's a concern for future series - AFAIK PRAMIN can only
access local VRAM.

> +
> +impl VramAddress {
> +    /// Creates an address from a raw value.
> +    pub(crate) const fn from_raw(addr: u64) -> Self {
> +        Self(addr)
> +    }
> +
> +    /// Returns the address as a raw value.
> +    pub(crate) const fn into_raw(self) -> u64 {
> +        self.0
> +    }
> +
> +    /// Adds `rhs` to this address, returning [`None`] on overflow.
> +    pub(crate) const fn checked_add(self, rhs: u64) -> Option<Self> {
> +        match self.into_raw().checked_add(rhs) {
> +            Some(addr) => Some(Self::from_raw(addr)),
> +            None => None,
> +        }
> +    }
> +}
> +
> +impl LowerHex for VramAddress {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        LowerHex::fmt(&self.into_raw(), f)
> +    }
> +}
> +
> +impl ops::Add<u64> for VramAddress {
> +    type Output = Self;
> +
> +    fn add(self, rhs: u64) -> Self::Output {
> +        Self::from_raw(self.into_raw() + rhs)
> +    }
> +}
> +
> +impl ops::Sub for VramAddress {
> +    type Output = u64;
> +
> +    fn sub(self, rhs: Self) -> Self::Output {
> +        self.into_raw() - rhs.into_raw()
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
> index 35a8b1214b0e..8f59cfa97017 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -18,6 +18,7 @@
>  mod gpu;
>  mod gsp;
>  mod mctp;
> +mod mm;
>  #[macro_use]
>  mod num;
>  mod regs;
> 
> -- 
> 2.55.0
> 
