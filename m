Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE56CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F8710F9A7;
	Mon,  8 Jun 2026 20:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="loRbYh+h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33F010F9A7
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:18:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8326640801;
 Mon,  8 Jun 2026 20:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258E01F0089D;
 Mon,  8 Jun 2026 20:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780949911;
 bh=H39lqrdjBjLU5AlmwvRqMP1dgScgMjlGWS/4/l3fnQE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=loRbYh+hzEDTl0EE5PPipVoPBVRTpDTXErTSTRnTVdxCZfoL51W9O2w4wFQB+EG02
 aHoeQocNJF3dBrZFViYMIUuFuLwvvzH7YhNg343yD/8nkKgmmmd3MwLhC55L6lmXg+
 1jGFVkYnGIiUVUdqX8inbZ/LPIdlz9AT3g1lpUUO6AWmY3YI4Fmv/KuAMkMgiGUfEV
 StbovqNAsDEtpThUf5f2n8gWuiyxFz+cUAWq7B2c8mCitBzkyj45QDvl+C2tGNOIXF
 Z+OeFMLFbIig57NO2fCD1V89YYuOyZMXBmdmT6e2bMXzmrqwY7eAv5A0wfUOKP7qRI
 rlcGgA2EUs8Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/19] rust: io: implement a view type for `Coherent`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260608-io_projection-v3-14-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-14-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:18:30 +0000
Message-Id: <20260608201831.258E01F0089D@smtp.kernel.org>
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
- [High] `CoherentView::as_mut` and `Coherent::as_mut` return mutable refer=
ences without requiring uniqueness in their safety contracts, leading to po=
tential UB.
- [Medium] Missing `?Sized` bound on `CoherentView` implementation block.
--

commit 0b0ac87fb8d6dae9b55b873481974c835edfff5a
Author: Gary Guo <gary@garyguo.net>

rust: io: implement a view type for Coherent
   =20
This commit implements a CoherentView type as a view of Coherent. It
contains both CPU and DMA pointers and delegates most of the Io
implementation to SysMemBackend.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69e..970a667b9be28 100644
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
> +
> +impl<T: ?Sized> Copy for CoherentView<'_, T> {}
> +impl<T: ?Sized> Clone for CoherentView<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<'a, T> CoherentView<'a, T> {

[Severity: Medium]
Since generic type parameters implicitly require Sized in Rust, this impl
block omits the ?Sized bound on T. Does this prevent dynamically-sized
views (like CoherentView<'_, [u8]>) from using the methods defined here
(as_sys_mem, dma_handle, as_ref, as_mut)?

> +    /// Erase the DMA handle information and obtain a [`SysMem`] view of=
 the same memory region.
> +    #[inline]
> +    pub fn as_sys_mem(self) -> SysMem<'a, T> {
[ ... ]
> +    /// Returns a mutable reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   slice is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   while the returned slice is live.
> +    #[inline]
> +    pub unsafe fn as_mut(self) -> &'a mut T {

[Severity: High]
Since CoherentView implements Copy, a caller could copy the view and call
as_mut(self) multiple times to yield multiple overlapping &'a mut T
references to the exact same memory. Does this same issue apply to
Coherent::as_mut when returning a mutable reference from a shared borrow?

Because the documented Safety contracts only forbid data races and omit
the requirement that callers must uphold Rust's strict aliasing rules for
uniqueness of mutable references, could following this contract still lead =
to
undefined behavior?

> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D14
