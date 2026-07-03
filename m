Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609BCC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9BE10F5F7;
	Fri,  3 Jul 2026 03:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="kElVOhY1";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF33610F5F7
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:42 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so590165f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047701; x=1783652501;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX+j4GjseoiCPFw3EfmCmbTSaMoPGlBM4ySiKg5qPW4=;
 b=kElVOhY1s4cyJJfeVOGCvlOjwZ3Uk3SBXMPOHa6J39fMZ3AMmCxE8oMKpOag+H/ml6
 kR6VoYu/uV8daI2BkDe8O89dGpof32c4fx6wALRf71Z54/Kgv9OTY3m16gzXOWFae0CQ
 7Emko/KM3L3z5pw1TB54i66F8Li3JZqHs6qTyhZ/stPZYKvuAvVcQlqcbDeoJvfCJQ9i
 qdtfYsQG+ZTTAPy5n3fKZFXa9wqvYnTd7MbHjpSsLv+mOM/CGfcZh/hHy69VrePy2gBb
 bYcqZa6gr7nDCZGFyyGoBnMa/fgqaoTL+PM5c+1YiOs3krE/tDBxcw3/mlLCXCWaCxdK
 gQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047701; x=1783652501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CX+j4GjseoiCPFw3EfmCmbTSaMoPGlBM4ySiKg5qPW4=;
 b=kmGMErhyF0MTkqOmwiyyQt5GJFSQLbrr2Kg/1L2k+CzNFFO2YjNBJBB/bCHyNtP6FK
 hkbWoWVEbqNgsIKkI7sklnG80GqqjYFTApl6+gIpHp+6PI6sbPNQ8S0izRc84DrlWLul
 Ey7TOYX1yrFS8UpyX9AKaqKM+SFEfOVpLPTq8mE+xoh/9G/SK7hoiMdgnnryZOSlNf9C
 ZarpD+xhaTSMxAoJrGLGrMpEhYaGfr4+e/67Hb8sXMbzRWfZ3HXkRYquDEyQm2JTIIj9
 /7RSNSSw43ukEfZT0GjYQKHNwmNG4Xvalm4JMF1zmRhIaMoIGYStIeYUDjHYiiyVjRy/
 iT4g==
X-Gm-Message-State: AOJu0YxtMNL5qUuG+IVhNdUbAYxCza7/HcyL4zaBUSPc2ps6M6bfSkJw
 6n1f3gLyRYyzVOSbOeMh4AenrIE9nG7zI90SEMAyeDqRqtCq+qS5qyeCxwdOlWzqbg==
X-Gm-Gg: AfdE7cmj1A1m06seiVo9pglDyAw40SpbxMcXYwRw4mgR4luHibSvtlsnegwchAj0RV9
 NIVYNHcN0SUpOhZO8KHgm1OcSqxViKEWE7xPOVAD8ZDu7kjM4sHDahc5qzEvPLsvPzDkldUnX/B
 nFo/wCHaPTxWuIPR9I20pjqbGMDS2FZUDePSAUHAjgMnnsLXrbRfJj7iV2uC3wntandidj/pavu
 HR0BeY3K9UGZT68SceZYoTrEVTZ1aaYXNLeYRtcSwnO0HWY4HIx2yHreHFuD+21iU8qjmgCCd3Y
 pEI75u2J/efgPL4CWP9op1uBfJn650ZrJSoU3L6Mdvlb6tJXcg2kkTXm/XEkXwSjciZbUUxOiNy
 2kFMSPAxju5uzIEj+SFBWoOLNtlXJkcxvWIamFQXmc6ELXHADZLK1qNy9YzTYfpG4eHRqaK4wMJ
 YV5da6LKhiLeUPUA7impukPHz8YHAUtAts0PMOAydlfnzFWgWBKdJTFFOz
X-Received: by 2002:a05:6000:41d0:b0:470:e26d:88ff with SMTP id
 ffacd0b85a97d-479343d1d3dmr3253927f8f.4.1783047701016; 
 Thu, 02 Jul 2026 20:01:41 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:40 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 04/18] rust: drm: kms: build the kernel crate clean
 under -Znext-solver
