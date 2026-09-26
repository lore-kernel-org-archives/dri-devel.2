Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55587C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1F810E2D9;
	Sat, 26 Sep 2026 12:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BUay6oS0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C29210E1FD
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:44:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6656643EBC;
 Sat, 26 Sep 2026 12:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378C41F00898;
 Sat, 26 Sep 2026 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790426652;
 bh=5L3CompX72sG2GpOS8TBtf9PZeipBZKMDVitrEtGYjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BUay6oS0iuRwNw7XSCRUHQK6Sk6sl5+8hPuHgZ3Tuiix4si4gGIVa6m4dqGA09FZF
 gnJ4mIuXT+UIE9DK9fof+3G2fFtuKgeftsrvK4f2d/vOsMDL9AD7Zt98keHEkng3V5
 iD5d0TfrLM4JuRS7aueFhL5iuFqQca6fA4BwwRCzynP0zXnDkifrNTultbarOMKAkp
 DOG0m44EiB7W4xq0vNkgNbChGujgN864v08lzGpZXo1TWZnScqNYQoEsjoML4JReLX
 PzNb/FwzI9duvbhIyRfqEcKyJmXX8PLd3QY7nZoMiDdcJmcpZitAP3qinqXQrXMGBA
 LdX2i0EFRTokA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/4] gpu: nova-core: remove unnecessary Arc around BarUser
Date: Sat, 26 Sep 2026 14:43:25 +0200
Message-ID: <20260926124405.604707-3-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926124405.604707-1-dakr@kernel.org>
References: <20260926124405.604707-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Remove the unnecessary Arc around BarUser and get rid of
Result<impl PinInit<T>> in favor of impl PinInit<T, Error>.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/gpu.rs         | 24 +++++++++++-------------
 drivers/gpu/nova-core/mm.rs          |  5 ++---
 drivers/gpu/nova-core/mm/bar_user.rs | 16 +++++++++-------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 1ae287c9e776..123e605fa2c2 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -16,7 +16,6 @@
         SizeConstants,
         SZ_4K, //
     },
-    sync::Arc,
 };
 
 use crate::{
@@ -309,7 +308,8 @@ pub(crate) struct Gpu<'gpu> {
     /// the GSP is still operational.
     mm: GpuMm<'gpu>,
     /// BAR1 user interface for CPU access to GPU virtual memory.
-    bar_user: Arc<BarUser<'gpu>>,
+    #[pin]
+    bar_user: BarUser<'gpu>,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -465,19 +465,17 @@ pub(crate) fn new<'a>(
             },
 
             // Create BAR1 user interface for CPU access to GPU virtual memory.
-            bar_user: {
+            bar_user <- {
                 let pdb_addr = VramAddress::from_raw(gsp_static_info.bar1_pde_base);
                 let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
                 let bar1_size = pdev.resource_len(bar1_idx)?;
-                Arc::pin_init(
-                    BarUser::new(
-                        pdb_addr,
-                        gsp_resources.spec.chipset,
-                        bar1_size,
-                        bar1,
-                    )?,
-                    GFP_KERNEL,
-                )?
+
+                BarUser::new(
+                    pdb_addr,
+                    gsp_resources.spec.chipset,
+                    bar1_size,
+                    bar1,
+                )
             },
         })
     }
@@ -493,7 +491,7 @@ pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bou
             dev,
             this.mm,
             regions,
-            this.bar_user,
+            &this.bar_user,
             this.gsp_static_info.bar1_pde_base,
             this.spec.chipset,
         ) {
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index a5bc4042577b..8a934c55169f 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -298,8 +298,7 @@ pub(crate) mod selftest {
 
     use kernel::{
         device,
-        sizes::SizeConstants,
-        sync::Arc, //
+        sizes::SizeConstants, //
     };
 
     use super::*;
@@ -309,7 +308,7 @@ pub(crate) fn run(
         dev: &device::Device<device::Bound>,
         mm: &mut GpuMm<'_>,
         usable_fb_regions: &[Range<u64>],
-        bar_user: &Arc<bar_user::BarUser<'_>>,
+        bar_user: &bar_user::BarUser<'_>,
         bar1_pdb: u64,
         chipset: Chipset,
     ) -> Result {
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 86b5d302188e..6c8fa06d9f4b 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -51,12 +51,14 @@ pub(crate) fn new(
         chipset: Chipset,
         va_size: u64,
         bar1: Bar1<'gpu>,
-    ) -> Result<impl PinInit<Self> + 'gpu> {
-        let vmm = Vmm::new(pdb_addr, chipset.mmu_version(), va_size)?;
-        Ok(pin_init!(Self {
-            vmm <- new_mutex!(vmm, "bar_user_vmm"),
+    ) -> impl PinInit<Self, Error> + 'gpu {
+        try_pin_init!(Self {
+            vmm <- new_mutex!(
+                Vmm::new(pdb_addr, chipset.mmu_version(), va_size)?,
+                "bar_user_vmm",
+            ),
             bar1,
-        }))
+        })
     }
 
     /// Map physical pages to a contiguous BAR1 virtual range.
@@ -183,7 +185,7 @@ fn drop(&mut self) {
 pub(crate) fn run_self_test(
     dev: &device::Device<device::Bound>,
     mm: &mut GpuMm<'_>,
-    bar_user: &Arc<BarUser<'_>>,
+    bar_user: &BarUser<'_>,
     bar1_pdb: u64,
     chipset: Chipset,
 ) -> Result {
@@ -389,7 +391,7 @@ pub(crate) fn run_self_test(
 
     // Test 4: Exercise `BarUser::map()` end-to-end.
     let bar_user = Arc::pin_init(
-        BarUser::new(pdb_addr, chipset, SZ_64K.into_safe_cast(), bar1)?,
+        BarUser::new(pdb_addr, chipset, SZ_64K.into_safe_cast(), bar1),
         GFP_KERNEL,
     )?;
     let access = bar_user.map(mm, &[test_pfn], true)?;
-- 
2.55.0

