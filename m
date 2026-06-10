Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AF7CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F4A10E65F;
	Wed, 10 Jun 2026 14:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eRfkm673";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEAB10E65F
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:14:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CFD440B65;
 Wed, 10 Jun 2026 14:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EBE1F00893;
 Wed, 10 Jun 2026 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781100867;
 bh=KPiX8TGWPsoMZqa7PdhBx71whabtl3ZRcCCVFIwYALE=;
 h=From:To:Cc:Subject:Date:Reply-To;
 b=eRfkm673gMKYrhae5FF7BN1DR7yX0fQXJNlU/EU7gYjhkNfsSr/mtEHVDxYEdnJqq
 XLkjMdeK/BbqDAUYhZr0LkyhiSijQIcZdJ6xoRMFQLZgTQIO7oT0SoSXnPOHGqDz+2
 9Ur8x2Xh4TkAaPPiTODa4o3F9zDLJw2Nhz4sdChq0eTpesEV51xqBgA5OSBJtt9l7r
 6QHLBQ+CZU7vsxEOZtD0OZesxgXX/R55FnM9R6l2bTkhBz+JzX5PY6BiOibBXpI5DC
 LBZry63mKf6X2aW1ThYwQrO9TJ26rdqxVuEv4BK9GaFWwYwO+f2c5RRWFtxCJRdQ71
 1Pto6jqxq4Rgg==
From: Gary Guo <gary@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH] drm/tyr: remove imports available from prelude
Date: Wed, 10 Jun 2026 15:13:58 +0100
Message-ID: <20260610141359.1033755-1-gary@kernel.org>
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
 drivers/gpu/drm/tyr/regs.rs | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 562023e5df2f..831357a8ef87 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -48,17 +48,12 @@ pub(crate) fn read_u64_no_tearing(lo_read: impl Fn() -> u32, hi_read: impl Fn()
 /// These registers correspond to the GPU_CONTROL register page.
 /// They are involved in GPU configuration and control.
 pub(crate) mod gpu_control {
-    use core::convert::TryFrom;
     use kernel::{
-        error::{
-            code::EINVAL,
-            Error, //
-        },
         num::Bounded,
+        prelude::*,
         register,
         uapi, //
     };
-    use pin_init::Zeroable;
 
     register! {
         /// GPU identification register.
@@ -964,14 +959,9 @@ pub(crate) mod mmu_control {
     ///
     /// This array contains 16 instances of the MMU_AS_CONTROL register page.
     pub(crate) mod mmu_as_control {
-        use core::convert::TryFrom;
-
         use kernel::{
-            error::{
-                code::EINVAL,
-                Error, //
-            },
             num::Bounded,
+            prelude::*,
             register, //
         };
 

base-commit: 7d570075805918f5ec33f03949c6a7c610397340
-- 
2.54.0

