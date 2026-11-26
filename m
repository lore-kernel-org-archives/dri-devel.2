Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B70606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1lMsQZ2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F6810E9F4;
	Thu, 26 Nov 2026 21:37:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F73810E9F4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:37:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16DC445585;
 Thu, 26 Nov 2026 21:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477E21F0089A;
 Thu, 26 Nov 2026 21:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795729029;
 bh=08UknIj2H8XWGwN1HnLhO6QQEtyNW4lOtE/RfCqlWbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a1lMsQZ21RbIGbZzYOKqI8Q1wwQ+WFF+EcaH1QhxHEbg5f22Pjb8VHlbFRRSYmNn+
 y+Q23d36rydgr3I99u4Gqf0bYYxBSFUncvTrXu4Vrf1JL19yoBYLRWcZpTm2PP27kU
 i0kTmyHHhaKaefbaCUr7+HREwja1QzyGRItenJYO+qpQH1MdoAuNOQxddl+pyBkv+R
 utp5iegaJzwZxmwcWZSrzCE5KSSOFnhTQhKrnGMV8C2V/eET4yRa9cy6Ih5E3xSU57
 382wdINqNZV91l1kHifzrJp5XU0YS0a8LcBxhnXsw9NY4BcmDbO1BqX5Z/D38wIbEV
 BMk4J8NFuD5nQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ecourtney@nvidia.com, jhubbard@nvidia.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] gpu: nova-core: mm: remove SharedPramin
Date: Thu, 26 Nov 2026 22:36:05 +0100
Message-ID: <20261126213652.3716162-5-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126213652.3716162-1-dakr@kernel.org>
References: <20261126213652.3716162-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SharedPramin was introduced as a temporary wrapper so its mutex could be
pin-initialized separately while GpuMm remained movable. This allowed
PRAMIN locking to remove the need for mutable GpuMm references before
converting GpuMm itself to pin initialization.

Now that GpuMm is pin-initialized, it can embed Mutex<Pramin> directly
and hide the mutex's invariant resource lifetime itself. Remove the
temporary wrapper.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/mm.rs        | 19 +++++++++++------
 drivers/gpu/nova-core/mm/pramin.rs | 34 ------------------------------
 2 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 94c6f425c867..7aa8906d2cb2 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -44,13 +44,15 @@ macro_rules! impl_pfn_bounded {
         GpuBuddy,
         GpuBuddyParams, //
     },
+    new_mutex,
     num::Bounded,
     prelude::*,
     ptr::{
         Alignable,
         Alignment, //
     },
-    sizes::SZ_4K, //
+    sizes::SZ_4K,
+    sync::Mutex, //
 };
 
 use crate::{
@@ -72,13 +74,18 @@ macro_rules! impl_pfn_bounded {
 ///
 /// Provides centralized ownership of memory management resources:
 /// - [`GpuBuddy`] allocator for VRAM page table allocation.
-/// - [`pramin::SharedPramin`] for direct VRAM access.
+/// - [`pramin::Pramin`] for direct VRAM access.
 /// - [`Tlb`] manager for translation buffer flush operations.
 #[pin_data]
-pub(crate) struct GpuMm<'gpu> {
+pub(crate) struct GpuMm<'gpu>
+where
+    // Hide the mutex's invariant resource lifetime so `GpuMm` remains covariant.
+    exists<'res>: 'gpu,
+{
     buddy: GpuBuddy,
     #[pin]
-    pramin: pramin::SharedPramin<'gpu>,
+    #[uses('res: invariant)]
+    pramin: Mutex<pramin::Pramin<'res>>,
     #[pin]
     tlb: Tlb<'gpu>,
 }
@@ -97,7 +104,7 @@ pub(crate) fn new(
 
         try_pin_init!(Self {
             buddy: GpuBuddy::new(buddy_params)?,
-            pramin <- pramin::SharedPramin::new(bar, chipset, vram_region),
+            pramin <- new_mutex!(pramin::Pramin::new(bar, chipset, vram_region)?, "pramin"),
             tlb <- Tlb::new(bar),
         })
     }
@@ -111,7 +118,7 @@ pub(crate) fn buddy(&self) -> &GpuBuddy {
     ///
     /// Do not perform reclaimable allocations in `f`.
     fn with_pramin_locked<R>(&self, f: impl FnOnce(&mut pramin::Pramin<'_>) -> R) -> R {
-        self.pramin.with_locked(f)
+        self.with_pramin(|pramin| f(&mut pramin.lock()))
     }
 
     /// Access the [`Tlb`] manager.
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 841289d7bccc..c83b1681d241 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -13,7 +13,6 @@
         Io,
         Mmio, //
     },
-    new_mutex,
     prelude::*,
     ptr::{
         Alignable,
@@ -23,7 +22,6 @@
         SizeConstants,
         SZ_1M, //
     },
-    sync::Mutex, //
 };
 
 use crate::{
@@ -56,38 +54,6 @@
     PRAMIN: PraminWindow @ 0x700000;
 }
 
-/// A [`Pramin`] shared between users, serialized by a mutex.
-#[pin_data]
-pub(super) struct SharedPramin<'gpu>
-where
-    // Hide the mutex's invariant resource lifetime so `SharedPramin` remains covariant.
-    exists<'res>: 'gpu,
-{
-    #[pin]
-    #[uses('res: invariant)]
-    inner: Mutex<Pramin<'res>>,
-}
-
-impl<'gpu> SharedPramin<'gpu> {
-    /// Creates the shared window manager for the given VRAM region.
-    pub(super) fn new(
-        bar: Bar0<'gpu>,
-        chipset: Chipset,
-        vram_range: Range<VramAddress>,
-    ) -> impl PinInit<Self, Error> {
-        try_pin_init!(Self {
-            inner <- new_mutex!(Pramin::new(bar, chipset, vram_range)?, "pramin"),
-        })
-    }
-
-    /// Runs `f` with exclusive access to the PRAMIN window.
-    ///
-    /// Do not perform reclaimable allocations in `f`.
-    pub(super) fn with_locked<R>(&self, f: impl FnOnce(&mut Pramin<'_>) -> R) -> R {
-        self.with_inner(|inner| f(&mut inner.lock()))
-    }
-}
-
 /// Owner of the PRAMIN window state.
 ///
 /// [`Pramin::window_at()`] repositions the window as needed and returns a typed MMIO view into
-- 
2.56.1

