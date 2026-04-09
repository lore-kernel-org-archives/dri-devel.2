Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F6F31E28
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0390C10E81E;
	Thu,  9 Apr 2026 15:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="j0Fc8dyD";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3195810E81E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:26:21 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so8651255e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775748380; x=1776353180;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uwPZTgDnQi5A6sDtWS0t3d869EnrSWkSVSYeYDIyfUc=;
 b=j0Fc8dyDsbVmYB57rXpOoSFaLqNCf/cwKOEq2Da+ETktQ2qMRlQUyJ/VGAkukU709a
 L87RqrmrC5U5MK2c0haw18bgr4981+/4RZ2y6omioHbfzx1uxYGWP8WC+cuT4c6dyj2O
 M+vqQ0DHAXWqOfDDByJBZ7QDBPflQJQgWKjMej8OCXtD/jlj8Zq1OQXu3p3Opmpr6V7d
 grjhBdsMXvAnIWvGqkscHVo3TRmouRaieoGs4wgycZXCcW0PPJp4CFyVKP2b1w7x70Yk
 pVAx+/xvPMUfcdUkkZTgY5OjTwvGPo8AsGGAaVYVQ3kSvbol+WDfEiigYrWeZoZ6wiLl
 UJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775748380; x=1776353180;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwPZTgDnQi5A6sDtWS0t3d869EnrSWkSVSYeYDIyfUc=;
 b=l0Uz7d4zMzeCYjow661+REp51XvUjxxmofzusa/UKYoYt97GcSxfFVkAPPFdO2V/f2
 H9ObrPolgr69mjFbBmqoscvTH52TDU9OJNnL9G35RZpZwfvvbjbZg7aebe83nVrT7tMG
 fsHByJupJmnsJBnta11WR8hAQtYsqx+D/x8vRtcqaSocIz+kYXXtqnvyHvEtXj3U8EZt
 AqD3Fp6lP5Oq1/RM0yI5AIItcEXLIw5UeRXORfOvTKySNGsVsMXx/JYb43FnNh+QzMbY
 dtJx1MU22Udz9JC5tsclcniig7rj/2ejCFy0oyFyTvZLZTs89eAGxtw9c4Tf0aQN1mi3
 +mzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCtmGjRZu5I6bNytZQZA28GRnH1WbPMUlO9fNQwkiCqgvIeKS2vO8l5IQcYSy8Kz/tWcOSOLQeM9A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybvvJp5mfZPnrOn+wwE+AKWkpwFkgNS8RYTz55f8qKDXT8B6eM
 Jj2nyvAPLvcHMz1fptmLj94+1RJPWJNQOnz8Wbx2adYtcLnR6EjRO8J1okpOg1gPDbm6nWBfBSD
 9HKMBxRF1w5Nhys6R+A==
