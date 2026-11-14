Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420B606A331
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9uttR3t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBED610E11B;
	Sat, 14 Nov 2026 04:35:54 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F380910E11B
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 04:35:47 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cdb1199bfd8so700328a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794630947; x=1795235747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RxV2i3CwJwPvn+mwJ4cbWtgTLXqgAkSjs2t6czxawYk=;
 b=A9uttR3toAblMO21ZC42vJgQ+E3cLC1Zcr8UtqGkoiXYVDsMlpKnN/I1sNaOfvo4hh
 MUoM0es/Jn7i1ylRYHoQB+d+1Fqap7RX6dj3hyrgABZFA3hbzpwGgOBW2sfvJbgSTii2
 wEbvp95ouf3fJfeKIRPOElg/gcHwUUUb8spVrhgHdRdnX+Ssfi4kvimsCY8RWnGuoKJ4
 tNPWENwtZPoEDdP35X7o1S5+7LQ1QvaFRBzo8Ot6tUg577HE2PuYgpPaZHeG+85zIO4S
 6bFt290HA9uv9yP5anY7w75qnA+lZb6Y9HzSNEJnTqU0djZPaPX5i2JQ9YOB/ROzHTIt
 N2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794630947; x=1795235747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RxV2i3CwJwPvn+mwJ4cbWtgTLXqgAkSjs2t6czxawYk=;
 b=Sfe6bX6h16R/jn3KLayhwYdGnoPAb5c4PDxL3sFyV2FG5KU5osCNhoQf1S/v7FrKEO
 9t7uTFZvhE3j+OQk95jXeTK3pQmTUWFTpeo3BMnGmc6vzXAtIfhSIdYCPnG3knkzAcJv
 3gdvGt4XZ7OvXkCh7R8oS323cF1t81Ud/O6J30aAfEYHTuHm1aZ3HixsII0nc2co8Jnl
 fXOGoBi+CG38Fy+cPqQr2nf5iYPcqG9r3ecgCbhWKXScgm2mM0iJLB60vbYLJyvR85qX
 m6TbsXWvqobCOu/udLWXDyfpKNd4HC+9Ss38I8p4XmbLyPqIHe4IwRY7xQcMH8jip9Bh
 ObDg==
X-Forwarded-Encrypted: i=1;
 AL+hErH+2NVAH6TOgq7E3d181RCo0Y2fmEE6zCRMlWG7j4tb/uB1yy9kXIekOtmra3K4yRuvpewLfWhVJnw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8egJ8f72e6hyKueB//clql3Q7S/JFg/8luwTrmABcEeDlSDMco
 S/8BQhPbrCM5gKqx52SQUI9VABcsy/LWf2Fo79gNvChNBmD1LBcC3VRL
X-Gm-Gg: AYBFou0rOY8kVFtsv2qMUKGOeyB+9mQO2DIiK7liKb3lPmpJkdubFmf/NoWZPjn8oLG
 F9r64shJJPgiBO1IijG4W/N5IQRKsQ0gNZzKDgV7B31gwV/TKpF3RNWrfDxGIbj3yfqWYJVnjFv
 tai+5EOEpbY+TYFgyzESz7f/owPz+/T7GsM5Fm1yKKDyZRwCL5V7qqGApEQkE9QknvTrxwoKTvE
 IzD7fXC80DB2sm9yI9JyR6lxHJxNcU3xuCF2qVthW0AfrKPJj8LL2UJ5HBBwJ4vcHLDWggV1fyE
 wLT+hxh9mvTZeRojttdRQD+LSIB2/NRXUU8Ys2onoxJTy1hUmDmK9lhDp6KohH/Lc/BrNOWQIvV
 wxyVAgdEZFo60k6d2D/2yecrRvGTM3I873wvl63Qg9Z/T03Y4iNHsPf8IK6fshVrTxlpi3EYHAc
 HOWRtB2FKdGv3isc1upGhrl2HJElJ7+4nlogGLBp1RuCcJIHUEfBPVPG6msnW/Oy/1ahYcIzAdl
 TgU1IYrh10uo+/+7aJKivDPsnh/S2rWiqviA+Ev8HU+8lpMITc+Vct/cfBAp768DMRvtY5d2wNT
 pWo8iDDAMwf0a8xMUZ6Bi+2JKVndB8CmL5g=
