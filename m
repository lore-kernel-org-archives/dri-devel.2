Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8130FC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 05:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9512810E32D;
	Sat, 18 Jul 2026 05:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y8N5GWyM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6573710E32D
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 05:48:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D58843D4F;
 Sat, 18 Jul 2026 05:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB74B1F000E9;
 Sat, 18 Jul 2026 05:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784353698;
 bh=96W4orZvI4Wv4J8ED0NDiSiibWsNvz85CtwcJO0kV/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y8N5GWyMYxPg+Il8oYZDPWiHMvMjC1F0HIJp1a40f3zP1irftu1Y4TtEsdbAMZv/t
 8PY/yA5hiOuYHGgeTPIjOqq1p9JpxrAB+t1f/j7pr5xFocbX7N6oO8PGJzkt3MYWs7
 Vib3uBFRHllut0J7SiDRZRiSmGeeQoaZRxosBEJT2qCMRqzwyky0VyuhMOkYt/cSce
 Qm81/UzCtY7/+8cZsuLkzz8mOXZSpZPIqiALt8EVVkVihqhs71qQre2gMo/AY2XVke
 n7ySkHF2kEEvHTjR7AOk7IOjkFJGbhNF+wnCpUWDGz+KIqKMlS3xmFpfn9pGrp+sXp
 kJmsEshkVh2GA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/4] rust: rcu: Add RcuBox type
To: "Boqun Feng" <boqun@kernel.org>
Cc: media-ci@linuxtv.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260718053247.25154-2-boqun@kernel.org>
References: <20260718053247.25154-1-boqun@kernel.org>
 <20260718053247.25154-2-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 05:48:17 +0000
Message-Id: <20260718054817.BB74B1F000E9@smtp.kernel.org>
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
- [Critical] `RcuBox` lacks a `'static` bound on `T`, which allows asynchro=
nous Use-After-Free for types with custom Drop implementations that contain=
 non-'static references.
- [High] `RcuBox<T, A>` bypasses the generic `Allocator`'s free method in i=
ts `Drop` implementation when `needs_drop::<T>()` is false, leading to inva=
lid frees for custom allocators.
- [High] `RcuBox` safely uses `call_rcu()` with a monomorphized callback `d=
rop_rcu_box`, but Rust does not expose `rcu_barrier()`, making safe module =
unload impossible.
--

--- Patch [1]: [RFC PATCH v2 1/4] rust: rcu: Add RcuBox type ---
commit b7ba3ecd614c74b985c54d7b0785315fa2c066c8
Author: Alice Ryhl <aliceryhl@google.com>

rust: rcu: Add RcuBox type

This adds an RcuBox container, which is like Box except that the value
is freed after waiting for one grace period (via {kvfree_,}call_rcu()).
To allow containers to rely on the RCU properties of RcuBox, an
extension of ForeignOwnable is added.

> diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_b=
ox.rs
> new file mode 100644
> index 0000000000000..cb1fd422480a8
> --- /dev/null
> +++ b/rust/kernel/sync/rcu/rcu_box.rs

[ ... ]

> +/// A box that is freed with rcu.
> +///
> +/// The value must be Send, as rcu may drop it on another thread.
> +///
> +/// # Invariants
> +///
> +/// * The pointer is valid and references a pinned RcuBoxInner<T> alloca=
ted with A.
> +/// * This RcuBox holds exclusive permissions to rcu free the allocation.
> +pub struct RcuBox<T: Send, A: Allocator>(NonNull<RcuBoxInner<T>>, Phanto=
mData<A>);

[Severity: Critical]
Since the drop implementation can delegate the actual drop to an asynchrono=
us
background task via call_rcu, could a type with a non-static lifetime
trigger a use-after-free if its custom drop implementation accesses a scoped
reference after it goes out of scope?

Would it be safer to require T: 'static here?

[ ... ]

> +impl<T: Send, A: Allocator> Drop for RcuBox<T, A> {
> +    fn drop(&mut self) {
> +        // SAFETY: The rcu_head field is in-bounds of a valid allocation.
> +        let rcu_head =3D unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
> +        if core::mem::needs_drop::<T>() {
> +            // SAFETY: rcu_head is the rcu_head field of RcuBoxInner<T>.=
 All users will be
> +            // gone in an rcu grace period. This is the destructor, so w=
e may pass ownership of the
> +            // allocation.
> +            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T,=
 A>)) };

[Severity: High]
Does this monomorphized callback require modules to use rcu_barrier() during
unload to prevent executing unloaded memory?

Since rcu_barrier() isn't exposed in the Rust bindings yet, is there a way
for loadable modules using RcuBox to safely unload without risking a regres=
sion
if the RCU grace period hasn't completed?

> +        } else {
> +            // SAFETY: All users will be gone in an rcu grace period.
> +            // TODO: We are luckily since kvfree_call_rcu() works on bot=
h kmalloc and vmalloc,
> +            // maybe a new Allocator method is needed.
> +            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr()=
.cast()) };

[Severity: High]
If RcuBox is instantiated with a custom allocator, will hardcoding
kvfree_call_rcu cause an invalid free when needs_drop is false?

This branch appears to completely bypass the generic allocator's free metho=
d.

> +        }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718053247.2515=
4-1-boqun@kernel.org?part=3D1
