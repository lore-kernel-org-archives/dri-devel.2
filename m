Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF50BC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E3410EEDB;
	Wed, 23 Sep 2026 01:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uBLqApIm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66F010EED5
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:09:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 345E1601FB;
 Wed, 23 Sep 2026 01:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F45C2BCF7;
 Wed, 23 Sep 2026 01:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790125781;
 bh=CvfRrKpZTcHB5jRS2Duv9lBazt2hF+1T964SNs2XGiM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=uBLqApImwL49JB7XnZdTh1RJgCd+v5oz2Iu1wtPrWpLJt/Wfbep71+z5WELxLrDiF
 NURUXjkMlDCSu6fgOZu/5Ui+e0+inxDD2c+94XhJg2qiQzn7EkSdFTBYQiQ+UXw95w
 V9A6c2w5gpQ1SKjShH44PKv6x7fIlv9EJ//7t1Q8ZpbQZ2wVNumo8heDLcYnQhHtan
 ncmX0NJeH4gB350j6meTAlBiwRisViHKFLI25CYZKZ9O+s6aTA0QuKZ2lF+j7eApjy
 OYgVLaWwj12iHk+PW1TxzTM0Dll4f25pWG9E629mRW4iwcrYcesbqxVok/IxQBeA3y
 MuuUSMW1KazRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B977FC98304;
 Wed, 23 Sep 2026 01:09:41 +0000 (UTC)
From: Antonin Malzieu Ridolfi via B4 Relay <devnull+dev.nanonej.com@kernel.org>
Date: Wed, 23 Sep 2026 03:09:26 +0200
Subject: [PATCH v3 2/4] gpu: nova-core: falcon: Extract PRISCV register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v3-2-cd26aa94c021@nanonej.com>
References: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v3-0-cd26aa94c021@nanonej.com>
In-Reply-To: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v3-0-cd26aa94c021@nanonej.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Antonin Malzieu Ridolfi <dev@nanonej.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7363; i=dev@nanonej.com;
 h=from:subject:message-id;
 bh=S7/kLSzN8N8I4ryirTYlHrFZoP6XWMLUmNrF0K94Oe8=;
 b=owEBbQKS/ZANAwAKAWaH8SMKFRX9AcsmYgBqsybTtQWzQd1MWTnx4W6l7vQjmskThQ1g9sI24
 iFPzZwq1KWJAjMEAAEKAB0WIQSDtk+wfJEhL1KFIn1mh/EjChUV/QUCarMm0wAKCRBmh/EjChUV
 /W8cD/9WIYzM/7VIyEuBTY4DPJsbqv6YQg2nGS11UXkd+vNsuFes6D+2uTDZWj+7nMfbOWcUVr3
 WPEAdeQVPFJz0RJmTFiEIc7FYGs5tRguafLr5vPQyC6zXx6KBwPRnL4dXsWjIugZcKR4e3seMSN
 KqbEiqQuztEH2KSNnyhEiDXVWiPLWjILNgpZympayXuAEjhKCs3wATgUHUveKeh44NT1Np36xc/
 YXFfCKQi005UOnTLChn+yS4CEdGCt/BUPAc3ptqTHO1J3iPDK87OqHJku8PUS6MoVRWJxNwONmP
 XBiMXR+Vfh37LVX0+IBvwLHHu4I+bvpSGrQXOU7R0ArnbMQXGAY3KDaxBvQWM8sqoAbl/7K/0o9
 fsz2mkgMXKC21EntT4mip2yFMD9z2FVYe5WemRkjYfueyVAdU2YPrnUdPc6bJLminZpwtLcwDAf
 zKxI2e0J7iDnVpjzTMD9LqBAOHZTwqUfD9gd1QHenbh0LlM1G33eu6MBguXmwFjUadCLQl6Pal5
 iglVLbiVBmhgd8QSnaLgyyIc4Q4UL3j14CvCKmKY19NWg525zNjMC7cME70rjM3klWRNxix3Gdb
 FbLor2PhNS3KItDaKNQOivlyJQ5gSTyuLmibzR+soZw5soKMwZxVHXQEQ2ST2OeWTpqPdLEDRtR
 HqGcrMzgMRWrFNQ==
