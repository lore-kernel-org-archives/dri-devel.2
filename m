Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C339FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB04310F6F4;
	Fri, 24 Apr 2026 23:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="c4OEcw7J";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684BE89D30
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073957; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j355JcGOlfcZfl74Bg0rToSM2+XTv5hHqSF2XeA9BBTpzTFg29UmuMa4RmkW32uvO1yqkz4FHnOhZc+VQAdIgklS9SzU1sIwMz1EY2s1Z95c+bcgrEpfimL1DB+XzeuFq12nROkusr8JcobqxunbEQ3OAdbTtPCrvyIIpBFCKq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073957;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JMJVfFlSOzp9g3cU5PEtd6C/2EHSjeZanGaJWg2I270=; 
 b=TrgFYRXnFi9jajFl8xcX9jLRSi9PozWbhQFtm8TQ+UEMcJrxBlQKi/NKhrHtUeIx+IRlh7o0e+jh1usz/Jz30nxZcHMV2zsgQe4UqyrQOn1vtGI/hn0LyYBtlJniA7OReuLJCW8naQWnUwShl4k3+k783zD0uSC6NaNP9f3JY+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073957; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=JMJVfFlSOzp9g3cU5PEtd6C/2EHSjeZanGaJWg2I270=;
 b=c4OEcw7JWkCVCtCgiic/UknJzhXTzuxCcvvPPQDaQa0yiMccj9hwUDqRnZqaoJQ1
 U6VcieCDzfzc4Oo9Ah1thQEuZZtLVU8ppxnkXGrR3mLPilfOEgHWt2MX7pv8+/6A5Di
 RAO3K6Lfd8q7EEAzRCctJ5Awmmp8mvS5hUTuVWs0=
Received: by mx.zohomail.com with SMTPS id 1777073955524519.719591354193;
 Fri, 24 Apr 2026 16:39:15 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:38:55 -0700
Subject: [PATCH v4 01/20] drm/tyr: remove unused device from platform data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-1-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=XRxFSamf7saI7+ftNuGJR2myREQ3d+lkhhlapLuBSII=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yt4Xk9zWHR3WvOuUxzegU/vzWZVtF/9+OX8kGqOT
 68Zt2VzdZSyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjCRoAxGhs5JgiETr76/6sga
 61d9v5txQePvwBUOr/s2Xf+2UFoi5yojQ6+Sn8GzGxOebdWb5jzhgXhP5lmfE1NEqjxFxIuz927
 s5QMA
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

