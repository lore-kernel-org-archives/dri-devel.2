Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D06C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED5510F5ED;
	Fri,  3 Jul 2026 03:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="Wx6u95Qp";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C8010F5ED
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:37 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-474560436c3so104226f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047696; x=1783652496;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zmepUPjDn3grp7kNjt5JCNExsSCDpx9IEqmKZjBkNg=;
 b=Wx6u95QpPlikeqgQU19l6NbAY74dLyDQ5wgtO24eY0uBziqMQvxLaV2VGQb2GwUM2i
 aATPSCp1fk9vpMeHmxAy//ECnv6v+2hNOm3uIOAysTw86OYgba/WYf4suXuV6bI5EEU+
 IT/6t4pjLNFR/mEhALbe3M+Lu9dZ82/b2msLDZb+g5zqyPKE+6JBLrYLo0f+hw4HssK8
 HIOt+TfFZ81lFnWtj5iQvApcrVvVF5Wcx6pp14M0X/1eKf+zBAG8RGbgkB6fzn/cL0w9
 9tKJpbfuHDyrqiguLGOViJMoEvCor80ikt01ReD2owEGW0mkk0xizwF8dVYpwoVSkfNc
 smmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047696; x=1783652496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4zmepUPjDn3grp7kNjt5JCNExsSCDpx9IEqmKZjBkNg=;
 b=VsVOPqC33WrqWCcLPKpsN5GJkXtKkJ4DwRs6Q6hhPAi0Tfo6M80vbzeB7946gCf4yX
 7wZq/V8wT7w+jjB+t55EWCfwkf9xfVic9pq14USQYyL4tJwquNlKZjq0z+LIR6veYP1t
 9OIMfM6b+VZh80XOXSoXptlyW+PEihsgHtOFCzKEG9nwxJdMQ73lt/ZTuPMCujchDVpu
 YIzfPwbK0R9mjbkKYY3jcAKPKig3dt9GTQyhHnm6UgcRSOWralsaXVZ3F3XqeyPmTY/X
 dGBV3aWvyfbkp6DcVrb2PF0ccRLZoBuc3fG8uV7L5cH7cziss5t0p6se3i4zUE+0hIDH
 dm3Q==
X-Gm-Message-State: AOJu0YzNyn747g13qCRiSOPUm2hSTZG3Q/EXjUgslAEFd7lp3Znkbvco
 1MIQ1Zrqm1Ilx3fYbsdem4fp5W29M3XMbk/W5E+7xFkpW0iI3rpxdkO8uv33ANaMAA==
X-Gm-Gg: AfdE7cks6XdvBjRneeyIBa7Q4ZxAAZsZDwbdXhJHgI6dAOP20FTevxUDmEFaIk0yvmj
 Sw9NX8a7ki3RUCek+LGxvQ8UjSWxvoixuChWt1OdLL3tow9w81W3P5Q04jtVQicjcSbAY+FjZlG
 2PErb4pb1mPQYLZXfxHySg+42PkqlY01+NckXRILVpFUoGtW+8T9s2YD1R1C9nNLcGGRx/l/SBd
 Gzr5sq54Hv5H/7SX9RR+Zv0r9aWinH5UbiNHw3Rss8OZR6ew6oRsgxtGs1gCzeFidRwt+W8qLli
 T+AqYZrHEdecVUHEgl1qJutC01W7FIoWfRFK6rnnrkyYgQ1s0k/Z6YitEi0IIMSryrMwz0Yr2qJ
 3PRpCSvz+f4tN70X2YjrDYZ4C+Belb7UHlceVBi1WiNlZn1R8KEa+K1OVp/cUg9mcxqyJySCHx6
 yOjkfLYoCY0g3zxtFpY4PkvDeHxgsk8hBi3xYsn/J8Jm4rtCn3xjTr0lj5
X-Received: by 2002:adf:e194:0:b0:476:135a:135c with SMTP id
 ffacd0b85a97d-477aeb5bd8dmr12495575f8f.2.1783047695816; 
 Thu, 02 Jul 2026 20:01:35 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/18] rust: drm: kms: adapt the port to current
 drm-next
