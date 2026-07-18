Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC894C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 05:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D1D10E532;
	Sat, 18 Jul 2026 05:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QDptKh9W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672B310E32D
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 05:42:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DD456001A;
 Sat, 18 Jul 2026 05:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF91F1F000E9;
 Sat, 18 Jul 2026 05:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784353374;
 bh=BCSHuIQWbOyvTRwfZH96kR6QQqrLNcsCch9jFgQC1SM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QDptKh9WV2S1opc6EbEmDLPQ9NcUSpbvLKPbS6sFwrZXEP0dunemtpxqovx6BECT4
 DOJ5RH/IQ0NuLjxMfnCBK84cX364KfQDTPfzVNDkAL3WZz2W5NCcf2dXh/VatRtG/y
 VOcGoYyndH85SJ3hb+yTLF1SaZMfjtvIrVhQCdx6OuKPzin7HaXTzdZV4k0FLRZ5Ie
 Qk20qjuRXQ/R4xP4LiMlxYbDdYC23kLcDUm8oXCEzlIRU9vlMu+eZMkn5HsVmbDEUb
 nKTy6cGIMIE4fBODn8QLtBeLQ3cFyDq+t44ac0Etwplvo/jqilMuS7xDrYTh0QwhzZ
 Qr92Xwh+gTsmQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] rust: rcu: Introduce RcuFreeBox
To: "Boqun Feng" <boqun@kernel.org>
Cc: media-ci@linuxtv.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260718053247.25154-4-boqun@kernel.org>
References: <20260718053247.25154-1-boqun@kernel.org>
 <20260718053247.25154-4-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 05:42:53 +0000
Message-Id: <20260718054253.EF91F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] `RcuFreeBox::drop` creates an exclusive mutable reference (`&mut T=
`) while concurrent RCU readers may exist, causing Undefined Behavior (Muta=
ble Aliasing).
- [High] `RcuFreeBox` permanently skips `T::drop()`, silently leaking inner=
 resources or forcing developers into Use-After-Free traps.
- [High] Casting between `*mut RcuBoxInner<ManuallyDrop<T>>` and `*mut RcuB=
oxInner<T>` relies on unguaranteed memory layout, resulting in Undefined Be=
havior.
- [High] If memory allocation fails in `RcuFreeBox::new()`, the inner objec=
t is silently leaked.
- [Medium] `RcuFreeBox` lacks implementations for `ForeignOwnable` and `For=
eignOwnableRcu`, making it completely unusable in RCU data structures.
- [Low] Missing `#[inline]` annotations on small forwarding functions in an=
 abstraction.

Pre-existing issues:
- [High] `RcuBox::drop` unconditionally invokes `kvfree_call_rcu`, bypassin=
g custom generic allocators and causing kernel memory corruption.
--

--- Patch [3]: [RFC PATCH v2 3/4] rust: rcu: Introduce RcuFreeBox ---
commit a85d6377ca5df1e0c96d95e2dd50fb0b8a721195
Author: Boqun Feng <boqun@kernel.org>
Subject: rust: rcu: Introduce RcuFreeBox

This commit introduces RcuFreeBox, which extends RcuBox to support an RCU
usage pattern where objects are cleaned up before a grace period and freed
afterwards. It provides methods to unshare an object from future RCU
readers and wait for a grace period before safely freeing the memory.

> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index 42f6bbc83f71f..e781a5044de9b 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
[ ... ]
> @@ -100,3 +104,33 @@ pub trait ForeignOwnableRcu: ForeignOwnable {
>      /// [`from_foreign`]: ForeignOwnable::from_foreign
>      unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorrowed=
<'a>;
>  }
> +
> +/// Declares a struct is safe to free after a grace period if all reader=
s are guarded by RCU.
> +///
> +/// # Safety
> +///
> +/// Implementation must guarantee `drop_before_gp()` makes sure no futur=
e RCU reader will access
> +/// any part of [`Self`], as a result, after `drop_before_gp()` return +=
 one grace period, no RCU