X-Received: by 2002:a17:90a:c88b:b0:3ac:8897:7ba5 with SMTP id
 98e67ed59e1d1-3b1b0ba890emr4682230a91.59.1794630947279; 
 Fri, 13 Nov 2026 20:35:47 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d32ea0sm12089020a91.15.2026.11.13.20.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:35:46 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	joelagnelf@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ecourtney@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 vladazaharova2018@gmail.com
Subject: [PATCH v2] gpu: nova-core: mm: reserve room for every prepared page
 table page
Date: Sat, 14 Nov 2026 11:35:35 +0700
Message-ID: <20261114043535.158583-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

install_mappings() moves every page in pt_pages into page_table_allocs
with push_within_capacity(), but prepare_map() reserves room only for an
estimate of the pages of the mapping it prepares. The estimate is too
low for a range that crosses a page table boundary, and it leaves out
pages that earlier calls put in pt_pages. Preparing several mappings
before executing them is then enough to make the push fail. The page is
freed although its PDE has been written, and pages still in pt_pages
can have their PDEs installed into it later.

Reserve room for each page when it is added to pt_pages, and drop the
estimate. Also move a page into page_table_allocs before writing its
PDE, so that a failing PDE write does not free it either.

The problem was found by an LLM-assisted code review.

Fixes: 4e4182282d4e ("gpu: nova-core: mm: Add multi-page mapping API to VMM")
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
v2: reserve room for each page as it is added to pt_pages, so that pages
left by earlier or failed calls are covered too. The Sashiko review
pointed out that v1 alone still lets a failing push free a parent page
while its children stay in pt_pages.

Tested on a GB203 with a temporary self-test that prepares eight
single-page mappings 1 TiB apart in a fresh Vmm and then executes them:
without this patch every execute_map() fails with -ENOMEM, with it they
all succeed. The MM self-tests still pass.

v1: https://lore.kernel.org/nova-gpu/20261113075422.943779-1-vladazaharova2018@gmail.com/

 drivers/gpu/nova-core/mm/pagetable.rs     | 24 ---------------
 drivers/gpu/nova-core/mm/pagetable/map.rs | 37 ++++++++++++++---------
 2 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 63a7e1855caa..03a132406a15 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -248,30 +248,6 @@ fn entry_size(level: PageTableLevel) -> usize {
             8 // 64-bit PDE/PTE
         }
     }
