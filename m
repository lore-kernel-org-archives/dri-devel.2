Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B9BC624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E86910E5D3;
	Sat,  5 Sep 2026 09:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CBsvTuPK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2361910E5D3
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 09:10:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09415602C3;
 Sat,  5 Sep 2026 09:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C4A1F00A3D;
 Sat,  5 Sep 2026 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788599449;
 bh=R4TCsVGY3J4BJmZC/jPXookWELhuZikkNXNveeFpOmA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CBsvTuPKXQuWMV5a5U1ofaMdHcqfQF7WtV0rE6wGMfZrHEuLmOw2SjX+ZaXwUHuti
 ON/xejKXkRfrd9wph9QWHGv7o8w6a9WQ1+6Z3uZ8ch+Ojmz0fOmahA8jg06pKYpKcS
 CGNEyboXK8+TGftDo4bI7F1poMN4f0P8TIgwirN9yL4H3tLtKxNc4kxoYmnN5mGf3X
 TE6LBCQ7cvmcFbXsK+elFw4Fe4841HlZ4a2o9N1lCwsHGhObLClc+xczHDMMZNy5d9
 9oCexS18Hie6miowNQldunIPFj0bkgnEpvnB7Bu0fHVcbnT3zFUfAp5L2VceznBm8Z
 E/j1zELEYkVVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260905085343.1827305-3-phasta@kernel.org>
References: <20260905085343.1827305-2-phasta@kernel.org>
 <20260905085343.1827305-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:10:48 +0000
Message-Id: <20260905091049.79C4A1F00A3D@smtp.kernel.org>
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
- [High] The consumer `Fence` can outlive its `FenceContext`, leading to a =
use-after-free when C callbacks access the context.
- [High] Unconditional spinlock acquisition in `Fence::is_signaled()` cause=
s a deadlock if invoked from within a fence callback.
- [High] `FenceContext`'s `PinnedDrop` implementation calls `rcu_barrier()`=
, which blocks and sleeps, making it unsafe to drop in atomic context.
- [Low] Missing `#[inline]` annotation on small abstraction functions forwa=
rding to C bindings.
--

commit fb115447c7bec2def2c1691d01dc640dec6f4092
Author: Philipp Stanner <phasta@kernel.org>

    rust: Add dma_fence abstractions
   =20
    C's dma_fence's are synchronisation primitives that will be needed by a=
ll
    Rust GPU drivers.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 0000000000000..32d9999e75d44
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> +    extern "C" fn get_driver_name(ptr: *mut bindings::dma_fence) -> *con=
st c_char {
> +        // SAFETY: The C backend only invokes this callback with `ptr` p=
ointing
> +        // to a valid, unsignaled `bindings::dma_fence`. All fences crea=
ted in
> +        // this module always reside within `Fence` which always resides=
 in a
> +        // `DriverFenceData`, thus satisfying the function's safety
> +        // requirements.
> +        let fctx =3D unsafe { Self::from_raw_fence(ptr) };
> +
> +        fctx.driver_name.as_char_ptr()
> +    }
> +
> +    extern "C" fn get_timeline_name(ptr: *mut bindings::dma_fence) -> *c=
onst c_char {
> +        // SAFETY: The C backend only invokes this callback with `ptr` p=
ointing
> +        // to a valid, unsignaled `bindings::dma_fence`. All fences crea=
ted in
> +        // this module always reside within `Fence` which always resides=
 in a
> +        // `DriverFenceData`, thus satisfying the function's safety
> +        // requirements.
> +        let fctx =3D unsafe { Self::from_raw_fence(ptr) };
> +
> +        fctx.timeline_name.as_char_ptr()
> +    }

[Severity: High]
Could this lead to a use-after-free if the consumer Fence outlives its
FenceContext? The Fence object (representing the consumer side of dma_fence=
) is
refcounted and has no Rust lifetime constraint tying it to FenceContext. It=
 can
be shared with C subsystems or exported to userspace. If the driver drops
DriverFence and subsequently drops FenceContext, the memory for FenceContex=
t is
freed. If an external consumer then queries the fence, the callback casts t=
he
fence pointer and dereferences the now-dangling fctx reference to read the =
name.

[ ... ]

> +#[pinned_drop]
> +impl<T: FenceContextOps + Send + Sync> PinnedDrop for FenceContext<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Fence ops callbacks can be called on unsignaled fences. Since=
 these
> +        // callbacks can access the fence context and its data, it needs=
 to be
> +        // guaranteed that a context only drops after all associated
> +        // `DriverFence`s have been dropped. This is unlikely to occur, =
but
> +        // would result in silent UAF. Throw a panic to prevent that.
> +        //
> +        // TODO:
> +        // It would be better if the fence context signals all forgotten=
 fences
