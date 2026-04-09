Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4839BF364A6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FEA10E041;
	Thu,  9 Apr 2026 17:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="UzGdJrXf";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328F210E041
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775757123; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b1KAxY5KB87PrzaHS+2m2feXClExmLK16vddxmU2htRbLCF0EPcYZv29AjR2Hy5sLeC4u6KSyvGIF+wS4XONa8VNfXPgaKRpChDe+m9AYFT3f/AQClROhlI38tf12BtYQ4KPvtVbwoA0IzlQGiTy8/Dp8aIaWcQ4En+JVC2o2K4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775757123;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=any4v+IkRdjJFkXStey/qMTxDVoxDDnAeFVjH9Os6NI=; 
 b=OMiJJuv/4cfOfBuIusWY6mK5ddF1xDGcGtQI4TXozaVrMe+q4a9nSdgqWi4gkMsrTeGzyEqTEFAIFcs64kxGZWkF8eP8zaswPqqtWDS4J6Ht4f2RbYR8JxI7lMw5SXdczT6JomuhZsUad6tFPNGFzvHbGzvdTEZisaJuyN0qVr8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775757123; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=any4v+IkRdjJFkXStey/qMTxDVoxDDnAeFVjH9Os6NI=;
 b=UzGdJrXfEvxWtTvDnDMQu4U1poyt1ZoUD4SjLclOshcH0DLnh+KXnX6+1rlcpG1t
 WnEu0dDs4VYINANIdoeG52pD2a39vhsth0En4f8uRWCQDgpeXs4Oenn17Tvg05b8aIO
 QQMlYzjDgwFiL/yBFCBWh744yXys4nfSrbxTWL8g=
Received: by mx.zohomail.com with SMTPS id 1775757122209250.6047478742007;
 Thu, 9 Apr 2026 10:52:02 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 09 Apr 2026 10:51:24 -0700
Subject: [PATCH v5 1/6] drm/tyr: Use register! macro for GPU_CONTROL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-tyr-use-register-macro-v5-v5-1-8abfff8a0204@collabora.com>
References: <20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com>
In-Reply-To: <20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=46073;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=8nxm45DGtOdsKZvWrW4lfKV9p/9ZUVsHRu1F299yO1A=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJnXnzv0nF2bJlrjzxXt9zA9Nab2/xuOxfWsO5MnHzgkb
 WidysrbUcrCIMbFICumyHLW3qhHvOq9ke78/80wc1iZQIYwcHEKwEQevmJkeJ6Rd6tz5cqjz2+6
 Ou5ccUI/efXB/iPWS6ecqH5T16uuvorhf7LO9ku71FLZ9HTzai2MVvTlTmSYJ/Dh8m9l0Wnyjxd
 HMwEA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

From: Daniel Almeida <daniel.almeida@collabora.com>

Define the GPU_CONTROL register block with the kernel's register! macro
and switch the current GPU control paths over to the new typed register
definitions.

This replaces manual register constants, bit masks, shifts, and the
hand-written GpuId parsing code with typed register and field accessors.
It also adds helpers for combining split 64-bit registers and uses the new
definitions in reset, L2 power-on, and GPU info readout/logging paths.

This reduces open-coded bit manipulation making the code easier to read
and maintain.

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs |  19 +-
 drivers/gpu/drm/tyr/gpu.rs    | 173 +++-----
 drivers/gpu/drm/tyr/regs.rs   | 909 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 930 insertions(+), 171 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 611434641580..725ef209ae5f 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -13,7 +13,10 @@
     devres::Devres,
     drm,
     drm::ioctl,
-    io::poll,
+    io::{
+        poll,
+        Io, //
+    },
     new_mutex,
     of,
     platform,
@@ -34,7 +37,7 @@
     gem::TyrObject,
     gpu,
     gpu::GpuInfo,
-    regs, //
+    regs::gpu_control::*, //
 };
 
 pub(crate) type IoMem = kernel::io::mem::IoMem<SZ_2M>;
@@ -78,11 +81,15 @@ unsafe impl Send for TyrDrmDeviceData {}
 unsafe impl Sync for TyrDrmDeviceData {}
 
 fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
+    let io = (*iomem).access(dev)?;
+    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
 
     poll::read_poll_timeout(
-        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
-        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED != 0,
+        || {
+            let io = (*iomem).access(dev)?;
+            Ok(io.read(GPU_IRQ_RAWSTAT))
+        },
+        |status| status.reset_completed(),
         time::Delta::from_millis(1),
         time::Delta::from_millis(100),
     )