Date: Fri,  3 Jul 2026 04:00:51 +0100
Message-ID: <20260703030123.2814-5-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
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

The coinductive cycle from the previous commit isn't a bug in this
port -- it's inherent to the mutual type Driver / type State / type
Crtc references in the mode-object traits, and the current trait
solver can't evaluate a coinductive obligation without unbounded
memory, regardless of where the bounds are placed. Disabling the
unused from_opaque-on-state impls doesn't help either: their errors
were masking the same explosion one level down.

The next-generation trait solver (-Znext-solver) does handle it. Scope
it to the kernel crate only in rust/Makefile rather than globally, so
core/alloc/etc. stay on the old solver -- core.o ICEs under
-Znext-solver on this toolchain, and there's no reason to pay that
cost crate-wide when only kernel/ needs the new solver's coinductive
support.

rust/kernel.o now builds with 0 errors, safe KMS layer included. Fixes
needed to get there once the solver could actually evaluate the web:
restore the pinned associated-type bounds (no back-edge cuts needed
under the new solver); add Device::event_lock(), ModeConfigGuard::new();
import AlwaysRefCounted/SpinLockIrq; Driver*::new() takes
&Device<.., Uninit> since objects are created during probe; base drift
in drm_crtc_helper_funcs (drop mode_set_base_atomic, add
handle_vblank_timeout); device.rs T::Object::<Uninit>::ALLOC_OPS and a
probe_kms Option rewrite; driver.rs captures preferred_fourcc and uses
the registered device after mem::forget(drm); unused imports dropped;
allow(dead_code) on the not-yet-used ModeObjectVtable.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 rust/Makefile                    |  6 ++--
 rust/kernel/drm/device.rs        | 12 ++++----
 rust/kernel/drm/driver.rs        |  8 ++---
 rust/kernel/drm/kms.rs           | 51 +++++++++++++++++++++++---------
 rust/kernel/drm/kms/connector.rs | 31 ++++++-------------
 rust/kernel/drm/kms/crtc.rs      | 35 ++++++++--------------
 rust/kernel/drm/kms/encoder.rs   |  4 +--
 rust/kernel/drm/kms/modes.rs     |  5 ++++
 rust/kernel/drm/kms/plane.rs     | 31 ++++++-------------
 rust/kernel/drm/kms/vblank.rs    |  7 ++---
 10 files changed, 91 insertions(+), 99 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index a870d1616c71..9aa985e21905 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -270,7 +270,7 @@ rustdoc-kernel: private is-kernel-object := y
 rustdoc-kernel: private rustc_target_flags = --extern ffi --extern pin_init \
     --extern build_error --extern macros \
     --extern bindings --extern uapi \
-    --extern zerocopy --extern zerocopy_derive
+    --extern zerocopy --extern zerocopy_derive -Znext-solver
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-ffi rustdoc-macros \
     rustdoc-pin_init rustdoc-compiler_builtins $(obj)/$(libmacros_name) \
     $(obj)/bindings.o FORCE
@@ -342,7 +342,7 @@ rusttestlib-pin_init: $(src)/pin-init/src/lib.rs rusttestlib-macros \
 rusttestlib-kernel: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros --extern pin_init \
     --extern bindings --extern uapi \
-    --extern zerocopy --extern zerocopy_derive
+    --extern zerocopy --extern zerocopy_derive -Znext-solver
 rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
     rusttestlib-build_error rusttestlib-pin_init $(obj)/$(libmacros_name) \
     $(obj)/bindings.o rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
@@ -764,7 +764,7 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
 
 $(obj)/kernel.o: private rustc_target_flags = --extern ffi --extern pin_init \
     --extern build_error --extern macros --extern bindings --extern uapi \
