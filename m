Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A21FC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AC210EF4E;
	Wed,  5 Aug 2026 16:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CHe7l6RA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1248B10EF4E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:46:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EECBF43B3E;
 Wed,  5 Aug 2026 16:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E0E1F000E9;
 Wed,  5 Aug 2026 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948393;
 bh=985jZjDz+qUwEBNpXS944ilYWn0u8gi9bGWcYoeb0EE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CHe7l6RACkx6cU4og0Kjv28R4BViODHV4HQMMQG73pslqCE9Hp6aEq9RKdMBZ0j/C
 GlPfjqBFSbGeHGO3FPn07rODp2V7eCTw48h8ANIGNs56TyhdLrMCzONN/+W8ULitXC
 IBJHTNA3AFz9hGn7M78jWKXAq4rEzfNZTZ56uwHgx5+Uc4OWxq3rCObihHYYOeI8Y7
 xGDmInyTsNcFWm9Gyi+X+uCLCBIDuVsvGKG53vTjKwV554TWar7v9shi0p2XvZ3yEk
 Er1tqfSKXHskGQYCgv4uDm8SCI7gfrnUPgeDs1mTIs6TWY+f+z1upDuf4F+q4y2Q1A
 SJJmI7nmohxLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/16] rust: io: add `IoRepr` trait
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:46:32 +0000
Message-Id: <20260805164633.84E0E1F000E9@smtp.kernel.org>
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

> For types that are layout-compatible with an I/O capable type, we would
> want the ability to use them directly for I/O operations. E.g.
>=20
>     bitfield! {
>         pub struct Foo(u32) {
>             ...
>         }
>     }
>=20
>     #[repr(C)]
>     struct Bar {
>         foo: Foo,
>     }
>=20
>     let mmio: Mmio<'_, Bar> =3D ...;
>     io_read!(mmio, .foo)
>=20
> Currently this feature is available from `register!()` macro but not
> otherwise available with `io_read!`, `io_write!`. Support this by adding a
> `IoRepr` type to denote the underlying I/O type to use for a specific typ=
e.
>=20
> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
> remove them; also convert register methods to use the `read_val` and
> `write_val` instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D2

