Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D54606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6uNkcyP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF1510F6FC;
	Wed, 11 Nov 2026 05:23:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFEB10E17D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:23:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD4D947216;
 Wed, 11 Nov 2026 05:23:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794374613;
 b=kW9722JXs7klg5SI8d8Rmr1rFBQOXFeP8YMYawNX5unuBhMVkAgD87wKr0wNlPgqRgcp
 g9CY2XfSunvKbLWyufV5lzKZWrqr4dcheeIEqlW/nFcTWcSaxAZsZZVw8/mXARbCGTmct
 1m7bdmJYqG6SnTTt9fMCotpGOTW2ik1wjaxFK3eaYt2wi1adtH1v/+72CbsQknR/HZ0oW
 F5ncNvsIryzMlzp/ZoL5ToOyxLVP170whmwNJNmAdr7NqNRtPDnRol+Wv2WQBl/8D1LCP
 SHGlvLyUiSKFzKM1UhOAWqQqu14IUd/lUtMKX6Pn86Ej8SyviKzKSnZIt/no6xeKlqA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794374613;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=E1syRLdKotIl4dek2d5nG+SDWcTBT7GHsAGKvveAx5Y=;
 b=tZbuBvVIguPEwg8nOCthDlbw/prSR7erCWzR+xkG/kbLK5RzP2ubHsWGcPylWrET1AjF
 m1weeOmUG1oJWgbCMtIyb/Zsj1AXjPpHoe/DEmikx/e2QHFp5XzuZsTjVkbJODVGOvqcW
 k95VLrmXwxiu5jJU4Fnmuc3kEiMRG0vNsRZ5DUtD7M37ms6y4PnAPITFxCaHAWulX5u8c
 eu9kCYjOZDkYJ5h/ytzIVY5xOM1efD69UAmQ28Xiqgu1eu9jlQV2myHcFNVSB3eH6+WcR
 AAhxLkw8mP+Gi0kdLHVCF5p2FwX96HIb9NAZI8aP24hVy++GBrURMPX+6JFAhayIKtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D5EC01F0093C;
 Wed, 11 Nov 2026 05:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794374613;
 bh=E1syRLdKotIl4dek2d5nG+SDWcTBT7GHsAGKvveAx5Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=F6uNkcyPbiUg7GlVW8bIao+W3xW5MVFr3eL8hEYC6OJtuSn4f3bXlz9BB3d3Snq/r
 CDPl2zL2SlDmwjfPuqNdfRcsq4GFugZ1v/3OIjdmKZfxjoaIOiMjPMM6DLrErmkGSm
 49LT0ZOVAGfRbg+h84LTXsTVxXAnd3FEaQDHbXgMArS73tI7PyzBX+HXrvK08vruio
 Ku+dCUTI0btie/8vYzAf3rD51dQXdj+27ETDMIKI0xWe2XSmd9B28Dr9HhMniG/1Xf
 Hclv1jh1tFZeWgkXt15gpWq1SRzYclFoolWUBAklt+x+gT+LKbLUGLP3yuexlItECY
 EXG92uxS2wlFw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 66CA448DC4;
 Wed, 11 Nov 2026 05:23:31 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Wed, 11 Nov 2026 15:23:25 +1000