-    --extern zerocopy --extern zerocopy_derive
+    --extern zerocopy --extern zerocopy_derive -Znext-solver
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/build_error.o $(obj)/pin_init.o \
     $(obj)/$(libmacros_name) $(obj)/bindings.o $(obj)/uapi.o \
     $(obj)/zerocopy.o $(obj)/$(libzerocopy_derive_name) FORCE
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 9641102bd87f..5b84ce18fb29 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -229,7 +229,7 @@ const fn compute_features() -> u32 {
         dumb_map_offset: T::Object::<Uninit>::ALLOC_OPS.dumb_map_offset,
 
         show_fdinfo: None,
-        fbdev_probe: T::Object::ALLOC_OPS.fbdev_probe,
+        fbdev_probe: T::Object::<Uninit>::ALLOC_OPS.fbdev_probe,
 
         major: T::INFO.major,
         minor: T::INFO.minor,
@@ -306,15 +306,17 @@ pub fn new(
         // won't be called during its lifetime and that the device is unregistered.
         let drm_dev = unsafe { ARef::from_raw(raw_drm) };
 
-        let mode_config_info = drm::Device::<T>::has_kms().then(|| {
+        let mode_config_info = if drm::Device::<T>::has_kms() {
             // SAFETY: This is the only place that we call probe_kms
-            unsafe { T::Kms::probe_kms(&drm_dev)? }
-        });
+            Some(unsafe { T::Kms::probe_kms(&drm_dev)? })
+        } else {
+            None
+        };
 
         Ok(Self {
             // SAFETY: We just completed all of the initialization steps for this device.
             dev: unsafe { mem::transmute(drm_dev) },
-            preferred_fourcc: mode_config_info.preferred_fourcc,
+            preferred_fourcc: mode_config_info.and_then(|i| i.preferred_fourcc),
             _p: NotThreadSafe,
         })
     }
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index c7716afabcb0..b7e80df6289e 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -10,7 +10,6 @@
     devres,
     drm::{
         self,
-        kms::private::KmsImpl as KmsImplPrivate,
     },
     error::to_result,
     prelude::*,
@@ -214,6 +213,7 @@ fn new<'bound, E>(
             return Err(e);
         }
 
+        let preferred_fourcc = drm.preferred_fourcc;
         // SAFETY: We just called `drm_dev_register` above
         let new = NonNull::from(unsafe { drm.assume_ctx() });
 
@@ -226,12 +226,12 @@ fn new<'bound, E>(
 
         #[cfg(CONFIG_DRM_CLIENT = "y")]
         if drm::Device::<T>::has_kms() {
-            if let Some(fourcc) = drm.preferred_fourcc {
+            if let Some(fourcc) = preferred_fourcc {
                 // SAFETY: We just registered `drm` above, fulfilling the C API requirements
-                unsafe { bindings::drm_client_setup_with_fourcc(drm.as_raw(), fourcc) }
+                unsafe { bindings::drm_client_setup_with_fourcc(new.as_raw(), fourcc) }
             } else {
                 // SAFETY: We just registered `drm` above, fulfilling the C API requirements
-                unsafe { bindings::drm_client_setup(drm.as_raw(), ptr::null()) }
+                unsafe { bindings::drm_client_setup(new.as_raw(), ptr::null()) }
             }
         }
 
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index d07389fd510c..7c7e1d59c892 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -12,7 +12,7 @@
     },
     error::to_result,
     prelude::*,
