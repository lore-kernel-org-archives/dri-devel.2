Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4D5C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4847510E619;
	Sun, 28 Jun 2026 14:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+GhwiVC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926A310E619
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A4A643EED;
 Sun, 28 Jun 2026 14:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17491F000E9;
 Sun, 28 Jun 2026 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658461;
 bh=oAJ7c0y15eZY17lgo23mp8Sc4dPN0x3EeLmQ4Qlc1nc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F+GhwiVC/izBr+z1K0ZeR9dD3JnzVZWLkmgakzAhCYhZM33uNJjer0KRcxc+ToUg4
 JnTIsZ8ybILNm7xtlxyvhP6euH6igrBjfdnX7X4PbTRNQdGXVEiJC5vlD+UySj2d77
 UKNsWh8zTGBfEZFXb5Tc0tsYu57z4VAY8tWKCi9svD8NyBMQKXMATR1M0BMGYCjT1K
 hmw9p7jlWQWgJlAvfDdI6b/+Gci76hrMtD/1gB0yui27Xnbr/ChyLx7z5ed0/u+seN
 BlG5GguP9Eahykiwej41vQ8Wn/VBnwotRqmBwrU7mWJq74cWXUN/3+uCoXbnD36MwG
 lvwZj+WowXi8Q==
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
Subject: [PATCH v5 02/19] rust: drm: rename Uninit DeviceContext to Normal
Date: Sun, 28 Jun 2026 16:53:22 +0200
Message-ID: <20260628145406.2107056-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rename the Uninit DeviceContext to Normal to better reflect its purpose
as the general-purpose, reference-counted device context. The Uninit
name was a leftover from when DRM device private data initialization was
planned to split across UnregisteredDevice::new() and
Registration::new(); with the subsequent introduction of
RegistrationData, this distinction is no longer needed.

This also simplifies the DeviceContext documentation, trimming the
multi-stage initialization description that no longer applies.
Subsequent patches will refine the semantics of the Registered context
accordingly.

