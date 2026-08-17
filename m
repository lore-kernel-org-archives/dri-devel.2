Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7D0C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C42410E766;
	Mon, 17 Aug 2026 11:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jKNESjn8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E52F10E766
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786966886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RAgrzHZYe2l55ocIc4U6z1x+YgIHjnqqwdVi242aYk=;
 b=jKNESjn8yD22uEpNBpnxgrZnCxrD088Io4wgd+nNKVCAEnU/MESZyAvg/lEcZ+Zh38zD54
 6HkDneA/X3eMp1S6ghY7kaftt5loVO/pFvqe+3enaiL1NwHhjoxSGwceRgzHIdTtjj7SxV
 dqALhSGpcGoxakzUbTY+969GQRdkMEo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-zMmBDt2KPT-FSVb_H4Oc8Q-1; Mon,
 17 Aug 2026 07:41:21 -0400
X-MC-Unique: zMmBDt2KPT-FSVb_H4Oc8Q-1
X-Mimecast-MFC-AGG-ID: zMmBDt2KPT-FSVb_H4Oc8Q_1786966878
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE8A5195609D; Mon, 17 Aug 2026 11:41:17 +0000 (UTC)
Received: from [192.168.1.153] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 540EA426; Mon, 17 Aug 2026 11:41:12 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 17 Aug 2026 13:40:49 +0200
Subject: [PATCH 4/5] rust: drm: add panel producer abstractions
MIME-Version: 1.0
Message-Id: <20260817-drm_panel_bindings-v1-4-1f974508a31c@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786966849; l=17932;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=93LQvEkhKRf7JgS8cXWiOHE5WFGnK0FXkIOKmrKDAZ0=;
 b=WFfgJZ1mGm+21yJAM36wpwxn2zJE+VA9e53E0uDuIJwfGzEMmZqD5LA3fuxOr5udpJXZAYslA
 LS73LQsUr9HB5I93ozKM4ccO+7/K2M91rtPj8cYOXf9cnkGmyNwSPy8
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: TZ_XNXJ2VM_k0J3lmy82mrSHsdPcnH5LcSuN8eYKHiI_1786966878
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

`PanelFuncs` is a `#[vtable]` trait that panel drivers implement to
provide their callbacks.

`PanelFuncsVTable` builds a `struct drm_panel_funcs` from `PanelFuncs`
through `extern "C"` trampolines, using the `HAS_*` flags generated by
`#[vtable]` to populate optional callbacks selectively.

`PanelContainer<T>` is a `#[repr(C)]` struct embedding `ManuallyDrop<T>`
at offset zero followed by the `drm_panel`. This layout lets
`__devm_drm_panel_alloc` allocate both in a single `kzalloc` call with
`panel->container` pointing to the base, so `__drm_panel_free` can call
`kfree(container)` to free the entire block. A separate
`devm_add_action_or_reset` runs `drop_in_place::<T>` before the memory
is reclaimed, ensuring T's destructor is called at the right time.

`Panel::new` wraps `__devm_drm_panel_alloc` and ties the above together,
returning an `ARef<Panel>`. Registration with the global registry is kept
separate via `Registration::register`, following the pattern established
by `drm::Device::new`.

`ConnectorType` mirrors the `DRM_MODE_CONNECTOR_*` defines from
`include/uapi/drm/drm_mode.h`, required by `Panel::new` to specify the
panel's connector type.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 rust/kernel/drm/panel.rs | 376 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 373 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/panel.rs b/rust/kernel/drm/panel.rs
index fd21cc2236685..8f87774e06ed7 100644
--- a/rust/kernel/drm/panel.rs
+++ b/rust/kernel/drm/panel.rs
@@ -6,11 +6,15 @@
 
 use crate::drm::connector::Connector;
 use crate::{
-    bindings, error, of,
+    bindings,
+    device::Device,
+    error, of,
     prelude::*,
     sync::aref::{ARef, AlwaysRefCounted},
     types::Opaque,
 };
+use core::marker::PhantomData;
+use core::mem::{ManuallyDrop, MaybeUninit};
 use core::ptr::NonNull;
 
 /// A DRM panel object.
