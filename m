Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF88C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C3E10EAB4;
	Wed, 29 Jul 2026 07:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cgIHY3HP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C500110EAB4
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 07:06:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B626D60A66;
 Wed, 29 Jul 2026 07:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294CF1F000E9;
 Wed, 29 Jul 2026 07:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785308797;
 bh=6UFXlTf2h1/afXZYrP4wYhhzyP5kpLTzXzsHvGIRU5k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cgIHY3HPoRmtci1fpk0+59Mp1pzQMVQkXd6gD51BmIqnbKR20QYZajkFw946T/JEB
 3Y0T71/g6+cUa/jpePk+gr9qq4BUlwQCiOdj203Tp0wSWSolB/LxAg2Htoi7KvSgE2
 8+YlGxpuNL+tugBBV1/xykebttFqmjKfWgUCMsiF+nO3tzq3v/SwPxaYIJejebKMMG
 zXIW5AQyjl3sxx7hVNFvf0iNbMyuElt2f2ZMdUhxQsA2/58LLDwdkpnk7WG3R40ia9
 DdjrkZE4xdsGJRk/SW5CyIOBuLRegpfLn0SjwvSroayUbjCx+0K9ChSSbK3stAuJOQ
 Z4+kXXrkEg3oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] rust: bitmap: add contiguous area operations
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-chid-v3-2-20cc08032bbc@nvidia.com>
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
 <20260729-chid-v3-2-20cc08032bbc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 07:06:36 +0000
Message-Id: <20260729070637.294CF1F000E9@smtp.kernel.org>
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
- [High] The `set` and `clear` methods incorrectly restrict the area's `end=
` coordinate to `i32::MAX`, artificially limiting bitmap operations and cau=
sing silent data corruption on large bitmaps.
- [High] The safe function `next_zero_area` fails to prevent integer overfl=
ow for `self.len() + align - 1`, leading to a documented deterministic kern=
el hang.
--

--- Patch [2]: [PATCH v3 2/4] rust: bitmap: add contiguous area operations =
---
commit 6adb3d6be8231d8ad4e8a7ca4a15f16e149caa2c
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: bitmap: add contiguous area operations

This commit introduces bindings for area operations on bitmaps, such as fin=
ding
the next zero area, setting, and clearing contiguous bits. It also adds bou=
nds
checking and other safety mechanisms to catch erroneous usage.

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc2..f4b0b8ae39d88 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs

[ ... ]

> @@ -497,6 +498,116 @@ pub fn next_zero_bit(&self, start: usize) -> Option=
<usize> {
>              Some(index)
>          }
>      }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`=
, aligned to `align`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if n=
o such area fitting in
> +    /// the bitmap exists.
> +    ///
> +    /// The returned index is a multiple of `align`. Alignments where `s=
elf.len() + align - 1`
> +    /// overflows a `usize` can hang the underlying C code.

[ ... ]

> +    #[inline]
> +    pub fn next_zero_area(&self, start: usize, nbits: usize, align: Alig=
nment) -> Option<usize> {

[ ... ]

> +        let nr =3D u32::try_from(nbits).ok()?;
> +
> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with =
an out of bounds `start`
> +        // value and never reads beyond `self.len()` bits.
> +        let index =3D unsafe {
> +            bindings::bitmap_find_next_zero_area_off(
> +                self.as_ptr().cast_mut(),
> +                self.len(),
> +                start,
> +                nr,
> +                align.as_usize() - 1,
> +                0,
> +            )
> +        };

[Severity: High]
The documentation notes that an alignment where self.len() + align - 1
overflows can hang the C code.

Since next_zero_area() is exposed as a safe API, shouldn't it validate this
overflow condition before calling the unsafe FFI function to prevent a
deterministic kernel hang from safe Rust? A caller providing an alignment
and bitmap length that overflows usize will cause this function to hang
indefinitely.

[ ... ]

> +    /// Sets a contiguous area of `nbits` bits starting at `start`.
> +    ///
> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `star=
t..start + nbits` is out of
> +    /// bounds, does nothing.

[ ... ]

> +    #[inline]
> +    pub fn set(&mut self, start: usize, nbits: usize) {
> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits)
> +                .is_some_and(|end| end <=3D self.len() && end <=3D i32::=
MAX as usize),

[Severity: High]
Does this bounds check in set() restrict the sum start + nbits to i32::MAX
instead of just restricting nbits?

The underlying C function __bitmap_set() takes unsigned int start and
int len. By bounding the end coordinate, a caller attempting to set bits
past index i32::MAX on a valid large bitmap will experience silent failure,
dropping state updates and potentially leading to data corruption like
double-allocations.

[ ... ]

> +    /// Clears a contiguous area of `nbits` bits starting at `start`.
> +    ///
> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `star=
t..start + nbits` is out of
> +    /// bounds, does nothing.

[ ... ]

> +    #[inline]
> +    pub fn clear(&mut self, start: usize, nbits: usize) {
> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits)
> +                .is_some_and(|end| end <=3D self.len() && end <=3D i32::=
MAX as usize),

[Severity: High]
Like the set() function, does this bounds check in clear() also improperly
bound start + nbits to i32::MAX?

This would discard valid clear operations for any caller modifying bits in
the upper half of the addressable bit space.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-chid-v3-0-=
20cc08032bbc@nvidia.com?part=3D2
