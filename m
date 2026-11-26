Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsSEjfUn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4935C10E468;
	Thu, 26 Nov 2026 22:11:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539F410E468
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 22:11:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BD576021E;
 Thu, 26 Nov 2026 22:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC06B1F00893;
 Thu, 26 Nov 2026 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795731076;
 bh=c+/9lYLQw8DsofbwWqUP492ZKN/7icTXPBxD5RQmlUo=;
 h=From:To:Cc:Subject:Date;
 b=bsSEjfUnduNUnKUQsX4mMEN6z/dd1kG4WkTnFh/o2TXoRGrXbVkw+69QsOrFEznFK
 c4Xc2asOH0RJq4uMkRTMF7AWnXkuZ+1hxAMTYEgPK9AaG7/egeNg4HaqlxV2YBWusn
 pqBtJqH0KIWgzbx7/lOPpdLYf80CUKTsh9eCMNBbZLgIy79WKZGeAcQFN4PJXyYzOl
 tn6b0Gfyi9+ibTJYSjeh7HtHvllPBNb7URflGkofIVHkTrgEXrUuILNuUL+TRegWug
 2VB+Z3EMJVn94M3I/+LJ8M7WLemJmVE5ufsxe3Cz0xmbQn2/VUdzaVpRpMulZNaWb+
 vdYCoqP2rZXiQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ecourtney@nvidia.com, jhubbard@nvidia.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, joelagnelf@nvidia.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] rust: gpu: buddy: tie allocations to the allocator lifetime
Date: Thu, 26 Nov 2026 23:11:02 +0100
Message-ID: <20261126221108.3768637-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
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

Let the allocator's lifetime constrain the lifetime of its allocations,
rather than having allocations keep the allocator alive through
reference counting.

This also removes an unnecessary allocation and allows GpuBuddy to be
embedded directly in driver private data.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Depends on [1].