Date: Fri,  3 Jul 2026 04:00:49 +0100
Message-ID: <20260703030123.2814-3-mike@fireburn.co.uk>
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

Three mechanical fixups needed to build the forward-ported layer
against this tree, rather than the rvkms-slim/rust-stuck source
branches it came from:

- wire the KMS bindings/helpers/aref imports the port assumes into
  bindings_helper.h and rust/helpers/drm/{atomic,drm,vblank}.c, and fix
  the impl_aref_for_mode_object! macro path
- rename drm_atomic_state -> drm_atomic_commit, renamed upstream since
  rvkms-slim was last synced
- pin KmsDriver's associated types to Driver=Self and tidy the
  probe_kms stub so it type-checks against the current Driver trait

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 rust/bindings/bindings_helper.h |  8 +++++++
 rust/helpers/drm/atomic.c       | 32 +++++++++++++++++++++++++
 rust/helpers/drm/drm.c          |  2 ++
 rust/helpers/drm/vblank.c       |  8 +++++++
 rust/kernel/drm/kms.rs          | 21 ++++++++---------
 rust/kernel/drm/kms/atomic.rs   | 41 +++++++++++++++++----------------
 rust/kernel/drm/kms/crtc.rs     | 16 ++++++-------
 rust/kernel/drm/kms/plane.rs    |  8 +++----
 8 files changed, 93 insertions(+), 43 deletions(-)
 create mode 100644 rust/helpers/drm/atomic.c
 create mode 100644 rust/helpers/drm/vblank.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a1ea23714bdd..e41d2716fb2e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,14 @@
 #include <linux/gpu_buddy.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
diff --git a/rust/helpers/drm/atomic.c b/rust/helpers/drm/atomic.c
new file mode 100644
index 000000000000..ed5e49b73c81
--- /dev/null
+++ b/rust/helpers/drm/atomic.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <drm/drm_atomic.h>
+
+void rust_helper_drm_atomic_commit_get(struct drm_atomic_commit *state)
+{
+	drm_atomic_commit_get(state);
+}
+
+void rust_helper_drm_atomic_commit_put(struct drm_atomic_commit *state)
+{
+	drm_atomic_commit_put(state);
+}
+
+// Macros for generating one repetitive atomic state accessors (like drm_atomic_get_new_plane_state)
+#define STATE_FUNC(type, tense)                                                                     \
+	struct drm_ ## type ## _state *rust_helper_drm_atomic_get_ ## tense ## _ ## type ## _state( \
+		const struct drm_atomic_commit *state,                                               \
+		struct drm_ ## type *type                                                           \
+	) {                                                                                         \
+		return drm_atomic_get_## tense ## _ ## type ## _state(state, type);                 \
+	}
+#define STATE_FUNCS(type) \
+	STATE_FUNC(type, new); \
+	STATE_FUNC(type, old);
+
+STATE_FUNCS(plane);
+STATE_FUNCS(crtc);
+STATE_FUNCS(connector);
+
+#undef STATE_FUNCS
+#undef STATE_FUNC
diff --git a/rust/helpers/drm/drm.c b/rust/helpers/drm/drm.c
index b8700413a2b8..5d700d75c0c9 100644
--- a/rust/helpers/drm/drm.c
+++ b/rust/helpers/drm/drm.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "atomic.c"
 #include "gem.c"
 #include "vma_manager.c"
+#include "vblank.c"
diff --git a/rust/helpers/drm/vblank.c b/rust/helpers/drm/vblank.c
new file mode 100644
index 000000000000..165db7ac5b4d
--- /dev/null
+++ b/rust/helpers/drm/vblank.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <drm/drm_vblank.h>
+
+struct drm_vblank_crtc *rust_helper_drm_crtc_vblank_crtc(struct drm_crtc *crtc)
+{
+	return drm_crtc_vblank_crtc(crtc);
+}
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 11b09d2175db..a147276b3412 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -12,8 +12,7 @@
     },
     error::to_result,
     prelude::*,