No functional change.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 92 ++++++++++++---------------------------
 rust/kernel/drm/mod.rs    |  2 +-
 2 files changed, 28 insertions(+), 66 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 477cf771fb10..5e91474e6dbb 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -74,36 +74,22 @@ macro_rules! drm_legacy_fields {
 
 /// A trait implemented by all possible contexts a [`Device`] can be used in.
 ///
-/// Setting up a new [`Device`] is a multi-stage process. Each step of the process that a user
-/// interacts with in Rust has a respective [`DeviceContext`] typestate. For example,
-/// `Device<T, Registered>` would be a [`Device`] that reached the [`Registered`] [`DeviceContext`].
+/// A [`Device`] can be in one of two contexts:
 ///
-/// Each stage of this process is described below:
-///
-/// ```text
-///        1                     2                         3
-/// +--------------+   +------------------+   +-----------------------+
-/// |Device created| → |Device initialized| → |Registered w/ userspace|
-/// +--------------+   +------------------+   +-----------------------+
-///    (Uninit)                                      (Registered)
-/// ```
-///
-/// 1. The [`Device`] is in the [`Uninit`] context and is not guaranteed to be initialized or
-///    registered with userspace. Only a limited subset of DRM core functionality is available.
-/// 2. The [`Device`] is guaranteed to be fully initialized, but is not guaranteed to be registered
-///    with userspace. All DRM core functionality which doesn't interact with userspace is
-///    available. We currently don't have a context for representing this.
-/// 3. The [`Device`] is guaranteed to be fully initialized, and is guaranteed to have been
-///    registered with userspace at some point - thus putting it in the [`Registered`] context.
-///
-/// An important caveat of [`DeviceContext`] which must be kept in mind: when used as a typestate
-/// for a reference type, it can only guarantee that a [`Device`] reached a particular stage in the
-/// initialization process _at the time the reference was taken_. No guarantee is made in regards to
-/// what stage of the process the [`Device`] is currently in. This means for instance that a
-/// `&Device<T, Uninit>` may actually be registered with userspace, it just wasn't known to be
-/// registered at the time the reference was taken.
+/// - [`Normal`]: The general-purpose, reference-counted context. A [`Device`] in this context may
+///   or may not be registered with userspace.
+/// - [`Registered`]: The device has been registered with userspace at some point.
 pub trait DeviceContext: Sealed + Send + Sync {}
 
+/// The general-purpose, reference-counted [`DeviceContext`].
+///
+/// A [`Device`] in this context may or may not be registered with userspace. This context is used
+/// for reference-counted device handles and during device setup via [`UnregisteredDevice`].
+pub struct Normal;
+
+impl Sealed for Normal {}
+impl DeviceContext for Normal {}
+
 /// The [`DeviceContext`] of a [`Device`] that was registered with userspace at some point.
 ///
 /// This represents a [`Device`] which is guaranteed to have been registered with userspace at
@@ -121,20 +107,6 @@ pub trait DeviceContext: Sealed + Send + Sync {}
 impl Sealed for Registered {}
 impl DeviceContext for Registered {}
 
-/// The [`DeviceContext`] of a [`Device`] that may be unregistered and partly uninitialized.
-///
-/// A [`Device`] in this context is only guaranteed to be partly initialized, and may or may not
-/// be registered with userspace. Thus operations which depend on the [`Device`] being fully
-/// initialized, or which depend on the [`Device`] being registered with userspace are not
-/// available through this [`DeviceContext`].
-///
-/// A [`Device`] in this context can be used to create a
-/// [`Registration`](drm::driver::Registration).
-pub struct Uninit;
-
-impl Sealed for Uninit {}
-impl DeviceContext for Uninit {}
-
 /// A [`Device`] which is known at compile-time to be unregistered with userspace.
 ///
 /// This type allows performing operations which are only safe to do before userspace registration,
@@ -147,10 +119,10 @@ impl DeviceContext for Uninit {}
 ///
 /// The device in `self.0` is guaranteed to be a newly created [`Device`] that has not yet been
 /// registered with userspace until this type is dropped.
-pub struct UnregisteredDevice<T: drm::Driver>(ARef<Device<T, Uninit>>, NotThreadSafe);
+pub struct UnregisteredDevice<T: drm::Driver>(ARef<Device<T, Normal>>, NotThreadSafe);
 
 impl<T: drm::Driver> Deref for UnregisteredDevice<T> {
-    type Target = Device<T, Uninit>;
+    type Target = Device<T, Normal>;
 
     fn deref(&self) -> &Self::Target {
         &self.0
@@ -178,15 +150,13 @@ const fn compute_features() -> u32 {
         master_drop: None,
         debugfs_init: None,
 
-        // Ignore the Uninit DeviceContext below. It is only provided because it is required by the
-        // compiler, and it is not actually used by these functions.
-        gem_create_object: T::Object::<Uninit>::ALLOC_OPS.gem_create_object,
-        prime_handle_to_fd: T::Object::<Uninit>::ALLOC_OPS.prime_handle_to_fd,
-        prime_fd_to_handle: T::Object::<Uninit>::ALLOC_OPS.prime_fd_to_handle,
-        gem_prime_import: T::Object::<Uninit>::ALLOC_OPS.gem_prime_import,
-        gem_prime_import_sg_table: T::Object::<Uninit>::ALLOC_OPS.gem_prime_import_sg_table,
-        dumb_create: T::Object::<Uninit>::ALLOC_OPS.dumb_create,
-        dumb_map_offset: T::Object::<Uninit>::ALLOC_OPS.dumb_map_offset,
+        gem_create_object: T::Object::<Normal>::ALLOC_OPS.gem_create_object,
+        prime_handle_to_fd: T::Object::<Normal>::ALLOC_OPS.prime_handle_to_fd,
+        prime_fd_to_handle: T::Object::<Normal>::ALLOC_OPS.prime_fd_to_handle,
+        gem_prime_import: T::Object::<Normal>::ALLOC_OPS.gem_prime_import,
+        gem_prime_import_sg_table: T::Object::<Normal>::ALLOC_OPS.gem_prime_import_sg_table,
+        dumb_create: T::Object::<Normal>::ALLOC_OPS.dumb_create,
+        dumb_map_offset: T::Object::<Normal>::ALLOC_OPS.dumb_map_offset,
 
         show_fdinfo: None,
         fbdev_probe: None,
@@ -211,7 +181,7 @@ const fn compute_features() -> u32 {
     pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<Self> {
         // `__drm_dev_alloc` uses `kmalloc()` to allocate memory, hence ensure a `kmalloc()`
         // compatible `Layout`.
-        let layout = Kmalloc::aligned_layout(Layout::new::<Device<T, Uninit>>());
+        let layout = Kmalloc::aligned_layout(Layout::new::<Device<T, Normal>>());
 
         // Use a temporary vtable without a `release` callback until `data` is initialized, so
         // init failure can release the DRM device without dropping uninitialized fields.
@@ -223,12 +193,12 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<S
         // SAFETY:
         // - `alloc_vtable` reference remains valid until no longer used,
         // - `dev` is valid by its type invarants,
-        let raw_drm: *mut Device<T, Uninit> = unsafe {
+        let raw_drm: *mut Device<T, Normal> = unsafe {
             bindings::__drm_dev_alloc(
                 dev.as_raw(),
                 &alloc_vtable,
                 layout.size(),
-                mem::offset_of!(Device<T, Uninit>, dev),
+                mem::offset_of!(Device<T, Normal>, dev),
             )
         }
         .cast();
@@ -264,16 +234,8 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<S
 
 /// A typed DRM device with a specific [`drm::Driver`] implementation and [`DeviceContext`].
 ///
-/// Since DRM devices can be used before being fully initialized and registered with userspace, `C`
-/// represents the furthest [`DeviceContext`] we can guarantee that this [`Device`] has reached.
-///
-/// Keep in mind: this means that an unregistered device can still have the registration state
-/// [`Registered`] as long as it was registered with userspace once in the past, and that the
-/// behavior of such a device is still well-defined. Additionally, a device with the registration
-/// state [`Uninit`] simply does not have a guaranteed registration state at compile time, and could
-/// be either registered or unregistered. Since there is no way to guarantee a long-lived reference
-/// to an unregistered device would remain unregistered, we do not provide a [`DeviceContext`] for
-/// this.
+/// A device in the [`Registered`] context is guaranteed to have been registered with userspace
+/// at some point. The [`Normal`] context is the general-purpose, reference-counted context.
 ///
 /// # Invariants
 ///
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index a66e7166f66b..e5bfaf130342 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -11,8 +11,8 @@
 
 pub use self::device::Device;
 pub use self::device::DeviceContext;
+pub use self::device::Normal;
 pub use self::device::Registered;
-pub use self::device::Uninit;
 pub use self::device::UnregisteredDevice;
 pub use self::driver::Driver;
 pub use self::driver::DriverInfo;
-- 
2.54.0

