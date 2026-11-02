Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD36606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwSeYSCo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1206510E56B;
	Mon,  2 Nov 2026 07:17:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347C510E587
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:17:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BC7D4358B;
 Mon,  2 Nov 2026 07:17:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793603873;
 b=kicbau72Kvoq+ATHAwaneoK53VF/Ig0VQBKpViUo+gqVfi7TyWbc9pp7z292KOSRFqYQ
 4sK/EPI66zj4OTPMTnIH1igqOelNHwn9pC0vdRCrYD7tytmIKQhRefR4d4a3nCcTam7Y5
 XGPnfq0MxHjLgzvCBgxZ0stbmR3ih0nCEMSGXMPgOZHHopONsfEwKN/1frzMGinK8PaTS
 w97zlEmCtLRiPBdsItKtqjirmJIkWdQ+gIHYRAbf2+DJoTL2SMS95mQT+gFeeYqA+ZvbK
 n+PSStnRykOTkgZunbWXs4mB+HCNkTyW22QBeIKAzI5j/Jf6r8mXiTy1IoblDqKsbyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793603873;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=63lp+XJ6QNFYpOaOeAh0c0ncn8Wmf7KGyBgEW+y8gpM=;
 b=J6ljO8uSYCEqT7t/1aWISaLd1nQMGRPq20MpHKdEN5wToOPMxfSWTEnooAporLCGLnb4
 F9yza/B3oPS2srzkOkt9NH2QgAVsqwJcSOAe3NJHBYxTx3/7pyriG/xVUt2J225yoGB35
 fd39Gm8l5l0+XwzBnyRCz1n7aIG/Fgnme2O/BWlZ71IfaRIDp7GI3A7cgQHekJ/upeDmm
 CJQXH3QvXyYhgd+NgyVMbnQF6SPYb8c3JAB3qPzxK3CWoD6MQfpdY86zhavDdB/nhOcjE
 2kNwFRjXtH5vejK7bkFmMByvQ4S4ICF++qZLv0fwej3zR2tIZEoIGjWspqK8J733bmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A67261F00919;
 Mon,  2 Nov 2026 07:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793603872;
 bh=63lp+XJ6QNFYpOaOeAh0c0ncn8Wmf7KGyBgEW+y8gpM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=QwSeYSCo7uiWctdSjCd8clzjbiJlYxiaTeSIyC0oja8JbA0DDd61gKgFp9jwUVMv0
 iv56aeP4lD1V1rLY/DdoKb3IkycFKJ5TWOjhvaXli2f4mgOH1QwBbpbuDYVit7BYZY
 PbuFGKzuiBHYHUxGV3AEIgkHZDPFKf2cK9LCbBbzg2L1PPX5C8CW7OWg/yW7zIb3O/
 7DQZQ0HJqty9/JI6goFKr6yufA2Fsfe8oNdCfFVZQm3mut9MR5kszt6U6tAsKzSG2G
 /gnQ1mLxnbIcOasg1noWZc1Yy61YOLQLSNWIVJFdw04GJmNkawEKmmIqnFmqMRKE0q
 8dw2gLbAVh4KQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2875F463E3;
 Mon,  2 Nov 2026 07:17:51 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Mon, 02 Nov 2026 17:17:41 +1000
Subject: [PATCH 2/2] gpu: nova-core: add support for GPU timer block. (v2)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-nova-timer-v1-2-b347ead64469@redhat.com>
References: <20261102-nova-timer-v1-0-b347ead64469@redhat.com>
In-Reply-To: <20261102-nova-timer-v1-0-b347ead64469@redhat.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11235;
 i=airlied@redhat.com; h=from:subject:message-id;
 bh=WBZP5vxmZUj2MzrDrzerLRN8YeFDWdRG38lhGXIdpuU=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq6Dkd9o1ZN+UiTNgXxViBG8ly4xydrdHKtvI4X
 NLS6YfjwemJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCaug5HQAKCRAMdPNZecSG
 vv5OEACXskFd25WKY9hZUoqEC6/8eVDDFQjnMgX6qYOCcBP99ulj8vSPMky03e1ym4g/Tstrwze
 9Te+APQp/8Av1bp/pvr7q3e0+46ewpgmtwA6dmfMNYkuQbiF14TX1Y+en+j1YcEgMAGdrjCXuqQ
 kvtj/fdLcju5H2c721AJ9To+4bNApwsLsjZNbiHvZVLdsrC1EXA3QupNIA1y1oYBZ5yed04YEJN
 RfUdMWu8fL38xKiIT7u9YtQca7Qg7dQrkYTtdKUsyzREJbMiCnuQ+P2bEr0lPziAMYtIlfQmi4L
 rjkv55ufJHfI4pTOxOwQYq1gqtoFkV1+1w2xJ91pLUpHEYb0k7yWZkQccUPuKmXn/+AT6dEP1q4
 xXLT9504KqYFsMYcqVo/5RjpHa1RrkIYGzr82Ipt7Ks+wh0Jn6bmQIYcMxOZPds/yhhMBgj0ypm
 TGrIMifUIxYfESSScMzZtJPkw0Fp88eR9pvWu6BWsH76mzZe+IKasoIYYH1mV7gsWSIrFJguEOd
 2I7RbhMHDREOlZhRy0UObjPtBYcZJvBCcWeCb6imjJYUnTx6KfPCfKo5GHwGjo6/TXq3DKPMY82
 pK/nLdJom8rJGKzajjYHahtFTz82Rs/NLyfYaHXFv91y9+YfFw/WbYxu2uMQTZ8uso/IcV5kMOr
 f35iKjyYWnJnLZw==
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

