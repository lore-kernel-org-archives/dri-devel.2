Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785DEC44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D585910EA63;
	Tue, 21 Jul 2026 15:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OW8ofhD+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B8910E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784646935;
 bh=Bm2sDgGGdf93DGpkU5R0geZJmOBMRfW4uCRvCqoKcOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OW8ofhD+7zPldXdMKoPwIRCf1AgKP5NHavOOfAT5COpMLadJgFqhc3ro6vEBxC4H3
 5q8lfc+SHEWZ/MPZFwhLFESpkMV3Stocac/JZnLHKj6hj9+ooXQpF5E3PhpnXH1C3o
 D8uTJB97SZIL6TAZaiiIed5eM/My+fRoMNHkjoLR7d3K3/TeBC+ZUzVdlys78iCy93
 rZ8KtIK/XL2kNlxAm0C7wDcUHBovThA2I0W1OJFfm1SXlNpfRttNS9Qx0g19A8lhwH
 EOmYxRf8rU1+EveYhKZ40kpXz3ZxHT2kJNjT4894utKpe88prVOQpxDo41I8Et5w5l
 qivftjQSC4niQ==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AFC9917E08A2;
 Tue, 21 Jul 2026 17:15:34 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: daniel.almeida@collabora.com, aliceryhl@google.com, dakr@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org
Cc: boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, deborah.brouwer@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com,
 Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 2/2] drm/tyr: add Job IRQ handling
Date: Tue, 21 Jul 2026 17:14:23 +0200
Message-Id: <20260721151423.444175-3-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260721151423.444175-1-laura.nao@collabora.com>
References: <20260721151423.444175-1-laura.nao@collabora.com>
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

Add a threaded IRQ wrapper for Tyr interrupt sources and use it to handle
the firmware Job IRQ.

The Job IRQ reports requests from the CSF firmware, including global
interface requests and CSG attention bits. Add a Job IRQ handler that
masks the interrupt in the primary IRQ handler, processes pending raw
status in the threaded handler, clears handled bits, and reenables the
mask before returning.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs |  75 ++++++++++++++++++++++++
 drivers/gpu/drm/tyr/fw.rs     |   4 ++
 drivers/gpu/drm/tyr/fw/irq.rs | 104 ++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 drivers/gpu/drm/tyr/fw/irq.rs

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 46ba91af9aca..6ee6f5e578b7 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
+use core::marker::PhantomPinned;
+
 use kernel::{
     clk::{
         Clk,
@@ -21,6 +23,13 @@
         poll,
         Io, //
     },
+    irq::{
+        Flags,
+        IrqReturn,
+        ThreadedHandler,
+        ThreadedIrqReturn,
+        ThreadedRegistration, //
+    },
     new_mutex,
     of,
     platform,
@@ -238,3 +247,69 @@ struct Regulators {
     _mali: Regulator<regulator::Enabled>,
     _sram: Regulator<regulator::Enabled>,
 }
+
+pub(crate) trait TyrIrqTrait: Sync {
+    fn read_status(&self) -> u32;
+    fn clear_mask(&self);
+    fn reenable_mask(&self);
+    fn read_raw_status(&self) -> u32;
+    fn clear_status(&self, status: u32);
+    fn mask(&self) -> u32;
+    fn handle(&self, status: u32);
+}
+
+#[pin_data]
+pub(crate) struct TyrIrq<T: TyrIrqTrait> {
+    irq: T,
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+impl<T: TyrIrqTrait> TyrIrq<T> {
+    pub(crate) fn request<'a>(
+        pdev: &'a platform::Device<Bound>,
+        name: &'static CStr,
+        irq: T,
+    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + 'a>
+    where
+        T: 'a,
+    {
+        let handler = try_pin_init!(Self {
+            irq,
+            _pin: PhantomPinned,
+        });
+
+        // SAFETY: The resulting `PinInit` is not leaked, it is consumed by the caller to
+        // initialize a pinned `ThreadedRegistration`.
+        Ok(unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, name, name, handler) })
+    }
+}
+
+impl<T: TyrIrqTrait> ThreadedHandler for TyrIrq<T> {
+    fn handle(&self) -> ThreadedIrqReturn {
+        let masked_status = self.irq.read_status();
+
+        if masked_status == 0 {
+            return ThreadedIrqReturn::None;
+        }
+        self.irq.clear_mask();
+        ThreadedIrqReturn::WakeThread
+    }
+
+    fn handle_threaded(&self) -> IrqReturn {
+        let mut ret = IrqReturn::None;
+
+        loop {
+            let raw_status = self.irq.read_raw_status() & self.irq.mask();
+            if raw_status == 0 {
+                break;
+            }
+            self.irq.handle(raw_status);
+            self.irq.clear_status(raw_status);
+            ret = IrqReturn::Handled;
+        }
+
+        self.irq.reenable_mask();
+        ret
+    }
+}
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 554808a792aa..4188dc4232f5 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -66,8 +66,12 @@
     vm::Vm, //
 };
 
