Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3466FCD98ED
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 23:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3C010E8D8;
	Tue, 16 Jun 2026 23:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pksa7c9K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD63610E8C2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 23:48:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 35F1041B48;
 Tue, 16 Jun 2026 23:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01999C4AF16;
 Tue, 16 Jun 2026 23:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781653707;
 bh=zfhfPOr9h8jdTEAdspJagZiy7tE5gMuPbgv+0LGLlFA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=pksa7c9KnALUQ2Y5EARrBw3Bi75jdh9o/Z8R6/0TxbE45Ds9gOi7C9TK7r/b0Lhf/
 aIM3HrWq0yF2Q5ybK3azQOvXYeAiJnM5bgt1lq1kVX/uiNav6s1B/MPDhoyJMc8LFQ
 2I5ayOS2sMuE9s8iZB+LYlMbk/iqBkOK/4Bn6Xb4Bnmu1ncrXMnw6u6buQSvTeMuBJ
 3Qc027P8AmBAbEvW6Vu6P8tiPsDEcqTE7jkKKkCQJpzlCl+XWQ+CEGMVTHxxAePYC6
 3vLnSEK7ipwcMq62dCSvmqq6YUe91avIp93AmfT4j8HQ3dDP0xXt06f0P6ylGvZNzO
 61en1jluzAA9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EED3ECD98F0;
 Tue, 16 Jun 2026 23:48:26 +0000 (UTC)
From: Antonin Malzieu Ridolfi via B4 Relay <devnull+dev.nanonej.com@kernel.org>
Date: Wed, 17 Jun 2026 01:48:16 +0200
Subject: [PATCH 5/5] gpu: nova-core: falcon: Move PFSP register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-nova-core-regs-split-v1-5-4c7dc4450ea7@nanonej.com>
References: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
In-Reply-To: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Antonin Malzieu Ridolfi <dev@nanonej.com>
Cc: linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, daniel.almeida@collabora.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4371; i=dev@nanonej.com;
 h=from:subject:message-id;
 bh=e+RPTcJ/xqY9sHKEN1ysB3kpbYR3hnWcV9YH6i5vuxU=;
 b=owEBbQKS/ZANAwAKAWaH8SMKFRX9AcsmYgBqMeDJ4E5hAWmWx4y3VvMopq0DVgL/2pcl9FH29
 pnFkkAGyDKJAjMEAAEKAB0WIQSDtk+wfJEhL1KFIn1mh/EjChUV/QUCajHgyQAKCRBmh/EjChUV
 /WflD/9MiIELe1VPjb4tX9A/cmkMlc8bmGDZTnTFXaPhCqJ2oZHQrg0e8fl2/etB4aSdDfuNaHq
 lRMAVOHR0qPlGnonBJjMpEUbsszD0dG9ljDztVPxK3l37+P9qTFqwEfQecv9fYZqAqmvk2aCBFA
 VQPysLVNZY5g06eDg5WYXAVAvpFzUxfCaO3Be6kX8DtNIrvzy+pWXWwpHwlqIXbH67Fs9b0w1QH
 bW07HRiuSDSSd2JtyuNuIDHvIk9MbsAlBjIw6QluvcsFfZ/WfN8bfbSKLxolTLT0Yi/sg+9ULwI
 l/TEih/M0pSM2mlW6qwVfjtP5k+smb4SVlMGwi7dqg/XIoqwnKbGSRptuZamvX9cPRw4GqoYRjl
 kp+XRqdSyp4+S4GQj6sKmtNOktPfru4QsDh6Zt9adxuNT7naC17AsuJ1NlVl2QCWjfPhN5rHKMq
 ztVZNgQcXE+jZK6u2pnizlzPib1TIYPQIDZpfzUC+GaazC74EnJr4Dmr6ZA10NwJ9yyLETaaHuA
 PBLcIPE69xA5S2eE1ve6+M5vv0rg2CXhgzWFbCP8YnWBZ+nBMfzYLjSVeIkqi287oODs3fgPqyW
 MXE/n24lBcU6T/zab3VyK7s50U5fYLzw4bsbdd3F5opurpYRmPbZu7v+Bj1wKFSlF7Sgu8NjBuz
 Vi9E4730HtMp3HA==
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