X-Received: from wmjf21.prod.google.com ([2002:a7b:cd15:0:b0:488:811f:e5c4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190f:b0:488:caed:5cc7 with SMTP id
 5b1f17b1804b1-488ccfd91demr61983165e9.15.1775748379557; 
 Thu, 09 Apr 2026 08:26:19 -0700 (PDT)
Date: Thu, 09 Apr 2026 15:26:07 +0000
In-Reply-To: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
Mime-Version: 1.0
References: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14411; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=vj5t+rhR/KNKc0Ceu0mW+ieVah4JKaHwJzJG2RvIoLw=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp18UXwVDiJSx3RYe4wChYnPhMEJ9BPq8i1Y/NG
 PWMdpaJ12GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadfFFwAKCRAEWL7uWMY5
 Rt+PEACKfvyDNI6HRjl6dwj+GJG+VQb4tmrGlDMKxLIAUd89kbHp7EbwYxDuA8o407acIkh4Mwz
 yXQH+UdKtaACm69h/9D6VWJG5bHm426j5bUmLQjcXzuAD3xebtTDa/GHYWwUcBZBufQScTZaqEz
 Tl64l4bKHETap66bKGDvloSY5Z+IxYuEX6caH2Dp2z0KK/QvmSmT/r9YRgbZ8qpe7BJ7gjTSI9s
 kUqPSENkwzy4OaGhumvW9A/H8Nw3+esWtRErZ5EkjpPcC0Tv3lZskXmAeN4KkfRsONzcIFhRzRf
 UWOvKrTPd68KhwOsAiYez9YuAE/AcjaQoPLiKNzZbqip1zmuHXHbX8xXb44vDA9UfCBtTtanRVk
 BXWemEGHLXdwh+YfI6lh/qum2X/Ne9uDJj/+DrdjPY6fENDKbFnbqZVtDTzP5jchLIEvhuS+iv3
 dKWy46/h5qi3lm69UbtW1TYH/Z1Fr+Zxx+BBPNRy3RuFDGg6CN4ai0pwjmu3zvxYbgRF0tJyYBm
 CHkvbhlE1EUqF+wBDbg2s+sWzSelzOCAcLKbGTGKaU/3ELGDVDtQkkyP7dAQOCFglB35VA13OXM
 rzHDQdEna6RHEjWcikiFlpbh7x42IDoKA6h6vFugS83JFfDNckNj+mUd5MZqCw63kl7x7yrdQYt
 6McEuYF8dCjeqXg==
X-Mailer: b4 0.14.3
Message-ID: <20260409-gpuvm-rust-v6-2-b16e6ada7261@google.com>
Subject: [PATCH v6 2/5] rust: gpuvm: add GpuVm::obtain()
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
 rust/helpers/drm_gpuvm.c       |   6 +
 rust/kernel/drm/gpuvm/mod.rs   |  32 +++++-
 rust/kernel/drm/gpuvm/vm_bo.rs | 242 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+), 3 deletions(-)

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
index 1d9138d989b3..56e02b49a581 100644
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
@@ -83,8 +90,8 @@ const fn vtable() -> &'static bindings::drm_gpuvm_ops {
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
@@ -184,6 +191,16 @@ pub fn va_range(&self) -> Range<u64> {
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
@@ -209,6 +226,12 @@ pub fn is_extobj(&self, obj: &T::Object) -> bool {
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
@@ -218,6 +241,9 @@ pub trait DriverGpuVm: Sized + Send {
 
     /// The kind of GEM object stored in this GPUVM.
     type Object: IntoGEMObject;
+
+    /// Data stored with each [`struct drm_gpuvm_bo`](struct@GpuVmBo).
+    type VmBoData;
 }
 
 /// The core of the DRM GPU VA manager.
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
new file mode 100644
index 000000000000..65f03f93bd21
--- /dev/null
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -0,0 +1,242 @@
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
+impl<T: DriverGpuVm> PartialEq for GpuVmBo<T> {
+    #[inline]
+    fn eq(&self, other: &Self) -> bool {
+        core::ptr::eq(self.as_raw(), other.as_raw())
+    }
+}
+impl<T: DriverGpuVm> Eq for GpuVmBo<T> {}
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
+    /// The [`drm_gem_object`](DriverGpuVm::Object) for these mappings.
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
+    ///
+    /// The caller should not hold the GEM mutex or DMA resv lock.
+    #[inline]
+    pub(super) fn obtain(self) -> ARef<GpuVmBo<T>> {
+        let me = ManuallyDrop::new(self);
+        // SAFETY: Valid `drm_gpuvm_bo` not already in the lists. We do not access `me` after this
+        // call.
+        let ptr = unsafe { bindings::drm_gpuvm_bo_obtain_prealloc(me.as_raw()) };
+
+        // SAFETY: `drm_gpuvm_bo_obtain_prealloc` always returns a non-null ptr
+        let nonnull = unsafe { NonNull::new_unchecked(ptr.cast()) };
+
+        // INVARIANTS: `drm_gpuvm_bo_obtain_prealloc` ensures that the bo is in the GEM list.
+        // SAFETY: We received one refcount from `drm_gpuvm_bo_obtain_prealloc`.
+        let ret = unsafe { ARef::<GpuVmBo<T>>::from_raw(nonnull) };
+
+        // Ensure that external objects are in the extobj list.
+        //
+        // Note that we must call `extobj_add` even if `ptr != me` to avoid a race condition where
+        // we could end up using the extobj before the thread with `ptr == me` calls extobj_add.
+        if ret.gpuvm().is_extobj(ret.obj()) {
+            let resv_lock = ret.gpuvm().raw_resv();
+            // TODO: Use a proper lock guard here once a dma_resv lock abstraction exists.
+            // SAFETY: The GPUVM is still alive, so its resv lock is too.
+            unsafe { bindings::dma_resv_lock(resv_lock, ptr::null_mut()) };
+            // SAFETY: We hold the GPUVMs resv lock.
+            unsafe { bindings::drm_gpuvm_bo_extobj_add(ptr) };
+            // SAFETY: We took the lock, so we can unlock it.
+            unsafe { bindings::dma_resv_unlock(resv_lock) };
+        }
+
+        ret
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
2.53.0.1213.gd9a14994de-goog