@@ -103,7 +107,7 @@ pub fn disable(&self) {
     /// failure (no modes).
     pub fn get_modes(&self, connector: &Connector) -> i32 {
         // SAFETY: The type invariants guarantee the pointers are valid.
-        unsafe { bindings::drm_panel_get_modes(self.as_raw(), connector.as_raw()) } as i32
+        unsafe { bindings::drm_panel_get_modes(self.as_raw(), connector.as_raw()) }
     }
 
     /// Use backlight device node for backlight.
@@ -139,6 +143,66 @@ pub fn from_of_node(node: &of::Node) -> Result<ARef<Self>> {
         // `of_drm_find_panel` returns a kref-incremented reference.
         Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(panel).cast()) })
     }
+
+    /// Allocates and initialises a device-managed panel.
+    ///
+    /// `data` is embedded in the same allocation as the `drm_panel` and its
+    /// destructor is called automatically when `dev` is unbound.
+    ///
+    /// Use [`Registration::register`] to add the panel to the global registry
+    /// once it is ready to be used by display drivers.
+    pub fn new<T: PanelFuncs>(
+        dev: &Device,
+        data: T,
+        connector_type: ConnectorType,
+    ) -> Result<ARef<Self>> {
+        // SAFETY: `dev` is valid by its type invariants; `PanelFuncsVTable::build()`
+        // returns a valid, static `drm_panel_funcs` pointer.
+        let container = error::from_err_ptr(unsafe {
+            bindings::__devm_drm_panel_alloc(
+                dev.as_raw(),
+                core::mem::size_of::<PanelContainer<T>>(),
+                core::mem::offset_of!(PanelContainer<T>, panel),
+                PanelFuncsVTable::<T>::build(),
+                connector_type as i32,
+            )
+        })? as *mut PanelContainer<T>;
+
+        // SAFETY: `container` is a valid pointer to uninitialized memory.
+        unsafe {
+            core::ptr::write(
+                core::ptr::addr_of_mut!((*container).data),
+                ManuallyDrop::new(data),
+            )
+        };
+
+        // SAFETY:
+        // - `dev.as_raw()` is a pointer to a valid and bound device.
+        // - `container.cast()` is a valid pointer to the initialized `PanelContainer<T>`.
+        error::to_result(unsafe {
+            // `devm_add_action_or_reset` calls `drop_panel_data` on failure, so `data`
+            // is dropped even if this registration fails.
+            // Registering after `__devm_drm_panel_alloc` ensures devres LIFO order:
+            // `drop_panel_data` runs before `kfree(container)`.
+            bindings::devm_add_action_or_reset(
+                dev.as_raw(),
+                Some(drop_panel_data::<T>),
+                container.cast(),
+            )
+        })?;
+
+        // SAFETY: `__devm_drm_panel_alloc` was successful, hence `container` is
+        // valid and the `drm_panel` at this offset is initialised.
+        let raw = unsafe {
+            (container as *mut u8)
+                .add(core::mem::offset_of!(PanelContainer<T>, panel))
+                .cast::<bindings::drm_panel>()
+        };
+
+        // SAFETY: `__devm_drm_panel_alloc` was successful, hence `raw` is valid
+        // and the refcount is non-zero.
+        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(raw).cast()) })
+    }
 }
 
 // SAFETY: By the type invariants, this type is always refcounted.
@@ -149,7 +213,7 @@ fn inc_ref(&self) {
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
-        // SAFETY: The existence of `obj` guarantees the refcount is positive.
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
         unsafe { bindings::drm_panel_put(obj.cast().as_ptr()) };
     }
 }
@@ -202,6 +266,87 @@ pub fn from_of_node(node: &of::Node) -> Result<Self> {
     }
 }
 
