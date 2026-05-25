Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBA1CD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 22:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF6610E17A;
	Mon, 25 May 2026 22:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BVqtI4gB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9798910E17A
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 22:59:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C6E1600AB;
 Mon, 25 May 2026 22:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE801F000E9;
 Mon, 25 May 2026 22:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779749944;
 bh=L1d7UULgaosIXxBW7/PeEq+ReoPxcxwGmVZLUt9dhbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BVqtI4gBPRr6mv32/kNFuM2DUAbhzRXeWaF6NtE4X8QdxKwBBuLz3IaofBFUm5fNM
 fx8rJ2s1atFucDwPruiOoEezrTF+iZ9j/MXm77TRPCyzyx8z2qmAVXJcCp0TB2FiTJ
 ua2nKliZLQotm+9v2LSj0+mHQo2MVE2DLwF1Y+vLkFAhnfOhBCXafG3abmDLJrZiE0
 pH7Irjnd4MGYsz9W9MbvEueV40uOdJefWo+AErffF10VQp1D+1GNp0YaDARzYO4Qtb
 p2UY9SDEWqDieyt099zhNhSyfUNEu1XFr3hriZRCGbMLTkQLbK0/1CyR9Mk7DHArXn
 wOLmjPBCTVqXw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, ttabi@nvidia.com,
 joelagnelf@nvidia.com, gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 4/5] gpu: nova-core: gsp: replace ARef<Device> with &'a Device
 in sequencer
Date: Tue, 26 May 2026 00:58:32 +0200
Message-ID: <20260525225838.276108-5-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525225838.276108-1-dakr@kernel.org>
References: <20260525225838.276108-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

GspSequencer, GspSeqIter, and GspSequencerParams are already
lifetime-parameterized; the ARef<Device> is unnecessary -- a plain
&'a Device reference suffices.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/gsp/boot.rs      |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index df105ef4b371..3e8f9611d2b3 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -234,7 +234,7 @@ pub(crate) fn boot(
             libos_dma_handle: libos_handle,
             gsp_falcon,
             sec2_falcon,
-            dev: pdev.as_ref().into(),
+            dev,
             bar,
         };
         GspSequencer::run(&self.cmdq, seq_params)?;
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 474e4c8021db..b3015483ed17 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -11,7 +11,6 @@
         Io, //
     },
     prelude::*,
-    sync::aref::ARef,
     time::{
         delay::fsleep,
         Delta, //
@@ -142,7 +141,7 @@ pub(crate) struct GspSequencer<'a> {
     /// Bootloader application version.
     bootloader_app_version: u32,
     /// Device for logging.
-    dev: ARef<device::Device>,
+    dev: &'a device::Device,
 }
 
 impl fw::RegWritePayload {
@@ -281,7 +280,7 @@ pub(crate) struct GspSeqIter<'a> {
     /// Number of commands processed so far.
     cmds_processed: u32,
     /// Device for logging.
-    dev: ARef<device::Device>,
+    dev: &'a device::Device,
 }
 
 impl<'a> Iterator for GspSeqIter<'a> {
@@ -309,7 +308,7 @@ fn next(&mut self) -> Option<Self::Item> {
             self.cmd_data.len() - offset
         };
         buffer[..copy_len].copy_from_slice(&self.cmd_data[offset..offset + copy_len]);
-        let cmd_result = GspSeqCmd::new(&buffer, &self.dev);
+        let cmd_result = GspSeqCmd::new(&buffer, self.dev);
 
         cmd_result.map_or_else(
             |_err| {
@@ -334,7 +333,7 @@ fn iter(&self) -> GspSeqIter<'_> {
             current_offset: 0,
             total_cmds: self.seq_info.cmd_index,
             cmds_processed: 0,
-            dev: self.dev.clone(),
+            dev: self.dev,
         }
     }
 }
@@ -350,7 +349,7 @@ pub(crate) struct GspSequencerParams<'a> {
     /// SEC2 falcon for core operations.
     pub(crate) sec2_falcon: &'a Falcon<Sec2>,
     /// Device for logging.
-    pub(crate) dev: ARef<device::Device>,
+    pub(crate) dev: &'a device::Device,
     /// BAR0 for register access.
     pub(crate) bar: &'a Bar0,
 }
-- 
2.54.0

