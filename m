Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198BCCCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4BD10E783;
	Mon, 19 Oct 2026 04:37:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6AE910E785
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:37:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A819601FB;
 Mon, 19 Oct 2026 04:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4C71F000C4;
 Mon, 19 Oct 2026 04:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792384665;
 bh=JLiYDv+iV8ZTsAXWw6zS9tWEJ0XwIEI9q0xb2IWt+6k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A0HvTiXTTb+fgyfMjZrkP+c3qyHBg11kE0aaAViN9Yt8s9lNI1YoJZ4W9AU0WHbkx
 k7ncgPO7+HwHLGQKC9a6Mtk2WzuHonqaHUDsMIVF5Mw9QyA4GmRNhLTpn4Guw1Ljd4
 qDi0V3cdbo/xQhYyq3K0+UWUcgiVWAvrQkuH4NnVT7QLsM8eALdJv4guIX/p1Fv0p3
 sCMXsEECciqv6tvIpmQaZjvCVcMi3zP+PyNtUlIjp+vQnSfjnj5OfybhEznF9b7WDN
 0QNgSiGM2hVjJkQtkw619IZ1XZ75B86fMnVKIRV9MmEqBHu6NyMRUB0r2IXYUzSCzm
 q3E4wyrkF3QQQ==
Message-ID: <sashiko-outbox-176643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
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
In-Reply-To: <20261019-chid-v10-2-67de9180b4ed@nvidia.com>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-2-67de9180b4ed@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 04:37:43 +0000
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
- [Medium] rust: id_pool: panic in find_unused_id() on small or zero capaci=
ty pools
--

commit 018a4fbd0a161c3060c7581d4c4fd80bc70dcd41
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN

This commit stops rounding small capacities up to BitmapVec::MAX_INLINE_LEN
in IdPool::with_capacity() so that capacities smaller than MAX_INLINE_LEN,
including 0, can be used directly. It also updates IdPool::grow_request() to
grow to at least BitmapVec::MAX_INLINE_LEN.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 384753fe0e44a..7bb8bb89297f0 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -106,13 +106,8 @@ pub fn new() -> Self {
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

[Severity: Medium]
With the capacity floor removed, can calling IdPool::find_unused_id() on a
pool created with capacity 0 (or any capacity <=3D offset) trigger a panic =
when
CONFIG_RUST_BITMAP_HARDENED=3Dy is enabled?

In rust/kernel/id_pool.rs, IdPool::find_unused_id() passes offset directly =
to
Bitmap::next_zero_bit() without checking whether offset >=3D self.capacity(=
):

    pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>>=
 {
        // INVARIANT: `next_zero_bit()` returns None or an integer less tha=
n `map.len()`
        Some(UnusedId {
            id: self.map.next_zero_bit(offset)?,
            pool: self,
        })
    }

In rust/kernel/bitmap.rs, Bitmap::next_zero_bit() asserts that start is
strictly less than self.len():

    pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
        bitmap_assert!(
            start < self.len(),
            "`start` must be < {} was {}",
            self.len(),
            start
        );

When a pool is constructed via IdPool::with_capacity(0, flags) and a caller
invokes pool.find_unused_id(0) before growing the pool, self.len() is 0 and
start < self.len() fails, panicking under CONFIG_RUST_BITMAP_HARDENED=3Dy
instead of returning None. The same happens if a caller creates a small pool
(for example with capacity 1) and calls find_unused_id(1).

[ ... ]

>
>
>
>
>
>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-chid-v10-0=
-67de9180b4ed@nvidia.com?part=3D2
