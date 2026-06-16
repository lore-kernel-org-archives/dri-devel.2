Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115B3CD98EC
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 23:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A45C10E8CF;
	Tue, 16 Jun 2026 23:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IPsHo9Mb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF0910E8BD
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 23:48:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 068E54060B;
 Tue, 16 Jun 2026 23:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEEAAC4AF0F;
 Tue, 16 Jun 2026 23:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781653706;
 bh=Sw0CArHglrOPy8B/0AvzyTGPre7dhIz218l0RWsNwT0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=IPsHo9MblOQ+sVzsjAYnKM2Vaygyjoyc1pVF4ekM+dlYgnC4BTBw1zX6XyTiQi2MK
 rlouRCRp52MBJrwaF64oVP4cnu094vYNltn9DZGhNZwCPKxb4J7hopuOMnqaMmKwCU
 M0kjIUPXOoc2GUCqBYPa3luG8U8Lel9eFzvUiTZT4BeMuUxHLwjSdLoB6BtNISuzM+
 Oi/G/r+36yngMBN7PFaeKEOEBT2/koRKMHoLkL4byHL6aKXSUqUvKwSq4oCiAGCMIo
 pIWIGVUJKhEt1KqA2RqgfJP/ntzTWaFtttV/vikPhHLMGifBCuPSpZ9c4e25ndJ0BK
 OFwcsa+mHW2xA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D5CD98D2;
 Tue, 16 Jun 2026 23:48:26 +0000 (UTC)
From: Antonin Malzieu Ridolfi via B4 Relay <devnull+dev.nanonej.com@kernel.org>
Date: Wed, 17 Jun 2026 01:48:13 +0200
Subject: [PATCH 2/5] gpu: nova-core: gsp: Move PBUS register definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-nova-core-regs-split-v1-2-4c7dc4450ea7@nanonej.com>
References: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
In-Reply-To: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Antonin Malzieu Ridolfi <dev@nanonej.com>
Cc: linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, daniel.almeida@collabora.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3832; i=dev@nanonej.com;
 h=from:subject:message-id;
 bh=oJAAn5nH+lW2zNbhawIFPb0gkR+jFc56SN0jbmio4SQ=;
 b=owEBbQKS/ZANAwAKAWaH8SMKFRX9AcsmYgBqMeDIgyMxZgaQDKC5D2iuOxdFRWPBFEB87gJHM
 JWP/6EVNWeJAjMEAAEKAB0WIQSDtk+wfJEhL1KFIn1mh/EjChUV/QUCajHgyAAKCRBmh/EjChUV
 /R6sD/sEtMw3y/cjwGBxeKA08Drtgbq8US+9GlLzrpRraHGuiIwDkjECBM5eOxpI+wtRaJyjlMs
 pcR1Us4mJAOcwkNJwu4X8jxiIRtvzE4uKpEJvMu5NTDZ1Nlw06VlcbsK15715GAyJqFxFlRQ156
 4qJ3CPWEb1Oxmo48eFi61wt1iO4W/GOd1GTeaMgUgY27U8Lz9wNqOfse4DFPiF3IcBaahQwCA2L
 QmebeumkEindkQvHZd71z6UJ/HRl0d6ynKNkTZxMmi9dqvz2o/UmtOU2Pw1PinTP3Tpse7BB2rv
 gld8MZ36ZVRYYgU63LCpM1oosAjR1pRMWjr3PFd58ksuH4b38Uf0XkU98fHL0LQCNAudEriGmIp
 TfcuIVRo/B8t9++ydut0t1KXQtyWAY3Wi6SdDY/b1Uj6uGFJtOz+uxZhjgsqOW5o8EZT5ziXLoa
 7IpDORShpXzWbBgn7P04osVQ9+cQLviKu7jPrjts8bsIdF3fX36gr7xYlk33s/TCyCYj67md2TQ
 xmG4b3wSTRN8RY+yoB0iExpULrTQUwqIWPNVnNk2ON/NhRV8lzsJHN9XG3FXS0SlDsBhecRu/zl
 QzuhZGk9ax1mgREDUwfWPEWEJR4rdA1pmpjJz6T3q0BKNEfB2P3y18Tv7WrBwupzpxbxf+NGcW/
 s5Zaq+xzW77xg2w==
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

Move PBUS register definition into gsp module and update registers
visibility.

Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 12 ++++++------
 drivers/gpu/nova-core/gsp/regs.rs      | 11 +++++++++++
 drivers/gpu/nova-core/regs.rs          | 11 -----------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index eb7166148cc9..d46e8ec65785 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -37,6 +37,7 @@
             GspHal,
             UnloadBundle, //
         },
+        regs,
         sequencer::{
             GspSequencer,
             GspSequencerParams, //
@@ -44,7 +45,6 @@
         Gsp,
         GspFwWprMeta, //
     },
-    regs,
     vbios::Vbios, //
 };
 
@@ -141,7 +141,7 @@ fn run(
             .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
 
         // Remove WPR2 region if set.
-        let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+        let wpr2_hi = bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
         let booter_unloader_res = (|| {
             if !wpr2_hi.is_wpr2_set() {
                 return Ok(());
@@ -160,7 +160,7 @@ fn run(
             }
 
             // Confirm that the WPR2 region has been removed.
-            let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+            let wpr2_hi = bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
             if wpr2_hi.is_wpr2_set() {
                 dev_err!(
                     dev,
@@ -189,7 +189,7 @@ fn run_fwsec_frts(
 ) -> Result {
     // Check that the WPR2 region does not already exist - if it does, we cannot run
     // FWSEC-FRTS until the GPU is reset.
-    if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
+    if bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
         dev_err!(
             dev,
             "WPR2 region already exists - GPU needs to be reset to proceed\n"
@@ -234,8 +234,8 @@ fn run_fwsec_frts(
 
     // Check that the WPR2 region has been created as we requested.
     let (wpr2_lo, wpr2_hi) = (
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
+        bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+        bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
     );
 
     match (wpr2_lo, wpr2_hi) {
diff --git a/drivers/gpu/nova-core/gsp/regs.rs b/drivers/gpu/nova-core/gsp/regs.rs
index a76dea3c3ab0..571b7e0a95ee 100644
--- a/drivers/gpu/nova-core/gsp/regs.rs
+++ b/drivers/gpu/nova-core/gsp/regs.rs
@@ -2,6 +2,17 @@
 
 use kernel::io::register;
 
+// PBUS
+
+register! {
+    pub(super) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
+
+    /// Scratch register 0xe used as FRTS firmware error code.
+    pub(super) NV_PBUS_SW_SCRATCH_0E_FRTS_ERR(u32) => NV_PBUS_SW_SCRATCH[0xe] {
+        31:16   frts_err_code;
+    }
+}
+
 // PGSP
 
 register! {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 6a86ac05e59f..59d36870b92b 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -105,17 +105,6 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
     }
 }
 
-// PBUS
-
-register! {
-    pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
-
-    /// Scratch register 0xe used as FRTS firmware error code.
-    pub(crate) NV_PBUS_SW_SCRATCH_0E_FRTS_ERR(u32) => NV_PBUS_SW_SCRATCH[0xe] {
-        31:16   frts_err_code;
-    }
-}
-
 // PFB
 
 register! {

-- 
2.54.0


