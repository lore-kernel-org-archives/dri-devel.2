Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F56EC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71B010E1BD;
	Mon, 10 Aug 2026 08:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QWIBzfNm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFB610E1BD
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:55:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C97B41346;
 Mon, 10 Aug 2026 08:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB121F000E9;
 Mon, 10 Aug 2026 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786352146;
 bh=plh47mpcPfUIJLelymJANfcnbveHGF9umWBdKBbdqQI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QWIBzfNm4gcLgSinzqlv101yy0Z+Snuh/GAQl+PRBzhAhEGYbs18wmSKqxRz1Z6p+
 LoOFCwyCQaDArgcmWjNN1tQ0M67SVYpwT4tmlPd3M8RXxtSKsFs7qCrAGB37wAcgcP
 Tu6nEI7E1NCb9lgOe0IAogbQg/UlO7C07npTOtuRvINBNsHlCnY1QJQJiBElKa5qOL
 EfxoafzvbSU7flBXIn/ywHPjzfsk+VqQhbDGYnU5cyqEcW/fgTwIjJnuAXV9UhyzpS
 eHrPkujv7pdPQrZY7zqX4OmSnMXRIDIqg1zReusvdL5/Jy2tODIMNFc+9+E0Q5sqf4
 EsJNjv95sL4Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] rust: bitmap: add contiguous area operations
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260810-chid-v4-3-c9f206fdcb97@nvidia.com>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
 <20260810-chid-v4-3-c9f206fdcb97@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 08:55:45 +0000
Message-Id: <20260810085546.5EB121F000E9@smtp.kernel.org>
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
- [Medium] The overflow check `align_mask.checked_add(self.len())?.checked_=
add(nbits)?` incorrectly rejects valid `next_zero_area_off` queries on 32-b=
it architectures when `self.len()` and `nbits` are large.
- [Medium] The assertion `start < self.len()` in `next_zero_area_off` panic=
s if `start =3D=3D self.len()`, which breaks iterators and empty bitmaps.
--

--- Patch [3]: [PATCH v4 3/5] rust: bitmap: add contiguous area operations =
---
commit cd8a17b1e3284bd61e474e6a67facb0e46c2ec8a
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: bitmap: add contiguous area operations

Add bindings for area operations on bitmaps. Each one is made safe by adding
some extra checks compared to the underlying C code (for example, checking
bounds) and with additional checks to catch likely erroneous usage if
CONFIG_RUST_BITMAP_HARDENED is on. Tests demonstrating the edge cases are
also included.

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index 0d481d761f2ac..a2557e9c5cfe0 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs

[ ... ]

> @@ -504,6 +504,138 @@ pub fn next_zero_bit(&self, start: usize) -> Option=
<usize> {
>              Some(index)
>          }
>      }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`=
, where the area plus
> +    /// `align_offset` is aligned to `align`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if n=
o such area fitting in
> +    /// the bitmap exists.
> +    ///
> +    /// The returned index plus `align_offset` is a multiple of `align`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is =
out of bounds.
> +    #[inline]
> +    pub fn next_zero_area_off(
> +        &self,
> +        start: usize,
> +        nbits: usize,
> +        align: Alignment,
> +        align_offset: usize,
> +    ) -> Option<usize> {
> +        bitmap_assert!(
> +            start < self.len(),

[Severity: Medium]
Does this assertion break iterators and empty bitmaps when
CONFIG_RUST_BITMAP_HARDENED is enabled?

If a caller iteratively searches for zero areas (e.g., start =3D area_index=
 +
nbits) and the last found area ends exactly at the bitmap boundary, the next
iteration will query with start =3D=3D self.len(). Also, querying an empty =
bitmap
(self.len() =3D=3D 0) with start =3D 0 would trigger this panic.

The underlying C function bitmap_find_next_zero_area_off() safely processes
start >=3D size by returning size, which the Rust code gracefully transform=
s to
None.

Could we use start <=3D self.len() here instead, similar to how the set() a=
nd
clear() functions allow end <=3D self.len()?

> +            "`start` must be < {}, was {}",
> +            self.len(),
> +            start
> +        );
> +
> +        let nr =3D u32::try_from(nbits).ok()?;
> +
> +        // The C alignment and end arithmetic must not overflow, or it c=
an read out of bounds.
> +        // Overflow is only possible on 32-bit.
> +        let align_mask =3D align.as_usize() - 1;
> +        align_mask.checked_add(self.len())?.checked_add(nbits)?;

[Severity: Medium]
Is this overflow check overly strict for 32-bit architectures?

If a caller requests a large contiguous area in a large bitmap, such as
self.len() =3D 0x7FFFFFFF and nbits =3D 0x7FFFFFFF, the sum of align_mask +
self.len() + nbits can exceed u32::MAX. This would cause the checked_add()
chain to fail and incorrectly return None instead of executing the search.

Since we only need to prevent the C function's end =3D index + nr calculati=
on
from wrapping around maliciously, and we know nbits <=3D self.len() makes n=
r at
most 0x7FFFFFFF, any wrap-around of index + nr on 32-bit would mathematical=
ly
result in an end value strictly less than index. The C code handles end < i=
ndex
safely by returning index, which Rust then correctly rejects since
index < self.len() is false.

Would a simpler check like "if nbits > self.len() { return None; }" be
sufficient to prevent malicious wrap-around while preserving valid searches
for large boundaries?

> +
> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with =
an out of bounds `start`
> +        // value and, given the overflow check above, never reads beyond=
 `self.len()` bits.
> +        let index =3D unsafe {
> +            bindings::bitmap_find_next_zero_area_off(
> +                self.as_ptr().cast_mut(),

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-chid-v4-0-=
c9f206fdcb97@nvidia.com?part=3D3
