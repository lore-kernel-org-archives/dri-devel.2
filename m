Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A434C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E2C10E47F;
	Wed, 22 Jul 2026 15:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ArBK4Umx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C8B10E487
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:03:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 572B4600AB;
 Wed, 22 Jul 2026 15:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96A41F000E9;
 Wed, 22 Jul 2026 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784732606;
 bh=StCaNx98Con2/LrfAD+lZ0J9j0+69xxAuDFWc/RiRy0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ArBK4UmxAgg4IweAuQnkWArg+Te5h4JTNW1X16zRAKco6YW/lyRhXrOEB2etgs3wf
 xUGRG7ylmmEYJ3pv9p6s/twg3DyE+3HKnUS0AmRvGW0jjRW+KlbyFcylfm9l3RkvlB
 DTX0N+hakz/KdsGr1cQ3rqCGsFollmWfKwH20QPSvl6uhlzEdvH3Hqv4w5D3Qeij1C
 +Gcw8g60VurSg/XP8ByFZfsDY5u9S7YWXM9FDQ6oZH91pVvsH4PKPJMjU8YXtgy4ZX
 ImaIadT+2LlgqJU4SFmGKs6T5vrwzqzE0C6M/KbDywAj//6MVJDjQLsxGgCMGNbSlm
 eOMiKm1AdDm2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] rust: Add dma_fence abstractions
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260722144931.1070312-7-phasta@kernel.org>
References: <20260722144931.1070312-2-phasta@kernel.org>
 <20260722144931.1070312-7-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:03:25 +0000
Message-Id: <20260722150325.C96A41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Use-After-Free of `FenceContext` in `dma_fence_ops` callbacks =
because `Fence` outlives the context.
- [Critical] Passing a NULL pointer for the spinlock to `dma_fence_init` vi=
olates the C API contract and causes an immediate kernel panic.
- [High] Concurrent allocation failures in `fence_alloc` corrupt the shared=
 sequence number atomic, causing duplicate sequence numbers.
- [High] Using `GFP_KERNEL` while holding a spinlock guard sleeps in atomic=
 context.
- [High] `FenceContext::drop` holds the XArray spinlock while invoking `dma=
_fence_signal_locked`, risking deadlocks and lock inversions.
- [High] Iterating from 0 to `highest_seqno` under a spinlock in `FenceCont=
ext::drop` causes unbounded latency and stalls.
- [High] Casting the 64-bit `seqno` to `usize` for XArray indexing truncate=
s on 32-bit platforms, causing index collisions.
- [High] Implementing `ForeignOwnable` for `DriverFence<'a, T>` erases its =
lifetime, allowing safe Rust code to trigger UAF.
- [Medium] Dropping a `DriverFence` without explicitly signaling it leaks `=
DriverFenceData` and the `Fence` in the XArray.
- [Medium] `FenceCallbackRegistration::new` leaks the callback state if `dm=
a_fence_add_callback` returns an error other than `ENOENT`.
--

--- Patch [5]: [PATCH v6 5/6] rust: Add dma_fence abstractions ---
commit df80ab90d41cfd4c4088816a593de340df6f198e
Author: Philipp Stanner <phasta@kernel.org>

rust: Add dma_fence abstractions

