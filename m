Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BC4C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB30D10E635;
	Wed, 29 Jul 2026 10:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8qWEr75";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1822F10E635
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:14:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ABD0600B1;
 Wed, 29 Jul 2026 10:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2AA1F000E9;
 Wed, 29 Jul 2026 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785320090;
 bh=hUXfb7TWNklnluSblrvMxitRlLkRjiWovYXceZzp0E8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q8qWEr75brcZLsfx9a98vVhRU/8zQMK2O2f+uQzgJqZUJcKLRn4GlUVR+jq7FpfrV
 LDc80fYMeI21jyOqdmOEmHMXo6Bo9TZl/aShQw0Ussph1qFMPhPR/y5s2eF7rQN8KK
 gPDaa9cpI5qs8p3ITQMG+iHakp53XAxwyEuGgVChSt2SyNUlK8e/VKecH2OMZpQP9G
 Mq66FG2O9vWchWvOUZe1D1N/8v3Po38RbyOXG/Mcg1ny1hheYa3QQpFGmLzbleQYR3
 HWjYfSAeWZi8IQhllUreHr0k+gJH3ok5G6Jx2n4GIs+YQfRYO+3awp7yiCgVHRBjXm
 kx24KfS0V0NOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260729094542.302965-6-phasta@kernel.org>
References: <20260729094542.302965-2-phasta@kernel.org>
 <20260729094542.302965-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 10:14:49 +0000
Message-Id: <20260729101449.DD2AA1F000E9@smtp.kernel.org>
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
- [Critical] Infinite loop under spinlock in `remove_from_fctx_list`.
- [Critical] IRQ-context Deadlock due to using non-IRQ-safe `SpinLock` for =
`fctx.fences`.
- [High] Use-After-Free in dma_fence_ops callbacks (get_driver_name / get_t=
imeline_name).
- [High] Memory leak of `DriverFenceData` and list nodes when implicitly dr=
opped.
- [Low] Compilation Error (use-after-move) in `FenceCallbackRegistration::n=
ew`.
--

--- Patch [4]: [PATCH v7 4/5] rust: Add dma_fence abstractions ---
commit 6943f462ac2321e63a53d88290790522a943cbc4
Author: Philipp Stanner <phasta@kernel.org>

rust: Add dma_fence abstractions