X-Developer-Key: i=dev@nanonej.com; a=openpgp;
 fpr=83B64FB07C91212F5285227D6687F1230A1515FD
X-Endpoint-Received: by B4 Relay for dev@nanonej.com/default with auth_id=825
X-Original-From: Antonin Malzieu Ridolfi <dev@nanonej.com>
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
Reply-To: dev@nanonej.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Antonin Malzieu Ridolfi <dev@nanonej.com>

Move PRISCV register definitions from the root regs.rs file into the
falcon module that own them, in the existing falcon/regs.rs file.

This follows the same pattern established by previous commits for
GSP, PDISP, PFB, PBUS, PMC and PFSP registers: register definitions
move to the module that interprets their service, visibility changes
to pub(super).

Since PFALCON, PFALCON2 and FUSE registers are defined in the root
regs.rs but are also part of the falcon interface, accessed by the
whole falcon module, they are re-exported in falcon/regs.rs so falcon
code can use a single regs:: prefix.
Once these families moves out of the root module, these re-exports
will become plain definitions.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
---
 drivers/gpu/nova-core/falcon/hal/ga102.rs |  2 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs | 12 +++----
 drivers/gpu/nova-core/falcon/regs.rs      | 58 +++++++++++++++++++++++++------
 drivers/gpu/nova-core/regs.rs             | 29 +---------------
 4 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index f9a8444cf840..7323579a478d 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -18,6 +18,7 @@
     driver::Bar0,
     falcon::{
         hal::LoadMethod,
+        regs, //
         Falcon,
         FalconBromParams,
         FalconEngine,
@@ -25,7 +26,6 @@
         PFalcon2Registers,
         PeregrineCoreSelect, //
     },
-    regs,
 };
 
 use super::FalconHal;
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index 7fc6e83c2566..068258c69fd9 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -11,14 +11,12 @@
     time::Delta, //
 };
 
-use crate::{
-    falcon::{
-        hal::LoadMethod,
-        Falcon,
-        FalconBromParams,
-        FalconEngine, //
-    },
+use crate::falcon::{
+    hal::LoadMethod,
     regs, //
+    Falcon,
+    FalconBromParams,
+    FalconEngine,
 };
 
 use super::FalconHal;
diff --git a/drivers/gpu/nova-core/falcon/regs.rs b/drivers/gpu/nova-core/falcon/regs.rs
index 336f065929db..ac4a02405927 100644
--- a/drivers/gpu/nova-core/falcon/regs.rs
+++ b/drivers/gpu/nova-core/falcon/regs.rs
@@ -3,6 +3,37 @@
 use crate::driver::NovaRegisters;
 use kernel::io::register;
 
+use crate::falcon::{
+    PFalcon2Registers,
+    PeregrineCoreSelect, //
+};
+
+// PRISCV
+
+register! {
+    base: PFalcon2Registers;
+
+    /// RISC-V status register for debug (Turing and GA100 only).
+    /// Reflects current RISC-V core status.
+    pub(super) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ 0x00000240 {
+        /// RISC-V core active/inactive status.
+        0:0     active_stat => bool;
+    }
+
+    /// GA102 and later.
+    pub(super) NV_PRISCV_RISCV_CPUCTL(u32) @ 0x00000388 {
+        7:7     active_stat => bool;
+        4:4     halted => bool;
+    }
+
+    /// GA102 and later.
+    pub(super) NV_PRISCV_RISCV_BCR_CTRL(u32) @ 0x00000668 {
+        8:8     br_fetch => bool;
+        4:4     core_select => PeregrineCoreSelect;
+        0:0     valid => bool;
+    }
+}
+
 // FSP (Foundation Security Processor) queue registers for Hopper/Blackwell Chain of Trust.
 // These registers manage falcon EMEM communication queues.
 
@@ -26,17 +57,22 @@
     }
 }
 