+/// The type of a DRM connector.
+///
+/// Mirrors the `DRM_MODE_CONNECTOR_*` defines in
+/// [`include/uapi/drm/drm_mode.h`](srctree/include/uapi/drm/drm_mode.h).
+#[repr(u32)]
+pub enum ConnectorType {
+    /// Unknown connector type (`DRM_MODE_CONNECTOR_Unknown`).
+    Unknown = 0,
+    /// VGA connector (`DRM_MODE_CONNECTOR_VGA`).
+    VGA = 1,
+    /// DVI-I connector (`DRM_MODE_CONNECTOR_DVII`).
+    DVII = 2,
+    /// DVI-D connector (`DRM_MODE_CONNECTOR_DVID`).
+    DVID = 3,
+    /// DVI-A connector (`DRM_MODE_CONNECTOR_DVIA`).
+    DVIA = 4,
+    /// Composite connector (`DRM_MODE_CONNECTOR_Composite`).
+    Composite = 5,
+    /// S-Video connector (`DRM_MODE_CONNECTOR_SVIDEO`).
+    SVIDEO = 6,
+    /// LVDS connector (`DRM_MODE_CONNECTOR_LVDS`).
+    LVDS = 7,
+    /// Component connector (`DRM_MODE_CONNECTOR_Component`).
+    Component = 8,
+    /// 9-pin DIN connector (`DRM_MODE_CONNECTOR_9PinDIN`).
+    NinePinDin = 9,
+    /// DisplayPort connector (`DRM_MODE_CONNECTOR_DisplayPort`).
+    DisplayPort = 10,
+    /// HDMI type A connector (`DRM_MODE_CONNECTOR_HDMIA`).
+    HDMIA = 11,
+    /// HDMI type B connector (`DRM_MODE_CONNECTOR_HDMIB`).
+    HDMIB = 12,
+    /// TV connector (`DRM_MODE_CONNECTOR_TV`).
+    TV = 13,
+    /// Embedded DisplayPort connector (`DRM_MODE_CONNECTOR_eDP`).
+    #[allow(non_camel_case_types)]
+    eDP = 14,
+    /// Virtual connector (`DRM_MODE_CONNECTOR_VIRTUAL`).
+    Virtual = 15,
+    /// MIPI DSI connector (`DRM_MODE_CONNECTOR_DSI`).
+    DSI = 16,
+    /// DPI connector (`DRM_MODE_CONNECTOR_DPI`).
+    DPI = 17,
+    /// Writeback connector (`DRM_MODE_CONNECTOR_WRITEBACK`).
+    Writeback = 18,
+    /// SPI connector (`DRM_MODE_CONNECTOR_SPI`).
+    SPI = 19,
+    /// USB connector (`DRM_MODE_CONNECTOR_USB`).
+    USB = 20,
+}
+
+impl TryFrom<u32> for ConnectorType {
+    type Error = Error;
+    fn try_from(v: u32) -> Result<Self> {
+        match v {
+            0 => Ok(Self::Unknown),
+            1 => Ok(Self::VGA),
+            2 => Ok(Self::DVII),
+            3 => Ok(Self::DVID),
+            4 => Ok(Self::DVIA),
+            5 => Ok(Self::Composite),
+            6 => Ok(Self::SVIDEO),
+            7 => Ok(Self::LVDS),
+            8 => Ok(Self::Component),
+            9 => Ok(Self::NinePinDin),
+            10 => Ok(Self::DisplayPort),
+            11 => Ok(Self::HDMIA),
+            12 => Ok(Self::HDMIB),
+            13 => Ok(Self::TV),
+            14 => Ok(Self::eDP),
+            15 => Ok(Self::Virtual),
+            16 => Ok(Self::DSI),
+            17 => Ok(Self::DPI),
+            18 => Ok(Self::Writeback),
+            19 => Ok(Self::SPI),
+            20 => Ok(Self::USB),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
 /// A registration of a panel to the global panel registry.
 pub struct Registration(ARef<Panel>);
 
@@ -225,3 +370,228 @@ fn drop(&mut self) {
         unsafe { bindings::drm_panel_remove(self.0.as_raw()) };
     }
 }
+
+/// Operations implemented by a DRM panel driver.
+///
+/// Implement this trait to provide a DRM panel driver and its callbacks. Use
+/// [`Panel::new`] to allocate the panel, passing the driver data as `T`.
+///
+/// C header: [`include/drm/drm_panel.h`](srctree/include/drm/drm_panel.h)
+#[vtable]
+pub trait PanelFuncs {
+    /// Turn on panel and perform set up.
+    ///
+    /// This function is optional.
+    fn prepare(&self, _panel: &Panel) -> Result<()> {
+        Ok(())
+    }
+
+    /// Turn off panel.
+    ///
+    /// This function is optional.
+    fn unprepare(&self, _panel: &Panel) -> Result<()> {
+        Ok(())
+    }
+
+    /// Enable panel (turn on back light, etc.).
+    ///
+    /// This function is optional.
+    fn enable(&self, _panel: &Panel) -> Result<()> {
+        Ok(())
+    }
+
+    /// Disable panel (turn off back light, etc.).
+    ///
+    /// This function is optional.
+    fn disable(&self, _panel: &Panel) -> Result<()> {
+        Ok(())
+    }
+
+    /// Add modes to the connector that the panel is attached to
+    /// and returns the number of modes added.
+    ///
+    /// This function is mandatory.
+    fn get_modes(&self, _panel: &Panel, _connector: &Connector) -> i32 {
+        build_error!("get_modes is mandatory")
+    }
+
+    /// Return the panel orientation set by device tree or EDID.
+    ///
+    /// This function is optional.
+    fn get_orientation(&self, _panel: &Panel) -> PanelOrientation {
+        PanelOrientation::Unknown
+    }
+}
+
+// Outer allocation layout used by `Panel::new`.
+//
+// `__devm_drm_panel_alloc` allocates a block of `size_of::<PanelContainer<T>>()`
+// bytes, places `drm_panel` at `offset_of!(PanelContainer<T>, panel)`, and
+// stores the block's base address in `panel->container`.
+//
+// Lifetime:
+//   1. A devres action registered right after allocation calls `drop_in_place`
+//      on the `data` field (T's destructor) when the device is unbound.
+//   2. `__drm_panel_free` calls `kfree(panel->container)` when the kref hits
+//      zero, freeing the entire block.
+//
+// `data` is `ManuallyDrop<T>` so that Rust does not implicitly drop it; the
+// devres action owns the destructor call.
+#[repr(C)]
+struct PanelContainer<T> {
+    data: ManuallyDrop<T>,
+    panel: MaybeUninit<bindings::drm_panel>,
+}
+
+// Devres action: run T's destructor before `kfree(container)`.
+//
+// # Safety
+//
+// `ptr` must be the base of a live `PanelContainer<T>` whose `data` field was
+// initialised by `Panel::new` and has not yet been dropped.
+unsafe extern "C" fn drop_panel_data<T>(ptr: *mut core::ffi::c_void) {
+    // SAFETY: Caller guarantees `ptr` is the base of a live `PanelContainer<T>`
+    // with an initialised `data` field. `data` is at offset 0, so `ptr as *mut T`
+    // is valid.
+    unsafe { core::ptr::drop_in_place(ptr as *mut T) };
+}
+
+/// A vtable for the DRM core to interact with a panel driver.
+///
+/// A `bindings::drm_panel_funcs` vtable is constructed from pointers to the
+/// `extern "C"` functions of this struct, exposed through
+/// `PanelFuncsVTable::VTABLE`.
+///
+/// For general documentation of these methods, see the kernel source
+/// documentation related to `struct drm_panel_funcs` in
+/// [`include/drm/drm_panel.h`].
+///
+/// [`include/drm/drm_panel.h`]: srctree/include/drm/drm_panel.h
+pub(crate) struct PanelFuncsVTable<T: PanelFuncs>(PhantomData<T>);
+
+impl<T: PanelFuncs> PanelFuncsVTable<T> {
+    // Recover &T from panel->container.
+    //
+    // # Safety
+    //
+    // `panel` must be a valid pointer to a live `drm_panel` allocated by
+    // `Panel::new`, whose `container` field points to the base of a live
+    // `PanelContainer<T>` with an initialised `data` field.
+    unsafe fn data_from_panel<'a>(panel: *mut bindings::drm_panel) -> &'a T {
+        // SAFETY: Caller guarantees `panel` is valid and `panel->container` points
+        // to the base of a live `PanelContainer<T>` with an initialised `data`
+        // field. `data` is at offset 0, so `container as *const T` is valid.
+        unsafe { &*((*panel).container as *const T) }
+    }
+
+    unsafe extern "C" fn prepare_callback(panel: *mut bindings::drm_panel) -> i32 {
+        // SAFETY: The C DRM core only invokes callbacks on a live, initialised
+        // panel allocated by `Panel::new` (see `data_from_panel`).
+        let data = unsafe { Self::data_from_panel(panel) };
+        // SAFETY: `panel` is a valid `drm_panel` pointer per the callback contract.
+        let panel_ref = unsafe { Panel::from_raw(panel) };
+        match T::prepare(data, panel_ref) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    unsafe extern "C" fn unprepare_callback(panel: *mut bindings::drm_panel) -> i32 {
+        // SAFETY: The C DRM core only invokes callbacks on a live, initialised
+        // panel allocated by `Panel::new` (see `data_from_panel`).
+        let data = unsafe { Self::data_from_panel(panel) };
+        // SAFETY: `panel` is a valid `drm_panel` pointer per the callback contract.
+        let panel_ref = unsafe { Panel::from_raw(panel) };
+        match T::unprepare(data, panel_ref) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    unsafe extern "C" fn enable_callback(panel: *mut bindings::drm_panel) -> i32 {
+        // SAFETY: The C DRM core only invokes callbacks on a live, initialised
+        // panel allocated by `Panel::new` (see `data_from_panel`).
+        let data = unsafe { Self::data_from_panel(panel) };
+        // SAFETY: `panel` is a valid `drm_panel` pointer per the callback contract.
+        let panel_ref = unsafe { Panel::from_raw(panel) };
+        match T::enable(data, panel_ref) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    unsafe extern "C" fn disable_callback(panel: *mut bindings::drm_panel) -> i32 {
+        // SAFETY: The C DRM core only invokes callbacks on a live, initialised
+        // panel allocated by `Panel::new` (see `data_from_panel`).
+        let data = unsafe { Self::data_from_panel(panel) };
+        // SAFETY: `panel` is a valid `drm_panel` pointer per the callback contract.
+        let panel_ref = unsafe { Panel::from_raw(panel) };
+        match T::disable(data, panel_ref) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    unsafe extern "C" fn get_modes_callback(
+        panel: *mut bindings::drm_panel,
+        connector: *mut bindings::drm_connector,
+    ) -> i32 {
+        // SAFETY: The C DRM core only invokes callbacks on a live, initialised
+        // panel allocated by `Panel::new` (see `data_from_panel`).
+        let data = unsafe { Self::data_from_panel(panel) };
+        // SAFETY: `panel` is a valid `drm_panel` pointer per the callback contract.
+        let panel_ref = unsafe { Panel::from_raw(panel) };
+        // SAFETY: `connector` is a valid, non-null `drm_connector` pointer
+        // supplied by the DRM core for the duration of the callback.
+        let connector_ref = unsafe { Connector::from_raw(connector) };
+        T::get_modes(data, panel_ref, connector_ref)
+    }
+
+    unsafe extern "C" fn get_orientation_callback(panel: *mut bindings::drm_panel) -> i32 {
+        // SAFETY: The C DRM core only invokes callbacks on a live, initialised
+        // panel allocated by `Panel::new` (see `data_from_panel`).
+        let data = unsafe { Self::data_from_panel(panel) };
+        // SAFETY: `panel` is a valid `drm_panel` pointer per the callback contract.
+        let panel_ref = unsafe { Panel::from_raw(panel) };
+        T::get_orientation(data, panel_ref) as i32
+    }
+
+    const VTABLE: bindings::drm_panel_funcs = bindings::drm_panel_funcs {
+        // Initialize optional callbacks based on the traits of `T`.
+        prepare: if T::HAS_PREPARE {
+            Some(Self::prepare_callback)
+        } else {
+            None
+        },
+        unprepare: if T::HAS_UNPREPARE {
+            Some(Self::unprepare_callback)
+        } else {
+            None
+        },
+        enable: if T::HAS_ENABLE {
+            Some(Self::enable_callback)
+        } else {
+            None
+        },
+        disable: if T::HAS_DISABLE {
+            Some(Self::disable_callback)
+        } else {
+            None
+        },
+        get_orientation: if T::HAS_GET_ORIENTATION {
+            Some(Self::get_orientation_callback)
+        } else {
+            None
+        },
+
+        // Initialize mandatory callbacks.
+        get_modes: Some(Self::get_modes_callback),
+
+        get_timings: None,
+        debugfs_init: None,
+    };
+
+    pub(crate) const fn build() -> &'static bindings::drm_panel_funcs {
+        &Self::VTABLE
+    }
+}

-- 
2.55.0

