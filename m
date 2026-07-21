Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0821FC44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419A410E199;
	Tue, 21 Jul 2026 15:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rf+Y4B9A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F3610E199
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:41:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 14EFE413FE;
 Tue, 21 Jul 2026 15:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5CD9C2BCF6;
 Tue, 21 Jul 2026 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1784648497;
 bh=T1fGJquZ1PQ3x9Puk6RACOZxVIFWT/srP2SCTPcbPAA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=rf+Y4B9AvnYKrzG7WGv/h9SE6C4H8zF+DW4H/ZWU3zQ+8uDhhnw+r9BsAjS8DAwZe
 XW8S0E4YrJHzbpO+mCzGI5N5fX1N8mvq+CB4jckzfsVokqgqYo6VUau+pUHFnAT1Yk
 m0tHiAUe8Kec3yr6wrHEVR9qdx8ZiUqmaGe6Itbr2Lg0VF12GyAVMwIc8VDnnibW2O
 L5VtSmS3PlgzHMUJ4WU1BO7zw5V/ORq515GQCzQrGmtlvC7lvVFM1DztVPTn9iR2ya
 A57exQtSindmZiq8Ab7S8mkwxZgxDLLMshes9E5uCKypQmtQXU1ro8Ta2S2wlSISmW
 yIm/6qRBHS8XA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C43B1C44533;
 Tue, 21 Jul 2026 15:41:36 +0000 (UTC)
From: Antonin Malzieu Ridolfi via B4 Relay <devnull+dev.nanonej.com@kernel.org>
Date: Tue, 21 Jul 2026 17:41:07 +0200
Subject: [PATCH 1/3] gpu: nova-core: Add function to query WPR2 range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-nova-core-regs-split-v1-1-384fa2a42244@nanonej.com>
References: <20260721-nova-core-regs-split-v1-0-384fa2a42244@nanonej.com>
In-Reply-To: <20260721-nova-core-regs-split-v1-0-384fa2a42244@nanonej.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, daniel.almeida@collabora.com, 
 Antonin Malzieu Ridolfi <dev@nanonej.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5155; i=dev@nanonej.com;
 h=from:subject:message-id;
 bh=VlhUb7uLUDcrDDc81OAAEbtjZcATBSKEOEjEUDRfBGo=;
 b=owEBbQKS/ZANAwAKAWaH8SMKFRX9AcsmYgBqX5MtR7OCSOaTB7f95uxZ5CMIwjTPCK7TGBH60
 mjyQm1eFAaJAjMEAAEKAB0WIQSDtk+wfJEhL1KFIn1mh/EjChUV/QUCal+TLQAKCRBmh/EjChUV
 /W/iD/9jaSQEbjCMeg1Mx4sE5SFlECu638a1tBA6Zq/yFVBYaJS1GItxZT0QHsukoZMNONxYSrF
 qOPfWHkyhGFEVV8mSdvrXn463aOAvWZ0CbTyU6DoRqk1c5u3jroLIswpJdjj+obS51v0RPtc24q
 L9yPmKB6yQUEj9kmlHsGQra7l59luiFdR06/W9kFAwNOXNl3VR5A+dgiuBVPFSh8Al2zuI9642k
 He9OgHKRk9RPZOmxn4RYZa1dBx0qbSbhMbELLepVrmkBOSd4yzHwsEuHwpejgMu+Z/6vfZIMCBJ
 PXRRPlSXWmKVu+DOQgBh5vKg+/W0g73BB9DFBf8Io6ebpTnnl9z1jzC35LZEVea7nayAlL+D6DN
 b23dd71oz23NWaSeotE4J7phbFnqkr8vZRX170SkEvKrR0jfM6n2MB5FQHWQA4eKSlm5PZ3JiyZ
 ECbOmyq1dAd50R6FqdfJnx7he2HccyyJWeN+l1RDoH8XrIOTaQ2seZLVT9wmo5et+MZwJwMaxv/
 i0GyG3y2eYRFLWo9/YpLYJfRrVczTzhzIXJa2aJCeFG3DGbtKpCpKn8/Ki7eRuVVzUoR3RUD7qX
 oM0SVo3I3Ig/baNzmH0jAtLjrcqie9TGj7H19xdJWPatt48QQGpe5LpQgvtBGytdVudyWXX/pwL
 wHbEhOQl7M6sGqg==
