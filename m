Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB2DCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC42C10ECC3;
	Tue, 23 Jun 2026 21:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NbKTrQhE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1A310ECC3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:06:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BCFB960008
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7361F000E9;
 Tue, 23 Jun 2026 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248807;
 bh=tfPhiTPeCGQH9Y2AJHUTvBF9UCo7Jy6EfshdeF3Q/pE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NbKTrQhERnw8y0RWliYW9iVLZNvgff8LnW+wRt9ICQqRATvdM4kgm+Iy8ehUc4Nxc
 iAmCCXoIE/BMZXC2AsfrcGcq5EBIVb/TxI7TKkCW2FYCrsaTOpoPzWTBKp8QmEHXPo
 tyoO4tvgK/VjW2CbltvpQHrwsmFh32+GVr3g07it6uzBu3/mb5/AmgiPYpS+g8Emfn
 i4RC7vdNg7fpGKjds8SM/TzWb21jgsKWilt313Vd0x5pzNM+DMly0HmD2Js+mj4noS
 PvVdChRFQIbezmwYf3tPz+Urzt20fjcXJGO0ihM2ID+JX5mgci2RLKwiwXEXy6WIoD
 fx+lNum4BmtIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260622135654.334961-6-phasta@kernel.org>
References: <20260622135654.334961-2-phasta@kernel.org>
 <20260622135654.334961-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:06:46 +0000
Message-Id: <20260623210647.4F7361F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Soundness / Use-After-Free due to lifetime erasure in `Foreign=
Ownable` implementation for `DriverFence`.
- [Critical] TOCTOU race condition in `FenceCbRegistration::new` allows uni=
nitialized memory access.
- [High] Deadlock when calling `Fence::is_signaled()` from a registered fen=
ce callback.
- [High] `FenceCtx::drop` calls `rcu_barrier()`, sleeping in atomic context.
- [Medium] Missing `dma_fence_begin_signalling()` lockdep annotations in `D=
riverFence::signal` and `DriverFence::drop`.
--

commit 13ec5041cfbf69d9b4feb4a3709de7bd1157511a
Author: Philipp Stanner <phasta@kernel.org>

rust: Add dma_fence abstractions
   =20
This commit introduces Rust abstractions for the C dma_fence API, providing
a safe interface for drivers to create, signal, and await fences. It handles
the memory management, callback registration, and context creation.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> new file mode 100644
> index 0000000000000..a9d9a684947c5
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> +    extern "C" fn get_driver_name(ptr: *mut bindings::dma_fence) -> *con=
st c_char {
> +        // SAFETY: The C backend only invokes this callback with `ptr` p=
ointing
> +        // to a valid, unsignaled `bindings::dma_fence`. All fences crea=
ted
> +        // in this module always reside within `Fence` which always resi=
des in
> +        // a `DriverFenceData`, thus satisfying the function's safety re=
quirements.
> +        let fctx =3D unsafe { Self::from_raw_fence(ptr) };
> +
> +        fctx.driver_name.as_char_ptr()
> +    }

[Severity: Critical]
Could this result in a use-after-free?

When the C backend calls this mandatory callback, it dereferences the fctx
pointer. However, the lifetime of the DriverFence's context is erased in the
ForeignOwnable implementation. If the underlying FenceCtx is dropped
prematurely from safe Rust, could this callback access freed memory?

[ ... ]

> +#[pinned_drop]
> +impl<T: Send + Sync> PinnedDrop for FenceCtx<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        rcu_barrier();
> +    }
> +}

[Severity: High]
Does this sleep in atomic context?

FenceCtx is managed by an Arc, meaning its drop executes when the last
reference is released. If an Arc<FenceCtx> is dropped in an atomic context
like an interrupt handler or while holding a spinlock, unconditionally
calling rcu_barrier() will block and sleep, violating the atomic context
constraints.

[ ... ]

