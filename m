Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1360606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C51DSjZi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5851210F2CF;
	Tue,  3 Nov 2026 00:34:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A7F10F2CF
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 00:33:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42FA76020A;
 Tue,  3 Nov 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793666035;
 b=daHX/olyohbim5s2zopPdqCJ06FJeWAm6vIQZaVtIdTkXbJDumYGNf8apvDQURT3IXCI
 Jyd+D4gPHJD2MA1I2skcJDqjswdpLvT2AglbeIXtXKVNsUYjpb/irdEHs5GJpoKVIRi1w
 +v0im3c7a+K6/wqDPpL2ZA3IrKDob/wDWN6AC3WktCoMbmgWFTiV2i1SlkShfb13rN0OG
 +3s9AhpUtQKcExzsorB8UR2tzW6FWi4wePCM5Jx/YJa+8qb3jsL/XNxXF63HzBetnm63s
 Uw0zBO1HOvwgeEkk1Leu1qHmoR18079i2AQkq1xoeH+dVi1XQsGqtrY1goWDHjpxfwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793666035;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=/4/0rQii2626L+VcuNSqClhW+FM6w3X/PYD/szd1NeU=;
 b=TUdU7gidfgqJC3xsiMhn8lcqe3mf1wf10oiOwEx2HciH0yLDfm1ZFA8pdoQDROHBVvnb
 pDWmvTDF1ukKuYX5KPtJR3zW6CAtUCbkwYp8My0zmNs1Cl2ICCvdWc1G65qtpZIqXCrc3
 qz1yycDpC3U6nYmVi2BmYZ1oVmO5B/E2Ze9BH297AopapkRPfLBxir8a6ahH6D1fOPgqi
 0VTqhCjjB/b5w8Mq+fiqSSBvoiRb29TtGsDWlNBgIcsvUoAAIwpxD7iEVHsPGvv8PK7PI
 LertwRBECcfFkE9A/Fn94jn/jyUptsH8AbtSqUlFWKqoKUtQbYfkeoIomz2N3gAVgLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9F44D1F00919;
 Tue,  3 Nov 2026 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793666034;
 bh=/4/0rQii2626L+VcuNSqClhW+FM6w3X/PYD/szd1NeU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=C51DSjZiezMPjyWhksEV+UuqtOdRMv3EjcP6w1/ByfWMLM1YDFW03YmLmRhNb05XS
 ljRJhWxihORldnKS35TN/8q+0kYzRqGRV2Sj+m+jXtYGlTlRdQycI1ec4KPW+Xv6xK
 6CEHmpdIREhhtNbi9tg8bbRThROhXgx/keEv1V/jVha5N2TuugRI8uEusuXIWazgOO
 Mu79D22gjh4bh5PsUMwzYSScHpshqCjMkKqL6g4Vqt7yLpe0xaILiZD9Aoo5Ip2trl
 NCqyYr8p0DIW/X1Hdc3cJnqi7kj0cAid5tTUhFw+2f925CqVkn9bVNXNLXxUtSfD0i
 0eZhL9XbsZXMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1D2B94671C;
 Tue,  3 Nov 2026 00:33:53 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Tue, 03 Nov 2026 10:33:39 +1000
