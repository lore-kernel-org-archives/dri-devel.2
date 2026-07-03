Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65670C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AE110F682;
	Fri,  3 Jul 2026 07:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="SNvKLeqa";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF7810F5ED
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:37 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso99492f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047696; x=1783652496;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eumkndbmpgBQmZ7zkaNHL2PfDqyAiyKIvWHnUB0r2TI=;
 b=SNvKLeqaZ4MNC3GQwhDShHLCiDQEAzms7HW95yBMq1FBLW2R/muWxngwgBwRlrUoZa
 EyL/geXhCp/uhXkmx9xtuPXKeVuKKSEL049jjzPy626n1yzKBNu+3N+il9/xcnc9GvEz
 FtTPY/k2D9SGHHu3NpxuX+YVwsg/R8sSX5bt8ZSMPyRUHV1aJpc1oiFuSMxfrGJgjXYM
 cPUZYFrPKytRWHHTVn1vT+mWoJi0YC0xMUpo7yzqHOyqtBA/dz2viwOQ1h3mgFshemcM
 aGyEtUVVm05VVFTRfNLmnh9HZdQFiUnk5bJWwKkDLFLosRYH85LTWnwh/PST9Qk8kwzu
 qtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047696; x=1783652496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eumkndbmpgBQmZ7zkaNHL2PfDqyAiyKIvWHnUB0r2TI=;
 b=ZSM85Tw5CGOJvVoOXxJIy5YkU0/80LHoT+Rz0u2+58q4gO56KZQIH1F7qJmUvXV3Z0
 xUw6OgQcWeiY+aFJokSPcKJW5VRkjD49+6gMrw/PXbzVmfDf2SFfYygNHFbS78V+WC5+
 bLdb1kgr/tfFJnX8Ew2pgop1QOaAbFHukZdAlzaQniJwLHkfpBHZ5ztKjLrdoa4+cQmz
 X9k6F0pr/QS1ydAq55T9N8Adrvty5eVjIymHOPEg9Db9WdJGs6GqWZ20wLlG9BT7cVEI
 O07ILt1V8R8YmbvFULss2Zpn3yyiM/WgeroMzAPrxG+dRqWQH3oixIyymvlzh4f1j5eG
 mDAw==
X-Gm-Message-State: AOJu0Yyg8gFcE8iMmz/yoM4Kcv4mON/AlZkqHXAxaEYlkaNFiTbdTXI+
 ON8jZtxWn83clGE2uC3PCBRdPiDL208XacaTQ7HYRWIJhf/dxdNCGPuh6JHVpabUeA==
X-Gm-Gg: AfdE7ckG5Kygmoxd6HALZfqclDCLeLpx2Ne+9UZgnB+mVNjm+uBXY42XOqgsbJx+zMP
 Zp3U9JVdGizBAyCeQcQiRB8Raf/iFFNMuVTsIFPG9v93RLslZ4By6S3YlcOsvQ4iY4f0JNesjWj
 yT81msxw8cmjP/6oiAebBSFqBIa1lOq+k8sIgF/jCcjD4vJkMZAhTTuXJGXjjj3IldMLvy2b0C1
 0Ut/tgGNzkbR4HZKhfy8y96U0l5yP+eVBQ/zgAbECHUOqfPwwiJZp2Dr6B/jzhlks3AoduOdfIO
 sk1Kqgw39Z40HVcCkYVBAfWVnHJ/TYdkmzC4Vh/kRchvNefWxSH2WNTlEmlSFhyG4bV5BNosuEh
 W4bpN7uNPkq430WsZCOOOFppNtzNtcf7wu+09eiCUmesY5h3izLJSh8Ja8YFQaZ+lNE6zfVjssY
 c3Bti0w4ggyBLtDkHpvsfDdqNPPtgwkpbuy8u865V1OdHfc9Rwbj2WYaFb
X-Received: by 2002:a05:6000:420e:b0:473:c18:f2cb with SMTP id
 ffacd0b85a97d-477af4f8f3dmr12335882f8f.18.1783047693226; 
 Thu, 02 Jul 2026 20:01:33 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:30 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/18] rust: drm: kms: forward-port the safe
 mode-object layer onto the typestate device
Date: Fri,  3 Jul 2026 04:00:48 +0100
Message-ID: <20260703030123.2814-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

Port Lyude Paul's rvkms-slim safe mode-object layer (CRTC/plane/connector/
encoder/vblank/atomic state) onto her newer rust-stuck typestate Device
design (ParentDevice/DeviceContext/RegistrationData), which the preceding
cherry-picked commits bring in. Source: lyude/rvkms-slim + lyude/rust/rust-stuck.

Same module split as rvkms-slim (kms/{atomic,connector,crtc,encoder,
framebuffer,modes,plane,vblank}.rs), same trait shape, adjusted to the
typestate device's generic Ctx/State parameters. This is a mechanical
type-level port, not new design -- diff against lyude/rvkms-slim to see
exactly what moved.

Does not build yet. The port's mode-object traits are mutually
recursive in a way the current trait solver can't evaluate; the next
few commits get it to a clean build.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 rust/kernel/drm/kms.rs             |  395 +++++++++-
 rust/kernel/drm/kms/atomic.rs      |  864 ++++++++++++++++++++++
 rust/kernel/drm/kms/connector.rs   |  997 +++++++++++++++++++++++++
 rust/kernel/drm/kms/crtc.rs        | 1110 ++++++++++++++++++++++++++++
 rust/kernel/drm/kms/encoder.rs     |  409 ++++++++++
 rust/kernel/drm/kms/framebuffer.rs |   70 ++
 rust/kernel/drm/kms/modes.rs       |   76 ++
 rust/kernel/drm/kms/plane.rs       | 1095 +++++++++++++++++++++++++++
 rust/kernel/drm/kms/vblank.rs      |  461 ++++++++++++
 9 files changed, 5469 insertions(+), 8 deletions(-)
 create mode 100644 rust/kernel/drm/kms/atomic.rs
 create mode 100644 rust/kernel/drm/kms/connector.rs
 create mode 100644 rust/kernel/drm/kms/crtc.rs
 create mode 100644 rust/kernel/drm/kms/encoder.rs
 create mode 100644 rust/kernel/drm/kms/framebuffer.rs
 create mode 100644 rust/kernel/drm/kms/modes.rs
 create mode 100644 rust/kernel/drm/kms/plane.rs
 create mode 100644 rust/kernel/drm/kms/vblank.rs

diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 084ed0aebd0e..11b09d2175db 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -3,17 +3,37 @@
 //! KMS driver abstractions for rust.
 
 use crate::{
+    container_of,
     drm::{
-        device::Device,
+        device::{Device, DeviceContext},
         driver::Driver,
         private::Sealed,
         Uninit, //
     },
     error::to_result,
-    prelude::*, //
+    prelude::*,
+    sync::{Mutex, MutexGuard},
+    types::*,
 };
 use bindings;
-use core::{marker::PhantomData, ops::Deref};
+use core::{
+    cell::Cell,
+    marker::PhantomData,
+    ops::Deref,
+    ptr::{self, addr_of_mut, NonNull},
+};
+
+// Forward-ported mode-object layer (see Documentation/gpu/rust/vino-kms-forward-port.md).
+// Modules are declared here as each is grafted onto the rust-stuck typestate design.
+// `modes` is self-contained and ported as-is; the rest follow per the plan's order.
+pub mod atomic;
+pub mod connector;
+pub mod crtc;
+pub mod encoder;
+pub mod framebuffer;
+pub mod modes;
+pub mod plane;
+pub mod vblank;
 
 /// The C vtable for a [`Device`].
 ///
@@ -77,13 +97,21 @@ impl KmsContext for Probing {}
 /// This type is guaranteed to represent a [`Device`] that has not been registered with userspace,
 /// and is in the process of setting up KMS support. It carries a [`KmsDeviceContext`] to indicate
 /// which stage of the KMS setup process this [`Device`] is currently in.
-pub struct NewKmsDevice<'a, T: Driver, C: KmsContext>(&'a Device<T, Uninit>, PhantomData<C>);
+pub struct NewKmsDevice<'a, T: Driver, C: KmsContext> {
+    drm: &'a Device<T, Uninit>,
+    /// Tracks whether any CRTC created during probe requested vblank support, so that
+    /// [`drm_vblank_init()`] can be called afterwards. Set by [`crtc::Crtc::new()`].
+    ///
+    /// [`drm_vblank_init()`]: srctree/include/drm/drm_vblank.h
+    pub(crate) has_vblanks: Cell<bool>,
+    _ctx: PhantomData<C>,
+}
 
 impl<'a, T: Driver, C: KmsContext> Deref for NewKmsDevice<'a, T, C> {
     type Target = Device<T, Uninit>;
 
     fn deref(&self) -> &Self::Target {
-        self.0
+        self.drm
     }
 }
 
