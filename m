Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F55DCA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9532010F14D;
	Wed, 30 Sep 2026 02:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mudlmiZQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE5D10F14D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:51:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AADF9600D4;
 Wed, 30 Sep 2026 02:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0895F1F000FF;
 Wed, 30 Sep 2026 02:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790736698;
 bh=M4uNhA6ZEntvpM6Wv4h/4tea+cV0nmJq0bkOMbGyKKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mudlmiZQWj+sNkjBsDvVolVpnOv+o+6DygAiGTjZQRhetAUdblzKJ2akX4ptkCt3l
 A6YCBHSKmafMhswKxsaleAjSJresm74AuHgrDaBlQB2iP6KcTiOja1j2TGEjjfguxc
 yJbvxGbFTmFau8gwq/18opx5AfCuuLmV5w1iVCN5hXkCNS29k+JPQqNO6zBtBinXif
 P7+UFUZpNyyi931ONQIGPm+syS27mPpNr3mJSerMbhmfXSk7uikfqSCbMsBFk4gaJo
 3uFmT3Jd4M3Xn8U34dJc6MQmUj1hcH7SWeKiD0BXOSSpbH123lXHC+QjvCFY/xhJKt
 49xBSe32EFihg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/9] rust: id_pool: add contiguous ID reservation
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, gary@garyguo.net
In-Reply-To: <20260930-chid-v9-7-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-7-0d6cca376cff@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 02:51:37 +0000
Message-Id: <20260930025138.0895F1F000FF@smtp.kernel.org>
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
- [High] rust: id_pool: reserve_ids() and find_unused_id() panic when offse=
t >=3D capacity
--

commit aa26fdd2bd4ce814afc1e6755fd4a71b9333439f
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: add contiguous ID reservation

Add `IdPool::reserve_ids` which allocates a contiguous range with the
given offset, count, and alignment.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 384753fe0e44a..06a4c71c4c6c9 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs

[ ... ]

> @@ -240,6 +246,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> O=
ption<UnusedId<'_>> {
>      pub fn release_id(&mut self, id: usize) {
>          self.map.clear_bit(id);
>      }
> +
> +    /// Reserves a contiguous area of `count` IDs at or after `offset`.
> +    ///
> +    /// The start of the returned area is a multiple of `align`.
> +    ///
> +    /// Returns the reserved range upon success, or [`None`] if no such =
area could be found.
> +    #[inline]
> +    #[must_use]
> +    pub fn reserve_ids(
> +        &mut self,
> +        offset: usize,
> +        count: NonZero<usize>,
> +        align: Alignment,
> +    ) -> Option<Range<usize>> {
> +        let start =3D self.map.next_zero_area(offset, count, align)?;

[Severity: High]
Does this code panic when offset is greater than or equal to pool.capacity(=
)?

If a caller attempts to reserve an ID in an IdPool where the requested
offset is greater than or equal to pool.capacity(), IdPool::reserve_ids()
passes offset directly to BitmapVec::next_zero_area() without bounds valida=
tion.

This can trivially occur if a caller instantiates an empty pool
(IdPool::with_capacity(0)) or resumes searching for an ID by passing
offset =3D last_id + 1 when last_id was the last available ID.

The underlying BitmapVec::next_zero_area() function calls
next_zero_area_off() in rust/kernel/bitmap.rs, which contains a
bitmap_assert!(start < self.len()) that expands to a hard assert! under
CONFIG_RUST_BITMAP_HARDENED, leading to a kernel panic (denial of service).

Since IdPool is documented to return None to prompt a grow_request
when no IDs are available, failing to handle offset >=3D self.capacity()
gracefully breaks the resizing API and causes panics on legitimate resource
pool usage patterns.

It appears IdPool::find_unused_id() also shares this behavior when calling
self.map.next_zero_bit(offset)? without bounds checking.

> +        self.map.set(start, count);
> +        Some(start..start + count.get())
> +    }
> +
> +    /// Releases a contiguous area of IDs.
> +    #[inline]
> +    pub fn release_ids(&mut self, range: &Range<usize>) {
> +        if let Some(nbits) =3D NonZero::new(range.len()) {
> +            self.map.clear(range.start, nbits);
> +        }
> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-chid-v9-0-=
0d6cca376cff@nvidia.com?part=3D7