> +        // itself. To do so, it would keep a list of unsignaled fences. =
That
> +        // list's members would have to be pre-allocated (see
> +        // `FenceCallback::new_fence_allocation()`).
> +        if self.nr_of_unsignaled_fences.load(Relaxed) !=3D 0 {
> +            panic!("Forgotten fences in FenceContext.");
> +        }
> +
> +        // Ensure that the driver cannot unload while there are still dm=
a_fence
> +        // callbacks running. At the same time, the RCU barrier addresse=
s the
> +        // problem inherited by the C backend, in which backend ops call=
backs
> +        // might be accessing the fence while it is being signaled (or s=
hortly
> +        // after). This could cause UAF access on the fence context's
> +        // `fctx.driver_name` and `fctx.timeline_name`.
> +        //
> +        // Wait for the RCU callbacks in `DriverFence::drop`.
> +        rcu_barrier();
> +    }
> +}

[Severity: High]
Is it safe to call rcu_barrier() during destruction? rcu_barrier() waits for
all pending RCU callbacks, which involves blocking and sleeping. If a driver
stores the FenceContext in a reference-counted container and the last refer=
ence
is dropped from an atomic context (such as an interrupt handler or while ho=
lding
a spinlock), wouldn't this sleep in atomic context cause a kernel panic?

[ ... ]

> +    unsafe extern "C" fn dma_fence_callback(
> +        _fence: *mut bindings::dma_fence,
> +        callback_foreign: *mut bindings::dma_fence_cb,
> +    ) {
> +        let ptr =3D Opaque::cast_from(callback_foreign).cast_mut();
> +
> +        // SAFETY: All `cb` we can receive here have been created in suc=
h a way
> +        // that they are embedded into a `FenceCallbackRegistration`. The
> +        // backend ensures synchronisation so whoever holds the registra=
tion
> +        // object cannot drop it while this code is running. See
> +        // `FenceCallbackRegistration::drop`.
> +        unsafe {
> +            let reg: *mut Self =3D container_of!(ptr, Self, callback_for=
eign);
> +
> +            (*reg).callback.on_signal();
> +        }
> +    }

[ ... ]

> +impl Fence {
> +    /// Check whether the fence was signaled at the moment of the functi=
on call.
> +    ///
> +    /// Note that this can return `true` for a [`Fence`] whose [`DriverF=
ence`]
> +    /// has not yet been dropped. The reason is that the fence ops callb=
acks can
> +    /// cause the fence to get signaled by the C backend.
> +    #[inline]
> +    pub fn is_signaled(&self) -> bool {
> +        // We should not use `dma_fence_is_signaled_locked()` here, beca=
use
> +        // according to the C backend's recommendations, that function is
> +        // problematic and we should avoid calling that function with a =
lock
> +        // held.
> +
> +        // SAFETY: Inner `fence` is valid because `self` is valid.
> +        let ret =3D unsafe { bindings::dma_fence_is_signaled(self.as_raw=
()) };
> +
> +        // To be as robust as possible for the future we guarantee that =
an API
> +        // caller can 100% rely on the signaling being completed (i.e., =
all
> +        // fence callbacks ran), so we have to take the lock.
> +        //
> +        // The reason is that the C dma_fence backend currently does not
> +        // carefully synchronize the `dma_fence_is_signaled()` function =
with the
> +        // proper spinlock. This can lead to the function returning `tru=
e` while
> +        // fence callbacks are still being executed. This can be mitigat=
ed by
> +        // guarding the entire function with the spinlock.
> +        //
> +        // The fundamental reason is that the C backend currently does g=
uard
> +        // setting of the fence's signaled-bit with the fence's spinlock=
, but
> +        // reading is done locklessly.
> +        //
> +        // See commit c8a5d5ea3ba6a.
> +        let _ =3D self.lock();
> +
> +        ret
> +    }

[Severity: High]
Does this unconditionally acquire the spinlock even though it might already=
 be
held? When a fence is signaled, the C function dma_fence_signal_locked()
iterates over and executes all registered callbacks while actively holding =
the
fence's spinlock. If the user callback attempts to check the fence's status=
 by
calling Fence::is_signaled() from within on_signal(), it attempts to acquire
the exact same non-recursive spinlock, which would cause a deadlock.

[ ... ]

> +    fn as_raw(&self) -> *mut bindings::dma_fence {
> +        self.inner.get()
> +    }

[Severity: Low]
Should this small getter function be annotated with #[inline] according to =
the
Rust kernel coding guidelines?

[ ... ]

> +// SAFETY: These implement the C backends refcounting methods which are =
proven
> +// to work correctly.
> +unsafe impl AlwaysRefCounted for Fence {
> +    fn inc_ref(&self) {
> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct dma_f=
ence`.
> +        unsafe { bindings::dma_fence_get(self.as_raw()) }
> +    }

[Severity: Low]
Should this small function forwarding to C bindings be annotated with #[inl=
ine]
according to the Rust kernel coding guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905085343.1827=
305-2-phasta@kernel.org?part=3D1
