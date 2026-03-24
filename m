Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFEEF532C5
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058A610E56F;
	Tue, 24 Mar 2026 00:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="FG9/WLqQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53A310E464
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774311496; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fWeuLpGS7R1h+XRWbb3EvpbdbGtrJ5SM9BHJ9dW9F/z7+0IeUsMAle89jwC9rC2AqLkeBEY0THmxZJh/TgmfqoXtjU6F3EhVACJuQUUUzjgrkZC26R/rsKmIFIvTOFyQR0ofN2ISANN0Xs87Vda/yR17+A8wdlBtKMHX9QFSnN8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774311496;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BZb8QIRx44/ilYbS5qAz0VTwhN8BJ3suoOjGoNdases=; 
 b=QrZ9QaJRqbAHEe6xT4yCeJ3jmwm4sKNkDi3N3hVi2V+gXPkifJ13m7vQMQg1g+6Ux2MrUVmLYPgpEXvdijrA4U03N64UJFLBmjUfa00GFazGXIo2MEAMBv5hSezsW3BuflFnihHpXwNYlxHC+IyNfUzc7oIBvQ8cynnPwl7nJDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774311496; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=BZb8QIRx44/ilYbS5qAz0VTwhN8BJ3suoOjGoNdases=;
 b=FG9/WLqQDevyA93sY/hvuQj412ctvB9T6/hMFXAGix2w/SBIg/+q5P3TTkG6OUZK
 Ir4zJ5X+F/DSy4lhhLdjTb35201X54lzHMKNl8ahceA+dTx/BCSV5BIpcDccticE7+P
 rISw0sN5CpVT3/FDhYJQ9wPnIbnf2ui8TRJzc9IQ=
Received: by mx.zohomail.com with SMTPS id 1774311494749290.23201100936217;
 Mon, 23 Mar 2026 17:18:14 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 23 Mar 2026 17:18:06 -0700
Subject: [PATCH v3 04/12] drm/tyr: Use register! macro for JOB_CONTROL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-tyr-use-register-macro-v3-v3-4-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3583;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=ea9U4nLBHdPFka/eNcJuSDgiBbDOLnFdTTQrtQNPTqY=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkHbzj8Ys70ndXanRYd26RZ5BDLy36kaBe3zOL1p6+d/
 L/P/vGmjlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACbyMIDhf9jxbm3F8Jf3Zq50
 Tjky88HM/XfPvdKc5bL872TjVyqzZXwZGba0hQd8OusmNM1GrDLxYB/HnYaZcTG1UbebQ4IDTf3
 zeAE=
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

Convert the JOB_CONTROL register definitions to use the `register!` macro.

Using the `register!` macro allows us to replace manual bit masks and
shifts with typed register and field accessors, which makes the code
easier to read and avoids errors from bit manipulation.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 58 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 5ba4919263af29c6e88435099cf801fa5874b117..bae3f917dd3ad3fe0dfd8425a119347f9d1ebbe8 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -28,7 +28,6 @@
 #![allow(dead_code)]
 
 use kernel::{
-    bits::bit_u32,
     device::{
         Bound,
         Device, //
@@ -787,14 +786,57 @@ fn from(status: McuStatus) -> Self {
     }
 }
 
-pub(crate) const JOB_IRQ_RAWSTAT: Register<0x1000> = Register;
-pub(crate) const JOB_IRQ_CLEAR: Register<0x1004> = Register;
-pub(crate) const JOB_IRQ_MASK: Register<0x1008> = Register;
-pub(crate) const JOB_IRQ_STAT: Register<0x100c> = Register;
-
-pub(crate) const JOB_IRQ_GLOBAL_IF: u32 = bit_u32(31);
-
 pub(crate) const MMU_IRQ_RAWSTAT: Register<0x2000> = Register;
 pub(crate) const MMU_IRQ_CLEAR: Register<0x2004> = Register;
 pub(crate) const MMU_IRQ_MASK: Register<0x2008> = Register;
 pub(crate) const MMU_IRQ_STAT: Register<0x200c> = Register;
+
+/// These registers correspond to the JOB_CONTROL register page.
+/// They are involved in communication between the firmware running on the MCU and the host.
+pub(crate) mod job_control {
+    use kernel::register;
+
+    register! {
+        /// Raw status of job interrupts.
+        ///
+        /// Write to this register to trigger these interrupts.
+        /// Writing a 1 to a bit forces that bit on.
+        pub(crate) JOB_IRQ_RAWSTAT(u32) @ 0x1000 {
+            /// CSG request. These bits indicate that CSGn requires attention from the host.
+            30:0    csg;
+            /// GLB request. Indicates that the GLB interface requires attention from the host.
+            31:31   glb;
+        }
+
+        /// Clear job interrupts. Write only.
+        ///
+        /// Write a 1 to a bit to clear the corresponding bit in [`JOB_IRQ_RAWSTAT`].
+        pub(crate) JOB_IRQ_CLEAR(u32) @ 0x1004 {
+            /// Clear CSG request interrupts.
+            30:0    csg;
+            /// Clear GLB request interrupt.
+            31:31   glb;
+        }
+
+        /// Mask for job interrupts.
+        ///
+        /// Set each bit to 1 to enable the corresponding interrupt source or to 0 to disable it.
+        pub(crate) JOB_IRQ_MASK(u32) @ 0x1008 {
+            /// Enable CSG request interrupts.
+            30:0    csg;
+            /// Enable GLB request interrupt.
+            31:31   glb;
+        }
+
+        /// Active job interrupts. Read only.
+        ///
+        /// This register contains the result of ANDing together [`JOB_IRQ_RAWSTAT`] and
+        /// [`JOB_IRQ_MASK`].
+        pub(crate) JOB_IRQ_STATUS(u32) @ 0x100c {
+            /// CSG request interrupt status.
+            30:0    csg;
+            /// GLB request interrupt status.
+            31:31   glb;
+        }
+    }
+}

-- 
2.52.0