-
-    /// Compute upper bound on page table pages needed for `num_virt_pages`.
-    ///
-    /// Walks from PTE level up through PDE levels, accumulating the tree.
-    fn pt_pages_upper_bound(num_virt_pages: usize) -> usize {
-        let mut total = 0;
-
-        // PTE pages at the leaf level.
-        let pte_epp = Self::entries_per_page(Self::PTE_LEVEL);
-        let mut pages_at_level = num_virt_pages.div_ceil(pte_epp);
-        total += pages_at_level;
-
-        // Walk PDE levels bottom-up (reverse of PDE_LEVELS).
-        for &level in Self::PDE_LEVELS.iter().rev() {
-            let epp = Self::entries_per_page(level);
-
-            // How many pages at this level do we need to point to
-            // the previous pages_at_level?
-            pages_at_level = pages_at_level.div_ceil(epp);
-            total += pages_at_level;
-        }
-
-        total
-    }
 }
 
 /// Marker struct for MMU v2 (Turing/Ampere/Ada).
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
index f7774b9cc972..2517fdcc5217 100644
--- a/drivers/gpu/nova-core/mm/pagetable/map.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -116,6 +116,7 @@ fn ensure_single_pte_path(
         &self,
         mm: &mut GpuMm<'_>,
         vfn: Vfn,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
         pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
     ) -> Result {
         let max_iter = 2 * M::PDE_LEVELS.len();
@@ -140,6 +141,10 @@ fn ensure_single_pte_path(
                     install_addr,
                     level,
                 } => {
+                    // Reserve so install_mappings() can use push_within_capacity (no alloc in
+                    // fence signalling critical path). It installs every page in `pt_pages`,
+                    // including pages left by earlier calls, so keep room for all of them.
+                    page_table_allocs.reserve(pt_pages.iter().count() + 1, GFP_KERNEL)?;
                     let page = Self::alloc_and_zero_page(mm, level)?;
                     let node = RBTreeNode::new(install_addr, page, GFP_KERNEL)?;
                     let old = pt_pages.insert(node);
@@ -163,8 +168,8 @@ fn ensure_single_pte_path(
 
     /// Prepare page table resources for mapping `num_pages` pages starting at `vfn_start`.
     ///
-    /// Reserves capacity in `page_table_allocs`, then walks the hierarchy
-    /// per-VFN to prepare pages for all missing PDEs.
+    /// Walks the hierarchy per-VFN to prepare pages for all missing PDEs, and
+    /// reserves capacity in `page_table_allocs` for them.
     pub(super) fn prepare_map(
         &self,
         mm: &mut GpuMm<'_>,
@@ -173,16 +178,11 @@ pub(super) fn prepare_map(
         page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
         pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
     ) -> Result {
-        // Pre-reserve so install_mappings() can use push_within_capacity (no alloc
-        // in fence signalling critical path).
-        let pt_upper_bound = M::pt_pages_upper_bound(num_pages);
-        page_table_allocs.reserve(pt_upper_bound, GFP_KERNEL)?;
-
         // Walk the hierarchy per-VFN to prepare pages for all missing PDEs.
         for i in 0..num_pages {
             let i_u64: u64 = i.into_safe_cast();
             let vfn = Vfn::new(vfn_start.raw() + i_u64);
-            self.ensure_single_pte_path(mm, vfn, pt_pages)?;
+            self.ensure_single_pte_path(mm, vfn, page_table_allocs, pt_pages)?;
         }
         Ok(())
     }
@@ -207,10 +207,21 @@ pub(super) fn install_mappings(
             while let Some(c) = cursor {
                 let (next, node) = c.remove_current();
                 let (install_addr, page) = node.to_key_value();
-                let page_vram =
-                    VramAddress::from_raw(page.alloc.iter().next().ok_or(ENOMEM)?.offset());
+                let page_vram = page
+                    .alloc
+                    .iter()
+                    .next()
+                    .map(|b| VramAddress::from_raw(b.offset()));
+                let level = page.level;
+
+                // Keep the page before pointing a PDE at it, so that no failure below can free a
+                // page that a PDE points at. ensure_single_pte_path() reserved room for it.
+                page_table_allocs
+                    .push_within_capacity(page.alloc)
+                    .map_err(|_| ENOMEM)?;
+                let page_vram = page_vram.ok_or(ENOMEM)?;
 
-                if page.level == M::DUAL_PDE_LEVEL {
+                if level == M::DUAL_PDE_LEVEL {
                     let new_dpde = M::DualPde::new_small(Pfn::from(page_vram));
                     new_dpde.write(pramin, install_addr)?;
                 } else {
@@ -218,10 +229,6 @@ pub(super) fn install_mappings(
                     new_pde.write(pramin, install_addr)?;
                 }
 
-                page_table_allocs
-                    .push_within_capacity(page.alloc)
-                    .map_err(|_| ENOMEM)?;
-
                 cursor = next;
             }
 

base-commit: 0ff9e5b9ff6736c37593cd7db89f4593ec4f8e86
-- 
2.56.0

