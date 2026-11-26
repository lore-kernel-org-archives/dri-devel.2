Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EC606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtKKI7Ii
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E322510E3FA;
	Thu, 26 Nov 2026 21:37:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC4010E3FA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:37:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95352454E8;
 Thu, 26 Nov 2026 21:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF0A1F000C1;
 Thu, 26 Nov 2026 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795729023;
 bh=zRZq5TRieezmJqScckkwdtBu2F34j5OY2aYNqgKpduk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DtKKI7IipqfvE15o7FDZxwjD/6Vua9ZKIQ35DF3ruOSUn7KMyZQf2sSpdinxhwHx9
 2SU7LkbFSwDalHKBhs3B+Hy77pXm0VJKj/EtRv4nv99Ilnuw7rNdnTusF4rBA8Zpi4
 Oa/crdGMBUaV8diMXbbb6+HN0H3jO5pFWxoZwUBDC6fQ3z1x0kz1Z38MpIPGH6bEC8
 hN5IdntDngT3HAzr9DfeweIvdaBOWOWbwdKoZ4OmaIptNEQaxpmV48o/CiORrosURc
 FYKBKcLAyHr6fIOfKIyQuVhqnCEtZX1IxH64KNhbjOFgOVDJu1Oocj/u0QuRmf+lli
 YYyQFYuze/ujA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ecourtney@nvidia.com, jhubbard@nvidia.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] gpu: nova-core: mm: use shared references to GpuMm
Date: Thu, 26 Nov 2026 22:36:03 +0100
Message-ID: <20261126213652.3716162-3-dakr@kernel.org>
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

The components owned by GpuMm now provide their own synchronization.