> +    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a
> +    where
> +        T: 'a,
> +    {
> +        let mut callback =3D Some(callback);
> +
> +        try_pin_init!(Self {
> +            cb <- Opaque::try_ffi_init(|ptr| {
> +                // SAFETY: `fence.inner.get()` is a valid, initialized `=
struct dma_fence`. `ptr`
> +                // points to the `struct dma_fence_cb` field within the =
pinned allocation, so it
> +                // remains valid until `dma_fence_remove_callback()` in =
`PinnedDrop` or until the
> +                // callback fires.
> +                let ret =3D unsafe {
> +                    to_result(bindings::dma_fence_add_callback(
> +                        fence.inner.get(),
> +                        ptr,
> +                        Some(Self::dma_fence_callback),
> +                    ))
> +                };
> +                match ret {
> +                    Ok(()) =3D> Ok(()),
> +                    Err(e) =3D> {
> +                        let cb_back =3D callback.take().expect("Success =
path did not run.");
> +                        if e =3D=3D ENOENT {
> +                            Err(CallbackError::AlreadySignaled(cb_back))
> +                        } else {
> +                            Err(CallbackError::Other(e))
> +                        }
> +                    }
> +                }
> +            }),
> +            callback: callback.take().expect("Error path did not run."),

[Severity: Critical]
Is there a race condition here that allows uninitialized memory access?

The cb field is initialized first, which registers the callback with the C
backend via dma_fence_add_callback. Once added, the callback is live.
However, the callback field containing the user's T: FenceCb implementation
has not yet been initialized.

If a concurrent thread signals the fence in this tight window, the C subsys=
tem
will immediately invoke Self::dma_fence_callback, which will cast the point=
er
back and invoke (*reg).callback.called() on uninitialized memory.

[ ... ]

> +    pub fn is_signaled(&self) -> bool {
> +        let fence =3D self.as_raw();
> +        let mut fence_flags: usize =3D 0;
> +        let flag_ptr =3D &raw mut fence_flags;
> +
> +        // We shouuld not use `dma_fence_is_signaled_locked()` here, bec=
ause
> +        // according to the C backend's recommendations, that function i=
s problematic
> +        // and we should avoid calling that function with a lock held.
> +
> +        // SAFETY: `self` is valid by definition. We take the spinlock a=
bove.
> +        let ret =3D unsafe { bindings::dma_fence_is_signaled(fence) };
> +
> +        // To guarantee that an API caller can 100% rely on the signalli=
ng being
> +        // completed (i.e., all fence callbacks ran), we have to take th=
e lock.
> +        //
> +        // The reason is that the C dma_fence backend currently does not=
 carefully
> +        // synchronize the `dma_fence_is_signaled()` function with the p=
roper
> +        // spinlock. This can lead to the function returning `true` whil=
e fence
> +        // callbacks are still being executed. This can be mitigated by =
guarding
> +        // the entire function with the spinlock.
> +        //
> +        // See commit c8a5d5ea3ba6a.
> +
> +        // SAFETY: `fence` is valid because `self` is valid. `flag_ptr` =
is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        unsafe { bindings::dma_fence_lock_irqsave(fence, flag_ptr) };

[Severity: High]
Could this cause a deadlock if called from within a registered fence callba=
ck?

When the fence signals, the C backend (dma_fence_signal) acquires the fence=
's
spinlock and iterates over the callback list. The callback executes
FenceCb::called() synchronously while the spinlock is held.

If the user's called() implementation invokes Fence::is_signaled(), this co=
de
will forcefully attempt to acquire the exact same spinlock, leading to an
immediate CPU deadlock since spinlocks are not recursive.

[ ... ]

> +    pub fn signal(self, res: Result) {
> +        let fence =3D self.as_raw();
> +        let mut fence_flags: usize =3D 0;
> +        let flag_ptr =3D &raw mut fence_flags;
> +
> +        // SAFETY: `fence` is valid because `self` is valid. `flag_ptr` =
is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        unsafe { bindings::dma_fence_lock_irqsave(fence, flag_ptr) };
> +        // SAFETY: `fence` is valid because `self` is valid. The lock mu=
st be
> +        // held, which we acquired directly above.
> +        if !unsafe { bindings::dma_fence_test_signaled_flag(fence) } {
> +            if let Err(err) =3D res {
> +                // SAFETY: `fence` is valid because `self` is valid. The=
 fence
> +                // must not have been signaled yet, which we check direc=
tly above.
> +                unsafe { bindings::dma_fence_set_error(fence, err.to_err=
no()) };
> +            }
> +            // SAFETY: `fence` is valid because `self` is valid. The loc=
k must
> +            // be held, which we acquired above.
> +            unsafe { bindings::dma_fence_signal_locked(fence) };

[Severity: Medium]
Are we missing the dma_fence_begin_signalling() lockdep annotations here?

By calling bindings::dma_fence_signal_locked() directly instead of using the
standard dma_fence_signal() C function, we skip the lockdep state tracking
helpers. Could this disable lockdep's ability to detect deadlocks between
fence signaling and fence waiters?

[ ... ]

> +unsafe impl<'b, T: Send + Sync + FenceCtxOps + 'static> ForeignOwnable f=
or DriverFence<'b, T> {
> +    type Borrowed<'a> =3D DriverFenceBorrow<'a, T> where Self: 'a;
> +    type BorrowedMut<'a> =3D DriverFenceBorrow<'a, T> where Self: 'a;
> +
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<bindings::dma_f=
ence>();
> +
> +    fn into_foreign(self) -> *mut c_void {
> +        let fence =3D self;
> +
> +        let ptr =3D fence.as_raw();
> +
> +        // DriverFence must not drop.
> +        let _ =3D ManuallyDrop::new(fence);
> +
> +        ptr.cast()
> +    }

[Severity: Critical]
Does this ForeignOwnable implementation introduce a soundness issue by eras=
ing
the lifetime 'b bound to FenceCtx?

When into_foreign() is called, it consumes the DriverFence and returns a raw
pointer, effectively erasing the lifetime 'b from the borrow checker's
perspective. This allows the borrow on FenceCtx to be released, and safe Ru=
st
code can then drop the FenceCtx.

Since the C backend still retains the raw dma_fence pointer, any subsequent
use of mandatory callbacks (like get_driver_name) will read from the dangli=
ng
fctx pointer inside DriverFenceData, causing a use-after-free.

[ ... ]

> +impl<'a, T: Send + Sync + FenceCtxOps> Drop for DriverFence<'a, T> {
> +    fn drop(&mut self) {
> +        let fence =3D self.as_raw();
> +        let mut fence_flags: usize =3D 0;
> +        let flag_ptr =3D &raw mut fence_flags;
> +
> +        // SAFETY: `fence` is valid until the `call_rcu()` below. `flag_=
ptr` is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        unsafe { bindings::dma_fence_lock_irqsave(fence, flag_ptr) };
> +
> +        // Use dma_fence_test_signaled_flag() instead of dma_fence_is_si=
gnaled_locked()
> +        // because the C backend wants to get rid of the latter.
> +
> +        // SAFETY: `fence` is valid until the `call_rcu()` below.
> +        let signaled: bool =3D unsafe { bindings::dma_fence_test_signale=
d_flag(fence) };
> +        if warn_on!(!signaled) {
> +            // SAFETY: `fence` is valid until the `call_rcu()` below. Th=
e fence
> +            // must not have been signaled yet, which we check directly =
above.
> +            unsafe { bindings::dma_fence_set_error(fence, ECANCELED.to_e=
rrno()) };
> +            // SAFETY: `fence` is valid until the `call_rcu()` below. Th=
e lock must
> +            // be held, which we acquired above.
> +            unsafe { bindings::dma_fence_signal_locked(fence) };

[Severity: Medium]
Similar to the signal() method above, are we skipping the required lockdep
annotations here?

This fallback drop signaling path also invokes dma_fence_signal_locked()
directly without wrapping it in dma_fence_begin_signalling() and
dma_fence_end_signalling().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622135654.3349=
61-2-phasta@kernel.org?part=3D4
