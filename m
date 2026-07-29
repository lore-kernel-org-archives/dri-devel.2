Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48301C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4B110E010;
	Wed, 29 Jul 2026 09:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EKOEPZZ/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4583710E010
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785319165;
 bh=Suq674LFa59jDaaZiBW1Id3uqgygHaxrL2MNmowVaRM=;
 h=From:Date:Subject:To:Cc:From;
 b=EKOEPZZ/9cOXaaDtueiJA9jxBWnPAQp5e6VWRlYd0TEbiA8LpoPxwwdnkVddsXKVY
 6s3tWBWEsaxELzMfAr6SttKeuTh/dyCtvfouFqrl9DS9vBmkSC0ULg2oCDrGp9gQOy
 xASN0BZU1Uaqw+O/LItycxRRSvVLiKRlnXfxERkboGOIEhZHXmoZ9fR1vKPi4xZSk3
 PpEqu5Cp4JtDV/aXGgMdi7FYoJhpqo+eReH03JAmaApGm8qFyuFrBBOolM19mAe6oU
 qPGkhhXKmC3TgUjlgBRCRAXRdQOAr7yI2zznOZNl0xEXsMyWfK4Asg9nFZnaq1cIwp
 LNBVB5SbdKNIA==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 16FAC17E0048;
 Wed, 29 Jul 2026 11:59:25 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Wed, 29 Jul 2026 11:58:29 +0200
Subject: [PATCH v2] drm/tyr: add Job IRQ handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-tyr-irq-v2-v2-1-c2750fc11d59@collabora.com>
X-B4-Tracking: v=1; b=H4sIAMTOaWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcyML3ZLKIt3MokLdMiNdgyTjZFMDI6OkVGNjJaCGgqLUtMwKsGHRsbW
 1AA19aBVcAAAA
X-Change-ID: 20260728-tyr-irq-v2-0b3c5022be33
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, kernel@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.14.3
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

Add a threaded IRQ wrapper for Tyr interrupt sources and use it to
handle the firmware Job IRQ.

The Job IRQ reports requests from the CSF firmware, including global
interface requests and CSG attention bits. Add a Job IRQ handler that
masks the interrupt in the primary IRQ handler, processes pending raw
status in the threaded handler, clears handled bits, and reenables the
mask before returning.
Add a wait queue and a bool flag so the handler can signal firmware
readiness when the GLB bit is set.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
This patch follows up to [1], which adds support for firmware loading
and MCU booting to the Tyr driver. The changes included here were
originally introduced in its v4[2], then dropped to reduce the scope of
the series, and have been adjusted to work with the HRT (Higher-Ranked
Lifetime Types) driver architecture recently introduced.

The patch adds a threaded IRQ wrapper for the firmware Job interrupts,
used to signal events from the global CSF (GLB) and Command Stream Group
(CSG) interfaces.

These changes will be later used to wait for global CSF interface
readiness after firmware boot, as part of the CSF firmware interfaces
support that will be submitted as a separate series.

v1: https://lore.kernel.org/all/20260721151423.444175-1-laura.nao@collabora.com/

Changes in v2:
- Dropped Wait custom type in favor of WaitQueue
- Renamed JobIrq lifetime to generic 'a

This patch is based on drm-rust-next and depends on:
- [PATCH v10 0/7] drm/tyr: firmware loading and MCU boot support[1] (and its dependencies)
- [PATCH v2] rust: irq: make Registration compatible with lifetime-bound drivers[3]
- [PATCH 0/5] rust: sync: add WaitQueue infrastructure[4]

Note: [4] doesn't apply cleanly on drm-rust-next at the moment, due to
missing changes in rust/kernel/sync/lock/spinlock.rs[5]. I've applied
all dependencies and fixed conflicts for the purpose of testing this
patch on top of drm-rust-next, a branch with these changes is available
here: https://gitlab.freedesktop.org/laura.nao/linux/-/commits/b4/tyr-irq-v2

[1] https://lore.kernel.org/all/20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com/ 
[2] https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-15-a5d91050789d@collabora.com/
[3] https://lore.kernel.org/rust-for-linux/20260719153631.559341-1-dakr@kernel.org/
[4] https://lore.kernel.org/rust-for-linux/20260726223613.1242940-1-dakr@kernel.org/
[5] https://lore.kernel.org/all/20260302232154.861916-1-lyude@redhat.com/
---
 drivers/gpu/drm/tyr/driver.rs |  75 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/fw.rs     |   4 ++
 drivers/gpu/drm/tyr/fw/irq.rs | 106 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index d78ad9d292ff..b9994aea8684 100644
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
@@ -236,3 +245,69 @@ struct Regulators {
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
index 47d25c901bd0..c425fd95bbd1 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -69,8 +69,12 @@
     vm::Vm, //
 };
 
+pub(crate) mod irq;
 mod parser;
 
+/// Maximum number of CSG interfaces supported by hardware.
+const MAX_CSG: usize = 16;
+
 pub(super) const CSF_MCU_SHARED_REGION_START: u32 = 0x04000000;
 
 #[derive(Copy, Clone, Debug, PartialEq, Eq)]
diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
new file mode 100644
index 000000000000..95077a93639c
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/irq.rs
@@ -0,0 +1,106 @@
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
+    sync::{
+        Arc,
+        WaitQueue, //
+    },
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
+    }, //
+};
+
+const CSG_IRQ_MASK: u32 = (1u32 << super::MAX_CSG) - 1;
+
+pub(crate) struct JobIrq<'a> {
+    iomem: Arc<IoMem<'a>>,
+    fw_ready: Arc<AtomicBool>,
+    job_irq_wait: Arc<WaitQueue>,
+}
+
+pub(crate) fn job_irq_init<'a>(
+    pdev: &'a platform::Device<Bound>,
+    iomem: Arc<IoMem<'a>>,
+    fw_ready: Arc<AtomicBool>,
+    job_irq_wait: Arc<WaitQueue>,
+) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, Error> + 'a> {
+    iomem.write_reg(
+        JOB_IRQ_MASK::zeroed()
+            .with_const_csg::<CSG_IRQ_MASK>()
+            .with_glb(true),
+    );
+    let job_irq = JobIrq {
+        iomem: iomem.clone(),
+        fw_ready,
+        job_irq_wait,
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
+            self.job_irq_wait.wake_up_all();
+        }
+    }
+}

---
base-commit: f04035d00132e898ba2e107783ac1f8419a452ac
change-id: 20260728-tyr-irq-v2-0b3c5022be33

Best regards,
-- 
Laura Nao <laura.nao@collabora.com>

