Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B293606A69C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Hdi+9Xj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B361112E8C;
	Sat, 28 Nov 2026 02:16:44 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB67112E84
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832166; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VEguT3rOQgBTZ9SG2NAr4/Pk18LkKjNsUiRuuFixYJ/6wOZ6YhesDMbcSrR1LzefyaDQWjpegSEMEuSOUOAHRaCvflRQrAyWtg00jCl7TRllrU+lJHrZ4HT8FbpYRAQLJ5HaMAywiDyFbFT65XCERmuHbRac3kxZwy/gxYZRqUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832166;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=burL5KmTbeFmlZUskko+KLdoMnvGp13Hw0GTaVj5ukc=; 
 b=fGmkruP0OgdEErByxeq7GmRoMJF7m6AeB8IbQdxZ8Qigj9MDmdtJ+h8JVvIKyF5BdssNRSn4PFLCNbc8y0rjoMPFJnt2HAfpclBQpy09AI/z0fNVhrvWNHVBCuNVUuCJr/EP5GbDLq59U39eHq8bglFnUpZU8lNKD3eNOvQwcBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Hdi+9Xj9KAO6f1qdeqAVs4xGRes8IDwI5ZdTSE91eCeAj78TVvlYHR7AgVxJi3g1Zb6NhRS2M+BH11Zlpfc0uwEAucodVt3zdXEH8Tret7A/Dsul07pIEPJ5h3J/ixs5OtWZsvSyZMf/vqAQkFPabOjoa2TdUrylxeVSbIhY1r8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=burL5KmTbeFmlZUskko+KLdoMnvGp13Hw0GTaVj5ukc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795832163938125.18566182892107; 
 Fri, 27 Nov 2026 18:16:03 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 23:15:40 -0300
Subject: [PATCH 3/9] drm/tyr: request the gpu IRQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-mmu-irq-v1-3-2fcb9f9465cd@collabora.com>
References: <20261127-tyr-mmu-irq-v1-0-2fcb9f9465cd@collabora.com>
In-Reply-To: <20261127-tyr-mmu-irq-v1-0-2fcb9f9465cd@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The gpu IRQ reports gpu-wide events, such as gpu faults, completed
resets and power changes. Tyr does not request it, so nothing can report
a gpu fault.

Add GpuIrq, a TyrIrqTrait implementation for the GPU_CONTROL IRQ
registers, and request the "gpu" interrupt in probe before the firmware
is loaded. Keep the registration in TyrDrmRegistrationData ahead of the
clocks and regulators, since dropping it writes the IRQ mask through
MMIO, which needs them enabled.

All interrupt sources stay masked for now. The next patch unmasks and
reports gpu faults.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs  | 17 +++++++++-
 drivers/gpu/drm/tyr/gpu.rs     |  2 ++
 drivers/gpu/drm/tyr/gpu/irq.rs | 77 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 1fb91d0757f7..383335e8707d 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -33,7 +33,13 @@
     file::TyrDrmFileData,
     fw::Firmware,
     gem::Bo,
