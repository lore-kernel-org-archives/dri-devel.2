Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8532606A688
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoeOcHD5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF9A112725;
	Thu, 26 Nov 2026 21:37:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EA910E9F4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:37:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6F8761FFE;
 Thu, 26 Nov 2026 21:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C71F000C1;
 Thu, 26 Nov 2026 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795729020;
 bh=i6R7ZhkWSFhC6v/4N4XEIqorS+opAewlAho4MvvNTDo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KoeOcHD52KM9Ujr7AwB8Wz9KbGoQx0EkJzG4ppI1YasBqI3sEl/1JnWevKuDYNlfF
 78ocvE/BYQh800vhB3BZe1MVHTj8kbCYxUc3I4vWiD4CNx0Jtv5SYtzRl3XwN5d3aA
 yeoDCPZayjWF/e3l0iKUrm+K+Oo1tOa6oaQ2jQLqKk9zy4p5gvVf5DIdSBMWWNVsFY
 OItu4YgdmhX4gRHmNHPwO2cQUcB+u5lmHA7gKbI+5rW/3ouayEyObKk7HWCD5prUZe
 8aaUxziVTQZnb8rmOMOtDgxNrY8e8LGSRSXUo4CRRVEhKuYmr0/n2RygCyqHVf//u2
 AZ/8s/nZyKa7Q==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ecourtney@nvidia.com, jhubbard@nvidia.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] gpu: nova-core: mm: serialize PRAMIN access
Date: Thu, 26 Nov 2026 22:36:02 +0100
Message-ID: <20261126213652.3716162-2-dakr@kernel.org>
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

PRAMIN window selection and access must be serialized so that the window
cannot move while it is in use. Give PRAMIN its own synchronization,
independent of its GpuMm container, so sharing the memory manager does
not require serializing unrelated VRAM allocation and TLB operations.

Keep the lock across page table walks and update batches to avoid
acquiring it separately for every entry.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/mm.rs                | 21 ++++++++----
 drivers/gpu/nova-core/mm/bar_user.rs       | 39 ++++++++++++++--------
 drivers/gpu/nova-core/mm/pagetable/map.rs  | 34 +++++++++----------
 drivers/gpu/nova-core/mm/pagetable/walk.rs |  2 +-
 drivers/gpu/nova-core/mm/pramin.rs         | 34 +++++++++++++++++++
 5 files changed, 91 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index f53886f9ed91..bbe23dc6351f 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -72,11 +72,11 @@ macro_rules! impl_pfn_bounded {
 ///
 /// Provides centralized ownership of memory management resources:
 /// - [`GpuBuddy`] allocator for VRAM page table allocation.
-/// - [`pramin::Pramin`] for direct VRAM access.
+/// - [`pramin::SharedPramin`] for direct VRAM access.
 /// - [`Tlb`] manager for translation buffer flush operations.
 pub(crate) struct GpuMm<'gpu> {
     buddy: GpuBuddy,
-    pramin: pramin::Pramin<'gpu>,
+    pramin: Pin<KBox<pramin::SharedPramin<'gpu>>>,
     tlb: Pin<KBox<Tlb<'gpu>>>,
 }
 
@@ -94,7 +94,10 @@ pub(crate) fn new(
 
         Ok(Self {
             buddy: GpuBuddy::new(buddy_params)?,
-            pramin: pramin::Pramin::new(bar, chipset, vram_region)?,
+            pramin: KBox::pin_init(
+                pramin::SharedPramin::new(bar, chipset, vram_region),
+                GFP_KERNEL,
+            )?,
             tlb: KBox::pin_init(Tlb::new(bar), GFP_KERNEL)?,
         })
     }
@@ -104,9 +107,11 @@ pub(crate) fn buddy(&self) -> &GpuBuddy {
         &self.buddy
     }
 