+pub(crate) mod irq;
 mod parser;
 
+/// Maximum number of CSG interfaces supported by hardware.
+const MAX_CSG: usize = 16;
+
 impl_flags!(
     #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
     pub(super) struct SectionFlags(u32);
diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
new file mode 100644
index 000000000000..4084904d53f6
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/irq.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! IRQ handling for the Job IRQ.
+//!
+//! The Job IRQ signals events from the MCU, including global interface acknowledgements.
+#![allow(dead_code)]
+
+use core::sync::atomic::{
+    AtomicBool,
+    Ordering, //
+};
+
+use kernel::{
+    c_str,
+    device::Bound, //
+    io::Io,
+    irq::ThreadedRegistration,
+    platform,
+    prelude::*,
+    sync::Arc, //
+};
+
+use crate::{
+    driver::{
+        IoMem,
+        TyrIrq,
+        TyrIrqTrait, //
+    },
+    regs::job_control::{
+        JOB_IRQ_CLEAR,
+        JOB_IRQ_MASK,
+        JOB_IRQ_RAWSTAT,
+        JOB_IRQ_STATUS, //
+    },
+    wait::Wait, //
+};
+
+const CSG_IRQ_MASK: u32 = (1u32 << super::MAX_CSG) - 1;
+
+pub(crate) struct JobIrq<'bound> {
+    iomem: Arc<IoMem<'bound>>,
+    fw_ready: Arc<AtomicBool>,
+    ready_wait: Arc<Wait>,
+}
+
+pub(crate) fn job_irq_init<'bound>(
+    pdev: &'bound platform::Device<Bound>,
+    iomem: Arc<IoMem<'bound>>,
+    fw_ready: Arc<AtomicBool>,
+    ready_wait: Arc<Wait>,
+) -> Result<impl PinInit<ThreadedRegistration<'bound, TyrIrq<JobIrq<'bound>>>, Error> + 'bound> {
+    iomem.write_reg(
+        JOB_IRQ_MASK::zeroed()
+            .with_const_csg::<CSG_IRQ_MASK>()
+            .with_glb(true),
+    );
+    let job_irq = JobIrq {
+        iomem: iomem.clone(),
+        fw_ready,
+        ready_wait,
+    };
+
+    TyrIrq::request(pdev, c_str!("job"), job_irq)
+}
+
+impl TyrIrqTrait for JobIrq<'_> {
+    fn read_status(&self) -> u32 {
+        self.iomem.read(JOB_IRQ_STATUS).into_raw()
+    }
+
+    fn clear_mask(&self) {
+        self.iomem.write_reg(JOB_IRQ_MASK::zeroed());
+    }
+
+    fn reenable_mask(&self) {
+        self.iomem.write_reg(
+            JOB_IRQ_MASK::zeroed()
+                .with_const_csg::<CSG_IRQ_MASK>()
+                .with_glb(true),
+        );
+    }
+
+    fn read_raw_status(&self) -> u32 {
+        self.iomem.read(JOB_IRQ_RAWSTAT).into_raw()
+    }
+
+    fn clear_status(&self, status: u32) {
+        self.iomem.write_reg(JOB_IRQ_CLEAR::from_raw(status));
+    }
+
+    fn mask(&self) -> u32 {
+        JOB_IRQ_MASK::zeroed()
+            .with_const_csg::<CSG_IRQ_MASK>()
+            .with_glb(true)
+            .into_raw()
+    }
+
+    fn handle(&self, status: u32) {
+        if JOB_IRQ_RAWSTAT::from_raw(status).glb() {
+            self.fw_ready.store(true, Ordering::Release);
+            self.ready_wait.notify_all();
+        }
+    }
+}
-- 
2.39.5