-    sync::{aref::ARef, Mutex, MutexGuard},
+    sync::{aref::{ARef, AlwaysRefCounted}, Mutex, MutexGuard, SpinLockIrq},
 };
 use bindings;
 use core::{
@@ -122,23 +122,25 @@ fn deref(&self) -> &Self::Target {
 /// [`PhantomData<Self>`]: PhantomData
 #[vtable]
 pub trait KmsDriver: Driver {
-    // The driver's mode-object implementations. Left *unbounded* to break a trait
-    // well-formedness cycle: the natural bound (`type Crtc: DriverCrtc<Driver = Self>`, etc.)
-    // makes every `T: KmsDriver` obligation pull in the mutually-recursive Driver* web, which
-    // the compiler cannot evaluate (it loops in obligation processing and exhausts memory). The
-    // `DriverConnector`/`DriverCrtc`/... bounds are required at the use sites as `where`-clauses
-    // instead (an assumption, not an eagerly WF-checked trait-definition obligation).
-    //
-    // TODO: unneeded once we support multiple `Driver*` implementations per driver.
-
     /// The driver's [`DriverConnector`](connector::DriverConnector) implementation.
-    type Connector;
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverConnector` implementations.
+    type Connector: connector::DriverConnector<Driver = Self>;
+
     /// The driver's [`DriverPlane`](plane::DriverPlane) implementation.
-    type Plane;
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverPlane` implementations.
+    type Plane: plane::DriverPlane<Driver = Self>;
+
     /// The driver's [`DriverCrtc`](crtc::DriverCrtc) implementation.
-    type Crtc;
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverCrtc` implementations.
+    type Crtc: crtc::DriverCrtc<Driver = Self>;
+
     /// The driver's [`DriverEncoder`](encoder::DriverEncoder) implementation.
-    type Encoder;
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverEncoder` implementations.
+    type Encoder: encoder::DriverEncoder<Driver = Self>;
 
     /// Return a [`ModeConfigInfo`] structure for this [`device::Device`].
     fn mode_config_info(dev: &Device<Self, Uninit>) -> Result<ModeConfigInfo>
@@ -372,6 +374,13 @@ pub fn num_crtcs(&self) -> u32 {
         // * num_crtc is always >= 0, so casting to u32 is fine
         unsafe { (*self.as_raw()).mode_config.num_crtc as u32 }
     }
+
+    /// Returns a reference to the `event` spinlock for this [`Device`].
+    #[inline]
+    pub(crate) fn event_lock(&self) -> &SpinLockIrq<()> {
+        // SAFETY: `event_lock` is initialized for as long as `self` is exposed to users.
+        unsafe { SpinLockIrq::from_raw(addr_of_mut!((*self.as_raw()).event_lock)) }
+    }
 }
 
 impl<T: KmsDriver> Device<T> {
@@ -512,6 +521,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
 ///
 /// `ModeObjectVtable::vtable()` must always return a valid pointer to the relevant mode object's
 /// vtable.
+#[allow(dead_code)] // Scaffolding for future vtable-pointer comparison; see doc above.
 pub(crate) unsafe trait ModeObjectVtable {
     /// The type for the auto-generated vtable.
     type Vtable;
@@ -539,6 +549,19 @@ pub(crate) unsafe trait ModeObjectVtable {
 pub struct ModeConfigGuard<'a, T: KmsDriver>(MutexGuard<'a, ()>, PhantomData<T>);
 
 impl<'a, T: KmsDriver> ModeConfigGuard<'a, T> {
+    /// Construct a new [`ModeConfigGuard`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `drm_device.mode_config.mutex` is acquired.
+    pub(crate) unsafe fn new(drm: &'a Device<T>) -> Self {
+        // SAFETY: Our safety contract fulfills the requirements of `MutexGuard::new()`.
+        Self(
+            unsafe { MutexGuard::new(drm.mode_config_mutex(), ()) },
+            PhantomData,
+        )
+    }
+
     /// Return the [`Device`] that this [`ModeConfigGuard`] belongs to.
     pub fn drm_dev(&self) -> &'a Device<T> {
         let lock: *mut bindings::mutex = ptr::from_ref(self.0.lock_ref()).cast_mut().cast();
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index aca7be50e583..1c7c7b586340 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -10,7 +10,7 @@
 use crate::{
     alloc::KBox,
     bindings,
-    drm::{device::Device, kms::{NewKmsDevice, Probing}},
+    drm::{device::{Device, Uninit}, kms::{NewKmsDevice, Probing}},
     error::to_result,
     prelude::*,
     types::{NotThreadSafe, Opaque},
@@ -139,12 +139,12 @@ pub trait DriverConnector: Send + Sync + Sized {
     /// The [`DriverConnectorState`] implementation for this [`DriverConnector`].
     ///
     /// See [`DriverConnectorState`] for more info.
-    type State: DriverConnectorState<Connector = Self>;
+    type State: DriverConnectorState;
 
     /// The constructor for creating a [`Connector`] using this [`DriverConnector`] implementation.
     ///
     /// Drivers may use this to instantiate their [`DriverConnector`] object.
-    fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+    fn new(device: &Device<Self::Driver, Uninit>, args: Self::Args) -> impl PinInit<Self, Error>;
 
     /// Retrieve a list of available display modes for this [`Connector`].
     fn get_modes<'a>(
@@ -700,17 +700,13 @@ pub struct ConnectorState<T: DriverConnectorState> {
 /// [`struct drm_connector`]: srctree/include/drm_connector.h
 /// [`struct drm_connector_state`]: srctree/include/drm_connector.h
 pub trait DriverConnectorState: Clone + Default + Sized {
-    /// The parent [`DriverConnector`]. Unbounded to break the trait WF cycle; the
-    /// `DriverConnector` bound is required at use sites instead.
-    type Connector;
+    /// The parent [`DriverConnector`].
+    type Connector: DriverConnector;
 }
 
 impl<T: DriverConnectorState> Sealed for ConnectorState<T> {}
 
-impl<T: DriverConnectorState> AsRawConnectorState for ConnectorState<T>
-where
-    T::Connector: DriverConnector,
-{
+impl<T: DriverConnectorState> AsRawConnectorState for ConnectorState<T> {
     type Connector = Connector<T::Connector>;
 }
 
@@ -724,10 +720,7 @@ unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_connector_state {
     }
 }
 
-impl<T: DriverConnectorState> FromRawConnectorState for ConnectorState<T>
-where
-    T::Connector: DriverConnector,
-{
+impl<T: DriverConnectorState> FromRawConnectorState for ConnectorState<T> {
     unsafe fn from_raw<'a>(ptr: *const bindings::drm_connector_state) -> &'a Self {
         // Our data layout starts with `bindings::drm_connector_state`.
         let ptr: *const Self = ptr.cast();
@@ -866,10 +859,7 @@ pub(super) fn new<D: KmsDriver>(
     }
 }
 
-impl<'a, T: DriverConnectorState> Deref for ConnectorStateMutator<'a, ConnectorState<T>>
-where
-    T::Connector: DriverConnector,
-{
+impl<'a, T: DriverConnectorState> Deref for ConnectorStateMutator<'a, ConnectorState<T>> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -877,10 +867,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<'a, T: DriverConnectorState> DerefMut for ConnectorStateMutator<'a, ConnectorState<T>>
-where
-    T::Connector: DriverConnector,
-{
+impl<'a, T: DriverConnectorState> DerefMut for ConnectorStateMutator<'a, ConnectorState<T>> {
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.state.inner
     }
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 4c6cb6bbdcb8..9b43501bfb58 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -11,7 +11,7 @@
 use crate::{
     alloc::KBox,
     bindings,
-    drm::device::Device,
+    drm::device::{Device, Uninit},
     error::{from_result, to_result},
     prelude::*,
     types::{NotThreadSafe, Opaque},
@@ -107,8 +107,8 @@ pub trait DriverCrtc: Send + Sync + Sized {
             },
             mode_set_nofb: None,
             mode_set_base: None,
-            mode_set_base_atomic: None,
             get_scanout_position: None,
+            handle_vblank_timeout: None,
         },
     };
 
@@ -124,7 +124,7 @@ pub trait DriverCrtc: Send + Sync + Sized {
     /// The [`DriverCrtcState`] implementation for this [`DriverCrtc`].
     ///
     /// See [`DriverCrtcState`] for more info.
-    type State: DriverCrtcState<Crtc = Self>;
+    type State: DriverCrtcState;
 
     /// The driver's optional hardware vblank implementation
     ///
@@ -135,7 +135,7 @@ pub trait DriverCrtc: Send + Sync + Sized {
     /// The constructor for creating a [`Crtc`] using this [`DriverCrtc`] implementation.
     ///
     /// Drivers may use this to instantiate their [`DriverCrtc`] object.
-    fn new(device: &Device<Self::Driver>, args: &Self::Args) -> impl PinInit<Self, Error>;
+    fn new(device: &Device<Self::Driver, Uninit>, args: &Self::Args) -> impl PinInit<Self, Error>;
 
     /// The optional [`drm_crtc_helper_funcs.atomic_check`] hook for this crtc.
     ///
@@ -561,9 +561,10 @@ impl<T: DriverCrtcState> Sealed for CrtcState<T> {}
 /// [`struct drm_crtc`]: srctree/include/drm_crtc.h
 /// [`struct drm_crtc_state`]: srctree/include/drm_crtc.h
 pub trait DriverCrtcState: Clone + Default + Unpin {
-    /// The parent CRTC driver for this CRTC state. Unbounded to break the trait WF cycle;
-    /// the `DriverCrtc` bound is required at use sites instead.
-    type Crtc;
+    /// The parent CRTC driver for this CRTC state
+    type Crtc: DriverCrtc<State = Self>
+    where
+        Self: Sized;
 }
 
 /// The main interface for a [`struct drm_crtc_state`].
@@ -701,17 +702,11 @@ fn as_raw(&self) -> *mut bindings::drm_crtc_state {
     }
 }
 
-impl<T: DriverCrtcState> AsRawCrtcState for CrtcState<T>
-where
-    T::Crtc: DriverCrtc,
-{
+impl<T: DriverCrtcState> AsRawCrtcState for CrtcState<T> {
     type Crtc = Crtc<T::Crtc>;
 }
 
-impl<T: DriverCrtcState> FromRawCrtcState for CrtcState<T>
-where
-    T::Crtc: DriverCrtc,
-{
+impl<T: DriverCrtcState> FromRawCrtcState for CrtcState<T> {
     unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc_state) -> &'a Self {
         // SAFETY: Our data layout starts with `bindings::drm_crtc_state`
         unsafe { &*(ptr.cast()) }
@@ -818,10 +813,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, T: DriverCrtcState> Deref for CrtcStateMutator<'a, CrtcState<T>>
-where
-    T::Crtc: DriverCrtc,
-{
+impl<'a, T: DriverCrtcState> Deref for CrtcStateMutator<'a, CrtcState<T>> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -831,10 +823,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<'a, T: DriverCrtcState> DerefMut for CrtcStateMutator<'a, CrtcState<T>>
-where
-    T::Crtc: DriverCrtc,
-{
+impl<'a, T: DriverCrtcState> DerefMut for CrtcStateMutator<'a, CrtcState<T>> {
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: Our interface ensures that `self.state.inner` follows rust's data-aliasing rules,
         // so this is safe
diff --git a/rust/kernel/drm/kms/encoder.rs b/rust/kernel/drm/kms/encoder.rs
index 5f860faf8b61..47fd223a4d3a 100644
--- a/rust/kernel/drm/kms/encoder.rs
+++ b/rust/kernel/drm/kms/encoder.rs
@@ -9,7 +9,7 @@
 };
 use crate::{
     alloc::KBox,
-    drm::device::Device,
+    drm::device::{Device, Uninit},
     error::to_result,
     prelude::*,
     types::{NotThreadSafe, Opaque},
@@ -105,7 +105,7 @@ pub trait DriverEncoder: Send + Sync + Sized {
     /// The constructor for creating a [`Encoder`] using this [`DriverEncoder`] implementation.
     ///
     /// Drivers may use this to instantiate their [`DriverEncoder`] object.
-    fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+    fn new(device: &Device<Self::Driver, Uninit>, args: Self::Args) -> impl PinInit<Self, Error>;
 }
 
 /// The generated C vtable for a [`DriverEncoder`].
diff --git a/rust/kernel/drm/kms/modes.rs b/rust/kernel/drm/kms/modes.rs
index 0e8dc434487d..88ea27729212 100644
--- a/rust/kernel/drm/kms/modes.rs
+++ b/rust/kernel/drm/kms/modes.rs
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+
+//! DRM display mode definitions ([`struct drm_display_mode`]).
+//!
+//! [`struct drm_display_mode`]: srctree/include/drm/drm_modes.h
+
 use bindings;
 
 use crate::types::Opaque;
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 47e05fe6bee1..375f79bd3ceb 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -11,7 +11,7 @@
 use crate::{
     alloc::KBox,
     bindings,
-    drm::{device::Device, fourcc::*},
+    drm::{device::{Device, Uninit}, fourcc::*},
     error::{from_result, to_result, Error},
     prelude::*,
     types::{NotThreadSafe, Opaque},
@@ -98,12 +98,12 @@ pub trait DriverPlane: Send + Sync + Sized {
     /// The [`DriverPlaneState`] implementation for this [`DriverPlane`].
     ///
     /// See [`DriverPlaneState`] for more info.
-    type State: DriverPlaneState<Plane = Self>;
+    type State: DriverPlaneState;
 
     /// The constructor for creating a [`Plane`] using this [`DriverPlane`] implementation.
     ///
     /// Drivers may use this to instantiate their [`DriverPlane`] object.
-    fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+    fn new(device: &Device<Self::Driver, Uninit>, args: Self::Args) -> impl PinInit<Self, Error>;
 
     /// The optional [`drm_plane_helper_funcs.atomic_update`] hook for this plane.
     ///
@@ -689,17 +689,13 @@ pub struct PlaneState<T: DriverPlaneState> {
 /// [`struct drm_plane`]: srctree/include/drm_plane.h
 /// [`struct drm_plane_state`]: srctree/include/drm_plane.h
 pub trait DriverPlaneState: Clone + Default + Sized {
-    /// The type for this driver's drm_plane implementation. Unbounded to break the trait WF
-    /// cycle; the `DriverPlane` bound is required at use sites instead.
-    type Plane;
+    /// The type for this driver's drm_plane implementation
+    type Plane: DriverPlane;
 }
 
 impl<T: DriverPlaneState> Sealed for PlaneState<T> {}
 
-impl<T: DriverPlaneState> AsRawPlaneState for PlaneState<T>
-where
-    T::Plane: DriverPlane,
-{
+impl<T: DriverPlaneState> AsRawPlaneState for PlaneState<T> {
     type Plane = Plane<T::Plane>;
 }
 
@@ -713,10 +709,7 @@ unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
     }
 }
 
-impl<T: DriverPlaneState> FromRawPlaneState for PlaneState<T>
-where
-    T::Plane: DriverPlane,
-{
+impl<T: DriverPlaneState> FromRawPlaneState for PlaneState<T> {
     unsafe fn from_raw<'a>(ptr: *const bindings::drm_plane_state) -> &'a Self {
         // Our data layout starts with `bindings::drm_plane_state`.
         let ptr: *const Self = ptr.cast();
@@ -892,10 +885,7 @@ unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
 
 impl<'a, T: FromRawPlaneState> Sealed for PlaneStateMutator<'a, T> {}
 
-impl<'a, T: DriverPlaneState> Deref for PlaneStateMutator<'a, PlaneState<T>>
-where
-    T::Plane: DriverPlane,
-{
+impl<'a, T: DriverPlaneState> Deref for PlaneStateMutator<'a, PlaneState<T>> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -903,10 +893,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<'a, T: DriverPlaneState> DerefMut for PlaneStateMutator<'a, PlaneState<T>>
-where
-    T::Plane: DriverPlane,
-{
+impl<'a, T: DriverPlaneState> DerefMut for PlaneStateMutator<'a, PlaneState<T>> {
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.state.inner
     }
diff --git a/rust/kernel/drm/kms/vblank.rs b/rust/kernel/drm/kms/vblank.rs
index 534fd18f63b4..84e5cbbe923d 100644
--- a/rust/kernel/drm/kms/vblank.rs
+++ b/rust/kernel/drm/kms/vblank.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/drm/drm_vblank.h`](srcfree/include/drm/drm_vblank.h)
 
-use super::{crtc::*, ModeObject, modes::*, Sealed};
+use super::{crtc::*, ModeObject, modes::*};
 use bindings;
 use core::{
     marker::*,
@@ -62,9 +62,8 @@ fn get_vblank_timestamp(
 /// Drivers interested in implementing vblank support should refer to [`VblankSupport`], drivers
 /// that don't have vblank support can use [`PhantomData`].
 pub trait VblankImpl {
-    /// The parent [`DriverCrtc`]. Unbounded to break the trait WF cycle; the `DriverCrtc`
-    /// bound is required at use sites instead.
-    type Crtc;
+    /// The parent [`DriverCrtc`].
+    type Crtc: DriverCrtc<VblankImpl = Self>;
 
     /// The generated [`VblankOps`].
     const VBLANK_OPS: VblankOps;
-- 
2.55.0

