Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE61C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F53899B7;
	Tue,  1 Sep 2026 16:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ci4WEBFz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60472899B7
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:56:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D75506013A;
 Tue,  1 Sep 2026 16:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394171F000E9;
 Tue,  1 Sep 2026 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281782;
 bh=fjC24Xc9+ru8TCAv8m05nVLM5835Ya2wrX1VK8SgJPA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ci4WEBFzeKIx3Pr4X/kswDeH4U9H9kWmCgmo+y4rUv+vnnBtom2qLtvCqOSiP4MWW
 7xN2aEFUxG+oUJ1RxCp7wte4Nh5xniny8xcjLpWckevy2e0EDcKjS1/NVQyOccUb/u
 YohQk3fyLYO/TaxiUdfAymyWXMw3k6T9+Sf2/Wj/PYJ41AgOqkWq2IF5I/zuuMM1qz
 4WCFCYp0WW7qnZ8iPrd7BhulofpEGp7BJyyqtPfkutax00soqglvcArd7bALx+8kvk
 SKg1qbQECYRB6xYYcE0Hn+6TnqlztUiBpunBqOVQoZ8YOL2GwOWLf+pWGm4ojPCPAx
 GRL5aQOgfm9dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/16] rust: io: perform conversions using `AsRepr`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-4-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-4-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:56:21 +0000
Message-Id: <20260901165622.394171F000E9@smtp.kernel.org>
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
> otherwise available with `io_read!`, `io_write!`. Support this by
> performing conversions to I/O primitives via the `AsRepr`/`AsReprMut`
> trait.
>=20
> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
> remove them; also convert register methods to use the `read_val` and
> `write_val` instead.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D4

