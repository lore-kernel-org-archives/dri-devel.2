Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D61CC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8004510E3E6;
	Fri, 26 Jun 2026 15:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f5yNFkYj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B0710E3E6
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:05:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 087C6600C8;
 Fri, 26 Jun 2026 15:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4381F00A3A;
 Fri, 26 Jun 2026 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486319;
 bh=hIMH/CW8sOItdSGkkqGRNFq3zKeoOYtSzviJ3wvaV6g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f5yNFkYjMcVjwsSvo+vtFVjuuUE1LAQufFQR234cztX+uolEr7cxqx7FrGw+7wVoW
 XPllW9IUFmE0qH9JIr0baONau5lkDEHOnKriTcdHBB5IxvtGQjDvhABCWrn/P9TpJn
 pzNGVuK5HAmX1xdXvEMB/lu99mGlne1CEHGjotlGCE6l7KYLx27BaNILIaSTVRWufC
 QZDSiOqDKSqo2kQzFV2Co4o3CwvRho7zIF7CMCyZ5yfs90eKhUeOpXQ2vSWgF39Y/b
 6u8oq+Q90ayN5Aki6r+WQfIKNPSOnGugeaGoCqktGITF0KHU+sWksQn8aKkeyKHdPE
 KT+vKdAe9yOlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/20] rust: io: implement a view type for `Coherent`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:05:18 +0000
Message-Id: <20260626150519.4D4381F00A3A@smtp.kernel.org>
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
- [High] `CoherentView<'a, T>` automatically implements `Send` when `T: Syn=
c`, but provides an `as_mut()` capability to generate `&mut T`, allowing th=
read-safety bounds bypass.
- [High] `CoherentView::as_mut` consumes `self` by value on a `Copy` type a=
nd returns `&'a mut T`, but its safety documentation fails to require stric=
t exclusivity.
--

commit 12e6f6d7abcd0a26719f3c4f268f24a07774b118
Author: Gary Guo <gary@garyguo.net>

rust: io: implement a view type for `Coherent`

Implement a `CoherentView` type which is a view of `Coherent`. To be able
to give out DMA handles, the view type contains both CPU and DMA pointers,
and the projection method projects both at once.

Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
method to erase the DMA handle and give out a `SysMem` view, if the user
does not need the `dma_handle`.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69e..ab6504910e4f5 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs

[ ... ]

> @@ -1133,6 +1140,132 @@ unsafe impl Send for CoherentHandle {}
>  // plain `Copy` values.
>  unsafe impl Sync for CoherentHandle {}
> =20
> +/// View type for `Coherent`.
> +///
> +/// This is same as [`SysMem`] but with additional information that allo=
ws handing out a DMA handle.
> +pub struct CoherentView<'a, T: ?Sized> {
> +    cpu_addr: SysMem<'a, T>,
> +    dma_handle: DmaAddress,
> +}

[Severity: High]
Since SysMem<'a, T> automatically implements Send when T: Sync, CoherentView
also implements Send when T: Sync.

If T is !Send, can a caller move CoherentView to another thread and call
as_mut() to get a mutable reference? This appears to allow bypassing Rust's
concurrency guarantees and could lead to data races or memory corruption if
the type relies on thread-local invariants.

Note that this same pattern seems to pre-exist in Coherent<T> as well.

[ ... ]

> +    /// Returns a mutable reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   while the returned reference is live.
> +    #[inline]
> +    pub unsafe fn as_mut(self) -> &'a mut T {

[Severity: High]
Because CoherentView derives Copy and as_mut() takes self by value instead =
of
taking a mutable borrow, can a caller call as_mut() multiple times in
succession to create overlapping mutable references?

While the safety documentation requires callers to prevent races, it does
not explicitly require strict exclusivity. Could a caller sequentially use
two aliases without data races, believing they adhered to the safety
contract, but still trigger undefined behavior due to aliasing violations?

This documentation omission might also exist in the preexisting
Coherent::as_mut.

> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D15
