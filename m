Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48640C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F22710ECDB;
	Wed,  5 Aug 2026 05:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I992aXxV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6BF10ECC8
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:49:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E76D600B1;
 Wed,  5 Aug 2026 05:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55641F000E9;
 Wed,  5 Aug 2026 05:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785908967;
 bh=LujJQMUYrLsR40SlL6MQwegZqPRmljBFTFIr4QNHedo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I992aXxV7e0K7pu+SINovy3HTndDATVGa+XNGsJ6Ogy4R5RBmvThNrlN0Eb1MD9LI
 xzDt3bk4y/C+rR2xJHeRANYoNiG8FiDKWma/Al1NtKURDGR/Uil3la+FFZG4OO7PLK
 MOGv3hTtJp6uNjymqDnDeFgXD149RA0v04vR6YJ8xJwXJ6ew+UeGs1di9sxtzs3577
 60qO7FewtosXE8Lvn3C0M1qDyfuKoCr5adB5U01ijD5xBzlUMutndQ+pqlghhH/Twp
 0CTCWwek2ka2l7y0hLhAV9O3aDDr85x1biTR9joq71z2VtEKVE5SDHGNy+qFECRLb/
 wP/KuEv5RxB2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] gpu: nova-core: mm: Add VramAddress type
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-4-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-4-ff3e84a75dac@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:49:26 +0000
Message-Id: <20260805054926.B55641F000E9@smtp.kernel.org>
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
- [Low] Nested import groups are used instead of the kernel vertical import=
 style.
--

--- Patch [4]: [PATCH 04/12] gpu: nova-core: mm: Add VramAddress type ---
commit c94d87cb8d48e350527f7f52cc4f004c23fd4d17
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add VramAddress type

This commit adds the VramAddress type to represent a physical address in
VRAM. It also includes arithmetic helpers, comparisons, and operator
overloads required for address arithmetic.

> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> new file mode 100644
> index 0000000000000..dcd5e5e919bf2
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFIL=
IATES. All rights reserved.
> +
> +//! Memory management subsystems.
> +
> +#![expect(dead_code)]
> +
> +use core::{
> +    fmt::LowerHex,
> +    ops, //
> +};

[Severity: Low]
This isn't a bug, but does this follow the kernel vertical import style?=20
According to the Rust coding guidelines, imports should be organized=20
vertically rather than using nested import groups.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-pramin-spl=
it-v1-0-ff3e84a75dac@nvidia.com?part=3D4
