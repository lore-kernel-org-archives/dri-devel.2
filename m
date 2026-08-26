Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9000CC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C547310E2EE;
	Wed, 26 Aug 2026 16:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="MW1eo513";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA5210E2EC
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:34:29 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4956869750eso7260175e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762068; x=1788366868;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TaLAaDSW9RCk77WS9Tnrx8LlgM0NCtSamxqWiIG6Qw0=;
 b=MW1eo513Trtb84Z0w7eqLKyQjFmzE6DC+R3qIzyO1ZQPCIACwV7cC8KHBMqXpwgtSQ
 fQhbrAaf5NWQstiz3NnTwk7dwYLssci2u2YihRGBt0c8oY5n9Zgk91wfJ7fP+CQlwJPK
 I46G1UBq+paHYgExpgdCPquhskVuzyqdPjtDESHSTchOoH4HdtgrXq2enOL2JI8UDqow
 DZj1R1ACIGWMqKpuDltCKdpq8oiNYksuGliFfTzsV9jtTbmmIJcnKOQmoCVHqZ5uMG+u
 DMfDxp3gIFtxZLLyLHGC55t2fYbU899xl4AR5AcnNZDVn3A5/nr52pJZn+b+qpEbzA+G
 NX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762068; x=1788366868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TaLAaDSW9RCk77WS9Tnrx8LlgM0NCtSamxqWiIG6Qw0=;
 b=s4xdxKna6DzwRIYo8L3q2ZO+EvHFaoQFrfACMWe0KmkMQ+o1Q894qP5CwFkwKQJreo
 TjSIZtjuu4eT8BgmA/W7sRqZ8kZ5jTW2X3CWDTBPqrs3o34wLZ/i177jv4mETmQlaH0X
 WMlZyCutWPtE8TSsN5bOlDNGvsct5d0U4fSNgFxtnI1zO2KaJW0P90pwwpMqQbRzzeq+
 xMVKq41u085upL6ZPHRFMMjKManMVxsCtllDRnnLUFhR1sVsE0vXg1MiiMqy8mDeNOr5
 /qkcruiNfIxv+vDsguZ0GHapXxyK2Xels1K7MGS1g5HtTJToAgezghU9v4+Dy99wqzHs
 4+Vw==
X-Gm-Message-State: AFuF++mPGsXvsOldgcA6DLuEbWYqTvAKro4BMIGL5Mu7P6feS/pSxy12
 GMl0oM4wUaS4Ck95w5TYEcHa0iJcbKa4k9dPWpLrd43L5pPk2KHhtBKAnMPRPRwuTIeyxIfQh4p
 Wf/W/CKxG
X-Gm-Gg: AR+sD13N7eP0UAgn9orBrR/ve6Rusid8znwraGt6m1vbC/q/hYZYdjVpfhffy0LxCrm
 n+C3yisVYybkwavlMv1YhyMFitPiSKpStW0SvNil7pyYv4hCfaGhSQyVUxYwcEMGiNpX3PUiNIE
 Fdqw0R8z9Ro5GDb1PwmDBZXplpKIqRaS4GCgjpKbmIkKFnFYGFpUR5wlGNlFvVAL//vxaD0JVgc
 Ys3kphAVXm/dyxczIqJ4H54WgGFAYcuMUUJBedRCdVyIa1CX/A6ovBNYgPaepm/p+XE0eHwX3EC
 id2s//XL1+miXHAeDgTz6Xi/dYjhgWJMKIZDv5Wo+JNzuGCAjIPgsqDqUOmsL0aicO6W42r2c7k
 2NRDzwwQzOT4H4x6+qOjJ7c+SXh52WFSMJOOKCxvnsFUsCBo0d/nSQExAn0iROGdBksen8H2vSu
 xp+VYd7bB16telEJrqWx+IBEUOm1Fe1xOGukbCTr1V+eULW9H95fqvcqlEuA+pizEPX7nn451l5
 qp969y1hfAtVdIouQ6RcJpuqcynZ7BYJByo
