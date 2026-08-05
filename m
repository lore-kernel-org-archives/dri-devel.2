Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF2C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A25410EF08;
	Wed,  5 Aug 2026 15:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="clI16kA2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F60B10EEE4
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:46:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEDD040A80;
 Wed,  5 Aug 2026 15:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1761F00A3D;
 Wed,  5 Aug 2026 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785944786;
 bh=aJYinYe9eXqxWw8HSl8S3lWvFkOyc5xOhRpB5rBSP04=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=clI16kA2lTjbsz1Ei2Ztgp835aKbIp4ERcpGhtN42xC7bxeNQTQMY2Oeb6hHVBvC3
 271f7z5HC1beCv0WhxUlsZYlvxyLnoN+uEngalk2hYaRXluw8iu56K+Y9x4ISOzdeE
 /KIbe3VITdYOKktdFj9q87UzyyZ/7r2zMQIxLR8wlP0lFKuilYoz7SmZeQXgpvj2nT
 qp2ka7CP4IUoGUFhJlZvNv1lXV+hny48iShKfdZPvNAlRnxRmCn2C/mS6GO7DZZA/Z
 d202b52h/qZalBsVb49N2OHZ8QsOLS9ayjBu4QRlaxVHK+ItiSN3jTy50J7U+rm2Xk
 vMVHQXsm5DnfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260805145949.938505-6-phasta@kernel.org>
References: <20260805145949.938505-2-phasta@kernel.org>
 <20260805145949.938505-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:46:25 +0000
Message-Id: <20260805154626.5A1761F00A3D@smtp.kernel.org>
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
- [High] Calling Fence::is_signaled() from within a fence callback for the =
same fence will cause a deadlock.
- [High] FenceContext::drop unconditionally calls rcu_barrier(), which can =
lead to sleeping in atomic context panics and severe performance issues.
--

--- Patch [4]: [PATCH v9 4/5] rust: Add dma_fence abstractions ---
commit 38c478417a422309c2a228acac8f860a0f96dd34
Author: Philipp Stanner <phasta@kernel.org>

rust: Add dma_fence abstractions

This commit introduces abstractions for C's dma_fence to be used by Rust GPU
drivers. It implements DriverFence and Fence types to handle signaling,
sequence numbering, and callback registration.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> new file mode 100644
> index 0000000000000..e61b4b2d8b8cc
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs
[ ... ]
> +#[pinned_drop]
> +impl<T: FenceContextOps + Send + Sync> PinnedDrop for FenceContext<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // TODO:
> +        // It would be better if the fence context signals all forgotten=
 fences
> +        // itself. To do so, it would keep a list of unsignaled fences. =
That
> +        // list members would have to be pre-allocated (see
> +        // FenceCallback::new_fence_allocation()).
> +        if self.nr_of_unsignaled_fences.load(Relaxed) !=3D 0 {
> +            panic!("Forgotten fences in FenceContext.");
> +        }
> +
> +        rcu_barrier();

[Severity: High]
Can dropping a FenceContext in atomic context cause a panic here?=20

Because Rust drops objects implicitly when they go out of scope, a=20
FenceContext dropped in an atomic context (such as inside an interrupt=20
handler or under a spinlock) will trigger a 'sleeping in atomic context'=20
panic since rcu_barrier() blocks system-wide.

Even if dropped safely in process context, could waiting on a system-wide=20
RCU barrier during the destruction of every FenceContext cause severe=20
performance bottlenecks?

[ ... ]
> +    pub fn is_signaled(&self) -> bool {
[ ... ]
> +        // The fundamental reason is that the C backend currently does g=
uard
> +        // setting of the fence's signaled-bit with the fence's spinlock=
, but
> +        // reading is done locklessly.
> +        //
> +        // See commit c8a5d5ea3ba6a.
> +
> +        let _ =3D self.lock();
> +
> +        ret
> +    }
> +
> +    fn lock(&self) -> FenceGuard {
> +        let mut guard =3D FenceGuard {
> +            inner: self.as_raw(),
> +            flags: 0,
> +        };
> +
> +        // SAFETY: fence is valid because self is valid. flag_ptr is
> +        // merely a pointer to an integer, whose lifetime is tied to the=
 guard
> +        // object.
> +        unsafe { bindings::dma_fence_lock_irqsave(guard.inner, &raw mut =
guard.flags) };

[Severity: High]
Could this result in a deadlock if Fence::is_signaled() is called from with=
in=20
a fence callback?

When a fence is signaled, the C backend (dma_fence_signal_locked) acquires=
=20
the fence's spinlock and iterates over the registered callbacks, executing=
=20
them synchronously while holding the lock.

If a Rust FenceCallback implementation calls is_signaled() on that same fen=
ce,=20
it invokes self.lock() which will attempt to acquire the exact same spinloc=
k=20
via dma_fence_lock_irqsave(), leading to a non-recursive spinlock deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805145949.9385=
05-2-phasta@kernel.org?part=3D4
