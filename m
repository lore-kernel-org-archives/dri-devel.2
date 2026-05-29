Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62101CD6E4F
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 00:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDE110F72D;
	Fri, 29 May 2026 00:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hdyv2N8U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C9410F72C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 00:01:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B4EE44680;
 Fri, 29 May 2026 00:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7301F000E9;
 Fri, 29 May 2026 00:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780012876;
 bh=gIsKCNxSlhm2bsTKKYGVQXi6NNjPsd9S+/8bVLK40xI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hdyv2N8Ud9EgHar0g5aaYw1w1Lur0OSpv9gX5bphofASYgq+0+UwUjp9E00tI+4c+
 ji9DyvhSKVWaR6QG2YFJ/j513URTJm5gc/38nh4U5tZVFaCwb+EJSSZOGJLNznGVBK
 py7FXGS62FYajzi0hGDBK34BnG2gWCP0DmlsGjYI3TUN66lRgBYS63KoBAwMAK0Sjq
 rJYjqYFHzU4phyQgkl/jlsLsIgdkuaA6n++OPvlgYRTcbgjWMmFTQrc3rAodpqNbw4
 CwkHym7YfjoXE5B3OFMIt09jaHnksq9SMnkHnnqSboN9cIna9rxNzy8v/inewL66mJ
 LQlrBLGy2EjFQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 boris.brezillon@collabora.com, deborah.brouwer@collabora.com,
 gary@garyguo.net
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 2/2] drm/tyr: use IoMem directly instead of Devres
Date: Fri, 29 May 2026 02:00:54 +0200
Message-ID: <20260529000106.2257996-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529000106.2257996-1-dakr@kernel.org>
References: <20260529000106.2257996-1-dakr@kernel.org>
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

Now that IoMem is lifetime-parameterized, use it directly in probe
rather than wrapping it in Devres and Arc. The I/O memory mapping is
only used during probe and not stored in driver data, so device-managed
revocation is unnecessary.

This removes the Devres access(dev) pattern from issue_soft_reset(),
GpuInfo::new(), and l2_power_on(), simplifying register access.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/tyr/driver.rs | 19 ++++++-------------
 drivers/gpu/drm/tyr/gpu.rs    | 17 +++++------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 6276e9743c32..227ea2adccea 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -6,11 +6,9 @@
         OptionalClk, //
     },
     device::{
-        Bound,
         Core,
         Device, //
     },
-    devres::Devres,
     dma::{
         Device as DmaDevice,
         DmaMask, //
@@ -30,7 +28,6 @@
     sizes::SZ_2M,
     sync::{
         aref::ARef,
-        Arc,
         Mutex, //
     },
     time, //
@@ -44,7 +41,7 @@
     regs::gpu_control::*, //
 };
 
-pub(crate) type IoMem = kernel::io::mem::IoMem<'static, SZ_2M>;
+pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;
 
 pub(crate) struct TyrDrmDriver;
 
@@ -74,15 +71,11 @@ pub(crate) struct TyrDrmDeviceData {
     pub(crate) gpu_info: GpuInfo,
 }
 
-fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    let io = (*iomem).access(dev)?;
-    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
+fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
+    iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
 
     poll::read_poll_timeout(
-        || {
-            let io = (*iomem).access(dev)?;
-            Ok(io.read(GPU_IRQ_RAWSTAT))
-        },
+        || Ok(iomem.read(GPU_IRQ_RAWSTAT)),
         |status| status.reset_completed(),
         time::Delta::from_millis(1),
         time::Delta::from_millis(100),
@@ -123,12 +116,12 @@ fn probe<'bound>(
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
-        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?.into_devres()?, GFP_KERNEL)?;
+        let iomem = request.iomap_sized::<SZ_2M>()?;
 
         issue_soft_reset(pdev.as_ref(), &iomem)?;
         gpu::l2_power_on(pdev.as_ref(), &iomem)?;
 
-        let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
+        let gpu_info = GpuInfo::new(&iomem);
         gpu_info.log(pdev.as_ref());
 
         let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index 652556026f50..592b8bb16eba 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -9,7 +9,6 @@
         Bound,
         Device, //
     },
-    devres::Devres,
     io::{
         poll,
         register::Array,
@@ -40,10 +39,8 @@
 pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
 
 impl GpuInfo {
-    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
-        let io = (*iomem).access(dev)?;
-
-        Ok(Self(uapi::drm_panthor_gpu_info {
+    pub(crate) fn new(io: &IoMem<'_>) -> Self {
+        Self(uapi::drm_panthor_gpu_info {
             gpu_id: io.read(GPU_ID).into_raw(),
             gpu_rev: io.read(REVIDR).into_raw(),
             csf_id: io.read(CSF_ID).into_raw(),
@@ -81,7 +78,7 @@ pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
             pad: 0,
             //GPU_FEATURES register is not available; it was introduced in arch 11.x.
             gpu_features: 0,
-        }))
+        })
     }
 
     pub(crate) fn log(&self, dev: &Device<Bound>) {
@@ -163,15 +160,11 @@ struct GpuModels {
 }];
 
 /// Powers on the l2 block.
-pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    let io = (*iomem).access(dev)?;
+pub(crate) fn l2_power_on(dev: &Device, io: &IoMem<'_>) -> Result {
     io.write_reg(L2_PWRON_LO::zeroed().with_const_request::<1>());
 
     poll::read_poll_timeout(
-        || {
-            let io = (*iomem).access(dev)?;
-            Ok(io.read(L2_READY_LO))
-        },
+        || Ok(io.read(L2_READY_LO)),
         |status| status.ready() == 1,
         Delta::from_millis(1),
         Delta::from_millis(100),
-- 
2.54.0