> +/// reader will be on the object, and it's safe to free it.
> +///
> +/// Notes for implementators: implementing this trait in general require=
s `Self` being a
> +/// [`UnsafePinned`], i.e. a `&mut Self` is not a noalias reference if `=
Self` has non-trivial
> +/// `drop()` function.
> +pub unsafe trait RcuFreeSafe {
> +    /// Clean up `Self` and make it ready to be RCU freed.
> +    fn drop_before_gp(self: Pin<&mut Self>);

[Severity: High]
Does this trait signature inherently force a mutable aliasing violation?

By requiring a mutable reference here, does this force the caller to
create an exclusive reference while concurrent RCU readers may still hold
shared references to the object?

> +}
[ ... ]
> diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_b=
ox.rs
> index cb1fd422480a8..ab4e9b2a44448 100644
> --- a/rust/kernel/sync/rcu/rcu_box.rs
> +++ b/rust/kernel/sync/rcu/rcu_box.rs
[ ... ]
> @@ -223,6 +225,56 @@ fn drop(&mut self) {
>      drop(unsafe { Box::<_, A>::from_raw(box_inner) });
>  }
> =20
> +/// A box that is freed with RCU.
> +///
> +/// Currently we require `T` being `Send` because of an implementation l=
imitation. In theory we can
> +/// support `T` being `!Send`, since the RCU callback is only used to fr=
ee the memory, not dropping
> +/// `T`.
> +pub struct RcuFreeBox<T: Send + RcuFreeSafe, A: Allocator>(RcuBox<Manual=
lyDrop<T>, A>);

[Severity: Medium]
How can this struct be used in RCU data structures?

Since it lacks implementations for ForeignOwnable and ForeignOwnableRcu,
and its inner RcuBox field is private, is it structurally possible to
convert this to a foreign pointer or share it with RCU readers?

> +
> +impl<T: Send + RcuFreeSafe, A: Allocator> RcuFreeBox<T, A> {
> +    /// Create a new `RcuFreeBox`.
> +    pub fn new(x: T, flags: alloc::Flags) -> Result<Self, AllocError> {

[Severity: Low]
Should this small forwarding function have an inline annotation?

> +        Ok(Self(RcuBox::new(ManuallyDrop::new(x), flags)?))

[Severity: High]
Does this silently leak the inner object on allocation failure?

If RcuBox::new() returns an AllocError, the ? operator will abort the
function. Because ManuallyDrop intentionally prevents the Drop
implementation of its inner value from running, does this leak the object
and any dynamic resources it holds?

> +    }
> +}
> +
> +impl<T: Send + RcuFreeSafe, A: Allocator> Deref for RcuFreeBox<T, A> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &T {

[Severity: Low]
Should this trivial deref forwarder have an inline annotation?

> +        self.0.deref()
> +    }
> +}
> +
> +impl<T: Send + RcuFreeSafe, A: Allocator> Drop for RcuFreeBox<T, A> {
> +    fn drop(&mut self) {

[Severity: High]
This isn't a bug introduced by this patch, but does the underlying
RcuBox::drop unconditionally bypass custom allocators?

When core::mem::needs_drop::<T>() evaluates to false, RcuBox::drop
bypasses the allocator A and calls bindings::kvfree_call_rcu():

RcuBox::drop() {
    ...
    unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr().cast()) };
    ...
}

If a custom allocator (such as a module-specific slab cache) is used,
will passing its pointer to kvfree result in memory corruption?

> +        // CAST: `ManuallyDrop<RcuBoxInner<T>>` is transparent to `RcuBo=
xInner<T>`, and `RcuBox`
> +        // owns the object per type invariants.
> +        let inner: *mut RcuBoxInner<T> =3D self.0 .0.as_ptr().cast();

[Severity: High]
Does casting between these types rely on unguaranteed memory layout?

Both RcuBoxInner<ManuallyDrop<T>> and RcuBoxInner<T> use the default
repr(Rust) layout.

Since the Rust compiler provides no layout guarantees for generic
repr(Rust) structs across different type parameters, can fields be
arbitrarily reordered, making this cast undefined behavior?

> +
> +        // SAFETY: Per the invariants of `RcuBox`, `inner` owns the poin=
ted object. And we are not
> +        // going to move it.
> +        let pin =3D unsafe { Pin::new_unchecked(&mut (*inner).value) };

[Severity: High]
Does creating this exclusive mutable reference cause undefined behavior?

When RcuFreeBox::drop() executes before the RCU grace period,
pre-existing RCU readers may still be traversing the object and holding
shared references.

Does forming a mutable reference while shared references are active
violate Rust aliasing rules?

> +
> +        pin.drop_before_gp();
> +
> +        // `needs_drop::<ManuallyDrop>()` returns `false`, hence `kvfree=
_call_rcu()` will be called
> +        // and free the underlying data after a grace period.

[Severity: High]
Does permanently skipping T::drop() force a memory leak or a
use-after-free?

Because ManuallyDrop evaluates needs_drop to false, kvfree_call_rcu()
will only free the outermost struct after the grace period, bypassing
T::drop().

If T owns dynamic resources like a Box or Vec, will they permanently leak?

If a developer attempts to fix the leak by manually dropping the inner
fields inside drop_before_gp(), will they trigger a use-after-free
because concurrent RCU readers can still access those fields before the
grace period ends?

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718053247.2515=
4-1-boqun@kernel.org?part=3D3
