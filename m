Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8EFF531D9
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C83110E124;
	Mon, 13 Apr 2026 22:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="lUqe5A4d";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682F310E124
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119513; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LBaXMTKisio+ZuuYLlHNInE9dZEh0YasJ1JrvrxKqnXwEiuGS114ofQn8fYSMPUBnnyQAM5jpaCi7ZfWcKY5Sp6yDd+LlNgkFK+wo7Zt/E6APrf1nxW4oYXuHeG2ng0EPW30ICSUKOer15PFFUDC57U6A4wNJB/r2wgL+cNfLHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119513;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JMJVfFlSOzp9g3cU5PEtd6C/2EHSjeZanGaJWg2I270=; 
 b=e0tsH3mwP8+Ph/nK1/yw4f+vr9F8sQG3ogfJjoGi6hemgKRA8AkiXnYNmwlWgeFNgrGwO9jqONawgaIhbZZkvSoavdOpld28iteeW8mdsKx4ub/wnf5BfVDzTevPFc0TRJBcg4nx2jAViUJBDLbDbNiuKki2Mfso9yawNwbjDQg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119513; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=JMJVfFlSOzp9g3cU5PEtd6C/2EHSjeZanGaJWg2I270=;
 b=lUqe5A4dz3TMilzfLmZRH5DODlXuaHbE/UIb39C8YxZpNlrUXf3XqTnZstdZiCKa
 qvZB8Q8y2szmeecuU8f0nA0TgX9fsEVyPbCwN+YKGd9YgKSGSpiTCrhA+bi3XkpqTUi
 PaUKs5phJwnvoHZTzPX/+qp2s3gOhu+iUgExxkPE=
Received: by mx.zohomail.com with SMTPS id 1776119512472811.382134910694;
 Mon, 13 Apr 2026 15:31:52 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Apr 2026 15:31:36 -0700
Subject: [PATCH v3 01/13] drm/tyr: remove unused device from platform data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-fw-boot-v3-v3-1-b422f3c03885@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=XRxFSamf7saI7+ftNuGJR2myREQ3d+lkhhlapLuBSII=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl38666/1rf3tKwcJVrv4+rfnVd9vt5of6HjPcecqjOa
 OGxVWvrKGVhEONikBVTZDlrb9QjXvXeSHf+/2aYOaxMIEMYuDgFYCI+Wxn+8Eh4vXvGuys19Vgo
 24/THG3X+Rjy+ZW9ahN513O8dhdoY/jv8iB+H9crn78NBQw7+59eO/+apdHS89kWhQVfVHWP7hR
 mAAA=
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

TyrPlatformDriverData stores an ARef to the DRM device to keep it alive,
but after switching to Registration::new_foreign_owned(), the registration
owns the device, so the extra reference is no longer needed.

Remove the device field and return an empty TyrPlatformDriverData instead.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 0a1cfbad1e6c..7a27207e52f7 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -52,9 +52,7 @@
 pub(crate) type TyrDrmDevice<Ctx = drm::Registered> = drm::Device<TyrDrmDriver, Ctx>;
 
 #[pin_data(PinnedDrop)]
-pub(crate) struct TyrPlatformDriverData {
-    _device: ARef<TyrDrmDevice>,
-}
+pub(crate) struct TyrPlatformDriverData;
 
 #[pin_data(PinnedDrop)]
 pub(crate) struct TyrDrmDeviceData {
@@ -157,15 +155,12 @@ fn probe(
                 gpu_info,
         });
 
-        let ddev = Registration::new_foreign_owned(uninit_ddev, pdev.as_ref(), data, 0)?;
-        let driver = TyrPlatformDriverData {
-            _device: ddev.into(),
-        };
+        Registration::new_foreign_owned(uninit_ddev, pdev.as_ref(), data, 0)?;
 
         // We need this to be dev_info!() because dev_dbg!() does not work at
         // all in Rust for now, and we need to see whether probe succeeded.
         dev_info!(pdev, "Tyr initialized correctly.\n");
-        Ok(driver)
+        Ok(TyrPlatformDriverData)
     }
 }
 

-- 
2.53.0

