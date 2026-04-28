Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F73FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1987210E386;
	Tue, 28 Apr 2026 19:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Y30OfXGr";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E0510E369
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777403981; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DJon07VbFT57f8Igvy44Rzn/O/f+5H48DgnAJzjgrLM3IhtudQHMJalej2PlZAmV96vpEcHaGxKM/k4eVzO8MtFmC+i9SpHATpKr67DJk4lZDhqDOF9FeXTB/ZQxlbor6QfFuORc8RSHiiMn028hHD5yoonSCl3nm75tzlA5Ht8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777403981;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kTPl9yYwdmxPlkA+LNnQe66DxCpVxNnAaVuSH7KLSew=; 
 b=By0wBlV+sAguCdkt1zKPN6AyWxHITQpVarfvCHlPMsVNc4WhXe8Fln68hva623MoYFYeFOHZ0bwEhDkx/M/xzARdeVQZFsSH1Ixq9Kedx0/3LT4eXC4rkDYq45hE3+tuY7bDCPZFo5dhAIG2IP1LrrpVstIwlQzGF02Q195ilMU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777403981; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=kTPl9yYwdmxPlkA+LNnQe66DxCpVxNnAaVuSH7KLSew=;
 b=Y30OfXGrsO3jTKi5229bcGK9z83yMjUuhtwQcTi5DCGj5a9vdchrSZIOAioSvb7S
 u/2Kkpsh1LqRjExgZpIPPUUSp/yHF39Rd1FAIhXpQqjgO9sYlycSRxAj/+tdA+OO/ne
 DG9zAczSb5ONZBq3s6yNUXtiV7RZwwg/8X3PQwuQ=
Received: by mx.zohomail.com with SMTPS id 1777403978740847.9599992334656;
 Tue, 28 Apr 2026 12:19:38 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 28 Apr 2026 12:19:29 -0700
Subject: [PATCH 2/5] drm/tyr: rename TyrObject to BoData
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-fw-boot-prerequisites-v1-2-c69af9abe1af@collabora.com>
References: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
In-Reply-To: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=ISZXmYabGJ9SdgexjWCJ5nGOwQWfdDa12XyEDh7EmSw=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkfOdzPdSscC/seJrb1/u9XUxfo3rL4vsuoSs0gvI6rJ
 n2PcRVDRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABPRKmJk6NQ4a1xwwn9h3vxF
 qu/8tuf/5RA/d2vtPIt3X9a4cK4NmsXI0LuY/dSEiLqKt3mlxlPZdiy7diD4SdHHUnGPJo5J2Y7
 OjAA=
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
index bb56a9b996a0..bb90324043ed 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -34,7 +34,7 @@
 
 use crate::{
     file::TyrDrmFileData,
-    gem::TyrObject,
+    gem::BoData,
     gpu,
     gpu::GpuInfo,
     regs::gpu_control::*, //
@@ -171,7 +171,7 @@ fn drop(self: Pin<&mut Self>) {}
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
     type File = TyrDrmFileData;
-    type Object = drm::gem::Object<TyrObject>;
+    type Object = drm::gem::Object<BoData>;
 
     const INFO: drm::DriverInfo = INFO;
 
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 5cc6eb0b5d3f..66c427a16c31 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -12,13 +12,13 @@
 
 /// GEM Object inner driver data
 #[pin_data]
-pub(crate) struct TyrObject {}
+pub(crate) struct BoData {}
 
-impl gem::DriverObject for TyrObject {
+impl gem::DriverObject for BoData {
     type Driver = TyrDrmDriver;
     type Args = ();
 
     fn new(_dev: &TyrDrmDevice, _size: usize, _args: ()) -> impl PinInit<Self, Error> {
-        try_pin_init!(TyrObject {})
+        try_pin_init!(BoData {})
     }
 }

-- 
2.53.0

