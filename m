Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613DBC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FA310E1E9;
	Fri, 31 Jul 2026 08:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oz6RyX/l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2CB10E1E9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:18:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B83443899;
 Fri, 31 Jul 2026 08:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4ED1F00A3A;
 Fri, 31 Jul 2026 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785485897;
 bh=/6K83Z5fEfcZQxosgk5WlVajy97IYDv1AsHJJ0GwlCo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oz6RyX/lo1jH0XWpcv1ORcm6tcqi0p5/V+rSFLlOJT0/L2wN9todX+p9icioBhe8j
 reNATj11nXPIu2Z2W69INxjhN0/cVvqcL7Fy427JvCJNnYsibj2p1jTY1daMQ5XtR5
 cxGkFyG8Rtu4bGMdg8S4yUtHQ9Nc/LsvV0k674dfHy5pXOEKevv9PPsr0kTnL2cYZT
 k5eoLpwSe9btHsT4CDkLqrz97PLNp5Uxg3JC+tM/Z9tjrU+el2rQxK3oAcDPp363U+
 uAjB5wtPBcXRxoDocNJYiBVynImARkXMZXnQJM2LPeryAenRUgpTjhM7crIUXFcSPR
 RwE2+sRjZxKjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731080411.848772-6-phasta@kernel.org>
References: <20260731080411.848772-2-phasta@kernel.org>
 <20260731080411.848772-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 08:18:16 +0000
Message-Id: <20260731081816.BB4ED1F00A3A@smtp.kernel.org>
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
- [High] Soundness bug in `ForeignOwnable` allows safe lifetime erasure, le=
ading to UAF of `FenceContext`.
- [High] `Fence` objects safely outlive their `FenceContext`, leading to UA=
F in C callbacks.
- [High] Unconditional system-wide `rcu_barrier()` on `FenceContext` drop c=
auses severe latency spikes.
- [High] Calling `Fence::is_signaled()` from a fence callback causes a hard=
 deadlock.
- [Medium] `FenceContext::drop` does not signal leaked fences, causing perm=
anent deadlocks for consumers.
- [Medium] `nr_of_unsignaled_fences` counter leaks if a fence is signaled v=
ia the C API.
--

--- Patch [4]: [PATCH v8 4/5] rust: Add dma_fence abstractions ---
commit baeb68fb999484f7d372bacbf53bbc08faf26f2e
Author: Philipp Stanner <phasta@kernel.org>
rust: Add dma_fence abstractions

This commit adds abstractions for dma_fence in Rust. It provides DriverFenc=
e=20
and Fence types to cleanly decouple fence issuers and consumers, along with=
=20
a FenceContext to handle sequencing.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> new file mode 100644
> index 0000000000000..d6322e062faff
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

[Severity: High]
Can Fence objects safely outlive their FenceContext, leading to a=20
use-after-free here?

It looks like Fence implements AlwaysRefCounted but lacks a lifetime=20
parameter connecting it to its FenceContext. If a user drops the DriverFenc=
e=20
and then drops the FenceContext while the ARef to the Fence remains alive,=
=20
callbacks like get_driver_name could access a dangling fctx pointer.

Could this happen if a consumer accesses the exported fence, for example=20
through debugfs reading the fence driver name or through SYNC_IOC_FILE_INFO=
,=20
triggering the C backend to call this function on a signaled fence?

[ ... ]
> +#[pinned_drop]
> +impl<T: FenceContextOps + Send + Sync> PinnedDrop for FenceContext<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        if self.nr_of_unsignaled_fences.load(Relaxed) > 0 {
> +            pr_err!("Unsignaled DriverFence(s) left in FenceContext. UAF=
 possible.\n");
> +        }
> +
> +        // TODO:
> +        // It would be even more robust if the fence context signals all
> +        // forgotten fences itself. To do so, it would keep a list of un=
signaled
> +        // fences. That list members would have to be pre-allocated (see
> +        // `FenceCallback::fence_alloc()`).

[Severity: Medium]
Will this cause waiting consumers to hang indefinitely?

The commit message notes that as a safety measure, if a FenceContext drops=
=20
with an unsignaled fence present, it will signal it to ensure full=20
decoupling. However, this code leaves a TODO and only prints a warning=20
instead of actually signaling the leaked fences.

Does this mean that if a fence is forgotten without being signaled, any=20
kernel threads waiting on it will enter a permanent deadlock?

> +
> +        rcu_barrier();
> +    }
> +}

