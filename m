Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D0606A334
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoZP5Rov
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A0A10E50B;
	Sat,  7 Nov 2026 02:20:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536B910E50B
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 02:20:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5017960E17;
 Sat,  7 Nov 2026 02:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BE61F008A1;
 Sat,  7 Nov 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794018024;
 bh=TrIuf20+j9/0/4lJxbML9gAP91hF1KjANdxECGNgYyI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LoZP5Rov2QCisbYKDrvofjl6ahbPCNBGxGk0Vvezasl3hiKXDPcp40QHUsVPaBd6I
 aX/IYAejn9fU6Rmuy2oft1k7/28+fIVnO9zGGQQka3/L/F3P8h1dK0gOc8zAC4FwaA
 gmRxppWz7zdDvub+/hfclcRzEN3MCb5Z6DME7c8JOKL3dhLEkS6KIZkd7UG9mF0SOq
 h0BdWUCvLHnLnsk3sIo3sR0qa6me0MnQXGvSiCUdFg/a2IYH7yHy7U9ZOO1aDE3YoL
 azQnOnLo0DyEYyYFn021w1m4byU3HiEY2uPxz79zWDc5vNxIz6Bq4iWYrAwaF0qLbV
 GLUpRM3gxcR/Q==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] rust: drm: rename Ioctl device context to Userspace
Date: Sat,  7 Nov 2026 03:03:19 +0100
Message-ID: <20261107021427.2105374-2-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107021427.2105374-1-dakr@kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Ioctl DeviceContext typestate represents a device that has been
registered with userspace at some point. This context is not specific to
ioctl dispatch; it applies equally to GEM handle callbacks, mmap,
fdinfo, and any other operation triggered by userspace on a registered
device.

Rename it to Userspace to accurately reflect its semantics.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 21 ++++++++++++---------
 rust/kernel/drm/ioctl.rs  | 12 ++++++------
 rust/kernel/drm/mod.rs    |  2 +-
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 6b88ade28e24..dd1c83fef323 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -79,12 +79,12 @@ macro_rules! drm_legacy_fields {
 ///
 /// - [`Normal`]: The general-purpose, reference-counted context. A [`Device`] in this context may
 ///   or may not be registered with userspace.
-/// - [`Ioctl`]: The device has been registered with userspace at some point; used in ioctl
-///   dispatch context.
+/// - [`Userspace`]: The device has been registered with userspace at some point; used in
+///   callbacks triggered by userspace operations.
 /// - [`Registered`]: The device is currently registered with userspace and the parent bus device
 ///   is bound.
 ///
-/// Both `Device<T, Ioctl>` and `Device<T, Registered>` dereference to `Device<T>` ([`Normal`]),
+/// Both `Device<T, Userspace>` and `Device<T, Registered>` dereference to `Device<T>` ([`Normal`]),
 /// so any method available on a [`Normal`] device is also available in the other contexts.
 pub trait DeviceContext: Sealed + Send + Sync + 'static {}
 
@@ -120,14 +120,17 @@ impl DeviceContext for Registered {}
 /// unregistering or already unregistered. `drm_dev_enter()` can guard against this, ensuring the
 /// device remains registered for the duration of the critical section.
 ///
+/// This context is used for all callbacks triggered by userspace operations: ioctls, GEM handle
+/// management, mmap, fdinfo, etc.
+///
 /// # Invariants
 ///
 /// A [`Device`] in this context has been registered with userspace via `drm_dev_register()` at
 /// some point.
-pub struct Ioctl;
+pub struct Userspace;
 
-impl Sealed for Ioctl {}
-impl DeviceContext for Ioctl {}
+impl Sealed for Userspace {}
+impl DeviceContext for Userspace {}
 
 /// A [`Device`] which is known at compile-time to be unregistered with userspace.
 ///
@@ -344,7 +347,7 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
     }
 }
 
-impl<T: drm::Driver> Device<T, Ioctl> {
+impl<T: drm::Driver> Device<T, Userspace> {
     /// Guard against the parent bus device being unbound.
     ///
     /// Returns a [`RegistrationGuard`] if the device has not been unplugged, [`None`] otherwise.
@@ -467,12 +470,12 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: drm::Driver> Deref for Device<T, Ioctl> {
+impl<T: drm::Driver> Deref for Device<T, Userspace> {
     type Target = Device<T>;
 
     #[inline]
     fn deref(&self) -> &Self::Target {
-        // SAFETY: The caller holds a `Device<T, Ioctl>`, which guarantees all invariants
+        // SAFETY: The caller holds a `Device<T, Userspace>`, which guarantees all invariants
         // of the weaker `Normal` context.
         unsafe { self.assume_ctx() }
     }
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 64af9eacc306..9934b23c36eb 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -71,14 +71,14 @@ pub mod internal {
     pub use bindings::drm_file;
     pub use bindings::drm_ioctl_desc;
 
-    /// Cast an [`Ioctl`] DRM device pointer to [`Registered`], preserving the driver type
+    /// Cast a [`Userspace`] DRM device pointer to [`Registered`], preserving the driver type
     /// parameter `T`.
     ///
     /// Used by [`declare_drm_ioctls!`] to anchor type inference.
     #[doc(hidden)]
     #[inline]
     pub const fn __dev_ctx_cast<T: crate::drm::Driver>(
-        ptr: *const crate::drm::Device<T, crate::drm::Ioctl>,
+        ptr: *const crate::drm::Device<T, crate::drm::Userspace>,
     ) -> *const crate::drm::Device<T, crate::drm::Registered> {
         ptr.cast()
     }
@@ -144,14 +144,14 @@ macro_rules! declare_drm_ioctls {
                             // - The DRM device must have been registered when we're called through
                             //   an IOCTL.
                             //
-                            // INVARIANT: The `Ioctl` context requires that the device has been
-                            // registered via `drm_dev_register()` at some point; the DRM core
-                            // guarantees this for ioctl dispatch callbacks.
+                            // INVARIANT: The `Userspace` context requires that the device has
+                            // been registered via `drm_dev_register()` at some point; the DRM
+                            // core guarantees this for ioctl dispatch callbacks.
                             //
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev: &$crate::drm::device::Device<_, $crate::drm::Ioctl> =
+                            let dev: &$crate::drm::device::Device<_, $crate::drm::Userspace> =
                                 $crate::drm::device::Device::from_raw(raw_dev);
 
                             // Type-inference anchor: the closure is never called but ties `dev`'s
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index fd6ed35bc35a..7fcf2465a82e 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -11,11 +11,11 @@
 
 pub use self::device::Device;
 pub use self::device::DeviceContext;
-pub use self::device::Ioctl;
 pub use self::device::Normal;
 pub use self::device::Registered;
 pub use self::device::RegistrationGuard;
 pub use self::device::UnregisteredDevice;
+pub use self::device::Userspace;
 pub use self::driver::Driver;
 pub use self::driver::DriverInfo;
 pub use self::driver::Registration;
-- 
2.56.0

