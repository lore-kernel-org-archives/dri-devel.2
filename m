Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEA606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPVKj0pH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756F210FFE4;
	Thu,  5 Nov 2026 03:07:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CD210FD4B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 03:07:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D16684402C;
 Thu,  5 Nov 2026 03:07:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793848038;
 b=qVvDhp3WxAiFsMeMJnZd/HNiF+NpSa+OlaK0FjuK8apqs0VkpCeUbBxY0et6eVSZaBvP
 m2cxdE0HgjuxQ/hm6NCHHuS1TbLVVzFHQHAr6fyrCUUCJ+JQNz+6XtWRXPbWWX96guMND
 oSONTKiSXbnx8UDmvbrn6EBfJM6MN/W4uXoFx8CVuMrOui5R+uXxt9Rv4O5WZYsLL6Z71
 HrYu/ths1hb+3kSXK+fnFJjBf3vfkD3arbmjrXE4LMAZrhTFBi+MLOqNrnInbK2vCI2RQ
 G2XkEPrMYjF4vVZAIq2pbp8La+jToHn7xyBPh4IEtNyeLhQ6ciqu/k9t9bUEleB93gQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793848038;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=FsCb5Uvd0Yy9iqcCd7J4dGtuvXU+lImdapPAV+q8LDQ=;
 b=BL5WUUmRxLQMWCxKklRuGhPx83nim7J9RdJlC1CsyO/I0Q9OaUQobB0iviuoAiT1mZpM
 hzSewnwP1xSdqnm4wUXcPRm0GcTJr2zze0Ge1s280cfQZpT5qjhB+Sf677tCaALXGSQs2
 KplFU9BvgmnI/0IvjKC5oraLVXuM0CM7k9Z2CC0uzNi/nrwHEUd/k4J0OiN56pUZeilsL
 79FnbEWRVlAlVx9TVNJiQJCDEE2wbyFrBi+H2gzll985EPn8Cf+boE0F5kthyEzjwVGCr
 0PAAi7dK4nSGvcx+RaFYgBabKiWyVQklY3aje8TQR+sGBMrCYYSwxrIOfQe/VW2vIHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 54D3B1F00A22;
 Thu,  5 Nov 2026 03:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793848038;
 bh=FsCb5Uvd0Yy9iqcCd7J4dGtuvXU+lImdapPAV+q8LDQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=oPVKj0pHM15HNxTwT/itHhOU8PSXnWpGatNoayJ3SJkftkhFwyj1ISlzfsYiqKSdP
 stv0KururdnvHFFbA3xqkwLT+JuAt4j9OFU03stEJpoVmEW9fRupl73zIyymenJeQ9
 E9+Pg00p38TpRfN/tHtf9nRkdhFJrniPj+9pe2iwS23q8xeCFe9bt3vlqFQzMIZKhu
 8+Yt2HqaFEQ78ZhPjnBgxxV9qAlboL4k9fKjyMZTaH8EsaZa83XpgYUm8N0Ppz2JA2
 cFSoFtr+se6j1ux+EXIX9M1USg8Fe+ScuR/C30TxM6g5TCNGEtbLo+bL0QdB4mt7rK
 ewRJzaF6KbTwA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C6C1D47068;
 Thu,  5 Nov 2026 03:07:15 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 05 Nov 2026 13:07:02 +1000
Subject: [PATCH v4 2/2] gpu: nova-core: add support for GPU timer block. (v4)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
In-Reply-To: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13669;
 i=airlied@redhat.com; h=from:subject:message-id;
 bh=Qv4X+Q1kq0c1fJOTrGlHwciKB+lQNJn7TBGDOl/0Ewg=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq6/LiwR43uaQoTGWUOYhPc4kc6xBqy7oCzgazN
 Kz8vaoupmWJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCauvy4gAKCRAMdPNZecSG
 vhOID/0bH4H86tfLiDM57Xqrsk9fRaxbZV6qMizCzrP9idUR2jXGzE4PM5EhPVgj8QRag+OOtRJ
 g/YBnVRM8j9l+VsfPtlahlUGwXJ/KN1tjiRY+cNcEtp15CjAwGkAWzNxky8kcCeQb2Gl9bPt61o
 OD6E4sLtfrS2D5Ne36ZRA2VFu+GYrWNvXlrdjFAzXVLAz1N6hZrcvCe+FSWgneHCoQkZKStdJ+l
 bYY1J7/czV9zxPWMeLqrD45a9AIJYjWl38Y79BPTxS+KAE0c3jd0J2VXu4MrxgxDMiY7TKi0JOd
 qVzLtUDoX/jldB4myr7tAdP1WejI8rlB7eSCa9Ewq2GmTYZ4tXs8672Ro1Bfz8KiGAez2cXUmxX
 ZE88GT4vrXVTFVOhyOybE5rvgiheLTvWafmMD3xGS95o/lXsZ9IXFQ5dj7Bqhx+bP2sZXZZrRuS
 /2kGZK5VclvVj509Stci+ZcI7tTJQC3IP4ne8/CSlOApfNavef4Wpl+hOZgIBxuGOLIJ5W5KXSd
 wu4qXjkfZ5UshUI3Zd3ii0Ch7aGR0rGGCPooGUx2Y/Y7k27gY6ScTS9PhNsszEgr89XcBjFjTXM
 t3OiTlOHbjiAyP1lN2ZebdkWK3xHnrORCkKnKYrWHjRlEtyJ8Zw4ygK0JXylgLCIn2ZK1YqpbXz
 kjBF7lF1mG52AkA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

