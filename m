Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27DE10987A4
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9042110EB24;
	Fri, 20 Mar 2026 16:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jkau2pkM";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A2410EB21
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:08:42 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-439f5c57c52so1367222f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774022921; x=1774627721;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Igsa35Q/abhqbKOPMwTPoyThyZXwfOe3ZKKrgGUnE38=;
 b=jkau2pkMFsglQncffIilsXLZG9uB5/WTP8fCkByCFIfVUhhYz4sM71cyzCYwTuIvrE
 PfjOh6jyd7m4zmVpZRSQIH19z++o0JD6oxE+b1DglLlrGkEnVhQuywieTlunDEAp23BK
 YQJNDEEv1UIa8Psl3gbPzENBy3o9BLYjT+tpv7V6jGuKLhGkwv9++42vF6skLJb7k7BY
 VM/bcxaV1coERndt4TdqKViQbA2ibaFkMCq+NcBJG49g9e9yFI1+nh2X04CqE1fGbSo2
 hcD64NjMg1aeGM2gUx5GcpCHvntfmDS4Uh1pSbot53UpXW6To9CnhVZA+FIcObZO0M6Q
 fgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022921; x=1774627721;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Igsa35Q/abhqbKOPMwTPoyThyZXwfOe3ZKKrgGUnE38=;
 b=GY5SUXJLuRWCTXlQfUyvxNr2SJsYrVVYauDjAbWrBq8SeLsadOSZ0aWYht//C1RV/Y
 G8HTniqsOPcFNocTt+w3maO5q33y1QrE2p6SyuFgEuWS/MY11f11LeAAO4Taa9+l7Ice
 q89t+c+aJxdDrI8bsEdpfqTAMTUuBHWq+h25A3Fyn90uHEqV8me+bYOdTu4As24AlD2V
 kniqKVCMIIB6hLqDdH8sFDRhTbQCJoz3Yz9ftGg0vGFUgfdbyE/QUZGx6WaXd3EfATdx
 l/KxcigryENXsVj829APVMaGkWk7tE+ymI6JNZDs8V2k9uc17pVA4kBrLFMeg3C11kpb
 dIDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhKQvJqGXZH3a+HQRi6Kt+CGCJntKG4E9lRT4aP+PF46PjMGPg6MI+xS2KdF4dtNTVEk7pM7zJz84=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeJhGMSsvc702tqHGtuwvQTP7CfcBkaprKLY6BoIV46QXE2vur
 kXRGD0DKaOiTPKTCw/hX0NcNRCU1h1ANvvx9Yp2pMArKvCo3uaIkvnUj3mXk3bYCiBxVmiO7rOF
 Wd2pgYpgCgJxDuvdYZw==
X-Received: from wrwn9.prod.google.com ([2002:a5d:67c9:0:b0:439:b81f:ad99])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f84:b0:43b:4d2e:a004 with SMTP id
 ffacd0b85a97d-43b64242f00mr6010280f8f.10.1774022920836; 
 Fri, 20 Mar 2026 09:08:40 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:08:27 +0000
In-Reply-To: <20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com>
Mime-Version: 1.0
References: <20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=13926; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=n3i27r8Uj1K9Jua9JJ5lqChjmq+OSy3eVxOiFxWTgKs=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpvXECzP7ZocGSSzsHAKUlGZh0W8Rs/EEFE/Chd
 WOKGnKJG8iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCab1xAgAKCRAEWL7uWMY5
 RgmcD/9ALk+plFEngOFLXrpDHniFei2T0g9ABTC9MLlSIJ6fuG1nrGGmK2jue4BtBf/fWyeIGHZ
 LPc209/72ZbAm/HZ9EiqHp48Mc5FUKOABRxou1BsTDrf6XIN3kzfURJ/rNQRcyaz6m5yRI/esO/
 sX1EOx03qxdzcSTeFTGmxCWa3JOotn8TeQDIpkoZmeaCqqJIzhfP0fLGcBAPPcSqV062QXpKoD2
 Xc8UTJeu4aA2bZ6OyCjLKkqcfz1NM35NdLEHw7XJQEfiLEe3L9XeEEHrZeleP9TP6p3fOkq6l+l
 ST7PFiehIi92TV5F9qyUCtz2BuoZ9yr/F3vy16w2gA1kROVTF4h4h5YCJLv+ejMsSpgH8flbjqP
 00x7o9bH9omusaUUqF+yyZCW+lKzvzvjLBT3AR/h+aPYAEsCy4nAYGRPwko9UuYShHHJulfiBNS
 sbD5i6mG0wger1TN2kkZguMuk9G3JOY3WHmMSpsRxcDqgddY/RO7CZoglQFPswqiP3VXHV84prC
 VqgBmiP3CdQlvKyP21830kFP0qf/DYldsqQDuCjaKli0i/8voCLPFLZhkiFpxQ8ssROLBPnwgMW
 T7oUxbMSahs2lv+133PxrdvxBQLG5nfKwCfIl6toybf3nObQV34roAZORnLbF8EBad2MlF1jQJ0
 aOUsab+c842ZU9A==
