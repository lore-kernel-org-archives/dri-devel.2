Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA68CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8A0112587;
	Fri, 16 Oct 2026 02:04:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B301511255F
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:04:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D9C743F8D;
 Fri, 16 Oct 2026 02:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B95A1F000C4;
 Fri, 16 Oct 2026 02:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792116250;
 bh=FdcxFEgwdi/jPH2odXcF0/cWQyZfYLZUXFYMLgg4+hg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m95yRK1Kzpql9elHQ1PS0ZaWk51AoTopIjkKU1g98fPc+7OfwMngviuK+APm206Cc
 506q7RmMWl0yWcAmti7ugnNUJ52oKeaVLPu8qvxWKm6XXZsL0R5J+J30iI0m5K/HB6
 YVam613WRCQLgacOPML3UaVFjH3qP/2BwD2TAQNnd+/9h7Ttc7GyCiofBy1ubooEHD
 H4UX9ShiD2T9Jc9OrhfXS6RLxnbveEu9+Fa9BntPxYrS9i0xS0mRNuHNbvAFfpd217
 Me8EO5l1gKNcSV9lhJTXFNA8/jSR7ClmYSqH+5lxYmKr9o32H8sjIIJ82pyAWixM7r
 H4ztFvAV0hMjA==
Message-ID: <sashiko-outbox-173611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] rust: alloc: add ArrayVec
To: "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, 
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-b4-nvkv-v4-2-e8b92b91aa5b@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-2-e8b92b91aa5b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 02:04:09 +0000
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
- [Low] rust: missing #[inline] on try_push_init and extend_from_slice
--

commit 83efda44f14b36e4aab4040f689c08677c6c23f1
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: alloc: add ArrayVec

Add a fixed capacity vector backed by [MaybeUninit<T>; N]. The ArrayVec
is also initializable with a closure, returning an Init instance, to
avoid constructing it on the stack.

> diff --git a/rust/kernel/alloc/arrayvec.rs b/rust/kernel/alloc/arrayvec.rs
> new file mode 100644
> index 0000000000000..8793adf4d27b7
> --- /dev/null
> +++ b/rust/kernel/alloc/arrayvec.rs

[ ... ]

> +    /// Appends an element to the back of the [`ArrayVec`] by initializi=
ng it in place.
> +    ///
> +    /// Unlike [`ArrayVec::push_init`], the initializer may be fallible.=
 If the [`ArrayVec`] is
> +    /// full, the original initializer `init` is handed back in [`TryPus=
hInitError::Full`]. If the
> +    /// initializer itself fails, its error is returned in [`TryPushInit=
Error::InitError`].
> +    pub fn try_push_init<I, E>(&mut self, init: I) -> Result<(), TryPush=
InitError<I, E>>
> +    where
> +        I: Init<T, E>,
> +    {
> +        let Some(slot) =3D self.spare_capacity_mut().first_mut() else {

[Severity: Low]
This isn't a bug, but is try_push_init() missing an #[inline] attribute?
The Rust subsystem coding guidelines state that small functions in abstract=
ions
should be annotated with #[inline].

[ ... ]

> +    /// Appends a clone of each element in `slice` to the back of the [`=
ArrayVec`].
> +    ///
> +    /// Fails with [`EINVAL`] if `slice` is longer than the remaining ca=
pacity.
> +    pub fn extend_from_slice(&mut self, slice: &[T]) -> Result
> +    where
> +        T: Clone,
> +    {
> +        let Some(dst) =3D self.spare_capacity_mut().get_mut(..slice.len(=
)) else {

[Severity: Low]
This isn't a bug, but is extend_from_slice() also missing an #[inline]
attribute? The Rust subsystem coding guidelines state that small functions =
in
abstractions should be annotated with #[inline].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-b4-nvkv-v4=
-0-e8b92b91aa5b@nvidia.com?part=3D2
