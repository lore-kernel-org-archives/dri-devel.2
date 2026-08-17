Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E3C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDBB10E761;
	Mon, 17 Aug 2026 11:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hftFkH7Q";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB2F10E761
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786966880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6Xz9SzRekDuFjQRTihEV7izlswBoX4HzYpM9NVUmkg=;
 b=hftFkH7QPXRUoeYVxE/eujL5rNSVNnNIQPsXJVnq0jt23hZuq53fp0vThriXLqU/MlyLWx
 wXQwfWt78CTOVSAemm/y3IIAxSZahxLHSGyz5bmJVEOH2cLEFaZHKPJLOdzpVK+I88ctTh
 RAoIXqjlIWjPrOYVZkQBMqBTwMYBYjI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-0TWtXQM8OC-NJPliwDfYmQ-1; Mon,
 17 Aug 2026 07:41:14 -0400
X-MC-Unique: 0TWtXQM8OC-NJPliwDfYmQ-1
X-Mimecast-MFC-AGG-ID: 0TWtXQM8OC-NJPliwDfYmQ_1786966872
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E16241956069; Mon, 17 Aug 2026 11:41:11 +0000 (UTC)
Received: from [192.168.1.153] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EF44423; Mon, 17 Aug 2026 11:41:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 17 Aug 2026 13:40:48 +0200
Subject: [PATCH 3/5] rust: drm: add panel consumer abstractions
MIME-Version: 1.0
Message-Id: <20260817-drm_panel_bindings-v1-3-1f974508a31c@redhat.com>
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
In-Reply-To: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786966849; l=11877;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=gKhVm8XBGs7x/Liyol8f7STgqIpe5f31i5j5M/rx+4U=;
 b=MdjJz7j1F5Y9JB+An3y2Kzpeky34AJRWOojwnNzQJYW5ZnS2df5gKLpCSQlvxV1CPWmmL69e8
 YYO45pMMpa1BUP/ZPk2MjJtTXksUpPbiRhpBWv44MXy/SggWe8G/FhF
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 5CGM-2Kh6yiiYHm3N9T-QjnUK0AvgS8VrqYtK-X2Pi0_1786966872
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Add Rust abstraction for the DRM panel subsystem, covering
the consumer side of the panel API.

`Panel` wraps a reference-counted `struct drm_panel` and
implements `AlwaysRefCounted`. It exposes consumer-side lifecycle
operations and provides `from_of_node()` associated method for
looking up a registered panel by device tree node.

`PanelOrientation` wraps `enum drm_panel_orientation` and
provides `from_of_node()` to read "rotation" property from
the device tree.

`Registration` manages the panel's presence in the global
registry, decoupling its lifetime from reference count lifetime.

Following patches will handle the producer side.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/drm.c              |  15 +++
 rust/kernel/drm/mod.rs          |   1 +
 rust/kernel/drm/panel.rs        | 227 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7f3030ac0feb6..0f23d323cbb24 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -33,6 +33,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
diff --git a/rust/helpers/drm.c b/rust/helpers/drm.c
index 65f3f22b0e1d2..fc5b9af6e4d23 100644
--- a/rust/helpers/drm.c
+++ b/rust/helpers/drm.c
@@ -2,6 +2,7 @@
 
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_vma_manager.h>
 
 #ifdef CONFIG_DRM
@@ -75,4 +76,18 @@ rust_helper_drm_gem_shmem_object_mmap(struct drm_gem_object *obj, struct vm_area
 }
 
 #endif /* CONFIG_DRM_GEM_SHMEM_HELPER */
+
+__rust_helper struct drm_panel *
+rust_helper_of_drm_find_panel(const struct device_node *np)
+{
+	return of_drm_find_panel(np);
+}
+
+__rust_helper int
+rust_helper_of_drm_get_panel_orientation(const struct device_node *np,
+					 enum drm_panel_orientation *orientation)
+{
+	return of_drm_get_panel_orientation(np, orientation);
+}
+
 #endif /* CONFIG_DRM */
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index 672ea8728e1c3..d1de5d448a1a5 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -9,6 +9,7 @@
 pub mod gem;
 pub mod gpuvm;
 pub mod ioctl;
