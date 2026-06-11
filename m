Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E49CD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4F610F089;
	Thu, 11 Jun 2026 18:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ai9XWaeo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3830410E814
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:30:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 730EF600AA;
 Thu, 11 Jun 2026 18:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8A01F000E9;
 Thu, 11 Jun 2026 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781202651;
 bh=Tq9WlxyaX3hhKxGeqMBQiX/2lLF66I5lE34NLBYcw2g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ai9XWaeoxvL5A2wEXm729UqVMmIMZy4YEY3zTYb+R90b3ULWwMKflQpt+EHzG94Ce
 GTQl77PBptIh9sE5ASR/Obz7QEHx5kjznXAiDiSoGlr4QhTg+Gys8oupHuyO/X+W3z
 UDLTivtua7pRWzplMq8Wx7wwStstj/9BbjhVqD28vdeGRNTFrYI0OtkDHB6pjnKhuS
 +6W3lOr6F/RtZwM5VWxOxmlZzYoQHD2IAzej7rVZwi4jwN/MdmA74g7oef1lnv+mgZ
 kW9LKwXbpEwgApSndiTnLIQQ4Aulma6FlrzJJcGkXLBC5nmJR6FF/R27SzuhNLJd9P
 tAtiRifZFchHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/20] rust: io: implement a view type for `Coherent`
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260611-io_projection-v4-15-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-15-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:30:49 +0000
Message-Id: <20260611183050.CA8A01F000E9@smtp.kernel.org>
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
- [High] The safety documentation for `CoherentView::as_mut` and `as_ref` f=
ails to demand Rust's reference aliasing exclusivity, allowing Undefined Be=
havior.
--

commit 20e5ba166044275ffb7dbced6b142a0a7c1c896e
Author: Gary Guo <gary@garyguo.net>

Implement a CoherentView type which is a view of Coherent.

To be able to give out DMA handles, the view type contains both CPU and DMA
pointers, and the projection method projects both at once. Delegate most of
the Io implementation to SysMemBackend. Provide a method to erase the DMA
handle and give out a SysMem view, if the user does not need the dma_handle.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69..ab6504910e4f 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs

[ ... ]

> +impl<T: ?Sized> Copy for CoherentView<'_, T> {}
> +impl<T: ?Sized> Clone for CoherentView<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<'a, T: ?Sized> CoherentView<'a, T> {

[ ... ]

> +    /// Returns a reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   the returned reference is live.
> +    #[inline]
> +    pub unsafe fn as_ref(self) -> &'a T {

[Severity: High]
Since CoherentView implements Copy, callers can duplicate the view and call
this method multiple times. Does this safety contract adequately protect
against creating overlapping shared and mutable references?

Rust's aliasing rules consider it undefined behavior to create aliasing
mutable and shared references, even in single-threaded code without a data
race.

It seems the preconditions should explicitly require callers to ensure no
mutable references to the same memory region exist while the returned
reference is live.

> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &*self.cpu_addr.as_ptr() }
> +    }
> +
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
Similar to as_ref() above, does this safety contract prevent the creation of
aliasing mutable references?

Because the struct implements Copy and this method takes self by value retu=
rning
&'a mut T, a caller could copy the view and call as_mut() sequentially. The
safety contract only forbids racing with a read or write, which does not pr=
event
the immediate undefined behavior of having multiple overlapping &'a mut T
references.

Should the documentation be updated to demand Rust's reference aliasing
exclusivity?

> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D15