[Severity: High]
Could calling rcu_barrier() unconditionally here cause severe latency spike=
s?

Since rcu_barrier() blocks the current thread until all pending call_rcu()=
=20
callbacks across the entire kernel have completed, using it for regular=20
object destruction seems problematic.

If GPU drivers frequently create and destroy fence contexts dynamically=20
(such as per-process or per-timeline), could destroying a context become a=
=20
denial of service vector by repeatedly blocking kernel threads?

[ ... ]
> +    pub fn is_signaled(&self) -> bool {
> +        // We should not use `dma_fence_is_signaled_locked()` here, beca=
use
> +        // according to the C backend's recommendations, that function is
> +        // problematic and we should avoid calling that function with a =
lock
> +        // held.
> +
> +        // SAFETY: `fence` stems from `self`, which is valid by definiti=
on.
> +        let ret =3D unsafe { bindings::dma_fence_is_signaled(self.as_raw=
()) };
> +
> +        // To be as robust as possible for the future we guarantee that =
an API
> +        // caller can 100% rely on the signalling being completed (i.e.,=
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
> +
> +        let _ =3D self.lock();
> +
> +        ret
> +    }

[Severity: High]
Does acquiring the lock here cause a hard deadlock if called from a callbac=
k?

The is_signaled method intentionally acquires the fence spinlock to guarant=
ee=20
signaling completion. However, the C backend executes callbacks registered =
via=20
FenceCallbackRegistration with this exact same spinlock already held.

If a user calls fence.is_signaled() from within their callback implementati=
on,=20
would it attempt to recursively acquire the non-recursive Linux spinlock?

[ ... ]
> +unsafe impl<T: Send + Sync + FenceContextOps + 'static> ForeignOwnable f=
or DriverFence<'_, T> {
> +    type Borrowed<'a>
> +        =3D DriverFenceBorrow<'a, T>
> +    where
> +        Self: 'a;
> +    type BorrowedMut<'a>
> +        =3D DriverFenceBorrow<'a, T>
> +    where
> +        Self: 'a;
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

[Severity: High]
Does this implementation allow safe lifetime erasure of DriverFence?

The ForeignOwnable trait is implemented for DriverFence regardless of its=20
lifetime. Because into_foreign is a safe method that returns a raw pointer,=
=20
it completely erases the lifetime parameter of DriverFence.

Could safe Rust code call fence.into_foreign(), successfully ending the=20
borrow of FenceContext from the compiler's perspective without dropping the=
=20
fence? This might allow the FenceContext to be safely dropped, invalidating=
=20
the fctx pointer and leading to a use-after-free when the kernel later=20
accesses the exported fence.

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
> +        if !signaled {
> +            pr_err!("DriverFence drops unsignaled. Danger of memory corr=
uption!\n");
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
> +
> +            // SAFETY: `self.data` is valid because `self` is valid.
> +            let fctx =3D unsafe { self.data.as_ref().fctx };
> +            let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
> +        }
> +        drop(guard);

[Severity: Medium]
Can the nr_of_unsignaled_fences counter leak if the fence is signaled=20
externally?

The logic here only decrements the counter if dma_fence_test_signaled_flag=
=20
returns false. If another subsystem signals the fence through the C API, th=
e=20
signaled flag is set.

When this DriverFence is subsequently dropped, it appears it would skip the=
=20
decrement, permanently leaking the counter. Would this cause false-positive=
=20
memory corruption warnings later when the FenceContext is dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731080411.8487=
72-2-phasta@kernel.org?part=3D4
