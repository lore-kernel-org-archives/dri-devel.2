Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37974CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F2110E889;
	Tue, 16 Jun 2026 08:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JCyB6PI6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1020310E889
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:44:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4714E600AB
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2DB1F000E9;
 Tue, 16 Jun 2026 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781599496;
 bh=R2vIEwgGFKHdT3GJRSCAhTclN6o/zAyXEEKO07A0YSg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JCyB6PI66acx2aq8zrwmAxLj4LZPNufouomEvbtRHbjl7o+7XKx1yzOUUhTnqAq5V
 mQ8deSt/3G6ryY+lJMDSw0UK3n0SY5EQ0+gHyglBCguOI3T8lBmlSeLb0xhTQFcCw2
 5bTG/EJLlvNtiO7hTYZ3cnhMtvIybGfRi8v74dTMdL2vHSBeZqlXwDzY/h3PrAN4ki
 XL4Q8eqgld4vcbpSh1WbyVN8MEAuiBUbETvelubyFGs+QFlKG+4EOGH/7zAp7PTwqO
 9ze8sRubrthevo6+YpC8uBot31+OPVQklaIZ2sOXEI5+q3mTs7bxLeRuoP6/noiCMU
 4af0hvqrxMv4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260616082819.2943886-7-phasta@kernel.org>
References: <20260616082819.2943886-7-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 08:44:55 +0000
Message-Id: <20260616084455.CC2DB1F000E9@smtp.kernel.org>
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
- [Critical] Incorrect struct layout in `DriverFenceData` places `rcu_head`=
 before `inner: Fence`, causing misaligned pointer casts and SLUB corruptio=
n when the C backend frees the interior pointer.
- [Critical] `DriverFence::drop` prematurely destroys `FenceCtx` and user d=
ata before the `dma_fence` reference count reaches 0, causing Use-After-Fre=
e.
- [High] `FenceCtx<T>` and `DriverFence<T>` lack a `'static` bound on `T`, =
allowing safe Rust code to erase lifetimes and cause Use-After-Free.
- [High] `FenceCbRegistration::new` leaks an `ARef<Fence>` reference count =
on the error path.
- [High] Dropping the last reference to `FenceCtx` from the RCU callback wi=
ll execute the user's `T` (context data) `Drop` implementation in softirq c=
ontext.
--

commit 95eb8ea421a40fbf4b3b019ea0a7b2c3928e1e11
Author: Philipp Stanner <phasta@kernel.org>
rust: Add dma_fence abstractions

