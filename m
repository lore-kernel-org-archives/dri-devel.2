Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E088FC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494C510E8A4;
	Mon, 10 Aug 2026 14:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D9MdNtEe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1CB10E8A1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:09:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 303A460204;
 Mon, 10 Aug 2026 14:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C551F000E9;
 Mon, 10 Aug 2026 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786370993;
 bh=qPomjfQ/iNRMXP6nS6RJneDx/EEx8/z5CLf4AkHFhiU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D9MdNtEerPrP/rEZlQfPbjtJ888OO2HeVDmj4gjeddpmLJsBPb6ge4ZW5bG+Bo2Ty
 v1ul6AWvcPQ9JCjyDzlFJRGj6XpvRgdhhfFZTr5U5RFDD/LiG512tvosrHn8M0/4om
 74hc2TxccoV+PHJCSbc1KX5mFJ1p3RvvoJmC0DPyKzOMdkC4qZOI32KxeoMHgGkYMd
 MBvnrs+Zh6PH63tWziI6X1Pdl4gu49MZv4uPGyOEBQhQFZrINWo8Bs6BDFAc9w1kBm
 6z9UJ8npMTMVZZm2yxDAxw71U9dAZaHG2yReVdecSPPpEs/oBS5OgzkgaYprP8BRm/
 t+/4UXVZCs2EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] gpu: nova-core: Add self-test assertion macros
 and config option
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260810-pramin-split-v2-11-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-11-65a00b3c7309@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:09:52 +0000
Message-Id: <20260810140953.31C551F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `$dev` expression in `selftest_assert!` is conditionally evalua=
ted only when the assertion fails, which can lead to inconsistent side effe=
cts.
--

--- Patch [11]: [PATCH v2 11/12] gpu: nova-core: Add self-test assertion ma=
cros and config option ---
commit 205e1404103e41ca5c6fd34482ac0f24c1d05216
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: Add self-test assertion macros and config option

The existing assert! and assert_eq! macros cause a panic. For self tests
in nova-core, it's inconvenient to cause a panic since these need to be
run on actual hardware. Instead, define similar macros that log an error
then return an Err.

> diff --git a/drivers/gpu/nova-core/selftest.rs b/drivers/gpu/nova-core/se=
lftest.rs
> new file mode 100644
> index 0000000000000..f5b5965b7e6ad
> --- /dev/null
> +++ b/drivers/gpu/nova-core/selftest.rs

[ ... ]

> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFIL=
IATES. All rights reserved.

[ ... ]

> +#[macro_export]
> +macro_rules! selftest_assert {
> +    ($dev:expr, $cond:expr $(,)?) =3D> {
> +        $crate::selftest_assert!($dev, $cond, "assertion failed: {}", ::=
core::stringify!($cond))
> +    };
> +    ($dev:expr, $cond:expr, $($arg:tt)+) =3D> {{
> +        if !$cond {
> +            ::kernel::dev_err!(
> +                $dev,

[Severity: Low]
Could this lead to inconsistent side effects if the $dev expression contains
them?

Since $dev is only evaluated inside the if !$cond block, any side effects in
the expression passed as $dev will only occur on the error path when the
assertion fails. They will be skipped on the happy path.

Would it be safer to evaluate $dev outside the condition, for instance by
binding it to a local variable like let dev =3D $dev; before the check?

> +                "Selftest: {}:{}: {}\n",
> +                ::core::file!(),
> +                ::core::line!(),
> +                ::kernel::prelude::fmt!($($arg)+)
> +            );
> +            return Err(::kernel::error::code::EIO);
> +        }
> +    }};
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-pramin-spl=
it-v2-0-65a00b3c7309@nvidia.com?part=3D11
