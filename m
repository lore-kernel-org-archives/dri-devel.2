Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF44ACA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F77310E906;
	Mon, 28 Sep 2026 08:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wd+2AKht";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D12A10E905
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:51:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3620060AB9;
 Mon, 28 Sep 2026 08:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A159E1F00898;
 Mon, 28 Sep 2026 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790585470;
 bh=OP6AAf+CPFjUDg5EA7Hut+rH1BWV4J9s+VSYbD/7DhU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wd+2AKhtFRX5gpd4T0Pu39QZg581zxyJK+Th0a5UsQ8VDBZ8hD0dk37B/J7/AWjlh
 eYBMpUx7AYwn5luxy2my81tLgcEDrQIpLsarvo83ezuNaRFSBkClbuVLTrcmj3y+N6
 lroyXMxSxHQ3x71/GhbD7PUQYlQcfTCc3LgU1qKqjoic4HHYn+M17sTilJ9j4HWgaq
 QF88Rqz6AIRoNTAllbUYGJX+fqpm5BMKv2IBju4EnMtMDhlSScrOT9UZSI5gK8Tv2I
 zf+fy8RgRNWZ9FFxkLtZOF1uxGaWAacV4FII1pXhQ1gQPSMmu2VPlMRi3xZziAq52W
 H13NGRelgbzWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] rust: alloc: add ArrayVec
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, gary@garyguo.net, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260928-b4-nvkv-v3-3-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-3-f04504c262c2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:51:10 +0000
Message-Id: <20260928085110.A159E1F00898@smtp.kernel.org>
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
- [Low] rust: alloc: missing #[inline] on small ArrayVec methods
--

commit 272001023e1b94a98c5055e880db10e4aff13e9a
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: alloc: add ArrayVec

Adds a fixed capacity vector backed by an array of uninitialized memory. The
ArrayVec is also initializable with a closure to avoid constructing it on
the stack, which is useful for small varying size arrays on the stack or
larger ones initialized into caller-provided memory.

> diff --git a/rust/kernel/alloc/arrayvec.rs b/rust/kernel/alloc/arrayvec.rs
> new file mode 100644
> index 0000000000000..4172a982e4775
> --- /dev/null
> +++ b/rust/kernel/alloc/arrayvec.rs
[ ... ]
> +    /// Appends an element to the back of the [`ArrayVec`].
> +    ///
> +    /// Fails when the [`ArrayVec`] is full, handing the element back in=
 [`PushError`].
> +    pub fn push(&mut self, v: T) -> Result<(), PushError<T>> {

[Severity: Low]
The rust subsystem coding guidelines recommend that small functions in
abstractions like the kernel crate be annotated with #[inline]. Since push
is a trivial wrapper around try_push_init, should it have an #[inline]
annotation to avoid sub-optimal inlining?

> +        self.try_push_init(v)
> +            .map_err(|PushInitError::Full(v)| PushError(v))
> +    }
> +
> +    /// Appends an element to the back of the [`ArrayVec`] by initializi=
ng it in place.
> +    ///
> +    /// Fails with [`FullError`] when the [`ArrayVec`] is full.
> +    pub fn push_init(&mut self, init: impl Init<T>) -> Result<(), FullEr=
ror> {

[Severity: Low]
Similarly, push_init is a trivial wrapper around try_push_init. Would it be
appropriate to add an #[inline] annotation here as well?

> +        self.try_push_init(init)
> +            .map_err(|PushInitError::Full(_)| FullError)
> +    }
[ ... ]
> +    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capa=
city of the [`ArrayVec`].
> +    fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {

[Severity: Low]
Since spare_capacity_mut is a small internal helper returning a slice,
should it also be annotated with #[inline]?

> +        // PANIC: `len` never exceeds `N` by the type invariants.
> +        &mut self.data[self.len..]
> +    }
> +}
[ ... ]
> +impl<T, const N: usize> Borrow<[T]> for ArrayVec<T, N> {
> +    fn borrow(&self) -> &[T] {

[Severity: Low]
This trait method is a one-line wrapper around as_slice. Does it need an
#[inline] annotation following the coding guidelines?

> +        self.as_slice()
> +    }
> +}
[ ... ]
> +impl<'a, T, const N: usize> IntoIterator for &'a ArrayVec<T, N> {
> +    type Item =3D &'a T;
> +    type IntoIter =3D slice::Iter<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {

[Severity: Low]
This trait method is a one-line wrapper around iter. Should an #[inline]
annotation be added here?

> +        self.iter()
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-nvkv-v3=
-0-f04504c262c2@nvidia.com?part=3D3
