Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756CCCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AA710EC96;
	Tue, 23 Jun 2026 20:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PxaiRDOo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FE910EC96
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:33:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D37F460018
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BB01F00A3A;
 Tue, 23 Jun 2026 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246791;
 bh=oqE4mdSxJCYYptRFLAHW4Xo5IdS2dySzDBQoIm/AM2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PxaiRDOomlILUiXBiATSH9Tne9XWapPuqnPG7ewxrx+r5flCk3wAY5oC998nVhP1a
 lpYgTi+GtQwLFw99PUj0XUhAnbPZgMwSrfqTbNVz9h7eLRFmwa1LzbDDf7wAl2I38X
 FDSOHQIJo6CllYDU2Q8oXWHxvZ8lFQU7PI90HjqfxXypUwZfrc6ZEPeFj63/GFNZo+
 6PaDtS1plNWyhSlOhT8Mul9xpTgPo0bCxVtO5QXk5rTXZ2eJiBWIHL8R61EHtyKEjl
 8gPMpf9v+sfjOCBw8DDIK7S2+RFyEb40txF/shJd9mHD/kWrjFywNNyaEFmu4ccvyI
 4TTkvSWg44mHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260618132628.3811068-5-phasta@kernel.org>
References: <20260618132628.3811068-2-phasta@kernel.org>
 <20260618132628.3811068-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:33:11 +0000
Message-Id: <20260623203311.64BB01F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Early publication of the fence callback exposes uninitialized =
memory to concurrent execution.
- [High] `Fence::is_signaled()` unconditionally acquires the fence's spinlo=
ck, causing a CPU deadlock if called from a fence callback.
- [High] Missing `dma_fence_begin_signalling()` and `dma_fence_end_signalli=
ng()` lockdep annotations breaks deadlock detection.
- [High] Aliasing violation in `FenceCbRegistration` Drop causes Undefined =
Behavior due to concurrent mutable references.
- [High] Missing `'static` bound on `DriverFence` generic types allows defe=
rred destruction of short-lived references, leading to Use-After-Free.
- [Medium] Dropping `FenceCtx<T>` and user data in RCU softirq context trig=
gers 'sleeping in atomic context' kernel BUG.
--

commit 77832e103c4c07b8e062803330d24f8483753627
Author: Philipp Stanner <phasta@kernel.org>

rust: Add dma_fence abstractions

This patch adds Rust abstractions for the dma_fence synchronization primiti=
ves.
It provides DriverFence and Fence types to decouple fence issuers and
consumers. It also implements callbacks and RCU-based destruction logic.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> new file mode 100644
> index 0000000000000..dcb41c8733aca
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs

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
Does this code expose uninitialized memory to concurrent execution? By
initializing `cb` and calling `bindings::dma_fence_add_callback()` first, t=
he
callback is published to the C backend and the spinlock is unlocked.

If a concurrent `dma_fence_signal` on another CPU triggers the callback
immediately, could `dma_fence_callback` attempt to access
`(*reg).callback.called()` before the `try_pin_init!` macro proceeds to
initialize the `callback` field?

[ ... ]

