Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC169C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA0C10F6B6;
	Fri,  3 Jul 2026 07:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VhXBFkrM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A91010F6B6
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:45:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E83044169F
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB5E1F00A3D;
 Fri,  3 Jul 2026 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783064714;
 bh=V9rBl/YNeSLRGqMN7f8xZFnLN+Pqa/1p10115WkDsFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VhXBFkrM1tL/pgnKwEEVerG+kgXK1uGsPn2z3sDZkml5ckEZIU3Z4jHuEPxX1e54t
 XRIaBv/6jqCz2bdJEn+E4b1UcfzZDiJH2goxC4ufQFgZlMnlewRL2sB/C1Ly81P1gr
 AOtTyVqxYHNba4iCATdE6dTde82+rPDdOzgxCv2kJqZRhg97NJMG/bt/BZnKq10KDV
 zCUq5L1726rT0ZZ7Lcb6Hgy1RJehTYvkWfmJEOQh+9GuxML7/RrEXURoyn7+aANAqd
 6faCRIBdpDqcJDLKldcCbRc9UVhIAmtvtWiQ33FNqEi8/oHLZGdXD1+JHI2Um5886+
 dqriqEawZmLbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703073141.3962604-6-phasta@kernel.org>
References: <20260703073141.3962604-2-phasta@kernel.org>
 <20260703073141.3962604-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 07:45:13 +0000
Message-Id: <20260703074514.9CB5E1F00A3D@smtp.kernel.org>
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
- [High] Lifetime erasure via `ForeignOwnable` or `core::mem::forget` on `D=
riverFence` leads to a Use-After-Free of `FenceCtx`.
- [Medium] `DriverFence::signal` and `DriverFence::drop` omit the required =
`dma_fence_begin_signalling()` and `dma_fence_end_signalling()` lockdep ann=
otations.
- [Low] `FenceCbRegistration`'s `# Invariants` documentation is outdated an=
d lacks the mandatory `// INVARIANT:` comment upon construction.
--

commit d72bac0aa1194434de7bc7000b2d5a50bb882d68
Author: Philipp Stanner <phasta@kernel.org>

rust: Add dma_fence abstractions

This commit adds Rust abstractions for the dma_fence subsystem, providing
DriverFence and Fence types to cleanly decouple fence issuers and consumers
while ensuring safe reference counting and signaling.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs
[ ... ]
> +/// # Invariants
> +///
> +/// If callback is Some, then cb is registered with the fence and the
> +/// callback hasn't been invoked yet. If None, the callback has been inv=
oked
> +/// or the fence was already signaled when we tried to register.
> +#[pin_data(PinnedDrop)]
> +pub struct FenceCbRegistration<T: FenceCb + 'static> {
> +    #[pin]
> +    callback_foreign: Opaque<bindings::dma_fence_cb>,
> +    callback: ManuallyDrop<T>,

[Severity: Low]
Is this documentation accurate?

The invariants description references Some and None for the callback
field, but the field is defined as ManuallyDrop<T> rather than an Option.