This is needed to calculate the system timer offset that is passed
to GSP init.

2 HALs exist:

a) tu102 is the gv100 path from open-gpu, the priv level is checked
and the cpu time is written to the gpu timer. no offset is used.

b) gh100 as two variants, gh100 and gb100.
This is the gh100 path from open-gpu, where the secure system
timer is read, the offset is calculated.
On gh100 which need a work around we avoid sending it to registers
other we write the offset to registers.
The gb100 path just avoids the war.
The value is also stored to send to GSP.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/nova-core/fsp.rs             |  5 +-
 drivers/gpu/nova-core/fsp/regs.rs        | 30 ++++++++++++
 drivers/gpu/nova-core/gpu.rs             |  8 ++++
 drivers/gpu/nova-core/nova_core.rs       |  1 +
 drivers/gpu/nova-core/timer.rs           | 33 +++++++++++++
 drivers/gpu/nova-core/timer/hal.rs       | 27 +++++++++++
 drivers/gpu/nova-core/timer/hal/gh100.rs | 79 ++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/timer/hal/tu102.rs | 53 +++++++++++++++++++++
 drivers/gpu/nova-core/timer/regs.rs      | 82 ++++++++++++++++++++++++++++++++
 9 files changed, 316 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index b738dcabcdef..222b3dbaca47 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -51,10 +51,11 @@
         NvdmType, //
     },
     num,
-    regs, //
+    regs as bootregs, //
 };
 
 mod hal;
+pub(crate) mod regs;
 
 /// PRC message sub-command.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
