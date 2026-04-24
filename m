Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0221FF885D
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E64D10F702;
	Fri, 24 Apr 2026 23:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="fe7roqjA";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DD610F6FD
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073975; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KQn9RxJQSFmEOihrIKHKoRVnv3ubC+rp6yapRUxuQh2gFjilYhA7tlhYQRCByTtab/4SHzMJgrinQ2A+JttsAGvLhVTJC/7V5QV3J2SEQCIzTKBzPvKYtB9mGJaumL/3Mr+vU+09ps2M8Ynzwqsi4gj2cqHL5oxHPXDoGaLF4EM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073975;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Hp6X7lRO2Not0Ub1LtI2j0rehU8Gzb0YawWAXUTLDb0=; 
 b=ZuL3LTDSvCztv1Z/+8jYrkfunRrKmPERiL88xubRJzrzhHISlWXr+tdSW7rC/ja6gjdiqp/Mnd9sJpu+33ZKokJIPEDgDWbFrozl4MjEeLVv06w2XimmMbV9/bbAYM8JcHBZDICAq7KEeabbrLd2hpA1TPchJYXJ/2EzSIxW/4s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073975; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Hp6X7lRO2Not0Ub1LtI2j0rehU8Gzb0YawWAXUTLDb0=;
 b=fe7roqjAguEzrrIhEU2EWz4ssU4PXZe+xahbpAU1zNOfz1U2W6VK2b6pNd2ArbOU
 R/uPH+AZQy0AGO+4sWbsmJ8TBu9t9BcZhhzSMzw5OuxOR5oP8gMu69LjAXGJSqr0Jw+
 TK9YqijFMg3oIQL6QpFj2HGFjUGd2JfVA9mJPjQs=
Received: by mx.zohomail.com with SMTPS id 177707397360115.53315446750355;
 Fri, 24 Apr 2026 16:39:33 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:09 -0700
Subject: [PATCH v4 15/20] drm/tyr: add Job IRQ handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-15-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7139;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=Wy5br/oMx1DtfGRbLaIteahpbobGyw+1HEHcVVt4KSA=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yv8bHi5Y/bt/eUnDoS3nPe/UfzfPpGN5XSR/Lq9f
 mpmzzlvd5SyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjCRMwsY/hfzxaz+KfqJd/Jm
 t+u2p/Z27r956+Sa/phJm6ZU/ux+vPw4I8NbtT9J9XdSZwfOUw574GN3fUbA1Jl9TjI+/Sm2Jhu
 5tbgA
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

Add a threaded IRQ wrapper for Tyr interrupt sources and use it to handle
the firmware Job IRQ.

The Job IRQ reports requests from the CSF firmware, including global
interface requests and CSG attention bits. Add a Job IRQ handler that
masks the interrupt in the primary IRQ handler, processes pending raw
status in the threaded handler, clears handled bits, and reenables the
mask before returning.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs |  70 ++++++++++++++++++++++++
 drivers/gpu/drm/tyr/fw.rs     |   3 ++
 drivers/gpu/drm/tyr/fw/irq.rs | 121 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 246bc3cb8580..da007aded92d 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