-    gpu::GpuInfo,
+    gpu::{
+        irq::{
+            gpu_irq_init,
+            GpuIrq, //
+        },
+        GpuInfo, //
+    },
     irq::TyrIrqRegistration,
     mmu::{
         irq::{
@@ -84,6 +90,10 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     // field before the clocks and regulators.
     _mmu_irq: Pin<KBox<TyrIrqRegistration<'drm, MmuIrq<'drm>>>>,
 
+    // `TyrIrqRegistration::drop()` writes to the GPU registers, so keep this
+    // field before the clocks and regulators.
+    _gpu_irq: Pin<KBox<TyrIrqRegistration<'drm, GpuIrq>>>,
+
     #[pin]
     clks: Mutex<Clocks>,
 
@@ -157,6 +167,10 @@ fn probe<'bound>(
             // drops at unbind, and every error path before that drops it.
             let mmu_irq = unsafe { mmu_irq_init(pdev, hw.clone(), &gpu_info) }?;
 
+            // SAFETY: The registration ends up in `TyrDrmRegistrationData`, which `_reg`
+            // drops at unbind, and every error path before that drops it.
+            let gpu_irq = unsafe { gpu_irq_init(pdev, hw.clone()) }?;
+
             let firmware = Firmware::new(
                 pdev.as_ref(),
                 hw.clone(),
@@ -180,6 +194,7 @@ fn probe<'bound>(
                         reset <- reset::ResetHandle::new(pdev, hw.clone()),
                         fw: firmware,
                         _mmu_irq: mmu_irq,
+                        _gpu_irq: gpu_irq,
                         clks <- new_mutex!(Clocks {
                             core: core_clk,
                             stacks: stacks_clk,
diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index 820de9d60c19..cc86ea04607d 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -28,6 +28,8 @@
     }, //
 };
 
+pub(crate) mod irq;
+
 /// Struct containing information that can be queried by userspace. This is read from
 /// the GPU's registers.
 #[repr(transparent)]
diff --git a/drivers/gpu/drm/tyr/gpu/irq.rs b/drivers/gpu/drm/tyr/gpu/irq.rs
new file mode 100644
index 000000000000..a27ccf5c37a6
--- /dev/null
+++ b/drivers/gpu/drm/tyr/gpu/irq.rs
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! IRQ handling for the GPU IRQ.
+//!
+//! The GPU IRQ reports GPU-wide events, such as faults, completed resets and power changes.
+
+use kernel::{
+    device::Bound,
+    io::Io,
+    platform,
+    prelude::*,
+    sync::Arc, //
+};
+
+use crate::{
+    driver::IoMem,
+    irq::{
+        TyrIrqRegistration,
+        TyrIrqTrait, //
+    },
+    regs::gpu_control::{
+        GPU_IRQ_CLEAR,
+        GPU_IRQ_MASK,
+        GPU_IRQ_RAWSTAT,
+        GPU_IRQ_STATUS, //
+    },
+    reset::HwGate, //
+};
+
+/// The GPU IRQ, signalling GPU-wide events.
+pub(crate) struct GpuIrq;
+
+/// Requests a threaded IRQ registration for the GPU IRQ.
+///
+/// # Safety
+///
+/// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+/// [`Drop`] implementation from running.
+pub(crate) unsafe fn gpu_irq_init<'a>(
+    pdev: &'a platform::Device<Bound>,
+    hw: Arc<HwGate<'a>>,
+) -> Result<Pin<KBox<TyrIrqRegistration<'a, GpuIrq>>>> {
+    let gpu_irq = GpuIrq;
+    // Ensure interrupt sources are disabled until the handler is registered.
+    gpu_irq.clear_mask(hw.access().iomem());
+
+    // SAFETY: The caller guarantees the resulting registration will not be leaked.
+    unsafe { TyrIrqRegistration::request(pdev, c"gpu", c"tyr-gpu", gpu_irq, hw) }
+}
+
+impl TyrIrqTrait for GpuIrq {
+    fn read_status(&self, io: &IoMem<'_>) -> u32 {
+        io.read(GPU_IRQ_STATUS).into_raw()
+    }
+
+    fn clear_mask(&self, io: &IoMem<'_>) {
+        io.write_reg(GPU_IRQ_MASK::zeroed());
+    }
+
+    fn reenable_mask(&self, io: &IoMem<'_>) {
+        io.write_reg(GPU_IRQ_MASK::from_raw(self.mask()));
+    }
+
+    fn read_raw_status(&self, io: &IoMem<'_>) -> u32 {
+        io.read(GPU_IRQ_RAWSTAT).into_raw()
+    }
+
+    fn clear_status(&self, io: &IoMem<'_>, status: u32) {
+        io.write_reg(GPU_IRQ_CLEAR::from_raw(status));
+    }
+
+    fn mask(&self) -> u32 {
+        GPU_IRQ_MASK::zeroed().into_raw()
+    }
+
+    fn handle(&self, _status: u32) {}
+}

-- 
2.56.0

