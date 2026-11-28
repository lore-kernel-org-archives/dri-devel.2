Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A92606A69A
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=TCsPX9XZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6144F112E83;
	Sat, 28 Nov 2026 02:16:22 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E126112BF7
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832160; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U9Pj2eFJtICiMDDxxOJXfm6WGMq/1PkP08GnEHKcbFyMiNwoPY7ZmrXgOo/kN/8RKxYunmJdK8Tbuv5QDFUQteQblBszt+Q3mEDV44My91Z3wvHIFXFcwJD3o+flUV+y8fBal90iTdkXekYUXl8nJKa3KID9Q//faDwKZ2vtlvM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832160;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SGS1yjurF129s3EEICocuiqZDqlPa+vzexrsONiPJ5E=; 
 b=F5qGpTm2yPA6gs3lB/msTy1QTwIkHWskjdprzuZ/2WiwLngR6YU3i1f3a4zBXeNTm8jMIdcZvYgQsoYrY2Rbl2REm6ULdsjDOtD4s2UsUxpiUfkjJv1IORRbsG2CoFCoub1ImIVp8tHKSN7EUhD6cEeIq1eb1xEb45D1v+8OAvQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=TCsPX9XZHywy70OAeYXt/Yao35tC62828iaSwUFv6lGbo7O/xvnQFWvq3uoVaPX1o8by9pQg6QnvHzB1BEgH/sTqcoZYYexqin9P1r2En+gF/F+wz2IgzLhr00GHR6PzOK/LNANbFhFvHI99IvvaLXRVrydJPo2DkS2oR8WOVXE=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=SGS1yjurF129s3EEICocuiqZDqlPa+vzexrsONiPJ5E=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795832158182751.9359826466103;
 Fri, 27 Nov 2026 18:15:58 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 23:15:38 -0300
Subject: [PATCH 1/9] drm/tyr: request the mmu IRQ
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-mmu-irq-v1-1-2fcb9f9465cd@collabora.com>
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

The mmu IRQ reports page faults and completed commands for each address
space. Tyr does not request it, so nothing can report an mmu page fault.

Add MmuIrq, a TyrIrqTrait implementation for the MMU_CONTROL IRQ
registers, and request the "mmu" interrupt in probe before the firmware
is loaded. Keep the registration in TyrDrmRegistrationData ahead of the
clocks and regulators, since dropping it writes the IRQ mask through
MMIO, which needs them enabled.

All interrupt sources stay masked for now. The next patch unmasks and
reports page faults.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs  | 18 +++++++++-
 drivers/gpu/drm/tyr/mmu.rs     |  1 +
 drivers/gpu/drm/tyr/mmu/irq.rs | 77 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 9aa536b16972..44ff1f522902 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -34,7 +34,14 @@
     fw::Firmware,
     gem::Bo,
     gpu::GpuInfo,
-    mmu::Mmu,
+    irq::TyrIrqRegistration,
+    mmu::{
+        irq::{
+            mmu_irq_init,
+            MmuIrq, //
+        },
+        Mmu, //
+    },
     regs::gpu_control::*,
     reset, //
 };
@@ -73,6 +80,10 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     /// Firmware sections.
     pub(crate) fw: Firmware<'drm>,
 
+    // `TyrIrqRegistration::drop()` writes to the GPU registers, so keep this
+    // field before the clocks and regulators.
+    _mmu_irq: Pin<KBox<TyrIrqRegistration<'drm, MmuIrq>>>,
+
     #[pin]
     clks: Mutex<Clocks>,
 
@@ -142,6 +153,10 @@ fn probe<'bound>(
 
             let mmu = Mmu::new(pdev.as_ref(), hw.clone(), &gpu_info)?;
 
+            // SAFETY: The registration ends up in `TyrDrmRegistrationData`, which `_reg`
+            // drops at unbind, and every error path before that drops it.
+            let mmu_irq = unsafe { mmu_irq_init(pdev, hw.clone()) }?;
+
             let firmware = Firmware::new(
                 pdev.as_ref(),
                 hw.clone(),
@@ -164,6 +179,7 @@ fn probe<'bound>(
                         // so reset work is drained before borrowed data expires.
                         reset <- reset::ResetHandle::new(pdev, hw.clone()),
                         fw: firmware,
+                        _mmu_irq: mmu_irq,
                         clks <- new_mutex!(Clocks {
                             core: core_clk,
                             stacks: stacks_clk,
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index adac036744a3..f095c3374e3a 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -42,6 +42,7 @@
 };
 
 pub(crate) mod address_space;
+pub(crate) mod irq;
 
 pub(crate) type AsSlotManager<'drm> = SlotManager<AddressSpaceManager<'drm>, MAX_AS>;
 
diff --git a/drivers/gpu/drm/tyr/mmu/irq.rs b/drivers/gpu/drm/tyr/mmu/irq.rs
new file mode 100644
index 000000000000..7f8b02613e9e
--- /dev/null
+++ b/drivers/gpu/drm/tyr/mmu/irq.rs
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! IRQ handling for the MMU IRQ.
+//!
+//! The MMU IRQ reports page faults and completed commands for each address space.
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
+    regs::mmu_control::{
+        IRQ_CLEAR,
+        IRQ_MASK,
+        IRQ_RAWSTAT,
+        IRQ_STATUS, //
+    },
+    reset::HwGate, //
+};
+
+/// The MMU IRQ, signalling events from the address spaces.
+pub(crate) struct MmuIrq;
+
+/// Requests a threaded IRQ registration for the MMU IRQ.
+///
+/// # Safety
+///
+/// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+/// [`Drop`] implementation from running.
+pub(crate) unsafe fn mmu_irq_init<'a>(
+    pdev: &'a platform::Device<Bound>,
+    hw: Arc<HwGate<'a>>,
+) -> Result<Pin<KBox<TyrIrqRegistration<'a, MmuIrq>>>> {
+    let mmu_irq = MmuIrq;
+    // Ensure interrupt sources are disabled until the handler is registered.
+    mmu_irq.clear_mask(hw.access().iomem());
+
+    // SAFETY: The caller guarantees the resulting registration will not be leaked.
+    unsafe { TyrIrqRegistration::request(pdev, c"mmu", c"tyr-mmu", mmu_irq, hw) }
+}
+
+impl TyrIrqTrait for MmuIrq {
+    fn read_status(&self, io: &IoMem<'_>) -> u32 {
+        io.read(IRQ_STATUS).into_raw()
+    }
+
+    fn clear_mask(&self, io: &IoMem<'_>) {
+        io.write_reg(IRQ_MASK::zeroed());
+    }
+
+    fn reenable_mask(&self, io: &IoMem<'_>) {
+        io.write_reg(IRQ_MASK::from_raw(self.mask()));
+    }
+
+    fn read_raw_status(&self, io: &IoMem<'_>) -> u32 {
+        io.read(IRQ_RAWSTAT).into_raw()
+    }
+
+    fn clear_status(&self, io: &IoMem<'_>, status: u32) {
+        io.write_reg(IRQ_CLEAR::from_raw(status));
+    }
+
+    fn mask(&self) -> u32 {
+        IRQ_MASK::zeroed().into_raw()
+    }
+
+    fn handle(&self, _status: u32) {}
+}

-- 
2.56.0

