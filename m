Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B9CC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABE310EF56;
	Wed,  5 Aug 2026 16:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V1RTxSih";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1CC10EF56
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:51:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02B0F40D68;
 Wed,  5 Aug 2026 16:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB7A1F000E9;
 Wed,  5 Aug 2026 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948671;
 bh=iKC88PlcMQAy72Vp4zYxUh+UBhe4tddg7eRlo0Qvf/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V1RTxSihuVi8C9O/cfFnLvaC1QV2+byc2NyH9Fekj8rpivMVn7hkBuJVAzraxJ1Hj
 AEo+QiYjhIX2tHt6V0ghEun7yeqrgRzNherRjhjnlYIODmvBPr1gsyc/swIyZuWhK+
 H79TMnfaJzY5xR2oqbfhF2JTNJ7U/nFX4KMyC3lPtxpArCshHAR1gSgjy6acvfTu/I
 mjIvjQDgucd/tqiePTi3F+tnu3/3jqUqrNQK0Hcq5rxf7tFA0RgbfadA5fCkVFDdUi
 9NwgIyRBUtbMUrzJPLKCtvSvvSk4n0TJDoCgUzEhAU1kaIK8h5dqOukremrD+NwwFF
 8Wei4ujpsoynQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/16] rust: io: register: unify handling of register
 with/without bitfields
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:51:10 +0000
Message-Id: <20260805165111.8CB7A1F000E9@smtp.kernel.org>
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
- [Low] The documentation comment for `FixedIoLoc::Location` references `[`=
FixedIoLoc::location`]`, which does not exist.
--

--- Patch [16]: [PATCH v2 16/16] rust: io: register: unify handling of regi=
ster with/without bitfields ---
commit eee244bc141adb8220a5c6420bc3a94addf8572c
Author: Gary Guo <gary@garyguo.net>

rust: io: register: unify handling of register with/without bitfields

This commit unifies the handling of registers with and without bitfields by=
 making the fixed location a property of the type. It replaces FixedRegiste=
r with a new FixedIoLoc trait to indicate if a type's I/O location is uniqu=
e for a specific base.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index fe0e6763a600e..80282c423868a 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs

[ ... ]

> @@ -265,6 +224,17 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Sel=
f>>
>      }
>  }
> =20
> +/// Trait implemented by types that indicate there is a fixed I/O locati=
on for this given type.
> +///
> +/// Implementors can be used with [`Io::write_reg`](super::Io::write_reg=
).
> +pub trait FixedIoLoc<Base: ?Sized>: Sized {
> +    /// Type of [`FixedIoLoc::location`].

[Severity: Low]
This isn't a bug, but does this intra-doc link point to a non-existent item?
The trait defines a Location type and a LOCATION constant, but no location
method or field, which will likely result in a broken rustdoc link.

> +    type Location: IoLoc<Base, Self>;
> +
> +    /// Location of this type within given base.
> +    const LOCATION: Self::Location;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D16
