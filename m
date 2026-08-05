Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9610CC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 22:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B088610E10A;
	Wed,  5 Aug 2026 22:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JXxpTTZ9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000A710E10A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 22:05:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79B7341B6D;
 Wed,  5 Aug 2026 22:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1008D1F000E9;
 Wed,  5 Aug 2026 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785967507;
 bh=6QQn9u1mFekYJZiqkC6HkNHytPZF3t4oEDdZR6NY+2g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JXxpTTZ9efrYG1nZkErJwsOzyw+FPNs1DG21uZevckNWvuo2MUU0a5gwuOfpAWal/
 g2zcTFDrk60Ue6rG/aA4Q+pf3ffgTzfH+JxzzCnfRcrq4LqMOwsg8ZNbI2+ZezPdSK
 KjLo1D65vK/HZ9oK5oSHH/4XJa087TiiZdDm3iUoZ6ZrCxn5okfPk3c9olAtM8uv52
 oZmkRAT56EFGgWkbD79O3B5AEJaW2y2KKJSXk5e6+/10bqpWzGFrpXBje3Nz/FPzOB
 GISVAxh8kT9lGSTQm7H/EPsOJqUCBWuBumZ2Rr1nik5h0zAamb2HIGpZc6p9P7cSOk
 YVTAd0jIpkkRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] rust: dma: add ContiguousBuffer trait for streaming
 DMA storage
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-dma-streaming-v1-1-03974c86b141@mailbox.org>
References: <20260805-dma-streaming-v1-0-03974c86b141@mailbox.org>
 <20260805-dma-streaming-v1-1-03974c86b141@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 22:05:06 +0000
Message-Id: <20260805220507.1008D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `size()` method creates a shared reference to potentially muta=
ting DMA memory, causing Undefined Behavior.
- [Medium] `ContiguousBuffer` implementation for `KBox<T>` implicitly requi=
res `T: Sized`, preventing the mapping of dynamically sized buffers.
- [Low] Missing `#[inline]` annotations on small trait methods in an abstra=
ction.
--

--- Patch [1]: [PATCH 1/3] rust: dma: add ContiguousBuffer trait for stream=
ing DMA storage ---
commit 9463792a46877c9a52666dde64c8d1a545e696f7
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: dma: add ContiguousBuffer trait for streaming DMA storage

This commit introduces the ContiguousBuffer trait to describe backing stora=
ge
that can be mapped via the streaming DMA API. It also implements this trait
for KBox<T> to guarantee physically contiguous memory allocated via kmalloc=
().

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69e..8a8af5ab7feb8 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs

[ ... ]

> +// SAFETY: `KBox` allocates via `kmalloc()`, which returns a single phys=
ically contiguous,
> +// DMA-safe region in the kernel's linear mapping. All three methods des=
cribe that allocation.
> +unsafe impl<T: FromBytes + AsBytes> ContiguousBuffer for KBox<T> {

[Severity: Medium]
Does this implementation unintentionally exclude dynamically sized buffers
like KBox<[u8]>?

Since T implicitly requires Sized here, it restricts the implementation to
statically sized types, despite the ContiguousBuffer trait allowing
type Data: ?Sized. Should this include the ?Sized bound?

> +    type Data =3D T;
> +
> +    fn ptr(&mut self) -> *mut c_void {

[Severity: Low]
This isn't a bug, but according to the Rust subsystem guidelines, should
small methods in abstractions, such as ptr(), size(), and data(), be
annotated with #[inline]?

> +        let ptr =3D &raw mut **self;
> +        ptr.cast()
> +    }
> +
> +    fn size(&self) -> usize {
> +        const {
> +            assert!(
> +                core::mem::size_of::<T>() > 0,
> +                "It doesn't make sense to map a ZST for DMA"
> +            );
> +        }
> +
> +        core::mem::size_of_val(&**self)

[Severity: High]
Does this expression create a shared reference to potentially mutating DMA
memory?

Calling core::mem::size_of_val(&**self) implicitly calls deref() and creates
a shared reference (&T) to the underlying allocation. If the device is
actively modifying the buffer during a DMA operation, could materializing
this shared reference violate Rust's aliasing rules and cause Undefined
Behavior?

Since T is implicitly Sized in this implementation, can this just use
core::mem::size_of::<T>() to evaluate the size purely at compile time witho=
ut
creating hazardous references?

> +    }
> +
> +    fn data(&mut self) -> &mut Self::Data {
> +        self
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-dma-stream=
ing-v1-0-03974c86b141@mailbox.org?part=3D1