> +    unsafe extern "C" fn dma_fence_callback(
> +        _fence: *mut bindings::dma_fence,
> +        cb: *mut bindings::dma_fence_cb,
> +    ) {
> +        let ptr =3D Opaque::cast_from(cb).cast_mut();
> +
> +        // SAFETY: All `cb` we can receive here have been created in suc=
h a way
> +        // that they are embedded into a `FenceCbRegistration`. The back=
end
> +        // ensures synchronisation so whoever holds the registration obj=
ect
> +        // cannot drop it while this code is running. See `FenceCbRegist=
ration::drop`.
> +        unsafe {
> +            let reg: *mut Self =3D container_of!(ptr, Self, cb);
> +
> +            (*reg).callback.called();
> +        }
> +    }

[ ... ]

> +#[pinned_drop]
> +impl<T: FenceCb> PinnedDrop for FenceCbRegistration<T> {
> +    fn drop(self: Pin<&mut Self>) {

[Severity: High]
Could this result in an aliasing violation and Undefined Behavior?

When `FenceCbRegistration` drops, `PinnedDrop::drop` takes an exclusive
`Pin<&mut Self>`. If the fence signals concurrently, another CPU could exec=
ute
`dma_fence_callback` and invoke `(*reg).callback.called(&mut self)` using a
raw pointer.

Does taking an exclusive reference while another thread actively accesses t=
he
data concurrently via a raw pointer violate Rust's aliasing rules?

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
Can this code cause a CPU deadlock if called from a fence callback?

The Rust `Fence::is_signaled()` wrapper unconditionally acquires the fence's
spinlock via `dma_fence_lock_irqsave()`. However, the C backend's
`dma_fence_signal_timestamp_locked` executes callbacks with the fence's
spinlock already held.

If an API user calls `is_signaled()` from within the `FenceCb::called()`
callback on the same fence, wouldn't it attempt to acquire the non-recursive
spinlock a second time?

> +        // SAFETY: `fence` is valid because `self` is valid. `flag_ptr` =
is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        // The lock was taken above.
> +        unsafe { bindings::dma_fence_unlock_irqrestore(fence, flag_ptr) =
};
> +
> +        ret
> +    }

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

[Severity: High]
Are we missing the mandatory lockdep annotations for signaling here?

The `dma_fence` subsystem contract mandates that any code signaling a fence
must be annotated with `dma_fence_begin_signalling()` and
`dma_fence_end_signalling()` to prime lockdep for cross-driver deadlock
detection.

By manually signaling the fence with `dma_fence_signal_locked()` without th=
ese
annotations, does this silently disable lockdep's deadlock tracking for Rust
drivers?

> +        }
> +        // SAFETY: `fence` is valid because `self` is valid. `flag_ptr` =
is
> +        // merely a pointer to an integer, which lives as long as this f=
unction.
> +        // The lock must be held, which we acquired above.
> +        unsafe { bindings::dma_fence_unlock_irqrestore(fence, flag_ptr) =
};
> +    }

[ ... ]

> +impl<T: Send + Sync + FenceCtxOps> Drop for DriverFence<T> {
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

[Severity: High]
Does this drop signaling path also omit the required
`dma_fence_begin_signalling()` and `dma_fence_end_signalling()` lockdep
annotations?

> +        }

[ ... ]

> +unsafe extern "C" fn drop_driver_fence_data<T: Send + Sync + FenceCtxOps=
>(
> +    head: *mut bindings::callback_head,
> +) {
> +    // SAFETY: Caller provides a pointer to the `rcu_head` field of a `D=
riverFenceData<C>`.
> +    let fence_data =3D unsafe { container_of!(head, DriverFenceData<T>, =
rcu_head) };
> +
> +    // SAFETY: `fence_data` was created validly above. All the fence's d=
ata will
> +    // only drop below, but the raw pointer to the raw C `dma_fence` rem=
ains
> +    // valid because the reference count is only decremented at the end =
of the
> +    // function.
> +    let fence =3D unsafe { (*fence_data).inner.inner.get() };
> +
> +    // SAFETY: `fence_data` was created validly above. A grace period ha=
s passed.
> +    // All callbacks which might have had access to the `fctx` are gone =
now.
> +    unsafe { drop_in_place(&raw mut (*fence_data).fctx) };

[Severity: Medium]
Since `FenceCtx<T>` and the generic context data `T` are dropped here in
softirq (atomic) context via `call_rcu`, could this trigger a "sleeping in
atomic context" kernel BUG if `T` performs sleepable operations in its `Dro=
p`
implementation?

Would it be helpful to add documentation or trait bounds warning users that
these types must be drop-safe in atomic context?

> +
> +    // SAFETY: `fence_data` was created validly above. The user has alre=
ady
> +    // dropped the only conventional accessor to the user data, the `Dri=
verFence`,
> +    // one grace period ago. All accessors are gone now.
> +    unsafe { drop_in_place(&raw mut (*fence_data).data) };

[Severity: High]
Does this missing `'static` bound on `DriverFence` generic types allow the
deferred destruction of short-lived references?

Since `DriverFence<T>` does not require `T` to be bounded by `'static'`, a =
user
could instantiate it with a type holding a short-lived reference (e.g., to a
local stack variable).

When `DriverFence` drops, `call_rcu` defers the actual destruction to
`drop_driver_fence_data::<T>`, which escapes the borrow checker. If the sta=
ck
variable goes out of scope before the RCU callback runs, will `drop_in_plac=
e`
access a dangling pointer and cause a Use-After-Free?

> +
> +    // The inner `Fence` explicitly does not get dropped because there m=
ay be
> +    // many more users / consumers, each holding their own reference.
> +
> +    // SAFETY: Once a `DriverFence` is initialized, the inner `fence` is
> +    // valid and initialized. It is valid until the refcount drops
> +    // to 0, which can earliest happen once we drop the `DriverFence`'s =
reference
> +    // here.
> +    unsafe { bindings::dma_fence_put(fence) };
> +
> +    // The actual memory the data associated with a `DriverFence` lives =
in
> +    // gets freed by the C dma_fence backend once the fence's refcount r=
eaches 0.
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618132628.3811=
068-2-phasta@kernel.org?part=3D3