[ ... ]
> +    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a
> +    where
> +        T: 'a,
> +    {
> +        try_pin_init!(Self {
> +            // We need to fully initialize the fence because after
> +            // dma_fence_add_callback() ran, the callback might immediat=
ely
> +            // get invoked.
> +            callback: ManuallyDrop::new(callback),

[Severity: Low]
Are we missing the mandatory INVARIANT comment here?

The Rust subsystem guidelines require an explicit INVARIANT comment when
constructing a struct with an Invariants documentation section, but it
appears to be omitted here.

[ ... ]
> +    pub fn signal(self, res: Result) {
> +        let fence =3D self.as_raw();
> +        let mut fence_flags: usize =3D 0;
> +        let flag_ptr =3D &raw mut fence_flags;
> +
> +        // SAFETY: fence is valid because self is valid. flag_ptr is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        unsafe { bindings::dma_fence_lock_irqsave(fence, flag_ptr) };
> +        // SAFETY: fence is valid because self is valid. The lock must be
> +        // held, which we acquired directly above.
> +        if !unsafe { bindings::dma_fence_test_signaled_flag(fence) } {
> +            if let Err(err) =3D res {
> +                // SAFETY: fence is valid because self is valid. The fen=
ce
> +                // must not have been signaled yet, which we check direc=
tly above.
> +                unsafe { bindings::dma_fence_set_error(fence, err.to_err=
no()) };
> +            }
> +            // SAFETY: fence is valid because self is valid. The lock mu=
st
> +            // be held, which we acquired above.
> +            unsafe { bindings::dma_fence_signal_locked(fence) };
> +        }
> +        // SAFETY: fence is valid because self is valid. flag_ptr is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        // The lock must be held, which we acquired above.
> +        unsafe { bindings::dma_fence_unlock_irqrestore(fence, flag_ptr) =
};
> +    }

[Severity: Medium]
Should this manual signaling path include lockdep annotations?

By open-coding the fence signaling using dma_fence_lock_irqsave() and
dma_fence_signal_locked(), this function omits the
dma_fence_begin_signalling() and dma_fence_end_signalling() calls used in
the equivalent C dma_fence_signal() function.

Without these annotations, lockdep cannot track cross-release dependencies
during fence signaling, which might lead to false negatives when detecting
deadlocks between fence signaling and wait paths.

[ ... ]
> +unsafe impl<'b, T: Send + Sync + FenceCtxOps + 'static> ForeignOwnable f=
or DriverFence<'b, T> {

[Severity: High]
Could this lead to a Use-After-Free if the DriverFence is leaked?

Since DriverFence implements ForeignOwnable without requiring a 'static
lifetime for the 'b parameter, a user can call into_foreign() on a
DriverFence<'a, T> or use core::mem::forget() to leak it.

If the DriverFence is leaked, DriverFence::drop() is never called.
The Rust compiler will then allow the borrowed FenceCtx (tied to
lifetime 'a in DriverFenceData) to be dropped. Once FenceCtx::drop()
completes, the driver_name is freed.

However, the C backend could later interact with the dma_fence, which
is kept alive by ARef<Fence>, and invoke get_driver_name(). This would
dereference the dangling fctx pointer, causing a Use-After-Free.

[ ... ]
> +    fn drop(&mut self) {
> +        let fence =3D self.as_raw();
> +        let mut fence_flags: usize =3D 0;
> +        let flag_ptr =3D &raw mut fence_flags;
> +
> +        // SAFETY: fence is valid until the call_rcu() below. flag_ptr is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        unsafe { bindings::dma_fence_lock_irqsave(fence, flag_ptr) };
> +
> +        // Use dma_fence_test_signaled_flag() instead of dma_fence_is_si=
gnaled_locked()
> +        // because the C backend wants to get rid of the latter.
> +
> +        // SAFETY: fence is valid until the call_rcu() below.
> +        let signaled: bool =3D unsafe { bindings::dma_fence_test_signale=
d_flag(fence) };
> +        if warn_on!(!signaled) {
> +            // SAFETY: fence is valid until the call_rcu() below. The fe=
nce
> +            // must not have been signaled yet, which we check directly =
above.
> +            unsafe { bindings::dma_fence_set_error(fence, ECANCELED.to_e=
rrno()) };
> +            // SAFETY: fence is valid until the call_rcu() below. The lo=
ck must
> +            // be held, which we acquired above.
> +            unsafe { bindings::dma_fence_signal_locked(fence) };
> +        }
> +        // SAFETY: fence is valid until the call_rcu() below. flag_ptr is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        // The lock must be held, which we acquired above.
> +        unsafe { bindings::dma_fence_unlock_irqrestore(fence, flag_ptr) =
};

[Severity: Medium]
Does this cancellation path also need the lockdep annotations?

Similar to DriverFence::signal(), this open-coded signaling omits the
dma_fence_begin_signalling() and dma_fence_end_signalling() lockdep wrapper=
s,
which prevents cross-release dependency tracking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703073141.3962=
604-2-phasta@kernel.org?part=3D4
