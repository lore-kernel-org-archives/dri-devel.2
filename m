Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FC4CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 22:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B59510E140;
	Mon, 25 May 2026 22:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MV6CwB74";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498E410E140
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 22:59:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1F6F6008A;
 Mon, 25 May 2026 22:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2FB1F00A3C;
 Mon, 25 May 2026 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779749939;
 bh=uXCCkMR96gANcmvtt8tBwowRl4eHHJtqcRtzQOWjUXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MV6CwB74j9SIhjvDIcWbxJGAWX73RrFvkYCHxzdnsR5U2riY4vNhW/GBCXlHxSUjs
 zmUSIxkxrf0/XYeVttP6gbrd+rTotheqO7PZ6ONe6J6gPObhi9yXY/kTz018jovbGA
 gYzSkgRPZMsykZvE8Qbs1rYcjpDsqCSJyBAClh9DjQB9JqEoS4iOB/kJ4fADRwgKQJ
 HoYzLetXsaSpck3QtWuKmYnD9EIZq85cmCyvQXaLVxO5uUOvlae+xmEoFqNMlvCbJ9
 j9P5OclWvKtnGjQ+YYh8B3CvzByZXsej+fIEkB/wFHEE11kA4EFZUjueyhgi5vKXIc
 A13pzWa/9QY9g==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, ttabi@nvidia.com,
 joelagnelf@nvidia.com, gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 2/5] gpu: nova-core: unregister sysmem flush page from Drop
Date: Tue, 26 May 2026 00:58:30 +0200
Message-ID: <20260525225838.276108-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525225838.276108-1-dakr@kernel.org>
References: <20260525225838.276108-1-dakr@kernel.org>
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

Now that SysmemFlush can borrow the Bar via HRT lifetime, store a
&'bound Bar0 reference and implement Drop to automatically unregister
the sysmem flush page. This removes the need for manual unregister()
calls and the Gpu::unbind() method.

Reported-by: Eliot Courtney <ecourtney@nvidia.com>
Closes: https://lore.kernel.org/all/20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com/
Fixes: 6554ad65b589 ("gpu: nova-core: register sysmem flush page")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs |  4 ----
 drivers/gpu/nova-core/fb.rs     | 22 ++++++++++------------
 drivers/gpu/nova-core/gpu.rs    |  9 +--------
 3 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index d4cf4379ee87..cff5034c2dcd 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -113,8 +113,4 @@ fn probe<'bound>(
             }))
         })
     }
-
-    fn unbind<'bound>(_pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self::Data<'bound>>) {
-        this.gpu.unbind();
-    }
 }
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 6ee87050ce69..3b3271790cc9 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -43,21 +43,20 @@
 /// Because of this, the sysmem flush memory page must be registered as early as possible during
 /// driver initialization, and before any falcon is reset.
 ///
-/// Users are responsible for manually calling [`Self::unregister`] before dropping this object,
-/// otherwise the GPU might still use it even after it has been freed.
-pub(crate) struct SysmemFlush {
+pub(crate) struct SysmemFlush<'sys> {
     /// Chipset we are operating on.
     chipset: Chipset,
     device: ARef<device::Device>,
+    bar: &'sys Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
 }
 
-impl SysmemFlush {
+impl<'sys> SysmemFlush<'sys> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: &'sys Bar0,
         chipset: Chipset,
     ) -> Result<Self> {
         let page = CoherentHandle::alloc(dev, kernel::page::PAGE_SIZE, GFP_KERNEL)?;
@@ -67,19 +66,18 @@ pub(crate) fn register(
         Ok(Self {
             chipset,
             device: dev.into(),
+            bar,
             page,
         })
     }
+}
 
-    /// Unregister the managed sysmem flush page.
-    ///
-    /// In order to gracefully tear down the GPU, users must make sure to call this method before
-    /// dropping the object.
-    pub(crate) fn unregister(&self, bar: &Bar0) {
+impl Drop for SysmemFlush<'_> {
+    fn drop(&mut self) {
         let hal = hal::fb_hal(self.chipset);
 
-        if hal.read_sysmem_flush_page(bar) == self.page.dma_handle() {
-            let _ = hal.write_sysmem_flush_page(bar, 0).inspect_err(|e| {
+        if hal.read_sysmem_flush_page(self.bar) == self.page.dma_handle() {
+            let _ = hal.write_sysmem_flush_page(self.bar, 0).inspect_err(|e| {
                 dev_warn!(
                     &self.device,
                     "failed to unregister sysmem flush page: {:?}\n",
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 108dd094e354..cf134cab49cd 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -250,7 +250,7 @@ pub(crate) struct Gpu<'gpu> {
     bar: &'gpu Bar0,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
-    sysmem_flush: SysmemFlush,
+    sysmem_flush: SysmemFlush<'gpu>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
@@ -293,11 +293,4 @@ pub(crate) fn new(
             _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
         })
     }
-
-    /// Called when the corresponding [`Device`](device::Device) is unbound.
-    ///
-    /// Note: This method must only be called from `Driver::unbind`.
-    pub(crate) fn unbind(&self) {
-        self.sysmem_flush.unregister(self.bar);
-    }
 }
-- 
2.54.0