-    /// Access the [`pramin::Pramin`].
-    fn pramin_mut(&mut self) -> &mut pramin::Pramin<'gpu> {
-        &mut self.pramin
+    /// Runs `f` with exclusive access to the PRAMIN window.
+    ///
+    /// Do not perform reclaimable allocations in `f`.
+    fn with_pramin_locked<R>(&self, f: impl FnOnce(&mut pramin::Pramin<'_>) -> R) -> R {
+        self.pramin.with_locked(f)
     }
 
     /// Access the [`Tlb`] manager.
@@ -329,7 +334,9 @@ pub(crate) fn run(
             return Ok(());
         };
 
-        pramin::selftest::run(dev, mm.pramin_mut(), VramAddress::from_raw(base))?;
+        mm.with_pramin_locked(|pramin| {
+            pramin::selftest::run(dev, pramin, VramAddress::from_raw(base))
+        })?;
         bar_user::run_self_test(dev, mm, bar_user, bar1_pdb, chipset)
     }
 }
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 2e8bd2a8ed91..f25ead64bf53 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -213,7 +213,12 @@ pub(crate) fn run_self_test(
     let pdb_addr = VramAddress::from_raw(bar1_pdb);
 
     // Check if initial page tables are in VRAM.
-    if crate::mm::pagetable::check_pdb_valid(mm.pramin_mut(), pdb_addr, chipset).is_err() {
+    if mm
+        .with_pramin_locked(|pramin| {
+            crate::mm::pagetable::check_pdb_valid(pramin, pdb_addr, chipset)
+        })
+        .is_err()
+    {
         dev_info!(dev, "MM: Self-test SKIPPED - no valid VRAM page tables\n");
         return Ok(());
     }
@@ -246,10 +251,13 @@ pub(crate) fn run_self_test(
     let vram_read_addr = test_vram + 0x100;
 
     // Test 1: Write via PRAMIN, read via BAR1.
-    mm.pramin_mut()
-        .window_at::<u32>(vram_read_addr)?
-        .view()
-        .write_val(PATTERN_PRAMIN);
+    mm.with_pramin_locked(|pramin| -> Result {
+        pramin
+            .window_at::<u32>(vram_read_addr)?
+            .view()
+            .write_val(PATTERN_PRAMIN);
+        Ok(())
+    })?;
 
     // Read back via BAR1 aperture.
     let bar1_value = bar1.try_read32(bar1_read_offset)?;
@@ -353,11 +361,11 @@ pub(crate) fn run_self_test(
 
             bar1.try_write32(PATTERN_BAR1, page_bar1_off)?;
 
-            let pramin_val = mm
-                .pramin_mut()
-                .window_at::<u32>(VramAddress::from_raw(page_phys))?
-                .view()
-                .read_val();
+            let pramin_val = mm.with_pramin_locked(|pramin| {
+                pramin
+                    .window_at::<u32>(VramAddress::from_raw(page_phys))
+                    .map(|window| window.view().read_val())
+            })?;
 
             if pramin_val != PATTERN_BAR1 {
                 dev_err!(
@@ -392,10 +400,13 @@ pub(crate) fn run_self_test(
     let access = bar_user.map(mm, &[test_pfn], true)?;
 
     // Write pattern via PRAMIN, read via BarUserAccess.
-    mm.pramin_mut()
-        .window_at::<u32>(test_vram)?
-        .view()
-        .write_val(PATTERN_BAR1);
+    mm.with_pramin_locked(|pramin| -> Result {
+        pramin
+            .window_at::<u32>(test_vram)?
+            .view()
+            .write_val(PATTERN_BAR1);
+        Ok(())
+    })?;
 
     let readback = access.try_read32(0)?;
     let test4_passed = if readback == PATTERN_BAR1 {
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
index f7774b9cc972..ba23cd3c2b25 100644
--- a/drivers/gpu/nova-core/mm/pagetable/map.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -96,12 +96,13 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<Prep
         let page_vram = VramAddress::from_raw(blocks.iter().next().ok_or(ENOMEM)?.offset());
 
         // Zero via PRAMIN.
-        let window = mm
-            .pramin_mut()
-            .window_at::<[u64; PAGE_SIZE / 8]>(page_vram)?;
-        for i in 0..PAGE_SIZE / 8 {
-            io_write!(window.view(), [build: i], 0);
-        }
+        mm.with_pramin_locked(|pramin| -> Result {
+            let window = pramin.window_at::<[u64; PAGE_SIZE / 8]>(page_vram)?;
+            for i in 0..PAGE_SIZE / 8 {
+                io_write!(window.view(), [build: i], 0);
+            }
+            Ok(())
+        })?;
 
         Ok(PreparedPtPage {
             alloc: blocks,
@@ -121,16 +122,16 @@ fn ensure_single_pte_path(
         let max_iter = 2 * M::PDE_LEVELS.len();
 
         for _ in 0..max_iter {
-            let result = self
-                .walker
-                .walk_pde_levels(mm.pramin_mut(), vfn, |install_addr| {
+            let result = mm.with_pramin_locked(|pramin| {
+                self.walker.walk_pde_levels(pramin, vfn, |install_addr| {
                     pt_pages.get(&install_addr).and_then(|p| {
                         p.alloc
                             .iter()
                             .next()
                             .map(|b| VramAddress::from_raw(b.offset()))
                     })
-                })?;
+                })
+            })?;
 
             match result {
                 WalkPdeResult::Complete { .. } => {
@@ -199,9 +200,7 @@ pub(super) fn install_mappings(
         pfns: &[Pfn],
         writable: bool,
     ) -> Result {
-        {
-            let pramin = mm.pramin_mut();
-
+        mm.with_pramin_locked(|pramin| -> Result {
             // Drain prepared PT pages, install all pending PDEs.
             let mut cursor = pt_pages.cursor_front_mut();
             while let Some(c) = cursor {
@@ -242,7 +241,8 @@ pub(super) fn install_mappings(
                     }
                 }
             }
-        }
+            Ok(())
+        })?;
 
         // Flush TLB.
         mm.tlb().flush(self.pdb_addr)
@@ -257,8 +257,7 @@ pub(super) fn invalidate_ptes(
     ) -> Result {
         let invalid_pte = M::Pte::invalid();
 
-        {
-            let pramin = mm.pramin_mut();
+        mm.with_pramin_locked(|pramin| -> Result {
             for i in 0..num_pages {
                 let i_u64: u64 = i.into_safe_cast();
                 let vfn = Vfn::new(vfn_start.raw() + i_u64);
@@ -273,7 +272,8 @@ pub(super) fn invalidate_ptes(
                     }
                 }
             }
-        }
+            Ok(())
+        })?;
 
         mm.tlb().flush(self.pdb_addr)
     }
diff --git a/drivers/gpu/nova-core/mm/pagetable/walk.rs b/drivers/gpu/nova-core/mm/pagetable/walk.rs
index 76c1729971f5..899c61888756 100644
--- a/drivers/gpu/nova-core/mm/pagetable/walk.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/walk.rs
@@ -172,7 +172,7 @@ pub(super) fn walk_pde_levels(
     ///
     /// Returns [`WalkResult::PageTableMissing`] if intermediate tables don't exist.
     pub(super) fn walk_to_pte_lookup(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<WalkResult> {
-        self.walk_to_pte_lookup_with_window(mm.pramin_mut(), vfn)
+        mm.with_pramin_locked(|pramin| self.walk_to_pte_lookup_with_window(pramin, vfn))
     }
 
     /// Walk to PTE using a caller-provided PRAMIN manager (lookup only).
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index c83b1681d241..841289d7bccc 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -13,6 +13,7 @@
         Io,
         Mmio, //
     },
+    new_mutex,
     prelude::*,
     ptr::{
         Alignable,
@@ -22,6 +23,7 @@
         SizeConstants,
         SZ_1M, //
     },
+    sync::Mutex, //
 };
 
 use crate::{
@@ -54,6 +56,38 @@
     PRAMIN: PraminWindow @ 0x700000;
 }
 
+/// A [`Pramin`] shared between users, serialized by a mutex.
+#[pin_data]
+pub(super) struct SharedPramin<'gpu>
+where
+    // Hide the mutex's invariant resource lifetime so `SharedPramin` remains covariant.
+    exists<'res>: 'gpu,
+{
+    #[pin]
+    #[uses('res: invariant)]
+    inner: Mutex<Pramin<'res>>,
+}
+
+impl<'gpu> SharedPramin<'gpu> {
+    /// Creates the shared window manager for the given VRAM region.
+    pub(super) fn new(
+        bar: Bar0<'gpu>,
+        chipset: Chipset,
+        vram_range: Range<VramAddress>,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- new_mutex!(Pramin::new(bar, chipset, vram_range)?, "pramin"),
+        })
+    }
+
+    /// Runs `f` with exclusive access to the PRAMIN window.
+    ///
+    /// Do not perform reclaimable allocations in `f`.
+    pub(super) fn with_locked<R>(&self, f: impl FnOnce(&mut Pramin<'_>) -> R) -> R {
+        self.with_inner(|inner| f(&mut inner.lock()))
+    }
+}
+
 /// Owner of the PRAMIN window state.
 ///
 /// [`Pramin::window_at()`] repositions the window as needed and returns a typed MMIO view into
-- 
2.56.1