@@ -95,15 +123,56 @@ fn deref(&self) -> &Self::Target {
 /// [`PhantomData<Self>`]: PhantomData
 #[vtable]
 pub trait KmsDriver: Driver {
+    /// The driver's [`DriverConnector`](connector::DriverConnector) implementation.
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverConnector` implementations.
+    type Connector: connector::DriverConnector;
+
+    /// The driver's [`DriverPlane`](plane::DriverPlane) implementation.
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverPlane` implementations.
+    type Plane: plane::DriverPlane;
+
+    /// The driver's [`DriverCrtc`](crtc::DriverCrtc) implementation.
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverCrtc` implementations.
+    type Crtc: crtc::DriverCrtc;
+
+    /// The driver's [`DriverEncoder`](encoder::DriverEncoder) implementation.
+    ///
+    /// TODO: This will be unneeded once we support multiple `DriverEncoder` implementations.
+    type Encoder: encoder::DriverEncoder;
+
     /// Return a [`ModeConfigInfo`] structure for this [`device::Device`].
     fn mode_config_info(dev: &Device<Self, Uninit>) -> Result<ModeConfigInfo>
     where
         Self: Sized;
 
     /// Create mode objects like [`crtc::Crtc`], [`plane::Plane`], etc. for this device
-    fn probe(drm: NewKmsDevice<'_, Self, Probing>) -> Result
+    fn probe(drm: &NewKmsDevice<'_, Self, Probing>) -> Result
     where
         Self: Sized;
+
+    /// The optional [`atomic_commit_tail`] callback for this [`Device`].
+    ///
+    /// It must return a [`CommittedAtomicState`](atomic::CommittedAtomicState) to prove that it has
+    /// signaled completion of the hw commit phase. Drivers may use this function to customize the
+    /// order in which commits are performed during the atomic commit phase.
+    ///
+    /// If not provided, DRM will use its own default atomic commit tail helper
+    /// `drm_atomic_helper_commit_tail`.
+    ///
+    /// [`atomic_commit_tail`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_commit_tail<'a>(
+        _state: atomic::AtomicCommitTail<'a, Self>,
+        _modeset_token: atomic::ModesetsReadyToken<'_>,
+        _plane_update_token: atomic::PlaneUpdatesReadyToken<'_>,
+    ) -> atomic::CommittedAtomicState<'a, Self>
+    where
+        Self: Sized,
+    {
+        build_error::build_error("This function should not be reachable")
+    }
 }
 
 impl<T: KmsDriver> private::KmsImpl for T {
@@ -123,7 +192,11 @@ impl<T: KmsDriver> private::KmsImpl for T {
 
         kms_helper_vtable: bindings::drm_mode_config_helper_funcs {
             atomic_commit_setup: None,
-            atomic_commit_tail: None,
+            atomic_commit_tail: if T::HAS_ATOMIC_COMMIT_TAIL {
+                Some(atomic::commit_tail_callback::<T>)
+            } else {
+                None
+            },
         },
     });
 
@@ -156,7 +229,19 @@ unsafe fn probe_kms(drm: &Device<Self::Driver, Uninit>) -> Result<ModeConfigInfo
         // SAFETY: We just setup all of the info required to call this function above.
         to_result(unsafe { bindings::drmm_mode_config_init(drm.as_raw()) })?;
 
-        T::probe(NewKmsDevice(&drm, PhantomData))?;
+        let new_kms = NewKmsDevice {
+            drm: &drm,
+            has_vblanks: Cell::new(false),
+            _ctx: PhantomData,
+        };
+        T::probe(&new_kms)?;
+
+        if new_kms.has_vblanks.get() {
+            // SAFETY: `has_vblanks` is only set when CRTCs with vblank support were created during
+            // probe (the only place static mode objects are created), so the vblank state is ready
+            // to be initialized.
+            to_result(unsafe { bindings::drm_vblank_init(drm.as_raw(), drm.num_crtcs()) })?;
+        }
 
         // TODO: In the future, we should add a hook here for initializing each state via hardware
         // state readback.
@@ -192,3 +277,297 @@ pub struct ModeConfigInfo {
     /// An optional default fourcc format code to be preferred for clients.
     pub preferred_fourcc: Option<u32>,
 }
+
+// ---------------------------------------------------------------------------
+// Mode-object framework (forward-ported from lyude/rvkms-slim's kms.rs).
+//
+// Adapted to rust-stuck's typestate device: `Device<T, C>` defaults `C` to
+// `Registered`, so most `Device<T>` references port unchanged; only creation
+// paths (during probe) use the `Uninit` context, reached via `NewKmsDevice`.
+// ---------------------------------------------------------------------------
+
+/// Implement the repetitive from_opaque/try_from_opaque methods for all mode object and state
+/// types.
+///
+/// Because there are so many different ways of accessing mode objects, their states, etc. we need a
+/// macro that we can use for consistently implementing try_from_opaque()/from_opaque() functions to
+/// convert from Opaque mode objects to fully typed mode objects. This macro handles that, and can
+/// generate said functions for any kind of type which the original mode object driver trait can be
+/// derived from.
+macro_rules! impl_from_opaque_mode_obj {
+    (
+        fn <
+            $( $lifetime:lifetime, )?
+            $( $decl_bound_id:ident ),*
+        > ($opaque:ty) -> $inner_ret_ty:ty
+        $(
+            where
+                $( $extra_bound_id:ident : $extra_trait:ident<$( $extra_assoc:ident = $extra_param_match:ident ),+> ),+
+        )? ;
+        use
+            $obj_trait_param:ident as $obj_trait:ident,
+            $drv_trait_param:ident as KmsDriver<$drv_assoc_trait:ident = ...>
+    ) => {
+        #[doc = "Try to convert `opaque` into a fully qualified `Self`."]
+        #[doc = ""]
+        #[doc = concat!("This will try to convert `opaque` into `Self` if it shares the same [`",
+                        stringify!($obj_trait), "`] implementation as `Self`.")]
+        pub fn try_from_opaque<$( $lifetime, )? $( $decl_bound_id ),* >(
+            opaque: $opaque
+        ) -> Result<$inner_ret_ty, $opaque>
+        where
+            $drv_trait_param: KmsDriver<$drv_assoc_trait = $obj_trait_param>,
+            $obj_trait_param: $obj_trait<Driver = $drv_trait_param>
+            $( , $( $extra_bound_id: $extra_trait<$( $extra_assoc = $extra_param_match ),+> ),+ )?
+        {
+            // FIXME: What we really want to be doing here is comparing vtable pointers, but this is
+            // currently blocked on getting unique vtable macros to ensure that each vtable has a
+            // consistent memory pointer.
+            // For the time being, we simply restrict things to one object type per driver and do a
+            // transmutation based on that assumption holding true.
+            // SAFETY: We currently only allow one object type per-driver, so this transmute is
+            // always safe.
+            Ok(unsafe { core::mem::transmute(opaque) })
+        }
+
+        #[doc = "Convert `opaque` into a fully qualified `Self`."]
+        #[doc = ""]
+        #[doc = concat!("This is an infallible version of [`Self::try_from_opaque`]. This ",
+                        "function is mainly useful for drivers where only a single [`",
+                        stringify!($obj_trait), "`] implementation exists.")]
+        #[doc = ""]
+        #[doc = "# Panics"]
+        #[doc = ""]
+        #[doc = concat!("This function will panic if `opaque` belongs to a different [`",
+                        stringify!($obj_trait), "`] implementation.")]
+        pub fn from_opaque<$( $lifetime, )? $( $decl_bound_id ),* >(
+            opaque: $opaque
+        ) -> $inner_ret_ty
+        where
+            $drv_trait_param: KmsDriver<$drv_assoc_trait = $obj_trait_param>,
+            $obj_trait_param: $obj_trait<Driver = $drv_trait_param>
+            $( , $( $extra_bound_id: $extra_trait<$( $extra_assoc = $extra_param_match ),+> ),+ )?
+        {
+            Self::try_from_opaque(opaque)
+                .map_or(None, |o| Some(o))
+                .expect(concat!("Passed ", stringify!($opaque), " does not share this ",
+                                stringify!($obj_trait), " implementation."))
+        }
+    };
+}
+
+pub(crate) use impl_from_opaque_mode_obj;
+
+impl<T: KmsDriver, C: DeviceContext> Device<T, C> {
+    /// Retrieve a pointer to the mode_config mutex
+    #[inline]
+    pub(crate) fn mode_config_mutex(&self) -> &Mutex<()> {
+        // SAFETY: This lock is initialized for as long as `Device<T>` is exposed to users
+        unsafe { Mutex::from_raw(addr_of_mut!((*self.as_raw()).mode_config.mutex)) }
+    }
+
+    /// Return the number of registered [`Crtc`](crtc::Crtc) objects on this [`Device`].
+    #[inline]
+    pub fn num_crtcs(&self) -> u32 {
+        // SAFETY:
+        // * This can only be modified during the single-threaded context before registration, so
+        //   this is safe
+        // * num_crtc is always >= 0, so casting to u32 is fine
+        unsafe { (*self.as_raw()).mode_config.num_crtc as u32 }
+    }
+}
+
+impl<T: KmsDriver> Device<T> {
+    /// Acquire the [`mode_config.mutex`] for this [`Device`].
+    #[inline]
+    pub fn mode_config_lock(&self) -> ModeConfigGuard<'_, T> {
+        // INVARIANT: We're locking mode_config.mutex, fulfilling our invariant that this lock is
+        // held throughout ModeConfigGuard's lifetime.
+        ModeConfigGuard(self.mode_config_mutex().lock(), PhantomData)
+    }
+}
+
+/// A modesetting object in DRM.
+///
+/// This is any type of object where the underlying C object contains a [`struct drm_mode_object`].
+/// This type requires [`Send`] + [`Sync`] as all modesetting objects in DRM are able to be sent
+/// between threads.
+///
+/// This type is only implemented by the DRM crate itself.
+///
+/// # Safety
+///
+/// [`raw_mode_obj()`] must always return a valid pointer to an initialized
+/// [`struct drm_mode_object`].
+///
+/// [`struct drm_mode_object`]: srctree/include/drm/drm_mode_object.h
+/// [`raw_mode_obj()`]: ModeObject::raw_mode_obj()
+pub unsafe trait ModeObject: Sealed + Send + Sync {
+    /// The parent driver for this [`ModeObject`].
+    type Driver: KmsDriver;
+
+    /// Return the [`Device`] for this [`ModeObject`].
+    fn drm_dev(&self) -> &Device<Self::Driver>;
+
+    /// Return a pointer to the [`struct drm_mode_object`] for this [`ModeObject`].
+    ///
+    /// [`struct drm_mode_object`]: (srctree/include/drm/drm_mode_object.h)
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object;
+}
+
+/// A trait for modesetting objects which don't come with their own reference-counting.
+///
+/// Some [`ModeObject`] types in DRM do not have a reference count. These types are considered
+/// "static" and share the lifetime of their parent [`Device`]. To retrieve an owned reference to
+/// such types, see [`KmsRef`].
+///
+/// # Safety
+///
+/// This trait must only be implemented for modesetting objects which do not have a refcount within
+/// their [`struct drm_mode_object`], otherwise [`KmsRef`] can't guarantee the object will stay
+/// alive.
+///
+/// [`struct drm_mode_object`]: (srctree/include/drm/drm_mode_object.h)
+pub unsafe trait StaticModeObject: ModeObject {}
+
+/// An owned reference to a [`StaticModeObject`].
+///
+/// Note that since [`StaticModeObject`] types share the lifetime of their parent [`Device`], the
+/// parent [`Device`] will stay alive as long as this type exists. Thus, users should be aware that
+/// storing a [`KmsRef`] within a [`ModeObject`] is a circular reference.
+///
+/// # Invariants
+///
+/// `self.0` points to a valid instance of `T` throughout the lifetime of this type.
+pub struct KmsRef<T: StaticModeObject>(NonNull<T>);
+
+// SAFETY: Owned references to DRM device are thread-safe.
+unsafe impl<T: StaticModeObject> Send for KmsRef<T> {}
+// SAFETY: Owned references to DRM device are thread-safe.
+unsafe impl<T: StaticModeObject> Sync for KmsRef<T> {}
+
+impl<T: StaticModeObject> From<&T> for KmsRef<T> {
+    fn from(value: &T) -> Self {
+        // INVARIANT: Because the lifetime of the StaticModeObject is the same as the lifetime of
+        // its parent device, we can ensure that `value` remains alive by incrementing the device's
+        // reference count. The device will only disappear once we drop this reference in `Drop`.
+        value.drm_dev().inc_ref();
+
+        Self(value.into())
+    }
+}
+
+impl<T: StaticModeObject> Drop for KmsRef<T> {
+    fn drop(&mut self) {
+        // SAFETY: We're reclaiming the reference we leaked in From<&T>
+        drop(unsafe { ARef::from_raw(self.drm_dev().into()) })
+    }
+}
+
+impl<T: StaticModeObject> Deref for KmsRef<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: We're guaranteed object will point to a valid object as long as we hold dev
+        unsafe { self.0.as_ref() }
+    }
+}
+
+impl<T: StaticModeObject> Clone for KmsRef<T> {
+    fn clone(&self) -> Self {
+        // INVARIANT: See `From<&T>`; we keep the parent device alive for this new reference.
+        self.drm_dev().inc_ref();
+
+        Self(self.0)
+    }
+}
+
+macro_rules! impl_aref_for_mode_object {
+    (impl $( < $( $param:ident: $bound:ident ),+ > )? for $type:ty) => {
+        // SAFETY: drm_mode_object_get()/put() ensure the type is ref-counted according to the
+        // safety contract
+        unsafe impl $( < $( $param: $bound ),+ > )? kernel::types::AlwaysRefCounted for $type {
+            #[inline]
+            fn inc_ref(&self) {
+                // SAFETY: We're guaranteed by the safety contract of `ModeObject` that
+                // `raw_mode_obj()` always returns a pointer to an initialized `drm_mode_object`.
+                unsafe { kernel::bindings::drm_mode_object_get(self.raw_mode_obj()) }
+            }
+
+            #[inline]
+            unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+                // SAFETY: We're guaranteed by the safety contract of `ModeObject` that
+                // `raw_mode_obj()` always returns a pointer to an initialized `drm_mode_object`.
+                unsafe { kernel::bindings::drm_mode_object_put(obj.as_ref().raw_mode_obj()) }
+            }
+        }
+    };
+}
+
+pub(super) use impl_aref_for_mode_object;
+
+/// A trait for any object related to a [`ModeObject`] that can return its vtable.
+///
+/// This reference will be used for checking whether an opaque representation of a mode object uses a
+/// specific driver trait implementation.
+///
+/// # Safety
+///
+/// `ModeObjectVtable::vtable()` must always return a valid pointer to the relevant mode object's
+/// vtable.
+pub(crate) unsafe trait ModeObjectVtable {
+    /// The type for the auto-generated vtable.
+    type Vtable;
+
+    /// Return a static reference to the auto-generated vtable for the relevant mode object.
+    fn vtable(&self) -> *const Self::Vtable;
+}
+
+/// A mode config guard.
+///
+/// This is an exclusive primitive that represents when [`drm_device.mode_config.mutex`] is held - as
+/// some modesetting operations (particularly ones related to [`connectors`](connector)) are still
+/// protected under this single lock. The lock will be dropped once this object is dropped.
+///
+/// # Invariants
+///
+/// - `self.0` is contained within a [`struct drm_mode_config`], which is contained within a
+///   [`struct drm_device`].
+/// - The [`KmsDriver`] implementation of that [`struct drm_device`] is always `T`.
+/// - This type proves that [`drm_device.mode_config.mutex`] is acquired.
+///
+/// [`struct drm_mode_config`]: (srctree/include/drm/drm_device.h)
+/// [`drm_device.mode_config.mutex`]: (srctree/include/drm/drm_device.h)
+/// [`struct drm_device`]: (srctree/include/drm/drm_device.h)
+pub struct ModeConfigGuard<'a, T: KmsDriver>(MutexGuard<'a, ()>, PhantomData<T>);
+
+impl<'a, T: KmsDriver> ModeConfigGuard<'a, T> {
+    /// Return the [`Device`] that this [`ModeConfigGuard`] belongs to.
+    pub fn drm_dev(&self) -> &'a Device<T> {
+        let lock: *mut bindings::mutex = ptr::from_ref(self.0.lock_ref()).cast_mut().cast();
+
+        // SAFETY:
+        // - `self` is embedded within a `drm_mode_config` via our type invariants
+        // - `self.0.lock` has an equivalent data type to `mutex` via its type invariants.
+        let mode_config = unsafe { container_of!(lock, bindings::drm_mode_config, mutex) };
+
+        // SAFETY: And that `drm_mode_config` lives in a `drm_device` via type invariants.
+        unsafe {
+            Device::from_raw(container_of!(
+                mode_config,
+                bindings::drm_device,
+                mode_config
+            ))
+        }
+    }
+
+    /// Assert that the given device is the owner of this mode config guard.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `dev` is different from the owning device for this mode config guard.
+    #[inline]
+    pub(crate) fn assert_owner(&self, dev: &Device<T>) {
+        assert!(ptr::eq(self.drm_dev(), dev));
+    }
+}
diff --git a/rust/kernel/drm/kms/atomic.rs b/rust/kernel/drm/kms/atomic.rs
new file mode 100644
index 000000000000..cc14bff47abd
--- /dev/null
+++ b/rust/kernel/drm/kms/atomic.rs
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! [`struct drm_atomic_state`] related bindings for rust.
+//!
+//! [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
+use super::{connector::*, crtc::*, plane::*, KmsDriver, ModeObject};
+use crate::{
+    bindings,
+    drm::device::Device,
+    error::{from_err_ptr, to_result},
+    prelude::*,
+    types::*,
+};
+use core::{cell::Cell, marker::*, mem::ManuallyDrop, ops::*, ptr::NonNull};
+
+/// The main wrapper around [`struct drm_atomic_state`].
+///
+/// This type is usually embedded within another interface such as an [`AtomicStateMutator`].
+///
+/// # Invariants
+///
+/// - The data layout of this type is identical to [`struct drm_atomic_state`].
+/// - `state` is initialized for as long as this type is exposed to users.
+///
+/// [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
+#[repr(transparent)]
+pub struct AtomicState<T: KmsDriver> {
+    pub(super) state: Opaque<bindings::drm_atomic_state>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> AtomicState<T> {
+    /// Reconstruct an immutable reference to an atomic state from the given pointer
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a valid initialized instance of [`struct drm_atomic_state`].
+    ///
+    /// [`struct drm_atomic_state`]: srctree/include/drm/drm_atomic.h
+    #[allow(dead_code)]
+    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_atomic_state) -> &'a Self {
+        // SAFETY: Our data layout is identical
+        // INVARIANT: Our safety contract upholds the guarantee that `state` is initialized for as
+        // long as this type is exposed to users.
+        unsafe { &*ptr.cast() }
+    }
+
+    pub(crate) fn as_raw(&self) -> *mut bindings::drm_atomic_state {
+        self.state.get()
+    }
+
+    /// Return the [`Device`] associated with this [`AtomicState`].
+    pub fn drm_dev(&self) -> &Device<T> {
+        // SAFETY:
+        // - `state` is initialized via our type invariants.
+        // - `dev` is invariant throughout the lifetime of `AtomicState`
+        unsafe { Device::from_raw((*self.state.get()).dev) }
+    }
+
+    /// Return the old atomic state for `crtc`, if it is present within this [`AtomicState`].
+    pub fn get_old_crtc_state<C>(&self, crtc: &C) -> Option<&C::State>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        // SAFETY: This function either returns NULL or a valid pointer to a `drm_crtc_state`
+        unsafe {
+            bindings::drm_atomic_get_old_crtc_state(self.as_raw(), crtc.as_raw())
+                .as_ref()
+                .map(|p| C::State::from_raw(p))
+        }
+    }
+
+    /// Return the old atomic state for `plane`, if it is present within this [`AtomicState`].
+    pub fn get_old_plane_state<P>(&self, plane: &P) -> Option<&P::State>
+    where
+        P: ModesettablePlane + ModeObject<Driver = T>,
+    {
+        // SAFETY: This function either returns NULL or a valid pointer to a `drm_plane_state`
+        unsafe {
+            bindings::drm_atomic_get_old_plane_state(self.as_raw(), plane.as_raw())
+                .as_ref()
+                .map(|p| P::State::from_raw(p))
+        }
+    }
+
+    /// Return the old atomic state for `connector` if it is present within this [`AtomicState`].
+    pub fn get_old_connector_state<C>(&self, connector: &C) -> Option<&C::State>
+    where
+        C: ModesettableConnector + ModeObject<Driver = T>,
+    {
+        // SAFETY: This function either returns NULL or a valid pointer to a `drm_connector_state`.
+        unsafe {
+            bindings::drm_atomic_get_old_connector_state(self.as_raw(), connector.as_raw())
+                .as_ref()
+                .map(|p| C::State::from_raw(p))
+        }
+    }
+}
+
+// SAFETY: DRM atomic state objects are always reference counted and the get/put functions satisfy
+// the requirements.
+unsafe impl<T: KmsDriver> AlwaysRefCounted for AtomicState<T> {
+    fn inc_ref(&self) {
+        // SAFETY: `state` is initialized for as long as this type is exposed to users
+        unsafe { bindings::drm_atomic_state_get(self.state.get()) }
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: `obj` contains a valid non-null pointer to an initialized `Self`.
+        unsafe { bindings::drm_atomic_state_put(obj.as_ptr().cast()) }
+    }
+}
+
+/// A smart-pointer for modifying the contents of an atomic state.
+///
+/// As it's not unreasonable for a modesetting driver to want to have references to the state of
+/// multiple modesetting objects at once, along with mutating multiple states for unique modesetting
+/// objects at once, this type provides a mechanism for safely doing both of these things.
+///
+/// To honor Rust's aliasing rules regarding mutable references, this structure ensures only one
+/// mutable reference to a mode object's atomic state may exist at a time - and refuses to provide
+/// another if one has already been taken out using runtime checks.
+pub struct AtomicStateMutator<T: KmsDriver> {
+    /// The state being mutated. Note that the use of `ManuallyDrop` here is because mutators are
+    /// only constructed in FFI callbacks and thus borrow their references to the atomic state from
+    /// DRM. Composers, which make use of mutators internally, can potentially be owned by rust code
+    /// if a driver is performing an atomic commit internally - and thus will call the drop
+    /// implementation here.
+    state: ManuallyDrop<ARef<AtomicState<T>>>,
+
+    /// Bitmask of borrowed CRTC state objects
+    pub(super) borrowed_crtcs: Cell<u32>,
+    /// Bitmask of borrowed plane state objects
+    pub(super) borrowed_planes: Cell<u32>,
+    /// Bitmask of borrowed connector state objects
+    pub(super) borrowed_connectors: Cell<u32>,
+}
+
+impl<T: KmsDriver> AtomicStateMutator<T> {
+    /// Construct a new [`AtomicStateMutator`]
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a valid `drm_atomic_state`
+    #[allow(dead_code)]
+    pub(super) unsafe fn new(ptr: NonNull<bindings::drm_atomic_state>) -> Self {
+        Self {
+            // SAFETY: The data layout of `AtomicState<T>` is identical to drm_atomic_state
+            // We use `ManuallyDrop` because `AtomicStateMutator` is only ever provided to users in
+            // the context of KMS callbacks. As such, skipping ref inc/dec for the atomic state is
+            // convienent for our bindings.
+            state: ManuallyDrop::new(unsafe { ARef::from_raw(ptr.cast()) }),
+            borrowed_planes: Cell::default(),
+            borrowed_crtcs: Cell::default(),
+            borrowed_connectors: Cell::default(),
+        }
+    }
+
+    pub(crate) fn as_raw(&self) -> *mut bindings::drm_atomic_state {
+        self.state.as_raw()
+    }
+
+    /// Return the [`Device`] for this [`AtomicStateMutator`].
+    pub fn drm_dev(&self) -> &Device<T> {
+        self.state.drm_dev()
+    }
+
+    /// Retrieve the last committed atomic state for `crtc` if `crtc` has already been added to the
+    /// atomic state being composed.
+    ///
+    /// Returns `None` otherwise.
+    pub fn get_old_crtc_state<C>(&self, crtc: &C) -> Option<&C::State>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        self.state.get_old_crtc_state(crtc)
+    }
+
+    /// Retrieve the last committed atomic state for `connector` if `connector` has already been
+    /// added to the atomic state being composed.
+    ///
+    /// Returns `None` otherwise.
+    pub fn get_old_connector_state<C>(&self, connector: &C) -> Option<&C::State>
+    where
+        C: ModesettableConnector + ModeObject<Driver = T>,
+    {
+        self.state.get_old_connector_state(connector)
+    }
+
+    /// Retrieve the last committed atomic state for `plane` if `plane` has already been added to
+    /// the atomic state being composed.
+    ///
+    /// Returns `None` otherwise.
+    pub fn get_old_plane_state<P>(&self, plane: &P) -> Option<&P::State>
+    where
+        P: ModesettablePlane + ModeObject<Driver = T>,
+    {
+        self.state.get_old_plane_state(plane)
+    }
+
+    /// Return a composer for `plane`s new atomic state if it was previously added to the atomic
+    /// state being composed.
+    ///
+    /// Returns `None` otherwise, or if another mutator still exists for this state.
+    pub fn get_new_crtc_state<C>(&self, crtc: &C) -> Option<CrtcStateMutator<'_, C::State>>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        // SAFETY: DRM either returns NULL or a valid pointer to a `drm_crtc_state`
+        let state =
+            unsafe { bindings::drm_atomic_get_new_crtc_state(self.as_raw(), crtc.as_raw()) };
+
+        CrtcStateMutator::<C::State>::new(self, NonNull::new(state)?)
+    }
+
+    /// Return a composer for `plane`s new atomic state if it was previously added to the atomic
+    /// state being composed.
+    ///
+    /// Returns `None` otherwise, or if another mutator still exists for this state.
+    pub fn get_new_plane_state<P>(&self, plane: &P) -> Option<PlaneStateMutator<'_, P::State>>
+    where
+        P: ModesettablePlane + ModeObject<Driver = T>,
+    {
+        // SAFETY: DRM either returns NULL or a valid pointer to a `drm_plane_state`.
+        let state =
+            unsafe { bindings::drm_atomic_get_new_plane_state(self.as_raw(), plane.as_raw()) };
+
+        PlaneStateMutator::<P::State>::new(self, NonNull::new(state)?)
+    }
+
+    /// Return a composer for `crtc`s new atomic state if it was previously added to the atomic
+    /// state being composed.
+    ///
+    /// Returns `None` otherwise, or if another mutator still exists for this state.
+    pub fn get_new_connector_state<C>(
+        &self,
+        connector: &C,
+    ) -> Option<ConnectorStateMutator<'_, C::State>>
+    where
+        C: ModesettableConnector + ModeObject<Driver = T>,
+    {
+        // SAFETY: DRM either returns NULL or a valid pointer to a `drm_connector_state`
+        let state = unsafe {
+            bindings::drm_atomic_get_new_connector_state(self.as_raw(), connector.as_raw())
+        };
+
+        ConnectorStateMutator::<C::State>::new(self, NonNull::new(state)?)
+    }
+}
+
+/// An [`AtomicStateMutator`] wrapper which is not yet part of any commit operation.
+///
+/// Since it's not yet part of a commit operation, new mode objects may be added to the state. It
+/// also holds a reference to the underlying [`AtomicState`] that will be released when this object
+/// is dropped.
+pub struct AtomicStateComposer<T: KmsDriver>(AtomicStateMutator<T>);
+
+impl<T: KmsDriver> Deref for AtomicStateComposer<T> {
+    type Target = AtomicStateMutator<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl<T: KmsDriver> Drop for AtomicStateComposer<T> {
+    fn drop(&mut self) {
+        // SAFETY: We're in drop, so this is guaranteed to be the last possible reference
+        unsafe { ManuallyDrop::drop(&mut self.0.state) }
+    }
+}
+
+impl<T: KmsDriver> AtomicStateComposer<T> {
+    /// # Safety
+    ///
+    /// The caller guarantees that `ptr` points to a valid instance of `drm_atomic_state`.
+    pub(crate) unsafe fn new(ptr: NonNull<bindings::drm_atomic_state>) -> Self {
+        // SAFETY: see `AtomicStateMutator::from_raw()`
+        Self(unsafe { AtomicStateMutator::new(ptr) })
+    }
+
+    /// Attempt to add the state for `crtc` to the atomic state for this composer if it hasn't
+    /// already been added, and create a mutator for it.
+    ///
+    /// If a composer already exists for this `crtc`, this function returns `Error(EBUSY)`. If
+    /// attempting to add the state fails, another error code will be returned.
+    pub fn add_crtc_state<C>(&self, crtc: &C) -> Result<CrtcStateMutator<'_, C::State>>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        // SAFETY: DRM will only return a valid pointer to a `drm_crtc_state` - or an error.
+        let state = unsafe {
+            from_err_ptr(bindings::drm_atomic_get_crtc_state(
+                self.as_raw(),
+                crtc.as_raw(),
+            ))
+            .map(|c| NonNull::new_unchecked(c))
+        }?;
+
+        CrtcStateMutator::<C::State>::new(self, state).ok_or(EBUSY)
+    }
+
+    /// Attempt to add the state for `plane` to the atomic state for this composer if it hasn't
+    /// already been added, and create a mutator for it.
+    ///
+    /// If a composer already exists for this `plane`, this function returns `Error(EBUSY)`. If
+    /// attempting to add the state fails, another error code will be returned.
+    pub fn add_plane_state<P>(&self, plane: &P) -> Result<PlaneStateMutator<'_, P::State>>
+    where
+        P: ModesettablePlane + ModeObject<Driver = T>,
+    {
+        // SAFETY: DRM will only return a valid pointer to a `drm_plane_state` - or an error.
+        let state = unsafe {
+            from_err_ptr(bindings::drm_atomic_get_plane_state(
+                self.as_raw(),
+                plane.as_raw(),
+            ))
+            .map(|p| NonNull::new_unchecked(p))
+        }?;
+
+        PlaneStateMutator::<P::State>::new(self, state).ok_or(EBUSY)
+    }
+
+    /// Attempt to add the state for `connector` to the atomic state for this composer if it hasn't
+    /// already been added, and create a mutator for it.
+    ///
+    /// If a composer already exists for this `connector`, this function returns `Error(EBUSY)`. If
+    /// attempting to add the state fails, another error code will be returned.
+    pub fn add_connector_state<C>(
+        &self,
+        connector: &C,
+    ) -> Result<ConnectorStateMutator<'_, C::State>>
+    where
+        C: ModesettableConnector + ModeObject<Driver = T>,
+    {
+        // SAFETY: DRM will only return a valid pointer to a `drm_plane_state` - or an error.
+        let state = unsafe {
+            from_err_ptr(bindings::drm_atomic_get_connector_state(
+                self.as_raw(),
+                connector.as_raw(),
+            ))
+            .map(|c| NonNull::new_unchecked(c))
+        }?;
+
+        ConnectorStateMutator::<C::State>::new(self, state).ok_or(EBUSY)
+    }
+
+    /// Attempt to add any planes affected by changes on `crtc` to this [`AtomicStateComposer`].
+    ///
+    /// Will return an [`Error`] if this fails.
+    pub fn add_affected_planes<C>(&self, crtc: &C) -> Result
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        // SAFETY: Both .as_raw() values are guaranteed to return a valid pointer
+        to_result(unsafe { bindings::drm_atomic_add_affected_planes(self.as_raw(), crtc.as_raw()) })
+    }
+}
+
+/// A macro for declaring the repetitive take_all(), take_state(), etc. methods for atomic state
+/// token types.
+///
+/// It is assumed that $token_name refers to a struct that contains two members:
+///
+/// - `state`: This should be the atomic state type to use
+/// - The object in question. The name of this member is generated by converting $obj to lowercase.
+///
+/// The struct should have one lifetime ($lifetime_a) declared, and one meta-variable ($meta) which
+/// should be bound to the Driver* trait for the given mode object.
+macro_rules! impl_atomic_state_token_ops {
+    (
+        $token_name:ident,
+        $state:ident,
+        $obj:ident,
+        use <$lifetime_a:lifetime, $meta:ident>
+    ) => {
+        kernel::macros::paste! {
+            /// Create a new token.
+            ///
+            /// # Safety
+            ///
+            /// To use this function it must be known in the current context that:
+            ///
+            /// - The object has had its atomic states added to `state`.
+            /// - No state mutator can possibly be taken out for the objects new state.
+            pub(crate) unsafe fn new(
+                [<$obj:lower>]: &$lifetime_a $obj<$meta>,
+                state: &$lifetime_a $state<$meta::Driver>,
+            ) -> Self {
+                Self { [<$obj:lower>], state }
+            }
+
+            #[doc = concat!("Get the [`", stringify!($obj), "`] associated with this",
+                            " [`", stringify!($token_name), "`].")]
+            pub fn [<$obj:lower>](&self) -> &$lifetime_a $obj<$meta> {
+                self.[<$obj:lower>]
+            }
+
+            /// Exchange this token for a (atomic_state, old_state, new_state) tuple.
+            pub fn take_all(self) -> (
+                &$lifetime_a $state<$meta::Driver>,
+                &$lifetime_a [<$obj State>]<$meta::State>,
+                [<$obj StateMutator>]<$lifetime_a, [<$obj State>]<$meta::State>>,
+            ) {
+                let (old_state, new_state) = (
+                    self.state.[<get_old_ $obj:lower _state>](self.[<$obj:lower>]),
+                    self.state.[<get_new_ $obj:lower _state>](self.[<$obj:lower>]),
+                );
+
+                // SAFETY:
+                // - Both the old and new object state are present in `state` via our type
+                //   invariants.
+                // - The new state is guaranteed to have no mutators taken out via our type
+                //   invariants.
+                let (old_state, new_state) = unsafe {
+                    (old_state.unwrap_unchecked(), new_state.unwrap_unchecked())
+                };
+
+                (self.state, old_state, new_state)
+            }
+
+            #[doc = concat!("Exchange this token for the old [`", stringify!($obj), "State`].")]
+            pub fn take_old_state(self) -> &$lifetime_a [<$obj State>]<$meta::State> {
+                let old = self.state.[<get_old_ $obj:lower _state>](self.[<$obj:lower>]);
+
+                // SAFETY: The old state is guaranteed to be present in `state` via our type
+                // invariants.
+                unsafe { old.unwrap_unchecked() }
+            }
+
+            #[doc = concat!("Exchange this token for the new [`", stringify!($obj), "State`].")]
+            pub fn take_new_state(
+                self
+            ) -> [<$obj StateMutator>]<$lifetime_a, [<$obj State>]<$meta::State>> {
+                let new = self.state.[<get_new_ $obj:lower _state>](self.[<$obj:lower>]);
+
+                // SAFETY:
+                // - The new state is guaranteed to be present in our `state` via our type
+                //   invariants.
+                // - The new state is guaranteed not to have any mutators taken out for it via our
+                //   type invariants.
+                unsafe { new.unwrap_unchecked() }
+            }
+
+            #[doc = concat!("Exchange this token for both the old and new [`",
+                            stringify!($obj), "State`].")]
+            pub fn take_old_new_state(self) -> (
+                &$lifetime_a [<$obj State>]<$meta::State>,
+                [<$obj StateMutator>]<$lifetime_a, [<$obj State>]<$meta::State>>,
+            ) {
+                let (old_state, new_state) = (
+                    self.state.[<get_old_ $obj:lower _state>](self.[<$obj:lower>]),
+                    self.state.[<get_new_ $obj:lower _state>](self.[<$obj:lower>]),
+                );
+
+                // SAFETY:
+                // - Both the old and new object state are present in `state` via our type
+                //   invariants.
+                // - The new state is guaranteed to have no mutators taken out via our type
+                //   invariants.
+                let (old_state, new_state) = unsafe {
+                    (old_state.unwrap_unchecked(), new_state.unwrap_unchecked())
+                };
+
+                (old_state, new_state)
+            }
+
+            #[doc = concat!("Exchange this token for both the [`", stringify!($state),
+                            "`] and the old [`", stringify!($obj), "State`].")]
+            pub fn take_state_old_state(self) -> (
+                &$lifetime_a $state<$meta::Driver>,
+                &$lifetime_a [<$obj State>]<$meta::State>,
+            ) {
+                let old = self.state.[<get_old_ $obj:lower _state>](self.[<$obj:lower>]);
+
+                // SAFETY: The old state is guaranteed to be present in `state` via our type
+                // invariants.
+                (self.state, unsafe { old.unwrap_unchecked() })
+            }
+
+            #[doc = concat!("Exchange this token for both the [`", stringify!($state),
+                            "`] and the new [`", stringify!($obj), "State`].")]
+            pub fn take_state_new_state(self) -> (
+                &$lifetime_a $state<$meta::Driver>,
+                [<$obj StateMutator>]<$lifetime_a, [<$obj State>]<$meta::State>>,
+            ) {
+                let new = self.state.[<get_new_ $obj:lower _state>](self.[<$obj:lower>]);
+
+                // SAFETY:
+                // - The new state is guaranteed to be present in `state` via our type
+                //   invariants.
+                // - The new state is guaranteed to have no mutators taken out via our type
+                //   invariants.
+                (self.state, unsafe { new.unwrap_unchecked() })
+            }
+        }
+
+        #[doc = concat!("Exchange this token for the [`", stringify!($state), "`].")]
+        pub fn take_state(self) -> &$lifetime_a $state<$meta::Driver> {
+            self.state
+        }
+    };
+}
+
+pub(crate) use impl_atomic_state_token_ops;
+
+/// A token proving that no modesets for a commit have completed.
+///
+/// This token is proof that no commits have yet completed, and is provided as an argument to
+/// [`KmsDriver::atomic_commit_tail`]. This may be used with
+/// [`AtomicCommitTail::commit_modeset_disables`].
+pub struct ModesetsReadyToken<'a>(PhantomData<&'a ()>);
+
+/// A token proving that modeset disables for a commit have completed.
+///
+/// This token is proof that an implementor's [`KmsDriver::atomic_commit_tail`] phase has finished
+/// committing any operations which disable mode objects. It is returned by
+/// [`AtomicCommitTail::commit_modeset_disables`], and can be used with
+/// [`AtomicCommitTail::commit_modeset_enables`] to acquire a [`EnablesCommittedToken`].
+pub struct DisablesCommittedToken<'a>(PhantomData<&'a ()>);
+
+/// A token proving that modeset enables for a commit have completed.
+///
+/// This token is proof that an implementor's [`KmsDriver::atomic_commit_tail`] phase has finished
+/// committing any operations which enable mode objects. It is returned by
+/// [`AtomicCommitTail::commit_modeset_enables`].
+pub struct EnablesCommittedToken<'a>(PhantomData<&'a ()>);
+
+/// A token proving that no plane updates for a commit have completed.
+///
+/// This token is proof that no plane updates have yet been completed within an implementor's
+/// [`KmsDriver::atomic_commit_tail`] implementation, and that we are ready to begin updating planes. It
+/// is provided as an argument to [`KmsDriver::atomic_commit_tail`].
+pub struct PlaneUpdatesReadyToken<'a>(PhantomData<&'a ()>);
+
+/// A token proving that all plane updates for a commit have completed.
+///
+/// This token is proof that all plane updates within an implementor's [`KmsDriver::atomic_commit_tail`]
+/// implementation have completed. It is returned by [`AtomicCommitTail::commit_planes`].
+pub struct PlaneUpdatesCommittedToken<'a>(PhantomData<&'a ()>);
+
+/// An [`AtomicState`] interface that allows a driver to control the [`atomic_commit_tail`]
+/// callback.
+///
+/// This object is provided as an argument to [`KmsDriver::atomic_commit_tail`], and represents an atomic
+/// state within the commit tail phase which is still in the process of being committed to hardware.
+/// It may be used to control the order in which the commit process happens.
+///
+/// # Invariants
+///
+/// Same as [`AtomicState`].
+///
+/// [`atomic_commit_tail`]: srctree/include/drm/drm_modeset_helper_vtables.h
+pub struct AtomicCommitTail<'a, T: KmsDriver>(&'a AtomicState<T>);
+
+impl<'a, T: KmsDriver> AtomicCommitTail<'a, T> {
+    /// Commit modesets which would disable outputs.
+    ///
+    /// This function commits any modesets which would shut down outputs, along with preparing them
+    /// for a new mode (if needed).
+    ///
+    /// Since it is physically impossible to disable an output multiple times, and since it is
+    /// logically unsound to disable an output within an atomic commit after the output was enabled
+    /// in the same commit - this function requires a [`ModesetsReadyToken`] to consume and returns
+    /// a [`DisablesCommittedToken`].
+    ///
+    /// If compatibility with legacy CRTC helpers is desired, this
+    /// should be called before [`commit_planes`] which is what the default commit function does.
+    /// But drivers with different needs can group the modeset commits tgether and do the plane
+    /// commits at the end. This is useful for drivers doing runtime PM since then plane updates
+    /// only happen when the CRTC is actually enabled.
+    ///
+    /// [`commit_planes`]: AtomicCommitTail::commit_planes
+    #[inline]
+    #[must_use]
+    pub fn commit_modeset_disables<'b>(
+        &mut self,
+        _token: ModesetsReadyToken<'_>,
+    ) -> DisablesCommittedToken<'b> {
+        // SAFETY: Both `as_raw()` calls are guaranteed to return valid pointers
+        unsafe {
+            bindings::drm_atomic_helper_commit_modeset_disables(
+                self.0.drm_dev().as_raw(),
+                self.0.as_raw(),
+            )
+        }
+
+        DisablesCommittedToken(PhantomData)
+    }
+
+    /// Commit all plane updates.
+    ///
+    /// This function performs all plane updates for the given [`AtomicCommitTail`]. Since it is
+    /// logically unsound to perform the same plane update more then once in a given atomic commit,
+    /// this function requires a [`PlaneUpdatesReadyToken`] to consume and returns a
+    /// [`PlaneUpdatesCommittedToken`] to prove that plane updates for the state have completed.
+    #[inline]
+    #[must_use]
+    pub fn commit_planes<'b>(
+        &mut self,
+        _token: PlaneUpdatesReadyToken<'_>,
+        flags: PlaneCommitFlags,
+    ) -> PlaneUpdatesCommittedToken<'b> {
+        // SAFETY: Both `as_raw()` calls are guaranteed to return valid pointers
+        unsafe {
+            bindings::drm_atomic_helper_commit_planes(
+                self.0.drm_dev().as_raw(),
+                self.0.as_raw(),
+                flags.into(),
+            )
+        }
+
+        PlaneUpdatesCommittedToken(PhantomData)
+    }
+
+    /// Commit modesets which would enable outputs.
+    ///
+    /// This function commits any modesets in the given [`AtomicCommitTail`] which would enable
+    /// outputs, along with preparing them for their new modes (if needed).
+    ///
+    /// Since it is logically unsound to enable an output before any disabling modesets within the
+    /// same atomic commit have been performed, and physically impossible to enable the same output
+    /// multiple times - this function requires a [`DisablesCommittedToken`] to consume and returns
+    /// a [`EnablesCommittedToken`] which may be used as proof that all modesets in the state have
+    /// been completed.
+    #[inline]
+    #[must_use]
+    pub fn commit_modeset_enables<'b>(
+        &mut self,
+        _token: DisablesCommittedToken<'_>,
+    ) -> EnablesCommittedToken<'b> {
+        // SAFETY: Both `as_raw()` calls are guaranteed to return valid pointers
+        unsafe {
+            bindings::drm_atomic_helper_commit_modeset_enables(
+                self.0.drm_dev().as_raw(),
+                self.0.as_raw(),
+            )
+        }
+
+        EnablesCommittedToken(PhantomData)
+    }
+
+    /// Fake vblank events if needed.
+    ///
+    /// Note that this is still relevant to drivers which don't implement [`VblankSupport`] for any
+    /// of their CRTCs.
+    ///
+    /// TODO: more doc
+    ///
+    /// [`VblankSupport`]: super::vblank::VblankSupport
+    pub fn fake_vblank(&mut self) {
+        // SAFETY: `as_raw()` is guaranteed to always return a valid pointer
+        unsafe { bindings::drm_atomic_helper_fake_vblank(self.0.as_raw()) }
+    }
+
+    /// Signal completion of the hardware commit step.
+    ///
+    /// This swaps the atomic state into the relevant atomic state pointers and marks the hardware
+    /// commit step as completed. Since this step can only happen after all plane updates and
+    /// modesets within an [`AtomicCommitTail`] have been completed, it requires both a
+    /// [`EnablesCommittedToken`] and a [`PlaneUpdatesCommittedToken`] to consume. After this
+    /// function is called, the caller no longer has exclusive access to the underlying atomic
+    /// state. As such, this function consumes the [`AtomicCommitTail`] object and returns a
+    /// [`CommittedAtomicState`] accessor for performing post-hw commit tasks.
+    pub fn commit_hw_done<'b>(
+        self,
+        _modeset_token: EnablesCommittedToken<'_>,
+        _plane_updates_token: PlaneUpdatesCommittedToken<'_>,
+    ) -> CommittedAtomicState<'b, T>
+    where
+        'a: 'b,
+    {
+        // SAFETY: we consume the `AtomicCommitTail` object, making it impossible for the user to
+        // mutate the state after this function has been called - which upholds the safety
+        // requirements of the C API allowing us to safely call this function
+        unsafe { bindings::drm_atomic_helper_commit_hw_done(self.0.as_raw()) };
+
+        CommittedAtomicState(self.0)
+    }
+}
+
+// The actual raw C callback for custom atomic commit tail implementations
+pub(crate) unsafe extern "C" fn commit_tail_callback<T: KmsDriver>(
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // - We're guaranteed by DRM that `state` always points to a valid instance of
+    //   `bindings::drm_atomic_state`
+    // - This conversion is safe via the type invariants
+    let state = unsafe { AtomicState::from_raw(state.cast_const()) };
+
+    T::atomic_commit_tail(
+        AtomicCommitTail(state),
+        ModesetsReadyToken(PhantomData),
+        PlaneUpdatesReadyToken(PhantomData),
+    );
+}
+
+/// An [`AtomicState`] which was just committed with [`AtomicCommitTail::commit_hw_done`].
+///
+/// This object represents an [`AtomicState`] which has been fully committed to hardware, and as
+/// such may no longer be mutated as it is visible to userspace. It may be used to control what
+/// happens immediately after an atomic commit finishes within the [`atomic_commit_tail`] callback.
+///
+/// Since acquiring this object means that all modesetting locks have been dropped, a non-blocking
+/// commit could happen at the same time an [`atomic_commit_tail`] implementer has access to this
+/// object. Thus, it cannot be assumed that this object represents the current hardware state - and
+/// instead only represents the final result of the [`AtomicCommitTail`] that was just committed.
+///
+/// # Invariants
+///
+/// It may be assumed that [`drm_atomic_helper_commit_hw_done`] has been called as long as this type
+/// exists.
+///
+/// [`atomic_commit_tail`]: KmsDriver::atomic_commit_tail
+/// [`drm_atomic_helper_commit_hw_done`]: srctree/include/drm/drm_atomic_helper.h
+pub struct CommittedAtomicState<'a, T: KmsDriver>(&'a AtomicState<T>);
+
+impl<'a, T: KmsDriver> CommittedAtomicState<'a, T> {
+    /// Wait for page flips on this state to complete
+    pub fn wait_for_flip_done(&self) {
+        // SAFETY: `drm_atomic_helper_commit_hw_done` has been called via our invariants
+        unsafe {
+            bindings::drm_atomic_helper_wait_for_flip_done(
+                self.0.drm_dev().as_raw(),
+                self.0.as_raw(),
+            )
+        }
+    }
+}
+
+impl<'a, T: KmsDriver> Drop for CommittedAtomicState<'a, T> {
+    fn drop(&mut self) {
+        // SAFETY:
+        // * This interface represents the last atomic state accessor which could be affected as a
+        //   result of resources from an atomic commit being cleaned up.
+        unsafe {
+            bindings::drm_atomic_helper_cleanup_planes(self.0.drm_dev().as_raw(), self.0.as_raw())
+        }
+    }
+}
+
+/// An enumator representing a single flag in [`PlaneCommitFlags`].
+///
+/// This is a non-exhaustive list, as the C side could add more later.
+#[derive(Copy, Clone, PartialEq, Eq)]
+#[repr(u32)]
+#[non_exhaustive]
+pub enum PlaneCommitFlag {
+    /// Don't notify applications of plane updates for newly-disabled planes. Drivers are encouraged
+    /// to set this flag by default, as otherwise they need to ignore plane updates for disabled
+    /// planes by hand.
+    ActiveOnly = (1 << 0),
+    /// Tell the DRM core that the display hardware requires that a [`Crtc`]'s planes must be
+    /// disabled when the [`Crtc`] is disabled. When not specified,
+    /// [`AtomicCommitTail::commit_planes`] will skip the atomic disable callbacks for a plane if
+    /// the [`Crtc`] in the old [`PlaneState`] needs a modesetting operation. It is still up to the
+    /// driver to disable said planes in their [`DriverCrtc::atomic_disable`] callback.
+    NoDisableAfterModeset = (1 << 1),
+}
+
+impl BitOr for PlaneCommitFlag {
+    type Output = PlaneCommitFlags;
+
+    fn bitor(self, rhs: Self) -> Self::Output {
+        PlaneCommitFlags(self as u32 | rhs as u32)
+    }
+}
+
+impl BitOr<PlaneCommitFlags> for PlaneCommitFlag {
+    type Output = PlaneCommitFlags;
+
+    fn bitor(self, rhs: PlaneCommitFlags) -> Self::Output {
+        PlaneCommitFlags(self as u32 | rhs.0)
+    }
+}
+
+/// A bitmask for controlling the behavior of [`AtomicCommitTail::commit_planes`].
+///
+/// This corresponds to the `DRM_PLANE_COMMIT_*` flags on the C side. Note that this bitmask does
+/// not discard unknown values in order to ensure that adding new flags on the C side of things does
+/// not break anything in the future.
+#[derive(Copy, Clone, Default, PartialEq, Eq)]
+pub struct PlaneCommitFlags(u32);
+
+impl From<PlaneCommitFlag> for PlaneCommitFlags {
+    fn from(value: PlaneCommitFlag) -> Self {
+        Self(value as u32)
+    }
+}
+
+impl From<PlaneCommitFlags> for u32 {
+    fn from(value: PlaneCommitFlags) -> Self {
+        value.0
+    }
+}
+
+impl BitOr for PlaneCommitFlags {
+    type Output = Self;
+
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl BitOrAssign for PlaneCommitFlags {
+    fn bitor_assign(&mut self, rhs: Self) {
+        *self = *self | rhs
+    }
+}
+
+impl BitAnd for PlaneCommitFlags {
+    type Output = PlaneCommitFlags;
+
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl BitAndAssign for PlaneCommitFlags {
+    fn bitand_assign(&mut self, rhs: Self) {
+        *self = *self & rhs
+    }
+}
+
+impl BitOr<PlaneCommitFlag> for PlaneCommitFlags {
+    type Output = Self;
+
+    fn bitor(self, rhs: PlaneCommitFlag) -> Self::Output {
+        self | Self::from(rhs)
+    }
+}
+
+impl BitOrAssign<PlaneCommitFlag> for PlaneCommitFlags {
+    fn bitor_assign(&mut self, rhs: PlaneCommitFlag) {
+        *self = *self | rhs
+    }
+}
+
+impl BitAnd<PlaneCommitFlag> for PlaneCommitFlags {
+    type Output = PlaneCommitFlags;
+
+    fn bitand(self, rhs: PlaneCommitFlag) -> Self::Output {
+        self & Self::from(rhs)
+    }
+}
+
+impl BitAndAssign<PlaneCommitFlag> for PlaneCommitFlags {
+    fn bitand_assign(&mut self, rhs: PlaneCommitFlag) {
+        *self = *self & rhs
+    }
+}
+
+impl PlaneCommitFlags {
+    /// Create a new bitmask.
+    pub fn new() -> Self {
+        Self::default()
+    }
+
+    /// Check if the bitmask has the given commit flag set.
+    pub fn has(&self, flag: PlaneCommitFlag) -> bool {
+        *self & flag == flag.into()
+    }
+}
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
new file mode 100644
index 000000000000..05ec64cf6fa2
--- /dev/null
+++ b/rust/kernel/drm/kms/connector.rs
@@ -0,0 +1,997 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM display connectors.
+//!
+//! C header: [`include/drm/drm_connector.h`](srctree/include/drm/drm_connector.h)
+
+use super::{
+    atomic::*, encoder::*, KmsDriver, ModeConfigGuard, ModeObject, ModeObjectVtable, Sealed
+};
+use crate::{
+    alloc::KBox,
+    bindings,
+    drm::{device::Device, kms::{NewKmsDevice, Probing}},
+    error::to_result,
+    prelude::*,
+    types::{NotThreadSafe, Opaque},
+};
+use core::{
+    cell::Cell,
+    marker::*,
+    mem::{self, ManuallyDrop},
+    ops::*,
+    ptr::{null_mut, NonNull},
+    stringify,
+};
+use macros::paste;
+
+/// A macro for generating our type ID enumerator.
+macro_rules! declare_conn_types {
+    ($( $oldname:ident as $newname:ident ),+) => {
+        /// An enumerator for all possible [`Connector`] type IDs.
+        #[repr(i32)]
+        #[non_exhaustive]
+        #[derive(Copy, Clone, PartialEq, Eq)]
+        pub enum Type {
+            // Note: bindgen defaults the macro values to u32 and not i32, but DRM takes them as an
+            // i32 - so just do the conversion here
+            $(
+                #[doc = concat!("The connector type ID for a ", stringify!($newname), " connector.")]
+                $newname = paste!(crate::bindings::[<DRM_MODE_CONNECTOR_ $oldname>]) as i32
+            ),+,
+
+            // 9PinDIN is special because of the 9, making it an invalid ident. Just define it here
+            // manually since it's the only one
+
+            /// The connector type ID for a 9PinDIN connector.
+            _9PinDin = crate::bindings::DRM_MODE_CONNECTOR_9PinDIN as i32
+        }
+    };
+}
+
+declare_conn_types! {
+    Unknown     as Unknown,
+    Composite   as Composite,
+    Component   as Component,
+    DisplayPort as DisplayPort,
+    VGA         as Vga,
+    DVII        as DviI,
+    DVID        as DviD,
+    DVIA        as DviA,
+    SVIDEO      as SVideo,
+    LVDS        as Lvds,
+    HDMIA       as HdmiA,
+    HDMIB       as HdmiB,
+    TV          as Tv,
+    eDP         as Edp,
+    VIRTUAL     as Virtual,
+    DSI         as Dsi,
+    DPI         as Dpi,
+    WRITEBACK   as Writeback,
+    SPI         as Spi,
+    USB         as Usb
+}
+
+/// The main trait for implementing the [`struct drm_connector`] API for [`Connector`].
+///
+/// Any KMS driver should have at least one implementation of this type, which allows them to create
+/// [`Connector`] objects. Additionally, a driver may store driver-private data within the type that
+/// implements [`DriverConnector`] - and it will be made available when using a fully typed
+/// [`Connector`] object.
+///
+/// # Invariants
+///
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_connector`] pointers are contained within a [`Connector<Self>`].
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_connector_state`] pointers are contained within a
+///   [`ConnectorState<Self::State>`].
+///
+/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
+/// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+#[vtable]
+pub trait DriverConnector: Send + Sync + Sized {
+    /// The generated C vtable for this [`DriverConnector`] implementation
+    const OPS: &'static DriverConnectorOps = &DriverConnectorOps {
+        funcs: bindings::drm_connector_funcs {
+            dpms: None,
+            atomic_get_property: None,
+            atomic_set_property: None,
+            early_unregister: None,
+            late_register: None,
+            set_property: None,
+            reset: Some(connector_reset_callback::<Self::State>),
+            atomic_print_state: None,
+            atomic_destroy_state: Some(atomic_destroy_state_callback::<Self::State>),
+            destroy: Some(connector_destroy_callback::<Self>),
+            force: None,
+            detect: None,
+            fill_modes: Some(bindings::drm_helper_probe_single_connector_modes),
+            debugfs_init: None,
+            oob_hotplug_event: None,
+            atomic_duplicate_state: Some(atomic_duplicate_state_callback::<Self::State>),
+        },
+        helper_funcs: bindings::drm_connector_helper_funcs {
+            mode_valid: None,
+            atomic_check: None,
+            get_modes: Some(get_modes_callback::<Self>),
+            detect_ctx: None,
+            enable_hpd: None,
+            disable_hpd: None,
+            best_encoder: None,
+            atomic_commit: None,
+            mode_valid_ctx: None,
+            atomic_best_encoder: None,
+            prepare_writeback_job: None,
+            cleanup_writeback_job: None,
+        },
+    };
+
+    /// The type to pass to the `args` field of [`UnregisteredConnector::new`].
+    ///
+    /// This type will be made available in in the `args` argument of [`Self::new`]. Drivers which
+    /// don't need this can simply pass [`()`] here.
+    type Args;
+
+    /// The parent [`KmsDriver`] implementation.
+    type Driver: KmsDriver;
+
+    /// The [`DriverConnectorState`] implementation for this [`DriverConnector`].
+    ///
+    /// See [`DriverConnectorState`] for more info.
+    type State: DriverConnectorState;
+
+    /// The constructor for creating a [`Connector`] using this [`DriverConnector`] implementation.
+    ///
+    /// Drivers may use this to instantiate their [`DriverConnector`] object.
+    fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+
+    /// Retrieve a list of available display modes for this [`Connector`].
+    fn get_modes<'a>(
+        connector: ConnectorGuard<'a, Self>,
+        guard: &ModeConfigGuard<'a, Self::Driver>,
+    ) -> i32;
+}
+
+/// The generated C vtable for a [`DriverConnector`].
+///
+/// This type is created internally by DRM.
+pub struct DriverConnectorOps {
+    funcs: bindings::drm_connector_funcs,
+    helper_funcs: bindings::drm_connector_helper_funcs,
+}
+
+/// The main interface for a [`struct drm_connector`].
+///
+/// This type is the main interface for dealing with DRM connectors. In addition, it also allows
+/// immutable access to whatever private data is contained within an implementor's
+/// [`DriverConnector`] type.
+///
+/// # Invariants
+///
+/// - The DRM C API and our interface guarantees that only the user has mutable access to `state`,
+///   up until [`drm_atomic_helper_commit_hw_done`] is called. Therefore, `connector` follows rust's
+///   data aliasing rules and does not need to be behind an [`Opaque`] type.
+/// - `connector` and `inner` are initialized for as long as this object is made available to users.
+/// - The data layout of this structure begins with [`struct drm_connector`].
+/// - The atomic state for this type can always be assumed to be of type
+///   [`ConnectorState<T::State>`].
+///
+/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
+/// [`drm_atomic_helper_commit_hw_done`]: srctree/include/drm/drm_atomic_helper.h
+#[repr(C)]
+#[pin_data]
+pub struct Connector<T: DriverConnector> {
+    connector: Opaque<bindings::drm_connector>,
+    #[pin]
+    inner: T,
+    #[pin]
+    _p: PhantomPinned,
+}
+
+impl<T: DriverConnector> Sealed for Connector<T> {}
+
+impl<T: DriverConnector> Deref for Connector<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+impl<T: DriverConnector> Connector<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D>(&'a OpaqueConnector<D>) -> &'a Self;
+        use
+            T as DriverConnector,
+            D as KmsDriver<Connector = ...>
+    }
+
+    /// Acquire a [`ConnectorGuard`] for this connector from a [`ModeConfigGuard`].
+    ///
+    /// This verifies using the provided reference that the given guard is actually for the same
+    /// device as this connector's parent.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `guard` is not a [`ModeConfigGuard`] for this connector's parent [`Device`].
+    pub fn guard<'a>(&'a self, guard: &ModeConfigGuard<'a, T::Driver>) -> ConnectorGuard<'a, T> {
+        guard.assert_owner(self.drm_dev());
+        ConnectorGuard(self)
+    }
+}
+
+/// A trait implemented by any type that acts as a [`struct drm_connector`] interface.
+///
+/// This is implemented internally by DRM.
+///
+/// # Safety
+///
+/// [`as_raw()`] must always return a pointer to a valid initialized [`struct drm_connector`].
+///
+/// [`as_raw()`]: AsRawConnector::as_raw()
+/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
+pub unsafe trait AsRawConnector {
+    /// Return the raw [`struct drm_connector`] for this DRM connector.
+    ///
+    /// Drivers should never use this directly
+    ///
+    /// [`struct drm_Connector`]: srctree/include/drm/drm_connector.h
+    fn as_raw(&self) -> *mut bindings::drm_connector;
+
+    /// Convert a raw `bindings::drm_connector` pointer into an object of this type.
+    ///
+    /// # Safety
+    ///
+    /// Callers promise that `ptr` points to a valid instance of this type.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connector) -> &'a Self;
+}
+
+/// A supertrait of [`AsRawConnector`] for [`struct drm_connector`] interfaces that can perform
+/// modesets.
+///
+/// This is implemented internally by DRM.
+///
+/// # Safety
+///
+/// Any object implementing this trait must only be made directly available to the user after
+/// [`create_objects`] has completed.
+///
+/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
+/// [`create_objects`]: KmsDriver::create_objects
+pub unsafe trait ModesettableConnector: AsRawConnector {
+    /// The type that should be returned for a plane state acquired using this plane interface
+    type State: FromRawConnectorState;
+}
+
+// SAFETY: Our connector interfaces are guaranteed to be thread-safe
+unsafe impl<T: DriverConnector> Send for Connector<T> {}
+
+// SAFETY: Our connector interfaces are guaranteed to be thread-safe
+unsafe impl<T: DriverConnector> Sync for Connector<T> {}
+
+// SAFETY: We don't expose Connector<T> to users before `base` is initialized in ::new(), so
+// `raw_mode_obj` always returns a valid pointer to a bindings::drm_mode_object.
+unsafe impl<T: DriverConnector> ModeObject for Connector<T> {
+    type Driver = T::Driver;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: The parent device for a DRM connector will never outlive the connector, and this
+        // pointer is invariant through the lifetime of the connector
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose DRM connectors to users before `base` is initialized
+        unsafe { &raw mut (*self.as_raw()).base }
+    }
+}
+
+// Connectors are refcounted objects.
+super::impl_aref_for_mode_object! {
+    impl<T: DriverConnector> for Connector<T>
+}
+
+// SAFETY: `funcs` is initialized by DRM when the connector is allocated
+unsafe impl<T: DriverConnector> ModeObjectVtable for Connector<T> {
+    type Vtable = bindings::drm_connector_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `funcs` is initialized by DRM when the connector is allocated
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+// SAFETY:
+// * Via our type variants our data layout starts with `drm_connector`
+// * Since we don't expose `Connector` to users before it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_connector`.
+unsafe impl<T: DriverConnector> AsRawConnector for Connector<T> {
+    fn as_raw(&self) -> *mut bindings::drm_connector {
+        self.connector.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connector) -> &'a Self {
+        // SAFETY: Our data layout starts with `bindings::drm_connector`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: We only expose this object to users directly after KmsDriver::create_objects has been
+// called.
+unsafe impl<T: DriverConnector> ModesettableConnector for Connector<T> {
+    type State = ConnectorState<T::State>;
+}
+
+/// A [`Connector`] that has not yet been registered with userspace.
+///
+/// KMS registration is single-threaded, so this object is not thread-safe.
+///
+/// # Invariants
+///
+/// - This object can only exist before its respective KMS device has been registered.
+/// - Otherwise, it inherits all invariants of [`Connector`] and has an identical data layout.
+pub struct UnregisteredConnector<T: DriverConnector>(Connector<T>, NotThreadSafe);
+
+// SAFETY: We share the invariants of `Connector`
+unsafe impl<T: DriverConnector> AsRawConnector for UnregisteredConnector<T> {
+    fn as_raw(&self) -> *mut bindings::drm_connector {
+        self.0.as_raw()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connector) -> &'a Self {
+        // SAFETY: This is another from_raw() call, so this function shares the same safety contract
+        let connector = unsafe { Connector::<T>::from_raw(ptr) };
+
+        // SAFETY: Our data layout is identical via our type invariants.
+        unsafe { mem::transmute(connector) }
+    }
+}
+
+impl<T: DriverConnector> Deref for UnregisteredConnector<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0.inner
+    }
+}
+
+impl<T: DriverConnector> UnregisteredConnector<T> {
+    /// Construct a new [`UnregisteredConnector`].
+    ///
+    /// A driver may use this to create new [`UnregisteredConnector`] objects.
+    ///
+    /// [`KmsDriver::create_objects`]: kernel::drm::kms::KmsDriver::create_objects
+    pub fn new<'a>(
+        dev: &'a NewKmsDevice<'a, T::Driver, Probing>,
+        type_: Type,
+        args: T::Args,
+    ) -> Result<&'a Self> {
+        let new: Pin<KBox<Connector<T>>> = KBox::try_pin_init(
+            try_pin_init!(Connector {
+                connector: Opaque::new(bindings::drm_connector {
+                    helper_private: &T::OPS.helper_funcs,
+                    ..Default::default()
+                }),
+                inner <- T::new(dev, args),
+                _p: PhantomPinned,
+            }),
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY:
+        // - `dev` will hold a reference to the new connector, and thus outlives us.
+        // - We just allocated `new` above
+        // - `new` starts with `drm_connector` via its type invariants.
+        to_result(unsafe {
+            bindings::drm_connector_init(dev.as_raw(), new.as_raw(), &T::OPS.funcs, type_ as i32)
+        })?;
+
+        // SAFETY: We don't move anything
+        let this = unsafe { Pin::into_inner_unchecked(new) };
+
+        // We'll re-assemble the box in connector_destroy_callback()
+        let this = KBox::into_raw(this);
+
+        // UnregisteredConnector has an equivalent data layout
+        let this: *mut Self = this.cast();
+
+        // SAFETY: We just allocated the connector above, so this pointer must be valid
+        Ok(unsafe { &*this })
+    }
+
+    /// Attach an encoder to this [`Connector`].
+    #[must_use]
+    pub fn attach_encoder(&self, encoder: &impl AsRawEncoder) -> Result {
+        // SAFETY:
+        // - Both as_raw() calls are guaranteed to return a valid pointer
+        // - We're guaranteed this connector is not registered via our type invariants, thus this
+        //   function is safe to call
+        to_result(unsafe {
+            bindings::drm_connector_attach_encoder(self.as_raw(), encoder.as_raw())
+        })
+    }
+}
+
+/// Common methods available on any type which implements [`AsRawConnector`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// connectors.
+pub trait RawConnector: AsRawConnector {
+    /// Return the index of this DRM connector
+    #[inline]
+    fn index(&self) -> u32 {
+        // SAFETY: The index is initialized by the time we expose DRM connector objects to users,
+        // and is invariant throughout the lifetime of the connector
+        unsafe { (*self.as_raw()).index }
+    }
+
+    /// Return the bitmask derived from this DRM connector's index
+    #[inline]
+    fn mask(&self) -> u32 {
+        1 << self.index()
+    }
+}
+impl<T: AsRawConnector> RawConnector for T {}
+
+unsafe extern "C" fn connector_destroy_callback<T: DriverConnector>(
+    connector: *mut bindings::drm_connector,
+) {
+    // SAFETY: DRM guarantees that `connector` points to a valid initialized `drm_connector`.
+    unsafe {
+        bindings::drm_connector_unregister(connector);
+        bindings::drm_connector_cleanup(connector);
+    };
+
+    // SAFETY:
+    // - We originally created the connector in a `Box`
+    // - We are guaranteed to hold the last remaining reference to this connector
+    // - This cast is safe via `DriverConnector`s type invariants.
+    drop(unsafe { KBox::from_raw(connector as *mut Connector<T>) });
+}
+
+unsafe extern "C" fn get_modes_callback<T: DriverConnector>(
+    connector: *mut bindings::drm_connector,
+) -> core::ffi::c_int {
+    // SAFETY: This is safe via `DriverConnector`s type invariants.
+    let connector = unsafe { Connector::<T>::from_raw(connector) };
+
+    // SAFETY: This FFI callback is only called while `mode_config.lock` is held
+    // We use ManuallyDrop here to prevent the lock from being released after the callback
+    // completes, as that should be handled by DRM.
+    let guard = ManuallyDrop::new(unsafe { ModeConfigGuard::new(connector.drm_dev()) });
+
+    T::get_modes(connector.guard(&guard), &guard)
+}
+
+/// A [`struct drm_connector`] without a known [`DriverConnector`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverConnector`]
+/// implementation for a [`struct drm_connector`] automatically. It is identical to [`Connector`],
+/// except that it does not provide access to the driver's private data.
+///
+/// # Invariants
+///
+/// - `connector` is initialized for as long as this object is exposed to users.
+/// - The data layout of this type is equivalent to [`struct drm_connector`].
+///
+/// [`struct drm_connector`]: srctree/include/drm/drm_connector.h
+#[repr(transparent)]
+pub struct OpaqueConnector<T: KmsDriver> {
+    connector: Opaque<bindings::drm_connector>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> Sealed for OpaqueConnector<T> {}
+
+// SAFETY:
+// - Via our type variants our data layout starts is identical to `drm_connector`
+// - Since we don't expose `OpaqueConnector` to users before it has been initialized, this and our
+//   data layout ensure that `as_raw()` always returns a valid pointer to a `drm_connector`.
+unsafe impl<T: KmsDriver> AsRawConnector for OpaqueConnector<T> {
+    fn as_raw(&self) -> *mut bindings::drm_connector {
+        self.connector.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connector) -> &'a Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_connector`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: We only expose this object to users directly after KmsDriver::create_objects has been
+// called.
+unsafe impl<T: KmsDriver> ModesettableConnector for OpaqueConnector<T> {
+    type State = OpaqueConnectorState<T>;
+}
+
+// SAFETY: We don't expose OpaqueConnector<T> to users before `base` is initialized in
+// Connector::new(), so `raw_mode_obj` always returns a valid pointer to a bindings::drm_mode_object.
+unsafe impl<T: KmsDriver> ModeObject for OpaqueConnector<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: The parent device for a DRM connector will never outlive the connector, and this
+        // pointer is invariant through the lifetime of the connector
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose DRM connectors to users before `base` is initialized
+        unsafe { &mut (*self.as_raw()).base }
+    }
+}
+
+super::impl_aref_for_mode_object! {
+    impl<T: KmsDriver> for OpaqueConnector<T>
+}
+
+// SAFETY: `funcs` is initialized by DRM when the connector is allocated
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueConnector<T> {
+    type Vtable = bindings::drm_connector_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `funcs` is initialized by DRM when the connector is allocated
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+// SAFETY: Our connector interfaces are guaranteed to be thread-safe
+unsafe impl<T: KmsDriver> Send for OpaqueConnector<T> {}
+unsafe impl<T: KmsDriver> Sync for OpaqueConnector<T> {}
+
+/// A privileged [`Connector`] obtained while holding a [`ModeConfigGuard`].
+///
+/// This provides access to various methods for [`Connector`] that must happen under lock, such as
+/// setting resolution preferences and adding display modes.
+///
+/// # Invariants
+///
+/// Shares the invariants of [`ModeConfigGuard`].
+#[derive(Copy, Clone)]
+pub struct ConnectorGuard<'a, T: DriverConnector>(&'a Connector<T>);
+
+impl<T: DriverConnector> Deref for ConnectorGuard<'_, T> {
+    type Target = Connector<T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
+impl<'a, T: DriverConnector> ConnectorGuard<'a, T> {
+    /// Add modes for a [`ConnectorGuard`] without an EDID.
+    ///
+    /// Add the specified modes to the connector's mode list up to the given maximum resultion.
+    /// Returns how many modes were added.
+    pub fn add_modes_noedid(&self, (max_h, max_v): (u32, u32)) -> i32 {
+        // SAFETY: We hold the locks required to call this via our type invariants.
+        unsafe { bindings::drm_add_modes_noedid(self.as_raw(), max_h, max_v) }
+    }
+
+    /// Set the preferred display mode for the underlying [`Connector`].
+    pub fn set_preferred_mode(&self, (h_pref, w_pref): (u32, u32)) {
+        // SAFETY: We hold the locks required to call this via our type invariants.
+        unsafe { bindings::drm_set_preferred_mode(self.as_raw(), h_pref, w_pref) }
+    }
+}
+
+/// A trait implemented by any type which can produce a reference to a
+/// [`struct drm_connector_state`].
+///
+/// This is implemented internally by DRM.
+///
+/// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+pub trait AsRawConnectorState: private::AsRawConnectorState {
+    /// The type that represents this connector state's DRM connector.
+    type Connector: AsRawConnector;
+}
+
+pub(super) mod private {
+    use super::*;
+
+    /// Trait for retrieving references to the base connector state contained within any connector
+    /// state compatible type
+    #[allow(unreachable_pub)]
+    pub trait AsRawConnectorState {
+        /// Return an immutable reference to the raw connector state.
+        fn as_raw(&self) -> &bindings::drm_connector_state;
+
+        /// Get a mutable reference to the raw [`struct drm_connector_state`] contained within this
+        /// type.
+        ///
+        ///
+        /// # Safety
+        ///
+        /// The caller promises this mutable reference will not be used to modify any contents of
+        /// [`struct drm_connector_state`] which DRM would consider to be static - like the
+        /// backpointer to the DRM connector that owns this state. This also means the mutable
+        /// reference should never be exposed outside of this crate.
+        ///
+        /// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+        unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_connector_state;
+    }
+}
+
+pub(super) use private::AsRawConnectorState as AsRawConnectorStatePrivate;
+
+/// A trait implemented for any type which can be constructed directly from a
+/// [`struct drm_connector_state`] pointer.
+///
+/// This is implemented internally by DRM.
+///
+/// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+pub trait FromRawConnectorState: AsRawConnectorState {
+    /// Get an immutable reference to this type from the given raw [`struct drm_connector_state`]
+    /// pointer.
+    ///
+    /// # Safety
+    ///
+    /// - The caller guarantees `ptr` is contained within a valid instance of `Self`.
+    /// - The caller guarantees that `ptr` cannot not be modified for the lifetime of `'a`.
+    ///
+    /// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_connector_state) -> &'a Self;
+
+    /// Get a mutable reference to this type from the given raw [`struct drm_connector_state`]
+    /// pointer.
+    ///
+    /// # Safety
+    ///
+    /// - The caller guarantees that `ptr` is contained within a valid instance of `Self`.
+    /// - The caller guarantees that `ptr` cannot have any other references taken out for the
+    ///   lifetime of `'a`.
+    ///
+    /// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_connector_state) -> &'a mut Self;
+}
+
+/// Common methods available on any type which implements [`AsRawConnectorState`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// the atomic state of [`Connector`]s.
+pub trait RawConnectorState: AsRawConnectorState {
+    /// Return the connector that this atomic state belongs to.
+    fn connector(&self) -> &Self::Connector {
+        // SAFETY: This is guaranteed safe by type invariance, and we're guaranteed by DRM that
+        // `self.state.connector` points to a valid instance of a `Connector<T>`
+        unsafe { Self::Connector::from_raw((*self.as_raw()).connector) }
+    }
+}
+impl<T: AsRawConnectorState> RawConnectorState for T {}
+
+/// The main interface for a [`struct drm_connector_state`].
+///
+/// This type is the main interface for dealing with the atomic state of DRM connectors. In
+/// addition, it allows access to whatever private data is contained within an implementor's
+/// [`DriverConnectorState`] type.
+///
+/// # Invariants
+///
+/// - The DRM C API and our interface guarantees that only the user has mutable access to `state`,
+///   up until [`drm_atomic_helper_commit_hw_done`] is called. Therefore, `connector` follows rust's
+///   data aliasing rules and does not need to be behind an [`Opaque`] type.
+/// - `state` and `inner` initialized for as long as this object is exposed to users.
+/// - The data layout of this structure begins with [`struct drm_connector_state`].
+/// - The connector for this atomic state can always be assumed to be of type
+///   [`Connector<T::Connector>`].
+///
+/// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+/// [`drm_atomic_helper_commit_hw_done`]: srctree/include/drm/drm_atomic_helper.h
+#[derive(Default)]
+#[repr(C)]
+pub struct ConnectorState<T: DriverConnectorState> {
+    state: bindings::drm_connector_state,
+    inner: T,
+}
+
+/// The main trait for implementing the [`struct drm_connector_state`] API for a [`Connector`].
+///
+/// A driver may store driver-private data within the implementor's type, which will be available
+/// when using a full typed [`ConnectorState`] object.
+///
+/// # Invariants
+///
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_connector`] pointers are contained within a [`Connector<Self::Connector>`].
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_connector_state`] pointers are contained within a [`ConnectorState<Self>`].
+///
+/// [`struct drm_connector`]: srctree/include/drm_connector.h
+/// [`struct drm_connector_state`]: srctree/include/drm_connector.h
+pub trait DriverConnectorState: Clone + Default + Sized {
+    /// The parent [`DriverConnector`].
+    type Connector: DriverConnector;
+}
+
+impl<T: DriverConnectorState> Sealed for ConnectorState<T> {}
+
+impl<T: DriverConnectorState> AsRawConnectorState for ConnectorState<T> {
+    type Connector = Connector<T::Connector>;
+}
+
+impl<T: DriverConnectorState> private::AsRawConnectorState for ConnectorState<T> {
+    fn as_raw(&self) -> &bindings::drm_connector_state {
+        &self.state
+    }
+
+    unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_connector_state {
+        &mut self.state
+    }
+}
+
+impl<T: DriverConnectorState> FromRawConnectorState for ConnectorState<T> {
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_connector_state) -> &'a Self {
+        // Our data layout starts with `bindings::drm_connector_state`.
+        let ptr: *const Self = ptr.cast();
+
+        // SAFETY:
+        // - Our safety contract requires that `ptr` be contained within `Self`.
+        // - Our safety contract requires the caller ensure that it is safe for us to take an
+        //   immutable reference.
+        unsafe { &*ptr }
+    }
+
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_connector_state) -> &'a mut Self {
+        // Our data layout starts with `bindings::drm_connector_state`.
+        let ptr: *mut Self = ptr.cast();
+
+        // SAFETY:
+        // - Our safety contract requires that `ptr` be contained within `Self`.
+        // - Our safety contract requires the caller ensure it is safe for us to take a mutable
+        //   reference.
+        unsafe { &mut *ptr }
+    }
+}
+
+// SAFETY: `funcs` is initialized by DRM when the connector is allocated
+unsafe impl<T: DriverConnectorState> ModeObjectVtable for ConnectorState<T> {
+    type Vtable = bindings::drm_connector_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.connector().vtable()
+    }
+}
+
+impl<T: DriverConnectorState> ConnectorState<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D, C>(&'a OpaqueConnectorState<D>) -> &'a Self
+        where
+            T: DriverConnectorState<Connector = C>;
+        use
+            C as DriverConnector,
+            D as KmsDriver<Connector = ...>
+    }
+}
+
+/// A [`struct drm_connector_state`] without a known [`DriverConnectorState`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverConnectorState`]
+/// implementation for a [`struct drm_connector_state`] automatically. It is identical to
+/// [`Connector`], except that it does not provide access to the driver's private data.
+///
+/// # Invariants
+///
+/// - `state` is initialized for as long as this object is exposed to users.
+/// - The data layout of this type is identical to [`struct drm_connector_state`].
+/// - The DRM C API and our interface guarantees that only the user has mutable access to `state`,
+///   up until [`drm_atomic_helper_commit_hw_done`] is called. Therefore, `connector` follows rust's
+///   data aliasing rules and does not need to be behind an [`Opaque`] type.
+///
+/// [`struct drm_connector_state`]: srctree/include/drm/drm_connector.h
+/// [`drm_atomic_helper_commit_hw_done`]: srctree/include/drm/drm_atomic_helper.h
+#[repr(transparent)]
+pub struct OpaqueConnectorState<T: KmsDriver> {
+    state: bindings::drm_connector_state,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> AsRawConnectorState for OpaqueConnectorState<T> {
+    type Connector = OpaqueConnector<T>;
+}
+
+impl<T: KmsDriver> private::AsRawConnectorState for OpaqueConnectorState<T> {
+    fn as_raw(&self) -> &bindings::drm_connector_state {
+        &self.state
+    }
+
+    unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_connector_state {
+        &mut self.state
+    }
+}
+
+impl<T: KmsDriver> FromRawConnectorState for OpaqueConnectorState<T> {
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_connector_state) -> &'a Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_connector_state`
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_connector_state) -> &'a mut Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_connector_state`
+        unsafe { &mut *ptr.cast() }
+    }
+}
+
+// SAFETY: See OpaqueConnector's ModeObjectVtable implementation
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueConnectorState<T> {
+    type Vtable = bindings::drm_connector_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.connector().vtable()
+    }
+}
+
+/// An interface for mutating a [`Connector`]s atomic state.
+///
+/// This type is typically returned by an [`AtomicStateMutator`] within contexts where it is
+/// possible to safely mutate a connector's state. In order to uphold rust's data-aliasing rules,
+/// only [`ConnectorStateMutator`] may exist at a time.
+pub struct ConnectorStateMutator<'a, T: FromRawConnectorState> {
+    state: &'a mut T,
+    mask: &'a Cell<u32>,
+}
+
+impl<'a, T: FromRawConnectorState> ConnectorStateMutator<'a, T> {
+    pub(super) fn new<D: KmsDriver>(
+        mutator: &'a AtomicStateMutator<D>,
+        state: NonNull<bindings::drm_connector_state>,
+    ) -> Option<Self> {
+        // SAFETY:
+        // - `connector` is invariant throughout the lifetime of the atomic state.
+        // - `state` is initialized by the time it is passed to this function.
+        // - We're guaranteed that `state` is compatible with `drm_connector` by type invariants.
+        let connector = unsafe { T::Connector::from_raw((*state.as_ptr()).connector) };
+        let conn_mask = connector.mask();
+        let borrowed_mask = mutator.borrowed_connectors.get();
+
+        if borrowed_mask & conn_mask == 0 {
+            mutator.borrowed_connectors.set(borrowed_mask | conn_mask);
+            Some(Self {
+                mask: &mutator.borrowed_connectors,
+                // SAFETY: We're guaranteed `state` is of `T` by type invariance, and we just
+                // confirmed by checking `borrowed_connectors` that no other mutable borrows have
+                // been taken out for `state`
+                state: unsafe { T::from_raw_mut(state.as_ptr()) },
+            })
+        } else {
+            None
+        }
+    }
+}
+
+impl<'a, T: DriverConnectorState> Deref for ConnectorStateMutator<'a, ConnectorState<T>> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.state.inner
+    }
+}
+
+impl<'a, T: DriverConnectorState> DerefMut for ConnectorStateMutator<'a, ConnectorState<T>> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.state.inner
+    }
+}
+
+impl<'a, T: FromRawConnectorState> Drop for ConnectorStateMutator<'a, T> {
+    fn drop(&mut self) {
+        let mask = self.state.connector().mask();
+        self.mask.set(self.mask.get() & !mask);
+    }
+}
+
+impl<'a, T: FromRawConnectorState> AsRawConnectorState for ConnectorStateMutator<'a, T> {
+    type Connector = T::Connector;
+}
+
+impl<'a, T: FromRawConnectorState> private::AsRawConnectorState for ConnectorStateMutator<'a, T> {
+    fn as_raw(&self) -> &bindings::drm_connector_state {
+        self.state.as_raw()
+    }
+
+    unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_connector_state {
+        // SAFETY: We're bound by the same safety contract as this function
+        unsafe { self.state.as_raw_mut() }
+    }
+}
+
+// SAFETY: we inherit the safety guarantees of `T`
+unsafe impl<'a, T> ModeObjectVtable for ConnectorStateMutator<'a, T>
+where
+    T: FromRawConnectorState + ModeObjectVtable,
+{
+    type Vtable = T::Vtable;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.state.vtable()
+    }
+}
+
+impl<'a, T: DriverConnectorState> ConnectorStateMutator<'a, ConnectorState<T>> {
+    super::impl_from_opaque_mode_obj! {
+        fn <D, C>(ConnectorStateMutator<'a, OpaqueConnectorState<D>>) -> Self
+        where
+            T: DriverConnectorState<Connector = C>;
+        use
+            C as DriverConnector,
+            D as KmsDriver<Connector = ...>
+    }
+}
+
+unsafe extern "C" fn atomic_duplicate_state_callback<T: DriverConnectorState>(
+    connector: *mut bindings::drm_connector,
+) -> *mut bindings::drm_connector_state {
+    // SAFETY: DRM guarantees that `connector` points to a valid initialized `drm_connector`.
+    let state = unsafe { (*connector).state };
+    if state.is_null() {
+        return null_mut();
+    }
+
+    // SAFETY:
+    // - We just verified that `state` is non-null
+    // - This cast is guaranteed to be safe via our type invariants.
+    let state = unsafe { ConnectorState::<T>::from_raw(state) };
+
+    let new: Result<KBox<_>> = KBox::init(
+        init!(ConnectorState::<T> {
+            inner: state.inner.clone(),
+            state: bindings::drm_connector_state {
+                ..Default::default()
+            },
+        }),
+        GFP_KERNEL,
+    );
+
+    if let Ok(mut new) = new {
+        // SAFETY:
+        // - `new` provides a valid pointer to a newly allocated `drm_plane_state` via type
+        //   invariants
+        // - This initializes `new` via memcpy()
+        unsafe {
+            bindings::__drm_atomic_helper_connector_duplicate_state(connector, new.as_raw_mut())
+        };
+
+        KBox::into_raw(new).cast()
+    } else {
+        null_mut()
+    }
+}
+
+unsafe extern "C" fn atomic_destroy_state_callback<T: DriverConnectorState>(
+    _connector: *mut bindings::drm_connector,
+    connector_state: *mut bindings::drm_connector_state,
+) {
+    // SAFETY: DRM guarantees that `state` points to a valid instance of `drm_connector_state`
+    unsafe { bindings::__drm_atomic_helper_connector_destroy_state(connector_state) };
+
+    // SAFETY:
+    // - DRM guarantees we are the only one with access to this `drm_connector_state`
+    // - This cast is safe via our type invariants.
+    drop(unsafe { KBox::from_raw(connector_state.cast::<ConnectorState<T>>()) });
+}
+
+unsafe extern "C" fn connector_reset_callback<T: DriverConnectorState>(
+    connector: *mut bindings::drm_connector,
+) {
+    // SAFETY: DRM guarantees that `state` points to a valid instance of `drm_connector_state`
+    let state = unsafe { (*connector).state };
+    if !state.is_null() {
+        // SAFETY:
+        // - We're guaranteed `connector` is `Connector<T>` via type invariants
+        // - We're guaranteed `state` is `ConnectorState<T>` via type invariants.
+        unsafe { atomic_destroy_state_callback::<T>(connector, state) }
+
+        // SAFETY: No special requirements here, DRM expects this to be NULL
+        unsafe { (*connector).state = null_mut() };
+    }
+
+    // Unfortunately, this is the best we can do at the moment as this FFI callback was mistakenly
+    // presumed to be infallible :(
+    let new = KBox::new(ConnectorState::<T>::default(), GFP_KERNEL).expect("Blame the API, sorry!");
+
+    // DRM takes ownership of the state from here, resets it, and then assigns it to the connector
+    // SAFETY:
+    // - DRM guarantees that `connector` points to a valid instance of `drm_connector`.
+    // - The cast to `drm_connector_state` is safe via `ConnectorState`s type invariants.
+    unsafe { bindings::__drm_atomic_helper_connector_reset(connector, Box::into_raw(new).cast()) };
+}
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
new file mode 100644
index 000000000000..b9d095854ba6
--- /dev/null
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -0,0 +1,1110 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM CRTCs.
+//!
+//! C header: [`include/drm/drm_crtc.h`](srctree/include/drm/drm_crtc.h)
+
+use super::{
+    atomic::*, plane::*, vblank::*, KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject,
+    NewKmsDevice, Probing, Sealed,
+};
+use crate::{
+    alloc::KBox,
+    bindings,
+    drm::device::Device,
+    error::{from_result, to_result},
+    prelude::*,
+    types::{NotThreadSafe, Opaque},
+};
+use core::{
+    cell::{Cell, UnsafeCell},
+    marker::*,
+    mem::{self, ManuallyDrop},
+    ops::{Deref, DerefMut},
+    ptr::{null, null_mut, NonNull},
+};
+use macros::vtable;
+
+/// The main trait for implementing the [`struct drm_crtc`] API for [`Crtc`].
+///
+/// Any KMS driver should have at least one implementation of this type, which allows them to create
+/// [`Crtc`] objects. Additionally, a driver may store driver-private data within the type that
+/// implements [`DriverCrtc`] - and it will be made available when using a fully typed [`Crtc`]
+/// object.
+///
+/// # Invariants
+///
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_crtc`] pointers are contained within a [`Crtc<Self>`].
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_crtc_state`] pointers are contained within a [`CrtcState<Self::State>`].
+///
+/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
+/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
+#[vtable]
+pub trait DriverCrtc: Send + Sync + Sized {
+    /// The generated C vtable for this [`DriverCrtc`] implementation.
+    const OPS: &'static DriverCrtcOps = &DriverCrtcOps {
+        funcs: bindings::drm_crtc_funcs {
+            atomic_destroy_state: Some(atomic_destroy_state_callback::<Self::State>),
+            atomic_duplicate_state: Some(atomic_duplicate_state_callback::<Self::State>),
+            atomic_get_property: None,
+            atomic_print_state: None,
+            atomic_set_property: None,
+            cursor_move: None,
+            cursor_set2: None,
+            cursor_set: None,
+            destroy: Some(crtc_destroy_callback::<Self>),
+            disable_vblank: <Self::VblankImpl as VblankImpl>::VBLANK_OPS.disable_vblank,
+            early_unregister: None,
+            enable_vblank: <Self::VblankImpl as VblankImpl>::VBLANK_OPS.enable_vblank,
+            gamma_set: None,
+            get_crc_sources: None,
+            get_vblank_counter: None,
+            get_vblank_timestamp: <Self::VblankImpl as VblankImpl>::VBLANK_OPS.get_vblank_timestamp,
+            late_register: None,
+            page_flip: Some(bindings::drm_atomic_helper_page_flip),
+            page_flip_target: None,
+            reset: Some(crtc_reset_callback::<Self::State>),
+            set_config: Some(bindings::drm_atomic_helper_set_config),
+            set_crc_source: None,
+            set_property: None,
+            verify_crc_source: None,
+        },
+
+        helper_funcs: bindings::drm_crtc_helper_funcs {
+            atomic_disable: if Self::HAS_ATOMIC_DISABLE {
+                Some(atomic_disable_callback::<Self>)
+            } else {
+                None
+            },
+            atomic_enable: if Self::HAS_ATOMIC_ENABLE {
+                Some(atomic_enable_callback::<Self>)
+            } else {
+                None
+            },
+            atomic_check: if Self::HAS_ATOMIC_CHECK {
+                Some(atomic_check_callback::<Self>)
+            } else {
+                None
+            },
+            dpms: None,
+            commit: None,
+            prepare: None,
+            disable: None,
+            mode_set: None,
+            mode_valid: None,
+            mode_fixup: None,
+            atomic_begin: if Self::HAS_ATOMIC_BEGIN {
+                Some(atomic_begin_callback::<Self>)
+            } else {
+                None
+            },
+            atomic_flush: if Self::HAS_ATOMIC_FLUSH {
+                Some(atomic_flush_callback::<Self>)
+            } else {
+                None
+            },
+            mode_set_nofb: None,
+            mode_set_base: None,
+            mode_set_base_atomic: None,
+            get_scanout_position: None,
+        },
+    };
+
+    /// The type to pass to the `args` field of [`UnregisteredCrtc::new`].
+    ///
+    /// This type will be made available in in the `args` argument of [`Self::new`]. Drivers which
+    /// don't need this can simply pass [`()`] here.
+    type Args;
+
+    /// The parent [`KmsDriver`] implementation.
+    type Driver: KmsDriver;
+
+    /// The [`DriverCrtcState`] implementation for this [`DriverCrtc`].
+    ///
+    /// See [`DriverCrtcState`] for more info.
+    type State: DriverCrtcState;
+
+    /// The driver's optional hardware vblank implementation
+    ///
+    /// See [`VblankSupport`] for more info. Drivers that don't care about this can just pass
+    /// [`PhantomData<Self>`].
+    type VblankImpl: VblankImpl<Crtc = Self>;
+
+    /// The constructor for creating a [`Crtc`] using this [`DriverCrtc`] implementation.
+    ///
+    /// Drivers may use this to instantiate their [`DriverCrtc`] object.
+    fn new(device: &Device<Self::Driver>, args: &Self::Args) -> impl PinInit<Self, Error>;
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_check`] hook for this crtc.
+    ///
+    /// Drivers may use this to customize the atomic check phase of their [`Crtc`] objects. The
+    /// result of this function determines whether the atomic check passed or failed.
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_check`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_check(_check: CrtcAtomicCheck<'_, Self>) -> Result {
+        build_error::build_error("This should not be reachable")
+    }
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_begin`] hook.
+    ///
+    /// This hook will be called before a set of [`Plane`] updates are performed for the given
+    /// [`Crtc`].
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_begin`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_begin(_commit: CrtcAtomicCommit<'_, Self>) {
+        build_error::build_error("This should not be reachable")
+    }
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_flush`] hook.
+    ///
+    /// This hook will be called after a set of [`Plane`] updates are performed for the given
+    /// [`Crtc`].
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_flush`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_flush(_commit: CrtcAtomicCommit<'_, Self>) {
+        build_error::build_error("This should never be reachable")
+    }
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_enable`] hook.
+    ///
+    /// This hook will be called before enabling a [`Crtc`] in an atomic commit.
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_enable`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_enable(_commit: CrtcAtomicCommit<'_, Self>) {
+        build_error::build_error("This should never be reachable")
+    }
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_disable`] hook.
+    ///
+    /// This hook will be called before disabling a [`Crtc`] in an atomic commit.
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_disable`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_disable(_commit: CrtcAtomicCommit<'_, Self>) {
+        build_error::build_error("This should never be reachable")
+    }
+}
+
+/// The generated C vtable for a [`DriverCrtc`].
+///
+/// This type is created internally by DRM.
+pub struct DriverCrtcOps {
+    funcs: bindings::drm_crtc_funcs,
+    helper_funcs: bindings::drm_crtc_helper_funcs,
+}
+
+/// The main interface for a [`struct drm_crtc`].
+///
+/// This type is the main interface for dealing with DRM CRTCs. In addition, it also allows
+/// immutable access to whatever private data is contained within an implementor's [`DriverCrtc`]
+/// type.
+///
+/// # Invariants
+///
+/// - `crtc` and `inner` are initialized for as long as this object is made available to users.
+/// - The data layout of this structure begins with [`struct drm_crtc`].
+/// - The atomic state for this type can always be assumed to be of type [`CrtcState<T::State>`].
+///
+/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
+#[repr(C)]
+#[pin_data]
+pub struct Crtc<T: DriverCrtc> {
+    // The FFI drm_crtc object
+    crtc: Opaque<bindings::drm_crtc>,
+    /// The driver's private inner data
+    #[pin]
+    inner: T,
+    #[pin]
+    _p: PhantomPinned,
+}
+
+impl<T: DriverCrtc> Sealed for Crtc<T> {}
+
+// SAFETY: Our CRTC interfaces are guaranteed to be thread-safe
+unsafe impl<T: DriverCrtc> Send for Crtc<T> {}
+
+// SAFETY: Our CRTC interfaces are guaranteed to be thread-safe
+unsafe impl<T: DriverCrtc> Sync for Crtc<T> {}
+
+impl<T: DriverCrtc> Deref for Crtc<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+// SAFETY: We don't expose Crtc<T> to users before `base` is initialized in ::new(), so
+// `raw_mode_obj` always returns a valid pointer to a bindings::drm_mode_object.
+unsafe impl<T: DriverCrtc> ModeObject for Crtc<T> {
+    type Driver = T::Driver;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: DRM connectors exist for as long as the device does, so this pointer is always
+        // valid
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose Crtc<T> to users before it's initialized, so `base` is always
+        // initialized
+        unsafe { &raw mut (*self.as_raw()).base }
+    }
+}
+
+// SAFETY: CRTCs are non-refcounted modesetting objects
+unsafe impl<T: DriverCrtc> StaticModeObject for Crtc<T> {}
+
+// SAFETY: `funcs` is initialized when the crtc is allocated
+unsafe impl<T: DriverCrtc> ModeObjectVtable for Crtc<T> {
+    type Vtable = bindings::drm_crtc_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid pointer to a CRTC
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+impl<T: DriverCrtc> Crtc<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D>(&'a OpaqueCrtc<D>) -> &'a Self;
+        use
+            T as DriverCrtc,
+            D as KmsDriver<Crtc = ...>
+    }
+
+    pub(crate) fn get_vblank_ptr(&self) -> *mut bindings::drm_vblank_crtc {
+        // SAFETY: FFI Call with no special requirements
+        unsafe { bindings::drm_crtc_vblank_crtc(self.as_raw()) }
+    }
+
+    pub(crate) const fn has_vblank() -> bool {
+        T::OPS.funcs.enable_vblank.is_some()
+    }
+}
+
+/// A [`Crtc`] that has not yet been registered with userspace.
+///
+/// KMS registration is single-threaded, so this object is not thread-safe.
+///
+/// # Invariants
+///
+/// - This object can only exist before its respective KMS device has been registered.
+/// - Otherwise, it inherits all invariants of [`Crtc`] and has an identical data layout.
+pub struct UnregisteredCrtc<T: DriverCrtc>(Crtc<T>, NotThreadSafe);
+
+impl<T: DriverCrtc> UnregisteredCrtc<T> {
+    /// Construct a new [`UnregisteredCrtc`].
+    ///
+    /// A driver may use this from their [`KmsDriver::create_objects`] callback in order to
+    /// construct new [`UnregisteredCrtc`] objects.
+    ///
+    /// [`KmsDriver::create_objects`]: kernel::drm::kms::KmsDriver::create_objects
+    pub fn new<'a, 'b: 'a, PrimaryData, CursorData>(
+        dev: &'a NewKmsDevice<'a, T::Driver, Probing>,
+        primary: &'a UnregisteredPlane<PrimaryData>,
+        cursor: Option<&'a UnregisteredPlane<CursorData>>,
+        name: Option<&CStr>,
+        args: T::Args,
+    ) -> Result<&'a Self>
+    where
+        PrimaryData: DriverPlane<Driver = T::Driver>,
+        CursorData: DriverPlane<Driver = T::Driver>,
+    {
+        if Crtc::<T>::has_vblank() {
+            dev.has_vblanks.set(true)
+        }
+
+        let this: Pin<KBox<Crtc<T>>> = KBox::try_pin_init(
+            try_pin_init!(Crtc {
+                crtc: Opaque::new(bindings::drm_crtc {
+                    helper_private: &T::OPS.helper_funcs,
+                    ..Default::default()
+                }),
+                inner <- T::new(dev, &args),
+                _p: PhantomPinned,
+            }),
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY:
+        // - `dev` handles destroying the CRTC and thus will outlive us.
+        // - We just allocated `this`, and we won't move it since it's pinned
+        // - `primary` and `cursor` share the lifetime 'a with `dev`
+        // - This function will memcpy the contents of `name` into its own storage.
+        to_result(unsafe {
+            bindings::drm_crtc_init_with_planes(
+                dev.as_raw(),
+                this.as_raw(),
+                primary.as_raw(),
+                cursor.map_or(null_mut(), |c| c.as_raw()),
+                &T::OPS.funcs,
+                name.map_or(null(), |n| n.as_char_ptr()),
+            )
+        })?;
+
+        // SAFETY: We don't move anything
+        let this = unsafe { Pin::into_inner_unchecked(this) };
+
+        // We'll re-assemble the box in crtc_destroy_callback()
+        let this = KBox::into_raw(this);
+
+        // UnregisteredCrtc has an equivalent data layout
+        let this: *mut Self = this.cast();
+
+        // SAFETY: We just allocated the crtc above, so this pointer must be valid
+        Ok(unsafe { &*this })
+    }
+}
+
+// SAFETY: We inherit all relevant invariants of `Crtc`
+unsafe impl<T: DriverCrtc> AsRawCrtc for UnregisteredCrtc<T> {
+    fn as_raw(&self) -> *mut bindings::drm_crtc {
+        self.0.as_raw()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) -> &'a Self {
+        // SAFETY: This is another from_raw() call, so this function shares the same safety contract
+        let crtc = unsafe { Crtc::<T>::from_raw(ptr) };
+
+        // SAFETY: Our data layout is identical via our type invariants.
+        unsafe { mem::transmute(crtc) }
+    }
+}
+
+impl<T: DriverCrtc> Deref for UnregisteredCrtc<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0.inner
+    }
+}
+
+/// A trait implemented by any type that acts as a [`struct drm_crtc`] interface.
+///
+/// This is implemented internally by DRM.
+///
+/// # Safety
+///
+/// [`as_raw()`] must always return a valid pointer to a [`struct drm_crtc`].
+///
+/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
+/// [`as_raw()`]: AsRawCrtc::as_raw()
+pub unsafe trait AsRawCrtc {
+    /// Return a raw pointer to the `bindings::drm_crtc` for this object
+    fn as_raw(&self) -> *mut bindings::drm_crtc;
+
+    /// Convert a raw [`struct drm_crtc`] pointer into an object of this type.
+    ///
+    /// # Safety
+    ///
+    /// Callers promise that `ptr` points to a valid instance of this type
+    ///
+    /// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) -> &'a Self;
+}
+
+// SAFETY:
+// - Via our type variants our data layout starts with `drm_crtc`
+// - Since we don't expose `crtc` to users before it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_crtc`.
+unsafe impl<T: DriverCrtc> AsRawCrtc for Crtc<T> {
+    fn as_raw(&self) -> *mut bindings::drm_crtc {
+        self.crtc.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) -> &'a Self {
+        // Our data layout start with `bindings::drm_crtc`.
+        let ptr: *mut Self = ptr.cast();
+
+        // SAFETY: Our safety contract requires that `ptr` point to a valid intance of `Self`.
+        unsafe { &*ptr }
+    }
+}
+
+// SAFETY: We only expose this object to users directly after KmsDriver::create_objects has been
+// called.
+unsafe impl<T: DriverCrtc> ModesettableCrtc for Crtc<T> {
+    type State = CrtcState<T::State>;
+}
+
+/// A supertrait of [`AsRawCrtc`] for [`struct drm_crtc`] interfaces that can perform modesets.
+///
+/// This is implemented internally by DRM.
+///
+/// # Safety
+///
+/// Any object implementing this trait must only be made directly available to the user after
+/// [`create_objects`] has completed.
+///
+/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
+/// [`create_objects`]: KmsDriver::create_objects
+pub unsafe trait ModesettableCrtc: AsRawCrtc {
+    /// The type that should be returned for a CRTC state acquired using this CRTC interface
+    type State: FromRawCrtcState;
+}
+
+/// Common methods available on any type which implements [`AsRawCrtc`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// CRTCs.
+pub trait RawCrtc: AsRawCrtc {
+    /// Return the index of this CRTC.
+    fn index(&self) -> u32 {
+        // SAFETY: The index is initialized by the time we expose Crtc objects to users, and is
+        // invariant throughout the lifetime of the Crtc
+        unsafe { (*self.as_raw()).index }
+    }
+
+    /// Return the index of this DRM CRTC in the form of a bitmask.
+    fn mask(&self) -> u32 {
+        1 << self.index()
+    }
+}
+impl<T: AsRawCrtc> RawCrtc for T {}
+
+/// A [`struct drm_crtc`] without a known [`DriverCrtc`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverCrtc`] implementation
+/// for a [`struct drm_crtc`] automatically. It is identical to [`Crtc`], except that it does not
+/// provide access to the driver's private data.
+///
+/// It may be upcasted to a full [`Crtc`] using [`Crtc::from_opaque`] or
+/// [`Crtc::try_from_opaque`].
+///
+/// # Invariants
+///
+/// - `crtc` is initialized for as long as this object is made available to users.
+/// - The data layout of this structure is equivalent to [`struct drm_crtc`].
+///
+/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
+#[repr(transparent)]
+pub struct OpaqueCrtc<T: KmsDriver> {
+    crtc: Opaque<bindings::drm_crtc>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> Sealed for OpaqueCrtc<T> {}
+
+// SAFETY:
+// - Via our type variants our data layout is identical to `drm_crtc`
+// - Since we don't expose `OpaqueCrtc` to users before it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_crtc`.
+unsafe impl<T: KmsDriver> AsRawCrtc for OpaqueCrtc<T> {
+    fn as_raw(&self) -> *mut bindings::drm_crtc {
+        self.crtc.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) -> &'a Self {
+        // SAFETY: Our data layout starts with `bindings::drm_crtc`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: We only expose this object to users directly after KmsDriver::create_objects has been
+// called.
+unsafe impl<T: KmsDriver> ModesettableCrtc for OpaqueCrtc<T> {
+    type State = OpaqueCrtcState<T>;
+}
+
+// SAFETY: We don't expose OpaqueCrtc<T> to users before `base` is initialized in Crtc::<T>::new(),
+// so `raw_mode_obj` always returns a valid pointer to a bindings::drm_mode_object.
+unsafe impl<T: KmsDriver> ModeObject for OpaqueCrtc<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: The parent device for a DRM connector will never outlive the connector, and this
+        // pointer is invariant through the lifetime of the connector
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose DRM connectors to users before `base` is initialized
+        unsafe { &raw mut (*self.as_raw()).base }
+    }
+}
+
+// SAFETY: CRTCs are non-refcounted modesetting objects
+unsafe impl<T: KmsDriver> StaticModeObject for OpaqueCrtc<T> {}
+
+// SAFETY: Our CRTC interface is guaranteed to be thread-safe
+unsafe impl<T: KmsDriver> Send for OpaqueCrtc<T> {}
+
+// SAFETY: Our CRTC interface is guaranteed to be thread-safe
+unsafe impl<T: KmsDriver> Sync for OpaqueCrtc<T> {}
+
+// SAFETY: `funcs` is initialized when the CRTC is allocated
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueCrtc<T> {
+    type Vtable = bindings::drm_crtc_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid pointer to a crtc
+        unsafe { (*self.as_raw()).funcs }
+    }
+}
+
+impl<T: DriverCrtcState> Sealed for CrtcState<T> {}
+
+/// The main trait for implementing the [`struct drm_crtc_state`] API for a [`Crtc`].
+///
+/// A driver may store driver-private data within the implementor's type, which will be available
+/// when using a full typed [`CrtcState`] object.
+///
+/// # Invariants
+///
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_crtc`] pointers are contained within a [`Crtc<Self::Crtc>`].
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_crtc_state`] pointers are contained within a [`CrtcState<Self>`].
+///
+/// [`struct drm_crtc`]: srctree/include/drm_crtc.h
+/// [`struct drm_crtc_state`]: srctree/include/drm_crtc.h
+pub trait DriverCrtcState: Clone + Default + Unpin {
+    /// The parent CRTC driver for this CRTC state
+    type Crtc: DriverCrtc<State = Self>
+    where
+        Self: Sized;
+}
+
+/// The main interface for a [`struct drm_crtc_state`].
+///
+/// This type is the main interface for dealing with the atomic state of DRM crtcs. In addition, it
+/// allows access to whatever private data is contained within an implementor's [`DriverCrtcState`]
+/// type.
+///
+/// # Invariants
+///
+/// - `state` and `inner` initialized for as long as this object is exposed to users.
+/// - The data layout of this structure begins with [`struct drm_crtc_state`].
+/// - The CRTC for this type can always be assumed to be of type [`Crtc<T::Crtc>`].
+///
+/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
+#[repr(C)]
+pub struct CrtcState<T: DriverCrtcState> {
+    // It should be noted that CrtcState is a bit of an oddball - it's the only atomic state
+    // structure that can be modified after it has been swapped in, which is why we need to have
+    // `state` within an `Opaque<>`…
+    state: Opaque<bindings::drm_crtc_state>,
+
+    // …it is also one of the few atomic states that some drivers will embed work structures into,
+    // which means there's a good chance in the future we may have pinned data here - making it
+    // impossible for us to hold a mutable or immutable reference to the CrtcState. In preparation
+    // for that possibility, we keep `T` in an UnsafeCell.
+    inner: UnsafeCell<T>,
+}
+
+impl<T: DriverCrtcState> Deref for CrtcState<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Our interface ensures that `inner` will not be modified unless only a single
+        // mutable reference exists to `inner`, so this is safe
+        unsafe { &*self.inner.get() }
+    }
+}
+
+impl<T: DriverCrtcState> DerefMut for CrtcState<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        self.inner.get_mut()
+    }
+}
+
+// SAFETY: Shares the safety guarantee of Crtc<T>'s ModeObjectVtable impl
+unsafe impl<T: DriverCrtcState> ModeObjectVtable for CrtcState<T> {
+    type Vtable = bindings::drm_crtc_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.crtc().vtable()
+    }
+}
+
+impl<T: DriverCrtcState> CrtcState<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D, C>(&'a OpaqueCrtcState<D>) -> &'a Self
+        where
+            T: DriverCrtcState<Crtc = C>;
+        use
+            C as DriverCrtc,
+            D as KmsDriver<Crtc = ...>
+    }
+}
+
+/// A trait implemented by any type which can produce a reference to a [`struct drm_crtc_state`].
+///
+/// This is implemented internally by DRM.
+///
+/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
+pub trait AsRawCrtcState: private::AsRawCrtcState {
+    /// The type that this CRTC state interface returns to represent the parent CRTC
+    type Crtc: ModesettableCrtc;
+}
+
+pub(crate) mod private {
+    use super::*;
+
+    #[allow(unreachable_pub)]
+    pub trait AsRawCrtcState {
+        /// Return a raw pointer to the DRM CRTC state
+        ///
+        /// Note that CRTC states are the only atomic state in KMS which don't nicely follow rust's
+        /// data aliasing rules already.
+        fn as_raw(&self) -> *mut bindings::drm_crtc_state;
+    }
+}
+
+pub(super) use private::AsRawCrtcState as AsRawCrtcStatePrivate;
+
+/// Common methods available on any type which implements [`AsRawCrtcState`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// the atomic state of [`Crtc`]s.
+pub trait RawCrtcState: AsRawCrtcState {
+    /// Return the CRTC that owns this state.
+    fn crtc(&self) -> &Self::Crtc {
+        // SAFETY:
+        // - This type conversion is guaranteed by type invariance
+        // - Our interface ensures that this access follows rust's data-aliasing rules
+        // - `crtc` is guaranteed to never be NULL and is invariant throughout the lifetime of the
+        //   state
+        unsafe { <Self::Crtc as AsRawCrtc>::from_raw((*self.as_raw()).crtc) }
+    }
+
+    /// Returns whether or not the CRTC is active in this atomic state.
+    fn active(&self) -> bool {
+        // SAFETY: `active` and the rest of its containing bitfield can only be modified from the
+        // atomic check context, and are invariant beyond that point - so our interface can ensure
+        // this access is serialized
+        unsafe { (*self.as_raw()).active }
+    }
+}
+impl<T: AsRawCrtcState> RawCrtcState for T {}
+
+/// A trait implemented for any type which can be constructed directly from a
+/// [`struct drm_crtc_state`] pointer.
+///
+/// This is implemented internally by DRM.
+///
+/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
+pub trait FromRawCrtcState: AsRawCrtcState {
+    /// Obtain a reference back to this type from a raw DRM crtc state pointer
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that ptr contains a valid instance of this type.
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc_state) -> &'a Self;
+}
+
+impl<T: DriverCrtcState> private::AsRawCrtcState for CrtcState<T> {
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::drm_crtc_state {
+        self.state.get()
+    }
+}
+
+impl<T: DriverCrtcState> AsRawCrtcState for CrtcState<T> {
+    type Crtc = Crtc<T::Crtc>;
+}
+
+impl<T: DriverCrtcState> FromRawCrtcState for CrtcState<T> {
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc_state) -> &'a Self {
+        // SAFETY: Our data layout starts with `bindings::drm_crtc_state`
+        unsafe { &*(ptr.cast()) }
+    }
+}
+
+/// A [`struct drm_crtc_state`] without a known [`DriverCrtcState`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverCrtcState`]
+/// implementation for a [`struct drm_crtc_state`] automatically. It is identical to [`Crtc`],
+/// except that it does not provide access to the driver's private data.
+///
+/// # Invariants
+///
+/// - `state` is initialized for as long as this object is exposed to users.
+/// - The data layout of this type is identical to [`struct drm_crtc_state`].
+///
+/// [`struct drm_crtc_state`]: srctree/include/drm/drm_crtc.h
+#[repr(transparent)]
+pub struct OpaqueCrtcState<T: KmsDriver> {
+    state: Opaque<bindings::drm_crtc_state>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> AsRawCrtcState for OpaqueCrtcState<T> {
+    type Crtc = OpaqueCrtc<T>;
+}
+
+impl<T: KmsDriver> private::AsRawCrtcState for OpaqueCrtcState<T> {
+    fn as_raw(&self) -> *mut bindings::drm_crtc_state {
+        self.state.get()
+    }
+}
+
+impl<T: KmsDriver> FromRawCrtcState for OpaqueCrtcState<T> {
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc_state) -> &'a Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_crtc_state`
+        unsafe { &*(ptr.cast()) }
+    }
+}
+
+// SAFETY: Shares the safety guarantees of OpaqueCrtc<T>'s ModeObjectVtable impl
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueCrtcState<T> {
+    type Vtable = bindings::drm_crtc_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.crtc().vtable()
+    }
+}
+
+/// An interface for mutating a [`Crtc`]s atomic state.
+///
+/// This type is typically returned by an [`AtomicStateMutator`] within contexts where it is
+/// possible to safely mutate a plane's state. In order to uphold rust's data-aliasing rules, only
+/// [`CrtcStateMutator`] may exist at a time.
+///
+/// # Invariants
+///
+/// `self.state` always points to a valid instance of a [`FromRawCrtcState`] object.
+pub struct CrtcStateMutator<'a, T: FromRawCrtcState> {
+    state: NonNull<T>,
+    mask: &'a Cell<u32>,
+}
+
+impl<'a, T: FromRawCrtcState> CrtcStateMutator<'a, T> {
+    pub(super) fn new<D: KmsDriver>(
+        mutator: &'a AtomicStateMutator<D>,
+        state: NonNull<bindings::drm_crtc_state>,
+    ) -> Option<Self> {
+        // SAFETY: `crtc` is invariant throughout the lifetime of the atomic state, and always
+        // points to a valid `Crtc<T::Crtc>`
+        let crtc = unsafe { T::Crtc::from_raw((*state.as_ptr()).crtc) };
+        let crtc_mask = crtc.mask();
+        let borrowed_mask = mutator.borrowed_crtcs.get();
+
+        if borrowed_mask & crtc_mask == 0 {
+            mutator.borrowed_crtcs.set(borrowed_mask | crtc_mask);
+            Some(Self {
+                mask: &mutator.borrowed_crtcs,
+                state: state.cast(),
+            })
+        } else {
+            None
+        }
+    }
+}
+
+impl<'a, T: DriverCrtcState> CrtcStateMutator<'a, CrtcState<T>> {
+    super::impl_from_opaque_mode_obj! {
+        fn <D, C>(CrtcStateMutator<'a, OpaqueCrtcState<D>>) -> Self
+        where
+            T: DriverCrtcState<Crtc = C>;
+        use
+            T as DriverCrtc,
+            D as KmsDriver<Crtc = ...>
+    }
+}
+
+impl<'a, T: FromRawCrtcState> Drop for CrtcStateMutator<'a, T> {
+    fn drop(&mut self) {
+        // SAFETY: Our interface is proof that we are the only ones with a reference to this data
+        let mask = unsafe { self.state.as_ref() }.crtc().mask();
+        self.mask.set(self.mask.get() & !mask);
+    }
+}
+
+impl<'a, T: DriverCrtcState> Deref for CrtcStateMutator<'a, CrtcState<T>> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Our interface ensures that `self.state.inner` follows rust's data-aliasing rules,
+        // so this is safe
+        unsafe { &*(*self.state.as_ptr()).inner.get() }
+    }
+}
+
+impl<'a, T: DriverCrtcState> DerefMut for CrtcStateMutator<'a, CrtcState<T>> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: Our interface ensures that `self.state.inner` follows rust's data-aliasing rules,
+        // so this is safe
+        unsafe { (*self.state.as_ptr()).inner.get_mut() }
+    }
+}
+
+impl<'a, T: FromRawCrtcState> AsRawCrtcState for CrtcStateMutator<'a, T> {
+    type Crtc = T::Crtc;
+}
+
+impl<'a, T: FromRawCrtcState> private::AsRawCrtcState for CrtcStateMutator<'a, T> {
+    fn as_raw(&self) -> *mut bindings::drm_crtc_state {
+        self.state.as_ptr().cast()
+    }
+}
+
+// SAFETY: Shares the safety guarantees of T::Crtc's ModeObjectVtable impl
+unsafe impl<'a, T: FromRawCrtcState> ModeObjectVtable for CrtcStateMutator<'a, T>
+where
+    T::Crtc: ModeObjectVtable,
+{
+    type Vtable = <T::Crtc as ModeObjectVtable>::Vtable;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.crtc().vtable()
+    }
+}
+
+/// A token provided during [`atomic_check`] callbacks for accessing the crtc, atomic state, and new
+/// and old states of the crtc.
+///
+/// # Invariants
+///
+/// This token is proof that the old and new atomic state of `crtc` are present in `state` and do
+/// not have any mutators taken out.
+///
+/// [`atomic_check`]: DriverCrtc::atomic_check
+pub struct CrtcAtomicCheck<'a, T: DriverCrtc> {
+    state: &'a AtomicStateComposer<T::Driver>,
+    crtc: &'a Crtc<T>,
+}
+
+impl<'a, T: DriverCrtc> CrtcAtomicCheck<'a, T> {
+    impl_atomic_state_token_ops!(
+        CrtcAtomicCheck,
+        AtomicStateComposer,
+        Crtc,
+        use <'a, T>
+    );
+}
+
+/// A token provided to [`DriverCrtc`] callbacks during the atomic commit phase for accessing the
+/// crtc, atomic state, new and old states of the crtc.
+///
+/// # Invariants
+///
+/// This token is proof that the old and new atomic state of `crtc` are present in `state` and do
+/// not have any mutators taken out.
+pub struct CrtcAtomicCommit<'a, T: DriverCrtc> {
+    state: &'a AtomicStateMutator<T::Driver>,
+    crtc: &'a Crtc<T>,
+}
+
+impl<'a, T: DriverCrtc> CrtcAtomicCommit<'a, T> {
+    impl_atomic_state_token_ops!(
+        CrtcAtomicCommit,
+        AtomicStateMutator,
+        Crtc,
+        use <'a, T>
+    );
+}
+
+unsafe extern "C" fn crtc_destroy_callback<T: DriverCrtc>(crtc: *mut bindings::drm_crtc) {
+    // SAFETY: DRM guarantees that `crtc` points to a valid initialized `drm_crtc`.
+    unsafe { bindings::drm_crtc_cleanup(crtc) };
+
+    // SAFETY:
+    // - DRM guarantees we are now the only one with access to this [`drm_crtc`].
+    // - This cast is safe via `DriverCrtc`s type invariants.
+    // - We created this as a pinned type originally
+    drop(unsafe { Pin::new_unchecked(KBox::from_raw(crtc as *mut Crtc<T>)) });
+}
+
+unsafe extern "C" fn atomic_duplicate_state_callback<T: DriverCrtcState>(
+    crtc: *mut bindings::drm_crtc,
+) -> *mut bindings::drm_crtc_state {
+    // SAFETY: DRM guarantees that `crtc` points to a valid initialized `drm_crtc`.
+    let state = unsafe { (*crtc).state };
+    if state.is_null() {
+        return null_mut();
+    }
+
+    // SAFETY: This cast is safe via `DriverCrtcState`s type invariants.
+    let crtc = unsafe { Crtc::<T::Crtc>::from_raw(crtc) };
+
+    // SAFETY: This cast is safe via `DriverCrtcState`s type invariants.
+    let state = unsafe { CrtcState::<T>::from_raw(state) };
+
+    let new: Result<KBox<_>> = KBox::try_init(
+        try_init!(CrtcState {
+            inner: UnsafeCell::new((*state).clone()),
+            state: Opaque::new(Default::default()),
+        }),
+        GFP_KERNEL,
+    );
+
+    if let Ok(new) = new {
+        let new = KBox::into_raw(new).cast();
+
+        // SAFETY:
+        // - `new` provides a valid pointer to a newly allocated `drm_crtc_state` via type
+        // invariants
+        // - This initializes `new` via memcpy()
+        unsafe { bindings::__drm_atomic_helper_crtc_duplicate_state(crtc.as_raw(), new) }
+
+        new
+    } else {
+        null_mut()
+    }
+}
+
+unsafe extern "C" fn atomic_destroy_state_callback<T: DriverCrtcState>(
+    _crtc: *mut bindings::drm_crtc,
+    crtc_state: *mut bindings::drm_crtc_state,
+) {
+    // SAFETY: DRM guarantees that `state` points to a valid instance of `drm_crtc_state`
+    unsafe { bindings::__drm_atomic_helper_crtc_destroy_state(crtc_state) };
+
+    // SAFETY:
+    // - DRM guarantees we are the only one with access to this `drm_crtc_state`
+    // - This cast is safe via our type invariants.
+    // - All data in `CrtcState` is either Unpin, or pinned
+    drop(unsafe { KBox::from_raw(crtc_state as *mut CrtcState<T>) });
+}
+
+unsafe extern "C" fn crtc_reset_callback<T: DriverCrtcState>(crtc: *mut bindings::drm_crtc) {
+    // SAFETY: DRM guarantees that `state` points to a valid instance of `drm_crtc_state`
+    let state = unsafe { (*crtc).state };
+    if !state.is_null() {
+        // SAFETY:
+        // - We're guaranteed `crtc` is `Crtc<T>` via type invariants
+        // - We're guaranteed `state` is `CrtcState<T>` via type invariants.
+        unsafe { atomic_destroy_state_callback::<T>(crtc, state) }
+
+        // SAFETY: No special requirements here, DRM expects this to be NULL
+        unsafe {
+            (*crtc).state = null_mut();
+        }
+    }
+
+    // SAFETY: `crtc` is guaranteed to be of type `Crtc<T::Crtc>` by type invariance
+    let crtc = unsafe { Crtc::<T::Crtc>::from_raw(crtc) };
+
+    // Unfortunately, this is the best we can do at the moment as this FFI callback was mistakenly
+    // presumed to be infallible :(
+    let new: KBox<CrtcState<T>> = KBox::try_init(
+        try_init!(CrtcState {
+            state: Opaque::new(Default::default()),
+            inner: UnsafeCell::new(Default::default()),
+        }),
+        GFP_KERNEL,
+    )
+    .expect("Unfortunately, this API was presumed infallible");
+
+    // SAFETY: DRM takes ownership of the state from here, and will never move it
+    unsafe { bindings::__drm_atomic_helper_crtc_reset(crtc.as_raw(), KBox::into_raw(new).cast()) };
+}
+
+unsafe extern "C" fn atomic_check_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) -> i32 {
+    // SAFETY:
+    // - We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
+    // - We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_state`
+    // We use a ManuallyDrop here to avoid AtomicStateComposer dropping an owned reference we never
+    // acquired.
+    let state =
+        unsafe { ManuallyDrop::new(AtomicStateComposer::new(NonNull::new_unchecked(state))) };
+
+    // SAFETY:
+    // - Since we're in the atomic check callback, we're guaranteed by DRM that both the old and
+    //   new crtc state are present in this atomic state
+    // - We just created the state composer above, so other composers cannot be taken out on the
+    //   crtc state yet.
+    let check = unsafe { CrtcAtomicCheck::new(crtc, &state) };
+
+    from_result(|| {
+        T::atomic_check(check)?;
+        Ok(0)
+    })
+}
+
+unsafe extern "C" fn atomic_begin_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // * We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
+    // * We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_state`
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY:
+    // - Since we're in the atomic_begin callback, we're guaranteed by DRM that both the old and new
+    //   crtc state are resent in this atomic state.
+    // - We just created the state mutator above, so other mutators cannot be taken out on the crtc
+    //   state yet.
+    let commit = unsafe { CrtcAtomicCommit::new(crtc, &state) };
+
+    T::atomic_begin(commit);
+}
+
+unsafe extern "C" fn atomic_flush_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // - We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
+    // - We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_state`
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY:
+    // - Since we're in the atomic_flush callback, we're guaranteed by DRM that both the old and new
+    //   crtc state are resent in this atomic state.
+    // - We just created the state mutator above, so other mutators cannot be taken out on the crtc
+    //   state yet.
+    let commit = unsafe { CrtcAtomicCommit::new(crtc, &state) };
+
+    T::atomic_flush(commit);
+}
+
+unsafe extern "C" fn atomic_enable_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // - We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
+    // - We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: DRM never passes an invalid ptr for `state`
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY:
+    // - Since we're in the atomic_enable callback, we're guaranteed by DRM that both the old and
+    //   new crtc state are present in this atomic state.
+    // - We just created the state mutator above, so other mutators cannot be taken out on the crtc
+    //   state yet.
+    let commit = unsafe { CrtcAtomicCommit::new(crtc, &state) };
+
+    T::atomic_enable(commit);
+}
+
+unsafe extern "C" fn atomic_disable_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // - We're guaranteed `crtc` points to a valid instance of `drm_crtc`
+    // - We're guaranteed that `crtc` is of type `Plane<T>` by `DriverPlane`s type invariants.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: We're guaranteed that `state` points to a valid `drm_crtc_state` by DRM
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY:
+    // - Since we're in the atomic_disable callback, we're guaranteed by DRM that both the old and
+    //   new crtc state are present in this atomic state.
+    // - We just created the state mutator above, so other mutators cannot be taken out on the crtc
+    //   state yet.
+    let commit = unsafe { CrtcAtomicCommit::new(crtc, &state) };
+
+    T::atomic_disable(commit);
+}
diff --git a/rust/kernel/drm/kms/encoder.rs b/rust/kernel/drm/kms/encoder.rs
new file mode 100644
index 000000000000..5f860faf8b61
--- /dev/null
+++ b/rust/kernel/drm/kms/encoder.rs
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM encoders.
+//!
+//! C header: [`include/drm/drm_encoder.h`](srctree/include/drm/drm_encoder.h)
+
+use super::{
+    KmsDriver, ModeObject, ModeObjectVtable, NewKmsDevice, Probing, StaticModeObject, Sealed
+};
+use crate::{
+    alloc::KBox,
+    drm::device::Device,
+    error::to_result,
+    prelude::*,
+    types::{NotThreadSafe, Opaque},
+};
+use bindings;
+use core::{
+    marker::*,
+    mem,
+    ops::Deref,
+    ptr::null,
+};
+use macros::paste;
+
+/// A macro for generating our type ID enumerator.
+macro_rules! declare_encoder_types {
+    ($( $oldname:ident as $newname:ident ),+) => {
+        #[repr(i32)]
+        #[non_exhaustive]
+        #[derive(Copy, Clone, PartialEq, Eq)]
+        /// An enumerator for all possible [`Encoder`] type IDs.
+        pub enum Type {
+            // Note: bindgen defaults the macro values to u32 and not i32, but DRM takes them as an
+            // i32 - so just do the conversion here
+            $(
+                #[doc = concat!("The encoder type ID for a ", stringify!($newname), " encoder.")]
+                $newname = paste!(crate::bindings::[<DRM_MODE_ENCODER_ $oldname>]) as i32
+            ),+
+        }
+    };
+}
+
+declare_encoder_types! {
+    NONE     as None,
+    DAC      as Dac,
+    TMDS     as Tmds,
+    LVDS     as Lvds,
+    VIRTUAL  as Virtual,
+    DSI      as Dsi,
+    DPMST    as DpMst,
+    DPI      as Dpi
+}
+
+/// The main trait for implementing the [`struct drm_encoder`] API for [`Encoder`].
+///
+/// Any KMS driver should have at least one implementation of this type, which allows them to create
+/// [`Encoder`] objects. Additionally, a driver may store driver-private data within the type that
+/// implements [`DriverEncoder`] - and it will be made available when using a fully typed
+/// [`Encoder`] object.
+///
+/// # Invariants
+///
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_encoder`] pointers are contained within a [`Encoder<Self>`].
+///
+/// [`struct drm_encoder`]: srctree/include/drm/drm_encoder.h
+#[vtable]
+pub trait DriverEncoder: Send + Sync + Sized {
+    /// The generated C vtable for this [`DriverEncoder`] implementation.
+    const OPS: &'static DriverEncoderOps = &DriverEncoderOps {
+        funcs: bindings::drm_encoder_funcs {
+            reset: None,
+            destroy: Some(encoder_destroy_callback::<Self>),
+            late_register: None,
+            early_unregister: None,
+            debugfs_init: None,
+        },
+        helper_funcs: bindings::drm_encoder_helper_funcs {
+            dpms: None,
+            mode_valid: None,
+            mode_fixup: None,
+            prepare: None,
+            mode_set: None,
+            commit: None,
+            detect: None,
+            enable: None,
+            disable: None,
+            atomic_check: None,
+            atomic_enable: None,
+            atomic_disable: None,
+            atomic_mode_set: None,
+        },
+    };
+
+    /// The parent driver for this drm_encoder implementation
+    type Driver: KmsDriver;
+
+    /// The type to pass to the `args` field of [`UnregisteredEncoder::new`].
+    ///
+    /// This type will be made available in in the `args` argument of [`Self::new`]. Drivers which
+    /// don't need this can simply pass [`()`] here.
+    type Args;
+
+    /// The constructor for creating a [`Encoder`] using this [`DriverEncoder`] implementation.
+    ///
+    /// Drivers may use this to instantiate their [`DriverEncoder`] object.
+    fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+}
+
+/// The generated C vtable for a [`DriverEncoder`].
+///
+/// This type is created internally by DRM.
+pub struct DriverEncoderOps {
+    funcs: bindings::drm_encoder_funcs,
+    helper_funcs: bindings::drm_encoder_helper_funcs,
+}
+
+/// A trait implemented by any type that acts as a [`struct drm_encoder`] interface.
+///
+/// This is implemented internally by DRM.
+///
+/// # Safety
+///
+/// [`as_raw()`] must always return a valid pointer to a [`struct drm_encoder`].
+///
+/// [`struct drm_encoder`]: srctree/include/drm/drm_encoder.h
+/// [`as_raw()`]: AsRawEncoder::as_raw()
+pub unsafe trait AsRawEncoder {
+    /// Return the raw `bindings::drm_encoder` for this DRM encoder.
+    ///
+    /// Drivers should never use this directly
+    fn as_raw(&self) -> *mut bindings::drm_encoder;
+
+    /// Convert a raw `bindings::drm_encoder` pointer into an object of this type.
+    ///
+    /// # Safety
+    ///
+    /// Callers promise that `ptr` points to a valid instance of this type
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encoder) -> &'a Self;
+}
+
+/// The main interface for a [`struct drm_encoder`].
+///
+/// This type is the main interface for dealing with DRM encoders. In addition, it also allows
+/// immutable access to whatever private data is contained within an implementor's
+/// [`DriverEncoder`] type.
+///
+/// # Invariants
+///
+/// - `encoder` and `inner` are initialized for as long as this object is made available to users.
+/// - The data layout of this structure begins with [`struct drm_encoder`].
+///
+/// [`struct drm_encoder`]: srctree/include/drm/drm_encoder.h
+#[repr(C)]
+#[pin_data]
+pub struct Encoder<T: DriverEncoder> {
+    /// The FFI drm_encoder object
+    encoder: Opaque<bindings::drm_encoder>,
+    /// The driver's private inner data
+    #[pin]
+    inner: T,
+    #[pin]
+    _p: PhantomPinned,
+}
+
+impl<T: DriverEncoder> Sealed for Encoder<T> {}
+
+// SAFETY: Our interface is thread-safe.
+unsafe impl<T: DriverEncoder> Send for Encoder<T> {}
+// SAFETY: Our interface is thread-safe.
+unsafe impl<T: DriverEncoder> Sync for Encoder<T> {}
+
+// SAFETY: We don't expose Encoder<T> to users before `base` is initialized in ::new(), so
+// `raw_mode_obj` always returns a valid pointer to a bindings::drm_mode_object.
+unsafe impl<T: DriverEncoder> ModeObject for Encoder<T> {
+    type Driver = T::Driver;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: DRM encoders exist for as long as the device does, so this pointer is always
+        // valid
+        unsafe { Device::from_raw((*self.encoder.get()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose Encoder<T> to users before it's initialized, so `base` is always
+        // initialized
+        unsafe { &raw mut (*self.encoder.get()).base }
+    }
+}
+
+// SAFETY: Encoders do not have a refcount
+unsafe impl<T: DriverEncoder> StaticModeObject for Encoder<T> {}
+
+impl<T: DriverEncoder> Deref for Encoder<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+// SAFETY:
+// - Via our type invariants our data layout starts with `drm_encoder`.
+// - Since we don't expose `Encoder` to users befre it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_encoder`.
+unsafe impl<T: DriverEncoder> AsRawEncoder for Encoder<T> {
+    fn as_raw(&self) -> *mut bindings::drm_encoder {
+        self.encoder.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encoder) -> &'a Self {
+        // SAFETY: Our data layout is starts with to `bindings::drm_encoder`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: `funcs` is initialized when the encoder is allocated
+unsafe impl<T: DriverEncoder> ModeObjectVtable for Encoder<T> {
+    type Vtable = bindings::drm_encoder_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid pointer to an encoder
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+impl<T: DriverEncoder> Encoder<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D>(&'a OpaqueEncoder<D>) -> &'a Self;
+        use
+            T as DriverEncoder,
+            D as KmsDriver<Encoder = ...>
+    }
+}
+
+/// A [`Encoder`] that has not yet been registered with userspace.
+///
+/// KMS registration is single-threaded, so this object is not thread-safe.
+///
+/// # Invariants
+///
+/// - This object can only exist before its respective KMS device has been registered.
+/// - Otherwise, it inherits all invariants of [`Encoder`] and has an identical data layout.
+pub struct UnregisteredEncoder<T: DriverEncoder>(Encoder<T>, NotThreadSafe);
+
+// SAFETY: We inherit all relevant invariants of `Encoder`
+unsafe impl<T: DriverEncoder> AsRawEncoder for UnregisteredEncoder<T> {
+    fn as_raw(&self) -> *mut bindings::drm_encoder {
+        self.0.as_raw()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encoder) -> &'a Self {
+        // SAFETY: This is another from_raw() call, so this function shares the same safety contract
+        let encoder = unsafe { Encoder::<T>::from_raw(ptr) };
+
+        // SAFETY: Our data layout is identical via our type invariants.
+        unsafe { mem::transmute(encoder) }
+    }
+}
+
+impl<T: DriverEncoder> Deref for UnregisteredEncoder<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0.inner
+    }
+}
+
+impl<T: DriverEncoder> UnregisteredEncoder<T> {
+    /// Construct a new [`UnregisteredEncoder`].
+    ///
+    /// A driver may use this from their [`KmsDriver::create_objects`] callback in order to
+    /// construct new [`UnregisteredEncoder`] objects.
+    ///
+    /// [`KmsDriver::create_objects`]: kernel::drm::kms::KmsDriver::create_objects
+    pub fn new<'a, 'b: 'a>(
+        dev: &'a NewKmsDevice<'a, T::Driver, Probing>,
+        type_: Type,
+        possible_crtcs: u32,
+        possible_clones: u32,
+        name: Option<&CStr>,
+        args: T::Args,
+    ) -> Result<&'b Self> {
+        let this: Pin<KBox<Encoder<T>>> = KBox::try_pin_init(
+            try_pin_init!(Encoder {
+                encoder: Opaque::new(bindings::drm_encoder {
+                    helper_private: &T::OPS.helper_funcs,
+                    possible_crtcs,
+                    possible_clones,
+                    ..Default::default()
+                }),
+                inner <- T::new(dev, args),
+                _p: PhantomPinned
+            }),
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY:
+        // - `dev` is responsible for destroying the encoder and thus outlives us.
+        // - as_raw() returns valid pointers for each type here
+        // - This initializes `this`
+        // - Our type is proof that this is being called before KMS device registration
+        // - `name` is optional and will be auto-generated by DRM if passed as NULL
+        to_result(unsafe {
+            bindings::drm_encoder_init(
+                dev.as_raw(),
+                this.as_raw(),
+                &T::OPS.funcs,
+                type_ as _,
+                name.map_or(null(), |n| n.as_char_ptr()),
+            )
+        })?;
+
+        // SAFETY: We don't move anything
+        let this = unsafe { Pin::into_inner_unchecked(this) };
+
+        // We'll re-assemble the box in encoder_destroy_callback()
+        let this = KBox::into_raw(this);
+
+        // UnregisteredEncoder has an equivalent data layout
+        let this: *mut Self = this.cast();
+
+        // SAFETY: We just allocated the encoder above, so this pointer must be valid
+        Ok(unsafe { &*this })
+    }
+}
+
+/// A [`struct drm_encoder`] without a known [`DriverEncoder`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverEncoder`] implementation
+/// for a [`struct drm_encoder`] automatically. It is identical to [`Encoder`], except that it does not
+/// provide access to the driver's private data.
+///
+/// # Invariants
+///
+/// Same as [`Encoder`].
+#[repr(transparent)]
+pub struct OpaqueEncoder<T: KmsDriver> {
+    encoder: Opaque<bindings::drm_encoder>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> Sealed for OpaqueEncoder<T> {}
+
+// SAFETY: All of our encoder interfaces are thread-safe
+unsafe impl<T: KmsDriver> Send for OpaqueEncoder<T> {}
+
+// SAFETY: All of our encoder interfaces are thread-safe
+unsafe impl<T: KmsDriver> Sync for OpaqueEncoder<T> {}
+
+// SAFETY: We don't expose OpaqueEncoder<T> to users before `base` is initialized in
+// OpaqueEncoder::new(), so `raw_mode_obj` always returns a valid poiner to a
+// bindings::drm_mode_object.
+unsafe impl<T: KmsDriver> ModeObject for OpaqueEncoder<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: DRM encoders exist for as long as the device does, so this pointer is always
+        // valid
+        unsafe { Device::from_raw((*self.encoder.get()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose Encoder<T> to users before it's initialized, so `base` is always
+        // initialized
+        unsafe { &raw mut (*self.encoder.get()).base }
+    }
+}
+
+// SAFETY: Encoders do not have a refcount
+unsafe impl<T: KmsDriver> StaticModeObject for OpaqueEncoder<T> {}
+
+// SAFETY:
+// - Via our type variants our data layout is identical to  with `drm_encoder`
+// - Since we don't expose `Encoder` to users before it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_encoder`.
+unsafe impl<T: KmsDriver> AsRawEncoder for OpaqueEncoder<T> {
+    fn as_raw(&self) -> *mut bindings::drm_encoder {
+        self.encoder.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encoder) -> &'a Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_encoder`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: `funcs` is initialized when the encoder is allocated
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueEncoder<T> {
+    type Vtable = bindings::drm_encoder_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid pointer to an encoder
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+unsafe extern "C" fn encoder_destroy_callback<T: DriverEncoder>(
+    encoder: *mut bindings::drm_encoder,
+) {
+    // SAFETY: DRM guarantees that `encoder` points to a valid initialized `drm_encoder`.
+    unsafe { bindings::drm_encoder_cleanup(encoder) };
+
+    // SAFETY:
+    // - DRM guarantees we are now the only one with access to this [`drm_encoder`].
+    // - This cast is safe via `DriverEncoder`s type invariants.
+    unsafe { drop(KBox::from_raw(encoder as *mut Encoder<T>)) };
+}
diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
new file mode 100644
index 000000000000..54d0391388a9
--- /dev/null
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM framebuffers.
+//!
+//! C header: [`include/drm/drm_framebuffer.h`](srctree/include/drm/drm_framebuffer.h)
+
+use super::{KmsDriver, ModeObject, Sealed};
+use crate::{drm::device::Device, types::*};
+use bindings;
+use core::{marker::*, ptr};
+
+/// The main interface for [`struct drm_framebuffer`].
+///
+/// # Invariants
+///
+/// - `self.0` is initialized for as long as this object is exposed to users.
+/// - This type has an identical data layout to [`struct drm_framebuffer`]
+///
+/// [`struct drm_framebuffer`]: srctree/include/drm/drm_framebuffer.h
+#[repr(transparent)]
+pub struct Framebuffer<T: KmsDriver>(Opaque<bindings::drm_framebuffer>, PhantomData<T>);
+
+// SAFETY:
+// - `self.0` is initialized for as long as this object is exposed to users
+// - `base` is initialized by DRM when `self.0` is initialized, thus `raw_mode_obj()` always returns
+//   a valid pointer.
+unsafe impl<T: KmsDriver> ModeObject for Framebuffer<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: `dev` points to an initialized `struct drm_device` for as long as this type is
+        // initialized
+        unsafe { Device::from_raw((*self.0.get()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose Framebuffer<T> to users before its initialized, so `base` is
+        // always initialized
+        unsafe { &raw mut (*self.0.get()).base }
+    }
+}
+
+// SAFETY: References to framebuffers are safe to be accessed from any thread
+unsafe impl<T: KmsDriver> Send for Framebuffer<T> {}
+// SAFETY: References to framebuffers are safe to be accessed from any thread
+unsafe impl<T: KmsDriver> Sync for Framebuffer<T> {}
+
+// For implementing ModeObject
+impl<T: KmsDriver> Sealed for Framebuffer<T> {}
+
+impl<T: KmsDriver> PartialEq for Framebuffer<T> {
+    fn eq(&self, other: &Self) -> bool {
+        ptr::eq(self.0.get(), other.0.get())
+    }
+}
+impl<T: KmsDriver> Eq for Framebuffer<T> {}
+
+impl<T: KmsDriver> Framebuffer<T> {
+    /// Convert a raw pointer to a `struct drm_framebuffer` into a [`Framebuffer`]
+    ///
+    /// # Safety
+    ///
+    /// The caller guarantews that `ptr` points to a initialized `struct drm_framebuffer` for at
+    /// least the entire lifetime of `'a`.
+    #[inline]
+    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_framebuffer) -> &'a Self {
+        // SAFETY: Our data layout is identical to drm_framebuffer
+        unsafe { &*ptr.cast() }
+    }
+}
diff --git a/rust/kernel/drm/kms/modes.rs b/rust/kernel/drm/kms/modes.rs
new file mode 100644
index 000000000000..0e8dc434487d
--- /dev/null
+++ b/rust/kernel/drm/kms/modes.rs
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+use bindings;
+
+use crate::types::Opaque;
+
+/// DRM kernel-internal display mode structure.
+///
+/// This structure contains various resolution and timing information for a given display mode in
+/// DRM.
+///
+/// # Invariants
+///
+/// - The data layout of this structure is guaranteed to be equivalent to that of `struct
+///   drm_display_mode`.
+/// - We ensure through our bindings that rust's data aliasing rules are maintained, ensuring it is
+///   safe to read any fields inside of `self.inner`.
+#[repr(transparent)]
+pub struct DisplayMode {
+    inner: Opaque<bindings::drm_display_mode>,
+}
+
+// SAFETY: Our bindings are thread-safe via our type invariants.
+unsafe impl Send for DisplayMode {}
+// SAFETY: Our bindings are thread-safe via our type invariants.
+unsafe impl Sync for DisplayMode {}
+
+impl DisplayMode {
+    /// Convert a raw pointer to a `struct drm_display_mode` into an immutable [`DisplayMode`] ref.
+    ///
+    /// # SAFETY
+    ///
+    /// - The caller guarantees that `self_ptr` points to a valid initialized `struct
+    ///   drm_display_mode`.
+    /// - The caller must ensure that rust's data aliasing rules will not be broken for the lifetime
+    ///   of `'a`, e.g. no mutable references may exist while immutable references exist to Self.
+    #[inline]
+    pub(crate) unsafe fn as_ref<'a>(self_ptr: *const bindings::drm_display_mode) -> &'a Self {
+        // SAFETY: The pointer is valid via our safety contract, and the data layout of this struct
+        // is equivalent to `Self` via our type invariants.
+        unsafe { &*self_ptr.cast() }
+    }
+
+    /// Return a raw pointer to the `struct drm_display_mode` contained within this [`DisplayMode`].
+    #[inline]
+    pub(crate) fn as_raw(&self) -> *const bindings::drm_display_mode {
+        self.inner.get().cast_const()
+    }
+
+    /// Retrieve the pixel clock for the adjusted display mode in kHz.
+    #[inline]
+    pub fn crtc_clock(&self) -> i32 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).crtc_clock }
+    }
+
+    /// Retrieve the start of the vertical sync period for the adjusted display mode.
+    #[inline]
+    pub fn crtc_vblank_start(&self) -> u16 {
+        unsafe { (*self.as_raw()).crtc_vblank_start }
+    }
+
+    /// Retrieve the end of the vertical sync period for the adjusted display mode.
+    #[inline]
+    pub fn crtc_vblank_end(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).crtc_vblank_end }
+    }
+
+    /// Retrieve the number of vertical scanlines for a full scanout frame in this adjusted display
+    /// mode.
+    #[inline]
+    pub fn crtc_vtotal(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).crtc_vtotal }
+    }
+}
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
new file mode 100644
index 000000000000..661d82273099
--- /dev/null
+++ b/rust/kernel/drm/kms/plane.rs
@@ -0,0 +1,1095 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM display planes.
+//!
+//! C header: [`include/drm/drm_plane.h`](srctree/include/drm/drm_plane.h)
+
+use super::{
+    atomic::*, crtc::*, framebuffer::*, KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject,
+    NewKmsDevice, Probing, Sealed
+};
+use crate::{
+    alloc::KBox,
+    bindings,
+    drm::{device::Device, fourcc::*},
+    error::{from_result, to_result, Error},
+    prelude::*,
+    types::{NotThreadSafe, Opaque},
+};
+use core::{
+    cell::Cell,
+    marker::*,
+    mem::{self, ManuallyDrop},
+    ops::*,
+    pin::Pin,
+    ptr::{null, null_mut, NonNull},
+};
+
+/// The main trait for implementing the [`struct drm_plane`] API for [`Plane`].
+///
+/// Any KMS driver should have at least one implementation of this type, which allows them to create
+/// [`Plane`] objects. Additionally, a driver may store driver-private data within the type that
+/// implements [`DriverPlane`] - and it will be made available when using a fully typed [`Plane`]
+/// object.
+///
+/// # Invariants
+///
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_plane`] pointers are contained within a [`Plane<Self>`].
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_plane_state`] pointers are contained within a [`PlaneState<Self::State>`].
+///
+/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
+/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+#[vtable]
+pub trait DriverPlane: Send + Sync + Sized {
+    /// The generated C vtable for this [`DriverPlane`] implementation.
+    const OPS: &'static DriverPlaneOps = &DriverPlaneOps {
+        funcs: bindings::drm_plane_funcs {
+            update_plane: Some(bindings::drm_atomic_helper_update_plane),
+            disable_plane: Some(bindings::drm_atomic_helper_disable_plane),
+            destroy: Some(plane_destroy_callback::<Self>),
+            reset: Some(plane_reset_callback::<Self>),
+            set_property: None,
+            atomic_duplicate_state: Some(atomic_duplicate_state_callback::<Self::State>),
+            atomic_destroy_state: Some(atomic_destroy_state_callback::<Self::State>),
+            atomic_set_property: None,
+            atomic_get_property: None,
+            late_register: None,
+            early_unregister: None,
+            atomic_print_state: None,
+            format_mod_supported: None,
+            format_mod_supported_async: None,
+        },
+
+        helper_funcs: bindings::drm_plane_helper_funcs {
+            prepare_fb: None,
+            cleanup_fb: None,
+            begin_fb_access: None,
+            end_fb_access: None,
+            atomic_check: if Self::HAS_ATOMIC_CHECK {
+                Some(atomic_check_callback::<Self>)
+            } else {
+                None
+            },
+            atomic_update: if Self::HAS_ATOMIC_UPDATE {
+                Some(atomic_update_callback::<Self>)
+            } else {
+                None
+            },
+            atomic_enable: None,
+            atomic_disable: None,
+            atomic_async_check: None,
+            atomic_async_update: None,
+            panic_flush: None,
+            get_scanout_buffer: None,
+        },
+    };
+
+    /// The type to pass to the `args` field of [`UnregisteredPlane::new`].
+    ///
+    /// This type will be made available in in the `args` argument of [`Self::new`]. Drivers which
+    /// don't need this can simply pass [`()`] here.
+    type Args;
+
+    /// The parent [`KmsDriver`] implementation.
+    type Driver: KmsDriver;
+
+    /// The [`DriverPlaneState`] implementation for this [`DriverPlane`].
+    ///
+    /// See [`DriverPlaneState`] for more info.
+    type State: DriverPlaneState;
+
+    /// The constructor for creating a [`Plane`] using this [`DriverPlane`] implementation.
+    ///
+    /// Drivers may use this to instantiate their [`DriverPlane`] object.
+    fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+
+    /// The optional [`drm_plane_helper_funcs.atomic_update`] hook for this plane.
+    ///
+    /// Drivers may use this to customize the atomic update phase of their [`Plane`] objects. If not
+    /// specified, this function is a no-op.
+    ///
+    /// [`drm_plane_helper_funcs.atomic_update`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_update(_commit: PlaneAtomicCommit<'_, Self>) {
+        build_error::build_error("This should not be reachable")
+    }
+
+    /// The optional [`drm_plane_helper_funcs.atomic_check`] hook for this plane.
+    ///
+    /// Drivers may use this to customize the atomic check phase of their [`Plane`] objects. The
+    /// result of this function determines whether the atomic check passed or failed.
+    ///
+    /// [`drm_plane_helper_funcs.atomic_check`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_check(_check: PlaneAtomicCheck<'_, Self>) -> Result {
+        build_error::build_error("This should not be reachable")
+    }
+}
+
+/// The generated C vtable for a [`DriverPlane`].
+///
+/// This type is created internally by DRM.
+pub struct DriverPlaneOps {
+    funcs: bindings::drm_plane_funcs,
+    helper_funcs: bindings::drm_plane_helper_funcs,
+}
+
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(u32)]
+/// An enumerator describing a type of [`Plane`].
+///
+/// This is mainly just relevant for DRM legacy drivers.
+///
+/// # Invariants
+///
+/// This type is identical to [`enum drm_plane_type`].
+///
+/// [`enum drm_plane_type`]: srctree/include/drm/drm_plane.h
+pub enum Type {
+    /// Overlay planes represent all non-primary, non-cursor planes. Some drivers refer to these
+    /// types of planes as "sprites" internally.
+    Overlay = bindings::drm_plane_type_DRM_PLANE_TYPE_OVERLAY,
+
+    /// A primary plane attached to a CRTC that is the most likely to be able to light up the CRTC
+    /// when no scaling/cropping is used, and the plane covers the whole CRTC.
+    Primary = bindings::drm_plane_type_DRM_PLANE_TYPE_PRIMARY,
+
+    /// A cursor plane attached to a CRTC that is more likely to be enabled when no scaling/cropping
+    /// is used, and the framebuffer has the size indicated by [`ModeConfigInfo::max_cursor`].
+    ///
+    /// [`ModeConfigInfo::max_cursor`]: crate::drm::kms::ModeConfigInfo
+    Cursor = bindings::drm_plane_type_DRM_PLANE_TYPE_CURSOR,
+}
+
+/// The main interface for a [`struct drm_plane`].
+///
+/// This type is the main interface for dealing with DRM planes. In addition, it also allows
+/// immutable access to whatever private data is contained within an implementor's [`DriverPlane`]
+/// type.
+///
+/// # Invariants
+///
+/// - `plane` and `inner` are initialized for as long as this object is made available to users.
+/// - The data layout of this structure begins with [`struct drm_plane`].
+/// - The atomic state for this type can always be assumed to be of type [`PlaneState<T::State>`].
+///
+/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
+#[repr(C)]
+#[pin_data]
+pub struct Plane<T: DriverPlane> {
+    /// The FFI drm_plane object
+    plane: Opaque<bindings::drm_plane>,
+    /// The driver's private inner data
+    #[pin]
+    inner: T,
+    #[pin]
+    _p: PhantomPinned,
+}
+
+impl<T: DriverPlane> Sealed for Plane<T> {}
+
+impl<T: DriverPlane> Deref for Plane<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+// SAFETY: `funcs` is initialized when the plane is allocated
+unsafe impl<T: DriverPlane> ModeObjectVtable for Plane<T> {
+    type Vtable = bindings::drm_plane_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid plane pointer
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+impl<T: DriverPlane> Plane<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D>(&'a OpaquePlane<D>) -> &'a Self;
+        use
+            T as DriverPlane,
+            D as KmsDriver<Plane = ...>
+    }
+}
+
+/// A [`Plane`] that has not yet been registered with userspace.
+///
+/// KMS registration is single-threaded, so this object is not thread-safe.
+///
+/// # Invariants
+///
+/// - This object can only exist before its respective KMS device has been registered.
+/// - Otherwise, it inherits all invariants of [`Plane`] and has an identical data layout.
+pub struct UnregisteredPlane<T: DriverPlane>(Plane<T>, NotThreadSafe);
+
+// SAFETY: We share the invariants of `Plane`
+unsafe impl<T: DriverPlane> AsRawPlane for UnregisteredPlane<T> {
+    fn as_raw(&self) -> *mut bindings::drm_plane {
+        self.0.as_raw()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane) -> &'a Self {
+        // SAFETY: This is another from_raw() call, so this function shares the same safety contract
+        let plane = unsafe { Plane::<T>::from_raw(ptr) };
+
+        // SAFETY: Our data layout is identical via our type invariants.
+        unsafe { mem::transmute(plane) }
+    }
+}
+
+impl<T: DriverPlane> Deref for UnregisteredPlane<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0.inner
+    }
+}
+
+impl<T: DriverPlane> UnregisteredPlane<T> {
+    /// Construct a new [`UnregisteredPlane`].
+    ///
+    /// A driver may use this from their [`KmsDriver::create_objects`] callback in order to
+    /// construct new [`UnregisteredPlane`] objects.
+    ///
+    /// [`KmsDriver::create_objects`]: kernel::drm::kms::KmsDriver::create_objects
+    pub fn new<'a, 'b: 'a>(
+        dev: &'a NewKmsDevice<'a, T::Driver, Probing>,
+        possible_crtcs: u32,
+        formats: &[u32],
+        format_modifiers: Option<&[u64]>,
+        type_: Type,
+        name: Option<&CStr>,
+        args: T::Args,
+    ) -> Result<&'b Self> {
+        let this: Pin<KBox<Plane<T>>> = KBox::try_pin_init(
+            try_pin_init!(Plane {
+                plane: Opaque::new(bindings::drm_plane {
+                    helper_private: &T::OPS.helper_funcs,
+                    ..Default::default()
+                }),
+                inner <- T::new(dev, args),
+                _p: PhantomPinned
+            }),
+            GFP_KERNEL,
+        )?;
+
+        // TODO: Move this over to using collect() someday
+        // Create a modifiers array with the sentinel for passing to DRM
+        let format_modifiers_raw;
+        if let Some(modifiers) = format_modifiers {
+            let mut raw = KVec::with_capacity(modifiers.len() + 1, GFP_KERNEL)?;
+            for modifier in modifiers {
+                raw.push(*modifier, GFP_KERNEL)?;
+            }
+            raw.push(FORMAT_MOD_INVALID, GFP_KERNEL)?;
+
+            format_modifiers_raw = Some(raw);
+        } else {
+            format_modifiers_raw = None;
+        }
+
+        // SAFETY:
+        // - `dev` handles destroying the plane, and thus will outlive us and always be valid.
+        // - We just allocated `this`, and we won't move it since it's pinned
+        // - We just allocated the `format_modifiers_raw` vec and added the sentinel DRM expects
+        //   above
+        // - `drm_universal_plane_init` will memcpy() the following parameters into its own storage,
+        //   so it's safe for them to become inaccessible after this call returns:
+        //   - `formats`
+        //   - `format_modifiers_raw`
+        //   - `name`
+        // - `type_` is equivalent to `drm_plane_type` via its type invariants.
+        to_result(unsafe {
+            bindings::drm_universal_plane_init(
+                dev.as_raw(),
+                this.as_raw(),
+                possible_crtcs,
+                &T::OPS.funcs,
+                formats.as_ptr(),
+                formats.len() as _,
+                format_modifiers_raw.map_or(null(), |f| f.as_ptr()),
+                type_ as _,
+                name.map_or(null(), |n| n.as_char_ptr()),
+            )
+        })?;
+
+        // SAFETY: We don't move anything
+        let this = unsafe { Pin::into_inner_unchecked(this) };
+
+        // We'll re-assemble the box in plane_destroy_callback()
+        let this = KBox::into_raw(this);
+
+        // UnregisteredPlane has an equivalent data layout
+        let this: *mut Self = this.cast();
+
+        // SAFETY: We just allocated the plane above, so this pointer must be valid
+        Ok(unsafe { &*this })
+    }
+}
+
+/// A trait implemented by any type that acts as a [`struct drm_plane`] interface.
+///
+/// This is implemented internally by DRM.
+///
+/// # Safety
+///
+/// [`as_raw()`] must always return a valid pointer to an initialized [`struct drm_plane`].
+///
+/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
+/// [`as_raw()`]: AsRawPlane::as_raw()
+pub unsafe trait AsRawPlane {
+    /// Return the raw `bindings::drm_plane` for this DRM plane.
+    ///
+    /// Drivers should never use this directly.
+    fn as_raw(&self) -> *mut bindings::drm_plane;
+
+    /// Convert a raw `bindings::drm_plane` pointer into an object of this type.
+    ///
+    /// # Safety
+    ///
+    /// Callers promise that `ptr` points to a valid instance of this type
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane) -> &'a Self;
+}
+
+// SAFETY:
+// - Via our type variants our data layout starts with `drm_plane`
+// - Since we don't expose `plane` to users before it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_plane`.
+unsafe impl<T: DriverPlane> AsRawPlane for Plane<T> {
+    fn as_raw(&self) -> *mut bindings::drm_plane {
+        self.plane.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane) -> &'a Self {
+        // Our data layout start with `bindings::drm_plane`.
+        let ptr: *mut Self = ptr.cast();
+
+        // SAFETY: Our safety contract requires that `ptr` point to a valid intance of `Self`.
+        unsafe { &*ptr }
+    }
+}
+
+// SAFETY: We only expose this object to users directly after KmsDriver::create_objects has been
+// called.
+unsafe impl<T: DriverPlane> ModesettablePlane for Plane<T> {
+    type State = PlaneState<T::State>;
+}
+
+// SAFETY: We don't expose Plane<T> to users before `base` is initialized in ::new(), so
+// `raw_mode_obj` always returns a valid pointer to a bindings::drm_mode_object.
+unsafe impl<T: DriverPlane> ModeObject for Plane<T> {
+    type Driver = T::Driver;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: DRM planes exist for as long as the device does, so this pointer is always valid
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose DRM planes to users before `base` is initialized
+        unsafe { &raw mut (*self.as_raw()).base }
+    }
+}
+
+// SAFETY: Planes do not have a refcount
+unsafe impl<T: DriverPlane> StaticModeObject for Plane<T> {}
+
+// SAFETY: Our interface is thread-safe.
+unsafe impl<T: DriverPlane> Send for Plane<T> {}
+
+// SAFETY: Our interface is thread-safe.
+unsafe impl<T: DriverPlane> Sync for Plane<T> {}
+
+/// A supertrait of [`AsRawPlane`] for [`struct drm_plane`] interfaces that can perform modesets.
+///
+/// This is implemented internally by DRM.
+///
+/// # Safety
+///
+/// Any object implementing this trait must only be made directly available to the user after
+/// [`create_objects`] has completed.
+///
+/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
+/// [`create_objects`]: KmsDriver::create_objects
+pub unsafe trait ModesettablePlane: AsRawPlane {
+    /// The type that should be returned for a plane state acquired using this plane interface
+    type State: FromRawPlaneState;
+}
+
+/// Common methods available on any type which implements [`AsRawPlane`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// planes.
+pub trait RawPlane: AsRawPlane {
+    /// Return the index of this DRM plane
+    #[inline]
+    fn index(&self) -> u32 {
+        // SAFETY:
+        // - The index is initialized by the time we expose planes to users, and does not change
+        //   throughout its lifetime
+        // - `.as_raw()` always returns a valid poiinter.
+        unsafe { *self.as_raw() }.index
+    }
+
+    /// Return the index of this DRM plane in the form of a bitmask
+    #[inline]
+    fn mask(&self) -> u32 {
+        1 << self.index()
+    }
+}
+impl<T: AsRawPlane> RawPlane for T {}
+
+/// A [`struct drm_plane`] without a known [`DriverPlane`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverPlane`] implementation
+/// for a [`struct drm_plane`] automatically. It is identical to [`Plane`], except that it does not
+/// provide access to the driver's private data.
+///
+/// It may be upcasted to a full [`Plane`] using [`Plane::from_opaque`] or
+/// [`Plane::try_from_opaque`].
+///
+/// # Invariants
+///
+/// - `plane` is initialized for as long as this object is made available to users.
+/// - The data layout of this structure is equivalent to [`struct drm_plane`].
+///
+/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
+#[repr(transparent)]
+pub struct OpaquePlane<T: KmsDriver> {
+    plane: Opaque<bindings::drm_plane>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> Sealed for OpaquePlane<T> {}
+
+// SAFETY:
+// * Via our type variants our data layout is identical to `drm_plane`
+// * Since we don't expose `plane` to users before it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_plane`.
+unsafe impl<T: KmsDriver> AsRawPlane for OpaquePlane<T> {
+    fn as_raw(&self) -> *mut bindings::drm_plane {
+        self.plane.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane) -> &'a Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_plane`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: We only expose this object to users directly after KmsDriver::create_objects has been
+// called.
+unsafe impl<T: KmsDriver> ModesettablePlane for OpaquePlane<T> {
+    type State = OpaquePlaneState<T>;
+}
+
+// SAFETY: We don't expose OpaquePlane<T> to users before `base` is initialized in
+// Plane::<T>::new(), so `raw_mode_obj` always returns a valid pointer to a
+// bindings::drm_mode_object.
+unsafe impl<T: KmsDriver> ModeObject for OpaquePlane<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: DRM planes exist for as long as the device does, so this pointer is always valid
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose DRM planes to users before `base` is initialized
+        unsafe { &raw mut (*self.as_raw()).base }
+    }
+}
+
+// SAFETY: Planes do not have a refcount
+unsafe impl<T: KmsDriver> StaticModeObject for OpaquePlane<T> {}
+
+// SAFETY: `funcs` is initialized when the plane is allocated
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaquePlane<T> {
+    type Vtable = bindings::drm_plane_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid pointer to a plane
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+// SAFETY: Our plane interfaces are guaranteed to be thread-safe
+unsafe impl<T: KmsDriver> Send for OpaquePlane<T> {}
+unsafe impl<T: KmsDriver> Sync for OpaquePlane<T> {}
+
+/// A trait implemented by any type which can produce a reference to a [`struct drm_plane_state`].
+///
+/// This is implemented internally by DRM.
+///
+/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+pub trait AsRawPlaneState: private::AsRawPlaneState {
+    /// The type that this plane state interface returns to represent the parent DRM plane
+    type Plane: ModesettablePlane;
+}
+
+pub(crate) mod private {
+    /// Trait for retrieving references to the base plane state contained within any plane state
+    /// compatible type
+    #[allow(unreachable_pub)]
+    pub trait AsRawPlaneState {
+        /// Return an immutable reference to the raw plane state
+        fn as_raw(&self) -> &bindings::drm_plane_state;
+
+        /// Get a mutable reference to the raw `bindings::drm_plane_state` contained within this
+        /// type.
+        ///
+        /// # Safety
+        ///
+        /// The caller promises this mutable reference will not be used to modify any contents of
+        /// `bindings::drm_plane_state` which DRM would consider to be static - like the backpointer
+        /// to the DRM plane that owns this state. This also means the mutable reference should
+        /// never be exposed outside of this crate.
+        unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state;
+    }
+}
+
+pub(crate) use private::AsRawPlaneState as AsRawPlaneStatePrivate;
+
+/// A trait implemented for any type which can be constructed directly from a
+/// [`struct drm_plane_state`] pointer.
+///
+/// This is implemented internally by DRM.
+///
+/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+pub trait FromRawPlaneState: AsRawPlaneState {
+    /// Get an immutable reference to this type from the given raw [`struct drm_plane_state`]
+    /// pointer.
+    ///
+    /// # Safety
+    ///
+    /// - The caller guarantees `ptr` is contained within a valid instance of `Self`
+    /// - The caller guarantees that `ptr` cannot not be modified for the lifetime of `'a`.
+    ///
+    /// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_plane_state) -> &'a Self;
+
+    /// Get a mutable reference to this type from the given raw [`struct drm_plane_state`] pointer.
+    ///
+    /// # Safety
+    ///
+    /// - The caller guarantees that `ptr` is contained within a valid instance of `Self`
+    /// - The caller guarantees that `ptr` cannot have any other references taken out for the
+    ///   lifetime of `'a`.
+    ///
+    /// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_plane_state) -> &'a mut Self;
+}
+
+/// Common methods available on any type which implements [`AsRawPlane`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// the atomic state of [`Plane`]s.
+pub trait RawPlaneState: AsRawPlaneState {
+    /// Return the plane that this plane state belongs to.
+    fn plane(&self) -> &Self::Plane {
+        // SAFETY: The index is initialized by the time we expose Plane objects to users, and is
+        // invariant throughout the lifetime of the Plane
+        unsafe { Self::Plane::from_raw(self.as_raw().plane) }
+    }
+
+    /// Return the current [`OpaqueCrtc`] assigned to this plane, if there is one.
+    fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b OpaqueCrtc<D>>
+    where
+        Self::Plane: ModeObject<Driver = D>,
+        D: KmsDriver,
+    {
+        // SAFETY: This cast is guaranteed safe by `OpaqueCrtc`s invariants.
+        NonNull::new(self.as_raw().crtc).map(|c| unsafe { OpaqueCrtc::from_raw(c.as_ptr()) })
+    }
+
+    /// Run the atomic check helper for this plane and the given CRTC state.
+    fn atomic_helper_check<S, D>(
+        &mut self,
+        crtc_state: &CrtcStateMutator<'_, S>,
+        can_position: bool,
+        can_update_disabled: bool,
+    ) -> Result
+    where
+        D: KmsDriver,
+        S: FromRawCrtcState,
+        S::Crtc: ModesettableCrtc + ModeObject<Driver = D>,
+        Self::Plane: ModeObject<Driver = D>,
+    {
+        // SAFETY: We're passing the mutable reference from `self.as_raw_mut()` directly to DRM,
+        // which is safe.
+        to_result(unsafe {
+            bindings::drm_atomic_helper_check_plane_state(
+                self.as_raw_mut(),
+                crtc_state.as_raw(),
+                bindings::DRM_PLANE_NO_SCALING as _, // TODO: add parameters for scaling
+                bindings::DRM_PLANE_NO_SCALING as _,
+                can_position,
+                can_update_disabled,
+            )
+        })
+    }
+
+    /// Return the framebuffer currently set for this plane state
+    #[inline]
+    fn framebuffer<D>(&self) -> Option<&Framebuffer<D>>
+    where
+        Self::Plane: ModeObject<Driver = D>,
+        D: KmsDriver,
+    {
+        // SAFETY: The layout of Framebuffer<T> is identical to `fb`
+        unsafe {
+            self.as_raw()
+                .fb
+                .as_ref()
+                .map(|fb| Framebuffer::from_raw(fb))
+        }
+    }
+}
+impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
+
+/// The main interface for a [`struct drm_plane_state`].
+///
+/// This type is the main interface for dealing with the atomic state of DRM planes. In addition, it
+/// allows access to whatever private data is contained within an implementor's [`DriverPlaneState`]
+/// type.
+///
+/// # Invariants
+///
+/// - The DRM C API and our interface guarantees that only the user has mutable access to `state`,
+///   up until [`drm_atomic_helper_commit_hw_done`] is called. Therefore, `plane` follows rust's
+///   data aliasing rules and does not need to be behind an [`Opaque`] type.
+/// - `state` and `inner` initialized for as long as this object is exposed to users.
+/// - The data layout of this structure begins with [`struct drm_plane_state`].
+/// - The plane for this atomic state can always be assumed to be of type [`Plane<T::Plane>`].
+///
+/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+/// [`drm_atomic_helper_commit_hw_done`]: srctree/include/drm/drm_atomic_helper.h
+#[derive(Default)]
+#[repr(C)]
+pub struct PlaneState<T: DriverPlaneState> {
+    state: bindings::drm_plane_state,
+    inner: T,
+}
+
+/// The main trait for implementing the [`struct drm_plane_state`] API for a [`Plane`].
+///
+/// A driver may store driver-private data within the implementor's type, which will be available
+/// when using a full typed [`PlaneState`] object.
+///
+/// # Invariants
+///
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_plane`] pointers are contained within a [`Plane<Self::Plane>`].
+/// - Any C FFI callbacks generated using this trait are guaranteed that passed-in
+///   [`struct drm_plane_state`] pointers are contained within a [`PlaneState<Self>`].
+///
+/// [`struct drm_plane`]: srctree/include/drm_plane.h
+/// [`struct drm_plane_state`]: srctree/include/drm_plane.h
+pub trait DriverPlaneState: Clone + Default + Sized {
+    /// The type for this driver's drm_plane implementation
+    type Plane: DriverPlane;
+}
+
+impl<T: DriverPlaneState> Sealed for PlaneState<T> {}
+
+impl<T: DriverPlaneState> AsRawPlaneState for PlaneState<T> {
+    type Plane = Plane<T::Plane>;
+}
+
+impl<T: DriverPlaneState> private::AsRawPlaneState for PlaneState<T> {
+    fn as_raw(&self) -> &bindings::drm_plane_state {
+        &self.state
+    }
+
+    unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
+        &mut self.state
+    }
+}
+
+impl<T: DriverPlaneState> FromRawPlaneState for PlaneState<T> {
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_plane_state) -> &'a Self {
+        // Our data layout starts with `bindings::drm_plane_state`.
+        let ptr: *const Self = ptr.cast();
+
+        // SAFETY:
+        // - Our safety contract requires that `ptr` be contained within `Self`.
+        // - Our safety contract requires the caller ensure that it is safe for us to take an
+        //   immutable reference.
+        unsafe { &*ptr }
+    }
+
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_plane_state) -> &'a mut Self {
+        // Our data layout starts with `bindings::drm_plane_state`.
+        let ptr: *mut Self = ptr.cast();
+
+        // SAFETY:
+        // - Our safety contract requires that `ptr` be contained within `Self`.
+        // - Our safety contract requires the caller ensure it is safe for us to take a mutable
+        //   reference.
+        unsafe { &mut *ptr }
+    }
+}
+
+impl<T: DriverPlaneState> Deref for PlaneState<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+impl<T: DriverPlaneState> DerefMut for PlaneState<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.inner
+    }
+}
+
+// SAFETY: Shares the safety guarantee of Plane<T>'s vtable impl
+unsafe impl<T: DriverPlaneState> ModeObjectVtable for PlaneState<T> {
+    type Vtable = bindings::drm_plane_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.plane().vtable()
+    }
+}
+
+impl<T: DriverPlaneState> PlaneState<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D, P>(&'a OpaquePlaneState<D>) -> &'a Self
+        where
+            T: DriverPlaneState<Plane = P>;
+        use
+            P as DriverPlane,
+            D as KmsDriver<Plane = ...>
+    }
+}
+
+/// A [`struct drm_plane_state`] without a known [`DriverPlaneState`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverPlaneState`]
+/// implementation for a [`struct drm_plane_state`] automatically. It is identical to [`Plane`],
+/// except that it does not provide access to the driver's private data.
+///
+/// # Invariants
+///
+/// - The DRM C API and our interface guarantees that only the user has mutable access to `state`,
+///   up until [`drm_atomic_helper_commit_hw_done`] is called. Therefore, `plane` follows rust's
+///   data aliasing rules and does not need to be behind an [`Opaque`] type.
+/// - `state` is initialized for as long as this object is exposed to users.
+/// - The data layout of this structure is identical to [`struct drm_plane_state`].
+///
+/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+/// [`drm_atomic_helper_commit_hw_done`]: srctree/include/drm/drm_atomic_helper.h
+#[repr(transparent)]
+pub struct OpaquePlaneState<T: KmsDriver> {
+    state: bindings::drm_plane_state,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> AsRawPlaneState for OpaquePlaneState<T> {
+    type Plane = OpaquePlane<T>;
+}
+
+impl<T: KmsDriver> private::AsRawPlaneState for OpaquePlaneState<T> {
+    fn as_raw(&self) -> &bindings::drm_plane_state {
+        &self.state
+    }
+
+    unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
+        &mut self.state
+    }
+}
+
+impl<T: KmsDriver> FromRawPlaneState for OpaquePlaneState<T> {
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_plane_state) -> &'a Self {
+        // SAFETY: Our data layout is identical to `ptr`
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_plane_state) -> &'a mut Self {
+        // SAFETY: Our data layout is identical to `ptr`
+        unsafe { &mut *ptr.cast() }
+    }
+}
+
+// SAFETY: Shares the safety guarantee of OpaquePlane<T>'s vtable impl
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaquePlaneState<T> {
+    type Vtable = bindings::drm_plane_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.plane().vtable()
+    }
+}
+
+/// An interface for mutating a [`Plane`]s atomic state.
+///
+/// This type is typically returned by an [`AtomicStateMutator`] within contexts where it is
+/// possible to safely mutate a plane's state. In order to uphold rust's data-aliasing rules, only
+/// [`PlaneStateMutator`] may exist at a time.
+pub struct PlaneStateMutator<'a, T: FromRawPlaneState> {
+    state: &'a mut T,
+    mask: &'a Cell<u32>,
+}
+
+impl<'a, T: FromRawPlaneState> PlaneStateMutator<'a, T> {
+    pub(super) fn new<D: KmsDriver>(
+        mutator: &'a AtomicStateMutator<D>,
+        state: NonNull<bindings::drm_plane_state>,
+    ) -> Option<Self> {
+        // SAFETY: `plane` is invariant throughout the lifetime of the atomic state, is
+        // initialized by this point, and we're guaranteed it is of type `AsRawPlane` by type
+        // invariance
+        let plane = unsafe { T::Plane::from_raw((*state.as_ptr()).plane) };
+        let plane_mask = plane.mask();
+        let borrowed_mask = mutator.borrowed_planes.get();
+
+        if borrowed_mask & plane_mask == 0 {
+            mutator.borrowed_planes.set(borrowed_mask | plane_mask);
+            Some(Self {
+                mask: &mutator.borrowed_planes,
+                // SAFETY: We're guaranteed `state` is of `FromRawPlaneState` by type invariance,
+                // and we just confirmed by checking `borrowed_planes` that no other mutable borrows
+                // have been taken out for `state`
+                state: unsafe { T::from_raw_mut(state.as_ptr()) },
+            })
+        } else {
+            None
+        }
+    }
+}
+
+impl<'a, T: FromRawPlaneState> Drop for PlaneStateMutator<'a, T> {
+    fn drop(&mut self) {
+        let mask = self.state.plane().mask();
+        self.mask.set(self.mask.get() & !mask);
+    }
+}
+
+impl<'a, T: FromRawPlaneState> AsRawPlaneState for PlaneStateMutator<'a, T> {
+    type Plane = T::Plane;
+}
+
+impl<'a, T: FromRawPlaneState> private::AsRawPlaneState for PlaneStateMutator<'a, T> {
+    fn as_raw(&self) -> &bindings::drm_plane_state {
+        self.state.as_raw()
+    }
+
+    unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
+        // SAFETY: This function is bound by the same safety contract as `self.inner.as_raw_mut()`
+        unsafe { self.state.as_raw_mut() }
+    }
+}
+
+impl<'a, T: FromRawPlaneState> Sealed for PlaneStateMutator<'a, T> {}
+
+impl<'a, T: DriverPlaneState> Deref for PlaneStateMutator<'a, PlaneState<T>> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.state.inner
+    }
+}
+
+impl<'a, T: DriverPlaneState> DerefMut for PlaneStateMutator<'a, PlaneState<T>> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.state.inner
+    }
+}
+
+// SAFETY: Shares the safety guarantees of `T`'s ModeObjectVtable impl
+unsafe impl<'a, T: FromRawPlaneState> ModeObjectVtable for PlaneStateMutator<'a, T>
+where
+    T: FromRawPlaneState + ModeObjectVtable,
+{
+    type Vtable = T::Vtable;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        self.state.vtable()
+    }
+}
+
+impl<'a, T: DriverPlaneState> PlaneStateMutator<'a, PlaneState<T>> {
+    super::impl_from_opaque_mode_obj! {
+        fn <D, P>(PlaneStateMutator<'a, OpaquePlaneState<D>>) -> Self
+        where
+            T: DriverPlaneState<Plane = P>;
+        use
+            P as DriverPlane,
+            D as KmsDriver<Plane = ...>
+    }
+}
+
+/// A token provided during [`atomic_check`] callbacks for accessing the plane, atomic state, and
+/// the old and new states of the plane.
+///
+/// [`atomic_check`]: DriverPlane::atomic_check
+pub struct PlaneAtomicCheck<'a, T: DriverPlane> {
+    state: &'a AtomicStateComposer<T::Driver>,
+    plane: &'a Plane<T>,
+}
+
+impl<'a, T: DriverPlane> PlaneAtomicCheck<'a, T> {
+    impl_atomic_state_token_ops!(
+        PlaneAtomicCheck,
+        AtomicStateComposer,
+        Plane,
+        use <'a, T>
+    );
+}
+
+/// A token provided to [`DriverPlane`] callbacks during the atomic commit phase for accessing the
+/// plane, atomic state, new and old states of the plane.
+///
+/// # Invariants
+///
+/// This token is proof that the old and new atomic state of `plane` are present in `state` and do
+/// not have any mutators taken out.
+pub struct PlaneAtomicCommit<'a, T: DriverPlane> {
+    state: &'a AtomicStateMutator<T::Driver>,
+    plane: &'a Plane<T>,
+}
+
+impl<'a, T: DriverPlane> PlaneAtomicCommit<'a, T> {
+    impl_atomic_state_token_ops!(
+        PlaneAtomicCommit,
+        AtomicStateMutator,
+        Plane,
+        use <'a, T>
+    );
+}
+
+unsafe extern "C" fn plane_destroy_callback<T: DriverPlane>(plane: *mut bindings::drm_plane) {
+    // SAFETY: DRM guarantees that `plane` points to a valid initialized `drm_plane`.
+    unsafe { bindings::drm_plane_cleanup(plane) };
+
+    // SAFETY:
+    // - DRM guarantees we are now the only one with access to this [`drm_plane`].
+    // - This cast is safe via `DriverPlane`s type invariants.
+    drop(unsafe { KBox::from_raw(plane as *mut Plane<T>) });
+}
+
+unsafe extern "C" fn atomic_duplicate_state_callback<T: DriverPlaneState>(
+    plane: *mut bindings::drm_plane,
+) -> *mut bindings::drm_plane_state {
+    // SAFETY: DRM guarantees that `plane` points to a valid initialized `drm_plane`.
+    let state = unsafe { (*plane).state };
+    if state.is_null() {
+        return null_mut();
+    }
+
+    // SAFETY: This cast is safe via `DriverPlaneState`s type invariants.
+    let state = unsafe { PlaneState::<T>::from_raw(state) };
+
+    let new: Result<KBox<_>> = KBox::try_init(
+        try_init!(PlaneState {
+            inner: state.inner.clone(),
+            state: bindings::drm_plane_state {
+                ..Default::default()
+            },
+        }),
+        GFP_KERNEL,
+    );
+
+    if let Ok(mut new) = new {
+        // SAFETY:
+        // - `new` provides a valid pointer to a newly allocated `drm_plane_state` via type
+        //   invariants
+        // - This initializes `new` via memcpy()
+        unsafe { bindings::__drm_atomic_helper_plane_duplicate_state(plane, new.as_raw_mut()) };
+
+        KBox::into_raw(new).cast()
+    } else {
+        null_mut()
+    }
+}
+
+unsafe extern "C" fn atomic_destroy_state_callback<T: DriverPlaneState>(
+    _plane: *mut bindings::drm_plane,
+    state: *mut bindings::drm_plane_state,
+) {
+    // SAFETY: DRM guarantees that `state` points to a valid instance of `drm_plane_state`
+    unsafe { bindings::__drm_atomic_helper_plane_destroy_state(state) };
+
+    // SAFETY:
+    // * DRM guarantees we are the only one with access to this `drm_plane_state`
+    // * This cast is safe via our type invariants.
+    drop(unsafe { KBox::from_raw(state.cast::<PlaneState<T>>()) });
+}
+
+unsafe extern "C" fn plane_reset_callback<T: DriverPlane>(plane: *mut bindings::drm_plane) {
+    // SAFETY: DRM guarantees that `state` points to a valid instance of `drm_plane_state`
+    let state = unsafe { (*plane).state };
+    if !state.is_null() {
+        // SAFETY:
+        // - We're guaranteed `plane` is `Plane<T>` via type invariants
+        // - We're guaranteed `state` is `PlaneState<T>` via type invariants.
+        unsafe { atomic_destroy_state_callback::<T::State>(plane, state) }
+
+        // SAFETY: No special requirements here, DRM expects this to be NULL
+        unsafe {
+            (*plane).state = null_mut();
+        }
+    }
+
+    // Unfortunately, this is the best we can do at the moment as this FFI callback was mistakenly
+    // presumed to be infallible :(
+    let new =
+        KBox::new(PlaneState::<T::State>::default(), GFP_KERNEL).expect("Blame the API, sorry!");
+
+    // DRM takes ownership of the state from here, resets it, and then assigns it to the plane
+    // SAFETY:
+    // - DRM guarantees that `plane` points to a valid instance of `drm_plane`.
+    // - The cast to `drm_plane_state` is safe via `PlaneState`s type invariants.
+    unsafe { bindings::__drm_atomic_helper_plane_reset(plane, KBox::into_raw(new).cast()) };
+}
+
+unsafe extern "C" fn atomic_update_callback<T: DriverPlane>(
+    plane: *mut bindings::drm_plane,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // - We're guaranteed `plane` is of type `Plane<T>` via type invariants.
+    // - We're guaranteed by DRM that `plane` is pointing to a valid initialized state.
+    let plane = unsafe { Plane::from_raw(plane) };
+
+    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_state`
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY:
+    // - Since we're in the atomic_update callback, we're guaranteed by DRM that both the old and new
+    //   plane state are resent in this atomic state.
+    // - We just created the state mutator above, so other mutators cannot be taken out on the plane
+    //   state yet.
+    let commit = unsafe { PlaneAtomicCommit::new(plane, &state) };
+
+    T::atomic_update(commit);
+}
+
+unsafe extern "C" fn atomic_check_callback<T: DriverPlane>(
+    plane: *mut bindings::drm_plane,
+    state: *mut bindings::drm_atomic_state,
+) -> i32 {
+    // SAFETY:
+    // - We're guaranteed `plane` is of type `Plane<T>` via type invariants.
+    // - We're guaranteed by DRM that `plane` is pointing to a valid initialized state.
+    let plane = unsafe { Plane::from_raw(plane) };
+
+    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_state`
+    // We use ManuallyDrop here since AtomicStateComposer would otherwise drop a owned reference to
+    // the atomic state upon finishing this callback.
+    let state = ManuallyDrop::new(unsafe {
+        AtomicStateComposer::<T::Driver>::new(NonNull::new_unchecked(state))
+    });
+
+    // SAFETY:
+    // - Since we're in the atomic check callback, we're guaranteed by DRM that both the old and
+    //   new plane state are present in this atomic state
+    // - We just created the state composer above, so other composers cannot be taken out on the
+    //   plane state yet.
+    let check = unsafe { PlaneAtomicCheck::new(plane, &state) };
+
+    from_result(|| T::atomic_check(check).map(|_| 0))
+}
diff --git a/rust/kernel/drm/kms/vblank.rs b/rust/kernel/drm/kms/vblank.rs
new file mode 100644
index 000000000000..dc34e02e8ccb
--- /dev/null
+++ b/rust/kernel/drm/kms/vblank.rs
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM KMS vblank support.
+//!
+//! C header: [`include/drm/drm_vblank.h`](srcfree/include/drm/drm_vblank.h)
+
+use super::{crtc::*, ModeObject, modes::*, Sealed};
+use bindings;
+use core::{
+    marker::*,
+    mem::{self, ManuallyDrop},
+    ops::{Deref, Drop},
+    ptr::null_mut,
+};
+use kernel::{
+    drm::device::Device,
+    error::{from_result, to_result},
+    interrupt::LocalInterruptDisabled,
+    prelude::*,
+    time::Delta,
+    types::Opaque,
+};
+
+/// The main trait for a driver to implement hardware vblank support for a [`Crtc`].
+///
+/// # Invariants
+///
+/// C FFI callbacks generated using this trait can safely assume that input pointers to
+/// [`struct drm_crtc`] are always contained within a [`Crtc<Self::Crtc>`].
+///
+/// [`struct drm_crtc`]: srctree/include/drm/drm_crtc.h
+pub trait VblankSupport: Sized {
+    /// The parent [`DriverCrtc`].
+    type Crtc: VblankDriverCrtc<VblankImpl = Self>;
+
+    /// Enable vblank interrupts for this [`DriverCrtc`].
+    fn enable_vblank(
+        crtc: &Crtc<Self::Crtc>,
+        vblank_guard: &VblankGuard<'_, Self::Crtc>,
+        irq: &LocalInterruptDisabled,
+    ) -> Result;
+
+    /// Disable vblank interrupts for this [`DriverCrtc`].
+    fn disable_vblank(
+        crtc: &Crtc<Self::Crtc>,
+        vblank_guard: &VblankGuard<'_, Self::Crtc>,
+        irq: &LocalInterruptDisabled,
+    );
+
+    /// Retrieve the current vblank timestamp for this [`Crtc`]
+    ///
+    /// If this function is being called from the driver's vblank interrupt handler,
+    /// `handling_vblank_irq` will be `true`.
+    fn get_vblank_timestamp(
+        crtc: &Crtc<Self::Crtc>,
+        in_vblank_irq: bool,
+    ) -> Option<VblankTimestamp>;
+}
+
+/// Trait used for CRTC vblank (or lack there-of) implementations. Implemented internally.
+///
+/// Drivers interested in implementing vblank support should refer to [`VblankSupport`], drivers
+/// that don't have vblank support can use [`PhantomData`].
+pub trait VblankImpl {
+    /// The parent [`DriverCrtc`].
+    type Crtc: DriverCrtc<VblankImpl = Self>;
+
+    /// The generated [`VblankOps`].
+    const VBLANK_OPS: VblankOps;
+}
+
+/// C FFI callbacks for vblank management.
+///
+/// Created internally by DRM.
+#[derive(Default)]
+pub struct VblankOps {
+    pub(crate) enable_vblank: Option<unsafe extern "C" fn(crtc: *mut bindings::drm_crtc) -> i32>,
+    pub(crate) disable_vblank: Option<unsafe extern "C" fn(crtc: *mut bindings::drm_crtc)>,
+    pub(crate) get_vblank_timestamp: Option<
+        unsafe extern "C" fn(
+            crtc: *mut bindings::drm_crtc,
+            max_error: *mut i32,
+            vblank_time: *mut bindings::ktime_t,
+            in_vblank_irq: bool,
+        ) -> bool,
+    >,
+}
+
+impl<T: VblankSupport> VblankImpl for T {
+    type Crtc = T::Crtc;
+
+    const VBLANK_OPS: VblankOps = VblankOps {
+        enable_vblank: Some(enable_vblank_callback::<T>),
+        disable_vblank: Some(disable_vblank_callback::<T>),
+        get_vblank_timestamp: Some(get_vblank_timestamp_callback::<T>),
+    };
+}
+
+impl<T> VblankImpl for PhantomData<T>
+where
+    T: DriverCrtc<VblankImpl = PhantomData<T>>,
+{
+    type Crtc = T;
+
+    const VBLANK_OPS: VblankOps = VblankOps {
+        enable_vblank: None,
+        disable_vblank: None,
+        get_vblank_timestamp: None,
+    };
+}
+
+unsafe extern "C" fn enable_vblank_callback<T: VblankSupport>(
+    crtc: *mut bindings::drm_crtc,
+) -> i32 {
+    // SAFETY: We're guaranteed that `crtc` is of type `Crtc<T::Crtc>` by type invariants.
+    let crtc = unsafe { Crtc::<T::Crtc>::from_raw(crtc) };
+
+    // SAFETY: This callback happens with IRQs disabled
+    let irq = unsafe { LocalInterruptDisabled::assume_disabled() };
+
+    // SAFETY: This callback happens with `vbl_lock` already held
+    // We don't want to drop `vbl_lock` when this callback completes since DRM will do this for us,
+    // so wrap the `VblankGuard` in a `ManuallyDrop`
+    let vblank_guard = ManuallyDrop::new(unsafe { VblankGuard::new(crtc, irq) });
+
+    from_result(|| T::enable_vblank(crtc, &vblank_guard, irq).map(|_| 0))
+}
+
+unsafe extern "C" fn disable_vblank_callback<T: VblankSupport>(crtc: *mut bindings::drm_crtc) {
+    // SAFETY: We're guaranteed that `crtc` is of type `Crtc<T::Crtc>` by type invariants.
+    let crtc = unsafe { Crtc::<T::Crtc>::from_raw(crtc) };
+
+    // SAFETY: This callback happens with IRQs disabled
+    let irq = unsafe { LocalInterruptDisabled::assume_disabled() };
+
+    // SAFETY: This call happens with `vbl_lock` already held
+    // We don't want to drop `vbl_lock` when this callback completes since DRM will do this for us,
+    // so wrap the `VblankGuard` in a `ManuallyDrop`
+    let vblank_guard = ManuallyDrop::new(unsafe { VblankGuard::new(crtc, irq) });
+
+    T::disable_vblank(crtc, &vblank_guard, irq);
+}
+
+unsafe extern "C" fn get_vblank_timestamp_callback<T: VblankSupport>(
+    crtc: *mut bindings::drm_crtc,
+    max_error: *mut i32,
+    vblank_time: *mut bindings::ktime_t,
+    in_vblank_irq: bool,
+) -> bool {
+    // SAFETY: We're guaranteed `crtc` is of type `Crtc<T::Crtc>` by type invariance
+    let crtc = unsafe { Crtc::<T::Crtc>::from_raw(crtc) };
+
+    if let Some(timestamp) = T::get_vblank_timestamp(crtc, in_vblank_irq) {
+        // SAFETY: Both of these pointers are guaranteed by the C API to be valid
+        unsafe {
+            (*max_error) = timestamp.max_error;
+            (*vblank_time) = timestamp.time.as_nanos();
+        };
+
+        true
+    } else {
+        false
+    }
+}
+
+/// A vblank timestamp.
+///
+/// This type is used by [`VblankSupport::get_vblank_timestamp`] for the implementor to return the
+/// current vblank timestamp for the hardware.
+#[derive(Copy, Clone)]
+pub struct VblankTimestamp {
+    /// The actual vblank timestamp in nanoseconds, accuracy to within [`Self::max_error`]
+    /// nanoseconds.
+    pub time: Delta,
+
+    /// Maximum allowable timestamp error in nanoseconds
+    pub max_error: i32,
+}
+
+/// A trait for [`DriverCrtc`] implementations with hardware vblank support.
+///
+/// This trait is implemented internally by DRM for any [`DriverCrtc`] implementation that
+/// implements [`VblankSupport`]. It is used to expose hardware-vblank driver exclusive methods and
+/// data to users.
+pub trait VblankDriverCrtc: DriverCrtc {}
+
+impl<T, V> VblankDriverCrtc for T
+where
+    T: DriverCrtc<VblankImpl = V>,
+    V: VblankSupport<Crtc = T>,
+{
+}
+
+impl<T: VblankDriverCrtc> Crtc<T> {
+    /// Retrieve a reference to the [`VblankCrtc`] for this [`Crtc`].
+    pub(crate) fn vblank_crtc(&self) -> &VblankCrtc<T> {
+        // SAFETY:
+        // - The data layouts of these types are equivalent via `VblankCrtc`s type invariants
+        // - We don't expose any way of calling `vblank_crtc()` before `drm_vblank_init()` has been
+        //   called.
+        unsafe { VblankCrtc::from_raw(self.get_vblank_ptr()) }
+    }
+
+    /// Access vblank related infrastructure for a [`Crtc`].
+    ///
+    /// This function explicitly locks the device's vblank lock, and allows access to controlling
+    /// the vblank configuration for this CRTC. The lock is dropped once [`VblankGuard`] is
+    /// dropped.
+    pub fn vblank_lock<'a>(&'a self, irq: &'a LocalInterruptDisabled) -> VblankGuard<'a, T> {
+        // SAFETY: `vbl_lock` is initialized for as long as `Crtc` is available to users
+        // INVARIANT: We just acquired `vbl_lock`, fulfilling the invariants of `VblankGuard`
+        unsafe { bindings::spin_lock(&raw mut (*self.drm_dev().as_raw()).vbl_lock) };
+
+        // SAFETY: We just acquired vbl_lock above
+        unsafe { VblankGuard::new(self, irq) }
+    }
+
+    /// Trigger a vblank event on this [`Crtc`].
+    ///
+    /// Drivers should use this in their vblank interrupt handlers to update the vblank counter and
+    /// send any signals that may be pending.
+    ///
+    /// Returns whether or not the vblank event was handled.
+    #[inline]
+    pub fn handle_vblank(&self) -> bool {
+        // SAFETY: `as_raw()` always returns a valid pointer to an initialized drm_crtc.
+        unsafe { bindings::drm_crtc_handle_vblank(self.as_raw()) }
+    }
+
+    /// Forbid vblank events for a [`Crtc`].
+    ///
+    /// This function disables vblank events for a [`Crtc`], even if [`VblankRef`] objects exist.
+    #[inline]
+    pub fn vblank_off(&self) {
+        // SAFETY: `as_raw()` always returns a valid pointer to an initialized drm_crtc.
+        unsafe { bindings::drm_crtc_vblank_off(self.as_raw()) }
+    }
+
+    /// Allow vblank events for a [`Crtc`].
+    ///
+    /// This function allows users to enable vblank events and acquire [`VblankRef`] objects again.
+    #[inline]
+    pub fn vblank_on(&self) {
+        // SAFETY: `as_raw()` always returns a valid pointer to an initialized drm_crtc.
+        unsafe { bindings::drm_crtc_vblank_on(self.as_raw()) }
+    }
+
+    /// Enable vblank events for a [`Crtc`].
+    ///
+    /// Returns a [`VblankRef`] which will allow vblank events to be sent until it is dropped. Note
+    /// that vblank events may still be disabled by [`Self::vblank_off`].
+    #[must_use = "Vblanks are only enabled until the result from this function is dropped"]
+    pub fn vblank_get(&self) -> Result<VblankRef<'_, T>> {
+        VblankRef::new(self)
+    }
+}
+
+/// Common methods available on any [`CrtcState`] whose [`Crtc`] implements [`VblankSupport`].
+///
+/// This trait is implemented automatically by DRM for any [`DriverCrtc`] implementation that
+/// implements [`VblankSupport`].
+pub trait RawVblankCrtcState: AsRawCrtcState {
+    /// Return the [`PendingVblankEvent`] for this CRTC state, if there is one.
+    fn get_pending_vblank_event(&mut self) -> Option<PendingVblankEvent<'_, Self>>
+    where
+        Self: Sized,
+    {
+        // SAFETY: The driver is the only one that will ever modify this data, and since our
+        // interface follows rust's data aliasing rules that means this is safe to read
+        let event_ptr = unsafe { *self.as_raw() }.event;
+
+        (!event_ptr.is_null()).then_some(PendingVblankEvent(self))
+    }
+}
+
+impl<T, C> RawVblankCrtcState for T
+where
+    T: AsRawCrtcState<Crtc = Crtc<C>>,
+    C: VblankDriverCrtc,
+{
+}
+
+/// A pending vblank event from an atomic state
+pub struct PendingVblankEvent<'a, T: RawVblankCrtcState>(&'a mut T);
+
+impl<'a, T: RawVblankCrtcState> PendingVblankEvent<'a, T> {
+    /// Send this [`PendingVblankEvent`].
+    ///
+    /// A [`PendingVblankEvent`] can only be sent once, so this function consumes the
+    /// [`PendingVblankEvent`].
+    pub fn send<C>(self)
+    where
+        T: RawVblankCrtcState<Crtc = Crtc<C>>,
+        C: VblankDriverCrtc,
+    {
+        let crtc: &Crtc<C> = self.0.crtc();
+        let event_lock = crtc.drm_dev().event_lock();
+        let _guard = event_lock.lock();
+
+        // SAFETY:
+        // - We now hold the appropriate lock to call this function
+        // - Vblanks are enabled as proved by `vbl_ref`, as per the C api requirements
+        // - Our interface is proof that `event` is non-null
+        unsafe { bindings::drm_crtc_send_vblank_event(crtc.as_raw(), (*self.0.as_raw()).event) };
+
+        // SAFETY: The mutable reference in `self.state` is proof that it is safe to mutate this,
+        // and DRM expects us to set this to NULL once we've sent the vblank event.
+        unsafe { (*self.0.as_raw()).event = null_mut() };
+    }
+
+    /// Arm this [`PendingVblankEvent`] to be sent later by the CRTC's vblank interrupt handler.
+    ///
+    /// A [`PendingVblankEvent`] can only be armed once, so this function consumes the
+    /// [`PendingVblankEvent`]. As well, it requires a [`VblankRef`] so that vblank interrupts
+    /// remain enabled until the [`PendingVblankEvent`] has been sent out by the driver's vblank
+    /// interrupt handler.
+    pub fn arm<C>(self, vbl_ref: VblankRef<'_, C>)
+    where
+        T: RawVblankCrtcState<Crtc = Crtc<C>>,
+        C: VblankDriverCrtc,
+    {
+        let crtc: &Crtc<C> = self.0.crtc();
+        let event_lock = crtc.drm_dev().event_lock();
+        let _guard = event_lock.lock();
+
+        // SAFETY:
+        // - We now hold the appropriate lock to call this function
+        // - Vblanks are enabled as proved by `vbl_ref`, as per the C api requirements
+        // - Our interface is proof that `event` is non-null
+        unsafe { bindings::drm_crtc_arm_vblank_event(crtc.as_raw(), (*self.0.as_raw()).event) };
+
+        // SAFETY: The mutable reference in `self.state` is proof that it is safe to mutate this,
+        // and DRM expects us to set this to NULL once we've armed the vblank event.
+        unsafe { (*self.0.as_raw()).event = null_mut() };
+
+        // DRM took ownership of `vbl_ref` after we called `drm_crtc_arm_vblank_event`
+        mem::forget(vbl_ref);
+    }
+}
+
+/// A borrowed vblank reference.
+///
+/// This object keeps the vblank reference count for a [`Crtc`] incremented for as long as it
+/// exists, enabling vblank interrupts for said [`Crtc`] until all references are dropped, or
+/// [`Crtc::vblank_off`] is called - whichever comes first.
+pub struct VblankRef<'a, T: VblankDriverCrtc>(&'a Crtc<T>);
+
+impl<T: VblankDriverCrtc> Drop for VblankRef<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: as_raw() returns a valid pointer to an initialized drm_crtc
+        unsafe { bindings::drm_crtc_vblank_put(self.0.as_raw()) };
+    }
+}
+
+impl<'a, T: VblankDriverCrtc> VblankRef<'a, T> {
+    fn new(crtc: &'a Crtc<T>) -> Result<Self> {
+        // SAFETY: as_raw() returns a valid pointer to an initialized drm_crtc
+        to_result(unsafe { bindings::drm_crtc_vblank_get(crtc.as_raw()) })?;
+
+        Ok(Self(crtc))
+    }
+}
+
+/// The base wrapper for [`drm_vblank_crtc`].
+///
+/// Users will rarely interact with this object directly, it is a simple wrapper around
+/// [`drm_vblank_crtc`] which provides access to methods and data that is not protected by a lock.
+///
+/// # Invariants
+///
+/// This type has an identical data layout to [`drm_vblank_crtc`].
+///
+/// [`drm_vblank_crtc`]: srctree/include/drm/drm_vblank.h
+#[repr(transparent)]
+pub struct VblankCrtc<T>(Opaque<bindings::drm_vblank_crtc>, PhantomData<T>);
+
+impl<T: VblankDriverCrtc> VblankCrtc<T> {
+    pub(crate) fn as_raw(&self) -> *mut bindings::drm_vblank_crtc {
+        self.0.get()
+    }
+
+    // SAFETY: The caller promises that `ptr` points to a valid instance of
+    // `bindings::drm_vblank_crtc`, and that access to this structure has been properly serialized
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::drm_vblank_crtc) -> &'a Self {
+        // SAFETY: Our data layouts are identical via #[repr(transparent)]
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the [`Device`] for this [`VblankGuard`]
+    pub fn drm_dev(&self) -> &Device<T::Driver> {
+        // SAFETY: `drm` is initialized, invariant and valid throughout our lifetime
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+}
+
+// NOTE: This type does not use a `Guard` because the mutex is not contained within the same
+// structure as the relevant CRTC
+/// An interface for accessing and controlling vblank related state for a [`Crtc`].
+///
+/// This type may be returned from some [`VblankSupport`] callbacks, or manually via
+/// [`Crtc::vblank_lock`]. It provides access to methods and data which require
+/// [`drm_device.vbl_lock`] be held.
+///
+/// # Invariants
+///
+/// - [`drm_device.vbl_lock`] is acquired whenever an instance of this type exists.
+/// - Shares the invariants of [`VblankCrtc`].
+///
+/// [`drm_device.vbl_lock`]: srctree/include/drm/drm_device.h
+#[repr(transparent)]
+pub struct VblankGuard<'a, T: VblankDriverCrtc>(&'a VblankCrtc<T>);
+
+impl<'a, T: VblankDriverCrtc> VblankGuard<'a, T> {
+    /// Construct a new [`VblankGuard`]
+    ///
+    /// # Safety
+    ///
+    /// The caller must have already acquired [`drm_device.vbl_lock`].
+    ///
+    /// [`drm_device.vbl_lock`]: srctree/include/drm/drm_device.h
+    pub(crate) unsafe fn new(crtc: &'a Crtc<T>, _irq: &'a LocalInterruptDisabled) -> Self {
+        // INVARIANT: The caller promises that we've acquired `vbl_lock`
+        Self(crtc.vblank_crtc())
+    }
+
+    /// Returns the duration of a single scanout frame in ns.
+    pub fn frame_duration(&self) -> i32 {
+        // SAFETY: We hold the appropriate lock for this read via our type invariants.
+        unsafe { *self.as_raw() }.framedur_ns
+    }
+
+    /// Return the vblank core's cached copy of the currently set display mode.
+    ///
+    /// If the display is disabled, this will return `None`.
+    pub fn hwmode(&self) -> Option<&DisplayMode> {
+        // SAFETY: We hold the appropriate lock for this read via our type invariants.
+        let ptr = unsafe { &raw const (*self.as_raw()).hwmode };
+
+        // SAFETY: We check here if the cached DisplayMode is Null, which means the only other
+        // possibility is that the pointer points to a valid initialized drm_display_mode.
+        (!ptr.is_null()).then(|| unsafe { DisplayMode::as_ref(ptr) })
+    }
+}
+
+impl<T: VblankDriverCrtc> Deref for VblankGuard<'_, T> {
+    type Target = VblankCrtc<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl<T: VblankDriverCrtc> Drop for VblankGuard<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY:
+        // - We acquired this spinlock when creating this object
+        // - This lock is guaranteed to be initialized for as long as our DRM device is exposed to
+        //   users.
+        unsafe { bindings::spin_unlock(&raw mut (*self.drm_dev().as_raw()).vbl_lock) }
+    }
+}
-- 
2.55.0