X-Mailer: b4 0.14.3
Message-ID: <20260320-gpuvm-rust-v5-3-76fd44f17a87@google.com>
Subject: [PATCH v5 3/6] rust: gpuvm: add GpuVm::obtain()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, Matthew Brost <matthew.brost@intel.com>, 
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, 
 Asahi Lina <lina+kernel@asahilina.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 "=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

This provides a mechanism to create (or look up) VMBO instances, which
represent the mapping between GPUVM and GEM objects.

The GpuVmBoRegistered<T> type can be considered like ARef<GpuVm<T>>,
except that no way to increment the refcount is provided.

The GpuVmBoAlloc<T> type is more akin to a pre-allocated GpuVmBo<T>, so
it's not really a GpuVmBo<T> yet. Its destructor could call
drm_gpuvm_bo_destroy_not_in_lists(), but as the type is currently
private and never called anywhere, this perf optimization does not need
to happen now.

Pre-allocating and obtaining the gpuvm_bo object is exposed as a single
step. This could theoretically be a problem if one wanted to call
drm_gpuvm_bo_obtain_prealloc() during the fence signalling critical
path, but that's not a possibility because:

1. Adding the BO to the extobj list requires the resv lock, so it cannot
   happen during the fence signalling critical path.
2. obtain() requires that the BO is not in the extobj list, so obtain()
   must be called before adding the BO to the extobj list.

Thus, drm_gpuvm_bo_obtain_prealloc() cannot be called during the fence
signalling critical path. (For extobjs at least.)

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/drm_gpuvm.c       |   6 ++
 rust/kernel/drm/gpuvm/mod.rs   |  32 +++++-
 rust/kernel/drm/gpuvm/vm_bo.rs | 227 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 3 deletions(-)

diff --git a/rust/helpers/drm_gpuvm.c b/rust/helpers/drm_gpuvm.c
index 18cf104a8bc7..ca959d9a66f6 100644
--- a/rust/helpers/drm_gpuvm.c
+++ b/rust/helpers/drm_gpuvm.c
@@ -4,6 +4,12 @@
 
 #include <drm/drm_gpuvm.h>
 
