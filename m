Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6F7CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E08610F0CF;
	Thu, 11 Jun 2026 18:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K4AHm1x+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BA110F071
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:14:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A948B60128;
 Thu, 11 Jun 2026 18:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1052D1F000E9;
 Thu, 11 Jun 2026 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781201658;
 bh=kKbkqY5uxRO4ptGtTtDsits9JwKMmwpy8xA5FNaX4pg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K4AHm1x+7tM6lqniTkEyPQP/hxsjv4Ef54yIM5Dg47fBWihZ4VD0Aw3NwmTRsQMwU
 /6sRDIctVziHjRLLTdA+7VMNte8wkMfGWeWgeMftiJteHxhT0LiF/sC8MQggQCRANd
 ZA1jOWGgTzM0+CG6uk+r6FFUNhB96IO7LoBaOef+orwNso2ZqLriEORS/OHBf8IT3f
 DTrpA8Z2b9lAamcVYhvhHJo9J/CPY4TyoIDmaaadvxG2cwlFfb8yWexQOfcTzalNhy
 pScq88HtbtUFjvY+RG1zetI2hThulk7SgqrxXL9cO8DS/AVFQS+qmFynQ/5PzfFZvb
 9MwSuXcQWa34g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/20] rust: io: add projection macro and methods
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260611-io_projection-v4-13-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-13-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:14:17 +0000
Message-Id: <20260611181418.1052D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Deriving `FromBytes` on `Region<const SIZE: usize>` allows safe co=
de to bypass the struct's documented `SIZE` invariant.
- [Low] Removal of trailing `//` on the vertical import block closing brace=
 violates kernel Rust formatting rules.
--

commit 0616e76ffd1d8525b38835ead9f29afeae45c2ed
Author: Gary Guo <gary@garyguo.net>
Subject: Add an io_project!() macro allows projection from Io to a subview

This commit introduces an io_project!() macro that allows projection from Io
to a subview using compile-time checks. It also adds a try_cast() function
to perform size and alignment checks at runtime when type-casting is needed.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 470ee2ed9849..c7a9952af995 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -14,7 +14,7 @@
>      ptr::{
>          Alignment,
>          KnownSize, //
> -    }, //
> +    },

[Severity: Low]
This isn't a bug, but does removing the trailing // on the closing brace
violate the kernel Rust vertical import formatting rules? The coding
guidelines require this marker to prevent rustfmt from collapsing the
multi-line imports.

>  };
> =20
>  pub mod mem;

[ ... ]

> @@ -44,12 +44,12 @@
>  /// This type can be used when an I/O region without known type informat=
ion has a compile-time known
>  /// minimum size (and a runtime known actual size).
>  ///
> -/// This must be 4-byte aligned.
> -///
>  /// # Invariants
>  ///
> -/// Size of the region is at least as large as the `SIZE` generic parame=
ter.
> +/// - Size of the region is at least as large as the `SIZE` generic para=
meter.
> +/// - Size of the region is multiple of 4.
>  #[repr(C, align(4))]
> +#[derive(FromBytes)]
>  pub struct Region<const SIZE: usize =3D 0> {
>      inner: [u8],
>  }

[Severity: High]
Does deriving FromBytes on Region allow safe code to bypass the documented
SIZE invariant?

By implementing zerocopy::FromBytes, safe code could use ref_from() to cast
any 4-byte aligned byte slice into a &Region. Since zerocopy only checks
that the slice length matches the dynamically computed layout size, which
for inner: [u8] is just the length of the slice, it appears safe code could
cast a 4-byte slice into a &Region<1024>.

Could this lead to out-of-bounds reads or writes if unsafe code
subsequently relies on the SIZE parameter for bounds checking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D13
