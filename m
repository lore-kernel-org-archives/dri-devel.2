Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CF606A69E
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ixJZ0xNp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2DE112E84;
	Sat, 28 Nov 2026 02:16:43 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEE3112E84
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795832182; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X8yEMB+wvpxI3VrBYpoJe2ZRgmRdDSdMAP1Nr+bjjjbFW4zpof5NvyjSrMjOvKHwMPKp8pcPVmrP1Bk5g3ob5t8i64KbDmWD7s8Oy17fgBMx9srVCt3HyQlT6DhEIHz3J1KCuLuqt0ZqudcA4p0tvtUwMGxJkTe2O2tv3b2Kxac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795832182;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CrTCLZ93hwlX4ZwQ1q5UNKsWy1SPOSh5fzNi1ZAOwGE=; 
 b=Z2hfTT89Oc3laWYrEnu+2Mou34nq1R4FCmGRBGRUGPWZ5shi5BaCttHlJGVcEH2MWTfrhC0D5tFGYbkGKvskItOeHO9YYFQw4b1n1Je/zRk8dP7Ysx7UG0Siuq/z2Z5eaisM8ZkNlROjS94Khgh3oTq0tH6BqEukxnFOmXnuQWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=ixJZ0xNpez6JeL+sbt4cY2W5L23TpV8LxNSXI5f95yoGkqFYn36QrX7X4ONLCWk/+lKapZ7kQna3PjEofJ57qwavOA/uq0eo5I9koDwedhYhj0elVDqClvhL3rE0ZuAekVl59EFn38jVFSttrX6VYNHOfoiumNVxZIDOMqRCDBE=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=CrTCLZ93hwlX4ZwQ1q5UNKsWy1SPOSh5fzNi1ZAOwGE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795832181076365.8936751268392;
 Fri, 27 Nov 2026 18:16:21 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 23:15:46 -0300
Subject: [PATCH 9/9] drm/tyr: disable an address space that faults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-mmu-irq-v1-9-2fcb9f9465cd@collabora.com>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When an address space reports a page fault, the mmu IRQ handler logs the
fault and masks its page-fault interrupt, but the address space stays
mapped.

Switch the faulting address space to UNMAPPED from the handler, so that
every later access through it fails, like panthor does. Do it in place
rather than evicting the VM: the VM keeps its slot, so the slot is not
handed to another VM while the firmware or a command stream group (when
implemented) may still use it by number. This matches panthor, which
keeps ptdev->mmu->as.slots[as].vm and vm->as.id set when an address
space faults.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs            |  2 +-
 drivers/gpu/drm/tyr/mmu/address_space.rs |  2 +-
 drivers/gpu/drm/tyr/mmu/irq.rs           | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c88fc5194dc2..6b2dcef3e2df 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -165,7 +165,7 @@ fn probe<'bound>(
 
             // SAFETY: The registration ends up in `TyrDrmRegistrationData`, which `_reg`
             // drops at unbind, and every error path before that drops it.
-            let mmu_irq = unsafe { mmu_irq_init(pdev, hw.clone(), &gpu_info) }?;
+            let mmu_irq = unsafe { mmu_irq_init(pdev, hw.clone(), &gpu_info, mmu.clone()) }?;
 
             // SAFETY: The registration ends up in `TyrDrmRegistrationData`, which `_reg`
             // drops at unbind, and every error path before that drops it.
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index fa4c26a6eb12..6af45887ec61 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -309,7 +309,7 @@ fn as_enable(
     /// Disables an AS slot, clears its configuration and flushes the L2 and load/store caches.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_disable(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
+    pub(super) fn as_disable(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
 
         // Release any pending LOCK before disabling the address space.
diff --git a/drivers/gpu/drm/tyr/mmu/irq.rs b/drivers/gpu/drm/tyr/mmu/irq.rs
index 53ff1b2151ee..d2cc76becd1e 100644
--- a/drivers/gpu/drm/tyr/mmu/irq.rs
+++ b/drivers/gpu/drm/tyr/mmu/irq.rs
@@ -32,6 +32,7 @@
         TyrIrqRegistration,
         TyrIrqTrait, //
     },
+    mmu::Mmu,
     regs::{
         gpu_control::AS_PRESENT,
         join_u64,
@@ -56,6 +57,8 @@ pub(crate) struct MmuIrq<'a> {
     dev: &'a Device<Bound>,
     /// Shared gate that coordinates hardware access with GPU reset.
     hw: Arc<HwGate<'a>>,
+    /// MMU, used to disable the address spaces that fault.
+    mmu: Arc<Mmu<'a>>,
     /// Interrupt sources to unmask: the page-fault bit of each present address
     /// space that has not faulted yet.
     mask: Atomic<u32>,
@@ -71,11 +74,13 @@ pub(crate) unsafe fn mmu_irq_init<'a>(
     pdev: &'a platform::Device<Bound>,
     hw: Arc<HwGate<'a>>,
     gpu_info: &GpuInfo,
+    mmu: Arc<Mmu<'a>>,
 ) -> Result<Pin<KBox<TyrIrqRegistration<'a, MmuIrq<'a>>>>> {
     let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
     let mmu_irq = MmuIrq {
         dev: pdev.as_ref(),
         hw: hw.clone(),
+        mmu,
         mask: Atomic::new(IRQ_MASK::zeroed().try_with_page_fault(present)?.into_raw()),
     };
     // Ensure interrupt sources are disabled until the handler is registered.
@@ -146,6 +151,8 @@ fn mask(&self) -> u32 {
 
     fn handle(&self, status: u32) {
         let faults = IRQ_RAWSTAT::from_raw(status).page_fault();
+
+        let mut as_manager = self.mmu.as_manager.lock();
         let hw_guard = self.hw.access();
         let io = hw_guard.iomem();
 
@@ -156,6 +163,9 @@ fn handle(&self, status: u32) {
             pending &= pending - 1;
 
             let _ = self.report_fault(io, as_nr);
+            if let Err(e) = as_manager.as_disable(io, as_nr) {
+                dev_err!(self.dev, "Failed to disable AS{}: {:?}\n", as_nr, e);
+            }
         }
 
         // Nothing resolves these faults yet, and an address space that faulted

-- 
2.56.0

