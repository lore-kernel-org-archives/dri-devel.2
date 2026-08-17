Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08F2C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE55A10E65C;
	Mon, 17 Aug 2026 07:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GyOETB1K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D2910E65C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:14:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 668C4600AE;
 Mon, 17 Aug 2026 07:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50251F000E9;
 Mon, 17 Aug 2026 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786950842;
 bh=E/M06geur84ARxO/DQeGing6QMBaPH7fTpTLiQ4syqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GyOETB1K+LgKowK84+4Ox5kHiIhRh4vWJM+bSQY1IRDbZKJ13O5b63HJl7gxPtmUu
 Atb5w+fugf/xkPD5FZ2vdn1Y4AzYjj2dVQz2L5Nf1WFfar7kSC8+spBV71H9+W3x8K
 1p2avtRKvCjv2aPhDVGvL88cjm/Ra3GXgzzpuBoje2QBxUFcHAzjfX/lkG93N/2eFR
 B2rOVQcA4BDjZIU91bhBFI5Ee/xQOJ+eLpy+0F2hpuf8/b5rJPS3yKESEBPLzz3Paf
 dnJ/NJpJFK45xk+dfIQC/TFNa08glvoXxgnUnbkI8MLEfbOmi0u3UbvJQduQWeUFGh
 jyVV3AU5/7zBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] rust: id_pool: add contiguous ID reservation
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260817-chid-v7-7-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-7-a5872e64d8f4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:14:01 +0000
Message-Id: <20260817071401.C50251F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The `reserve_ids` method modifies the pool state immediately and=
 returns a plain `Range<usize>`, breaking the typestate pattern and risking=
 ID leaks.
- [Low] Imports from `crate::` are not formatted using the vertical import =
style.

Pre-existing issues:
- [High] `reserve_ids` and existing iteration methods panic under `CONFIG_R=
UST_BITMAP_HARDENED` if `offset >=3D pool.capacity()`.
--

--- Patch [7]: [PATCH v7 07/10] rust: id_pool: add contiguous ID reservatio=
n ---
commit 1c4cba33204f36d476fe12dc8cb9f2594da796ce
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: add contiguous ID reservation

This commit adds `IdPool::reserve_ids` to allow allocating a contiguous
range of IDs from the pool with a specified offset, count, and alignment.

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 9494fde701eea..382a5645767fb 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -4,8 +4,14 @@
=20
 //! Rust API for an ID pool backed by a [`BitmapVec`].
=20
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
+
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
+use crate::ptr::Alignment;

[Severity: Low]
This isn't a bug, but could we format these crate:: imports vertically?

The Rust subsystem coding guidelines request that new imports follow the
kernel vertical import style, rather than adding standalone single-line
imports to existing blocks.

=20
 /// Represents a dynamic ID pool backed by a [`BitmapVec`].
 ///

[ ... ]

@@ -244,6 +250,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> Opt=
ion<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Reserves a contiguous area of `count` IDs at or after `offset`.
+    ///
+    /// The start of the returned area is a multiple of `align`.
+    ///
+    /// Returns the reserved range upon success, or [`None`] if no such ar=
ea could be found.
+    #[inline]
+    #[must_use]
+    pub fn reserve_ids(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<Range<usize>> {
+        let start =3D self.map.next_zero_area(offset, count, align)?;

[Severity: High]
This is a pre-existing issue, but does passing an offset equal to the pool
capacity cause a kernel panic under CONFIG_RUST_BITMAP_HARDENED?

If a caller iterates through the ID pool and the offset reaches the end
of the pool, it appears that self.map.next_zero_area() triggers the
bitmap_assert!(start < self.len()) bounds assertion inside the underlying
bitmap implementation (like next_zero_area_off) instead of gracefully
returning None.

Could this strict assertion be overly restrictive and unsafe for standard l=
oop
patterns over the ID pool?

> +        self.map.set(start, count);
> +        Some(start..start + count.get())
> +    }

[Severity: Medium]
Does returning a plain Range<usize> here risk leaking IDs if the caller
returns early on a subsequent fallible operation?

Since this method modifies the pool state immediately by calling
self.map.set(start, count) but returns a type without a Drop implementation,
any error path (such as memory allocation failing) that propagates with `?`
after the reservation would permanently lock these IDs.

Could this be updated to use the RAII/typestate pattern (similar to UnusedId
used by find_unused_id) to either defer setting the bitmap or properly rele=
ase
the IDs when dropped?

+
+    /// Releases a contiguous area of IDs.
+    #[inline]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-chid-v7-0-=
a5872e64d8f4@nvidia.com?part=3D7