This commit introduces Rust abstractions for the C dma_fence framework.
It provides types such as DriverFence, Fence, and FenceCtx to cleanly=20
decouple fence issuers and consumers while interacting with the C backend.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> new file mode 100644
> index 0000000000000..3af2dee58e13f
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -0,0 +1,884 @@
[ ... ]
> +/// A dma-fence context. A fence context takes care of associating relat=
ed fences with each other,
> +/// providing each with raising sequence numbers and a common identifier.
> +#[pin_data]
> +pub struct FenceCtx<T: Send + Sync> {

[Severity: High]
Does T need a static bound here?

Fence contains an Opaque<bindings::dma_fence> without lifetime parameters,
making it implicitly static. DriverFence::as_fence allows extracting an
owned ARef<Fence>. Because it is static, safe Rust code could send this
ARef to threads that outlive T.=20

If T contains non-static references, the ARef<Fence> will keep
DriverFenceData alive beyond T's lifetime. Could this allow lifetime
erasure and a subsequent use-after-free?

> +    /// The fence context number.
> +    nr: u64,
> +    /// The sequence number for the next fence created.
> +    seqno: AtomicU64,
[ ... ]
> +#[allow(unused_unsafe)]
> +impl<T: Send + Sync + FenceCtxOps> FenceCtx<T> {
> +    // This can later be extended as a vtable in case other parties need=
 support
> +    // for the more "exotic" callbacks.
> +    const OPS: bindings::dma_fence_ops =3D bindings::dma_fence_ops {
> +        get_driver_name: Some(Self::get_driver_name),
> +        get_timeline_name: Some(Self::get_timeline_name),
> +        enable_signaling: None,
> +        signaled: None,
> +        wait: None,
> +        release: None,
> +        set_deadline: None,
> +    };

[Severity: Critical]
Will the C backend crash when trying to free this fence?=20

By leaving release as None, the dma_fence backend defaults to using
dma_fence_free(). As defined later in DriverFenceData, the dma_fence is
embedded at a non-zero offset. dma_fence_free() will call kfree_rcu() on
this interior pointer. Does this trigger a bad pointer panic in the SLUB
allocator?

[ ... ]
> +    /// Create a [`FenceCtx`] from an associated [`bindings::dma_fence`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be a valid pointer to a dma_fence which resides withi=
n a [`Fence`],
> +    /// which in turn resides in a [`DriverFenceData`].
> +    unsafe fn from_raw_fence<'a>(ptr: *mut bindings::dma_fence) -> &'a S=
elf {
> +        let opaque_fence =3D Opaque::cast_from(ptr);
> +
> +        // SAFETY: Safe due to the function's overall safety requirement=
s.
> +        let fence_ptr =3D unsafe { container_of!(opaque_fence, Fence, in=
ner) };
> +
> +        // DriverFenceData is repr(C) and a Fence is its first member.
> +        let fence_data_ptr =3D fence_ptr as *mut DriverFenceData<T>;

[Severity: Critical]
Can this direct cast lead to misaligned structure access?=20

The comment states Fence is the first member, but rcu_head is actually
defined before it in DriverFenceData. Casting the pointer directly to
DriverFenceData without accounting for the 16-byte offset of the inner
field could cause memory corruption when fctx is accessed later.

[ ... ]
> +    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a
> +    where
> +        T: 'a,
> +    {
[ ... ]
> +        unsafe {
> +            pin_init_from_closure(move |slot: *mut Self| {
> +                let slot_callback =3D &raw mut (*slot).callback;
> +                let slot_fence =3D &raw mut (*slot).fence;
> +                let slot_cb =3D &raw mut (*slot).cb;
> +
> +                // Write callback and fence first =E2=80=94 must be visi=
ble before
> +                // dma_fence_add_callback makes the registration live.
> +                core::ptr::write(slot_callback, callback);
> +                core::ptr::write(slot_fence, ARef::from(fence));
> +
> +                let ret =3D to_result(bindings::dma_fence_add_callback(
> +                    fence.inner.get(),
> +                    Opaque::cast_into(slot_cb),
> +                    Some(Self::dma_fence_callback),
> +                ));
> +
> +                match ret {
> +                    Ok(()) =3D> Ok(()),
> +                    Err(e) =3D> {
> +                        // Read back what we wrote to leave the slot cle=
an.
> +                        let cb_back =3D core::ptr::read(slot_callback);
> +
> +                        if e.to_errno() =3D=3D ENOENT.to_errno() {
> +                            Err(CallbackError::AlreadySignaled(cb_back))
> +                        } else {
> +                            Err(CallbackError::Other(e))
> +                        }
> +                    }
> +                }
> +            })
> +        }
> +    }

[Severity: High]
Does this error path leak the ARef reference count?

Earlier in this closure, ARef::from(fence) is written into slot_fence,
which increments the reference count. If dma_fence_add_callback() fails,
the error path reads back slot_callback to return it, but slot_fence is
neither read back nor manually dropped.=20

Since pin_init_from_closure assumes the slot is uninitialized on error
and won't run drop on it, will this permanently leak the ARef<Fence> and
its memory allocation?

[ ... ]
> +#[repr(C)] // Necessary to guarantee that `inner` always comes first so =
that we can cast.
> +#[pin_data]
> +struct DriverFenceData<T: Send + Sync + FenceCtxOps> {
> +    /// Callback head for dropping this in a deferred manner through RCU.
> +    rcu_head: bindings::callback_head,
> +    #[pin]
> +    /// The inner fence.
> +    inner: Fence,

[Severity: Critical]
Is the inner Fence guaranteed to be at offset 0 here?=20

The struct is marked repr(C), but rcu_head precedes inner. This shifts
the embedded Fence by the size of the callback_head, directly conflicting
with the assumption in from_raw_fence that Fence is the first member.

[ ... ]
> +pub struct DriverFence<T: Send + Sync + FenceCtxOps> {
> +    /// The actual content of the fence. Lives in a raw pointer so that =
its
> +    /// memory can be managed independently. Valid until both the [`Driv=
erFence`]
> +    /// and all associated [`Fence`]s have disappeared.
> +    data: NonNull<DriverFenceData<T>>,
> +}

[Severity: High]
Similar to FenceCtx, does DriverFence also require a static bound on T to
prevent safe code from erasing lifetimes and causing a use-after-free?

[ ... ]
> +/// Finally really drop this `DriverFence<T>`
> +///
> +/// # Safety
> +///
> +/// `head` references the `rcu_head` field of an `DriverFenceData<T>`. A=
ll
> +/// accessors to that `DriverFenceData<T>` must be gone by now. This mus=
t be
> +/// ensured by signalling the associated `DriverFence<T>` and then waiti=
ng
> +/// for a grace period until calling this function here.
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
> +    // SAFETY: A grace period has passed. All accessors to that `DriverF=
enceData`
> +    // are gone now. We have exclusive access and can now drop it.
> +    unsafe { drop_in_place(fence_data) };

[Severity: High]
Could this drop the user's data T in softirq context?

Since drop_driver_fence_data runs as an RCU callback, it executes in atomic
(softirq) context. If this drop_in_place() puts the last reference to the
Arc<FenceCtx<T>>, it will trigger the deallocation of the context and drop
its inner data T.

There appear to be no trait bounds or documentation enforcing that T must
only perform operations legal in atomic context. If a user provides context
data whose Drop implementation sleeps (like acquiring a mutex or freeing
large structures), would this trigger a sleeping in atomic context kernel
panic?

[Severity: Critical]
Does this prematurely destroy the user data and FenceCtx before the
dma_fence reference count actually reaches zero?

The dma_fence refcount is shared with ARef<Fence>. If an ARef<Fence> is
still alive when DriverFence drops, this RCU callback will execute
drop_in_place(fence_data). This destroys the Arc<FenceCtx> and the
user data. However, the C dma_fence is still alive with a non-zero
refcount.

When the refcount eventually hits zero later on, the C backend could
trigger callbacks like get_driver_name() via trace_dma_fence_destroy().
Could those callbacks access the already-freed fence_data.fctx, leading
to a use-after-free?=20

Should the Rust data instead be dropped in a custom release callback in
dma_fence_ops when the refcount actually reaches 0?

> +
> +    // The `drop_in_place()` above might drop the `FenceCtx` by putting =
the last
> +    // reference.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616082819.2943=
886-2-phasta@kernel.org?part=3D5
