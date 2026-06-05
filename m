Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AB5CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FFA112B2C;
	Fri,  5 Jun 2026 13:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RfJBG7+A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490A9112B2C
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:49:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DF8243E76
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C0E1F00893;
 Fri,  5 Jun 2026 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780667375;
 bh=NOPCHrzvq5CVQ0Mcn5Bk28yhps2kKyAdDW4GC+Kd1wE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RfJBG7+AKc4vFm0yolWSn6ut3MzqJ/i+zK+QagG1WD0OEeDNux64PFP5Fjr352I/9
 UehLP4Ft8uwgK9MlwAJ9OgwBflybZZb0Ze/yVgJ+7pL6wyGPWQhDjmF6DCcvFAB9i6
 9Ckn00rSWP8DeR+gT43utpRsc15S1bzR3mKGH/PgqThZtME/ifD0O3/1PvFkP5Jwg4
 GwZxrIyac14aj8wmhjJ5TRPK8/8BVhOGYtfCLYOqAbi9hp7iDsW7Tqf8dcQ3NxI10a
 5+P3w/0fQzjbBslaXhd6dpXvI4ZpebxeplcOrOjQuKihM27qkIjP87/yZDukz46deT
 X7KIXbdh15W+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] rust: rcu: add RcuBox type
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org
In-Reply-To: <20260605133541.22569-2-boqun@kernel.org>
References: <20260605133541.22569-2-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:49:35 +0000
Message-Id: <20260605134935.B6C0E1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] RcuBox::into_foreign drops `self` instead of forgetting it, ca=
using a guaranteed Use-After-Free.
- [High] RcuBox::drop bypasses the custom Allocator A and hardcodes kvfree_=
call_rcu() for types that do not require dropping, causing undefined behavi=
or for non-kvfree compatible allocators.
--

commit f69c06884595bb68a76f4f1dd4014ee9e2c9e31c
Author: Alice Ryhl <aliceryhl@google.com>

rust: rcu: add RcuBox type
   =20
This adds an RcuBox container, which is like Box except that the value
is freed after waiting for one grace period (via {kvfree_,}call_rcu()).
To allow containers to rely on the RCU properties of RcuBox, an
extension of ForeignOwnable is added.

> diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_b=
ox.rs
> new file mode 100644
> index 0000000000000..943fe3e8974e0
> --- /dev/null
> +++ b/rust/kernel/sync/rcu/rcu_box.rs

[ ... ]

> +// SAFETY:
> +// * The `RcuBoxInner<T>` was allocated with `A`.
> +// * `NonNull::as_ptr` returns a non-null pointer.
> +unsafe impl<T: Send + 'static, A: Allocator> ForeignOwnable for RcuBox<T=
, A> {
> +    const FOREIGN_ALIGN: usize =3D <Box<RcuBoxInner<T>, A> as ForeignOwn=
able>::FOREIGN_ALIGN;
> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D &'a T;
> +
> +    fn into_foreign(self) -> *mut c_void {
> +        self.0.as_ptr().cast()
> +    }

[Severity: Critical]
Since `self` is consumed by value here without being wrapped in `ManuallyDr=
op`
or passed to `core::mem::forget()`, won't it be dropped at the end of this
method?

This seems like it would immediately schedule the memory for RCU free, caus=
ing
a use-after-free for the foreign code when it later accesses the pointer.

> +
> +    unsafe fn from_foreign(ptr: *mut c_void) -> Self {

[ ... ]

> +impl<T: Send, A: Allocator> Drop for RcuBox<T, A> {
> +    fn drop(&mut self) {
> +        // SAFETY: The `rcu_head` field is in-bounds of a valid allocati=
on.
> +        let rcu_head =3D unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
> +        if core::mem::needs_drop::<T>() {
> +            // SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInne=
r<T>`. All users will be
> +            // gone in an rcu grace period. This is the destructor, so w=
e may pass ownership of the
> +            // allocation.
> +            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T,=
 A>)) };
> +        } else {
> +            // SAFETY: All users will be gone in an rcu grace period.
> +            // TODO: We are luckily since `kvfree_call_rcu()` works on b=
oth kmalloc and vmalloc,
> +            // maybe a new `Allocator` method is needed.
> +            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr()=
.cast()) };

[Severity: High]
Since `RcuBox` is generic over any custom `A: Allocator`, wouldn't calling
`kvfree_call_rcu()` here break for allocators other than kmalloc or vmalloc?

Does this need to always route through `A::free()` via `drop_rcu_box`, or
should `A` be explicitly bounded to an allocator trait that supports
`kvfree_rcu`?

> +        }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605133541.2256=
9-1-boqun@kernel.org?part=3D1
