Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5679FCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 21:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA66110EED3;
	Wed,  6 May 2026 21:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q19nEG2C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8F610EED3
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 21:53:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C6612403E3;
 Wed,  6 May 2026 21:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF14C2BCB2;
 Wed,  6 May 2026 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104436;
 bh=JemW6+hXTNe2roNUmuhyi6dJSHZ2hsaM41xXJeGWXFU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q19nEG2Cgkh58jimLzg/BPtuOxYrcF8uDCvMbepj/dLeF2Yc1z6Po0VIQkEVyPkWo
 7d1XtbLnjtlqYvK9jfsa7B1spr5VkcFuhckDh3aee+PNec23wrfXE7GDmh4fSyFbYF
 zFwfb21iBqVr1snKbrX6nLrZxUHyJ6kDdUYdqriWUz4p3l2NC4JqvKBD8ZMHWirMOq
 rzIMP3LOE18QfcE4MNtN1xvL9E8gt3wUKBnbVub7H2bLJqIS+sBUYV1Fg3UJNxARHM
 5aIuRnE3UoHFzR4dxHrqskYtTI5F5JN5qgfQljOyHYqy5wGptNJcjdmhfemtSqSGMv
 sW8vByLQupKlA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 23/25] gpu: nova-core: unregister sysmem flush page from
 Drop
Date: Wed,  6 May 2026 23:50:59 +0200
Message-ID: <20260506215113.851360-24-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
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
index 11b632ae3789..31d2a8dadb7b 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -111,8 +111,4 @@ fn probe(
             }))
         })
     }
-
-    fn unbind(_pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
-        this.gpu.unbind();
-    }
 }
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index bdd5eed760e1..a707fbfe3ced 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -46,21 +46,20 @@
 /// Because of this, the sysmem flush memory page must be registered as early as possible during
 /// driver initialization, and before any falcon is reset.
 ///
-/// Users are responsible for manually calling [`Self::unregister`] before dropping this object,
-/// otherwise the GPU might still use it even after it has been freed.
-pub(crate) struct SysmemFlush {
+pub(crate) struct SysmemFlush<'bound> {
     /// Chipset we are operating on.
     chipset: Chipset,
     device: ARef<device::Device>,
+    bar: &'bound Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
 }
 
-impl SysmemFlush {
+impl<'bound> SysmemFlush<'bound> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: &'bound Bar0,
         chipset: Chipset,
     ) -> Result<Self> {
         let page = CoherentHandle::alloc(dev, kernel::page::PAGE_SIZE, GFP_KERNEL)?;
@@ -70,19 +69,18 @@ pub(crate) fn register(
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
index 03295fa6fb32..c17d068b35eb 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -228,7 +228,7 @@ pub(crate) struct Gpu<'bound> {
     bar: &'bound Bar0,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
-    sysmem_flush: SysmemFlush,
+    sysmem_flush: SysmemFlush<'bound>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
@@ -271,11 +271,4 @@ pub(crate) fn new(
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

