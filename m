Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A06BCD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89118112B21;
	Fri,  5 Jun 2026 13:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dsGoe/F9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC11112B21
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:46:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C047600AF
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A8A1F00893;
 Fri,  5 Jun 2026 13:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780667194;
 bh=fDg43M2B9PlNWHiDy1AMMtGyAjwDnQ27B4JUT5jEEZY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dsGoe/F9w9ptQ3CBgBk5aWhc6h4s3+Efel29SxbZNJ0/YLXAbkJ5seI4oKo3xxFiI
 pp5wRSpjhbHe7OwY+YUjs19bTbd7zsM9XIezIgihDOPb2dHYKBxrSS9ZmMLNN04LiG
 C1wSLLu6y5tXCJmg1aFOU7gNnYs/r4tAl0q3ctJ3xVVLfabIwKqQf3/ZyLQtqyytXb
 LBAwSwQ8aE/Xt6NreB+6dMKrHqHzP/qEgaWZJQhmFjw0yoY7fVxqP7FJoWFsWTNhVo
 WyeK9RujJycOvM5sK0hpIpMSBJzr/kuwUADvNx0HqAYfno9ETk6WrE4WJk5X2fvnIS
 WNUulBYdxdmlA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] rust: rcu: Introduce RcuFreeBox
To: "Boqun Feng" <boqun@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 ojeda@kernel.org
In-Reply-To: <20260605133541.22569-6-boqun@kernel.org>
References: <20260605133541.22569-6-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:46:33 +0000
Message-Id: <20260605134633.D5A8A1F00893@smtp.kernel.org>
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
- [Critical] Pointer cast bypasses struct field offset, causing `drop_befor=
e_gp` to operate on `rcu_head` instead of `value`.
- [High] `RcuFreeBox::drop` creates a mutable reference (`&mut T`) before t=
he RCU grace period elapses, violating Rust's strict aliasing rules.
- [High] `RcuFreeBox` wraps `T` in `ManuallyDrop<T>`, bypassing its destruc=
tor and creating an unresolvable leak or Use-After-Free dilemma.
- [Low] Missing `#[inline]` annotations on small/forwarding functions in th=
e new abstraction.
- [Low] Multiple spelling errors in the code comments.
--

commit 78e35ac6ad00fb0c6ab7802573453596f9ee6134
Author: Boqun Feng <boqun@kernel.org>

rust: rcu: Introduce RcuFreeBox

The current RcuBox calls the drop function after a grace period inside an R=
CU
callback. To support a pattern where an object is cleaned up, unshared, and
freed after a grace period without readers, RcuFreeBox is introduced.

> diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_b=
ox.rs
> index 943fe3e8974e0..8f52bb472daf9 100644
> --- a/rust/kernel/sync/rcu/rcu_box.rs
> +++ b/rust/kernel/sync/rcu/rcu_box.rs

[ ... ]

> @@ -205,6 +207,50 @@ fn drop(&mut self) {
>      drop(unsafe { Box::<_, A>::from_raw(box_inner) });
>  }
> =20
> +/// A box that is freed with RCU.
> +///
> +/// Currently we require T being Send because of an implementation limit=
ation. In theory we can
> +/// support T being !Send, since the RCU callback is only used to free t=
he memory, not dropping
> +/// T.
> +pub struct RcuFreeBox<T: Send + RcuFreeSafe, A: Allocator>(RcuBox<Manual=
lyDrop<T>, A>);
> +
> +impl<T: Send + RcuFreeSafe, A: Allocator> RcuFreeBox<T, A> {
> +    /// Create a new RcuFreeBox.
> +    pub fn new(x: T, flags: alloc::Flags) -> Result<Self, AllocError> {

[Severity: Low]
Does this function need an inline annotation? The Rust subsystem guidelines
mention that small or forwarding functions in abstractions should be
annotated with #[inline].

> +        Ok(Self(RcuBox::new(ManuallyDrop::new(x), flags)?))
> +    }
> +
> +    /// Access the value for a grace period.
> +    pub fn with_rcu<'rcu>(&self, read_guard: &'rcu Guard) -> &'rcu T {

[Severity: Low]
Should this small forwarding function also have an #[inline] annotation?

> +        self.0.with_rcu(read_guard)
> +    }
> +}
> +
> +impl<T: Send + RcuFreeSafe, A: Allocator> Deref for RcuFreeBox<T, A> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &T {

[Severity: Low]
Would an #[inline] annotation be appropriate for this Deref implementation
as well, since it is a simple forwarding call?

> +        self.0.deref()
> +    }
> +}
> +
> +impl<T: Send + RcuFreeSafe, A: Allocator> Drop for RcuFreeBox<T, A> {
> +    fn drop(&mut self) {
> +        // CAST: ManuallyDrop<T> is transparet to T, adn RcuBox owns the=
 object per type

[Severity: Low]
There are a couple of typos here: transparet instead of transparent, and adn
instead of and.

> +        // invariants.
> +        let ptr =3D self.0 .0.as_ptr().cast::<T>();

[Severity: Critical]
Is this pointer cast skipping the struct field offset?

self.0.0.as_ptr() returns a pointer to RcuBoxInner<ManuallyDrop<T>>. The
RcuBoxInner struct starts with an rcu_head field, meaning the actual value
field is located at a non-zero offset.

Casting this pointer directly to *mut T will point to the rcu_head memory
instead of the value.

Could calling drop_before_gp() on this pointer corrupt memory by treating
the internal rcu_head structure bytes as if they were of type T?

> +
> +        // SAFETY: Per the invariants of RcuBox, ptr owns the pointed ob=
ject. And we are not
> +        // going to move it.
> +        let pin =3D unsafe { Pin::new_unchecked(&mut *ptr) };

[Severity: High]
Does creating a mutable reference here violate Rust's strict aliasing rules?

When an RcuFreeBox is dropped, it is typically removed from the shared data
structure, but the RCU grace period has not yet elapsed. Concurrent readers
might still hold shared references (&T) obtained via with_rcu.

Creating an exclusive mutable reference (&mut T) using Pin::new_unchecked
while shared references may still exist is immediate undefined behavior in
Rust.

> +
> +        pin.drop_before_gp();
> +
> +        // needs_drop::<ManuallyDrop>() returns false, hence kvfree_call=
_rcu() will be called

[Severity: High]
Could bypassing the destructor using ManuallyDrop<T> create an unresolvable
leak or use-after-free regression?

Since needs_drop::<ManuallyDrop<T>>() evaluates to false, it skips dropping
the internals of T. If T holds owned resources like a Box or Vec, they are
never freed after the grace period, which leaks memory.

Conversely, if a user tries to work around this by manually freeing
resources inside drop_before_gp(), could that trigger a use-after-free
since drop_before_gp() runs before the RCU grace period ends while
concurrent readers might still be accessing those resources?

> +        // and free the underlying data after a gracer period.

[Severity: Low]
There is a typo here: gracer instead of grace.

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605133541.2256=
9-1-boqun@kernel.org?part=3D3