X-Received: by 2002:a05:600c:4514:b0:499:8777:ccba with SMTP id
 5b1f17b1804b1-499dc822557mr73602335e9.12.1787762067730; 
 Wed, 26 Aug 2026 09:34:27 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:26 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>, Asahi Lina <lina+kernel@asahilina.net>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/23] rust: drm: kms: adapt Lyude's KMS series to current
 DRM APIs
Date: Wed, 26 Aug 2026 17:31:32 +0100
Message-ID: <20260826163359.4998-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163359.4998-1-mike@fireburn.co.uk>
References: <20260826163359.4998-1-mike@fireburn.co.uk>
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

Adapt the Rust KMS bindings to the current DRM APIs while preserving
Lyude Paul's implementation as a separate, unchanged series.

Update the atomic state type to drm_atomic_commit, initialize the
current callback-table fields, remove the retired CRTC helper field,
and use the current Rust ARef path and helper annotations. Keep
callback vtables in static storage so every reference handed to DRM
core remains valid for the device lifetime.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/helpers/drm/atomic.c        | 21 ++++++++--------
 rust/kernel/drm/gem/shmem.rs     |  1 +
 rust/kernel/drm/kms.rs           | 26 +++++++++++---------
 rust/kernel/drm/kms/atomic.rs    | 41 ++++++++++++++++----------------
 rust/kernel/drm/kms/connector.rs |  2 ++
 rust/kernel/drm/kms/crtc.rs      | 21 +++++++++-------
 rust/kernel/drm/kms/plane.rs     | 10 ++++----
 7 files changed, 68 insertions(+), 54 deletions(-)

diff --git a/rust/helpers/drm/atomic.c b/rust/helpers/drm/atomic.c
index fff70053f694..420d72745e6b 100644
--- a/rust/helpers/drm/atomic.c
+++ b/rust/helpers/drm/atomic.c
@@ -2,23 +2,24 @@
 
 #include <drm/drm_atomic.h>
 
-void rust_helper_drm_atomic_state_get(struct drm_atomic_state *state)
+__rust_helper void rust_helper_drm_atomic_commit_get(struct drm_atomic_commit *state)
 {
-	drm_atomic_state_get(state);
+	drm_atomic_commit_get(state);
 }
 
-void rust_helper_drm_atomic_state_put(struct drm_atomic_state *state)
+__rust_helper void rust_helper_drm_atomic_commit_put(struct drm_atomic_commit *state)
 {
-	drm_atomic_state_put(state);
+	drm_atomic_commit_put(state);
 }
 
 // Macros for generating one repetitive atomic state accessors (like drm_atomic_get_new_plane_state)
