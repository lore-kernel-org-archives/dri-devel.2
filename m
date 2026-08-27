Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98180C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00DB10EEF4;
	Thu, 27 Aug 2026 07:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wa4jiXUg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E4810EEDC
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:41:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 92B02600D0;
 Thu, 27 Aug 2026 07:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED811F000E9;
 Thu, 27 Aug 2026 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787816508;
 bh=BDZEHW6vwP2m4KsmF1PQ35psZOW8RmTbccykiQgIuAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wa4jiXUgPZA3uJvEkb7DZjPMdjmohHhlsp91Oi7T9XYlNja9cYr235mthzvHApSZi
 T2rXI1Kc5o+51OtxSOMb41XVUpo+zy8hvx5YRQRSZu3jwBlHiNtmJ6pH8erzZSqSU2
 f9XCxTed7jno6Ox/dUVwjHFzAmApa59+KwWL4msWnbBj0rPkEkl1YTOxzdSMte6KO6
 p+sur1Zrh7D3gBAwFm4RK/WYf8kRKx2Qlzk+U0kUi7YjU9EGDmSBpWFDOm5ElqYYCa
 xH74nKw32eihctwpEMsfPgsC61eoFnAfic9OK8huzf8dTP8r0B18qnyMtqXETTjHm1
 EnFGRVNgWZnbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/12] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-chid-v8-11-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-11-bc74c77d0214@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:41:47 +0000
Message-Id: <20260827074147.EED811F000E9@smtp.kernel.org>
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
- [High] Calling `find_unused_id(0)` or `reserve_ids(0, ...)` on an `IdPool=
` initialized with a capacity of 0 triggers a kernel panic when `CONFIG_RUS=
T_BITMAP_HARDENED` is enabled.
--

commit c0cd93bbf9f36768f04bc377021b9e32ae0dce05
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN

This commit modifies IdPool::with_capacity to stop rounding the capacity up
to BitmapVec::MAX_INLINE_LEN. This allows explicitly creating pools with 0
capacity, and adjusts grow_request and shrink_request to handle the new flo=
or.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 06a4c71c4c6c9..4f329249df9d0 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -112,13 +112,8 @@ pub fn new() -> Self {
>      }
> =20
>      /// Constructs a new [`IdPool`] with space for a specific number of =
bits.
> -    ///
> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_=
LEN`].
> -    ///
> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>      #[inline]
>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, A=
llocError> {
> -        let num_ids =3D usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
>          let map =3D BitmapVec::new(num_ids, flags)?;
>          Ok(Self { map })
>      }

[Severity: High]
Does allowing a capacity of 0 here introduce a kernel panic during standard
allocations if CONFIG_RUST_BITMAP_HARDENED is enabled?

If a caller attempts to allocate an ID on a 0-capacity pool using patterns =
like
pool.find_unused_id(0) or pool.reserve_ids(0, ...), the call delegates dire=
ctly
to the underlying bitmap without its own bounds check:

IdPool::find_unused_id() {
    Some(UnusedId {
        id: self.map.next_zero_bit(offset)?,
        pool: self,
    })
}

This passes offset=3D0 to Bitmap::next_zero_bit(), which contains an assert=
ion
that start < self.len(). Since 0 < 0 is false on a 0-capacity pool, it pani=
cs
immediately instead of gracefully returning None to prompt a grow_request().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-chid-v8-0-=
bc74c77d0214@nvidia.com?part=3D11