Subject: [PATCH v7 2/2] gpu: nova-core: add support for GPU timer block. (v7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-nova-timer-v7-2-3031c2476551@redhat.com>
References: <20261111-nova-timer-v7-0-3031c2476551@redhat.com>
In-Reply-To: <20261111-nova-timer-v7-0-3031c2476551@redhat.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16394;
 i=airlied@redhat.com; h=from:subject:message-id;
 bh=B8iemeI0YrTbCavgrBOSvCvemvp02U6Njga8B6gx0f4=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq8/vSSQSBZCh1OKDl1CCj2gJ1hLM7nz4rc13xE
 VAbzblxxomJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavP70gAKCRAMdPNZecSG
 viGFD/9V+7Kbh2dTlkcWvmu3m5XzmTyBMOXkOJz77q7O1t2J2Q6YV8quejQmTHPhcAz5RHCrlrp
 XHKbn4cQcrX9QUJNrNK1UmidR+Wc96Ejkq7QgknVo3SdzruFZ4F2t3aOmzoKGsimvR26Lbexp+e
 yS/bbgAyguJM3/t67SFKhAEKkhSl7vZAoPzB0eFoXX9+vFafe0O2QJDYw02um2TYG8ghykvtevV
 op5kNtVHJSBxpI+/U1mUDNAWHRueq8AsSFMnIr4hvoAv5mrkkjrRysJBDrzi1GB+g7xJbzxQpG1
 XG9ho+Ka2DOl0IS/Ic5ne1VE6cG4jaWxIOLZpoxn/qCCrXUStLosOhFJsZ/St/cSOB/2s62NCvl
 ijYnzeF1rD8KDXU+1H0RR259kiu72bjH3VeWSZn7h3XAY3C1x17AsO245m8UkHkf8eWpPfwytD+
 Ly9nh/WlebufamxgLzQ95dO7Iiykx0ihEjxX5oGJMqcPmCGYoaFuS6ChrIEYMkW6Slp9NbObJnk
 3ZVPenXMOzPiW8vreac1tpnj9ZRj/jU93X5CaJnt8gz2LBFdddW3WLU599bKqVLVFtjCHaIZjPP
 sPzhK3/GSCmm3LQsVU9mw4LSWCQox8emq7/ruv54593G/yAmBNm/COcImmvLsz8BclFcJGAu6Rj
 VmHxrJ/ZFDL4PKQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

This is needed to calculate the system timer offset that is passed
to GSP init.

2 HALs exist:

a) tu102 is the gv100 path from open-gpu, the priv level is checked
and the cpu time is written to the gpu timer. no offset is used.

b) gh100 is for hopper+
This is the gh100 path from open-gpu, where the secure system
timer is read, the offset is calculated.
The offset is written to hw offset registers, except on the
original gh100 where a workaround is needed for older FSP versions.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/nova-core/fsp.rs             |  16 ++++-
 drivers/gpu/nova-core/fsp/hal.rs         |   7 ++-
 drivers/gpu/nova-core/fsp/hal/gh100.rs   |   5 ++
 drivers/gpu/nova-core/fsp/regs.rs        |  31 ++++++++++
 drivers/gpu/nova-core/gpu.rs             |   8 +++
 drivers/gpu/nova-core/nova_core.rs       |   1 +
 drivers/gpu/nova-core/timer.rs           |  40 ++++++++++++
 drivers/gpu/nova-core/timer/hal.rs       |  39 ++++++++++++
 drivers/gpu/nova-core/timer/hal/gh100.rs |  71 +++++++++++++++++++++
 drivers/gpu/nova-core/timer/hal/tu102.rs |  49 +++++++++++++++
 drivers/gpu/nova-core/timer/regs.rs      | 103 +++++++++++++++++++++++++++++++
 11 files changed, 366 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 3a4a10487f33..74cbbe3996c6 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -50,10 +50,11 @@
         NvdmHeader,
         NvdmType, //
     },
-    regs, //
+    regs as bootregs, //
 };
 
 mod hal;
+mod regs;
 
 /// PRC message sub-command.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
@@ -389,6 +390,7 @@ pub(crate) fn boot_params(&self) -> &Coherent<'_, GspFmcBootParams> {
 pub(crate) struct Fsp<'a> {
     falcon: Falcon<'a, FspEngine>,
     fmc_fw: GspFmcFirmware<'a>,