-// PFALCON registers are defined in the root `regs.rs` but are part of the falcon
-// interface, accessed by the whole falcon module. They are re-exported here so
-// falcon code can use a single `regs::` prefix.
-// Once the PFALCON family moves out of the root module, these re-exports become
+// PFALCON, PFALCON2 and FUSE registers are defined in the root `regs.rs` but
+// are part of the falcon interface, accessed by the whole falcon module. They
+// are re-exported here so falcon code can use a single `regs::` prefix.
+// Once these families move out of the root module, these re-exports become
 // plain definitions.
 pub(super) use crate::regs::{
-    NV_PFALCON_FALCON_BOOTVEC, NV_PFALCON_FALCON_CPUCTL, NV_PFALCON_FALCON_CPUCTL_ALIAS,
-    NV_PFALCON_FALCON_DMACTL, NV_PFALCON_FALCON_DMATRFBASE, NV_PFALCON_FALCON_DMATRFBASE1,
-    NV_PFALCON_FALCON_DMATRFCMD, NV_PFALCON_FALCON_DMATRFFBOFFS, NV_PFALCON_FALCON_DMATRFMOFFS,
-    NV_PFALCON_FALCON_DMEMC, NV_PFALCON_FALCON_DMEMD, NV_PFALCON_FALCON_EMEMC,
-    NV_PFALCON_FALCON_EMEMD, NV_PFALCON_FALCON_IMEMC, NV_PFALCON_FALCON_IMEMD,
-    NV_PFALCON_FALCON_IMEMT, NV_PFALCON_FALCON_MAILBOX0, NV_PFALCON_FALCON_MAILBOX1,
-    NV_PFALCON_FALCON_OS, NV_PFALCON_FALCON_RM, NV_PFALCON_FBIF_CTL, NV_PFALCON_FBIF_TRANSCFG,
+    NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION, NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION,
+    NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION, NV_FUSE_OPT_FPF_SIZE,
+    NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID, NV_PFALCON2_FALCON_BROM_ENGIDMASK,
+    NV_PFALCON2_FALCON_BROM_PARAADDR, NV_PFALCON2_FALCON_MOD_SEL, NV_PFALCON_FALCON_BOOTVEC,
+    NV_PFALCON_FALCON_CPUCTL, NV_PFALCON_FALCON_CPUCTL_ALIAS, NV_PFALCON_FALCON_DMACTL,
+    NV_PFALCON_FALCON_DMATRFBASE, NV_PFALCON_FALCON_DMATRFBASE1, NV_PFALCON_FALCON_DMATRFCMD,
+    NV_PFALCON_FALCON_DMATRFFBOFFS, NV_PFALCON_FALCON_DMATRFMOFFS, NV_PFALCON_FALCON_DMEMC,
+    NV_PFALCON_FALCON_DMEMD, NV_PFALCON_FALCON_EMEMC, NV_PFALCON_FALCON_EMEMD,
+    NV_PFALCON_FALCON_ENGINE, NV_PFALCON_FALCON_HWCFG2, NV_PFALCON_FALCON_IMEMC,
+    NV_PFALCON_FALCON_IMEMD, NV_PFALCON_FALCON_IMEMT, NV_PFALCON_FALCON_MAILBOX0,
+    NV_PFALCON_FALCON_MAILBOX1, NV_PFALCON_FALCON_OS, NV_PFALCON_FALCON_RM, NV_PFALCON_FBIF_CTL,
+    NV_PFALCON_FBIF_TRANSCFG,
 };
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 693b5148b1d8..0a168b53236d 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -24,8 +24,7 @@
         FalconModSelAlgo,
         FalconSecurityModel,
         PFalcon2Registers,
-        PFalconRegisters,
-        PeregrineCoreSelect, //
+        PFalconRegisters, //
     },
     mm::tlb::TlbAckMode, //
 };
@@ -346,32 +345,6 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
     }
 }
 
-// PRISCV
-
-register! {
-    base: PFalcon2Registers;
-
-    /// RISC-V status register for debug (Turing and GA100 only).
-    /// Reflects current RISC-V core status.
-    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ 0x00000240 {
-        /// RISC-V core active/inactive status.
-        0:0     active_stat => bool;
-    }
-
-    /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ 0x00000388 {
-        7:7     active_stat => bool;
-        4:4     halted => bool;
-    }
-
-    /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ 0x00000668 {
-        8:8     br_fetch => bool;
-        4:4     core_select => PeregrineCoreSelect;
-        0:0     valid => bool;
-    }
-}
-
 // The modules below provide registers that are not identical on all supported chips. They should
 // only be used in HAL modules.
 

-- 
2.55.0


