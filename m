Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE94FF8850
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AC310F700;
	Fri, 24 Apr 2026 23:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="NVRJRMit";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3346210F700
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073977; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DLGWL+QUqSjLkm3RfUeOY1QcsyRdDj8WwyegMJrJp+zhmpoljdRLp2CQl2Hu9Sr53M0b05cZI2ET3mbwmCAtVhgVS4N4zzL+yywSqj/RzdyjvqzQXCLtdAa5NDmHYDgRilKqg3GBSqGWqbRlpMpoMv9S2jqHj/43VIpk6pkUAYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073977;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XPCpEWcCJ0qzuj/oC3i6Lp1Z+GZwJBbgwjn01sw/iTY=; 
 b=gTZCVvmngYUVHB1za1iPpclaNdidHNztyQ6NzbJzkCAdKsrZx+4sANqW47qAVfsoY43bOsoLLGERTyYS8QjrM/gm6c1cnH/gybNxztEDIKmNj0RgEjQShpx9ynD8SDBvdx4mAu080r0Ux8tYJsX+R572ZolOipFwvYGe/tzyGmY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073977; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=XPCpEWcCJ0qzuj/oC3i6Lp1Z+GZwJBbgwjn01sw/iTY=;
 b=NVRJRMitxXq/FphIpBxwcRzsEzOSiBv3071c5ioSTJ6oyqVD7Pl8slU3sl8MIjrw
 sVUO+p0zm5AGqi703QXwBBgL/SeJH1GuIeluQv9yZWWyMGS+/VB3rCWJqhnE8bwvZ96
 cul1MYJPYhFjB/rX7aIWQOTBZBlERKrrhmf3/IrY=
Received: by mx.zohomail.com with SMTPS id 1777073974777481.1103136465414;
 Fri, 24 Apr 2026 16:39:34 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:10 -0700
Subject: [PATCH v4 16/20] drm/tyr: wait for global interface readiness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-16-a5d91050789d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5113;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=zL8ETxM/Ozs01P199qVIBqOXQzVzvFVTIb+dkPMKXBE=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yu0tsUqaFRnbLi76ubZmZd/f9od6BBV7Hoh0/Dzk
 hyHwOaXHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAExELZHhr/TMqc61PL+LpjUt
 2sS+8qH1DE29KcfddNQWhQtWHzcLcGH4p3hRvfvEa6aly+8fKhAMWlztLbvsfbVx813uL8/nRH0
 yYQMA
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

Add a wait helper for global interface readiness using the Job IRQ. The
IRQ handler latches readiness in fw_ready and wakes waiters. After
booting the firmware, probe waits until the firmware reports that the
global interface is ready to accept requests.

Register the Job IRQ before booting the firmware so that the initial GLB
event is not missed.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 18 +++++++++++++++++-
 drivers/gpu/drm/tyr/fw.rs     | 35 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/tyr/fw/irq.rs |  1 -
 drivers/gpu/drm/tyr/wait.rs   |  1 -
 4 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index da007aded92d..3225385cd511 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -12,6 +12,7 @@
         Core,
         Device, //
     },
+    devres,
     devres::Devres,
     dma::{
         Device as DmaDevice,
@@ -51,7 +52,10 @@
 
 use crate::{
     file::TyrDrmFileData,
-    fw::Firmware,
+    fw::{
+        irq::job_irq_init,
+        Firmware, //
+    },
     gem::BoData,
     gpu,
     gpu::GpuInfo,
@@ -176,8 +180,20 @@ fn probe(
             &gpu_info,
         )?;
 
+        let job_irq = job_irq_init(
+            pdev,
+            iomem.clone(),
+            firmware.fw_ready.clone(),
+            firmware.ready_wait.clone(),
+        )?;
+        devres::register(pdev.as_ref(), job_irq, GFP_KERNEL)?;
+
         firmware.boot()?;
 
+        firmware
+            .wait_ready(1000)
+            .inspect_err(|_| pr_err!("Timed out waiting for firmware to be ready.\n"))?;
+
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
                 fw: firmware,
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index b5ccacf891a3..14815cdafac8 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -13,6 +13,11 @@
 //! [`Firmware`]: crate::fw::Firmware
 //! [`Section`]: crate::fw::Section
 
+use core::sync::atomic::{
+    AtomicBool,
+    Ordering, //
+};
+
 use kernel::{
     bits::genmask_u32,
     devres::Devres,
@@ -25,6 +30,7 @@
         poll,
         Io, //
     },
+    new_mutex,
     platform,
     prelude::*,
     str::CString,
@@ -52,6 +58,7 @@
     },
     gpu::GpuInfo,
     mmu::Mmu,
+    new_wait,
     regs::gpu_control::{
         McuControlMode,
         McuStatus,
@@ -59,13 +66,18 @@
         MCU_CONTROL,
         MCU_STATUS, //
     },
-    vm::Vm, //
+    vm::Vm,
+    wait::{
+        Wait,
+        WaitResult, //
+    }, //
 };
 
 pub(crate) mod irq;
 mod parser;
 
-const MAX_CSG: u32 = 16;
+/// Maximum number of CSG interfaces supported by hardware.
+const MAX_CSG: usize = 16;
 
 impl_flags!(
     #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
@@ -142,6 +154,12 @@ pub(crate) struct Firmware {
     /// List of firmware sections.
     #[expect(dead_code)]
     sections: KVec<Section>,
+
+    /// A condvar representing a wait on a firmware event.
+    pub(crate) ready_wait: Arc<Wait>,
+
+    /// Latched to `true` by the IRQ handler when the firmware signals readiness via the GLB bit.
+    pub(crate) fw_ready: Arc<AtomicBool>,
 }
 
 impl Drop for Firmware {
@@ -246,6 +264,8 @@ pub(crate) fn new(
                 iomem,
                 vm,
                 sections,
+                ready_wait: new_wait!()?,
+                fw_ready: Arc::new(AtomicBool::new(false), GFP_KERNEL)?,
             },
             GFP_KERNEL,
         )?;
@@ -272,4 +292,15 @@ pub(crate) fn boot(&self) -> Result {
         }
         Ok(())
     }
+
+    /// Waits until the firmware signals readiness via the GLB IRQ bit.
+    pub(crate) fn wait_ready(&self, timeout_ms: u32) -> Result {
+        self.ready_wait.wait_interruptible_timeout(timeout_ms, || {
+            if self.fw_ready.load(Ordering::Acquire) {
+                Ok(WaitResult::Done)
+            } else {
+                Ok(WaitResult::Retry)
+            }
+        })
+    }
 }
diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
index 0eff5a14f69e..0f371000679c 100644
--- a/drivers/gpu/drm/tyr/fw/irq.rs
+++ b/drivers/gpu/drm/tyr/fw/irq.rs
@@ -3,7 +3,6 @@
 //! IRQ handling for the Job IRQ.
 //!
 //! The Job IRQ signals events from the MCU, including global interface acknowledgements.
-#![allow(dead_code)]
 
 use core::sync::atomic::{
     AtomicBool,
diff --git a/drivers/gpu/drm/tyr/wait.rs b/drivers/gpu/drm/tyr/wait.rs
index 2a4d691c443c..1db4c1827fd7 100644
--- a/drivers/gpu/drm/tyr/wait.rs
+++ b/drivers/gpu/drm/tyr/wait.rs
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 //! Code to wait on GPU events.
-#![allow(dead_code)]
 
 use kernel::{
     new_condvar,

-- 
2.53.0