Subject: [PATCH v3 2/2] gpu: nova-core: add support for GPU timer block. (v3)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nova-timer-v3-2-0cf9bbae8fd9@redhat.com>
References: <20261103-nova-timer-v3-0-0cf9bbae8fd9@redhat.com>
In-Reply-To: <20261103-nova-timer-v3-0-0cf9bbae8fd9@redhat.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11814;
 i=airlied@redhat.com; h=from:subject:message-id;
 bh=EEjj+qLLaET6ZVRs239eunBRXb25ArXuNS4q8VuvB88=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq6Svv0HFTrWhBU7FOlTo6GUa/ymDiynvSxg42L
 /hatxntFiGJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCaukr7wAKCRAMdPNZecSG
 vp85D/4gLJhtazQb+o4HGf/963EKkwUAPDKiHU+1afgTIfgM++Hm65KSGhwa818ibiSKhHczqGl
 ZWbkq/bmNwPicPWlqQNtXUJhzqu1SZQ6g/m3JO28WUDOBvBidJ7vYyLms/7mqgenycQZorEC8i8
 BpWZXANIaP1TBAUmpYkoe5iqKutCbi6zb8x4o4l5Vh+hrXoMfJLaif4Qvlxb6mMc7BoJ5yr7da0
 +1Zd3RrRVSzlBPrwDrMjD2s+6JMwbSfku2tfFoDPuphDrWbQeAMtEgQYEamJ7fwwjYCrN6dUVso
 ttyXPl3hmo/c6dcFKU/pkdP7zxjyhiCPxlUkT1QDK1mKSsRBsR4qXy+XI0hqsi+kgW80ep+gR8j
 WasujG6P8HPda8zW2kbPXL6W1EUBCid8eZek9ecqOv8/wgZtLHicETlgSn3oPNrIE1OUW0TjXcR
 35d+/LlLeFWAbugdIdTO/aa0U3MA7ZW+agFgivucseeXWUgFcHun1ueQHPEc5sNppOFaSmecDZO
 2kXkwgW2fTEbnlhf3iTwI+8WI5WcRCNii4ingG0e81BotMcTkbdT7TtH97/3AEMXCuQP1ybcLc9
 bayYDfg66JeX/rPvp4R6JT9Vyi4dF7F01o5FzeSmxciPVirJUnpIRHF2qjMj7X9bWT/6AU5/vVZ
 Utmz+0Waj6xsbuA==
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
 drivers/gpu/nova-core/gpu.rs             |  5 ++
 drivers/gpu/nova-core/nova_core.rs       |  1 +
 drivers/gpu/nova-core/timer.rs           | 33 +++++++++++
 drivers/gpu/nova-core/timer/hal.rs       | 27 +++++++++
 drivers/gpu/nova-core/timer/hal/gh100.rs | 94 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/timer/hal/tu102.rs | 55 +++++++++++++++++++
 drivers/gpu/nova-core/timer/regs.rs      | 64 ++++++++++++++++++++++
 7 files changed, 279 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4e59072cab50..b111a5b802e8 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -53,6 +53,7 @@
         GpuMm,
         VramAddress, //
     },
+    timer::Timer,
     vgpu::VgpuManager, //
 };
 
@@ -331,6 +332,8 @@ struct GspResources<'gpu> {
     // TODO: use different resource types for each boot method, and make the relevant Gsp methods
     // generic against them.
     fsp: Option<Fsp<'gpu>>,
+    /// Timer instance - contains system timer offset
+    timer: Timer,
     /// vGPU state detected before GSP boot.
     vgpu: VgpuManager,
     /// GSP runtime data.
@@ -497,6 +500,8 @@ pub(crate) fn new<'a>(
 
                 fsp: Fsp::try_new(dev, bar, spec.chipset)?,
 