@@ -127,7 +134,7 @@ fn probe(
         gpu::l2_power_on(pdev.as_ref(), &iomem)?;
 
         let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
-        gpu_info.log(pdev);
+        gpu_info.log(pdev.as_ref());
 
         let platform: ARef<platform::Device> = pdev.into();
 
diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index a88775160f98..1e1e4103c575 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -5,14 +5,16 @@
     DerefMut, //
 };
 use kernel::{
-    bits::genmask_u32,
     device::{
         Bound,
         Device, //
     },
     devres::Devres,
-    io::poll,
-    platform,
+    io::{
+        poll,
+        register::Array,
+        Io, //
+    },
     prelude::*,
     time::Delta,
     transmute::AsBytes,
@@ -21,7 +23,10 @@
 
 use crate::{
     driver::IoMem,
-    regs, //
+    regs::{
+        gpu_control::*,
+        join_u64, //
+    }, //
 };
 
 /// Struct containing information that can be queried by userspace. This is read from
@@ -29,120 +34,95 @@
 ///
 /// # Invariants
 ///
-/// - The layout of this struct identical to the C `struct drm_panthor_gpu_info`.
+/// - The layout of this struct is identical to the C `struct drm_panthor_gpu_info`.
 #[repr(transparent)]
 #[derive(Clone, Copy)]
 pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
 
 impl GpuInfo {
     pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
-        let gpu_id = regs::GPU_ID.read(dev, iomem)?;
-        let csf_id = regs::GPU_CSF_ID.read(dev, iomem)?;
-        let gpu_rev = regs::GPU_REVID.read(dev, iomem)?;
-        let core_features = regs::GPU_CORE_FEATURES.read(dev, iomem)?;
-        let l2_features = regs::GPU_L2_FEATURES.read(dev, iomem)?;
-        let tiler_features = regs::GPU_TILER_FEATURES.read(dev, iomem)?;
-        let mem_features = regs::GPU_MEM_FEATURES.read(dev, iomem)?;
-        let mmu_features = regs::GPU_MMU_FEATURES.read(dev, iomem)?;
-        let thread_features = regs::GPU_THREAD_FEATURES.read(dev, iomem)?;
-        let max_threads = regs::GPU_THREAD_MAX_THREADS.read(dev, iomem)?;
-        let thread_max_workgroup_size = regs::GPU_THREAD_MAX_WORKGROUP_SIZE.read(dev, iomem)?;
-        let thread_max_barrier_size = regs::GPU_THREAD_MAX_BARRIER_SIZE.read(dev, iomem)?;
-        let coherency_features = regs::GPU_COHERENCY_FEATURES.read(dev, iomem)?;
-
-        let texture_features = regs::GPU_TEXTURE_FEATURES0.read(dev, iomem)?;
-
-        let as_present = regs::GPU_AS_PRESENT.read(dev, iomem)?;
-
-        let shader_present = u64::from(regs::GPU_SHADER_PRESENT_LO.read(dev, iomem)?);
-        let shader_present =
-            shader_present | u64::from(regs::GPU_SHADER_PRESENT_HI.read(dev, iomem)?) << 32;
-
-        let tiler_present = u64::from(regs::GPU_TILER_PRESENT_LO.read(dev, iomem)?);
-        let tiler_present =
-            tiler_present | u64::from(regs::GPU_TILER_PRESENT_HI.read(dev, iomem)?) << 32;
-
-        let l2_present = u64::from(regs::GPU_L2_PRESENT_LO.read(dev, iomem)?);
-        let l2_present = l2_present | u64::from(regs::GPU_L2_PRESENT_HI.read(dev, iomem)?) << 32;
+        let io = (*iomem).access(dev)?;
 
         Ok(Self(uapi::drm_panthor_gpu_info {
-            gpu_id,
-            gpu_rev,
-            csf_id,
-            l2_features,
-            tiler_features,
-            mem_features,
-            mmu_features,
-            thread_features,
-            max_threads,
-            thread_max_workgroup_size,
-            thread_max_barrier_size,
-            coherency_features,
-            // TODO: Add texture_features_{1,2,3}.
-            texture_features: [texture_features, 0, 0, 0],
-            as_present,
+            gpu_id: io.read(GPU_ID).into_raw(),
+            gpu_rev: io.read(REVIDR).into_raw(),
+            csf_id: io.read(CSF_ID).into_raw(),
+            l2_features: io.read(L2_FEATURES).into_raw(),
+            tiler_features: io.read(TILER_FEATURES).into_raw(),
+            mem_features: io.read(MEM_FEATURES).into_raw(),
+            mmu_features: io.read(MMU_FEATURES).into_raw(),
+            thread_features: io.read(THREAD_FEATURES).into_raw(),
+            max_threads: io.read(THREAD_MAX_THREADS).into_raw(),
+            thread_max_workgroup_size: io.read(THREAD_MAX_WORKGROUP_SIZE).into_raw(),
+            thread_max_barrier_size: io.read(THREAD_MAX_BARRIER_SIZE).into_raw(),
+            coherency_features: io.read(COHERENCY_FEATURES).into_raw(),
+            texture_features: [
+                io.read(TEXTURE_FEATURES::at(0)).supported_formats().get(),
+                io.read(TEXTURE_FEATURES::at(1)).supported_formats().get(),
+                io.read(TEXTURE_FEATURES::at(2)).supported_formats().get(),
+                io.read(TEXTURE_FEATURES::at(3)).supported_formats().get(),
+            ],
+            as_present: io.read(AS_PRESENT).into_raw(),
             selected_coherency: uapi::drm_panthor_gpu_coherency_DRM_PANTHOR_GPU_COHERENCY_NONE,
-            shader_present,
-            l2_present,
-            tiler_present,
-            core_features,
+            shader_present: join_u64(
+                io.read(SHADER_PRESENT_LO).into_raw(),
+                io.read(SHADER_PRESENT_HI).into_raw(),
+            ),
+            l2_present: join_u64(
+                io.read(L2_PRESENT_LO).into_raw(),
+                io.read(L2_PRESENT_HI).into_raw(),
+            ),
+            tiler_present: join_u64(
+                io.read(TILER_PRESENT_LO).into_raw(),
+                io.read(TILER_PRESENT_HI).into_raw(),
+            ),
+            core_features: io.read(CORE_FEATURES).into_raw(),
+            // Padding must be zero.
             pad: 0,
+            //GPU_FEATURES register is not available; it was introduced in arch 11.x.
             gpu_features: 0,
         }))
     }
 
-    pub(crate) fn log(&self, pdev: &platform::Device) {
-        let gpu_id = GpuId::from(self.gpu_id);
+    pub(crate) fn log(&self, dev: &Device<Bound>) {
+        let gpu_id = GPU_ID::from_raw(self.gpu_id);
 
-        let model_name = if let Some(model) = GPU_MODELS
-            .iter()
-            .find(|&f| f.arch_major == gpu_id.arch_major && f.prod_major == gpu_id.prod_major)
-        {
+        let model_name = if let Some(model) = GPU_MODELS.iter().find(|&f| {
+            f.arch_major == gpu_id.arch_major().get() && f.prod_major == gpu_id.prod_major().get()
+        }) {
             model.name
         } else {
             "unknown"
         };
 
         dev_info!(
-            pdev,
+            dev,
             "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
             model_name,
-            self.gpu_id >> 16,
-            gpu_id.ver_major,
-            gpu_id.ver_minor,
-            gpu_id.ver_status
+            gpu_id.into_raw() >> 16,
+            gpu_id.ver_major().get(),
+            gpu_id.ver_minor().get(),
+            gpu_id.ver_status().get()
         );
 
         dev_info!(
-            pdev,
+            dev,
             "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}",
             self.l2_features,
             self.tiler_features,
             self.mem_features,
             self.mmu_features,
-            self.as_present
+            self.as_present,
         );
 
         dev_info!(
-            pdev,
+            dev,
             "shader_present=0x{:016x} l2_present=0x{:016x} tiler_present=0x{:016x}",
             self.shader_present,
             self.l2_present,
-            self.tiler_present
+            self.tiler_present,
         );
     }
-
-    /// Returns the number of virtual address bits supported by the GPU.
-    #[expect(dead_code)]
-    pub(crate) fn va_bits(&self) -> u32 {
-        self.mmu_features & genmask_u32(0..=7)
-    }
-
-    /// Returns the number of physical address bits supported by the GPU.
-    #[expect(dead_code)]
-    pub(crate) fn pa_bits(&self) -> u32 {
-        (self.mmu_features >> 8) & genmask_u32(0..=7)
-    }
 }
 
 impl Deref for GpuInfo {
@@ -182,38 +162,17 @@ struct GpuModels {
     prod_major: 7,
 }];
 
-#[allow(dead_code)]
-pub(crate) struct GpuId {
-    pub(crate) arch_major: u32,
-    pub(crate) arch_minor: u32,
-    pub(crate) arch_rev: u32,
-    pub(crate) prod_major: u32,
-    pub(crate) ver_major: u32,
-    pub(crate) ver_minor: u32,
-    pub(crate) ver_status: u32,
-}
-
-impl From<u32> for GpuId {
-    fn from(value: u32) -> Self {
-        GpuId {
-            arch_major: (value & genmask_u32(28..=31)) >> 28,
-            arch_minor: (value & genmask_u32(24..=27)) >> 24,
-            arch_rev: (value & genmask_u32(20..=23)) >> 20,
-            prod_major: (value & genmask_u32(16..=19)) >> 16,
-            ver_major: (value & genmask_u32(12..=15)) >> 12,
-            ver_minor: (value & genmask_u32(4..=11)) >> 4,
-            ver_status: value & genmask_u32(0..=3),
-        }
-    }
-}
-
 /// Powers on the l2 block.
 pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    regs::L2_PWRON_LO.write(dev, iomem, 1)?;
+    let io = (*iomem).access(dev)?;
+    io.write_reg(L2_PWRON_LO::zeroed().with_const_request::<1>());
 
     poll::read_poll_timeout(
-        || regs::L2_READY_LO.read(dev, iomem),
-        |status| *status == 1,
+        || {
+            let io = (*iomem).access(dev)?;
+            Ok(io.read(L2_READY_LO))
+        },
+        |status| status.ready() == 1,
         Delta::from_millis(1),
         Delta::from_millis(100),
     )
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 611870c2e6af..f7eea9bd81f1 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1,5 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
+//! # Definitions
+//!
+//! - **CEU**: Command Execution Unit - A hardware component that executes commands (instructions)
+//!   from the command stream.
+//! - **CS**: Command Stream - A sequence of instructions (commands) used to control a particular
+//!   job or sequence of jobs. The instructions exist in one or more command buffers.
+//! - **CSF**: Command Stream Frontend - The interface and implementation for job submission
+//!   exposed to the host CPU driver. This includes the global interface, as well as CSG and CS
+//!   interfaces.
+//! - **CSG**: Command Stream Group - A group of related command streams. The CSF manages multiple
+//!   CSGs, and each CSG contains multiple CSs.
+//! - **CSHW**: Command Stream Hardware - The hardware interpreting command streams, including the
+//!   iterator control aspects. Implements the CSF in conjunction with the MCU.
+//! - **GLB**: Global - Prefix for global interface registers that control operations common to
+//!   all CSs.
+//! - **JASID**: Job Address Space ID - Identifies the address space for a job.
+//! - **MCU**: Microcontroller Unit - Implements the CSF in conjunction with the command stream
+//!   hardware.
+//! - **MMU**: Memory Management Unit - Handles address translation and memory access protection.
+
 // We don't expect that all the registers and fields will be used, even in the
 // future.
 //
@@ -41,64 +61,837 @@ pub(crate) fn write(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>, value: u3
     }
 }
 
-pub(crate) const GPU_ID: Register<0x0> = Register;
-pub(crate) const GPU_L2_FEATURES: Register<0x4> = Register;
-pub(crate) const GPU_CORE_FEATURES: Register<0x8> = Register;
-pub(crate) const GPU_CSF_ID: Register<0x1c> = Register;
-pub(crate) const GPU_REVID: Register<0x280> = Register;
-pub(crate) const GPU_TILER_FEATURES: Register<0xc> = Register;
-pub(crate) const GPU_MEM_FEATURES: Register<0x10> = Register;
-pub(crate) const GPU_MMU_FEATURES: Register<0x14> = Register;
-pub(crate) const GPU_AS_PRESENT: Register<0x18> = Register;
-pub(crate) const GPU_IRQ_RAWSTAT: Register<0x20> = Register;
-
-pub(crate) const GPU_IRQ_RAWSTAT_FAULT: u32 = bit_u32(0);
-pub(crate) const GPU_IRQ_RAWSTAT_PROTECTED_FAULT: u32 = bit_u32(1);
-pub(crate) const GPU_IRQ_RAWSTAT_RESET_COMPLETED: u32 = bit_u32(8);
-pub(crate) const GPU_IRQ_RAWSTAT_POWER_CHANGED_SINGLE: u32 = bit_u32(9);
-pub(crate) const GPU_IRQ_RAWSTAT_POWER_CHANGED_ALL: u32 = bit_u32(10);
-pub(crate) const GPU_IRQ_RAWSTAT_CLEAN_CACHES_COMPLETED: u32 = bit_u32(17);
-pub(crate) const GPU_IRQ_RAWSTAT_DOORBELL_STATUS: u32 = bit_u32(18);
-pub(crate) const GPU_IRQ_RAWSTAT_MCU_STATUS: u32 = bit_u32(19);
-
-pub(crate) const GPU_IRQ_CLEAR: Register<0x24> = Register;
-pub(crate) const GPU_IRQ_MASK: Register<0x28> = Register;
-pub(crate) const GPU_IRQ_STAT: Register<0x2c> = Register;
-pub(crate) const GPU_CMD: Register<0x30> = Register;
-pub(crate) const GPU_CMD_SOFT_RESET: u32 = 1 | (1 << 8);
-pub(crate) const GPU_CMD_HARD_RESET: u32 = 1 | (2 << 8);
-pub(crate) const GPU_THREAD_FEATURES: Register<0xac> = Register;
-pub(crate) const GPU_THREAD_MAX_THREADS: Register<0xa0> = Register;
-pub(crate) const GPU_THREAD_MAX_WORKGROUP_SIZE: Register<0xa4> = Register;
-pub(crate) const GPU_THREAD_MAX_BARRIER_SIZE: Register<0xa8> = Register;
-pub(crate) const GPU_TEXTURE_FEATURES0: Register<0xb0> = Register;
-pub(crate) const GPU_SHADER_PRESENT_LO: Register<0x100> = Register;
-pub(crate) const GPU_SHADER_PRESENT_HI: Register<0x104> = Register;
-pub(crate) const GPU_TILER_PRESENT_LO: Register<0x110> = Register;
-pub(crate) const GPU_TILER_PRESENT_HI: Register<0x114> = Register;
-pub(crate) const GPU_L2_PRESENT_LO: Register<0x120> = Register;
-pub(crate) const GPU_L2_PRESENT_HI: Register<0x124> = Register;
-pub(crate) const L2_READY_LO: Register<0x160> = Register;
-pub(crate) const L2_READY_HI: Register<0x164> = Register;
-pub(crate) const L2_PWRON_LO: Register<0x1a0> = Register;
-pub(crate) const L2_PWRON_HI: Register<0x1a4> = Register;
-pub(crate) const L2_PWRTRANS_LO: Register<0x220> = Register;
-pub(crate) const L2_PWRTRANS_HI: Register<0x204> = Register;
-pub(crate) const L2_PWRACTIVE_LO: Register<0x260> = Register;
-pub(crate) const L2_PWRACTIVE_HI: Register<0x264> = Register;
-
-pub(crate) const MCU_CONTROL: Register<0x700> = Register;
-pub(crate) const MCU_CONTROL_ENABLE: u32 = 1;
-pub(crate) const MCU_CONTROL_AUTO: u32 = 2;
-pub(crate) const MCU_CONTROL_DISABLE: u32 = 0;
-
-pub(crate) const MCU_STATUS: Register<0x704> = Register;
-pub(crate) const MCU_STATUS_DISABLED: u32 = 0;
-pub(crate) const MCU_STATUS_ENABLED: u32 = 1;
-pub(crate) const MCU_STATUS_HALT: u32 = 2;
-pub(crate) const MCU_STATUS_FATAL: u32 = 3;
-
-pub(crate) const GPU_COHERENCY_FEATURES: Register<0x300> = Register;
+/// Combine two 32-bit values into a single 64-bit value.
+pub(crate) fn join_u64(lo: u32, hi: u32) -> u64 {
+    (u64::from(lo)) | ((u64::from(hi)) << 32)
+}
+
+/// Read a logical 64-bit value from split 32-bit registers without tearing.
+pub(crate) fn read_u64_no_tearing(lo_read: impl Fn() -> u32, hi_read: impl Fn() -> u32) -> u64 {
+    loop {
+        let hi1 = hi_read();
+        let lo = lo_read();
+        let hi2 = hi_read();
+
+        if hi1 == hi2 {
+            return join_u64(lo, hi1);
+        }
+    }
+}
+
+/// These registers correspond to the GPU_CONTROL register page.
+/// They are involved in GPU configuration and control.
+pub(crate) mod gpu_control {
+    use core::convert::TryFrom;
+    use kernel::{
+        error::{
+            code::EINVAL,
+            Error, //
+        },
+        num::Bounded,
+        register,
+        uapi, //
+    };
+    use pin_init::Zeroable;
+
+    register! {
+        /// GPU identification register.
+        pub(crate) GPU_ID(u32) @ 0x0 {
+            /// Status of the GPU release.
+            3:0     ver_status;
+            /// Minor release version number.
+            11:4    ver_minor;
+            /// Major release version number.
+            15:12   ver_major;
+            /// Product identifier.
+            19:16   prod_major;
+            /// Architecture patch revision.
+            23:20   arch_rev;
+            /// Architecture minor revision.
+            27:24   arch_minor;
+            /// Architecture major revision.
+            31:28   arch_major;
+        }
+
+        /// Level 2 cache features register.
+        pub(crate) L2_FEATURES(u32) @ 0x4 {
+            /// Cache line size.
+            7:0     line_size;
+            /// Cache associativity.
+            15:8    associativity;
+            /// Cache slice size.
+            23:16   cache_size;
+            /// External bus width.
+            31:24   bus_width;
+        }
+
+        /// Shader core features.
+        pub(crate) CORE_FEATURES(u32) @ 0x8 {
+            /// Shader core variant.
+            7:0     core_variant;
+        }
+
+        /// Tiler features.
+        pub(crate) TILER_FEATURES(u32) @ 0xc {
+            /// Log of the tiler's bin size.
+            5:0     bin_size;
+            /// Maximum number of active levels.
+            11:8    max_levels;
+        }
+
+        /// Memory system features.
+        pub(crate) MEM_FEATURES(u32) @ 0x10 {
+            0:0     coherent_core_group => bool;
+            1:1     coherent_super_group => bool;
+            11:8    l2_slices;
+        }
+
+        /// Memory management unit features.
+        pub(crate) MMU_FEATURES(u32) @ 0x14 {
+            /// Number of bits supported in virtual addresses.
+            7:0     va_bits;
+            /// Number of bits supported in physical addresses.
+            15:8    pa_bits;
+        }
+
+        /// Address spaces present.
+        pub(crate) AS_PRESENT(u32) @ 0x18 {
+            31:0    present;
+        }
+
+        /// CSF version information.
+        pub(crate) CSF_ID(u32) @ 0x1c {
+            /// MCU revision ID.
+            3:0     mcu_rev;
+            /// MCU minor revision number.
+            9:4     mcu_minor;
+            /// MCU major revision number.
+            15:10   mcu_major;
+            /// CSHW revision ID.
+            19:16   cshw_rev;
+            /// CSHW minor revision number.
+            25:20   cshw_minor;
+            /// CSHW major revision number.
+            31:26   cshw_major;
+        }
+
+        /// IRQ sources raw status.
+        /// Writing to this register forces bits on, but does not clear them.
+        pub(crate) GPU_IRQ_RAWSTAT(u32) @ 0x20 {
+            /// A GPU fault has occurred, a 1-bit boolean flag.
+            0:0     gpu_fault => bool;
+            /// A GPU fault has occurred, a 1-bit boolean flag.
+            1:1     gpu_protected_fault => bool;
+            /// Reset has completed, a 1-bit boolean flag.
+            8:8     reset_completed => bool;
+            /// Set when a single power domain has powered up or down, a 1-bit boolean flag.
+            9:9     power_changed_single => bool;
+            /// Set when the all pending power domain changes are completed, a 1-bit boolean flag.
+            10:10   power_changed_all => bool;
+            /// Set when cache cleaning has completed, a 1-bit boolean flag.
+            17:17   clean_caches_completed => bool;
+            /// Mirrors the doorbell interrupt line to the CPU, a 1-bit boolean flag.
+            18:18   doorbell_mirror => bool;
+            /// MCU requires attention, a 1-bit boolean flag.
+            19:19   mcu_status => bool;
+        }
+
+        /// IRQ sources to clear. Write only.
+        pub(crate) GPU_IRQ_CLEAR(u32) @ 0x24 {
+            /// Clear the GPU_FAULT interrupt, a 1-bit boolean flag.
+            0:0     gpu_fault => bool;
+            /// Clear the GPU_PROTECTED_FAULT interrupt, a 1-bit boolean flag.
+            1:1     gpu_protected_fault => bool;
+            /// Clear the RESET_COMPLETED interrupt, a 1-bit boolean flag.
+            8:8     reset_completed => bool;
+            /// Clear the POWER_CHANGED_SINGLE interrupt, a 1-bit boolean flag.
+            9:9     power_changed_single => bool;
+            /// Clear the POWER_CHANGED_ALL interrupt, a 1-bit boolean flag.
+            10:10   power_changed_all => bool;
+            /// Clear the CLEAN_CACHES_COMPLETED interrupt, a 1-bit boolean flag.
+            17:17   clean_caches_completed => bool;
+            /// Clear the MCU_STATUS interrupt, a 1-bit boolean flag.
+            19:19   mcu_status => bool;
+        }
+
+        /// IRQ sources enabled.
+        pub(crate) GPU_IRQ_MASK(u32) @ 0x28 {
+            /// Enable the GPU_FAULT interrupt, a 1-bit boolean flag.
+            0:0     gpu_fault => bool;
+            /// Enable the GPU_PROTECTED_FAULT interrupt, a 1-bit boolean flag.
+            1:1     gpu_protected_fault => bool;
+            /// Enable the RESET_COMPLETED interrupt, a 1-bit boolean flag.
+            8:8     reset_completed => bool;
+            /// Enable the POWER_CHANGED_SINGLE interrupt, a 1-bit boolean flag.
+            9:9     power_changed_single => bool;
+            /// Enable the POWER_CHANGED_ALL interrupt, a 1-bit boolean flag.
+            10:10   power_changed_all => bool;
+            /// Enable the CLEAN_CACHES_COMPLETED interrupt, a 1-bit boolean flag.
+            17:17   clean_caches_completed => bool;
+            /// Enable the DOORBELL_MIRROR interrupt, a 1-bit boolean flag.
+            18:18   doorbell_mirror => bool;
+            /// Enable the MCU_STATUS interrupt, a 1-bit boolean flag.
+            19:19   mcu_status => bool;
+        }
+
+        /// IRQ status for enabled sources. Read only.
+        pub(crate) GPU_IRQ_STATUS(u32) @ 0x2c {
+            /// GPU_FAULT interrupt status, a 1-bit boolean flag.
+            0:0     gpu_fault => bool;
+            /// GPU_PROTECTED_FAULT interrupt status, a 1-bit boolean flag.
+            1:1     gpu_protected_fault => bool;
+            /// RESET_COMPLETED interrupt status, a 1-bit boolean flag.
+            8:8     reset_completed => bool;
+            /// POWER_CHANGED_SINGLE interrupt status, a 1-bit boolean flag.
+            9:9     power_changed_single => bool;
+            /// POWER_CHANGED_ALL interrupt status, a 1-bit boolean flag.
+            10:10   power_changed_all => bool;
+            /// CLEAN_CACHES_COMPLETED interrupt status, a 1-bit boolean flag.
+            17:17   clean_caches_completed => bool;
+            /// DOORBELL_MIRROR interrupt status, a 1-bit boolean flag.
+            18:18   doorbell_mirror => bool;
+            /// MCU_STATUS interrupt status, a 1-bit boolean flag.
+            19:19   mcu_status => bool;
+        }
+    }
+
+    /// Helpers for GPU_COMMAND Register
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum GpuCommand {
+        /// No operation. This is the default value.
+        Nop = 0,
+        /// Reset the GPU.
+        Reset = 1,
+        /// Flush caches.
+        FlushCaches = 4,
+        /// Clear GPU faults.
+        ClearFault = 7,
+    }
+
+    impl TryFrom<Bounded<u32, 8>> for GpuCommand {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(GpuCommand::Nop),
+                1 => Ok(GpuCommand::Reset),
+                4 => Ok(GpuCommand::FlushCaches),
+                7 => Ok(GpuCommand::ClearFault),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<GpuCommand> for Bounded<u32, 8> {
+        fn from(cmd: GpuCommand) -> Self {
+            (cmd as u8).into()
+        }
+    }
+
+    /// Reset mode for [`GPU_COMMAND::reset()`].
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum ResetMode {
+        /// Stop all external bus interfaces, then reset the entire GPU.
+        SoftReset = 1,
+        /// Force a full GPU reset.
+        HardReset = 2,
+    }
+
+    impl TryFrom<Bounded<u32, 4>> for ResetMode {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 4>) -> Result<Self, Self::Error> {
+            match val.get() {
+                1 => Ok(ResetMode::SoftReset),
+                2 => Ok(ResetMode::HardReset),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<ResetMode> for Bounded<u32, 4> {
+        fn from(mode: ResetMode) -> Self {
+            Bounded::try_new(mode as u32).unwrap()
+        }
+    }
+
+    /// Cache flush mode for [`GPU_COMMAND::flush_caches()`].
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum FlushMode {
+        /// No flush.
+        None = 0,
+        /// Clean the caches.
+        Clean = 1,
+        /// Invalidate the caches.
+        Invalidate = 2,
+        /// Clean and invalidate the caches.
+        CleanInvalidate = 3,
+    }
+
+    impl TryFrom<Bounded<u32, 4>> for FlushMode {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 4>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(FlushMode::None),
+                1 => Ok(FlushMode::Clean),
+                2 => Ok(FlushMode::Invalidate),
+                3 => Ok(FlushMode::CleanInvalidate),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<FlushMode> for Bounded<u32, 4> {
+        fn from(mode: FlushMode) -> Self {
+            Bounded::try_new(mode as u32).unwrap()
+        }
+    }
+
+    register! {
+        /// GPU command register.
+        ///
+        /// Use the constructor methods to create commands:
+        /// - [`GPU_COMMAND::nop()`]
+        /// - [`GPU_COMMAND::reset()`]
+        /// - [`GPU_COMMAND::flush_caches()`]
+        /// - [`GPU_COMMAND::clear_fault()`]
+        pub(crate) GPU_COMMAND (u32) @ 0x30 {
+            7:0     command ?=> GpuCommand;
+        }
+        /// Internal alias for GPU_COMMAND in reset mode.
+        /// Use [`GPU_COMMAND::reset()`] instead.
+        GPU_COMMAND_RESET (u32) => GPU_COMMAND {
+            7:0     command ?=> GpuCommand;
+            11:8    reset_mode ?=> ResetMode;
+        }
+
+        /// Internal alias for GPU_COMMAND in cache flush mode.
+        /// Use [`GPU_COMMAND::flush_caches()`] instead.
+        GPU_COMMAND_FLUSH (u32) => GPU_COMMAND {
+            7:0     command ?=> GpuCommand;
+            /// L2 cache flush mode.
+            11:8    l2_flush ?=> FlushMode;
+            /// Shader core load/store cache flush mode.
+            15:12   lsc_flush ?=> FlushMode;
+            /// Shader core other caches flush mode.
+            19:16   other_flush ?=> FlushMode;
+        }
+    }
+
+    impl GPU_COMMAND {
+        /// Create a NOP command.
+        pub(crate) fn nop() -> Self {
+            Self::zeroed()
+        }
+
+        /// Create a reset command with the specified reset mode.
+        pub(crate) fn reset(mode: ResetMode) -> Self {
+            Self::from_raw(
+                GPU_COMMAND_RESET::zeroed()
+                    .with_command(GpuCommand::Reset)
+                    .with_reset_mode(mode)
+                    .into_raw(),
+            )
+        }
+
+        /// Create a cache flush command with the specified flush modes.
+        pub(crate) fn flush_caches(l2: FlushMode, lsc: FlushMode, other: FlushMode) -> Self {
+            Self::from_raw(
+                GPU_COMMAND_FLUSH::zeroed()
+                    .with_command(GpuCommand::FlushCaches)
+                    .with_l2_flush(l2)
+                    .with_lsc_flush(lsc)
+                    .with_other_flush(other)
+                    .into_raw(),
+            )
+        }
+
+        /// Create a clear fault command.
+        pub(crate) fn clear_fault() -> Self {
+            Self::zeroed().with_command(GpuCommand::ClearFault)
+        }
+    }
+
+    register! {
+        /// GPU status register. Read only.
+        pub(crate) GPU_STATUS(u32) @ 0x34 {
+            /// GPU active, a 1-bit boolean flag.
+            0:0     gpu_active => bool;
+            /// Power manager active, a 1-bit boolean flag
+            1:1     pwr_active => bool;
+            /// Page fault active, a 1-bit boolean flag.
+            4:4     page_fault => bool;
+            /// Protected mode active, a 1-bit boolean flag.
+            7:7     protected_mode_active => bool;
+            /// Debug mode active, a 1-bit boolean flag.
+            8:8     gpu_dbg_enabled => bool;
+        }
+    }
+
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum ExceptionType {
+        /// Exception type: No error.
+        Ok = 0x00,
+        /// Exception type: GPU external bus error.
+        GpuBusFault = 0x80,
+        /// Exception type: GPU shareability error.
+        GpuShareabilityFault = 0x88,
+        /// Exception type: System shareability error.
+        SystemShareabilityFault = 0x89,
+        /// Exception type: GPU cacheability error.
+        GpuCacheabilityFault = 0x8A,
+    }
+
+    impl TryFrom<Bounded<u32, 8>> for ExceptionType {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0x00 => Ok(ExceptionType::Ok),
+                0x80 => Ok(ExceptionType::GpuBusFault),
+                0x88 => Ok(ExceptionType::GpuShareabilityFault),
+                0x89 => Ok(ExceptionType::SystemShareabilityFault),
+                0x8A => Ok(ExceptionType::GpuCacheabilityFault),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<ExceptionType> for Bounded<u32, 8> {
+        fn from(exc: ExceptionType) -> Self {
+            (exc as u8).into()
+        }
+    }
+
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum AccessType {
+        /// Access type: An atomic (read/write) transaction.
+        Atomic = 0,
+        /// Access type: An execute transaction.
+        Execute = 1,
+        /// Access type: A read transaction.
+        Read = 2,
+        /// Access type: A write transaction.
+        Write = 3,
+    }
+
+    impl From<Bounded<u32, 2>> for AccessType {
+        fn from(val: Bounded<u32, 2>) -> Self {
+            match val.get() {
+                0 => AccessType::Atomic,
+                1 => AccessType::Execute,
+                2 => AccessType::Read,
+                3 => AccessType::Write,
+                _ => unreachable!(),
+            }
+        }
+    }
+
+    impl From<AccessType> for Bounded<u32, 2> {
+        fn from(access: AccessType) -> Self {
+            Bounded::try_new(access as u32).unwrap()
+        }
+    }
+
+    register! {
+        /// GPU fault status register. Read only.
+        pub(crate) GPU_FAULTSTATUS(u32) @ 0x3c {
+            /// Exception type.
+            7:0     exception_type ?=> ExceptionType;
+            /// Access type.
+            9:8     access_type => AccessType;
+            /// The GPU_FAULTADDRESS is valid, a 1-bit boolean flag.
+            10:10   address_valid => bool;
+            /// The JASID field is valid, a 1-bit boolean flag.
+            11:11   jasid_valid => bool;
+            /// JASID of the fault, if known.
+            15:12   jasid;
+            /// ID of the source that triggered the fault.
+            31:16   source_id;
+        }
+
+        /// GPU fault address. Read only.
+        /// Once a fault is reported, it must be manually cleared by issuing a
+        /// [`GPU_COMMAND::clear_fault()`] command to the [`GPU_COMMAND`] register. No further GPU
+        /// faults will be reported until the previous fault has been cleared.
+        pub(crate) GPU_FAULTADDRESS_LO(u32) @ 0x40 {
+            31:0    pointer;
+        }
+
+        pub(crate) GPU_FAULTADDRESS_HI(u32) @ 0x44 {
+            31:0    pointer;
+        }
+
+        /// Level 2 cache configuration.
+        pub(crate) L2_CONFIG(u32) @ 0x48 {
+            /// Requested cache size.
+            23:16   cache_size;
+            /// Requested hash function index.
+            31:24   hash_function;
+        }
+
+        /// Global time stamp offset.
+        pub(crate) TIMESTAMP_OFFSET_LO(u32) @ 0x88 {
+            31:0    offset;
+        }
+
+        pub(crate) TIMESTAMP_OFFSET_HI(u32) @ 0x8c {
+            31:0    offset;
+        }
+
+        /// GPU cycle counter. Read only.
+        pub(crate) CYCLE_COUNT_LO(u32) @ 0x90 {
+            31:0    count;
+        }
+
+        pub(crate) CYCLE_COUNT_HI(u32) @ 0x94 {
+            31:0    count;
+        }
+
+        /// Global time stamp. Read only.
+        pub(crate) TIMESTAMP_LO(u32) @ 0x98 {
+            31:0    timestamp;
+        }
+
+        pub(crate) TIMESTAMP_HI(u32) @ 0x9c {
+            31:0    timestamp;
+        }
+
+        /// Maximum number of threads per core. Read only constant.
+        pub(crate) THREAD_MAX_THREADS(u32) @ 0xa0 {
+            31:0    threads;
+        }
+
+        /// Maximum number of threads per workgroup. Read only constant.
+        pub(crate) THREAD_MAX_WORKGROUP_SIZE(u32) @ 0xa4 {
+            31:0    threads;
+        }
+
+        /// Maximum number of threads per barrier. Read only constant.
+        pub(crate) THREAD_MAX_BARRIER_SIZE(u32) @ 0xa8 {
+            31:0    threads;
+        }
+
+        /// Thread features. Read only constant.
+        pub(crate) THREAD_FEATURES(u32) @ 0xac {
+            /// Total number of registers per core.
+            21:0    max_registers;
+            /// Implementation technology type.
+            23:22   implementation_technology;
+            /// Maximum number of compute tasks waiting.
+            31:24   max_task_queue;
+        }
+
+        /// Support flags for compressed texture formats. Read only constant.
+        ///
+        /// A bitmap where each bit indicates support for a specific compressed texture format.
+        /// The bit position maps to an opaque format ID (`texture_features_key_t` in spec).
+        pub(crate) TEXTURE_FEATURES(u32)[4] @ 0xb0 {
+            31:0    supported_formats;
+        }
+
+        /// Shader core present bitmap. Read only constant.
+        pub(crate) SHADER_PRESENT_LO(u32) @ 0x100 {
+            31:0    value;
+        }
+
+        pub(crate) SHADER_PRESENT_HI(u32) @ 0x104 {
+            31:0    value;
+        }
+
+        /// Tiler present bitmap. Read only constant.
+        pub(crate) TILER_PRESENT_LO(u32) @ 0x110 {
+            31:0    present;
+        }
+
+        pub(crate) TILER_PRESENT_HI(u32) @ 0x114 {
+            31:0    present;
+        }
+
+        /// L2 cache present bitmap. Read only constant.
+        pub(crate) L2_PRESENT_LO(u32) @ 0x120 {
+            31:0    present;
+        }
+
+        pub(crate) L2_PRESENT_HI(u32) @ 0x124 {
+            31:0    present;
+        }
+
+        /// Shader core ready bitmap. Read only.
+        pub(crate) SHADER_READY_LO(u32) @ 0x140 {
+            31:0    ready;
+        }
+
+        pub(crate) SHADER_READY_HI(u32) @ 0x144 {
+            31:0    ready;
+        }
+
+        /// Tiler ready bitmap. Read only.
+        pub(crate) TILER_READY_LO(u32) @ 0x150 {
+            31:0    ready;
+        }
+
+        pub(crate) TILER_READY_HI(u32) @ 0x154 {
+            31:0    ready;
+        }
+
+        /// L2 ready bitmap. Read only.
+        pub(crate) L2_READY_LO(u32) @ 0x160 {
+            31:0    ready;
+        }
+
+        pub(crate) L2_READY_HI(u32) @ 0x164 {
+            31:0    ready;
+        }
+
+        /// Shader core power up bitmap.
+        pub(crate) SHADER_PWRON_LO(u32) @ 0x180 {
+            31:0    request;
+        }
+
+        pub(crate) SHADER_PWRON_HI(u32) @ 0x184 {
+            31:0    request;
+        }
+
+        /// Tiler power up bitmap.
+        pub(crate) TILER_PWRON_LO(u32) @ 0x190 {
+            31:0    request;
+        }
+
+        pub(crate) TILER_PWRON_HI(u32) @ 0x194 {
+            31:0    request;
+        }
+
+        /// L2 power up bitmap.
+        pub(crate) L2_PWRON_LO(u32) @ 0x1a0 {
+            31:0    request;
+        }
+
+        pub(crate) L2_PWRON_HI(u32) @ 0x1a4 {
+            31:0    request;
+        }
+
+        /// Shader core power down bitmap.
+        pub(crate) SHADER_PWROFF_LO(u32) @ 0x1c0 {
+            31:0    request;
+        }
+
+        pub(crate) SHADER_PWROFF_HI(u32) @ 0x1c4 {
+            31:0    request;
+        }
+
+        /// Tiler power down bitmap.
+        pub(crate) TILER_PWROFF_LO(u32) @ 0x1d0 {
+            31:0    request;
+        }
+
+        pub(crate) TILER_PWROFF_HI(u32) @ 0x1d4 {
+            31:0    request;
+        }
+
+        /// L2 power down bitmap.
+        pub(crate) L2_PWROFF_LO(u32) @ 0x1e0 {
+            31:0    request;
+        }
+
+        pub(crate) L2_PWROFF_HI(u32) @ 0x1e4 {
+            31:0    request;
+        }
+
+        /// Shader core power transition bitmap. Read-only.
+        pub(crate) SHADER_PWRTRANS_LO(u32) @ 0x200 {
+            31:0    changing;
+        }
+
+        pub(crate) SHADER_PWRTRANS_HI(u32) @ 0x204 {
+            31:0    changing;
+        }
+
+        /// Tiler power transition bitmap. Read-only.
+        pub(crate) TILER_PWRTRANS_LO(u32) @ 0x210 {
+            31:0    changing;
+        }
+
+        pub(crate) TILER_PWRTRANS_HI(u32) @ 0x214 {
+            31:0    changing;
+        }
+
+        /// L2 power transition bitmap. Read-only.
+        pub(crate) L2_PWRTRANS_LO(u32) @ 0x220 {
+            31:0    changing;
+        }
+
+        pub(crate) L2_PWRTRANS_HI(u32) @ 0x224 {
+            31:0    changing;
+        }
+
+        /// Shader core active bitmap. Read-only.
+        pub(crate) SHADER_PWRACTIVE_LO(u32) @ 0x240 {
+            31:0    active;
+        }
+
+        pub(crate) SHADER_PWRACTIVE_HI(u32) @ 0x244 {
+            31:0    active;
+        }
+
+        /// Tiler active bitmap. Read-only.
+        pub(crate) TILER_PWRACTIVE_LO(u32) @ 0x250 {
+            31:0    active;
+        }
+
+        pub(crate) TILER_PWRACTIVE_HI(u32) @ 0x254 {
+            31:0    active;
+        }
+
+        /// L2 active bitmap.  Read-only.
+        pub(crate) L2_PWRACTIVE_LO(u32) @ 0x260 {
+            31:0    active;
+        }
+
+        pub(crate) L2_PWRACTIVE_HI(u32) @ 0x264 {
+            31:0    active;
+        }
+
+        /// Revision ID. Read only constant.
+        pub(crate) REVIDR(u32) @ 0x280 {
+            31:0    revision;
+        }
+
+        /// Coherency features present. Read only constant.
+        /// Supported protocols on the interconnect between the GPU and the
+        /// system into which it is integrated.
+        pub(crate) COHERENCY_FEATURES(u32) @ 0x300 {
+            /// ACE-Lite protocol supported, a 1-bit boolean flag.
+            0:0     ace_lite => bool;
+            /// ACE protocol supported, a 1-bit boolean flag.
+            1:1     ace => bool;
+        }
+    }
+
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum CoherencyMode {
+        /// ACE-Lite coherency protocol.
+        AceLite = uapi::drm_panthor_gpu_coherency_DRM_PANTHOR_GPU_COHERENCY_ACE_LITE as u8,
+        /// ACE coherency protocol.
+        Ace = uapi::drm_panthor_gpu_coherency_DRM_PANTHOR_GPU_COHERENCY_ACE as u8,
+        /// No coherency protocol.
+        None = uapi::drm_panthor_gpu_coherency_DRM_PANTHOR_GPU_COHERENCY_NONE as u8,
+    }
+
+    impl TryFrom<Bounded<u32, 32>> for CoherencyMode {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 32>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(CoherencyMode::AceLite),
+                1 => Ok(CoherencyMode::Ace),
+                31 => Ok(CoherencyMode::None),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<CoherencyMode> for Bounded<u32, 32> {
+        fn from(mode: CoherencyMode) -> Self {
+            (mode as u8).into()
+        }
+    }
+
+    register! {
+        /// Coherency enable. An index of which coherency protocols should be used.
+        /// This register only selects the protocol for coherency messages on the
+        /// interconnect. This is not to enable or disable coherency controlled by MMU.
+        pub(crate) COHERENCY_ENABLE(u32) @ 0x304 {
+            31:0    l2_cache_protocol_select ?=> CoherencyMode;
+        }
+    }
+
+    /// Helpers for MCU_CONTROL register
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum McuControlMode {
+        /// Disable the MCU.
+        Disable = 0,
+        /// Enable the MCU.
+        Enable = 1,
+        /// Enable the MCU to execute and automatically reboot after a fast reset.
+        Auto = 2,
+    }
+
+    impl TryFrom<Bounded<u32, 2>> for McuControlMode {
+        type Error = Error;
+
+        fn try_from(val: Bounded<u32, 2>) -> Result<Self, Self::Error> {
+            match val.get() {
+                0 => Ok(McuControlMode::Disable),
+                1 => Ok(McuControlMode::Enable),
+                2 => Ok(McuControlMode::Auto),
+                _ => Err(EINVAL),
+            }
+        }
+    }
+
+    impl From<McuControlMode> for Bounded<u32, 2> {
+        fn from(mode: McuControlMode) -> Self {
+            Bounded::try_new(mode as u32).unwrap()
+        }
+    }
+
+    register! {
+        /// MCU control.
+        pub(crate) MCU_CONTROL(u32) @ 0x700 {
+            /// Request MCU state change.
+            1:0 req ?=> McuControlMode;
+        }
+    }
+
+    /// Helpers for MCU_STATUS register
+    #[derive(Copy, Clone, Debug, PartialEq)]
+    #[repr(u8)]
+    pub(crate) enum McuStatus {
+        /// MCU is disabled.
+        Disabled = 0,
+        /// MCU is enabled.
+        Enabled = 1,
+        /// The MCU has halted by itself in an orderly manner to enable the core group to be powered down.
+        Halt = 2,
+        /// The MCU has encountered an error that prevents it from continuing.
+        Fatal = 3,
+    }
+
+    impl From<Bounded<u32, 2>> for McuStatus {
+        fn from(val: Bounded<u32, 2>) -> Self {
+            match val.get() {
+                0 => McuStatus::Disabled,
+                1 => McuStatus::Enabled,
+                2 => McuStatus::Halt,
+                3 => McuStatus::Fatal,
+                _ => unreachable!(),
+            }
+        }
+    }
+
+    impl From<McuStatus> for Bounded<u32, 2> {
+        fn from(status: McuStatus) -> Self {
+            Bounded::try_new(status as u32).unwrap()
+        }
+    }
+
+    register! {
+        /// MCU status. Read only.
+        pub(crate) MCU_STATUS(u32) @ 0x704 {
+            /// Read current state of MCU.
+            1:0 value => McuStatus;
+        }
+    }
+}
 
 pub(crate) const JOB_IRQ_RAWSTAT: Register<0x1000> = Register;
 pub(crate) const JOB_IRQ_CLEAR: Register<0x1004> = Register;

-- 
2.53.0