-#define STATE_FUNC(type, tense)                                                                     \
-	struct drm_ ## type ## _state *rust_helper_drm_atomic_get_ ## tense ## _ ## type ## _state( \
-		const struct drm_atomic_state *state,                                               \
-		struct drm_ ## type *type                                                           \
-	) {                                                                                         \
-		return drm_atomic_get_## tense ## _ ## type ## _state(state, type);                 \
+#define STATE_FUNC(type, tense)						\
+	__rust_helper struct drm_ ## type ## _state *			\
+	rust_helper_drm_atomic_get_ ## tense ## _ ## type ## _state(	\
+		const struct drm_atomic_commit *state,			\
+		struct drm_ ## type *type)				\
+	{								\
+		return drm_atomic_get_## tense ## _ ## type ## _state(state, type); \
 	}
 #define STATE_FUNCS(type) \
 	STATE_FUNC(type, new); \
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 593fc0d427e4..86797ab39ffd 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -636,6 +636,7 @@ impl drm::Driver for KunitDriver {
         type File = KunitFile;
         type Object = Object<KunitObject>;
         type ParentDevice<Ctx: device::DeviceContext> = faux::Device<Ctx>;
+        type Kms = core::marker::PhantomData<Self>;
 
         const INFO: drm::DriverInfo = INFO;
         const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor] = &[];
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 820b0df265ff..8baf9c2906f5 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -16,8 +16,11 @@
     drm::{device::Device, driver::Driver, private::Sealed},
     error::to_result,
     prelude::*,
-    sync::{Mutex, MutexGuard},
-    types::*,
+    sync::{
+        aref::{ARef, AlwaysRefCounted},
+        Mutex,
+        MutexGuard, //
+    },
 };
 use bindings;
 use core::{
@@ -52,7 +55,7 @@ pub trait KmsImpl {
         type Driver: Driver;
 
         /// The optional KMS callback operations for this driver.
-        const MODE_CONFIG_OPS: Option<ModeConfigOps>;
+        const MODE_CONFIG_OPS: Option<&'static ModeConfigOps>;
 
         /// The callback for setting up KMS on a device
         ///
@@ -216,14 +219,14 @@ pub trait KmsDriver: Driver {
     /// implementations.
     ///
     /// [`DriverConnector`]: connector::DriverConnector
-    type Connector: connector::DriverConnector;
+    type Connector: connector::DriverConnector<Driver = Self>;
 
     /// The driver's [`DriverPlane`] implementation.
     ///
     /// TODO: This will be unneeded in the future once we support multiple [`DriverPlane`]
     /// implementations.
     ///
-    type Plane: plane::DriverPlane;
+    type Plane: plane::DriverPlane<Driver = Self>;
 
     /// The driver's [`DriverCrtc`] implementation.
     ///
@@ -231,7 +234,7 @@ pub trait KmsDriver: Driver {
     /// implementations.
     ///
     /// [`DriverCrtc`]: crtc::DriverCrtc
-    type Crtc: crtc::DriverCrtc;
+    type Crtc: crtc::DriverCrtc<Driver = Self>;
 
     /// The driver's [`DriverEncoder`] implementation.
     ///
@@ -239,7 +242,7 @@ pub trait KmsDriver: Driver {
     /// implementations.
     ///
     /// [`DriverEncoder`]: encoder::DriverEncoder
-    type Encoder: encoder::DriverEncoder;
+    type Encoder: encoder::DriverEncoder<Driver = Self>;
 
     /// Return a [`ModeConfigInfo`] structure for this [`device::Device`].
     fn mode_config_info(
@@ -279,7 +282,7 @@ fn atomic_commit_tail<'a>(
 impl<T: KmsDriver> private::KmsImpl for T {
     type Driver = Self;
 
-    const MODE_CONFIG_OPS: Option<ModeConfigOps> = Some(ModeConfigOps {
+    const MODE_CONFIG_OPS: Option<&'static ModeConfigOps> = Some(&ModeConfigOps {
         kms_vtable: bindings::drm_mode_config_funcs {
             atomic_check: Some(bindings::drm_atomic_helper_check),
             fb_create: Some(bindings::drm_gem_fb_create),
@@ -305,7 +308,7 @@ unsafe fn setup_kms(drm: &Device<Self::Driver>) -> Result<ModeConfigInfo> {
         let mode_config_info = T::mode_config_info(drm.as_ref().as_ref(), drm)?;
 
         // SAFETY: `MODE_CONFIG_OPS` is always Some() in this implementation
-        let ops = unsafe { T::MODE_CONFIG_OPS.as_ref().unwrap_unchecked() };
+        let ops = unsafe { T::MODE_CONFIG_OPS.unwrap_unchecked() };
 
         // SAFETY:
         // - This function can only be called before registration via our safety contract.
@@ -352,7 +355,7 @@ impl<T: KmsDriver> KmsImpl for T {}
 impl<T: Driver> private::KmsImpl for PhantomData<T> {
     type Driver = T;
 
-    const MODE_CONFIG_OPS: Option<ModeConfigOps> = None;
+    const MODE_CONFIG_OPS: Option<&'static ModeConfigOps> = None;
 }
 
 impl<T: Driver> KmsImpl for PhantomData<T> {}
@@ -501,7 +504,7 @@ macro_rules! impl_aref_for_mode_object {
     (impl $( < $( $param:ident: $bound:ident ),+ > )? for $type:ty) => {
         // SAFETY: drm_mode_object_get()/put() ensure the type is ref-counted according to the
         // safety contract
-        unsafe impl $( < $( $param: $bound ),+ > )? kernel::types::AlwaysRefCounted for $type {
+        unsafe impl $( < $( $param: $bound ),+ > )? kernel::sync::aref::AlwaysRefCounted for $type {
             #[inline]
             fn inc_ref(&self) {
                 // SAFETY: We're guaranteed by the safety contract of `ModeObject` that
@@ -535,6 +538,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
 ///
 /// `ModeObjectVtable::vtable()` must always return a valid pointer to the relevant mode object's
 /// vtable.
+#[allow(dead_code)]
 pub(crate) unsafe trait ModeObjectVtable {
     /// The type for the auto-generated vtable.
     type Vtable;
diff --git a/rust/kernel/drm/kms/atomic.rs b/rust/kernel/drm/kms/atomic.rs
index cc14bff47abd..18dc136940f3 100644
--- a/rust/kernel/drm/kms/atomic.rs
+++ b/rust/kernel/drm/kms/atomic.rs
@@ -1,31 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 
-//! [`struct drm_atomic_state`] related bindings for rust.
+//! [`struct drm_atomic_commit`] related bindings for rust.
 //!
-//! [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
+//! [`struct drm_atomic_commit`]: srctree/include/drm/drm_atomic.h
 use super::{connector::*, crtc::*, plane::*, KmsDriver, ModeObject};
 use crate::{
     bindings,
     drm::device::Device,
     error::{from_err_ptr, to_result},
     prelude::*,
+    sync::aref::{ARef, AlwaysRefCounted},
     types::*,
 };
 use core::{cell::Cell, marker::*, mem::ManuallyDrop, ops::*, ptr::NonNull};
 
-/// The main wrapper around [`struct drm_atomic_state`].
+/// The main wrapper around [`struct drm_atomic_commit`].
 ///
 /// This type is usually embedded within another interface such as an [`AtomicStateMutator`].
 ///
 /// # Invariants
 ///
-/// - The data layout of this type is identical to [`struct drm_atomic_state`].
+/// - The data layout of this type is identical to [`struct drm_atomic_commit`].
 /// - `state` is initialized for as long as this type is exposed to users.
 ///
-/// [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
+/// [`struct drm_atomic_commit`]: srctree/include/drm/drm_atomic.h
 #[repr(transparent)]
 pub struct AtomicState<T: KmsDriver> {
-    pub(super) state: Opaque<bindings::drm_atomic_state>,
+    pub(super) state: Opaque<bindings::drm_atomic_commit>,
     _p: PhantomData<T>,
 }
 
@@ -34,18 +35,18 @@ impl<T: KmsDriver> AtomicState<T> {
     ///
     /// # Safety
     ///
-    /// `ptr` must point to a valid initialized instance of [`struct drm_atomic_state`].
+    /// `ptr` must point to a valid initialized instance of [`struct drm_atomic_commit`].
     ///
-    /// [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
+    /// [`struct drm_atomic_commit`]: srctree/include/drm/drm_atomic.h
     #[allow(dead_code)]
-    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_atomic_state) -> &'a Self {
+    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_atomic_commit) -> &'a Self {
         // SAFETY: Our data layout is identical
         // INVARIANT: Our safety contract upholds the guarantee that `state` is initialized for as
         // long as this type is exposed to users.
         unsafe { &*ptr.cast() }
     }
 
-    pub(crate) fn as_raw(&self) -> *mut bindings::drm_atomic_state {
+    pub(crate) fn as_raw(&self) -> *mut bindings::drm_atomic_commit {
         self.state.get()
     }
 
@@ -102,12 +103,12 @@ pub fn get_old_connector_state<C>(&self, connector: &C) -> Option<&C::State>
 unsafe impl<T: KmsDriver> AlwaysRefCounted for AtomicState<T> {
     fn inc_ref(&self) {
         // SAFETY: `state` is initialized for as long as this type is exposed to users
-        unsafe { bindings::drm_atomic_state_get(self.state.get()) }
+        unsafe { bindings::drm_atomic_commit_get(self.state.get()) }
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
         // SAFETY: `obj` contains a valid non-null pointer to an initialized `Self`.
-        unsafe { bindings::drm_atomic_state_put(obj.as_ptr().cast()) }
+        unsafe { bindings::drm_atomic_commit_put(obj.as_ptr().cast()) }
     }
 }
 
@@ -141,11 +142,11 @@ impl<T: KmsDriver> AtomicStateMutator<T> {
     ///
     /// # Safety
     ///
-    /// `ptr` must point to a valid `drm_atomic_state`
+    /// `ptr` must point to a valid `drm_atomic_commit`
     #[allow(dead_code)]
-    pub(super) unsafe fn new(ptr: NonNull<bindings::drm_atomic_state>) -> Self {
+    pub(super) unsafe fn new(ptr: NonNull<bindings::drm_atomic_commit>) -> Self {
         Self {
-            // SAFETY: The data layout of `AtomicState<T>` is identical to drm_atomic_state
+            // SAFETY: The data layout of `AtomicState<T>` is identical to drm_atomic_commit
             // We use `ManuallyDrop` because `AtomicStateMutator` is only ever provided to users in
             // the context of KMS callbacks. As such, skipping ref inc/dec for the atomic state is
             // convienent for our bindings.
@@ -156,7 +157,7 @@ pub(super) unsafe fn new(ptr: NonNull<bindings::drm_atomic_state>) -> Self {
         }
     }
 
-    pub(crate) fn as_raw(&self) -> *mut bindings::drm_atomic_state {
+    pub(crate) fn as_raw(&self) -> *mut bindings::drm_atomic_commit {
         self.state.as_raw()
     }
 
@@ -273,8 +274,8 @@ fn drop(&mut self) {
 impl<T: KmsDriver> AtomicStateComposer<T> {
     /// # Safety
     ///
-    /// The caller guarantees that `ptr` points to a valid instance of `drm_atomic_state`.
-    pub(crate) unsafe fn new(ptr: NonNull<bindings::drm_atomic_state>) -> Self {
+    /// The caller guarantees that `ptr` points to a valid instance of `drm_atomic_commit`.
+    pub(crate) unsafe fn new(ptr: NonNull<bindings::drm_atomic_commit>) -> Self {
         // SAFETY: see `AtomicStateMutator::from_raw()`
         Self(unsafe { AtomicStateMutator::new(ptr) })
     }
@@ -681,11 +682,11 @@ pub fn commit_hw_done<'b>(
 
 // The actual raw C callback for custom atomic commit tail implementations
 pub(crate) unsafe extern "C" fn commit_tail_callback<T: KmsDriver>(
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // - We're guaranteed by DRM that `state` always points to a valid instance of
-    //   `bindings::drm_atomic_state`
+    //   `bindings::drm_atomic_commit`
     // - This conversion is safe via the type invariants
     let state = unsafe { AtomicState::from_raw(state.cast_const()) };
 
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index f7817c5037bd..78b08b94587b 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -94,6 +94,7 @@ pub trait DriverConnector: Send + Sync + Sized {
     /// The generated C vtable for this [`DriverConnector`] implementation
     const OPS: &'static DriverConnectorOps = &DriverConnectorOps {
         funcs: bindings::drm_connector_funcs {
+            atomic_create_state: None,
             dpms: None,
             atomic_get_property: None,
             atomic_set_property: None,
@@ -110,6 +111,7 @@ pub trait DriverConnector: Send + Sync + Sized {
             debugfs_init: None,
             oob_hotplug_event: None,
             atomic_duplicate_state: Some(atomic_duplicate_state_callback::<Self::State>),
+            color_format: None,
         },
         helper_funcs: bindings::drm_connector_helper_funcs {
             mode_valid: None,
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 650c0b530de5..b1c68838205e 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -46,6 +46,7 @@ pub trait DriverCrtc: Send + Sync + Sized {
     /// The generated C vtable for this [`DriverCrtc`] implementation.
     const OPS: &'static DriverCrtcOps = &DriverCrtcOps {
         funcs: bindings::drm_crtc_funcs {
+            atomic_create_state: None,
             atomic_destroy_state: Some(atomic_destroy_state_callback::<Self::State>),
             atomic_duplicate_state: Some(atomic_duplicate_state_callback::<Self::State>),
             atomic_get_property: None,
@@ -107,8 +108,8 @@ pub trait DriverCrtc: Send + Sync + Sized {
             },
             mode_set_nofb: None,
             mode_set_base: None,
-            mode_set_base_atomic: None,
             get_scanout_position: None,
+            handle_vblank_timeout: None,
         },
     };
 
@@ -995,14 +996,14 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_check_callback<T: DriverCrtc>(
     crtc: *mut bindings::drm_crtc,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) -> i32 {
     // SAFETY:
     // - We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
     // - We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
     let crtc = unsafe { Crtc::from_raw(crtc) };
 
-    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_state`
+    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_commit`
     // We use a ManuallyDrop here to avoid AtomicStateComposer dropping an owned reference we never
     // acquired.
     let state =
@@ -1023,14 +1024,15 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_begin_callback<T: DriverCrtc>(
     crtc: *mut bindings::drm_crtc,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // * We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
     // * We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
     let crtc = unsafe { Crtc::from_raw(crtc) };
 
-    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_state`
+    // SAFETY: DRM guarantees that `state` points to a valid
+    // `drm_atomic_commit`.
     let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
 
     // SAFETY:
@@ -1045,14 +1047,15 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_flush_callback<T: DriverCrtc>(
     crtc: *mut bindings::drm_crtc,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // - We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
     // - We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
     let crtc = unsafe { Crtc::from_raw(crtc) };
 
-    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_state`
+    // SAFETY: DRM guarantees that `state` points to a valid
+    // `drm_atomic_commit`.
     let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
 
     // SAFETY:
@@ -1067,7 +1070,7 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_enable_callback<T: DriverCrtc>(
     crtc: *mut bindings::drm_crtc,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // - We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
@@ -1089,7 +1092,7 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_disable_callback<T: DriverCrtc>(
     crtc: *mut bindings::drm_crtc,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // - We're guaranteed `crtc` points to a valid instance of `drm_crtc`
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 2791d341f1ac..0c549dece483 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -46,6 +46,7 @@ pub trait DriverPlane: Send + Sync + Sized {
     /// The generated C vtable for this [`DriverPlane`] implementation.
     const OPS: &'static DriverPlaneOps = &DriverPlaneOps {
         funcs: bindings::drm_plane_funcs {
+            atomic_create_state: None,
             update_plane: Some(bindings::drm_atomic_helper_update_plane),
             disable_plane: Some(bindings::drm_atomic_helper_disable_plane),
             destroy: Some(plane_destroy_callback::<Self>),
@@ -1048,14 +1049,14 @@ impl<'a, T: DriverPlane> PlaneAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_update_callback<T: DriverPlane>(
     plane: *mut bindings::drm_plane,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // - We're guaranteed `plane` is of type `Plane<T>` via type invariants.
     // - We're guaranteed by DRM that `plane` is pointing to a valid initialized state.
     let plane = unsafe { Plane::from_raw(plane) };
 
-    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_state`
+    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_commit`
     let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
 
     // SAFETY:
@@ -1070,14 +1071,15 @@ impl<'a, T: DriverPlane> PlaneAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_check_callback<T: DriverPlane>(
     plane: *mut bindings::drm_plane,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) -> i32 {
     // SAFETY:
     // - We're guaranteed `plane` is of type `Plane<T>` via type invariants.
     // - We're guaranteed by DRM that `plane` is pointing to a valid initialized state.
     let plane = unsafe { Plane::from_raw(plane) };
 
-    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_state`
+    // SAFETY: DRM guarantees that `state` points to a valid
+    // `drm_atomic_commit`.
     // We use ManuallyDrop here since AtomicStateComposer would otherwise drop a owned reference to
     // the atomic state upon finishing this callback.
     let state = ManuallyDrop::new(unsafe {
