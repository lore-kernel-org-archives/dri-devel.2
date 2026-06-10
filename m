Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C329CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10F310E987;
	Wed, 10 Jun 2026 13:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LgnZ9P7y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF66A10E987
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:57:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E00343485;
 Wed, 10 Jun 2026 13:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32F61F00893;
 Wed, 10 Jun 2026 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781099870;
 bh=TeizJECtqJ8z2fxDQWQ6uFGtYjvnQLbN04L3f5mZygY=;
 h=From:To:Cc:Subject:Date:Reply-To;
 b=LgnZ9P7ywGIlS6U1InWIk2u9V0MjpqMAkZRaLtdVVeYj7eNYSgbsmBnV+4JgWalNf
 lUrvG5nbugn9qhvu9SmD8iHEY7gQeCkZrSPjASXiC76KK6nNZOleqpjNm0rcxIY9DR
 3Ro5H6uIiDK7ujHVpy88/KEQ8IfnnZFk3K3yoLDK6HTrcxiI6XMZQwXOnrP+4WnCB5
 rnZ2zGrM4MlWBARpbVVFnR1t6Feq8gkYbByjLlN0Z/SqGIKGX/1ctif2RxnH4CmUSl
 uOPUNXAc9Na0b9bqj8njtl9AoO1CR8P3ehO8ljXgKDF0Ko0gCUXYnjsmQGykcvtvbJ
 BA6rv7Hj17Fjw==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Gary Guo <gary@garyguo.net>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpu: nova-core: remove imports available from prelude
Date: Wed, 10 Jun 2026 14:57:14 +0100
Message-ID: <20260610135716.1013688-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

No functional changes intended.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/firmware.rs                  | 4 +---
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 366d3b76360e..f74e0f16c65c 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -467,11 +467,9 @@ pub(crate) const fn create(
 /// that scheme before nova-core becomes stable, which means this module will eventually be
 /// removed.
 mod elf {
-    use core::mem::size_of;
-
     use kernel::{
         bindings,
-        str::CStr,
+        prelude::*,
         transmute::FromBytes, //
     };
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 039920dc340b..ac1558a83b83 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -7,7 +7,6 @@
 //! be loaded using PIO.
 
 use kernel::{
-    alloc::KVec,
     device::{
         self,
         Device, //

base-commit: 58f0f62778faf667bdaf1fa7db59e89847213646
-- 
2.54.0