@@ -429,7 +430,7 @@ fn wait_secure_boot(
 
         read_poll_timeout(
             || Ok(hal.fsp_boot_status(bar)),
-            |&status| status == regs::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE_STATUS_SUCCESS,
+            |&status| status == bootregs::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE_STATUS_SUCCESS,
             Delta::from_millis(10),
             Delta::from_millis(FSP_SECURE_BOOT_TIMEOUT_MS),
         )
diff --git a/drivers/gpu/nova-core/fsp/regs.rs b/drivers/gpu/nova-core/fsp/regs.rs
new file mode 100644
index 000000000000..d4b8482a6854
--- /dev/null
+++ b/drivers/gpu/nova-core/fsp/regs.rs
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+pub(crate) mod gh100 {
+    use kernel::io::register;
+
+    use crate::{
+        driver::NovaRegisters,
+    };
+
+    // FSP PRI space; the timer is its only consumer so far.
+    register! {
+        base: NovaRegisters;
+
+        /// FSP ucode version, encoded as `major.minor` in bits 11:8 and 7:0, written by the FSP
+        /// during boot. (`NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(1)` in the hardware headers.)
+        pub(crate) NV_GFW_FSP_UCODE_VERSION(u32) @ 0x008f0334 {
+            11:0 full;
+        }
+    }
+
+    impl NV_GFW_FSP_UCODE_VERSION {
+        /// Check if the hopper only workaround is required
+        pub(crate) fn is_bug3957833_affected(self) -> bool {
+            /// FSP ucode version from which on the fix for bug 3957833 is included.
+            const FSP_BUG_3957833_FIX_VERSION: u32 = 0x44c;
+
+            self.full().get() < FSP_BUG_3957833_FIX_VERSION
+        }
+    }
+}
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4e59072cab50..99b6e33aa243 100644
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
 
+                timer: Timer::init(bar, spec.chipset)?,
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
index 000000000000..e7ad37806e5b
--- /dev/null
+++ b/drivers/gpu/nova-core/timer.rs
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+mod hal;
+mod regs;
+
+use kernel::{
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    gpu::Chipset, //
+};
+
+pub(crate) struct Timer;
+
+// struct that just holds the sys timer offset
+// after initialising the GPU timer block.
+pub(crate) struct TimerState {
+    /// This value is to be passed to GspInit SYS_TIMER_OFFSET_NS
+    /// It is considered an opaque value, passed from timer hal to GSP.
+    #[allow(dead_code)]
+    sys_timer_offset_ns: u64,
+}
+
+impl Timer {
+    /// Initialize the GPU timer.
+    pub(crate) fn init(bar: Bar0<'_>, chipset: Chipset) -> Result<TimerState> {
+        Ok(TimerState {
+            sys_timer_offset_ns: hal::timer_hal(chipset).init(bar)?,
+        })
+    }
+}
diff --git a/drivers/gpu/nova-core/timer/hal.rs b/drivers/gpu/nova-core/timer/hal.rs
new file mode 100644
index 000000000000..b78066bf9a0d
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal.rs
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::prelude::*;
+
+use crate::{
+    driver::Bar0,
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
+    /// return system timer offset ns
+    fn init(&self, bar: Bar0<'_>) -> Result<u64>;
+}
+
+pub(super) fn timer_hal(chipset: Chipset) -> &'static dyn TimerHal {
+    match chipset.arch() {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => tu102::TU102_HAL,
+        Architecture::Hopper => gh100::GH100_HAL,
+        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => gh100::GB100_HAL,
+    }
+}
diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-core/timer/hal/gh100.rs
new file mode 100644
index 000000000000..0486df588964
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::TimerHal;
+
+use kernel::{
+    io::Io,
+    prelude::*,
+    time::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    fsp::regs as fspregs,
+    timer::regs, //
+};
+
+/// Timer HAL for Hopper and Blackwell.
+struct Gh100 {
+    /// `true` on Hopper, FSP ucode on newer GPUs always has the fix.
+    fsp_bug3957833_war: bool,
+}
+
+impl Gh100 {
+    /// kfspRequiresBug3957833WAR_HAL: returns `true` if the FSP ucode predates the fix for
+    /// bug 3957833 and hence the sys timer offset must not be programmed. Can only be true
+    /// on GH100 with older FSP.
+    fn requires_bug3957833_war(&self, bar: Bar0<'_>) -> bool {
+        self.fsp_bug3957833_war
+            && bar.read(fspregs::gh100::NV_GFW_FSP_UCODE_VERSION).is_bug3957833_affected()
+    }
+
+    fn timer_time(&self, bar: Bar0<'_>, time_ns: u64) -> Result<u64> {
+        let mut sec_hi2 = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1));
+        let sec_timer_ns: u64;
+        loop {
+            let sec_lo = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_0));
+            let sec_hi = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1));
+            if sec_hi == sec_hi2 {
+                sec_timer_ns = u64::from(sec_hi) << 32 | u64::from(sec_lo);
+                break;
+            }
+            sec_hi2 = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1));
+        }
+
+        // The system and the GPU timer are both free-running with unrelated epochs, so the
+        // difference can be negative. Both operands are < 2^62, hence this cannot overflow.
+        let sys_timer_offset_ns = time_ns.checked_sub(sec_timer_ns).ok_or(EINVAL)?;
+
+        if !self.requires_bug3957833_war(bar) {
+            bar.write_reg(
+                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::try_from_nsec(sys_timer_offset_ns)?
+            );
+            bar.write_reg(
+                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::try_from_nsec(sys_timer_offset_ns)?
+                    .with_update(true),
+            );
+        }
+        Ok(sys_timer_offset_ns)
+    }
+}
+
+impl TimerHal for Gh100 {
+    fn init(&self, bar: Bar0<'_>) -> Result<u64> {
+        // The open drivers uses wall clock time here not monotonic
+        let sys_time_ns = Instant::<RealTime>::now().as_nanos();
+
+        self.timer_time(bar, sys_time_ns as u64)
+    }
+}
+
+const GH100: Gh100 = Gh100 {
+    fsp_bug3957833_war: true,
+};
+const GB100: Gh100 = Gh100 {
+    fsp_bug3957833_war: false,
+};
+
+pub(super) const GH100_HAL: &dyn TimerHal = &GH100;
+pub(super) const GB100_HAL: &dyn TimerHal = &GB100;
diff --git a/drivers/gpu/nova-core/timer/hal/tu102.rs b/drivers/gpu/nova-core/timer/hal/tu102.rs
new file mode 100644
index 000000000000..c0777b777362
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::TimerHal;
+
+use kernel::{
+    io::Io,
+    prelude::*,
+    time::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    timer::regs, //
+};
+struct Tu102;
+
+// this code will be used in the gb10b hal eventually
+#[expect(dead_code)]
+fn timer_read(bar: Bar0<'_>) -> u64 {
+    let mut hi2: u32 = u32::from(bar.read(regs::NV_PTIMER_TIME_1));
+    loop {
+        let lo = u32::from(bar.read(regs::NV_PTIMER_TIME_0));
+        let hi = u32::from(bar.read(regs::NV_PTIMER_TIME_1));
+        if hi == hi2 {
+            return u64::from(hi) << 32 | u64::from(lo);
+        }
+        hi2 = u32::from(bar.read(regs::NV_PTIMER_TIME_1));
+    }
+}
+
+fn timer_time(bar: Bar0<'_>, time_ns: u64) -> Result {
+    if bar.read(regs::NV_PTIMER_TIME_PRIV_LEVEL_MASK).level0() {
+        bar.write_reg(regs::NV_PTIMER_TIME_1::try_from_nsec(time_ns)?);
+        bar.write_reg(regs::NV_PTIMER_TIME_0::try_from_nsec(time_ns)?);
+        Ok(())
+    } else {
+        Err(EINVAL)
+    }
+}
+
+impl TimerHal for Tu102 {
+    fn init(&self, bar: Bar0<'_>) -> Result<u64> {
+        // The RM uses wall clock time here (osGetSystemTime -> ktime_get_real), so the GPU time
+        // matches the host's real time, e.g. for timestamp correlation in userspace.
+        let sys_time_ns = Instant::<RealTime>::now().as_nanos();
+
+        timer_time(bar, sys_time_ns as u64)?;
+        Ok(0_u64)
+    }
+}
+
+const TU102: Tu102 = Tu102;
+pub(super) const TU102_HAL: &dyn TimerHal = &TU102;
diff --git a/drivers/gpu/nova-core/timer/regs.rs b/drivers/gpu/nova-core/timer/regs.rs
new file mode 100644
index 000000000000..3de7174f20db
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/regs.rs
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::io::register;
+use kernel::prelude::*;
+
+use crate::{
+    driver::NovaRegisters,
+};
+use pin_init::Zeroable;
+
+// PTIMER
+
+register! {
+    base: NovaRegisters;
+
+    pub(crate) NV_PTIMER_TIME_PRIV_LEVEL_MASK(u32) @ 0x00009430 {
+        4:4 level0 => bool;
+    }
+
+    pub(crate) NV_PTIMER_TIME_0(u32) @ 0x00009400 {
+        31:5 nsec;
+    }
+
+    pub(crate) NV_PTIMER_TIME_1(u32) @ 0x00009410 {
+        28:0 nsec;
+    }
+}
+
+impl NV_PTIMER_TIME_0 {
+    pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {
+        Ok(Self::zeroed().try_with_nsec(((nsec >> 5) & 0x7FF_FFFF) as u32)?)
+    }
+}
+
+impl NV_PTIMER_TIME_1 {
+    pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {
+        Ok(Self::zeroed().try_with_nsec(((nsec >> 32) & 0x1FFF_FFFF) as u32)?)
+    }
+}
+
+pub(crate) mod gh100 {
+    use kernel::io::register;
+    use kernel::prelude::*;
+
+    use crate::driver::NovaRegisters;
+    use pin_init::Zeroable;
+
+    // PGC6/TIMER
+    register! {
+        base: NovaRegisters;
+
+        pub(crate) NV_PGC6_SCI_SEC_TIMER_TIME_0(u32) @ 0x00118f54 {
+            31:5 nsec;
+        }
+
+        pub(crate) NV_PGC6_SCI_SEC_TIMER_TIME_1(u32) @ 0x00118f58 {
+            28:0 nsec;
+        }
+
+        pub(crate) NV_PGC6_SCI_SYS_TIMER_OFFSET_0(u32) @ 0x00118df4 {
+            0:0 update;
+            31:5 nsec;
+        }
+
+        pub(crate) NV_PGC6_SCI_SYS_TIMER_OFFSET_1(u32) @ 0x00118df8 {
+            28:0 nsec;
+        }
+
+    }
+
+    impl NV_PGC6_SCI_SYS_TIMER_OFFSET_0 {
+        pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {
+            Ok(Self::zeroed().try_with_nsec(((nsec >> 5) & 0x7FF_FFFF) as u32)?)
+        }
+    }
+
+    impl NV_PGC6_SCI_SYS_TIMER_OFFSET_1 {
+        pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {
+            Ok(Self::zeroed().try_with_nsec(((nsec >> 32) & 0x1FFF_FFFF) as u32)?)
+        }
+    }
+}

-- 
2.56.0


