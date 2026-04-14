Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B448F9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F1C10E5D0;
	Tue, 14 Apr 2026 13:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D4kXfcBM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1791B10E5D0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:08:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BE6BB4074D;
 Tue, 14 Apr 2026 13:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06153C19425;
 Tue, 14 Apr 2026 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776172097;
 bh=EOs4cs74puDHNuXxnDv3cVw0QztmTfh44+ns5SWv/ic=;
 h=Date:From:To:Cc:Subject:From;
 b=D4kXfcBMvRdL998cWd1sQHemp49ysJ85XZdTQjdqz2z3PCSYBlMSHl7ADutQzsXxj
 71rou/X8joJ/29r0q+DQ9opI6AfW5Q+l2OmBAbXW5Hr+wtJTd13KsXKaSXB9Up69vl
 moTdw59ddBq+bce5vfxlzrAfsQvp6qCh3hcECiBbqWOQFh35wFGOidyzx1tup5G2dD
 YCpQmdJr0s2M/IpNw+v4NcVtc7htaH3VaYAnN8DheXoWD5nI1BrOwBLyDw/oSsZooR
 rWyt3hIVHEHnyw43H9P/yzPKSeyytTYKPmBMbUGAFF7sFtXfpau2gYUtM1XwEImG2x
 R7fF4oTqncbJg==
Date: Tue, 14 Apr 2026 14:08:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Asahi Lina <lina+kernel@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <ad48Pf2DA23y3c4W@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dTA+dSWhulpEZdll"
Content-Disposition: inline
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


--dTA+dSWhulpEZdll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  rust/kernel/lib.rs

between commit:

  d1aa40daa777c ("rust: kbuild: remove `feature(...)`s that are now stable")

=66rom the origin tree and commits:

  f9f0b4a1f35d3 ("rust: interop: Add list module for C linked list interfac=
e")
  80df573af9ef3 ("rust: drm: gem: shmem: Add DRM shmem helper abstraction")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined rust/kernel/lib.rs
index 5d22892447bdd,40de00ce4f971..0000000000000
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@@ -16,17 -16,50 +16,17 @@@
  // Please see https://github.com/Rust-for-Linux/linux/issues/2 for detail=
s on
  // the unstable features in use.
  //
 -// Stable since Rust 1.79.0.
 -#![feature(generic_nonzero)]
 -#![feature(inline_const)]
 -#![feature(pointer_is_aligned)]
 -#![feature(slice_ptr_len)]
 -//
 -// Stable since Rust 1.80.0.
 -#![feature(slice_flatten)]
 -//
 -// Stable since Rust 1.81.0.
 -#![feature(lint_reasons)]
 -//
 -// Stable since Rust 1.82.0.
 -#![feature(offset_of_nested)]
 -#![feature(raw_ref_op)]
 -//
 -// Stable since Rust 1.83.0.
 -#![feature(const_maybe_uninit_as_mut_ptr)]
 -#![feature(const_mut_refs)]
 -#![feature(const_option)]
 -#![feature(const_ptr_write)]
 -#![feature(const_refs_to_cell)]
 -#![feature(const_refs_to_static)]
 -//
 -// Stable since Rust 1.84.0.
 -#![feature(strict_provenance)]
 -//
  // Stable since Rust 1.89.0.
  #![feature(generic_arg_infer)]
  //
  // Expected to become stable.
  #![feature(arbitrary_self_types)]
 +#![feature(derive_coerce_pointee)]
  //
  // To be determined.
  #![feature(used_with_arg)]
  //
 -// `feature(derive_coerce_pointee)` is expected to become stable. Before =
Rust
 -// 1.84.0, it did not exist, so enable the predecessor features.
 -#![cfg_attr(CONFIG_RUSTC_HAS_COERCE_POINTEE, feature(derive_coerce_pointe=
e))]
 -#![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized)=
)]
 -#![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_d=
yn))]
 -#![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
 -//
 -// `feature(file_with_nul)` is expected to become stable. Before Rust 1.8=
9.0, it did not exist, so
 +// `feature(file_with_nul)` is stable since Rust 1.92.0. Before Rust 1.89=
=2E0, it did not exist, so
  // enable it conditionally.
  #![cfg_attr(CONFIG_RUSTC_HAS_FILE_WITH_NUL, feature(file_with_nul))]
 =20
@@@ -49,6 -82,7 +49,6 @@@ pub mod bits
  #[cfg(CONFIG_BLOCK)]
  pub mod block;
  pub mod bug;
 -#[doc(hidden)]
  pub mod build_assert;
  pub mod clk;
  #[cfg(CONFIG_CONFIGFS_FS)]
@@@ -72,12 -106,15 +72,15 @@@ pub mod faux
  pub mod firmware;
  pub mod fmt;
  pub mod fs;
+ #[cfg(CONFIG_GPU_BUDDY =3D "y")]
+ pub mod gpu;
  #[cfg(CONFIG_I2C =3D "y")]
  pub mod i2c;
  pub mod id_pool;
  #[doc(hidden)]
  pub mod impl_flags;
  pub mod init;
+ pub mod interop;
  pub mod io;
  pub mod ioctl;
  pub mod iommu;
@@@ -116,8 -153,10 +119,8 @@@ pub mod scatterlist
  pub mod security;
  pub mod seq_file;
  pub mod sizes;
 -pub mod slice;
  #[cfg(CONFIG_SOC_BUS)]
  pub mod soc;
 -mod static_assert;
  #[doc(hidden)]
  pub mod std_vendor;
  pub mod str;

--dTA+dSWhulpEZdll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnePDwACgkQJNaLcl1U
h9BUZAf/a+e7e56ZI9OKk6GMJAGzwkfrb0Qak+Dnc4NO68r31UDBuM2z3UAnlDSb
rIFjBrgZ9R3q1Ne/n38VKUhJcq0BfPqd+O0wo/NbCBYUua7T+0hEhn+u4rlTn/m9
xImCXArMSv4qXMI83/ybj3gmYVX3G/fsob0tQuhlYu54eerK2oZIKPADgI3dDwUh
SuW1lgf1l8FojP8EgGBnSpGSQdxcCZTqQ3NjOMthQpiYg45DK/hc3QPu+h7Ifu/z
a0jNk4b0enFWEY1cXQabyMG52B+8NJB2pvHCd1uCRnbK6SDMs6axdNso+ViCDZJN
tVslE7rQYFGKm9gIsjRJ0xqhsH5ioA==
=E2eG
-----END PGP SIGNATURE-----

--dTA+dSWhulpEZdll--