+    hal: &'static dyn hal::FspHal,
 }
 
 impl<'a> Fsp<'a> {
@@ -428,7 +430,7 @@ fn wait_secure_boot(
 
         read_poll_timeout(
             || Ok(hal.fsp_boot_status(bar)),
-            |&status| status == regs::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE_STATUS_SUCCESS,
+            |&status| status == bootregs::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE_STATUS_SUCCESS,
             Delta::from_millis(10),
             Delta::from_millis(FSP_SECURE_BOOT_TIMEOUT_MS),
         )
@@ -436,7 +438,11 @@ fn wait_secure_boot(
             dev_err!(dev, "FSP secure boot completion error: {:?}\n", e);
         })?;
 
-        Ok(Fsp { falcon, fmc_fw })
+        Ok(Fsp {
+            falcon,
+            fmc_fw,
+            hal,
+        })
     }
 
     /// Sends a message to FSP and waits for the response.
@@ -549,4 +555,8 @@ pub(crate) fn boot_fmc(
         dev_dbg!(dev, "FSP Chain of Trust completed successfully\n");
         Ok(())
     }
+
+    pub(crate) fn is_bug_3957833_affected(&self, bar: Bar0<'_>) -> bool {
+        self.hal.is_bug_3957833_affected(bar)
+    }
 }
diff --git a/drivers/gpu/nova-core/fsp/hal.rs b/drivers/gpu/nova-core/fsp/hal.rs
index eaf5837ac5a8..f2de7cc296ce 100644
--- a/drivers/gpu/nova-core/fsp/hal.rs
+++ b/drivers/gpu/nova-core/fsp/hal.rs
@@ -13,7 +13,7 @@
 mod gb202;
 mod gh100;
 
-pub(super) trait FspHal {
+pub(super) trait FspHal: Sync {
     /// Returns the secure boot status from the architecture-specific `NV_THERM_I2CS_SCRATCH` register.
     fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32;
 
@@ -23,6 +23,11 @@ pub(super) trait FspHal {
     // TODO: consider moving this into the TLV firmware metadata when ready
     /// Returns the size reserved at the end of the framebuffer, in bytes.
     fn fb_end_reserved_size(&self) -> u64;
+
+    /// Return if the bug 3957833 is affected
+    fn is_bug_3957833_affected(&self, _bar: Bar0<'_>) -> bool {
+        false
+    }
 }
 
 /// Returns the FSP HAL, or `None` if the architecture doesn't support FSP.
diff --git a/drivers/gpu/nova-core/fsp/hal/gh100.rs b/drivers/gpu/nova-core/fsp/hal/gh100.rs
index 9a8563799da8..7f6c8e404f30 100644
--- a/drivers/gpu/nova-core/fsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gh100.rs
@@ -9,6 +9,7 @@
 use crate::{
     driver::Bar0,
     fsp::hal::FspHal,
+    fsp::regs::*,
     regs, //
 };
 
@@ -33,6 +34,10 @@ fn cot_version(&self) -> u16 {
     fn fb_end_reserved_size(&self) -> u64 {
         u64::SZ_2M
     }
+
+    fn is_bug_3957833_affected(&self, bar: Bar0<'_>) -> bool {
+        bar.read(NV_GFW_FSP_UCODE_VERSION).is_bug_3957833_affected()
+    }
 }
 
 const GH100: Gh100 = Gh100;
diff --git a/drivers/gpu/nova-core/fsp/regs.rs b/drivers/gpu/nova-core/fsp/regs.rs
new file mode 100644
index 000000000000..d04c48ac8e5f
--- /dev/null
+++ b/drivers/gpu/nova-core/fsp/regs.rs
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::io::register;
+
+use crate::driver::NovaRegisters;
+
+register! {
+    base: NovaRegisters;
+
+    pub(super) NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(u32)[4] @ 0x008f0330 {
+        31:0 val;
+    }
+
+    /// FSP ucode version
+    pub(super) NV_GFW_FSP_UCODE_VERSION(u32) => NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3[1] {
+        11:0 full;
+    }
+}
+
+impl NV_GFW_FSP_UCODE_VERSION {
+    /// OpenRM kfspRequiresBug3957833WAR_HAL:
+    /// returns `true` if the FSP ucode predates the fix for
+    /// bug 3957833 and hence the sys timer offset must not be programmed.
+    /// Can only be true on GH100 with older FSP.
+    pub(super) fn is_bug_3957833_affected(self) -> bool {
+        /// FSP ucode version from which on the fix for bug 3957833 is included.
+        const FSP_BUG_3957833_FIX_VERSION: u32 = 0x44c;
+
+        self.full() < FSP_BUG_3957833_FIX_VERSION
+    }
+}
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index ac5305d7ff5e..39dcf28068b7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -53,6 +53,10 @@
         GpuMm,
         VramAddress, //
     },
+    timer::{
+        Timer,
+        TimerState, //
+    },
     vgpu::VgpuManager, //
 };
 
