Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B393BF531CE
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948A010E541;
	Mon, 13 Apr 2026 22:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Tb5lyLiV";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C7B10E541
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119517; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mfBz4HkNY01gg8a1ZYVJ3cCEHjGs2W/mVLa+7Axr44gztTdpuaLfNEyzO9JvoWQREfIxDTK+Vu8qVqRg+Ud3eI8JVbboVTEbFr235q/9hrSzm6TOfgibx/FC7TZ5n30UA04d2BBLSLnSbFQwXLyJi13i7DWwzRqr8/evON8j7+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119517;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hH4p6y7TKcN2UmMFYjcoILpCMwlTTx9qQRAByxuVZ1s=; 
 b=l/Ir7kbltoX9vpxEp7a4WRlPmsUrDsOSG5DJRhq/Xvi+HLdqlPeoQoeBCeU9JUhbr54xyTiGb5hP2EdDBts6JMm2MUeJWCjDnQpZeX+Z9HZOu2LFddJQtX7j64QPmhyDYwFKFSmSkCROSrd57YIF3DeGlyf29bzMf0vYM+EY7jE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119517; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=hH4p6y7TKcN2UmMFYjcoILpCMwlTTx9qQRAByxuVZ1s=;
 b=Tb5lyLiV+KML8tURrITt25s+btkZnCfeqxs69rODL4gZRRn8eG72FDIKtZGGMbni
 WE6LBQV6eQafHm7O38QiAJqUItupQ8dBqKqS2ORiiyIX3SU/tgO8ARb6m/2D1xg5WRR
 1TyQ3fAT/SZK2pg2i1E4BaM7mDZiXxyXc+F+Ugnw=
Received: by mx.zohomail.com with SMTPS id 1776119516355173.13981149757194;
 Mon, 13 Apr 2026 15:31:56 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Apr 2026 15:31:39 -0700
Subject: [PATCH v3 04/13] drm/tyr: rename TyrObject to BoData
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-fw-boot-v3-v3-4-b422f3c03885@collabora.com>
References: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
In-Reply-To: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=O2Pl2BjC/KB8EdcByAb7BBRMRMxruk1BxeLbq8Qs9jU=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl3864+y6q80bN3wybV1sSap9dP2vTUzQ7qWbKFR3ny9
 LuRW0ViO0pZGMS4GGTFFFnO2hv1iFe9N9Kd/78ZZg4rE8gQBi5OAZjIzkpGhr2btX+yXdmQsLH2
 1N1tm95+37tsLbfsy9Osjx/POn/ebcFbRobNKql1S+/eOPXyVv72x50NLzMdd8wr+ftz4iaeFWz
 PJ5xiAQA=
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Currently the GEM inner driver data object is called `TyrObject` which
is a fairly generic name. To make the code easier to understand,
rename `TyrObject` to `BoData` so that the name better reflects its
role.

No functional change is intended.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 4 ++--
 drivers/gpu/drm/tyr/gem.rs    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 3057f3af10e3..f2e7157221f1 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -38,7 +38,7 @@
 
 use crate::{
     file::TyrDrmFileData,
-    gem::TyrObject,
+    gem::BoData,
     gpu,
     gpu::GpuInfo,
     regs::gpu_control::*, //
@@ -183,7 +183,7 @@ fn drop(self: Pin<&mut Self>) {}
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
     type File = TyrDrmFileData;
-    type Object<R: drm::DeviceContext> = drm::gem::Object<TyrObject, R>;
+    type Object<R: drm::DeviceContext> = drm::gem::Object<BoData, R>;
 
     const INFO: drm::DriverInfo = INFO;
 
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index fa8d663fb523..11951b507b18 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -15,9 +15,9 @@
 
 /// GEM Object inner driver data
 #[pin_data]
-pub(crate) struct TyrObject {}
+pub(crate) struct BoData {}
 
-impl gem::DriverObject for TyrObject {
+impl gem::DriverObject for BoData {
     type Driver = TyrDrmDriver;
     type Args = ();
 
@@ -26,6 +26,6 @@ fn new<Ctx: DeviceContext>(
         _size: usize,
         _args: Self::Args,
     ) -> impl PinInit<Self, Error> {
-        try_pin_init!(TyrObject {})
+        try_pin_init!(BoData {})
     }
 }

-- 
2.53.0