-    sync::{Mutex, MutexGuard},
-    types::*,
+    sync::{aref::ARef, Mutex, MutexGuard},
 };
 use bindings;
 use core::{
@@ -69,10 +68,10 @@ pub trait KmsImpl {
         ///
         /// This function may only be called once.
         unsafe fn probe_kms(_drm: &Device<Self::Driver, Uninit>) -> Result<ModeConfigInfo> {
-            // TODO before submission: There is definitely a proper way of doing this, but I don't
-            // remember what it is.
-            unimplemented!()
-            //build_error!("This should never be reachable")
+            // This default is only reachable for the `PhantomData<T>` (non-KMS) implementor, whose
+            // KMS setup is never invoked. KMS drivers override it via the `KmsDriver` blanket impl
+            // below, so reaching this is a build-time bug.
+            build_error::build_error("probe_kms called on a device without KMS support")
         }
     }
 }
@@ -126,22 +125,22 @@ pub trait KmsDriver: Driver {
     /// The driver's [`DriverConnector`](connector::DriverConnector) implementation.
     ///
     /// TODO: This will be unneeded once we support multiple `DriverConnector` implementations.
-    type Connector: connector::DriverConnector;
+    type Connector: connector::DriverConnector<Driver = Self>;
 
     /// The driver's [`DriverPlane`](plane::DriverPlane) implementation.
     ///
     /// TODO: This will be unneeded once we support multiple `DriverPlane` implementations.
-    type Plane: plane::DriverPlane;
+    type Plane: plane::DriverPlane<Driver = Self>;
 
     /// The driver's [`DriverCrtc`](crtc::DriverCrtc) implementation.
     ///
     /// TODO: This will be unneeded once we support multiple `DriverCrtc` implementations.
-    type Crtc: crtc::DriverCrtc;
+    type Crtc: crtc::DriverCrtc<Driver = Self>;
 
     /// The driver's [`DriverEncoder`](encoder::DriverEncoder) implementation.
     ///
     /// TODO: This will be unneeded once we support multiple `DriverEncoder` implementations.
-    type Encoder: encoder::DriverEncoder;
+    type Encoder: encoder::DriverEncoder<Driver = Self>;
 
     /// Return a [`ModeConfigInfo`] structure for this [`device::Device`].
     fn mode_config_info(dev: &Device<Self, Uninit>) -> Result<ModeConfigInfo>
@@ -486,7 +485,7 @@ macro_rules! impl_aref_for_mode_object {
     (impl $( < $( $param:ident: $bound:ident ),+ > )? for $type:ty) => {
         // SAFETY: drm_mode_object_get()/put() ensure the type is ref-counted according to the
         // safety contract
-        unsafe impl $( < $( $param: $bound ),+ > )? kernel::types::AlwaysRefCounted for $type {
+        unsafe impl $( < $( $param: $bound ),+ > )? kernel::sync::aref::AlwaysRefCounted for $type {
             #[inline]
             fn inc_ref(&self) {
                 // SAFETY: We're guaranteed by the safety contract of `ModeObject` that
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
 
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index b9d095854ba6..0f579dc4ec75 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -995,14 +995,14 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
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
@@ -1023,14 +1023,14 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
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
+    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_commit`
     let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
 
     // SAFETY:
@@ -1045,14 +1045,14 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
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
+    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_commit`
     let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
 
     // SAFETY:
@@ -1067,7 +1067,7 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_enable_callback<T: DriverCrtc>(
     crtc: *mut bindings::drm_crtc,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // - We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
@@ -1089,7 +1089,7 @@ impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
 
 unsafe extern "C" fn atomic_disable_callback<T: DriverCrtc>(
     crtc: *mut bindings::drm_crtc,
-    state: *mut bindings::drm_atomic_state,
+    state: *mut bindings::drm_atomic_commit,
 ) {
     // SAFETY:
     // - We're guaranteed `crtc` points to a valid instance of `drm_crtc`
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 661d82273099..6f547adcfdc9 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -1048,14 +1048,14 @@ impl<'a, T: DriverPlane> PlaneAtomicCommit<'a, T> {
 
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
@@ -1070,14 +1070,14 @@ impl<'a, T: DriverPlane> PlaneAtomicCommit<'a, T> {
 
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
+    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_commit`
     // We use ManuallyDrop here since AtomicStateComposer would otherwise drop a owned reference to
     // the atomic state upon finishing this callback.
     let state = ManuallyDrop::new(unsafe {
-- 
2.55.0

