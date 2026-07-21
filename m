Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60475C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B801E10EACD;
	Tue, 21 Jul 2026 17:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ll28XigN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CAA10EACD
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:08:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C96AE4179C;
 Tue, 21 Jul 2026 17:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5549E1F00AC4;
 Tue, 21 Jul 2026 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653699;
 bh=j6ZzlgGKGZcub9UYCbEX3rIU6JVbMn7XKVo6dJ9ogYw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ll28XigNkSCEbQJxyTaz8ZAGH78OYnH3rlz5ibdH+XzpfVJwIaxY5QyU93RRqsqom
 T0KFNhUjwxISFB/N5B6//mIU8UaMu8Y8hB5dJOWrug24ud0YyOHMAuj7JkrmebC/sl
 qqCbNyul0RSz7BubvaBa8v0NtDB/JHrMLDCMlLGk7gaCZLmxm05HCYZuAk1alYcr4O
 U+aAX25gDWbXf/FbmpBoiwspQBeANz4alIJESuue++cL81ysydreOPNpxooyAb45eO
 WsLP9pJahcBWqHRxf6RQx8euVPf9ao1Z7bBARnEfvSxt3an+3rUrjmoTFCdCrFuay6
 dgC8WJrWw5xTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] rust: io: register: remove relative registers
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260721-typed_register-v1-10-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-10-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:08:18 +0000
Message-Id: <20260721170819.5549E1F00AC4@smtp.kernel.org>
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
- [Low] Broken intra-doc link for `WithBase` in module documentation.
- [Low] Leftover macro syntax for relative register aliases (`+ $alias_offs=
et`) causes confusing internal macro errors.
--

--- Patch [10]: [PATCH 10/10] rust: io: register: remove relative registers=
 ---
commit 9b1276cccc7f1b5ecb5c4e81e0c27d5b7d2f2492
Author: Gary Guo <gary@garyguo.net>

rust: io: register: remove relative registers

Relative registers can be better served by projection to subregion instead
of ad-hoc handling in register macro. Projection composes better (e.g. it
natively allows relative registers of relative registers without needing
additional support).

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index df47c28ba4f40..88ead1c1874fb 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -191,78 +191,6 @@ fn offset(self) -> usize {
>      }
>  }
> =20
> -/// Trait providing a base address to be added to the offset of a relati=
ve register to obtain
> -/// its actual offset.
[ ... ]
> -/// Trait implemented by all registers that are relative to a base.
> -pub trait WithBase {

[Severity: Low]
With WithBase removed here, does the register.rs module documentation need
to be updated? The module doc still references it in its intra-doc links:

//! items you might want to import from this module are [`WithBase`] and [`=
Array`].

Since kernel rustdoc compilation is strict about broken intra-doc links, co=
uld
this cause the rustdoc build to fail?

[ ... ]

> @@ -847,7 +479,7 @@ macro_rules! register {
>          $(
>              $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
>                  $([ $size:expr $(, stride =3D $stride:expr)? ])?
> -                $(@ $($base:ident +)? $offset:literal)?
> +                $(@ $offset:literal)?
>                  $(=3D> $alias:ident $(+ $alias_offset:ident)? $([$alias_=
idx:expr])? )?
>              { $($fields:tt)* }
>          )*
> @@ -855,7 +487,7 @@ macro_rules! register {
>          $(
>          $crate::register!(
>              @reg [$reg_base] $(#[$attr])* $vis $name ($storage) $([$size=
 $(, stride =3D $stride)?])?
> -                $(@ $($base +)? $offset)?
> +                $(@ $offset)?
>                  $(=3D> $alias $(+ $alias_offset)? $([$alias_idx])? )?

[Severity: Low]
Does the macro entry point still need to parse $(+ $alias_offset:ident)? and
forward $(+ $alias_offset)? now that the internal @reg macro arms handling
relative alias syntax have been removed?

If someone accidentally defines a register using the removed relative alias
syntax (e.g., =3D> Base + Alias), could this cause a confusing internal mac=
ro
matching error instead of a clean rejection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D10
