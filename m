Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79436CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 22:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E69A10E249;
	Mon, 25 May 2026 22:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CVH78Et/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED56110E17A
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 22:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CD9760018;
 Mon, 25 May 2026 22:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE47D1F00A3A;
 Mon, 25 May 2026 22:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779749942;
 bh=4LMYyGKD1lW6nYBiVpCrQLfZbktFHmCLyCx9p2MQ55Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CVH78Et/rja9Js9TZIJMF1xuhqhupWesgqi6wvoXLY6wmOzZhIH/mw/dthKFmwDV1
 BrduvM5mmpqHg7DaAFzflVwk6Z4Gb26B4j0XXFMZp4DdINcvMEcvk4sTtzhVTQCywD
 Y1e9F/lsP0kyJM7+FulAG+vWSFmNC/XESF4CI4mAPb7Wn9wnTTyicNbmQGsV4mH/gl
 oySsp4Kz4h44EaOmypWWPEyinqZxQUGH3RkGj3WMa/ez2Hp1lHW7DDzRhAXjzzHJ9p
 ARkQy97AiuoZjJvfrjG+ZGwooWt8WT9nezvSIhHmuHgR+wfHSxlGrjhDv9Kyck3/rI
 2dPVDCa8wuX6g==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, ttabi@nvidia.com,
 joelagnelf@nvidia.com, gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 3/5] gpu: nova-core: replace ARef<Device> with &'bound Device
 in SysmemFlush
Date: Tue, 26 May 2026 00:58:31 +0200
Message-ID: <20260525225838.276108-4-dakr@kernel.org>
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

Now that SysmemFlush is lifetime-parameterized, the ARef<Device> is
unnecessary -- a plain &'bound Device reference suffices.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/fb.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 3b3271790cc9..1fb65d4eb290 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -15,8 +15,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::*,
-    sync::aref::ARef, //
+    sizes::*, //
 };
 
 use crate::{
@@ -46,7 +45,7 @@
 pub(crate) struct SysmemFlush<'sys> {
     /// Chipset we are operating on.
     chipset: Chipset,
-    device: ARef<device::Device>,
+    device: &'sys device::Device,
     bar: &'sys Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
@@ -55,7 +54,7 @@ pub(crate) struct SysmemFlush<'sys> {
 impl<'sys> SysmemFlush<'sys> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
-        dev: &device::Device<device::Bound>,
+        dev: &'sys device::Device<device::Bound>,
         bar: &'sys Bar0,
         chipset: Chipset,
     ) -> Result<Self> {
@@ -65,7 +64,7 @@ pub(crate) fn register(
 
         Ok(Self {
             chipset,
-            device: dev.into(),
+            device: dev,
             bar,
             page,
         })
-- 
2.54.0

