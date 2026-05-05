Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DEBCD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7CA10EA0E;
	Tue,  5 May 2026 09:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jpWvyYA0";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DE310EA0E;
 Tue,  5 May 2026 09:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777973023;
 bh=eu2FXCNHpSqRcCHwo3LBgArqDRiQ1Vg3R9/LKPa0d4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jpWvyYA09zMhzPlqdaKg+8Y685qiiqiwVf3xThFnXPA8YpwGB4gqeTZKCpBEYatS2
 QMCivMGfAHbCfAVORssG+clYmdJshstuvlBMlCYz1YVtu20qZKuCXsfBLAbyBPQqUp
 Ju00DwttL5IFXicHpaKZKMQpF+mujbocqjTK5BpbBpz5Ex4e8/mEGJFEPvahGoish8
 KvaZnAyaxtae4WLxsVDBZ2+uGbxyHO2MUhZ5RsRPuuAnpp43MTAbIbaH/NfDahSyq2
 8m3SBU6I5Mz6d+7qtMfmwx0xys6cYxdSIDMU5akBSWK2h96yJNPOUlI/BRw86I3pNp
 c2OZqgkYRy4hw==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 01D0217E1321;
 Tue,  5 May 2026 11:23:42 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, boris.brezillon@collabora.com
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 1/1] rust: drm: add RENDER_CAPABILITY flag for render node
 support
Date: Tue,  5 May 2026 11:23:04 +0200
Message-Id: <20260505092304.108262-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260505092304.108262-1-laura.nao@collabora.com>
References: <20260505092304.108262-1-laura.nao@collabora.com>
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

Add RENDER_CAPABILITY bool constant to the Driver trait to control
render node support. When enabled, the driver exposes /dev/dri/renderDXX
render nodes to userspace. The flag defaults to false, drivers can opt
in by setting it to true in their Driver implementation.

This is then enabled in the Tyr driver, while it's left disabled for
Nova for the time being.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs |  1 +
 rust/kernel/drm/device.rs     | 12 +++++++++++-
 rust/kernel/drm/driver.rs     |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index e20a5978eed6..b7ae37ce3a1b 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -186,6 +186,7 @@ impl drm::Driver for TyrDrmDriver {
     type Object = drm::gem::shmem::Object<BoData>;
 
     const INFO: drm::DriverInfo = INFO;
+    const RENDER_CAPABILITY: bool = true;
 
     kernel::declare_drm_ioctls! {
         (PANTHOR_DEV_QUERY, drm_panthor_dev_query, ioctl::RENDER_ALLOW, TyrDrmFileData::dev_query),
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index adbafe8db54d..e121303d88f0 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -80,6 +80,16 @@ pub struct Device<T: drm::Driver> {
 }
 
 impl<T: drm::Driver> Device<T> {
+    const fn compute_features() -> u32 {
+        let mut features = drm::driver::FEAT_GEM;
+
+        if T::RENDER_CAPABILITY {
+            features |= drm::driver::FEAT_RENDER;
+        }
+
+        features
+    }
+
     const VTABLE: bindings::drm_driver = drm_legacy_fields! {
         load: None,
         open: Some(drm::File::<T::File>::open_callback),
@@ -105,7 +115,7 @@ impl<T: drm::Driver> Device<T> {
         name: crate::str::as_char_ptr_in_const_context(T::INFO.name).cast_mut(),
         desc: crate::str::as_char_ptr_in_const_context(T::INFO.desc).cast_mut(),
 
-        driver_features: drm::driver::FEAT_GEM,
+        driver_features: Self::compute_features(),
         ioctls: T::IOCTLS.as_ptr(),
         num_ioctls: T::IOCTLS.len() as i32,
         fops: &Self::GEM_FOPS,
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 5233bdebc9fc..92cbc26ce11f 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -16,6 +16,8 @@
 
 /// Driver use the GEM memory manager. This should be set for all modern drivers.
 pub(crate) const FEAT_GEM: u32 = bindings::drm_driver_feature_DRIVER_GEM;
+/// Driver supports render nodes, i.e.: /dev/dri/renderDXX devices.
+pub(crate) const FEAT_RENDER: u32 = bindings::drm_driver_feature_DRIVER_RENDER;
 
 /// Information data for a DRM Driver.
 pub struct DriverInfo {
@@ -115,6 +117,9 @@ pub trait Driver {
 
     /// IOCTL list. See `kernel::drm::ioctl::declare_drm_ioctls!{}`.
     const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor];
+
+    /// Sets the `DRIVER_RENDER` feature for this driver.
+    const RENDER_CAPABILITY: bool = false;
 }
 
 /// The registration type of a `drm::Device`.
-- 
2.39.5

