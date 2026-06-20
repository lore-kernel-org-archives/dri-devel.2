Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD9FCD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB5910E257;
	Sat, 20 Jun 2026 18:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="niDIyPDT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF05110E258
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:50:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 528E6601E1;
 Sat, 20 Jun 2026 18:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC61F00A3A;
 Sat, 20 Jun 2026 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981417;
 bh=85iR9exzf8P2dlAIyZXMmpV0bumfLYJd54QwSsU9LrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=niDIyPDTnhtjbfoTdMAPIA7v6HMytSwL4yvbZWHWWWKwmHZ5rVcjOM4P2O0PLLWKG
 JFckcFaRc8oa64RbG7B6IAxvDEEKWrlWsMxDDasfJ6MsAaL2CSe6q1C6LWtMn2f7Le
 6GanOFAb9rnL1+Z+NQh1Qk6dwmuxFAPL7V0DNqJMCMu8um0CCpIEEHUR2gp5RyUHXE
 0WXuBtw7lB3PnlSa0vdaA6vSIRoavEP6nL0yVP5hmcAvma5A9BwqgOMFIRQzJLERvs
 wVELF7Qx2gmfuJOPMqNd/cdMNShhpjsohsrg06kEW2ghmm+tQkNixPZcyseIIE7i4v
 i/TIUOg0U92Pg==
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
Subject: [PATCH v4 09/16] rust: drm: add Ioctl device context typestate
Date: Sat, 20 Jun 2026 20:48:02 +0200
Message-ID: <20260620184924.2247517-10-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620184924.2247517-1-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
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

Add the Ioctl DeviceContext for DRM devices that have been registered
with userspace previously.

A Device<T, Ioctl> has been registered at some point, but may be
concurrently unregistering or already unregistered. drm_dev_enter() can
guard against this, ensuring the device remains registered for the
duration of the critical section.

This typestate will be used in ioctl dispatch context where registration
is guaranteed by the DRM core, and RegistrationGuard can safely be
acquired.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 34 +++++++++++++++++++++++++++++++---
 rust/kernel/drm/mod.rs    |  1 +
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 86a7fca1d33f..d429b4655449 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -74,14 +74,16 @@ macro_rules! drm_legacy_fields {
 
 /// A trait implemented by all possible contexts a [`Device`] can be used in.
 ///
-/// A [`Device`] can be in one of two contexts:
+/// A [`Device`] can be in one of the following contexts:
 ///
 /// - [`Normal`]: The general-purpose, reference-counted context. A [`Device`] in this context may
 ///   or may not be registered with userspace.
+/// - [`Ioctl`]: The device has been registered with userspace at some point; used in ioctl
+///   dispatch context.
 /// - [`Registered`]: The device has been registered with userspace at some point.
 ///
-/// `Device<T, Registered>` dereferences to `Device<T>` ([`Normal`]), so any method available on a
-/// [`Normal`] device is also available on a [`Registered`] one.
+/// Both `Device<T, Ioctl>` and `Device<T, Registered>` dereference to `Device<T>` ([`Normal`]),
+/// so any method available on a [`Normal`] device is also available in the other contexts.
 pub trait DeviceContext: Sealed + Send + Sync {}
 
 /// The general-purpose, reference-counted [`DeviceContext`].
@@ -113,6 +115,21 @@ impl DeviceContext for Normal {}
 impl Sealed for Registered {}
 impl DeviceContext for Registered {}
 
+/// The [`DeviceContext`] of a [`Device`] that has been registered with userspace previously.
+///
+/// A [`Device`] in this context has been registered at some point, but may be concurrently
+/// unregistering or already unregistered. `drm_dev_enter()` can guard against this, ensuring the
+/// device remains registered for the duration of the critical section.
+///
+/// # Invariants
+///
+/// A [`Device`] in this context has been registered with userspace via `drm_dev_register()` at
+/// some point.
+pub struct Ioctl;
+
+impl Sealed for Ioctl {}
+impl DeviceContext for Ioctl {}
+
 /// A [`Device`] which is known at compile-time to be unregistered with userspace.
 ///
 /// This type allows performing operations which are only safe to do before userspace registration,
@@ -342,6 +359,17 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
+impl<T: drm::Driver> Deref for Device<T, Ioctl> {
+    type Target = Device<T>;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller holds a `Device<T, Ioctl>`, which guarantees all invariants
+        // of the weaker `Normal` context.
+        unsafe { self.assume_ctx() }
+    }
+}
+
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
 unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index e5bfaf130342..a6693d2b84b8 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -11,6 +11,7 @@
 
 pub use self::device::Device;
 pub use self::device::DeviceContext;
+pub use self::device::Ioctl;
 pub use self::device::Normal;
 pub use self::device::Registered;
 pub use self::device::UnregisteredDevice;
-- 
2.54.0

