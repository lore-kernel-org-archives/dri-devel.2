Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65130C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9757710EE9D;
	Wed, 12 Aug 2026 07:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="enu3bHZz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C12810EE9D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42F36416D6;
 Wed, 12 Aug 2026 07:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DE81F000E9;
 Wed, 12 Aug 2026 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786520327;
 bh=R57jKtSyofeSNd/7tg5u23RfYtRnv8BqBRwU2OvyfHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=enu3bHZzT88bYenFvHkufR7VYBcXOX19i+EzhqzhJ79KQcF2ARccpZya7scR/UZW1
 /LZLI3Hc7w99mEJT6SrMZeKIpzL37vYSnVJpaOl91lCGYe3ZR2pmJgRN/iEtQF1G8+
 KI6W1zsot8RsT1r3PflAmSumdqm4fgvXeHJCarh7sIHP2dh1wfsIVudC9UTTMNiHhP
 46tFbEMyZxQTae00ObMEegaB7J5xGtRk/cKjm4kOzUiZZN28FHvNZMUB6Fm+yBM3IU
 qrW/KIW41G2A3UhaOdtlXmtXrCsYvsbxashjurA23YhZMCxhyAQZNVqcqg7ayEyG6P
 4BuBgiL+cVYIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: media-ci@linuxtv.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260812072217.1971807-3-phasta@kernel.org>
References: <20260812072217.1971807-2-phasta@kernel.org>
 <20260812072217.1971807-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:38:46 +0000
Message-Id: <20260812073846.E3DE81F000E9@smtp.kernel.org>
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
- [Critical] Use-After-Free of FenceContext when a Fence outlives its Drive=
rFence or when `!needs_drop` bypasses RCU synchronization.
- [High] FenceContext will reliably trigger a kernel panic on drop if a Dri=
verFence is signaled by external C code.
- [High] Fence::is_signaled() unconditionally acquires the fence spinlock, =
leading to spinlock recursion deadlocks if called from a callback.
--

--- Patch [1]: [PATCH v10 1/2] rust: Add dma_fence abstractions ---
commit 4a2030e75f6de53abe7df28e7314d4e3c4ae44a8
Author: Philipp Stanner <phasta@kernel.org>

rust: Add dma_fence abstractions

C's dma_fence's are synchronisation primitives that will be needed by all
Rust GPU drivers.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> new file mode 100644
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

[Severity: Critical]
Is it possible for the FenceContext to be accessed after it is freed here?

The C dma_fence API allows callbacks like get_driver_name() to be invoked
at any time as long as the fence is alive (refcount > 0), even on signaled
fences. Because the Rust abstraction explicitly allows a Fence to outlive
its FenceContext, fctx can become a dangling pointer.

A userspace application calling SYNC_IOC_FILE_INFO or accessing debugfs
could trigger this after the driver has unloaded and the FenceContext is
dropped.

[ ... ]
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
> +        let _ =3D self.lock();
> +
> +        ret
> +    }

[Severity: High]
Can this spinlock acquisition cause a recursion deadlock?

The C dma_fence_is_signaled() function is explicitly lockless. By acquiring
the fence spinlock here, this wrapper introduces a blocking operation into
what is supposed to be a lockless API.

If a user registers a FenceCallback that invokes is_signaled() on the same
fence from within on_signal(), it will attempt to acquire the lock. Since
dma_fence_signal executes these callbacks with the spinlock already held,
this will result in an immediate deadlock.

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
d_flag(guard.as_raw()) };
> +        if !signaled {
> +            pr_err!("DriverFence drops unsignaled. Danger of memory corr=
uption!\n");
> +            // SAFETY: `guard` is valid until the `call_rcu()` below. Th=
e fence
> +            // must not have been signaled yet, which we check directly =
above.
> +            unsafe { bindings::dma_fence_set_error(guard.as_raw(), ECANC=
ELED.to_errno()) };
> +            // SAFETY: `guard` is valid until the `call_rcu()` below. Th=
e lock
> +            // must be held, which we acquired above.
> +            unsafe { bindings::dma_fence_signal_locked(guard.as_raw()) };
> +
> +            // SAFETY: `self.data` is valid because `self` is valid.
> +            let fctx =3D unsafe { self.data.as_ref().fctx };
> +            let _ =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
> +        }
> +        drop(guard);

[Severity: High]
Will this skip the counter decrement if the fence is signaled by external
C code?

If a C subsystem (like the DRM scheduler or a software signaling debugfs
hook) signals the DriverFence, the signaled variable will be true. If the
driver subsequently drops the DriverFence without calling signal(), this
block is skipped and the fetch_sub(1) decrement is permanently lost.

When the FenceContext is later dropped, it will unconditionally panic
because the counter is imbalanced:

rust/kernel/dma_buf/dma_fence.rs:FenceContext::drop() {
    ...
    if self.nr_of_unsignaled_fences.load(Relaxed) !=3D 0 {
        panic!("Forgotten fences in FenceContext.");
    }
    ...
}

> +
> +        // `DriverFenceData` but could be accessed through some dma_fence
> +        // callbacks right now. Access is being revoked in principle abo=
ve by
> +        // signalling the fence, but since the C backend does not guaran=
tee
> +        // perfect full synchronization, we have to wait for one grace p=
eriod to
> +        // ensure that all accessors of `DriverFenceData` (through the
> +        // dma_fence_ops accessible through a `Fence`) are gone.
> +
> +        if !core::mem::needs_drop::<T::FenceDataType>() {
> +            // SAFETY: Once a `DriverFence` is initialized, the inner `f=
ence` is
> +            // valid and initialized. It is valid until the refcount dro=
ps
> +            // to 0, which can earliest happen once we drop the `DriverF=
ence`'s reference
> +            // here.
> +            unsafe { bindings::dma_fence_put(self.as_raw()) };
> +            return;
> +        }

[Severity: Critical]
Does this optimization bypass the RCU synchronization required for safe
teardown?

If this block returns early, no RCU callback is queued. Consequently, when
the FenceContext drops, its rcu_barrier() call will not wait for a grace
period because there are no callbacks pending.

This allows the FenceContext to be freed immediately while concurrent C
readers holding RCU read locks might still be executing, leading to a
use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812072217.1971=
807-2-phasta@kernel.org?part=3D1