[1] https://lore.kernel.org/nova-gpu/20261126213652.3716162-1-dakr@kernel.org/
---
 drivers/gpu/nova-core/driver.rs           |   2 +-
 drivers/gpu/nova-core/gpu.rs              |  51 +++++----
 drivers/gpu/nova-core/mm.rs               |   9 +-
 drivers/gpu/nova-core/mm/bar_user.rs      |  20 ++--
 drivers/gpu/nova-core/mm/pagetable/map.rs |  43 ++++----
 drivers/gpu/nova-core/mm/vmm.rs           |  12 +-
 rust/kernel/gpu/buddy.rs                  | 128 ++++++++++++----------
 7 files changed, 147 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index d6bc972d47c7..f8f5d74d2742 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -133,7 +133,7 @@ fn probe<'bound>(
 
             gpu <- Gpu::new(pdev, bar, bar1).pin_chain(|_gpu| {
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
-                _gpu.run_selftests(pdev);
+                _gpu.as_ref().run_selftests(pdev);
                 Ok(())
             }),
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 2f0399100885..65290cedde11 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,5 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#![expect(
+    clippy::multiple_bound_locations,
+    reason = "pin_data generates additional outlives bounds for the borrowed MM field"
+)]
+
 use core::ops::Range;
 
 use kernel::{
@@ -383,7 +388,11 @@ unsafe fn new(
 
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
-pub(crate) struct Gpu<'gpu> {
+pub(crate) struct Gpu<'gpu>
+where
+    // Hide the borrowed memory manager's resource lifetime so `Gpu` remains covariant.
+    exists<'gpu_mm>: 'gpu,
+{
     pub(crate) spec: Spec,
     /// GSP event interrupt registration, and the enable of its subtree.
     ///
@@ -395,15 +404,17 @@ pub(crate) struct Gpu<'gpu> {
     _gsp_subtree: GspSubtree<'gsp_resources>,
     /// Static GPU information as provided by the GSP.
     pub(crate) gsp_static_info: GetGspStaticInfoReply,
+    /// BAR1 user interface for CPU access to GPU virtual memory.
+    #[pin]
+    #[uses('mm: invariant)]
+    bar_user: BarUser<'mm>,
     /// GPU memory manager owning memory management resources.
     ///
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
     /// the GSP is still operational.
     #[pin]
-    mm: GpuMm<'gpu>,
-    /// BAR1 user interface for CPU access to GPU virtual memory.
-    #[pin]
-    bar_user: BarUser<'gpu>,
+    #[uses('gpu_mm: invariant)]
+    mm: GpuMm<'gpu_mm>,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -614,20 +625,22 @@ pub(crate) fn wait_gfw_boot_completion(
 
     /// Runs self-tests on the constructed [`Gpu`], logging failures without failing probe.
     #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
-    pub(crate) fn run_selftests(&self, pdev: &pci::Device<device::Bound>) {
-        let dev = pdev.as_ref();
-        let regions = &self.gsp_static_info.usable_fb_regions;
-
-        if let Err(err) = crate::mm::selftest::run(
-            dev,
-            &self.mm,
-            regions,
-            &self.bar_user,
-            self.gsp_static_info.bar1_pde_base,
-            self.spec.chipset,
-        ) {
-            dev_err!(dev, "self-tests failed: {:?}\n", err);
-        }
+    pub(crate) fn run_selftests(self: Pin<&Self>, pdev: &pci::Device<device::Bound>) {
+        self.with_project_ref(|this| {
+            let dev = pdev.as_ref();
+            let regions = &this.gsp_static_info.usable_fb_regions;
+
+            if let Err(err) = crate::mm::selftest::run(
+                dev,
+                this.mm.get_ref(),
+                regions,
+                &this.bar_user,
+                this.gsp_static_info.bar1_pde_base,
+                this.spec.chipset,
+            ) {
+                dev_err!(dev, "self-tests failed: {:?}\n", err);
+            }
+        });
     }
 }
 
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 7aa8906d2cb2..e3ccd248ab48 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -82,6 +82,7 @@ pub(crate) struct GpuMm<'gpu>
     // Hide the mutex's invariant resource lifetime so `GpuMm` remains covariant.
     exists<'res>: 'gpu,
 {
+    #[pin]
     buddy: GpuBuddy,
     #[pin]
     #[uses('res: invariant)]
@@ -103,7 +104,7 @@ pub(crate) fn new(
         let vram_region = VramAddress::ZERO..total_fb_end;
 
         try_pin_init!(Self {
-            buddy: GpuBuddy::new(buddy_params)?,
+            buddy <- GpuBuddy::new(buddy_params),
             pramin <- new_mutex!(pramin::Pramin::new(bar, chipset, vram_region)?, "pramin"),
             tlb <- Tlb::new(bar),
         })
@@ -316,11 +317,11 @@ pub(crate) mod selftest {
     use super::*;
 
     /// Run MM subsystem self-tests during probe.
-    pub(crate) fn run(
+    pub(crate) fn run<'gpu>(
         dev: &device::Device<device::Bound>,
-        mm: &GpuMm<'_>,
+        mm: &'gpu GpuMm<'_>,
         usable_fb_regions: &[Range<u64>],
-        bar_user: &bar_user::BarUser<'_>,
+        bar_user: &bar_user::BarUser<'gpu>,
         bar1_pdb: u64,
         chipset: Chipset,
     ) -> Result {
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 483129d3d0f7..31a19219d032 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -37,7 +37,7 @@
 #[pin_data]
 pub(crate) struct BarUser<'a> {
     #[pin]
-    vmm: Mutex<Vmm>,
+    vmm: Mutex<Vmm<'a>>,
     bar1: Bar1<'a>,
 }
 
@@ -61,10 +61,10 @@ pub(crate) fn new(
     /// Map physical pages to a contiguous BAR1 virtual range.
     pub(crate) fn map(
         &self,
-        mm: &GpuMm<'_>,
+        mm: &'a GpuMm<'_>,
         pfns: &[Pfn],
         writable: bool,
-    ) -> Result<BarUserAccess<'_>> {
+    ) -> Result<BarUserAccess<'_, 'a>> {
         if pfns.is_empty() {
             return Err(EINVAL);
         }
@@ -81,15 +81,15 @@ pub(crate) fn map(
 /// Access object for a mapped BAR1 region.
 ///
 /// Borrows the [`BarUser`] managing the mapping for the lifetime of the access object.
-pub(crate) struct BarUserAccess<'a> {
-    bar_user: &'a BarUser<'a>,
+pub(crate) struct BarUserAccess<'a, 'gpu> {
+    bar_user: &'a BarUser<'gpu>,
     /// [`BarUserAccess::release`] [`Option::take`]s this; `Some` at
     /// drop time means `release()` was never called.
     mapped: Option<MappedRange>,
 }
 
 #[expect(dead_code)]
-impl BarUserAccess<'_> {
+impl BarUserAccess<'_, '_> {
     /// Tear down the BAR1 mapping.
     pub(crate) fn release(mut self, mm: &GpuMm<'_>) -> Result {
         let mapped = self.mapped.take().ok_or(EINVAL)?;
@@ -163,7 +163,7 @@ pub(crate) fn try_write64(&self, value: u64, offset: usize) -> Result {
     }
 }
 
-impl Drop for BarUserAccess<'_> {
+impl Drop for BarUserAccess<'_, '_> {
     fn drop(&mut self) {
         if self.mapped.is_some() {
             kernel::pr_warn!(
@@ -181,10 +181,10 @@ fn drop(&mut self) {
 /// address space. Uses the `GpuMm`'s buddy allocator to allocate page tables
 /// and test pages as needed.
 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
-pub(crate) fn run_self_test(
+pub(crate) fn run_self_test<'gpu>(
     dev: &device::Device<device::Bound>,
-    mm: &GpuMm<'_>,
-    bar_user: &BarUser<'_>,
+    mm: &'gpu GpuMm<'_>,
+    bar_user: &BarUser<'gpu>,
     bar1_pdb: u64,
     chipset: Chipset,
 ) -> Result {
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
index 22e44386423f..968a900a1bba 100644
--- a/drivers/gpu/nova-core/mm/pagetable/map.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -57,9 +57,9 @@
 ///
 /// Created during the mapping prepare phase and consumed during the execute phase.
 /// Stored in an [`RBTree`] keyed by the PDE slot address (`install_addr`).
-pub(in crate::mm) struct PreparedPtPage {
+pub(in crate::mm) struct PreparedPtPage<'gpu> {
     /// The allocated and zeroed page table page.
-    pub(in crate::mm) alloc: Pin<KBox<AllocatedBlocks>>,
+    pub(in crate::mm) alloc: Pin<KBox<AllocatedBlocks<'gpu>>>,
     /// Page table level -- needed to determine if this PT page is for a dual PDE.
     pub(in crate::mm) level: PageTableLevel,
 }
@@ -82,7 +82,10 @@ pub(super) fn new(pdb_addr: VramAddress) -> Self {
     }
 
     /// Allocate and zero a physical page table page.
-    fn alloc_and_zero_page(mm: &GpuMm<'_>, level: PageTableLevel) -> Result<PreparedPtPage> {
+    fn alloc_and_zero_page<'gpu>(
+        mm: &'gpu GpuMm<'_>,
+        level: PageTableLevel,
+    ) -> Result<PreparedPtPage<'gpu>> {
         let blocks = KBox::pin_init(
             mm.buddy().alloc_blocks(
                 GpuBuddyAllocMode::Simple,
@@ -113,11 +116,11 @@ fn alloc_and_zero_page(mm: &GpuMm<'_>, level: PageTableLevel) -> Result<Prepared
     /// Ensure all intermediate page table pages exist for a single VFN.
     ///
     /// The mutable PRAMIN borrow ends before each allocation.
-    fn ensure_single_pte_path(
+    fn ensure_single_pte_path<'gpu>(
         &self,
-        mm: &GpuMm<'_>,
+        mm: &'gpu GpuMm<'_>,
         vfn: Vfn,
-        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage<'gpu>>,
     ) -> Result {
         let max_iter = 2 * M::PDE_LEVELS.len();
 
@@ -166,13 +169,13 @@ fn ensure_single_pte_path(
     ///
     /// Reserves capacity in `page_table_allocs`, then walks the hierarchy
     /// per-VFN to prepare pages for all missing PDEs.
-    pub(super) fn prepare_map(
+    pub(super) fn prepare_map<'gpu>(
         &self,
-        mm: &GpuMm<'_>,
+        mm: &'gpu GpuMm<'_>,
         vfn_start: Vfn,
         num_pages: usize,
-        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
-        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks<'gpu>>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage<'gpu>>,
     ) -> Result {
         // Pre-reserve so install_mappings() can use push_within_capacity (no alloc
         // in fence signalling critical path).
@@ -191,11 +194,11 @@ pub(super) fn prepare_map(
     /// Install prepared PDEs and write PTEs, then flush TLB.
     ///
     /// Drains `pt_pages` and moves allocations into `page_table_allocs`.
-    pub(super) fn install_mappings(
+    pub(super) fn install_mappings<'gpu>(
         &self,
         mm: &GpuMm<'_>,
-        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
-        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage<'gpu>>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks<'gpu>>>>,
         vfn_start: Vfn,
         pfns: &[Pfn],
         writable: bool,
@@ -306,13 +309,13 @@ pub(in crate::mm) fn new(pdb_addr: VramAddress, version: MmuVersion) -> Self {
     }
 
     /// Prepare page table resources for a mapping.
-    pub(in crate::mm) fn prepare_map(
+    pub(in crate::mm) fn prepare_map<'gpu>(
         &self,
-        mm: &GpuMm<'_>,
+        mm: &'gpu GpuMm<'_>,
         vfn_start: Vfn,
         num_pages: usize,
-        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
-        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks<'gpu>>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage<'gpu>>,
     ) -> Result {
         pt_map_dispatch!(
             self,
@@ -321,11 +324,11 @@ pub(in crate::mm) fn prepare_map(
     }
 
     /// Install prepared PDEs and write PTEs, then flush TLB.
-    pub(in crate::mm) fn install_mappings(
+    pub(in crate::mm) fn install_mappings<'gpu>(
         &self,
         mm: &GpuMm<'_>,
-        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
-        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage<'gpu>>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks<'gpu>>>>,
         vfn_start: Vfn,
         pfns: &[Pfn],
         writable: bool,
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index c8258e579f8b..2ce6dca777ec 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -124,7 +124,7 @@ fn drop(&mut self) {
 ///
 /// Each [`Vmm`] instance manages a single address space identified by its Page
 /// Directory Base (`PDB`) address. Used for Channel, BAR1 and BAR2 mappings.
-pub(crate) struct Vmm {
+pub(crate) struct Vmm<'gpu> {
     /// Page Directory Base address for this address space.
     #[expect(dead_code)]
     pdb_addr: VramAddress,
@@ -133,7 +133,7 @@ pub(crate) struct Vmm {
     /// Page table mapper for prepare/execute operations.
     pt_map: PtMap,
     /// Page table allocations required for mappings.
-    page_table_allocs: KVec<Pin<KBox<AllocatedBlocks>>>,
+    page_table_allocs: KVec<Pin<KBox<AllocatedBlocks<'gpu>>>>,
     /// Maple tree allocator for virtual address range tracking.
     virt_alloc: Pin<KBox<MapleTreeAlloc<()>>>,
     /// Total number of pages in the virtual address space.
@@ -142,10 +142,10 @@ pub(crate) struct Vmm {
     ///
     /// Populated during prepare phase and drained in execute phase. Shared by all
     /// pending maps, preventing races on the same PDE slot.
-    pt_pages: RBTree<VramAddress, super::pagetable::map::PreparedPtPage>,
+    pt_pages: RBTree<VramAddress, super::pagetable::map::PreparedPtPage<'gpu>>,
 }
 
-impl Vmm {
+impl<'gpu> Vmm<'gpu> {
     /// Create a new [`Vmm`] for the given Page Directory Base address.
     ///
     /// The [`Vmm`] will manage a virtual address space of `va_size` bytes.
@@ -220,7 +220,7 @@ pub(super) fn read_mapping(&self, mm: &GpuMm<'_>, vfn: Vfn) -> Result<Option<Pfn
     /// to call outside the fence signalling critical path.
     pub(crate) fn prepare_map(
         &mut self,
-        mm: &GpuMm<'_>,
+        mm: &'gpu GpuMm<'_>,
         num_pages: usize,
         va_range: Option<Range<u64>>,
     ) -> Result<PreparedMapping> {
@@ -297,7 +297,7 @@ pub(crate) fn execute_map(
     /// [`Vmm::execute_map()`] will be called separately.
     pub(crate) fn map_pages(
         &mut self,
-        mm: &GpuMm<'_>,
+        mm: &'gpu GpuMm<'_>,
         pfns: &[Pfn],
         va_range: Option<Range<u64>>,
         writable: bool,
diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index 39f7f9eca255..159a3695d475 100644
--- a/rust/kernel/gpu/buddy.rs
+++ b/rust/kernel/gpu/buddy.rs
@@ -28,11 +28,14 @@
 //! };
 //!
 //! // Create a 1GB buddy allocator with 4KB minimum chunk size.
-//! let buddy = GpuBuddy::new(GpuBuddyParams {
-//!     base_offset: 0,
-//!     size: SZ_1G as u64,
-//!     chunk_size: Alignment::SZ_4K,
-//! })?;
+//! let buddy = KBox::pin_init(
+//!     GpuBuddy::new(GpuBuddyParams {
+//!         base_offset: 0,
+//!         size: SZ_1G as u64,
+//!         chunk_size: Alignment::SZ_4K,
+//!     }),
+//!     GFP_KERNEL,
+//! )?;
 //!
 //! assert_eq!(buddy.size(), SZ_1G as u64);
 //! assert_eq!(buddy.chunk_size(), Alignment::SZ_4K);
@@ -71,11 +74,14 @@
 //! #     ptr::Alignment,
 //! #     sizes::*, //
 //! # };
-//! # let buddy = GpuBuddy::new(GpuBuddyParams {
-//! #     base_offset: 0,
-//! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::SZ_4K,
-//! # })?;
+//! # let buddy = KBox::pin_init(
+//! #     GpuBuddy::new(GpuBuddyParams {
+//! #         base_offset: 0,
+//! #         size: SZ_1G as u64,
+//! #         chunk_size: Alignment::SZ_4K,
+//! #     }),
+//! #     GFP_KERNEL,
+//! # )?;
 //! # let initial_free = buddy.avail();
 //! let topdown = KBox::pin_init(
 //!     buddy.alloc_blocks(
@@ -111,11 +117,14 @@
 //! #     ptr::Alignment,
 //! #     sizes::*, //
 //! # };
-//! # let buddy = GpuBuddy::new(GpuBuddyParams {
-//! #     base_offset: 0,
-//! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::SZ_4K,
-//! # })?;
+//! # let buddy = KBox::pin_init(
+//! #     GpuBuddy::new(GpuBuddyParams {
+//! #         base_offset: 0,
+//! #         size: SZ_1G as u64,
+//! #         chunk_size: Alignment::SZ_4K,
+//! #     }),
+//! #     GFP_KERNEL,
+//! # )?;
 //! # let initial_free = buddy.avail();
 //! // Create fragmentation by allocating 4MB blocks at [0,4M) and [8M,12M).
 //! let frag1 = KBox::pin_init(
@@ -175,11 +184,14 @@
 //! #     sizes::*, //
 //! # };
 //! // Create a small 16MB buddy allocator with fragmented memory.
-//! let small = GpuBuddy::new(GpuBuddyParams {
-//!     base_offset: 0,
-//!     size: SZ_16M as u64,
-//!     chunk_size: Alignment::SZ_4K,
-//! })?;
+//! let small = KBox::pin_init(
+//!     GpuBuddy::new(GpuBuddyParams {
+//!         base_offset: 0,
+//!         size: SZ_16M as u64,
+//!         chunk_size: Alignment::SZ_4K,
+//!     }),
+//!     GFP_KERNEL,
+//! )?;
 //!
 //! let _hole1 = KBox::pin_init(
 //!     small.alloc_blocks(
@@ -227,7 +239,6 @@
     ptr::Alignment,
     sync::{
         lock::mutex::MutexGuard,
-        Arc,
         Mutex, //
     },
     types::Opaque, //
@@ -302,7 +313,11 @@ pub struct GpuBuddyParams {
     pub chunk_size: Alignment,
 }
 
-/// Inner structure holding the actual buddy allocator.
+/// GPU buddy allocator instance.
+///
+/// Allocated blocks borrow this allocator.
+///
+/// Refer to the module-level documentation for usage examples.
 ///
 /// # Synchronization
 ///
@@ -315,16 +330,19 @@ pub struct GpuBuddyParams {
 ///
 /// The `inner` field contains an initialized buddy allocator wrapped in [`Opaque`].
 #[pin_data(PinnedDrop)]
-struct GpuBuddyInner {
+pub struct GpuBuddy {
     #[pin]
     inner: Mutex<Opaque<bindings::gpu_buddy>>,
     /// Cached creation parameters (do not change after init).
     params: GpuBuddyParams,
 }
 
-impl GpuBuddyInner {
+impl GpuBuddy {
     /// Create a pin-initializer for the buddy allocator.
-    fn new(params: GpuBuddyParams) -> impl PinInit<Self, Error> {
+    ///
+    /// The allocator manages a contiguous address space of the given size, with the
+    /// specified minimum allocation unit (chunk_size must be at least 4KB).
+    pub fn new(params: GpuBuddyParams) -> impl PinInit<Self, Error> {
         let size = params.size;
         let chunk_size = params.chunk_size;
 
@@ -353,9 +371,20 @@ fn lock(&self) -> GpuBuddyGuard<'_> {
 }
 
 #[pinned_drop]
-impl PinnedDrop for GpuBuddyInner {
+impl PinnedDrop for GpuBuddy {
     fn drop(self: Pin<&mut Self>) {
         let guard = self.lock();
+        let raw = guard.as_raw();
+
+        // In case allocations have been leaked, e.g. with `mem::forget()`,
+        // leak the C allocator's resources as well: `gpu_buddy_fini()` requires
+        // all blocks to have been returned.
+        // SAFETY: Per the type invariant, `raw` points to an initialized
+        // allocator. `guard` provides exclusive access.
+        if unsafe { (*raw).avail != (*raw).size } {
+            crate::pr_warn!("GPU buddy allocator dropped with outstanding allocations\n");
+            return;
+        }
 
         // SAFETY: Per the type invariant, `inner` contains an initialized
         // allocator. `guard` provides exclusive access.
@@ -363,12 +392,12 @@ fn drop(self: Pin<&mut Self>) {
     }
 }
 
-// SAFETY: `GpuBuddyInner` can be sent between threads.
-unsafe impl Send for GpuBuddyInner {}
+// SAFETY: `GpuBuddy` can be sent between threads.
+unsafe impl Send for GpuBuddy {}
 
-// SAFETY: `GpuBuddyInner` is `Sync` because `GpuBuddyInner::lock`
+// SAFETY: `GpuBuddy` is `Sync` because `GpuBuddy::lock`
 // serializes all access to the C allocator, preventing data races.
-unsafe impl Sync for GpuBuddyInner {}
+unsafe impl Sync for GpuBuddy {}
 
 /// Guard that proves the lock is held, enabling access to the allocator.
 ///
@@ -384,41 +413,25 @@ fn as_raw(&self) -> *mut bindings::gpu_buddy {
     }
 }
 
-/// GPU buddy allocator instance.
-///
-/// This structure wraps the C `gpu_buddy` allocator using reference counting.
-/// The allocator is automatically cleaned up when all references are dropped.
-///
-/// Refer to the module-level documentation for usage examples.
-pub struct GpuBuddy(Arc<GpuBuddyInner>);
-
 impl GpuBuddy {
-    /// Create a new buddy allocator.
-    ///
-    /// The allocator manages a contiguous address space of the given size, with the
-    /// specified minimum allocation unit (chunk_size must be at least 4KB).
-    pub fn new(params: GpuBuddyParams) -> Result<Self> {
-        Arc::pin_init(GpuBuddyInner::new(params), GFP_KERNEL).map(Self)
-    }
-
     /// Get the base offset for allocations.
     pub fn base_offset(&self) -> u64 {
-        self.0.params.base_offset
+        self.params.base_offset
     }
 
     /// Get the chunk size (minimum allocation unit).
     pub fn chunk_size(&self) -> Alignment {
-        self.0.params.chunk_size
+        self.params.chunk_size
     }
 
     /// Get the total managed size.
     pub fn size(&self) -> u64 {
-        self.0.params.size
+        self.params.size
     }
 
     /// Get the available (free) memory in bytes.
     pub fn avail(&self) -> u64 {
-        let guard = self.0.lock();
+        let guard = self.lock();
 
         // SAFETY: Per the type invariant, `inner` contains an initialized allocator.
         // `guard` provides exclusive access.
@@ -434,15 +447,14 @@ pub fn alloc_blocks(
         size: u64,
         min_block_size: Alignment,
         flags: impl Into<GpuBuddyAllocFlags>,
-    ) -> impl PinInit<AllocatedBlocks, Error> {
-        let buddy_arc = Arc::clone(&self.0);
+    ) -> impl PinInit<AllocatedBlocks<'_>, Error> {
         let (start, end) = mode.range();
         let mode_flags = mode.as_flags();
         let modifier_flags = flags.into();
 
         // Create pin-initializer that initializes list and allocates blocks.
         try_pin_init!(AllocatedBlocks {
-            buddy: buddy_arc,
+            buddy: self,
             list <- CListHead::new(),
             _: {
                 // Reject zero-sized or inverted ranges.
@@ -483,13 +495,13 @@ pub fn alloc_blocks(
 ///
 /// - `list` is an initialized, valid list head containing allocated blocks.
 #[pin_data(PinnedDrop)]
-pub struct AllocatedBlocks {
+pub struct AllocatedBlocks<'a> {
     #[pin]
     list: CListHead,
-    buddy: Arc<GpuBuddyInner>,
+    buddy: &'a GpuBuddy,
 }
 
-impl AllocatedBlocks {
+impl AllocatedBlocks<'_> {
     /// Check if the block list is empty.
     pub fn is_empty(&self) -> bool {
         // An empty list head points to itself.
@@ -522,7 +534,7 @@ pub fn iter(&self) -> impl Iterator<Item = AllocatedBlock<'_>> + '_ {
 }
 
 #[pinned_drop]
-impl PinnedDrop for AllocatedBlocks {
+impl PinnedDrop for AllocatedBlocks<'_> {
     fn drop(self: Pin<&mut Self>) {
         let guard = self.buddy.lock();
 
@@ -582,7 +594,7 @@ unsafe impl Sync for Block {}
 /// Returned by [`AllocatedBlocks::iter()`].
 pub struct AllocatedBlock<'a> {
     this: &'a Block,
-    blocks: &'a AllocatedBlocks,
+    blocks: &'a AllocatedBlocks<'a>,
 }
 
 impl AllocatedBlock<'_> {

base-commit: 2a874fc59fdeb07159b627ca7681cfe6b4cff1de
-- 
2.56.1

