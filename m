Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C9FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EC910E369;
	Tue, 28 Apr 2026 19:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="fTUFpKI+";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076A410E364
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777403981; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gp5oWEVRkyxshS2sf3FbWXYB2aPjtEKBarevFnXVMq60HYh5j2v7NqIodUbIXjwGIz/lOgkgAcd+9ebMeUDIIUyq8lq8LHDU1lv9jefkeomCzHwzMxdHQ2MBtk1NCkh4bYGtYbFX07Dbueoct77XWwYuCU0ZqZNKtzsnfo185ZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777403981;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lylB4VdZYd/+Mm31ZLwjGWKc27cf1j1mM/6RvQC+wUw=; 
 b=Jnrn1Z0EH8IIXG/7Br9I2lVhV4Y6S0AirmFQA5LWfkYckzXWoNygN6843nIyqyHxGw2BRVjhXb4iuFjA7vf5qJh4KO698+HuaQLuw2G6fiqYv7kw4uUh03PTcYM2CK6Izl7JsqVpN4oZM1gCfQRU3YFvqKUbGD2i4b32Hnj7LPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777403981; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=lylB4VdZYd/+Mm31ZLwjGWKc27cf1j1mM/6RvQC+wUw=;
 b=fTUFpKI+HyVEctl1lhx0xGez+GjFP6P999D59RhOIlcnlUTH0HpMGjag14RtJvXY
 x7+ILYfa3e0CW5CK4x8sNetYdmpa0DrzbdbcYd1De7b4p5Q48XjXRpyBzAFDN4VOD3A
 tSml0agzQcs/I+yJs3jaqYdrZ5fDSlPJNIsZxSLo=
Received: by mx.zohomail.com with SMTPS id 17774039800641003.5924833519763;
 Tue, 28 Apr 2026 12:19:40 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 28 Apr 2026 12:19:30 -0700
Subject: [PATCH 3/5] drm/tyr: use shmem GEM object type in TyrDrmDriver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-fw-boot-prerequisites-v1-3-c69af9abe1af@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=9AUqc1pwEO0X2lyd1ardJI/seFGgn87n2wfHo+jWFIc=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkfOdyjf6+a23rqoWHiT5bTx38mCUgKLJp9ZOnqD+Z7W
 fheOK692VHKwiDGxSArpshy1t6oR7zqvZHu/P/NMHNYmUCGMHBxCsBEFLUZ/rtdZ/43/247q/IH
 jquuh/rXvHR3FnJJlldyijLPUlqV5cbw3+X51delmy9O9rCvn9Giue2p1465W20+HNVJ+PKoaMG
 8VFYA
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

From: Alvin Sun <alvin.sun@linux.dev>

Tyr buffer objects are shmem-backed, so the driver should use
drm::gem::shmem::Object<BoData> as its GEM object type instead of the base
drm::gem::Object<BoData> type.

Switching to the shmem GEM object type matches how Tyr allocates and
manages its buffer objects, and uses the shmem-specific GEM abstraction
provided by the DRM Rust bindings.

Select RUST_DRM_GEM_SHMEM_HELPER to ensure the required helpers are
available when DRM_TYR is enabled.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/Kconfig   | 1 +
 drivers/gpu/drm/tyr/driver.rs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
index e933e6478027..51a68ef8212c 100644
--- a/drivers/gpu/drm/tyr/Kconfig
+++ b/drivers/gpu/drm/tyr/Kconfig
@@ -8,6 +8,7 @@ config DRM_TYR
 	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
 	depends on COMMON_CLK
 	default n
+	select RUST_DRM_GEM_SHMEM_HELPER
 	help
 	  Rust DRM driver for ARM Mali CSF-based GPUs.
 
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index bb90324043ed..cdb9b13bdb32 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -171,7 +171,7 @@ fn drop(self: Pin<&mut Self>) {}
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
     type File = TyrDrmFileData;
-    type Object = drm::gem::Object<BoData>;
+    type Object = drm::gem::shmem::Object<BoData>;
 
     const INFO: drm::DriverInfo = INFO;
 

-- 
2.53.0