+__rust_helper
+struct drm_gpuvm_bo *rust_helper_drm_gpuvm_bo_get(struct drm_gpuvm_bo *vm_bo)
+{
+	return drm_gpuvm_bo_get(vm_bo);
+}
+
 __rust_helper
 struct drm_gpuvm *rust_helper_drm_gpuvm_get(struct drm_gpuvm *obj)
 {
diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index 5086625bbbe7..40446e679844 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -25,13 +25,20 @@
 
 use core::{
     cell::UnsafeCell,
+    mem::ManuallyDrop,
     ops::{
         Deref,
         Range, //
     },
-    ptr::NonNull, //
+    ptr::{
+        self,
+        NonNull, //
+    }, //
 };
 
+mod vm_bo;
+pub use self::vm_bo::*;
+
 /// A DRM GPU VA manager.
 ///
 /// This object is refcounted, but the locations of mapped ranges may only be accessed or changed
@@ -73,8 +80,8 @@ const fn vtable() -> &'static bindings::drm_gpuvm_ops {
             vm_free: Some(Self::vm_free),
             op_alloc: None,
             op_free: None,
-            vm_bo_alloc: None,
-            vm_bo_free: None,
+            vm_bo_alloc: GpuVmBo::<T>::ALLOC_FN,
+            vm_bo_free: GpuVmBo::<T>::FREE_FN,
             vm_bo_validate: None,
             sm_step_map: None,
             sm_step_unmap: None,
@@ -173,6 +180,16 @@ pub fn va_range(&self) -> Range<u64> {
         Range { start, end }
     }
 
+    /// Get or create the [`GpuVmBo`] for this gem object.
+    #[inline]
+    pub fn obtain(
+        &self,
+        obj: &T::Object,
+        data: impl PinInit<T::VmBoData>,
+    ) -> Result<ARef<GpuVmBo<T>>, AllocError> {
+        Ok(GpuVmBoAlloc::new(self, obj, data)?.obtain())
+    }
+
     /// Clean up buffer objects that are no longer used.
     #[inline]
     pub fn deferred_cleanup(&self) {
@@ -198,6 +215,12 @@ pub fn is_extobj(&self, obj: &T::Object) -> bool {
         // SAFETY: By type invariants we can free it when refcount hits zero.
         drop(unsafe { KBox::from_raw(me) })
     }
+
+    #[inline]
+    fn raw_resv(&self) -> *mut bindings::dma_resv {
+        // SAFETY: `r_obj` is immutable and valid for duration of GPUVM.
+        unsafe { (*(*self.as_raw()).r_obj).resv }
+    }
 }
 
 /// The manager for a GPUVM.
@@ -207,6 +230,9 @@ pub trait DriverGpuVm: Sized {
 
     /// The kind of GEM object stored in this GPUVM.
     type Object: IntoGEMObject;
+
+    /// Data stored with each `struct drm_gpuvm_bo`.
+    type VmBoData;
 }
 
 /// The core of the DRM GPU VA manager.
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
new file mode 100644
index 000000000000..b51c6f106185
--- /dev/null
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+use super::*;
+
+/// Represents that a given GEM object has at least one mapping on this [`GpuVm`] instance.
+///
+/// Does not assume that GEM lock is held.
+///
+/// # Invariants
+///
+/// * Allocated with `kmalloc` and refcounted via `inner`.
+/// * Is present in the gem list.
+#[repr(C)]
+#[pin_data]
+pub struct GpuVmBo<T: DriverGpuVm> {
+    #[pin]
+    inner: Opaque<bindings::drm_gpuvm_bo>,
+    #[pin]
+    data: T::VmBoData,
+}
+
+// SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
+unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
+    fn inc_ref(&self) {
+        // SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
+        unsafe { bindings::drm_gpuvm_bo_get(self.inner.get()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // CAST: `drm_gpuvm_bo` is first field of repr(C) struct.
+        // SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
+        // This GPUVM instance uses immediate mode, so we may put the refcount using the deferred
+        // mechanism.
+        unsafe { bindings::drm_gpuvm_bo_put_deferred(obj.as_ptr().cast()) };
+    }
+}
+
+impl<T: DriverGpuVm> GpuVmBo<T> {
+    /// The function pointer for allocating a GpuVmBo stored in the gpuvm vtable.
+    ///
+    /// Allocation is always implemented according to [`Self::vm_bo_alloc`], but it is set to
+    /// `None` if the default gpuvm behavior is the same as `vm_bo_alloc`.
+    ///
+    /// This may be `Some` even if `FREE_FN` is `None`, or vice-versa.
+    pub(super) const ALLOC_FN: Option<unsafe extern "C" fn() -> *mut bindings::drm_gpuvm_bo> = {
+        use core::alloc::Layout;
+        let base = Layout::new::<bindings::drm_gpuvm_bo>();
+        let rust = Layout::new::<Self>();
+        assert!(base.size() <= rust.size());
+        if base.size() != rust.size() || base.align() != rust.align() {
+            Some(Self::vm_bo_alloc)
+        } else {
+            // This causes GPUVM to allocate a `GpuVmBo<T>` with `kzalloc(sizeof(drm_gpuvm_bo))`.
+            None
+        }
+    };
+
+    /// The function pointer for freeing a GpuVmBo stored in the gpuvm vtable.
+    ///
+    /// Freeing is always implemented according to [`Self::vm_bo_free`], but it is set to `None` if
+    /// the default gpuvm behavior is the same as `vm_bo_free`.
+    ///
+    /// This may be `Some` even if `ALLOC_FN` is `None`, or vice-versa.
+    pub(super) const FREE_FN: Option<unsafe extern "C" fn(*mut bindings::drm_gpuvm_bo)> = {
+        if core::mem::needs_drop::<Self>() {
+            Some(Self::vm_bo_free)
+        } else {
+            // This causes GPUVM to free a `GpuVmBo<T>` with `kfree`.
+            None
+        }
+    };
+
+    /// Custom function for allocating a `drm_gpuvm_bo`.
+    ///
+    /// # Safety
+    ///
+    /// Always safe to call.
+    unsafe extern "C" fn vm_bo_alloc() -> *mut bindings::drm_gpuvm_bo {
+        let raw_ptr = KBox::<Self>::new_uninit(GFP_KERNEL | __GFP_ZERO)
+            .map(KBox::into_raw)
+            .unwrap_or(ptr::null_mut());
+
+        // CAST: `drm_gpuvm_bo` is first field of `Self`.
+        raw_ptr.cast()
+    }
+
+    /// Custom function for freeing a `drm_gpuvm_bo`.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must have been allocated with [`GpuVmBo::ALLOC_FN`], and must not be used after
+    /// this call.
+    unsafe extern "C" fn vm_bo_free(ptr: *mut bindings::drm_gpuvm_bo) {
+        // CAST: `drm_gpuvm_bo` is first field of `Self`.
+        // SAFETY:
+        // * The ptr was allocated from kmalloc with the layout of `GpuVmBo<T>`.
+        // * `ptr->inner` has no destructor.
+        // * `ptr->data` contains a valid `T::VmBoData` that we can drop.
+        drop(unsafe { KBox::<Self>::from_raw(ptr.cast()) });
+    }
+
+    /// Access this [`GpuVmBo`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// For the duration of `'a`, the pointer must reference a valid `drm_gpuvm_bo` associated with
+    /// a [`GpuVm<T>`]. The BO must also be present in the GEM list.
+    #[inline]
+    #[expect(dead_code)]
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::drm_gpuvm_bo) -> &'a Self {
+        // SAFETY: `drm_gpuvm_bo` is first field and `repr(C)`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns a raw pointer to underlying C value.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::drm_gpuvm_bo {
+        self.inner.get()
+    }
+
+    /// The [`GpuVm`] that this GEM object is mapped in.
+    #[inline]
+    pub fn gpuvm(&self) -> &GpuVm<T> {
+        // SAFETY: The `obj` pointer is guaranteed to be valid.
+        unsafe { GpuVm::<T>::from_raw((*self.inner.get()).vm) }
+    }
+
+    /// The [`drm_gem_object`](crate::gem::Object) for these mappings.
+    #[inline]
+    pub fn obj(&self) -> &T::Object {
+        // SAFETY: The `obj` pointer is guaranteed to be valid.
+        unsafe { <T::Object as IntoGEMObject>::from_raw((*self.inner.get()).obj) }
+    }
+
+    /// The driver data with this buffer object.
+    #[inline]
+    pub fn data(&self) -> &T::VmBoData {
+        &self.data
+    }
+}
+
+/// A pre-allocated [`GpuVmBo`] object.
+///
+/// # Invariants
+///
+/// Points at a `drm_gpuvm_bo` that contains a valid `T::VmBoData`, has a refcount of one, and is
+/// absent from any gem, extobj, or evict lists.
+pub(super) struct GpuVmBoAlloc<T: DriverGpuVm>(NonNull<GpuVmBo<T>>);
+
+impl<T: DriverGpuVm> GpuVmBoAlloc<T> {
+    /// Create a new pre-allocated [`GpuVmBo`].
+    ///
+    /// It's intentional that the initializer is infallible because `drm_gpuvm_bo_put` will call
+    /// drop on the data, so we don't have a way to free it when the data is missing.
+    #[inline]
+    pub(super) fn new(
+        gpuvm: &GpuVm<T>,
+        gem: &T::Object,
+        value: impl PinInit<T::VmBoData>,
+    ) -> Result<GpuVmBoAlloc<T>, AllocError> {
+        // CAST: `GpuVmBoAlloc::vm_bo_alloc` ensures that this memory was allocated with the layout
+        // of `GpuVmBo<T>`. The type is repr(C), so `container_of` is not required.
+        // SAFETY: The provided gpuvm and gem ptrs are valid for the duration of this call.
+        let raw_ptr = unsafe {
+            bindings::drm_gpuvm_bo_create(gpuvm.as_raw(), gem.as_raw()).cast::<GpuVmBo<T>>()
+        };
+        let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+        // SAFETY: `ptr->data` is a valid pinned location.
+        let Ok(()) = unsafe { value.__pinned_init(&raw mut (*raw_ptr).data) };
+        // INVARIANTS: We just created the vm_bo so it's absent from lists, and the data is valid
+        // as we just initialized it.
+        Ok(GpuVmBoAlloc(ptr))
+    }
+
+    /// Returns a raw pointer to underlying C value.
+    #[inline]
+    pub(super) fn as_raw(&self) -> *mut bindings::drm_gpuvm_bo {
+        // SAFETY: The pointer references a valid `drm_gpuvm_bo`.
+        unsafe { (*self.0.as_ptr()).inner.get() }
+    }
+
+    /// Look up whether there is an existing [`GpuVmBo`] for this gem object.
+    #[inline]
+    pub(super) fn obtain(self) -> ARef<GpuVmBo<T>> {
+        let me = ManuallyDrop::new(self);
+        // SAFETY: Valid `drm_gpuvm_bo` not already in the lists.
+        let ptr = unsafe { bindings::drm_gpuvm_bo_obtain_prealloc(me.as_raw()) };
+
+        // Add the vm_bo to the extobj list if it's an external object, and if the vm_bo does not
+        // already exist. (If we are using an existing vm_bo, it's already in the extobj list.)
+        if ptr::eq(ptr, me.as_raw()) && me.gpuvm().is_extobj(me.obj()) {
+            let resv_lock = me.gpuvm().raw_resv();
+            // TODO: Use a proper lock guard here once a dma_resv lock abstraction exists.
+            // SAFETY: The GPUVM is still alive, so its resv lock is too.
+            unsafe { bindings::dma_resv_lock(resv_lock, ptr::null_mut()) };
+            // SAFETY: We hold the GPUVMs resv lock.
+            unsafe { bindings::drm_gpuvm_bo_extobj_add(ptr) };
+            // SAFETY: We took the lock, so we can unlock it.
+            unsafe { bindings::dma_resv_unlock(resv_lock) };
+        }
+
+        // SAFETY: `drm_gpuvm_bo_obtain_prealloc` always returns a non-null ptr
+        let ptr = unsafe { NonNull::new_unchecked(ptr.cast()) };
+
+        // INVARIANTS: `drm_gpuvm_bo_obtain_prealloc` ensures that the bo is in the GEM list.
+        // SAFETY: We received one refcount from `drm_gpuvm_bo_obtain_prealloc`.
+        unsafe { ARef::from_raw(ptr) }
+    }
+}
+
+impl<T: DriverGpuVm> Deref for GpuVmBoAlloc<T> {
+    type Target = GpuVmBo<T>;
+    #[inline]
+    fn deref(&self) -> &GpuVmBo<T> {
+        // SAFETY: By the type invariants we may deref while `Self` exists.
+        unsafe { self.0.as_ref() }
+    }
+}
+
+impl<T: DriverGpuVm> Drop for GpuVmBoAlloc<T> {
+    #[inline]
+    fn drop(&mut self) {
+        // TODO: Call drm_gpuvm_bo_destroy_not_in_lists() directly.
+        // SAFETY: It's safe to perform a deferred put in any context.
+        unsafe { bindings::drm_gpuvm_bo_put_deferred(self.as_raw()) };
+    }
+}

-- 
2.53.0.959.g497ff81fa9-goog