Accept shared references to the memory manager so independent users can
access these resources without requiring a lock around the container.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/gpu.rs               | 13 ++++++-------
 drivers/gpu/nova-core/mm.rs                |  2 +-
 drivers/gpu/nova-core/mm/bar_user.rs       |  6 +++---
 drivers/gpu/nova-core/mm/pagetable/map.rs  | 16 ++++++++--------
 drivers/gpu/nova-core/mm/pagetable/walk.rs |  4 ++--
 drivers/gpu/nova-core/mm/vmm.rs            | 10 +++++-----
 6 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8ab1687847ff..39e57e724a71 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -613,18 +613,17 @@ pub(crate) fn wait_gfw_boot_completion(
 
     /// Runs self-tests on the constructed [`Gpu`], logging failures without failing probe.
     #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
-    pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bound>) {
-        let this = self.project();
+    pub(crate) fn run_selftests(&self, pdev: &pci::Device<device::Bound>) {
         let dev = pdev.as_ref();
-        let regions = &this.gsp_static_info.usable_fb_regions;
+        let regions = &self.gsp_static_info.usable_fb_regions;
 
         if let Err(err) = crate::mm::selftest::run(
             dev,
-            this.mm,
+            &self.mm,
             regions,
-            &this.bar_user,
-            this.gsp_static_info.bar1_pde_base,
-            this.spec.chipset,
+            &self.bar_user,
+            self.gsp_static_info.bar1_pde_base,
+            self.spec.chipset,
         ) {
             dev_err!(dev, "self-tests failed: {:?}\n", err);
         }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index bbe23dc6351f..30a394424e12 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -311,7 +311,7 @@ pub(crate) mod selftest {
     /// Run MM subsystem self-tests during probe.
     pub(crate) fn run(
         dev: &device::Device<device::Bound>,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         usable_fb_regions: &[Range<u64>],
         bar_user: &bar_user::BarUser<'_>,
         bar1_pdb: u64,
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index f25ead64bf53..483129d3d0f7 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -61,7 +61,7 @@ pub(crate) fn new(
     /// Map physical pages to a contiguous BAR1 virtual range.
     pub(crate) fn map(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         pfns: &[Pfn],
         writable: bool,
     ) -> Result<BarUserAccess<'_>> {
@@ -91,7 +91,7 @@ pub(crate) struct BarUserAccess<'a> {
 #[expect(dead_code)]
 impl BarUserAccess<'_> {
     /// Tear down the BAR1 mapping.
-    pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {
+    pub(crate) fn release(mut self, mm: &GpuMm<'_>) -> Result {
         let mapped = self.mapped.take().ok_or(EINVAL)?;
         let mut vmm = self.bar_user.vmm.lock();
         vmm.unmap_pages(mm, mapped)?;
@@ -183,7 +183,7 @@ fn drop(&mut self) {
 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
 pub(crate) fn run_self_test(
     dev: &device::Device<device::Bound>,
-    mm: &mut GpuMm<'_>,
+    mm: &GpuMm<'_>,
     bar_user: &BarUser<'_>,
     bar1_pdb: u64,
     chipset: Chipset,
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
index ba23cd3c2b25..22e44386423f 100644
--- a/drivers/gpu/nova-core/mm/pagetable/map.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -82,7 +82,7 @@ pub(super) fn new(pdb_addr: VramAddress) -> Self {
     }
 
     /// Allocate and zero a physical page table page.
-    fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<PreparedPtPage> {
+    fn alloc_and_zero_page(mm: &GpuMm<'_>, level: PageTableLevel) -> Result<PreparedPtPage> {
         let blocks = KBox::pin_init(
             mm.buddy().alloc_blocks(
                 GpuBuddyAllocMode::Simple,
@@ -115,7 +115,7 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<Prep
     /// The mutable PRAMIN borrow ends before each allocation.
     fn ensure_single_pte_path(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         vfn: Vfn,
         pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
     ) -> Result {
@@ -168,7 +168,7 @@ fn ensure_single_pte_path(
     /// per-VFN to prepare pages for all missing PDEs.
     pub(super) fn prepare_map(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         vfn_start: Vfn,
         num_pages: usize,
         page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
@@ -193,7 +193,7 @@ pub(super) fn prepare_map(
     /// Drains `pt_pages` and moves allocations into `page_table_allocs`.
     pub(super) fn install_mappings(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
         page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
         vfn_start: Vfn,
@@ -251,7 +251,7 @@ pub(super) fn install_mappings(
     /// Invalidate PTEs for a range and flush TLB.
     pub(super) fn invalidate_ptes(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         vfn_start: Vfn,
         num_pages: usize,
     ) -> Result {
@@ -308,7 +308,7 @@ pub(in crate::mm) fn new(pdb_addr: VramAddress, version: MmuVersion) -> Self {
     /// Prepare page table resources for a mapping.
     pub(in crate::mm) fn prepare_map(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         vfn_start: Vfn,
         num_pages: usize,
         page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
@@ -323,7 +323,7 @@ pub(in crate::mm) fn prepare_map(
     /// Install prepared PDEs and write PTEs, then flush TLB.
     pub(in crate::mm) fn install_mappings(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
         page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
         vfn_start: Vfn,
@@ -339,7 +339,7 @@ pub(in crate::mm) fn install_mappings(
     /// Invalidate PTEs for a range and flush TLB.
     pub(in crate::mm) fn invalidate_ptes(
         &self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         vfn_start: Vfn,
         num_pages: usize,
     ) -> Result {
diff --git a/drivers/gpu/nova-core/mm/pagetable/walk.rs b/drivers/gpu/nova-core/mm/pagetable/walk.rs
index 899c61888756..59a011148455 100644
--- a/drivers/gpu/nova-core/mm/pagetable/walk.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/walk.rs
@@ -171,7 +171,7 @@ pub(super) fn walk_pde_levels(
     /// Walk to PTE for lookup only (no allocation).
     ///
     /// Returns [`WalkResult::PageTableMissing`] if intermediate tables don't exist.
-    pub(super) fn walk_to_pte_lookup(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<WalkResult> {
+    pub(super) fn walk_to_pte_lookup(&self, mm: &GpuMm<'_>, vfn: Vfn) -> Result<WalkResult> {
         mm.with_pramin_locked(|pramin| self.walk_to_pte_lookup_with_window(pramin, vfn))
     }
 
@@ -238,7 +238,7 @@ pub(in crate::mm) fn new(pdb_addr: VramAddress, version: MmuVersion) -> Self {
     }
 
     /// Walk to PTE for lookup.
-    pub(in crate::mm) fn walk_to_pte(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<WalkResult> {
+    pub(in crate::mm) fn walk_to_pte(&self, mm: &GpuMm<'_>, vfn: Vfn) -> Result<WalkResult> {
         pt_walk_dispatch!(self, walk_to_pte_lookup(mm, vfn))
     }
 }
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index 51b500a27233..c8258e579f8b 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -204,7 +204,7 @@ fn free_vfn(&self, vfn: Vfn) {
     }
 
     /// Read the [`Pfn`] for a mapped [`Vfn`] if one is mapped.
-    pub(super) fn read_mapping(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<Option<Pfn>> {
+    pub(super) fn read_mapping(&self, mm: &GpuMm<'_>, vfn: Vfn) -> Result<Option<Pfn>> {
         match self.pt_walk.walk_to_pte(mm, vfn)? {
             WalkResult::Mapped { pfn, .. } => Ok(Some(pfn)),
             WalkResult::Unmapped { .. } | WalkResult::PageTableMissing => Ok(None),
@@ -220,7 +220,7 @@ pub(super) fn read_mapping(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<Option
     /// to call outside the fence signalling critical path.
     pub(crate) fn prepare_map(
         &mut self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         num_pages: usize,
         va_range: Option<Range<u64>>,
     ) -> Result<PreparedMapping> {
@@ -254,7 +254,7 @@ pub(crate) fn prepare_map(
     /// Installs all prepared PDEs and writes PTEs into the page table, then flushes TLB.
     pub(crate) fn execute_map(
         &mut self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         prepared: PreparedMapping,
         pfns: &[Pfn],
         writable: bool,
@@ -297,7 +297,7 @@ pub(crate) fn execute_map(
     /// [`Vmm::execute_map()`] will be called separately.
     pub(crate) fn map_pages(
         &mut self,
-        mm: &mut GpuMm<'_>,
+        mm: &GpuMm<'_>,
         pfns: &[Pfn],
         va_range: Option<Range<u64>>,
         writable: bool,
@@ -324,7 +324,7 @@ pub(crate) fn map_pages(
     }
 
     /// Unmap all pages in a [`MappedRange`] with a single TLB flush.
-    pub(crate) fn unmap_pages(&mut self, mm: &mut GpuMm<'_>, range: MappedRange) -> Result {
+    pub(crate) fn unmap_pages(&mut self, mm: &GpuMm<'_>, range: MappedRange) -> Result {
         let result = self
             .pt_map
             .invalidate_ptes(mm, range.vfn_start, range.num_pages);
-- 
2.56.1