This commit adds Rust abstractions for the dma_fence framework. It provides
DriverFence for signaling and Fence for consumption, tying them to a
DmaFenceContext to manage sequence numbering and timelines.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 0000000000000..a7d9e22e7e81e 100644
> --- /dev/null
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -147,15 +147,15 @@ impl<'a, T: Send + Sync + FenceContextOps> FenceCon=
text<T> {
>      fn get_next_seqno(&self) -> u64 {
>          self.seqno.fetch_add(1, Relaxed)
>      }
> =20
>      fn decrement_seqno(&self) {
>          let _ =3D self.seqno.fetch_sub(1, Relaxed);
>      }
> =20

[ ... ]

> @@ -178,14 +178,14 @@ impl<'a, T: Send + Sync + FenceContextOps> FenceCon=
text<T> {
>                  // Take the next seqno right now, so that we can use it =
for pre-allocating
>                  // an entry in the xarray.
>                  let seqno: u64 =3D self.get_next_seqno();
> =20
>                  match self.fences.reserve(seqno as usize, GFP_KERNEL) {

[Severity: High]
Does casting the 64-bit seqno to usize for XArray indexing cause truncation
on 32-bit platforms?

DMA fence sequence numbers are u64 to prevent wrap-around. When the sequence
number exceeds u32::MAX, the cast to usize on 32-bit platforms truncates the
value. Will this overwrite existing unsignaled fences in the XArray and cau=
se
fatal corruption of the fence tracking mechanism?

>                      Ok(reservation) =3D> Ok(DriverFenceAllocation {
>                          data,
>                          seqno,
>                          reservation,
>                          ops: &Self::OPS,
>                      }),
>                      Err(e) =3D> {
>                          self.decrement_seqno();

[Severity: High]
Does rolling back the sequence number corrupt the timeline?

If the reservation fails, the code calls self.decrement_seqno(), which exec=
utes
fetch_sub(1, Relaxed).

If Thread B acquires seqno 2, and Thread A (which acquired seqno 1) fails a=
nd
decrements the counter back to 1, won't a subsequent Thread C be assigned s=
eqno
2, creating duplicate sequence numbers and breaking the DMA fence timeline
guarantees?

>                          Err(e)
>                      }
>                  }
>              }

[ ... ]

> @@ -189,14 +189,14 @@ impl<'a, T: Send + Sync + FenceContextOps> FenceCon=
text<T> {
>      extern "C" fn get_driver_name(ptr: *mut bindings::dma_fence) -> *con=
st c_char {
>          // SAFETY: The C backend only invokes this callback with ptr poi=
nting
>          // to a valid, unsignaled bindings::dma_fence. All fences create=
d in
>          // this module always reside within Fence which always resides i=
n a
>          // DriverFenceData, thus satisfying the function's safety
>          // requirements.
>          let fctx =3D unsafe { Self::from_raw_fence(ptr) };
> =20
>          fctx.driver_name.as_char_ptr()
>      }
> =20
>      extern "C" fn get_timeline_name(ptr: *mut bindings::dma_fence) -> *c=
onst c_char {
>          // SAFETY: The C backend only invokes this callback with ptr poi=
nting
>          // to a valid, unsignaled bindings::dma_fence. All fences create=
d in
>          // this module always reside within Fence which always resides i=
n a
>          // DriverFenceData, thus satisfying the function's safety
>          // requirements.
>          let fctx =3D unsafe { Self::from_raw_fence(ptr) };
> =20
>          fctx.timeline_name.as_char_ptr()
>      }

[Severity: Critical]
Can this code introduce a use-after-free risk?

If a Fence is exported to userspace (for example via a sync_file), userspace
could call SYNC_IOC_FILE_INFO on the descriptor after the driver's job is
complete and the FenceContext has been dropped.

This triggers the C backend to call fence->ops->get_driver_name. The Rust
callback retrieves the FenceContext reference from the DriverFenceData and
dereferences fctx.driver_name.

Since FenceContext::drop does not wait for the Fence refcount to drop to 0,
does this result in a direct read from freed memory?

[ ... ]

> @@ -248,15 +248,15 @@ impl<T: FenceContextOps + Send + Sync> PinnedDrop f=
or FenceContext<T> {
>      fn drop(self: Pin<&mut Self>) {
>          let highest_seqno =3D self.get_current_seqno();
> =20
>          let fences_guard =3D self.fences.lock();
> =20
>          // TODO: Implement a public iterator for XArray and use it here.
>          for seqno in 0..highest_seqno {

[Severity: High]
Could iterating from 0 to highest_seqno under a spinlock cause unbounded
latency and stalls?

FenceContext::drop linearly loops from 0 to highest_seqno, performing an XA=
rray
lookup on every iteration while holding the fences_guard spinlock.

Since drivers often initialize FenceContext with a very large initial_seqno,
could this loop run billions of times with preemption disabled?

>              if let Some(fence) =3D fences_guard.get(seqno as usize) {
>                  let fence =3D fence.lock();
> =20
>                  // SAFETY: We still hold a reference, thus the pointer i=
s valid.
>                  let signaled: bool =3D
>                      unsafe { bindings::dma_fence_test_signaled_flag(*fen=
ce.deref()) };
>                  if !signaled {
>                      // SAFETY: We still hold a reference, thus the point=
er is
>                      // valid. The fence must not have been signaled yet,=
 which we
>                      // check directly above. The lock must be held, whic=
h we
>                      // acquired above.
>                      unsafe { bindings::dma_fence_set_error(*fence.deref(=
), ECANCELED.to_errno()) };
>                      // SAFETY: We still hold a reference, thus the point=
er is
>                      // valid. The lock must be held, which we acquired a=
bove.
>                      unsafe { bindings::dma_fence_signal_locked(*fence.de=
ref()) };

[Severity: High]
Is it safe to invoke dma_fence_signal_locked while holding the subsystem
internal XArray lock?

While holding the fences_guard spinlock, the code calls
bindings::dma_fence_signal_locked. This synchronously invokes any registered
dma_fence_ops callbacks.

If any callback attempts to interact with the same FenceContext, or attempts
to take a driver lock that is held elsewhere while a fence is signaled, won=
't
this guarantee an ABBA deadlock?

>                  } else {
>                      pr_warn!("Signaled Fences in FenceContext.");
>                  }
>              }

[ ... ]

> @@ -357,11 +357,11 @@ impl<T: FenceCallback> FenceCallbackRegistration<T>=
 {
>                              // and pass it to the user again.
>                              let cb_back =3D unsafe { ManuallyDrop::take(=
callback) };
>                              Err(CallbackError::AlreadySignaled(cb_back))
>                          } else {
>                              Err(CallbackError::Other(e))
>                          }

[Severity: Medium]
Does this code leak the callback state if dma_fence_add_callback returns
an error other than ENOENT?

The user's callback is moved into a ManuallyDrop<T>. If the C backend fails
with an error other than ENOENT, the error is returned directly.

Because the callback is never extracted from ManuallyDrop on this error pat=
h,
is it permanently leaked when the partially initialized struct is cleaned u=
p?

[ ... ]

> @@ -668,14 +668,14 @@ impl<'a, T: Send + Sync + FenceContextOps> DriverFe=
nceAllocation<'a, T> {
>      pub fn new_fence(self) -> DriverFence<'a, T> {
>          // We feed the C dma_fence backend a NULL for the spinlock so th=
at it
>          // uses per-fence locks automatically.
>          let null_ptr: *mut bindings::spinlock =3D ptr::null_mut();
>          let fence_ptr =3D self.as_raw();
>          // SAFETY: fence_ptr has been created directly above. It will li=
ve
>          // at least as long as Self. The same applies to &Self::OPS.
>          unsafe {
>              bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self=
.data.fctx.nr, self.seqno)
>          };

[Severity: Critical]
Will this hardcoded NULL pointer passed directly to the C initialization
function cause an immediate kernel panic?

The C implementation in drivers/dma-buf/dma-fence.c starts with BUG_ON(!loc=
k).
Does passing ptr::null_mut() here violate the C API contract and crash the
system upon fence creation?

> =20
>          let fence =3D ARef::from(&self.data.inner);
>          let mut fences_guard =3D self.data.fctx.fences.lock();
>          // Can never be an error because we already allocated an entry f=
or
>          // exactly this sequence number.
>          // TODO: write some sort of XArray::replace() function or mechan=
ism for
>          // reserving entries so that this can obviously never fail.
>          if fences_guard
>              .store(self.seqno as usize, fence, GFP_KERNEL)
>              .is_err()
>          {

[Severity: High]
Is it safe to use GFP_KERNEL while holding a spinlock guard?

The code acquires the XArray spinlock via self.data.fctx.fences.lock(), and
then calls fences_guard.store() with GFP_KERNEL.

Since GFP_KERNEL implies __GFP_DIRECT_RECLAIM, which allows the allocation =
to
sleep, doesn't this strictly violate atomic context constraints and risk sy=
stem
deadlocks?

[ ... ]

> @@ -768,7 +768,7 @@ impl<'a, T: Send + Sync + FenceContextOps> Deref for =
DriverFenceBorrow<'a, T> {
>      }
>  }
> =20
>  // SAFETY: The Rust dma_fence abstractions are already designed around t=
he inner
>  // C dma_fence, which can serve safely as the identification point when =
being
>  // owned by C. Moreover, safety is ensured by not dropping DriverFence a=
nd by
>  // only allowing operations without side effects on the Borrowed type.
>  unsafe impl<T: Send + Sync + FenceContextOps + 'static> ForeignOwnable f=
or DriverFence<'_, T> {

[Severity: High]
Does implementing ForeignOwnable for DriverFence erase its lifetime?

The DriverFence type relies on its lifetime to ensure it cannot outlive its
associated FenceContext. Implementing ForeignOwnable for DriverFence allows
safe Rust code to convert the object into a raw pointer.

When it is later reconstructed from the raw pointer, the compiler cannot en=
force
the lifetime dependency. Could this allow it to outlive the FenceContext and
trigger a use-after-free when accessing the context to signal the fence?

[ ... ]

> @@ -833,14 +833,14 @@ impl<'a, T: Send + Sync + FenceContextOps> Drop for=
 DriverFence<'a, T> {
>      fn drop(&mut self) {
>          let guard =3D self.as_fence().lock();
> =20
>          // Use dma_fence_test_signaled_flag() instead of
>          // dma_fence_is_signaled_locked() because the C backend wants to=
 get rid
>          // of the latter.
> =20
>          // SAFETY: guard is valid until the call_rcu() below.
>          let signaled: bool =3D unsafe { bindings::dma_fence_test_signale=
d_flag(*guard.deref()) };
>          if warn_on!(!signaled) {
>              // SAFETY: guard is valid until the call_rcu() below. The fe=
nce
>              // must not have been signaled yet, which we check directly =
above.
>              unsafe { bindings::dma_fence_set_error(*guard.deref(), ECANC=
ELED.to_errno()) };
>              // SAFETY: guard is valid until the call_rcu() below. The lo=
ck
>              // must be held, which we acquired above.
>              unsafe { bindings::dma_fence_signal_locked(*guard.deref()) };
>          }
>          drop(guard);
> =20
>          // SAFETY: Valid because self is valid.
>          let rcu_head_ptr =3D unsafe { &raw mut (*self.data.as_ptr()).rcu=
_head };

[Severity: Medium]
Should this drop implementation clean up the fctx.fences XArray entry?

If a DriverFence drops without being explicitly signaled first, this code
signals it with -ECANCELED and schedules RCU destruction, but fails to remo=
ve
the fence from the XArray.

Will the XArray continue to hold an ARef<Fence>, keeping the dma_fence
reference count above zero indefinitely and causing a permanent memory leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722144931.1070=
312-2-phasta@kernel.org?part=3D5