+pub mod panel;
 
 pub use self::device::Device;
 pub use self::device::DeviceContext;
diff --git a/rust/kernel/drm/panel.rs b/rust/kernel/drm/panel.rs
new file mode 100644
index 0000000000000..fd21cc2236685
--- /dev/null
+++ b/rust/kernel/drm/panel.rs
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! DRM panel abstractions.
+//!
+//! C header: [`include/drm/drm_panel.h`](srctree/include/drm/drm_panel.h)
+
+use crate::drm::connector::Connector;
+use crate::{
+    bindings, error, of,
+    prelude::*,
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
+};
+use core::ptr::NonNull;
+
+/// A DRM panel object.
+///
+/// Wraps `struct drm_panel`. Instances are reference-counted via [`drm_panel_get`] and
+/// [`drm_panel_put`]; use [`ARef<Panel>`] to hold an owned reference.
+///
+/// The DRM panel methods allow drivers to register panel objects with a
+/// central registry and provide functions to retrieve those panels in display
+/// drivers.
+///
+/// # Invariants
+///
+/// The inner pointer is always a valid, non-null pointer to a `struct drm_panel` with a
+/// positive reference count.
+///
+/// [`drm_panel_get`]: srctree/include/drm/drm_panel.h
+/// [`drm_panel_put`]: srctree/include/drm/drm_panel.h
+#[repr(transparent)]
+pub struct Panel(Opaque<bindings::drm_panel>);
+
+impl Panel {
+    /// Creates a reference from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid, non-null `struct drm_panel` pointer that remains
+    /// valid for the lifetime `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::drm_panel) -> &'a Self {
+        // SAFETY: Caller guarantees `ptr` is valid and lives for `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the raw pointer to the underlying `struct drm_panel`.
+    pub fn as_raw(&self) -> *mut bindings::drm_panel {
+        self.0.get()
+    }
+
+    /// Power on a panel.
+    ///
+    /// Calling this function will enable power and deassert any reset signals to
+    /// the panel. After this has completed it is possible to communicate with any
+    /// integrated circuitry via a command bus. This function cannot fail (as it is
+    /// called from the pre_enable call chain). There will always be a call to
+    /// [`Panel::disable`] afterwards.
+    pub fn prepare(&self) {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::drm_panel_prepare(self.as_raw()) }
+    }
+
+    /// Power off a panel.
+    ///
+    /// Calling this function will completely power off a panel (assert the panel's
+    /// reset, turn off power supplies, ...). After this function has completed, it
+    /// is usually no longer possible to communicate with the panel until another
+    /// call to [`Panel::prepare`].
+    pub fn unprepare(&self) {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::drm_panel_unprepare(self.as_raw()) }
+    }
+
+    /// Enable a panel.
+    ///
+    /// Calling this function will cause the panel display drivers to be turned on
+    /// and the backlight to be enabled. Content will be visible on screen after
+    /// this call completes. This function cannot fail (as it is called from the
+    /// enable call chain). There will always be a call to [`Panel::disable`]
+    /// afterwards.
+    pub fn enable(&self) {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::drm_panel_enable(self.as_raw()) }
+    }
+
+    /// Disable a panel.
+    ///
+    /// This will typically turn off the panel's backlight or disable the display
+    /// drivers. For smart panels it should still be possible to communicate with
+    /// the integrated circuitry via any command bus after this call.
+    pub fn disable(&self) {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::drm_panel_disable(self.as_raw()) }
+    }
+
+    /// Probe the available display modes of a panel.
+    ///
+    /// The modes probed from the panel are automatically added to the connector
+    /// that the panel is attached to.
+    ///
+    /// Return: The number of modes available from the panel on success, or 0 on
+    /// failure (no modes).
+    pub fn get_modes(&self, connector: &Connector) -> i32 {
+        // SAFETY: The type invariants guarantee the pointers are valid.
+        unsafe { bindings::drm_panel_get_modes(self.as_raw(), connector.as_raw()) } as i32
+    }
+
+    /// Use backlight device node for backlight.
+    ///
+    /// Use this function to enable backlight handling if your panel
+    /// uses device tree and has a backlight phandle.
+    ///
+    /// When the panel is enabled backlight will be enabled after a
+    /// successful call to [`Panel::enable`].
+    ///
+    /// When the panel is disabled backlight will be disabled before the
+    /// call to [`Panel::disable`].
+    ///
+    /// A typical implementation for a panel driver supporting device tree
+    /// will call this function at probe time. Backlight will then be handled
+    /// transparently without requiring any intervention from the driver.
+    #[cfg(CONFIG_BACKLIGHT_CLASS_DEVICE)]
+    pub fn of_backlight(&self) -> Result<()> {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        error::to_result(unsafe { bindings::drm_panel_of_backlight(self.as_raw()) })?;
+        Ok(())
+    }
+
+    /// Look up the panel associated with the given device tree node.
+    ///
+    /// Searches the set of registered panels for one that matches the given device
+    /// tree node. If a matching panel is found, return a pointer to it.
+    pub fn from_of_node(node: &of::Node) -> Result<ARef<Self>> {
+        // SAFETY: `node.as_raw()` is a valid device_node pointer.
+        let panel = error::from_err_ptr(unsafe { bindings::of_drm_find_panel(node.as_raw()) })?;
+
+        // SAFETY: `from_err_ptr` guarantees a non-null pointer on success.
+        // `of_drm_find_panel` returns a kref-incremented reference.
+        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(panel).cast()) })
+    }
+}
+
+// SAFETY: By the type invariants, this type is always refcounted.
+unsafe impl AlwaysRefCounted for Panel {
+    fn inc_ref(&self) {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::drm_panel_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The existence of `obj` guarantees the refcount is positive.
+        unsafe { bindings::drm_panel_put(obj.cast().as_ptr()) };
+    }
+}
+
+/// This enum is used to track the (LCD) panel orientation.
+///
+/// C header: [`include/drm/drm_connector.h`](srctree/include/drm/drm_connector.h)
+#[repr(i32)]
+pub enum PanelOrientation {
+    /// The drm driver has not provided any panel orientation information.
+    Unknown = -1,
+    /// The top side of the panel matches the top side of the device's casing.
+    Normal = 0,
+    /// The top side of the panel matches the bottom side of the device's casing.
+    BottomUp = 1,
+    /// The left side of the panel matches the top side of the device's casing.
+    LeftUp = 2,
+    /// The right side of the panel matches the top side of the device's casing.
+    RightUp = 3,
+}
+
+impl TryFrom<i32> for PanelOrientation {
+    type Error = Error;
+    fn try_from(v: i32) -> Result<Self> {
+        match v {
+            -1 => Ok(Self::Unknown),
+            0 => Ok(Self::Normal),
+            1 => Ok(Self::BottomUp),
+            2 => Ok(Self::LeftUp),
+            3 => Ok(Self::RightUp),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl PanelOrientation {
+    /// Look up the orientation of the panel through the "rotation" binding
+    /// from a device tree node
+    ///
+    /// Looks up the rotation of a panel in the device tree. The orientation of the
+    /// panel is expressed as a property name "rotation" in the device tree. The
+    /// rotation in the device tree is counter clockwise.
+    pub fn from_of_node(node: &of::Node) -> Result<Self> {
+        let mut orientation = 0i32;
+        // SAFETY: `node.as_raw()` is a valid device_node pointer.
+        error::to_result(unsafe {
+            bindings::of_drm_get_panel_orientation(node.as_raw(), &mut orientation)
+        })?;
+        Ok(PanelOrientation::try_from(orientation)?)
+    }
+}
+
+/// A registration of a panel to the global panel registry.
+pub struct Registration(ARef<Panel>);
+
+impl Registration {
+    /// Registers a panel with the global panel registry.
+    pub fn register(panel: ARef<Panel>) -> Self {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::drm_panel_add(panel.as_raw()) };
+        Self(panel)
+    }
+
+    /// Returns a reference to the panel.
+    pub fn panel(&self) -> &Panel {
+        &self.0
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::drm_panel_remove(self.0.as_raw()) };
+    }
+}

-- 
2.55.0