b) gh100 is the gh100 path from open-gpu, where the secure system
timer is read, the offset is calculated and on everything where it
works the offset gets written to secure registers, and also
sent to GSP.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
v2: kill the read API for now, it would be internal to the timer
    as we just want to read once at startup on gb10b.
    Drop the cpu timer wrapper.
    don't store chipset and remove the pin stuff
    Move registers into timer.
    add support for GH100 WAR properly
    do i64 calcs to avoid overflow and copy RM code closer.
---
 drivers/gpu/nova-core/gpu.rs             |  5 +++
 drivers/gpu/nova-core/nova_core.rs       |  1 +
 drivers/gpu/nova-core/timer.rs           | 33 ++++++++++++++
 drivers/gpu/nova-core/timer/hal.rs       | 28 ++++++++++++
 drivers/gpu/nova-core/timer/hal/gh100.rs | 76 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/timer/hal/tu102.rs | 56 +++++++++++++++++++++++
 drivers/gpu/nova-core/timer/regs.rs      | 64 +++++++++++++++++++++++++++
 7 files changed, 263 insertions(+)

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
index 000000000000..7aeff6cdc678
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal.rs
@@ -0,0 +1,28 @@
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
+        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+            gh100::GH100_HAL
+        }
+    }
+}
diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-core/timer/hal/gh100.rs
new file mode 100644
index 000000000000..7f55bf04a3f3
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
@@ -0,0 +1,76 @@
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
+struct Gh100;
+
+/// FSP ucode version from which on the fix for bug 3957833 is included.
+const FSP_BUG_3957833_FIX_VERSION: u32 = 0x44c;
+
+/// kfspRequiresBug3957833WAR_HAL: returns `true` if the FSP ucode predates the fix for bug
+/// 3957833 and hence the sys timer offset must not be programmed.
+fn fsp_requires_bug3957833_war(bar: Bar0<'_>) -> bool {
+    bar.read(regs::gh100::NV_GFW_FSP_UCODE_VERSION).full().get() < FSP_BUG_3957833_FIX_VERSION
+}
+
+fn timer_time(bar: Bar0<'_>, time_ns: i64) -> Result<i64> {
+    let mut sec_hi2 = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1));
+    let sec_timer_ns: u64;
+    loop {
+        let sec_lo = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_0));
+        let sec_hi = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1));
+        if sec_hi == sec_hi2 {
+            sec_timer_ns = u64::from(sec_hi) << 32 | u64::from(sec_lo);
+            break;
+        }
+        sec_hi2 = u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_TIMER_TIME_1));
+    }
+
+    // The system and the GPU timer are both free-running with unrelated epochs, so the
+    // difference can be negative. Both operands are < 2^62, hence this cannot overflow.
+    let sys_timer_offset_ns = time_ns - sec_timer_ns as i64;
+
+    // The offset is passed to the GSP as an unsigned value and, like in the RM's
+    // tmrSetCurrentTime_GH100, is required to be non-negative. With wall clock time this can
+    // only fail if the system clock is set behind the GPU power-on time.
+    if sys_timer_offset_ns < 0 {
+        return Err(EINVAL);
+    }
+
+    if !fsp_requires_bug3957833_war(bar) {
+        let offset_ns = sys_timer_offset_ns as u64;
+        bar.write_reg(
+            regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::zeroed()
+                .try_with_nsec(((offset_ns >> 32) & 0x1fff_ffff) as u32)?,
+        );
+        bar.write_reg(
+            regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::zeroed()
+                .try_with_nsec(((offset_ns >> 5) & 0x7ff_ffff) as u32)?
+                .with_update(true),
+        );
+    }
+    Ok(sys_timer_offset_ns)
+}
+
+impl TimerHal for Gh100 {
+    fn init(&self, bar: Bar0<'_>) -> Result<i64> {
+        // The open drivers uses wall clock time here not monotonic
+        let sys_time_ns = Instant::<RealTime>::now().as_nanos();
+
+        timer_time(bar, sys_time_ns)
+    }
+}
+
+const GH100: Gh100 = Gh100;
+pub(super) const GH100_HAL: &dyn TimerHal = &GH100;
diff --git a/drivers/gpu/nova-core/timer/hal/tu102.rs b/drivers/gpu/nova-core/timer/hal/tu102.rs
new file mode 100644
index 000000000000..80f26a152065
--- /dev/null
+++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
@@ -0,0 +1,56 @@
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
+        bar.write_reg(
+            regs::NV_PTIMER_TIME_1::zeroed().try_with_nsec(((time_ns >> 32) & 0x1fff_ffff) as u32)?);
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