This commit introduces Rust abstractions for the C dma_fence framework.
It provides DriverFence and Fence types to decouple fence issuers and
consumers, along with a FenceContext for synchronization.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs
[ ... ]
> +pub struct FenceContext<T: FenceContextOps + Send + Sync> {
> +    /// The fence context number.
> +    nr: u64,
[ ... ]
> +    #[pin]
> +    fences: SpinLock<List<FenceLastResortSignaler>>,

[Severity: Critical]
Can this lead to an IRQ-context deadlock?

If a process-context thread acquires the lock during DriverFence creation,
and a hardware interrupt fires on the same CPU before the lock is released:

Process context:
fctx.fence_alloc()
    new_fence()
        fctx.fences.lock()

IRQ context on same CPU:
GPU job completes
    DriverFence::signal()
        remove_from_fctx_list()
            fctx.fences.lock()

It seems the interrupt handler will attempt to acquire the already-held
lock. Since SpinLock resolves to spin_lock() which leaves interrupts
enabled, would this cause the CPU to deadlock?

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

[Severity: High]
Could this result in a use-after-free?

If the device is removed and the FenceContext is dropped, userspace could
still hold a reference to the fence via a sync_file file descriptor. If
userspace then calls the SYNC_IOC_FILE_INFO ioctl, the C backend would
unconditionally invoke get_driver_name.

It appears fctx would point to freed memory, causing a use-after-free when
accessing driver_name.

[ ... ]
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
Does this have the same use-after-free issue as get_driver_name above?

[ ... ]
> +    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a
> +    where
> +        T: 'a,
> +    {
> +        try_pin_init!(Self {
> +            // We need to fully initialize the fence because after
> +            // `dma_fence_add_callback()` ran, the callback might immedi=
ately
> +            // get invoked.
> +            callback: ManuallyDrop::new(callback),
> +            fence: ARef::from(fence),
> +            callback_foreign <- Opaque::try_ffi_init(|ptr| {
[ ... ]
> +                match ret {
> +                    Ok(()) =3D> Ok(()),
> +                    Err(e) =3D> {
> +                        // SAFETY: We could not register the callback. T=
hus,
> +                        // C will not use it. So we can just take it back
> +                        // and pass it to the user again.
> +                        let cb_back =3D unsafe { ManuallyDrop::take(call=
back) };

[Severity: Low]
Does this compile successfully?

It looks like the callback parameter is moved into ManuallyDrop::new(), and
then later accessed inside the try_ffi_init closure. This appears to
violate ownership rules with a use-after-move. Additionally, wouldn't
ManuallyDrop::take() expect a mutable reference rather than the underlying
type?

[ ... ]
> +    fn remove_from_fctx_list(&self) {
> +        // SAFETY: `self.data` is valid because `self` was validly initi=
alized.
> +        let mut guard =3D unsafe { self.data.as_ref().fctx.fences.lock()=
 };
> +        let mut cursor =3D guard.cursor_front();
> +
> +        while let Some(pos) =3D cursor.peek_next() {
> +            // Fences in this list are always initialized, so `unwrap` i=
s OK.
> +            if self.as_fence().get_seqno() =3D=3D pos.fence.as_ref().unw=
rap().get_seqno() {
> +                let _ =3D pos.remove();
> +            }
> +        }
> +    }

[Severity: Critical]
Can this cause an infinite loop?

If the current element's seqno does not match the signaled fence, the code
takes no action and fails to advance the cursor. The next iteration would
peek at the exact same element indefinitely, leading to a lockup under the
spinlock.

Should there be a cursor.move_next() call when the sequence number does not
match?

[ ... ]
> +impl<'a, T: Send + Sync + FenceContextOps> Drop for DriverFence<'a, T> {
> +    fn drop(&mut self) {
> +        let guard =3D self.as_fence().lock();
> +
> +        // Use dma_fence_test_signaled_flag() instead of
> +        // dma_fence_is_signaled_locked() because the C backend wants to=
 get rid
> +        // of the latter.
> +
> +        // SAFETY: `guard` is valid until the `call_rcu()` below.
> +        let signaled: bool =3D unsafe { bindings::dma_fence_test_signale=
d_flag(*guard.deref()) };
> +        if warn_on!(!signaled) {
> +            // SAFETY: `guard` is valid until the `call_rcu()` below. Th=
e fence
> +            // must not have been signaled yet, which we check directly =
above.
> +            unsafe { bindings::dma_fence_set_error(*guard.deref(), ECANC=
ELED.to_errno()) };
> +            // SAFETY: `guard` is valid until the `call_rcu()` below. Th=
e lock
> +            // must be held, which we acquired above.
> +            unsafe { bindings::dma_fence_signal_locked(*guard.deref()) };
> +        }
> +        drop(guard);
> +
> +        // SAFETY: Valid because `self` is valid.
> +        let rcu_head_ptr =3D unsafe { &raw mut (*self.data.as_ptr()).rcu=
_head };
[ ... ]
> +        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence=
_data::<T>)) };
> +    }
> +}

[Severity: High]
Does implicitly dropping a DriverFence leak the tracking nodes?

The drop implementation orchestrates the destruction and signals the fence,
but it seems it does not call self.remove_from_fctx_list().

If the driver implicitly drops the DriverFence on an error path without
explicitly calling signal(), the tracking node would remain in the
fctx.fences list indefinitely. This holds an ARef<Fence> that keeps the C
dma_fence refcount elevated, preventing the memory from being freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729094542.3029=
65-2-phasta@kernel.org?part=3D4
