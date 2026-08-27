Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B05BC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C6810EED7;
	Thu, 27 Aug 2026 07:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MpZVu+hT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 102ED10EED7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:43:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 586C2600D0;
 Thu, 27 Aug 2026 07:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2241F000E9;
 Thu, 27 Aug 2026 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787816589;
 bh=vp3nGe964DbCfAeNt9KBjiqyMe9sCec5kxQ7uxk9Ktk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MpZVu+hTj2JDMAbgWMe51PosCXDpnwHhZa5z0LK0gnSu3FE8rO/Ev5MOEtvhFSWSu
 21EZEsoyKJ3qBOq4rPNzSV/MLKF2p4Nk77+rnPSIlbCfIZQWuwRd79GW65ThLupV/H
 daRlEkqQ7W75Xa00M2ZkG2OJd087PdrnPSR0x1CkLdXgkAasSdxARtGGqEyrba7Y8n
 UbLJOFTrqJ4SJPaXcmnKBMR5BFh9IwvUeT6qiWZJPxqohuMooxyj+VM8sbs92fYPmz
 HXRK74oZbfhrBnqSUptQsphfPOIbZvqhUGUW8mO38D72/7A2zprOxxnusItjpYwd4F
 q8yoIpf9ISfcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/12] rust: bitmap: add contiguous area operations
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260827-chid-v8-9-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-9-bc74c77d0214@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:43:08 +0000
Message-Id: <20260827074308.CB2241F000E9@smtp.kernel.org>
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
- [Medium] Overly strict bounds check in `next_zero_area_off` causes unwarr=
anted panics for valid edge cases when `CONFIG_RUST_BITMAP_HARDENED` is ena=
bled.
--

commit 9d58aea77dca5a824882cabebc4724be42a07915
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: bitmap: add contiguous area operations

This commit introduces bindings for contiguous area operations on bitmaps,
specifically next_zero_area_off(), next_zero_area(), set(), and clear().
It adds safety bounds checking that can be hardened via
CONFIG_RUST_BITMAP_HARDENED, along with KUnit tests for these operations.

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index df5505ec7a965..23c2b43a98acf 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs

[ ... ]

> @@ -525,13 +529,159 @@ pub fn next_zero_bit(&self, start: usize) -> Optio=
n<usize> {
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
> +        nbits: NonZero<usize>,
> +        align: Alignment,
> +        align_offset: usize,
> +    ) -> Option<usize> {
> +        bitmap_assert!(
> +            start < self.len(),
> +            "`start` must be < {}, was {}",
> +            self.len(),
> +            start
> +        );

[Severity: Medium]
When CONFIG_RUST_BITMAP_HARDENED is enabled, does this overly strict bounds
check cause unwarranted panics for valid edge cases?

Calling next_zero_area_off() (or its wrapper next_zero_area()) on an empty
BitmapVec (length 0) will panic immediately because 0 < 0 is false.
Additionally, standard iteration loops that update start to area_start + nb=
its
will panic on their final check if the previous area ended exactly at the
bitmap boundary (start =3D=3D self.len()).

The underlying C implementation bitmap_find_next_zero_area_off() safely
handles start >=3D self.len() and returns an out-of-bounds index, which this
Rust wrapper correctly turns into a None return. Could this assertion be
relaxed to start <=3D self.len() to avoid these spurious panics?

> +
> +        let nr =3D u32::try_from(nbits.get()).ok()?;
> +        let align_mask =3D align.as_usize() - 1;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-chid-v8-0-=
bc74c77d0214@nvidia.com?part=3D9