Move PFSP register definition into falcon module and update registers
visibility.

Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs  | 14 +++++++-------
 drivers/gpu/nova-core/falcon/regs.rs | 21 +++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs        | 21 ---------------------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 52cdb84ef0e8..547843e6483c 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -26,10 +26,10 @@
         Falcon,
         FalconEngine,
         PFalcon2Base,
-        PFalconBase, //
+        PFalconBase,
+        regs, //
     },
-    num,
-    regs, //
+    num, //
 };
 
 /// FSP message timeout in milliseconds.
@@ -61,7 +61,7 @@ fn write_emem(&mut self, bar: Bar0<'_>, data: &[u8]) -> Result {
         // Begin a write burst at offset `0`, auto-incrementing on each write.
         bar.write(
             WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true),
+            crate::regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true),
         );
 
         for chunk in data.chunks_exact(4) {
@@ -70,7 +70,7 @@ fn write_emem(&mut self, bar: Bar0<'_>, data: &[u8]) -> Result {
             // Write the next 32-bit `value`; hardware advances the offset.
             bar.write(
                 WithBase::of::<Fsp>(),
-                regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value),
+                crate::regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value),
             );
         }
 
@@ -89,12 +89,12 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &mut [u8]) -> Result {
         // Begin a read burst at offset `0`, auto-incrementing on each read.
         bar.write(
             WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true),
+            crate::regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true),
         );
 
         for chunk in data.chunks_exact_mut(4) {
             // Read the next 32-bit word; hardware advances the offset.
-            let value = bar.read(regs::NV_PFALCON_FALCON_EMEMD::of::<Fsp>()).data();
+            let value = bar.read(crate::regs::NV_PFALCON_FALCON_EMEMD::of::<Fsp>()).data();
             chunk.copy_from_slice(&value.to_le_bytes());
         }
 
diff --git a/drivers/gpu/nova-core/falcon/regs.rs b/drivers/gpu/nova-core/falcon/regs.rs
index 4d4e69b235fc..81530abfb54c 100644
--- a/drivers/gpu/nova-core/falcon/regs.rs
+++ b/drivers/gpu/nova-core/falcon/regs.rs
@@ -53,3 +53,24 @@
         0:0     valid => bool;
     }
 }
+
+// FSP (Foundation Security Processor) queue registers for Hopper/Blackwell Chain of Trust.
+// These registers manage falcon EMEM communication queues.
+
+register! {
+    pub(super) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {
+        31:0    address => u32;
+    }
+
+    pub(super) NV_PFSP_QUEUE_TAIL(u32)[8] @ 0x008f2c04 {
+        31:0    address => u32;
+    }
+
+    pub(super) NV_PFSP_MSGQ_HEAD(u32)[8] @ 0x008f2c80 {
+        31:0    val => u32;
+    }
+
+    pub(super) NV_PFSP_MSGQ_TAIL(u32)[8] @ 0x008f2c84 {
+        31:0    val => u32;
+    }
+}
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index b21a5adc723a..9069aeff1ee4 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -491,27 +491,6 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
     }
 }
 
-// FSP (Foundation Security Processor) queue registers for Hopper/Blackwell Chain of Trust.
-// These registers manage falcon EMEM communication queues.
-
-register! {
-    pub(crate) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {
-        31:0    address => u32;
-    }
-
-    pub(crate) NV_PFSP_QUEUE_TAIL(u32)[8] @ 0x008f2c04 {
-        31:0    address => u32;
-    }
-
-    pub(crate) NV_PFSP_MSGQ_HEAD(u32)[8] @ 0x008f2c80 {
-        31:0    val => u32;
-    }
-
-    pub(crate) NV_PFSP_MSGQ_TAIL(u32)[8] @ 0x008f2c84 {
-        31:0    val => u32;
-    }
-}
-
 // The modules below provide registers that are not identical on all supported chips. They should
 // only be used in HAL modules.
 

-- 
2.54.0