X-Developer-Key: i=dev@nanonej.com; a=openpgp;
 fpr=83B64FB07C91212F5285227D6687F1230A1515FD
X-Endpoint-Received: by B4 Relay for dev@nanonej.com/default with auth_id=825
X-Original-From: Antonin Malzieu Ridolfi <dev@nanonej.com>
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
Reply-To: dev@nanonej.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Antonin Malzieu Ridolfi <dev@nanonej.com>

Create new function abstracting WPR2 region range query.
Refactor gsp hal tu102 to query the WPR2 region range using this new
function.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
---
 drivers/gpu/nova-core/fb.rs            | 15 +++++++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 58 +++++++++++++++-------------------
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 273cff752fae..864a34ca20b8 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -270,3 +270,18 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Resu
         })
     }
 }
+
+/// Reads the WPR2 memory region registers and returns the range if set.
+/// Returns `None` if the WPR2 region is not set.
+pub(crate) fn wpr2_range(bar: Bar0<'_>) -> Option<Range<u64>> {
+    let (wpr2_lo, wpr2_hi) = (
+        bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO),
+        bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI),
+    );
+
+    if !wpr2_hi.is_wpr2_set() {
+        return None;
+    }
+
+    Some(wpr2_lo.lower_bound()..wpr2_hi.higher_bound())
+}
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 29bb17171f56..b3242aaeea45 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -17,7 +17,10 @@
         sec2::Sec2,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::{
+        wpr2_range,
+        FbLayout, //
+    },
     firmware::{
         booter::{
             BooterFirmware,
@@ -90,9 +93,8 @@ fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
             .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
 
         // Remove WPR2 region if set.
-        let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
         let booter_unloader_res = (|| {
-            if !wpr2_hi.is_wpr2_set() {
+            if wpr2_range(bar).is_none() {
                 return Ok(());
             }
 
@@ -110,8 +112,7 @@ fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
             }
 
             // Confirm that the WPR2 region has been removed.
-            let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
-            if wpr2_hi.is_wpr2_set() {
+            if wpr2_range(bar).is_some() {
                 dev_err!(
                     dev,
                     "WPR2 region still set after Booter Unloader returned\n"
@@ -144,9 +145,9 @@ fn run_fwsec_frts(
         bios: &Vbios,
         fb_layout: &FbLayout,
     ) -> Result {
-        // Check that the WPR2 region does not already exist - if it does, we cannot run
-        // FWSEC-FRTS until the GPU is reset.
-        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
+        // Check that the WPR2 region does not already exist -
+        // if it does, we cannot run FWSEC-FRTS until the GPU is reset.
+        if wpr2_range(bar).is_some() {
             dev_err!(
                 dev,
                 "WPR2 region already exists - GPU needs to be reset to proceed\n"
@@ -189,34 +190,27 @@ fn run_fwsec_frts(
         }
 
         // Check that the WPR2 region has been created as we requested.
-        let (wpr2_lo, wpr2_hi) = (
-            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
-            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
-        );
-
-        match (wpr2_lo, wpr2_hi) {
-            (_, 0) => {
-                dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
+        let Some(wpr2_range) = wpr2_range(bar) else {
+            dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
 
-                Err(EIO)
-            }
-            (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
-                dev_err!(
-                    dev,
-                    "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
-                    wpr2_lo,
-                    fb_layout.frts.start,
-                );
+            return Err(EIO);
+        };
 
-                Err(EIO)
-            }
-            (wpr2_lo, wpr2_hi) => {
-                dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
-                dev_dbg!(dev, "GPU instance built\n");
+        if wpr2_range.start != fb_layout.frts.start {
+            dev_err!(
+                dev,
+                "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
+                wpr2_range.start,
+                fb_layout.frts.start,
+            );
 
-                Ok(())
-            }
+            return Err(EIO);
         }
+
+        dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_range.start, wpr2_range.end);
+        dev_dbg!(dev, "GPU instance built\n");
+
+        Ok(())
     }
 
     /// Load and prepare the resources required to properly reset the GSP after it has been stopped.

-- 
2.55.0


