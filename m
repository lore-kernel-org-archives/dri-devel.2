Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3791099B3B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0A410EBAA;
	Fri, 20 Mar 2026 19:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RS/plEgH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A345010EC16;
 Fri, 20 Mar 2026 19:47:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B0F2412F2;
 Fri, 20 Mar 2026 19:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FD2C4CEF7;
 Fri, 20 Mar 2026 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774036026;
 bh=yc78EFSFizHHU1W4DvyE+4pE9pQQdt0bGIk0ILUuLHM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RS/plEgHZ2b/fcU7+m23NjZIXr1vn73AdcNkXaEE+f+jhAlYT1IL4zp/nHw2MjBBp
 HnkaMiqTht7Xkq6AQdlIPp9RHS7Uj4L6C/Sdu4TWkk7bZS9ITwgsqr9xGc/Wi9vjap
 vxtzvGt78R1lkvLLbDTn3pXiHjaLG8hb372GoSC4QD3ZO8JexrKvDp7OwJrhEvkZGd
 /Lavmr27PrELMEQK4K93VkH1JBMVURccwkoJLTVAWAb9X4yA65UWMRFyI+WX8O0EUK
 DbxOEeMVQ2kYlJCwKsSbwITKGHKVkVxL9iOPB6MvH1mwAzBiZefAXxXlQH9B5VX3AU
 uy11tKDMk49qA==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 6/8] gpu: nova-core: use Coherent::init to initialize
 GspFwWprMeta
Date: Fri, 20 Mar 2026 20:45:41 +0100
Message-ID: <20260320194626.36263-7-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320194626.36263-1-dakr@kernel.org>
References: <20260320194626.36263-1-dakr@kernel.org>
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

Convert wpr_meta to use Coherent::init() and simplify the
initialization.  It also avoids a separate initialization of
GspFwWprMeta on the stack.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/gsp/boot.rs |  7 ++-----
 drivers/gpu/nova-core/gsp/fw.rs   | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 5e73bd769dcc..e55210ebb6d1 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -2,8 +2,7 @@
 
 use kernel::{
     device,
-    dma::CoherentAllocation,
-    dma_write,
+    dma::Coherent,
     io::poll::read_poll_timeout,
     pci,
     prelude::*,
@@ -164,9 +163,7 @@ pub(crate) fn boot(
             bar,
         )?;
 
-        let wpr_meta =
-            CoherentAllocation::<GspFwWprMeta>::alloc_coherent(dev, 1, GFP_KERNEL | __GFP_ZERO)?;
-        dma_write!(wpr_meta, [0]?, GspFwWprMeta::new(&gsp_fw, &fb_layout));
+        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         self.cmdq
             .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev))?;
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index a061131b5412..4e3bfc6c4c47 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -204,7 +204,9 @@ pub(crate) fn wpr_heap_size(&self, chipset: Chipset, fb_size: u64) -> u64 {
 /// Structure passed to the GSP bootloader, containing the framebuffer layout as well as the DMA
 /// addresses of the GSP bootloader and firmware.
 #[repr(transparent)]
-pub(crate) struct GspFwWprMeta(bindings::GspFwWprMeta);
+pub(crate) struct GspFwWprMeta {
+    inner: bindings::GspFwWprMeta,
+}
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.
 unsafe impl AsBytes for GspFwWprMeta {}
@@ -217,10 +219,14 @@ unsafe impl FromBytes for GspFwWprMeta {}
 type GspFwWprMetaBootInfo = bindings::GspFwWprMeta__bindgen_ty_1__bindgen_ty_1;
 
 impl GspFwWprMeta {
-    /// Fill in and return a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
+    /// Returns an initializer for a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
     /// `fb_layout` layout.
-    pub(crate) fn new(gsp_firmware: &GspFirmware, fb_layout: &FbLayout) -> Self {
-        Self(bindings::GspFwWprMeta {
+    pub(crate) fn new<'a>(
+        gsp_firmware: &'a GspFirmware,
+        fb_layout: &'a FbLayout,
+    ) -> impl Init<Self> + 'a {
+        #[allow(non_snake_case)]
+        let init_inner = init!(bindings::GspFwWprMeta {
             // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
             magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
             revision: u64::from(bindings::GSP_FW_WPR_META_REVISION),
@@ -255,7 +261,11 @@ pub(crate) fn new(gsp_firmware: &GspFirmware, fb_layout: &FbLayout) -> Self {
             fbSize: fb_layout.fb.end - fb_layout.fb.start,
             vgaWorkspaceOffset: fb_layout.vga_workspace.start,
             vgaWorkspaceSize: fb_layout.vga_workspace.end - fb_layout.vga_workspace.start,
-            ..Default::default()
+            ..Zeroable::init_zeroed()
+        });
+
+        init!(GspFwWprMeta {
+            inner <- init_inner,
         })
     }
 }
-- 
2.53.0

