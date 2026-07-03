Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965BEC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93E510F78C;
	Fri,  3 Jul 2026 10:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GDNmF+hf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4F610F78C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:30:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A778D44085;
 Fri,  3 Jul 2026 10:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB371F000E9;
 Fri,  3 Jul 2026 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783074652;
 bh=uOshgmVgQGaGftl6B40j022JjYgsv+BRIHBfyvfMth0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GDNmF+hfmj8LIeKYkqDFk0hT2y+UrN9vWXUdLriEaHA0NtNynADXXXqtNiugr0h+Q
 y4VRjuT2BupNXPeQ9pV4kWCJrm4BgDbR16wlFOWV3mccK+jdMHefIvFoUqqHjib7s7
 HKIm2Q0yIGaAgoddb7qfvRS2cNGJACumdvcENTccQf343uVBGPGqdVCZfg4IUOdRoc
 HPoYY+zr1U90JADQs53hGFdLKDnUFqcPk8+/pgeQkYq1GTQVTXLEjE5o7z08C6cK+1
 2pkU3P7RZvMAbZK8mUU8ruL2myBaF/rqeT7kumabqKLqtLqEZIiY2Oy3wnThzs98fF
 B7jAAJ+dgWXuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] rust: bitmap: add contiguous area operations
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260703-chid-v1-2-84fe8259e46e@nvidia.com>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-2-84fe8259e46e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:30:51 +0000
Message-Id: <20260703103052.4FB371F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Integer truncation in `Bitmap::copy_and_extend` leading to out-of-=
bounds memset in C.
--

commit 19918f0914fec684f788000700e6deb8bdb878e0
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: bitmap: add contiguous area operations

This patch adds bindings and helpers for area operations on bitmaps. It mak=
es
each operation safe by adding extra bounds checks compared to the underlyin=
g C
code. Additional checks are included to catch likely erroneous usage when
CONFIG_RUST_BITMAP_HARDENED is enabled.

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc2..f7290fa439d6f 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
[ ... ]
> @@ -497,6 +497,129 @@ pub fn next_zero_bit(&self, start: usize) -> Option=
<usize> {
>              Some(index)
>          }
>      }
[ ... ]
> +    #[inline]
> +    pub fn set_area(&mut self, start: usize, nbits: usize) {
> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits)
> +                .is_some_and(|end| end <=3D self.len() && end <=3D i32::=
MAX as usize),

[Severity: High]
This isn't a bug introduced by this patch, but given your note about bounds
checking and 32-bit limits, I noticed a pre-existing issue in
Bitmap::copy_and_extend() that might need similar treatment.

rust/kernel/bitmap.rs:Bitmap::copy_and_extend() {
    ...
    pub fn copy_and_extend(&mut self, src: &Bitmap) {
        let len =3D core::cmp::min(src.len(), self.len());
        // SAFETY: access to self and src is within bounds.
        unsafe {
            bindings::bitmap_copy_and_extend(
                self.as_mut_ptr(),
                src.as_ptr(),
                len as u32,
                self.len() as u32,
            )
        };
    }
}

Can this lead to an out-of-bounds memset in C?

A Bitmap can be created from a raw pointer using Bitmap::from_raw() without
u32::MAX length restrictions. If self.len() exceeds u32::MAX on 64-bit
systems, the self.len() as u32 cast will silently truncate the length.

If src.len() is smaller than the full length but larger than the truncated
length, count will be greater than size when passed to the C function
bitmap_copy_and_extend().

The C function calculates the byte delta for memset as:
bitmap_size(size) - copy * sizeof(long)

With a truncated size, this would subtract a larger byte count from a small=
er
byte count, underflowing to a huge size_t value. Could this cause a massive
out-of-bounds write and kernel panic?

> +            "Area `start..start + nbits` ({}..{}) must be within bounds =
{}",
> +            start,
> +            start.saturating_add(nbits),
> +            self.len()
> +        );
> +        // SAFETY: The area `start..start + nbits` is within bounds.
> +        unsafe { bindings::bitmap_set(self.as_mut_ptr(), start as u32, n=
bits as u32) };
> +    }
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-chid-v1-0-=
84fe8259e46e@nvidia.com?part=3D2
