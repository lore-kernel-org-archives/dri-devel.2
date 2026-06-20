Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7077CD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D6A10E14D;
	Sat, 20 Jun 2026 00:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V2sRRcpM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1502E10E14F
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D0EC601F8;
 Sat, 20 Jun 2026 00:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E971F00A3A;
 Sat, 20 Jun 2026 00:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917172;
 bh=+qBowXS5Rd+9eAOyYfhc7TZnWiUGUXYMeAN8Z34y/WY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V2sRRcpMRaepVPI10Hl3anm1/n54Dwuurv2nh8ccnPMQ0HKOJYR/BUph5t7HsAJTG
 vLpkieLoUsgMh3LI/In/X/OZ6OSWl0hP2/ogv+rDmptp8/wZSR4yvUuCY1yVsaNIlR
 BdnyhUjmO7TFjchZSNRHncNMvTFCUZTLiTsrqJCHzw/MrHE1lXxSAt9fp9yE3fWk3C
 5EOsOimtbeWm1nd3VCpU70cirKDV4znWdJMMVy6n+X2cAzObQEYyJr94ZFNYiEHMcA
 UFMRKzbXTdzYESy8aV325Ebyq6rWrOWq5DCdve5XlWO3g6EDDLdZVvDGSDHN/3BAWm
 plZOUHJDbi4mQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v3 07/13] rust: drm: return ParentDevice from Device AsRef
Date: Sat, 20 Jun 2026 02:51:19 +0200
Message-ID: <20260620005431.1562115-8-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620005431.1562115-1-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
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

Change AsRef for drm::Device to return &T::ParentDevice<device::Normal>
instead of &device::Device, and restrict it to the Normal context.
Device<T, Registered> still gets this through Deref coercion.

This provides access to the typed parent bus device rather than the raw
base device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 10 +++++++---
 rust/kernel/drm/driver.rs |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 86a7fca1d33f..6fdd9fb1ae7f 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -359,11 +359,15 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
-impl<T: drm::Driver, C: DeviceContext> AsRef<device::Device> for Device<T, C> {
-    fn as_ref(&self) -> &device::Device {
+impl<T: drm::Driver> AsRef<T::ParentDevice<device::Normal>> for Device<T> {
+    fn as_ref(&self) -> &T::ParentDevice<device::Normal> {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
         // which is guaranteed by the type invariant.
-        unsafe { device::Device::from_raw((*self.as_raw()).dev) }
+        let dev = unsafe { device::Device::from_raw((*self.as_raw()).dev) };
+
+        // SAFETY: By the type invariant of `Device`, the parent device is embedded in
+        // `T::ParentDevice`.
+        unsafe { device::AsBusDevice::from_device(dev) }
     }
 }
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 5152a18a8312..9ba7dc3a7a97 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -170,7 +170,7 @@ pub fn new_foreign_owned<'a>(
     where
         T: 'static,
     {
-        if drm.as_ref().as_raw() != dev.as_raw() {
+        if drm.as_ref().as_ref().as_raw() != dev.as_raw() {
             return Err(EINVAL);
         }
 
-- 
2.54.0