@@ -331,6 +335,8 @@ struct GspResources<'gpu> {
     // TODO: use different resource types for each boot method, and make the relevant Gsp methods
     // generic against them.
     fsp: Option<Fsp<'gpu>>,
+    /// Timer state - contains system timer offset
+    timer: TimerState,
     /// vGPU state detected before GSP boot.
     vgpu: VgpuManager,
     /// GSP runtime data.
@@ -497,6 +503,8 @@ pub(crate) fn new<'a>(
 
                 fsp: Fsp::try_new(dev, bar, spec.chipset)?,
 
+                timer: Timer::setup(dev, bar, spec.chipset, fsp.as_ref())?,
+
                 vgpu: VgpuManager::new(pdev, spec.chipset, fsp.as_mut()),
 
                 gsp <- Gsp::new(pdev, bar),
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index a8f6dc22057b..ee59d81e5105 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -27,6 +27,7 @@
 mod sbuffer;
 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
 mod selftest;
+mod timer;
 mod vbios;
 mod vgpu;
 
diff --git a/drivers/gpu/nova-core/timer.rs b/drivers/gpu/nova-core/timer.rs
new file mode 100644
index 000000000000..ea751a9578d0
--- /dev/null
+++ b/drivers/gpu/nova-core/timer.rs
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+mod hal;
+mod regs;
+
+use kernel::{
+    device,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    fsp::Fsp,
+    gpu::Chipset, //
+};
+
+pub(crate) struct Timer;
+
+/// Struct that holds the sys timer offset value
+/// after initialising the GPU timer block.
+pub(crate) struct TimerState {
+    /// This value is to be passed to GspInit SYS_TIMER_OFFSET_NS
+    /// It is considered an opaque value, passed from timer hal to GSP.
+    #[expect(dead_code)]
+    pub(crate) sys_timer_offset_ns: u64,
+}
+
+impl Timer {
+    /// Setup the GPU timer hardware
+    pub(crate) fn setup(
+        dev: &device::Device<device::Bound>,
+        bar: Bar0<'_>,
+        chipset: Chipset,
+        fsp: Option<&Fsp<'_>>,
+    ) -> Result<TimerState> {
+        Ok(TimerState {
+            sys_timer_offset_ns: hal::timer_hal(chipset).setup(dev, bar, fsp)?,
+        })
+    }
+}
diff --git a/drivers/gpu/nova-core/timer/hal.rs b/drivers/gpu/nova-core/timer/hal.rs
new file mode 100644
index 000000000000..f036bc5d43bd
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    device,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    fsp::Fsp,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
+};
+
+mod gh100;
+mod tu102;
+
+pub(super) trait TimerHal {
+    /// Setup the GPU's system timer.
+    ///
+    /// Returns the value to program into GspInitRequest.
+    fn setup(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: Bar0<'_>,
+        fsp: Option<&Fsp<'_>>,
+    ) -> Result<u64>;
+}
+
+pub(super) fn timer_hal(chipset: Chipset) -> &'static dyn TimerHal {
+    match chipset.arch() {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => tu102::TU102_HAL,
+        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+            gh100::GH100_HAL
+        }
+    }
+}
diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-core/timer/hal/gh100.rs
new file mode 100644
index 000000000000..0f061ce2aa6b
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::TimerHal;
+
+use kernel::{
+    device,
+    io::Io,
+    prelude::*,
+    time::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    fsp::Fsp,
+    timer::regs::gh100::*, //
+};
+
+/// Timer HAL for Hopper and Blackwell.
+struct Gh100;
+
+fn sec_timer_read(bar: Bar0<'_>) -> u64 {
+    let mut hi2 = bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_1);
+    loop {
+        let lo = bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_0);
+        let hi = bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_1);
+        if hi == hi2 {
+            return u64::from(u32::from(hi)) << 32 | u64::from(u32::from(lo));
+        }
+        hi2 = bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_1);
+    }
+}
+
+fn set_sys_timer_offset(bar: Bar0<'_>, fsp: &Fsp<'_>, time_ns: u64) -> u64 {
+    let sec_timer_ns = sec_timer_read(bar);
+
+    // if we wrap after an underflow the SEC_TIMER + OFFSET value
+    // modulo 61 bits will match the system clock.
+    let sys_timer_offset_ns = time_ns.wrapping_sub(sec_timer_ns);
+
+    // Don't set the timer offset registers on buggy firmware
+    if !fsp.is_bug_3957833_affected(bar) {
+        bar.write_reg(NV_PGC6_SCI_SYS_TIMER_OFFSET_1::from_nsec(
+            sys_timer_offset_ns,
+        ));
+        bar.write_reg(
+            NV_PGC6_SCI_SYS_TIMER_OFFSET_0::from_nsec(sys_timer_offset_ns).with_update(true),
+        );
+    }
+    sys_timer_offset_ns
+}
+
+impl TimerHal for Gh100 {
+    fn setup(
+        &self,
+        _dev: &device::Device<device::Bound>,
+        bar: Bar0<'_>,
+        fsp: Option<&Fsp<'_>>,
+    ) -> Result<u64> {
+        // The OpenRM driver uses wall clock time here not monotonic
+        let sys_time_ns = Instant::<RealTime>::now().as_nanos();
+
+        // fsp is required on gh100 - return error if not available.
+        let fsp = fsp.ok_or(EINVAL)?;
+
+        // CAST: realtime system time can't be negative.
+        Ok(set_sys_timer_offset(bar, fsp, sys_time_ns as u64))
+    }
+}
+
+const GH100: Gh100 = Gh100;
+pub(super) const GH100_HAL: &dyn TimerHal = &GH100;
diff --git a/drivers/gpu/nova-core/timer/hal/tu102.rs b/drivers/gpu/nova-core/timer/hal/tu102.rs
new file mode 100644
index 000000000000..93fe17990ec8
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::TimerHal;
+
+use kernel::{
+    device,
+    io::Io,
+    prelude::*,
+    time::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    fsp::Fsp,
+    timer::regs::*, //
+};
+
+/// Timer HAL for Turing, Ampere, Ada
+struct Tu102;
+
+fn set_time(bar: Bar0<'_>, time_ns: u64) -> Result {
+    if !bar.read(NV_PTIMER_TIME_PRIV_LEVEL_MASK).level0() {
+        return Err(EINVAL);
+    }
+    bar.write_reg(NV_PTIMER_TIME_1::from_nsec(time_ns));
+    bar.write_reg(NV_PTIMER_TIME_0::from_nsec(time_ns));
+    Ok(())
+}
+
+impl TimerHal for Tu102 {
+    fn setup(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: Bar0<'_>,
+        _fsp: Option<&Fsp<'_>>,
+    ) -> Result<u64> {
+        // The OpenRM driver uses wall clock time here not monotonic
+        let sys_time_ns = Instant::<RealTime>::now().as_nanos();
+
+        // CAST: realtime system time can't be negative.
+        // not setting the timer isn't fatal, just log.
+        let _ = set_time(bar, sys_time_ns as u64)
+            .inspect_err(|e| dev_err!(dev, "timer block failed to initialise: {:?}", e));
+        Ok(0_u64)
+    }
+}
+
+const TU102: Tu102 = Tu102;
+pub(super) const TU102_HAL: &dyn TimerHal = &TU102;
diff --git a/drivers/gpu/nova-core/timer/regs.rs b/drivers/gpu/nova-core/timer/regs.rs
new file mode 100644
index 000000000000..789a14c88c55
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/regs.rs
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    bits,
+    io::register,
+    num::Bounded, //
+};
+
+use crate::driver::NovaRegisters;
+use pin_init::Zeroable;
+
+/// Field value for the NSEC field (31:5) of the `_0` registers: `nsec[31:5]`.
+///
+/// The GPU timer counts nanoseconds with 32 ns granularity, so `nsec[4:0]` is dropped.
+fn nsec_lo(nsec: u64) -> Bounded<u32, 27> {
+    // CAST: take the lowest 32-bits of nsec
+    Bounded::<u32, 32>::from(nsec as u32).shr::<5, _>()
+}
+
+/// Field value for the NSEC field (28:0) of the `_1` registers: `nsec[60:32]`.
+///
+/// The GPU timer is 61 bits wide, so `nsec[63:61]` is not representable and is
+/// truncated - the same bits the hardware discards on a raw register write.
+fn nsec_hi(nsec: u64) -> Bounded<u32, 29> {
+    // CAST: shift 64-bits down by 32-bits and take only those 32-bits
+    Bounded::<u32, 29>::from_expr((nsec >> 32) as u32 & bits::genmask_u32(0..=28))
+}
+
+// PTIMER
+
+register! {
+    base: NovaRegisters;
+
+    pub(super) NV_PTIMER_TIME_PRIV_LEVEL_MASK(u32) @ 0x00009430 {
+        4:4 level0 => bool;
+    }
+
+    pub(super) NV_PTIMER_TIME_0(u32) @ 0x00009400 {
+        31:5 nsec;
+    }
+
+    pub(super) NV_PTIMER_TIME_1(u32) @ 0x00009410 {
+        28:0 nsec;
+    }
+}
+
+impl NV_PTIMER_TIME_0 {
+    pub(super) fn from_nsec(nsec: u64) -> Self {
+        Self::zeroed().with_nsec(nsec_lo(nsec))
+    }
+}
+
+impl NV_PTIMER_TIME_1 {
+    pub(super) fn from_nsec(nsec: u64) -> Self {
+        Self::zeroed().with_nsec(nsec_hi(nsec))
+    }
+}
+
+pub(super) mod gh100 {
+    use kernel::io::register;
+
+    use super::{
+        nsec_hi,
+        nsec_lo, //
+    };
+    use crate::driver::NovaRegisters;
+    use pin_init::Zeroable;
+
+    // PGC6/TIMER
+    register! {
+        base: NovaRegisters;
+
+        pub(in crate::timer) NV_PGC6_SCI_SEC_TIMER_TIME_0(u32) @ 0x00118f54 {
+            31:5 nsec;
+        }
+
+        pub(in crate::timer) NV_PGC6_SCI_SEC_TIMER_TIME_1(u32) @ 0x00118f58 {
+            28:0 nsec;
+        }
+
+        pub(in crate::timer) NV_PGC6_SCI_SYS_TIMER_OFFSET_0(u32) @ 0x00118df4 {
+            0:0 update;
+            31:5 nsec;
+        }
+
+        pub(in crate::timer) NV_PGC6_SCI_SYS_TIMER_OFFSET_1(u32) @ 0x00118df8 {
+            28:0 nsec;
+        }
+
+    }
+
+    impl NV_PGC6_SCI_SYS_TIMER_OFFSET_0 {
+        pub(in crate::timer) fn from_nsec(nsec: u64) -> Self {
+            Self::zeroed().with_nsec(nsec_lo(nsec))
+        }
+    }
+
+    impl NV_PGC6_SCI_SYS_TIMER_OFFSET_1 {
+        pub(in crate::timer) fn from_nsec(nsec: u64) -> Self {
+            Self::zeroed().with_nsec(nsec_hi(nsec))
+        }
+    }
+}

-- 
2.56.0