+use core::marker::PhantomPinned;
+
 use kernel::{
     clk::{
         Clk,
@@ -25,6 +27,13 @@
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
@@ -239,3 +248,64 @@ struct Regulators {
     _mali: Regulator<regulator::Enabled>,
     _sram: Regulator<regulator::Enabled>,
 }
+
+pub(crate) trait TyrIrqTrait: Sync {
+    fn read_status(&self, dev: &Device<Bound>) -> u32;
+    fn clear_mask(&self, dev: &Device<Bound>);
+    fn reenable_mask(&self, dev: &Device<Bound>);
+    fn read_raw_status(&self, dev: &Device<Bound>) -> u32;
+    fn clear_status(&self, dev: &Device<Bound>, status: u32);
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
+impl<T: TyrIrqTrait + 'static> TyrIrq<T> {
+    pub(crate) fn request<'a>(
+        pdev: &'a platform::Device<Bound>,
+        name: &'static CStr,
+        irq: T,
+    ) -> Result<impl PinInit<ThreadedRegistration<Self>, Error> + 'a> {
+        let handler = try_pin_init!(Self {
+            irq,
+            _pin: PhantomPinned,
+        });
+
+        Ok(pdev.request_threaded_irq_by_name(Flags::SHARED, name, name, handler))
+    }
+}
+
+impl<T: TyrIrqTrait> ThreadedHandler for TyrIrq<T> {
+    fn handle(&self, dev: &Device<Bound>) -> ThreadedIrqReturn {
+        let masked_status = self.irq.read_status(dev);
+
+        if masked_status == 0 {
+            return ThreadedIrqReturn::None;
+        }
+        self.irq.clear_mask(dev);
+        ThreadedIrqReturn::WakeThread
+    }
+
+    fn handle_threaded(&self, dev: &Device<Bound>) -> IrqReturn {
+        let mut ret = IrqReturn::None;
+
+        loop {
+            let raw_status = self.irq.read_raw_status(dev) & self.irq.mask();
+            if raw_status == 0 {
+                break;
+            }
+            self.irq.handle(raw_status);
+            self.irq.clear_status(dev, raw_status);
+            ret = IrqReturn::Handled;
+        }
+
+        self.irq.reenable_mask(dev);
+        ret
+    }
+}
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index cb2546350f0a..b5ccacf891a3 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -62,8 +62,11 @@
     vm::Vm, //
 };
 
+pub(crate) mod irq;
 mod parser;
 
+const MAX_CSG: u32 = 16;
+
 impl_flags!(
     #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
     pub(super) struct SectionFlags(u32);
diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
new file mode 100644
index 000000000000..0eff5a14f69e
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/irq.rs
@@ -0,0 +1,121 @@
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
+    device::{
+        Bound,
+        Device, //
+    },
+    devres::Devres,
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
+pub(crate) struct JobIrq {
+    iomem: Arc<Devres<IoMem>>,
+    fw_ready: Arc<AtomicBool>,
+    ready_wait: Arc<Wait>,
+}
+
+pub(crate) fn job_irq_init<'a>(
+    pdev: &'a platform::Device<Bound>,
+    iomem: Arc<Devres<IoMem>>,
+    fw_ready: Arc<AtomicBool>,
+    ready_wait: Arc<Wait>,
+) -> Result<impl PinInit<ThreadedRegistration<TyrIrq<JobIrq>>, Error> + 'a> {
+    let io = iomem.access(pdev.as_ref())?;
+    io.write_reg(
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
+impl TyrIrqTrait for JobIrq {
+    fn read_status(&self, dev: &Device<Bound>) -> u32 {
+        match self.iomem.access(dev) {
+            Ok(io) => io.read(JOB_IRQ_STATUS).into_raw(),
+            Err(_) => 0,
+        }
+    }
+
+    fn clear_mask(&self, dev: &Device<Bound>) {
+        if let Ok(io) = self.iomem.access(dev) {
+            io.write_reg(JOB_IRQ_MASK::zeroed());
+        }
+    }
+
+    fn reenable_mask(&self, dev: &Device<Bound>) {
+        if let Ok(io) = self.iomem.access(dev) {
+            io.write_reg(
+                JOB_IRQ_MASK::zeroed()
+                    .with_const_csg::<CSG_IRQ_MASK>()
+                    .with_glb(true),
+            );
+        }
+    }
+
+    fn read_raw_status(&self, dev: &Device<Bound>) -> u32 {
+        match self.iomem.access(dev) {
+            Ok(io) => io.read(JOB_IRQ_RAWSTAT).into_raw(),
+            Err(_) => 0,
+        }
+    }
+
+    fn clear_status(&self, dev: &Device<Bound>, status: u32) {
+        if let Ok(io) = self.iomem.access(dev) {
+            io.write_reg(JOB_IRQ_CLEAR::from_raw(status));
+        }
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
2.53.0

