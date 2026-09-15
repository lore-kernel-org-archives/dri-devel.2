Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9646BC982C2
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8A710FB35;
	Tue, 15 Sep 2026 10:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BxaQPnB/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F26910F40E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469931;
 bh=4xsDqrilJ7fbk1vkeIBx9zljoIWiTgKz6huGqgRYnvI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BxaQPnB/SRz+afydyotjvnxYwj2Ox/p89aONIy/uNE+au2WuXqVJeLXIQ5AsJRDze
 Xl+FHyXC5ghz9M9zhwewTvRt7qgkJwy/YuMnguuFXIhw3WXagSpR97wCF9P4Za4D5e
 4UBYspSDonLOHaIOxveAoBVR6QGgt3XBS9vN/u+XErTTsE9s3TIOmF7ffls2uB9JpH
 uhn/9BH3RiyKei4rEx26T830Du17751mfSph9Yu5IWadimLvyyovgnIKhInXvIyxde
 2ep3ggx8YSRwpCQqBRGjN7+30A4+AFropgu8rDIMvpS3+/eU+7mxus7gYdZyaYTKKQ
 DQHvNYQjmcmxQ==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DAE4117E0E61;
 Tue, 15 Sep 2026 12:58:50 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Tue, 15 Sep 2026 12:57:42 +0200
Subject: [PATCH 9/9] drm/tyr: wait for global interface readiness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-tyr-interfaces-v1-9-5d28f1f75aca@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
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

Add a wait helper for global interface readiness using the Job IRQ.
JobIrqEvents signals readiness and wakes waiters when the firmware sets
the GLB bit. After booting the firmware, probe waits until the firmware
reports that the global interface is ready to accept requests.
Register the Job IRQ before booting the firmware so that the initial GLB
event is not missed. Store the JobIrqMaskGuard returned by
job_irq_init() ahead of the ThreadedRegistration in
TyrDrmRegistrationData so the Job IRQ is masked before it is freed.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 30 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/tyr/fw.rs     | 23 ++++++++++++++---------
 drivers/gpu/drm/tyr/fw/irq.rs |  1 -
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 2dcf33ec93ea..138afeecfb3d 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -21,6 +21,7 @@
         poll,
         Io, //
     },
+    irq::ThreadedRegistration,
     new_mutex,
     of,
     platform,
@@ -37,10 +38,18 @@
 
 use crate::{
     file::TyrDrmFileData,
-    fw::Firmware,
+    fw::{
+        irq::{
+            job_irq_init,
+            JobIrq,
+            JobIrqMaskGuard, //
+        },
+        Firmware, //
+    },
     gem::Bo,
     gpu,
     gpu::GpuInfo,
+    irq::TyrIrq,
     mmu::Mmu,
     regs::gpu_control::*, //
 };
@@ -81,6 +90,12 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     /// GPU MMIO register mapping.
     pub(crate) iomem: Arc<IoMem<'drm>>,
 
+    /// Masks the Job IRQ on drop. Must be declared before `job_irq` so it is
+    /// dropped first (see [`JobIrqMaskGuard`]).
+    _job_irq_mask: JobIrqMaskGuard<'drm>,
+
+    job_irq: Pin<KBox<ThreadedRegistration<'drm, TyrIrq<JobIrq<'drm>>>>>,
+
     /// GPU information read from hardware during probe.
     pub(crate) gpu_info: GpuInfo,
 }
@@ -158,7 +173,18 @@ fn probe<'bound>(
             &gpu_info,
         )?;
 
+        let (_job_irq_mask, job_irq_registration) =
+            // SAFETY: The resulting registration is stored in
+            // `TyrDrmRegistrationData`, which is dropped normally when
+            // the driver is unbound. It is not leaked or forgotten.
+            unsafe { job_irq_init(pdev, iomem.clone(), firmware.events.clone()) }?;
+
+        let job_irq = KBox::pin_init(job_irq_registration, GFP_KERNEL)?;
+
         firmware.boot()?;
+        firmware.wait_ready(1000).inspect_err(|e| {
+            dev_err!(pdev, "Error waiting for firmware to be ready: {:?}\n", e);
+        })?;
         firmware.enable_global_interface(&gpu_info, &core_clk)?;
 
         let reg_data = pin_init!(TyrDrmRegistrationData {
@@ -174,6 +200,8 @@ fn probe<'bound>(
                     _sram: sram_regulator,
                 }),
                 iomem,
+                _job_irq_mask,
+                job_irq,
                 gpu_info,
         });
 
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 1499ffdef51f..3a7a11c5723e 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -36,7 +36,8 @@
         ArcBorrow,
         Mutex, //
     },
-    time, //
+    time,
+    time::Msecs, //
 };
 
 use crate::{
@@ -68,10 +69,7 @@
             MCU_CONTROL,
             MCU_STATUS, //
         }, //
-        job_control::{
-            JOB_IRQ_CLEAR,
-            JOB_IRQ_RAWSTAT, //
-        }, //
+        job_control::JOB_IRQ_CLEAR,
     },
     vm::Vm, //
 };
@@ -179,6 +177,9 @@ pub(crate) struct Firmware<'drm> {
     /// The global FW interface.
     #[pin]
     global_iface: Mutex<FwIfaces<'drm>>,
+
+    /// Firmware events signalled via the Job IRQ.
+    pub(crate) events: Arc<irq::JobIrqEvents>,
 }
 
 #[pinned_drop]
@@ -291,6 +292,7 @@ pub(crate) fn new(
                     vm: vm.clone(),
                     sections,
                     global_iface <- new_mutex!(FwIfaces::new()?),
+                    events: irq::JobIrqEvents::new()?,
                 }),
                 GFP_KERNEL,
             )?)
@@ -327,10 +329,8 @@ pub(crate) fn boot(&self) -> Result {
         io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto));
 
         if let Err(e) = poll::read_poll_timeout(
-            || Ok((io.read(MCU_STATUS), io.read(JOB_IRQ_RAWSTAT))),
-            |(mcu_status, irq_rawstat)| {
-                mcu_status.value() == McuStatus::Enabled && irq_rawstat.glb()
-            },
+            || Ok(io.read(MCU_STATUS)),
+            |status| status.value() == McuStatus::Enabled,
             time::Delta::from_millis(1),
             time::Delta::from_millis(100),
         ) {
@@ -393,4 +393,9 @@ pub(crate) fn enable_global_interface(&self, gpu_info: &GpuInfo, core_clk: &Clk)
             }
         }
     }
+
+    /// Waits until the firmware signals readiness via the GLB IRQ bit.
+    pub(crate) fn wait_ready(&self, timeout_ms: Msecs) -> Result {
+        self.events.wait_ready(timeout_ms)
+    }
 }
diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
index 7dd894de18cb..95380cb428ba 100644
--- a/drivers/gpu/drm/tyr/fw/irq.rs
+++ b/drivers/gpu/drm/tyr/fw/irq.rs
@@ -3,7 +3,6 @@
 //! IRQ handling for the Job IRQ.
 //!
 //! The Job IRQ signals events from the MCU, including global interface acknowledgements.
-#![allow(dead_code)]
 
 use kernel::{
     device::Bound, //

-- 
2.39.5

