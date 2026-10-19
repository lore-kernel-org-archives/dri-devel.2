Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFDCCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105F810E41A;
	Mon, 19 Oct 2026 04:41:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367BD10E41A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:41:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96D68438FC;
 Mon, 19 Oct 2026 04:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947CE1F000C4;
 Mon, 19 Oct 2026 04:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792384896;
 bh=Pk6MkmtH/GJw8NlTcNRi6wz8CXhzQWHpRjQ0BGTG4OI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D/1TcAerN9vo08Ig/Us5K0WF1kf/UAi+j3LWX2B8NEgE5WWh3RDHDKkva3kgvzVde
 1QSRkoB3HdSN8lhf7hSo/Xsj+D+kwWjozaXVFQ1tS1hmaUdeuGCA3KZPrYunxRWNgh
 S9ZreiPYOQIC+TXiYOzPTjOpmvEPbaEFgJjqrt/Ys4f7O8ZGh81UYbWfercSyZ7MEg
 BlXEQ9D+/AfhGVas08cna6SNGV/kjBj4SMKvIKoTwFrpjK6uT/YoMBEeAfYMnMyk3e
 n0GpkE5umIXGg/yjYK0F7tbVeLHlz8mL5nhAwX+oqzQq0pvRrDbUYLZc6uM/wGZ8Yt
 imMH2oy7issPQ==
Message-ID: <sashiko-outbox-176646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] rust: use Alignment size constants
To: "Eliot Courtney" <ecourtney@nvidia.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Burak
 Emir" <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, 
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261019-chid-v10-1-67de9180b4ed@nvidia.com>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-1-67de9180b4ed@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 04:41:35 +0000
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
- [Low] rust: missing SizeConstants implementation and sub-1K constants for=
 Alignment
--

commit 2a0eb77a4c0fef593fa5a986d45a2a3fe50ca233
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: use Alignment size constants

This commit replaces Alignment::new::<...>() calls with SizeConstants
associated constants on Alignment across rust/kernel/ and
drivers/gpu/nova-core/.

> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index 8a934c55169fd..f53886f9ed91e 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -317,7 +317,7 @@ pub(crate) fn run(
> =20
>          let base =3D usable_fb_regions.iter().find_map(|region| {
>              // Tests rely on this being 8 byte aligned for checking misa=
lignment handling.
> -            let base =3D region.start.align_up(Alignment::new::<8>())?;
> +            let base =3D region.start.align_up(Alignment::SZ_8)?;
>              (base.checked_add(SELFTEST_SPAN)? <=3D region.end).then_some=
(base)
>          });
>          let Some(base) =3D base else {
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index 9c214b9f4dd9d..a2d2d170b5014 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs

[ ... ]

> @@ -291,7 +294,7 @@ fn next(&mut self) -> Option<Self::Item> {
> =20
>          // Advance to next image (aligned to 512 bytes).
>          self.current_offset +=3D image_size;
> -        self.current_offset =3D self.current_offset.align_up(Alignment::=
new::<512>())?;
> +        self.current_offset =3D self.current_offset.align_up(Alignment::=
SZ_512)?;
> =20
>          Some(Ok(full_image))
>      }
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index de8ef8e2aec41..5712478a54616 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -19,7 +19,8 @@
>      ptr::{
>          Alignment,
>          KnownSize, //
> -    }, //
> +    },
> +    sizes::SizeConstants, //
>  };
> =20
>  #[cfg(CONFIG_HAS_IOMEM)]
> @@ -90,7 +91,7 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: =
usize) -> Result<*mut Sel
>  impl<const SIZE: usize> KnownSize for Region<SIZE> {
>      const MIN_SIZE: usize =3D SIZE;
>      // Alignment of 4 is the most common; different base types can be ad=
ded once required.
> -    const MIN_ALIGN: Alignment =3D Alignment::new::<4>();
> +    const MIN_ALIGN: Alignment =3D Alignment::SZ_4;
> =20
>      #[inline(always)]
>      fn size(p: *const Self) -> usize {

[Severity: Low]
Is this patch missing a prerequisite commit that implements SizeConstants f=
or
Alignment and adds the sub-1K size constants?

Currently in rust/kernel/sizes.rs, define_sizes! is only invoked for integer
types:

    define_sizes!(u32, u64, usize);

and define_sizes! only defines constants from SZ_1K through SZ_2G. There is=
 no
SizeConstants implementation for Alignment in rust/kernel/sizes.rs or
rust/kernel/ptr.rs, and sub-1K constants such as SZ_4 (used in
Region::MIN_ALIGN in rust/kernel/io.rs), SZ_8 (used in selftest::run in
drivers/gpu/nova-core/mm.rs under CONFIG_NOVA_CORE_SELFTESTS), and SZ_512 (=
used
in PciRomImageIterator::next in drivers/gpu/nova-core/vbios.rs) are not def=
ined
in SizeConstants.

Without that prerequisite change, will building the kernel Rust crate,
rust/kernel/gpu/buddy.rs doctests, and drivers/gpu/nova-core/ fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-chid-v10-0=
-67de9180b4ed@nvidia.com?part=3D1
