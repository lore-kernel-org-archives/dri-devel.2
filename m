Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219F3CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 22:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F76B10E24E;
	Mon, 25 May 2026 22:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n1Pjd28n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3112410E24E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 22:59:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94EAB4378C;
 Mon, 25 May 2026 22:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8981F00A3A;
 Mon, 25 May 2026 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779749947;
 bh=XNOA11o3XVKPjE8hzFVrc4KJGxqos6GX3K9OdJH/JfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n1Pjd28nN1kAD2QhDt9geotEnooMgSRuMrQKhsAqwI+ijSFd54tWYVzW2Epltbh8J
 itGl1PIuCx3zfCe/RmdeDYCtCoYWYB8OJrMKo9Y6+OeX616y2ogSjDQThsIeI+Vruz
 hBNQhfB6u2qOVczqn8IzIL/A0WEbbjEMaB6s8z55Th85/e/J7/iyK0PK2OGcfx5d0i
 9a2IOwiIyEGqGPvjh4jit5qg1GT6VR1KQSk8Zy7fC1eaBTutRR5QQ6x2vSlaR6xIA4
 RPVr3f8nnhYBG7DwPgv8pagzkEQLv6hSacI06ciNeBuzK2TKFvvQaeAaJxiAHjRvPz
 o9xtCm9jC1/pw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 jhubbard@nvidia.com, ecourtney@nvidia.com, ttabi@nvidia.com,
 joelagnelf@nvidia.com, gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 5/5] gpu: nova: separate driver type from driver data
Date: Tue, 26 May 2026 00:58:33 +0200
Message-ID: <20260525225838.276108-6-dakr@kernel.org>
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

Split NovaDriver into a unit struct for trait implementations and a
separate Nova struct for the private driver data.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index e4765bc5b3ec..4289df7de01c 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -15,9 +15,11 @@
 use crate::file::File;
 use crate::gem::NovaObject;
 
-pub(crate) struct NovaDriver {
+pub(crate) struct NovaDriver;
+
+pub(crate) struct Nova {
     #[expect(unused)]
-    drm: ARef<drm::Device<Self>>,
+    drm: ARef<drm::Device<NovaDriver>>,
 }
 
 /// Convienence type alias for the DRM device type for this driver
@@ -51,19 +53,19 @@ pub(crate) struct NovaData {
 
 impl auxiliary::Driver for NovaDriver {
     type IdInfo = ();
-    type Data<'bound> = Self;
+    type Data<'bound> = Nova;
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
     fn probe<'bound>(
         adev: &'bound auxiliary::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self, Error> + 'bound {
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::Device::<Self>::new(adev.as_ref(), data)?;
         drm::Registration::new_foreign_owned(&drm, adev.as_ref(), 0)?;
 
-        Ok(Self { drm })
+        Ok(Nova { drm })
     }
 }
 
-- 
2.54.0

