Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68F4C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 22:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21E510F008;
	Wed,  5 Aug 2026 22:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dp7ulIMD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F202210F008
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 22:06:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5B6D60A5A;
 Wed,  5 Aug 2026 22:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF241F000E9;
 Wed,  5 Aug 2026 22:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785967588;
 bh=l3Wo2XYfshVaZ0rM98x9x4q56oduGHnV+UciN8vsgxc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dp7ulIMD9ngw+yc8BQPqS4aJckj6vhSSql24wV768ItQU01ok6WpQqRvacSf3cfKw
 2XbdkmjW2ZuJRiPuMKZ0XtOT+UUfSnV0aYWd7cb4zIAMVkbqgrx2nbbXiU4eO32cnI
 B1+f6prVtdvkxru09F7f7hjjMMaWkqVdUkpf77ggF0/lbP/6F7Ng4PrGJ91QQ1Qkg/
 Z8tJxIZxStL7etc9NJ+Z/Cn6V1Eb5BHMdzyIGeZzginuMJmk6z+umqeR1tFMEXIhWR
 Sfgf0cim28RrL9eJ/j6d08p6zCnzdv9priLTw6HOE3TYzT4pggz2B2qW6WQagCScMb
 r6mql1n8HLUdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rust: dma: add abstraction for the single-buffer
 streaming DMA API
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260805-dma-streaming-v1-2-03974c86b141@mailbox.org>
References: <20260805-dma-streaming-v1-0-03974c86b141@mailbox.org>
 <20260805-dma-streaming-v1-2-03974c86b141@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 22:06:27 +0000
Message-Id: <20260805220628.4CF241F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] StreamingCpuGuard unconditionally implements DerefMut, allowing sa=
fe Rust code to mutate DMA_FROM_DEVICE buffers.
- [High] Safe Rust code can bypass dma_sync_single_for_device by leaking St=
reamingCpuGuard, causing a hardware data race.
- [Medium] Panic in ContiguousBuffer::data() leaves the DMA buffer synced f=
or the CPU without creating a guard.
- [Low] Missing #[inline] annotations on small/forwarding methods in abstra=
ctions.
--

--- Patch [2]: [PATCH 2/3] rust: dma: add abstraction for the single-buffer=
 streaming DMA API ---
commit 5deae1f6c89c43e53f36e40c370843d948aa3422
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: dma: add abstraction for the single-buffer streaming DMA API

Add Streaming, a safe abstraction around dma_map_single_attrs(). Between
map and unmap the buffer belongs to the device, and the CPU may only access
it in between a dma_sync_single_for_cpu() / dma_sync_single_for_device()
pair.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 8a8af5ab7feb8..cbaf30a2de864 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -621,6 +630,389 @@ fn data(&mut self) -> &mut Self::Data {

[ ... ]

> +    pub fn for_cpu(&mut self) -> StreamingCpuGuard<'_, C::Data> {
> +        let dev =3D self.dev;
> +        let dma_addr =3D self.dma_addr;
> +        let direction =3D self.direction;
> +        let size =3D self.container.size();
> +
> +        // SAFETY: By the type invariants, `dev` is bound and `dma_addr`=
 denotes a live mapping of
> +        // `size` bytes established with `direction`, which is the range=
 synced here.
> +        unsafe {
> +            bindings::dma_sync_single_for_cpu(dev.as_raw(), dma_addr, si=
ze, direction.into())
> +        };
> +
> +        // INVARIANT: The buffer is now owned by the CPU, and dropping t=
he guard hands it back.
> +        StreamingCpuGuard {
> +            data: self.container.data(),

[Severity: Medium]
If the custom ContiguousBuffer::data() implementation panics, does this
leave the DMA buffer synced for the CPU without creating the guard? While
the kernel currently uses panic=3Dabort, this sequence mutates global state
(the DMA cache mapping) before a potentially panicking safe trait method
call, which could violate panic safety guarantees. Could data() be
evaluated before calling dma_sync_single_for_cpu()?

> +            dev,
> +            dma_addr,
> +            size,
> +            direction,
> +        }
> +    }

[ ... ]

> +    fn unmap(&mut self) {

[Severity: Low]
This isn't a bug, but according to the Rust kernel coding guidelines,
functions in abstractions that are small or directly forward to a C
binding should be annotated with #[inline]. Should this method have
an #[inline] annotation?

> +        // SAFETY: By the type invariants, `self.dev` is bound and the m=
apping is still live, with
> +        // exactly the address, size, direction and attributes it was cr=
eated with. Both callers
> +        // run this at most once, so the mapping cannot be torn down twi=
ce.
> +        unsafe {
> +            bindings::dma_unmap_single_attrs(
> +                self.dev.as_raw(),
> +                self.dma_addr,
> +                self.container.size(),
> +                self.direction.into(),
> +                self.dma_attrs.as_raw(),
> +            )
> +        };
> +    }

[ ... ]

> +impl<T: ?Sized> Drop for StreamingCpuGuard<'_, T> {
> +    fn drop(&mut self) {

[Severity: High]
Does relying on Drop to run dma_sync_single_for_device() allow safe Rust
code to bypass the synchronization? If a driver calls for_cpu() and then
passes the guard to core::mem::forget(), the mutable borrow ends without
Drop ever being called. The driver could then safely call submit(),
causing the device to interact with an unsynchronized buffer and breaking
the explicit type invariant.

> +        // SAFETY: By the type invariants, `self.dev` is bound and `self=
.dma_addr` denotes a live
> +        // mapping of `self.size` bytes established with `self.direction=
`, which is the range
> +        // synced here.
> +        unsafe {
> +            bindings::dma_sync_single_for_device(
> +                self.dev.as_raw(),
> +                self.dma_addr,
> +                self.size,
> +                self.direction.into(),
> +            )
> +        };
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for StreamingCpuGuard<'_, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {

[Severity: Low]
This isn't a bug, but this small trait implementation in an abstraction
might benefit from an #[inline] annotation to follow the Rust kernel
coding guidelines.

> +        self.data
> +    }
> +}
> +
> +impl<T: ?Sized> DerefMut for StreamingCpuGuard<'_, T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {

[Severity: Low]
This isn't a bug, but this trait implementation could also use an
#[inline] annotation.

[Severity: High]
Does this unconditional DerefMut implementation permit safe code to mutate
buffers mapped with DataDirection::FromDevice? According to the DMA API,
memory mapped with DMA_FROM_DEVICE must be treated as read-only by the CPU
to avoid dirtying cache lines, which could asynchronously evict and
overwrite the device's DMA writes in physical memory.

> +        self.data
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-dma-stream=
ing-v1-0-03974c86b141@mailbox.org?part=3D2
