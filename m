Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC0ECD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C9910E4C1;
	Fri,  5 Jun 2026 13:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C3grknss";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A5010E4C1
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:51:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C7E3600AF
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26131F00893;
 Fri,  5 Jun 2026 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780667494;
 bh=WxgnRDgfcaJRPgOkS64o9HIQ9HlQL3SWek+yUpbgbVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C3grknssz/hpe2p8OB9abQyN7IXkuuArntkWOSCD8RlsvQp1Yx4cgz1Z28spmU8RH
 FGJKEqNvL5BpA+g9wC7W+iSRb9fGkFLeAs0aLUOFc3KvwRATzjqtcVE1WKeD57s+Td
 Xi6tT1EHSltojJk5eyYz+oEkPEBj+PQPPI34JhTA7A3L+OiIUXKrELT9BRqLbtKBS0
 t9iC4rd2O8LgwjJPgWubfU9X3rr4I/tL7LVsnnPaRCHXPhUVdVmto0zDjYJZkgOJ/M
 ITTGXizFEMvpmBF9dw0Cv75xVdMT14v2wibnCaARqEXoB5fSsCD5NyhytwRvI3J4ZO
 2tYo/tTD0P5xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rust: maple_tree: add load_rcu()
To: "Boqun Feng" <boqun@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-media@vger.kernel.org
In-Reply-To: <20260605133541.22569-4-boqun@kernel.org>
References: <20260605133541.22569-4-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:51:33 +0000
Message-Id: <20260605135133.D26131F00893@smtp.kernel.org>
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
- [Critical] Lockless traversal in `load_rcu()` causes a use-after-free of =
internal mapletree nodes because the tree is not initialized with `MT_FLAGS=
_USE_RCU`.
- [High] Unsound API: `RcuBox::new` safely allows types with blocking destr=
uctors to execute their `Drop` implementation in RCU softirq context, leadi=
ng to atomic context violations.
--

commit b7609fa7d8f12dc31f5e195b6f4d6155f2a20574
Author: Alice Ryhl <aliceryhl@google.com>

rust: maple_tree: add load_rcu()

This commit adds a load_rcu() method to MapleTree, allowing lookups under an
RCU read lock without taking the spinlock.

> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 265d6396a78a1..1499191b8935a 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs

[ ... ]

> @@ -233,6 +237,54 @@ pub fn erase(&self, index: usize) -> Option<T> {
>          unsafe { T::try_from_foreign(ret) }
>      }
> =20
> +    /// Load the value at the given index with rcu.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Read the value under an rcu read lock. Even if the value is remo=
ved, it remains accessible
> +    /// for one rcu grace period.
> +    ///
> +    /// ```ignore
> +    /// use kernel::{
> +    ///     maple_tree::MapleTree,
> +    ///     sync::rcu::{self, RcuBox},
> +    /// };
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<RcuBox<i32>>::new(), GFP=
_KERNEL)?;
> +    ///
> +    /// let ten =3D RcuBox::new(10, GFP_KERNEL)?;

[Severity: High]
Is it safe to allow arbitrary types to be managed via RcuBox?

RcuBox::new() is a safe function that accepts any T: Send. It lacks trait
bounds to restrict T to types that are safe to drop in atomic contexts.

When an RcuBox is dropped, if T requires dropping, it schedules drop_rcu_bo=
x()
using bindings::call_rcu(). The drop_rcu_box() callback executes in an RCU
softirq context, where sleeping or blocking is strictly forbidden.

If a safe T blocks during its Drop implementation (for example, safely
acquiring a kernel::sync::Mutex on drop), will this execute in softirq
context and cause a scheduling-while-atomic panic?

> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    ///
> +    /// let rcu_read_lock =3D rcu::Guard::new();
> +    /// let ten =3D tree.load_rcu(100, &rcu_read_lock);
> +    /// assert_eq!(ten, Some(&10));
> +    ///
> +    /// // Even if the value gets removed, we may continue to access it =
for one rcu grace period.
> +    /// tree.erase(100);
> +    /// assert_eq!(ten, Some(&10));
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn load_rcu<'rcu>(
> +        &self,
> +        index: usize,
> +        _rcu: &'rcu rcu::Guard,
> +    ) -> Option<T::RcuBorrowed<'rcu>>
> +    where
> +        T: ForeignOwnableRcu,
> +    {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret =3D unsafe { bindings::mtree_load(self.tree.get(), index=
) };

[Severity: Critical]
Does this lockless traversal risk a use-after-free?

Looking at MapleTree::new() and MapleTreeAlloc::new() in
rust/kernel/maple_tree.rs, the tree is initialized with 0 or
bindings::MT_FLAGS_ALLOC_RANGE respectively, without bindings::MT_FLAGS_USE=
_RCU.

If MT_FLAGS_USE_RCU is not set, structural modifications to the tree (like
node splits or merges) will synchronously free the replaced internal tree
nodes directly to the slab allocator via kmem_cache_free(), completely
bypassing call_rcu().

Could a concurrent load_rcu() walking the tree dereference a node pointer
that was just synchronously freed by a writer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605133541.2256=
9-1-boqun@kernel.org?part=3D2
