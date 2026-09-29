Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9026BCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA5910E270;
	Wed, 30 Sep 2026 12:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="TkbjctR2";
	dkim-atps=neutral
X-Greylist: delayed 313 seconds by postgrey-1.36 at gabe;
 Tue, 29 Sep 2026 14:07:19 UTC
Received: from mail-proxy25229.mail.163.com (mail-proxy25229.mail.163.com
 [103.129.252.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DD210E492
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vj
 bTBB8DwF7g9ji0l50jBGPJhPvM44ev2BgqTyu3dIY=; b=TkbjctR20LRlfwvrAB
 KVBHS85+oqhRKGYSn1vgukFqgOhXrRCMw8Js2AzqwfwK8DgudcQbh2UZehvEH9iE
 adHzmP5zg8OcuqWTOC6nnFrQbCMTz1M5VvCvHz/9kDzu2yifaE8WLFWUwn/tAu4L
 RNepQx1NAcFFefcG2OhGy9/bk=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgB3SLFPxLtqLmV_Bw--.47547S2;
 Tue, 29 Sep 2026 21:59:48 +0800 (CST)
From: Kaiqi Guo <chaoji_xinren@163.com>
To: rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Jesung Yang <y.j3ms.n@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kaiqi Guo <chaoji_xinren@163.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v6 10/10] gpu: nova-core: use conversion derives for two
 register enums
Date: Tue, 29 Sep 2026 21:58:55 +0800
Message-ID: <20260929135855.36775-11-chaoji_xinren@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929135855.36775-1-chaoji_xinren@163.com>
References: <20260929135855.36775-1-chaoji_xinren@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgB3SLFPxLtqLmV_Bw--.47547S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF48Wr13Xw47Wr47AFy5urg_yoW5Aw1rpF
 45KrZ2kr17Zwn3Xa4xA3WUZFW3Cas3GFZ8uF47Jw1DursFyF10k3ykXrWFq34DG34IkrW2
 gryvk345ua4UK37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piXTm-UUUUU=
X-CM-SenderInfo: pfkd0yplb0x0xuhqqiywtou0bp/xtbC4hXPS2q7xFWmOAAA3t
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:17:35 +0000
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

Replace bounded_enum! for Architecture with TryFrom and Into using the
shared convert helper. Keep the six discriminants, Bounded<u32, 6> input
and output, and Error/EINVAL on invalid inputs.

Use From and Into for FalconCoreRevSubversion, which covers every value
of Bounded<u32, 2>. Its existing infallible conversion and blanket
TryFrom error type remain unchanged. Leave other register enums and
Chipset conversion behavior in place.

This exercises both fallible and exhaustive conversions in actual
register field users without changing register accesses or GPU
initialization logic.

Link: https://lore.kernel.org/rust-for-linux/DHHJCEG8BC47.2VC6GLDRRZH1B@nvidia.com/
Signed-off-by: Kaiqi Guo <chaoji_xinren@163.com>
---
 drivers/gpu/nova-core/falcon.rs | 19 +++++++++----------
 drivers/gpu/nova-core/gpu.rs    | 22 ++++++++++------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 65cb12d26e2b..15bbbda7df28 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -59,16 +59,15 @@ pub(crate) enum FalconCoreRev with TryFrom<Bounded<u32, 4>> {
     }
 }
 
-bounded_enum! {
-    /// Revision subversion number of a falcon core, used in the
-    /// [`crate::regs::NV_PFALCON_FALCON_HWCFG1`] register.
-    #[derive(Debug, Copy, Clone)]
-    pub(crate) enum FalconCoreRevSubversion with From<Bounded<u32, 2>> {
-        Subversion0 = 0,
-        Subversion1 = 1,
-        Subversion2 = 2,
-        Subversion3 = 3,
-    }
+/// Revision subversion number of a falcon core, used in the
+/// [`crate::regs::NV_PFALCON_FALCON_HWCFG1`] register.
+#[derive(Debug, Copy, Clone, kernel::macros::From, kernel::macros::Into)]
+#[convert(Bounded<u32, 2>)]
+pub(crate) enum FalconCoreRevSubversion {
+    Subversion0 = 0,
+    Subversion1 = 1,
+    Subversion2 = 2,
+    Subversion3 = 3,
 }
 
 bounded_enum! {
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fd1414004dd0..66249bb5b369 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -14,7 +14,6 @@
 };
 
 use crate::{
-    bounded_enum,
     driver::Bar0,
     falcon::{
         gsp::Gsp as GspFalcon,
@@ -155,17 +154,16 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-bounded_enum! {
-    /// Enum representation of the GPU generation.
-    #[derive(fmt::Debug, Copy, Clone)]
-    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
-        Turing = 0x16,
-        Ampere = 0x17,
-        Hopper = 0x18,
-        Ada = 0x19,
-        BlackwellGB10x = 0x1a,
-        BlackwellGB20x = 0x1b,
-    }
+/// Enum representation of the GPU generation.
+#[derive(fmt::Debug, Copy, Clone, kernel::macros::TryFrom, kernel::macros::Into)]
+#[convert(Bounded<u32, 6>)]
+pub(crate) enum Architecture {
+    Turing = 0x16,
+    Ampere = 0x17,
+    Hopper = 0x18,
+    Ada = 0x19,
+    BlackwellGB10x = 0x1a,
+    BlackwellGB20x = 0x1b,
 }
 
 #[derive(Clone, Copy)]