+                timer: Timer::new(bar, spec.chipset)?,
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
index 000000000000..a4206076a2f0
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
+// struct that just holds the sys timer offset
+// after initialising the GPU timer block.
+pub(crate) struct Timer {
+    sys_timer_offset_ns: i64,
+}
+
+impl Timer {
+    pub(crate) fn new(bar: Bar0<'_>, chipset: Chipset) -> Result<Self> {
+        Ok(Self {
+            sys_timer_offset_ns: hal::timer_hal(chipset).init(bar)?,
+        })
+    }
+
+    // this value will be passed to GspInitRequest SYS_TIMER_OFFSET_NS
+    #[expect(dead_code)]
+    pub(crate) fn sys_timer_offset_ns(&self) -> i64 {
+        self.sys_timer_offset_ns
+    }
+}
diff --git a/drivers/gpu/nova-core/timer/hal.rs b/drivers/gpu/nova-core/timer/hal.rs
new file mode 100644
index 000000000000..fd702867b470
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
+    fn init(&self, bar: Bar0<'_>) -> Result<i64>;
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
index 000000000000..a9d46bdd2527
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
@@ -0,0 +1,94 @@
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
+
+/// Timer HAL for Hopper and Blackwell.
+struct Gh100 {
+    /// `true` on Hopper, the only architecture where the FSP ucode can predate the fix for
+    /// bug 3957833 and hence the sys timer offset must not be programmed. Blackwell FSP
+    /// always includes the fix.
+    fsp_bug3957833_war: bool,
+}
+
+/// FSP ucode version from which on the fix for bug 3957833 is included.
+const FSP_BUG_3957833_FIX_VERSION: u32 = 0x44c;
+
+impl Gh100 {
+    /// kfspRequiresBug3957833WAR_HAL: returns `true` if the FSP ucode predates the fix for
+    /// bug 3957833 and hence the sys timer offset must not be programmed. The RM implements
+    /// the version check for GH100 only; for all later chips it defaults to `false`.
+    fn requires_bug3957833_war(&self, bar: Bar0<'_>) -> bool {
+        self.fsp_bug3957833_war
+            && bar.read(regs::gh100::NV_GFW_FSP_UCODE_VERSION).full().get()
+                < FSP_BUG_3957833_FIX_VERSION
+    }
+
+    fn timer_time(&self, bar: Bar0<'_>, time_ns: i64) -> Result<i64> {
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
+        let sys_timer_offset_ns = time_ns - sec_timer_ns as i64;
+
+        // The offset is passed to the GSP as an unsigned value and, like in the RM's
+        // tmrSetCurrentTime_GH100, is required to be non-negative. With wall clock time this
+        // can only fail if the system clock is set behind the GPU power-on time.
+        if sys_timer_offset_ns < 0 {
+            return Err(EINVAL);
+        }
+
+        if !self.requires_bug3957833_war(bar) {
+            let offset_ns = sys_timer_offset_ns as u64;
+            bar.write_reg(
+                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::zeroed()
+                    .try_with_nsec(((offset_ns >> 32) & 0x1fff_ffff) as u32)?,
+            );
+            bar.write_reg(
+                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::zeroed()
+                    .try_with_nsec(((offset_ns >> 5) & 0x7ff_ffff) as u32)?
+                    .with_update(true),
+            );
+        }
+        Ok(sys_timer_offset_ns)
+    }
+}
+
+impl TimerHal for Gh100 {
+    fn init(&self, bar: Bar0<'_>) -> Result<i64> {
+        // The open drivers uses wall clock time here not monotonic
+        let sys_time_ns = Instant::<RealTime>::now().as_nanos();
+
+        self.timer_time(bar, sys_time_ns)
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
index 000000000000..b8f9743da9db
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
@@ -0,0 +1,55 @@
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
+        bar.write_reg(regs::NV_PTIMER_TIME_1::zeroed().try_with_nsec(((time_ns >> 32) & 0x1fff_ffff) as u32)?);
+        bar.write_reg(
+            regs::NV_PTIMER_TIME_0::zeroed().try_with_nsec(((time_ns >> 5) & 0x7ff_ffff) as u32)?,
+        );
+        Ok(())
+    } else {
+        Err(EINVAL)
+    }
+}
+
+impl TimerHal for Tu102 {
+    fn init(&self, bar: Bar0<'_>) -> Result<i64> {
+        // The RM uses wall clock time here (osGetSystemTime -> ktime_get_real), so the GPU time
+        // matches the host's real time, e.g. for timestamp correlation in userspace.
+        let sys_time_ns = Instant::<RealTime>::now().as_nanos();
+
+        timer_time(bar, sys_time_ns as u64)?;
+        Ok(0_i64)
+    }
+}
+
+const TU102: Tu102 = Tu102;
+pub(super) const TU102_HAL: &dyn TimerHal = &TU102;
diff --git a/drivers/gpu/nova-core/timer/regs.rs b/drivers/gpu/nova-core/timer/regs.rs
new file mode 100644
index 000000000000..04549c761fb0
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/regs.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::io::register;
+
+use crate::{
+    driver::NovaRegisters,
+};
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
+pub(crate) mod gh100 {
+    use kernel::io::register;
+
+    use crate::driver::NovaRegisters;
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
+    }
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
+}

-- 
2.56.0


