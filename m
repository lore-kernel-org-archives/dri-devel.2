Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B60F31E29
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16F710E81F;
	Thu,  9 Apr 2026 15:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qVU9T61H";
	dkim-atps=neutral
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8102510E81F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:26:22 +0000 (UTC)
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-b9c603ec28eso147267666b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775748381; x=1776353181;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=cmCMVFn7A8FBsU7JrtIy9Z3tXezUBNiPB/QWhv76Fgw=;
 b=qVU9T61HEaKpjC/qmSWkSQQYmGKTimU6KyHAS9GrCbRCCFfh3HZVaDyUsbeIpK1mw3
 i52Sb17DbW/mVgiSuY+Z0CH9NkjgPDHjC3i+4395tSX4UHmFHwCFlYXm1CG+6hWy3+8u
 USLyVFpKKScnr4bfOOoUnNVvY5WTWZr/M6YzqRG6vT42V2c225AcoySZPtUHPSyS+CqN
 +ywvW6h56dZMnyWZu9tyOZOzM1wB08H8+0eHTzv23WIv2BKA/f0bUa/nXnR8rpaHtaqB
 4obF4dTVf8Ys8wlNPe4CALNewDJ1Q/4i9Lro+LacL05j75qYS4dnlhhcQf3cj9QXBt7O
 HkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775748381; x=1776353181;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmCMVFn7A8FBsU7JrtIy9Z3tXezUBNiPB/QWhv76Fgw=;
 b=G+3SapWOXA7fZQ2D9FqA7AODP3gNDFvbXKXhbG1e7014z1djgfnX4xQDOxgFRf9I3d
 S1XB1R+hlxBQ42fY6dCiIP55uExh1QlKUv/wa7IJx08P9zReyre5HX12fvj/Bobx2Ciy
 ofbVIrzDahM6kr3MN5gctd0Ro5dMRclpKhvSvvww2FL2YcvfjMBOx/yhLGY6cFVfxqDz
 dVZcD7q7/Ap4LHG9iyItyujLvToFS593yo6fVY1BtzpT33gSK5K6IPRhMk9LO7+7IC8K
 sxvqSC6EfZTp0HxGJBeRd98O22u7zXj/AlEvLF/4uRdB5Pw0j3aicurMzKv2280uIAY1
 Y7jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYr+WxhW+QJ7yXei0xcfe8mxo+9stg2kgnQefg0/naFlLeJGkoAPNqq5Rf3OopI4N6qTYThB4HnF8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzX6fZZVHEG3E6po7wkOcXVF5tsQfpx5vB8tKHeiOCI8obeqNx
 IVYiklNIS/UxobrUJDUSuJ9IpEZzSSh0Lrih5lNN89qX4aHSIHmRYGcJvkHfB0nHf3eb302RWRf
 Pk/df9U7gRnNabDEOeg==
X-Received: from ejcqk37.prod.google.com ([2002:a17:907:7fa5:b0:b9b:ff97:4914])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d1d:b0:b87:7485:b4a8 with SMTP id
 a640c23a62f3a-b9c66ed856emr1315762866b.0.1775748380848; 
 Thu, 09 Apr 2026 08:26:20 -0700 (PDT)
Date: Thu, 09 Apr 2026 15:26:08 +0000
In-Reply-To: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
Mime-Version: 1.0
References: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8866; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=yxjLLW+eyiG9le+2ww647p7emAqKkJd9fk+bDVYvWVY=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp18UX8ZfyFfn7kV5FI2v7kmz+lyzYgsLoVvsdo
 ec1Rqwau+CJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadfFFwAKCRAEWL7uWMY5
 RtKfD/9Td4e1lxNHzVDyLZ2crdh03mOpA7vi/oiLGOvuTfyMYIUm8WjP3XSS8wIKFOXeboACYv1
 w3xQWohNglCVF7GQ3qjjDxjSPeSN3/mILQJS1580LkrVOGgItflxtCz/NEBvo4A8PPyKpnNAqJd
 MVda24R3CgHN3EGnAtJcVeYdEavX36CX/vsU8xNmVCNhHvlHtPLRbMRPlcYZBXURJRkuHvouZjn
 0xTcacguzXr+eibS7bVDcKxs/CLYDFuNBKTd4grproUybNheMlYjbRg2Dn04MMMrdQklw1qtywK
 lkDF7QH6hMoaQP+UIDU45zTbhTFV7Y0RYjk7OrKZDuNnuzQcJzm6r8F8pug1ASi8MjsAniK/lrn
 kh4YApgYpm58a5c2TYkfwF+TpaPgi3xpXcNjaeA4XJjoX6GxXZzt+ToPtXZfNLMtW4jdBw+aS6T
 JfWaoJ7xGDsJ8hjCFBm9/xwv2+UpcK5LCW7cZ85eQ17HtPGrTEMPwXrYNeRONS0ORWNk7jGy3ki
 EwDf0enr5TE7TcejQZTxvaEiVNAzJmGuwz+knoRrqfAqwhxvL3LD1NpP1jj479ApuoMrB+y66v1
 OXUrIGDEXlHpS7vklhgzTiXPtmphzw0ri6R9z1SSzh3s8+7jXdfnYOxkWHiwk5lvcR4gG8IZYER
 D6XBwRtlsUIeTCA==
X-Mailer: b4 0.14.3
Message-ID: <20260409-gpuvm-rust-v6-3-b16e6ada7261@google.com>
Subject: [PATCH v6 3/5] rust: gpuvm: add GpuVa struct
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

This struct will be used to keep track of individual mapped ranges in
the GPU's virtual memory.

Sparse VAs are not yet supported.

Co-developed-by: Asahi Lina <lina+kernel@asahilina.net>
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/gpuvm/mod.rs   |  19 ++++-
 rust/kernel/drm/gpuvm/va.rs    | 169 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs |   1 -
 3 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index 56e02b49a581..78951e8aa5d3 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -11,7 +11,10 @@
 //! C header: [`include/drm/drm_gpuvm.h`](srctree/include/drm/drm_gpuvm.h)
 
 use kernel::{
-    alloc::AllocError,
+    alloc::{
+        AllocError,
+        Flags as AllocFlags, //
+    },
     bindings,
     drm,
     drm::gem::IntoGEMObject,
@@ -25,9 +28,13 @@
 
 use core::{
     cell::UnsafeCell,
-    mem::ManuallyDrop,
+    mem::{
+        ManuallyDrop,
+        MaybeUninit, //
+    },
     ops::{
         Deref,
+        DerefMut,
         Range, //
     },
     ptr::{
@@ -36,6 +43,9 @@
     }, //
 };
 
+mod va;
+pub use self::va::*;
+
 mod vm_bo;
 pub use self::vm_bo::*;
 
@@ -48,7 +58,7 @@
 ///
 /// * Stored in an allocation managed by the refcount in `self.vm`.
 /// * Access to `data` and the gpuvm interval tree is controlled via the [`UniqueRefGpuVm`] type.
-/// * Does not contain any sparse `GpuVa` instances.
+/// * Does not contain any sparse [`GpuVa<T>`] instances.
 #[pin_data]
 pub struct GpuVm<T: DriverGpuVm> {
     #[pin]
@@ -242,6 +252,9 @@ pub trait DriverGpuVm: Sized + Send {
     /// The kind of GEM object stored in this GPUVM.
     type Object: IntoGEMObject;
 
+    /// Data stored with each [`struct drm_gpuva`](struct@GpuVa).
+    type VaData;
+
     /// Data stored with each [`struct drm_gpuvm_bo`](struct@GpuVmBo).
     type VmBoData;
 }
diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
new file mode 100644
index 000000000000..227c259f7db9
--- /dev/null
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+#![expect(dead_code)]
+use super::*;
+
+/// Represents that a range of a GEM object is mapped in this [`GpuVm`] instance.
+///
+/// Does not assume that GEM lock is held.
+///
+/// # Invariants
+///
+/// * This is a valid `drm_gpuva` object that is resident in a [`GpuVm<T>`] instance.
+/// * It is associated with a [`GpuVmBo<T>`]. Or in other words, it's not an
+///   `gpuvm->kernel_alloc_node` and `DRM_GPUVA_SPARSE` is not set.
+/// * The associated [`GpuVmBo<T>`] is part of the GEM list.
+#[repr(C)]
+#[pin_data]
+pub struct GpuVa<T: DriverGpuVm> {
+    #[pin]
+    inner: Opaque<bindings::drm_gpuva>,
+    #[pin]
+    data: T::VaData,
+}
+
+impl<T: DriverGpuVm> PartialEq for GpuVa<T> {
+    #[inline]
+    fn eq(&self, other: &Self) -> bool {
+        core::ptr::eq(self.as_raw(), other.as_raw())
+    }
+}
+impl<T: DriverGpuVm> Eq for GpuVa<T> {}
+
+impl<T: DriverGpuVm> GpuVa<T> {
+    /// Access this [`GpuVa`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * For the duration of `'a`, the pointer must reference a valid `drm_gpuva` associated with
+    ///   a [`GpuVm<T>`].
+    /// * It must be associated with a [`GpuVmBo<T>`].
+    /// * The associated [`GpuVmBo<T>`] is part of the GEM list.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_gpuva) -> &'a Self {
+        // CAST: `drm_gpuva` is first field and `repr(C)`.
+        // SAFETY: The safety requirements match the invariants of `GpuVa`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns a raw pointer to underlying C value.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::drm_gpuva {
+        self.inner.get()
+    }
+
+    /// Returns the address of this mapping in the GPU virtual address space.
+    #[inline]
+    pub fn addr(&self) -> u64 {
+        // SAFETY: The `va.addr` field of `drm_gpuva` is immutable.
+        unsafe { (*self.as_raw()).va.addr }
+    }
+
+    /// Returns the length of this mapping.
+    #[inline]
+    pub fn length(&self) -> u64 {
+        // SAFETY: The `va.range` field of `drm_gpuva` is immutable.
+        unsafe { (*self.as_raw()).va.range }
+    }
+
+    /// Returns `addr..addr+length`.
+    #[inline]
+    pub fn range(&self) -> Range<u64> {
+        let addr = self.addr();
+        addr..addr + self.length()
+    }
+
+    /// Returns the offset within the GEM object.
+    #[inline]
+    pub fn gem_offset(&self) -> u64 {
+        // SAFETY: The `gem.offset` field of `drm_gpuva` is immutable.
+        unsafe { (*self.as_raw()).gem.offset }
+    }
+
+    /// Returns the GEM object.
+    #[inline]
+    pub fn obj(&self) -> &T::Object {
+        // SAFETY: The `gem.obj` field of `drm_gpuva` is immutable. We know that it's not null
+        // because this VA is associated with a `GpuVmBo<T>`.
+        unsafe { <T::Object as IntoGEMObject>::from_raw((*self.as_raw()).gem.obj) }
+    }
+
+    /// Returns the underlying [`GpuVmBo`] object that backs this [`GpuVa`].
+    #[inline]
+    pub fn vm_bo(&self) -> &GpuVmBo<T> {
+        // SAFETY: The `vm_bo` field of `drm_gpuva` is immutable. We know that it's not null
+        // because this VA is associated with a `GpuVmBo<T>`. The BO is in the GEM list by the type
+        // invariants.
+        unsafe { GpuVmBo::from_raw((*self.as_raw()).vm_bo) }
+    }
+}
+
+/// A pre-allocated [`GpuVa`] object.
+///
+/// # Invariants
+///
+/// The memory is zeroed.
+pub struct GpuVaAlloc<T: DriverGpuVm>(KBox<MaybeUninit<GpuVa<T>>>);
+
+impl<T: DriverGpuVm> GpuVaAlloc<T> {
+    /// Pre-allocate a [`GpuVa`] object.
+    pub fn new(flags: AllocFlags) -> Result<GpuVaAlloc<T>, AllocError> {
+        // INVARIANTS: Memory allocated with __GFP_ZERO.
+        Ok(GpuVaAlloc(KBox::new_uninit(flags | __GFP_ZERO)?))
+    }
+
+    /// Prepare this `drm_gpuva` for insertion into the GPUVM.
+    #[must_use]
+    pub(super) fn prepare(mut self, va_data: impl PinInit<T::VaData>) -> *mut bindings::drm_gpuva {
+        let va_ptr = MaybeUninit::as_mut_ptr(&mut self.0);
+        // SAFETY: The `data` field is pinned.
+        let Ok(()) = unsafe { va_data.__pinned_init(&raw mut (*va_ptr).data) };
+        KBox::into_raw(self.0).cast()
+    }
+}
+
+/// A [`GpuVa`] object that has been removed.
+///
+/// # Invariants
+///
+/// The `drm_gpuva` is not resident in the [`GpuVm`].
+pub struct GpuVaRemoved<T: DriverGpuVm>(KBox<GpuVa<T>>);
+
+impl<T: DriverGpuVm> GpuVaRemoved<T> {
+    /// Convert a raw pointer into a [`GpuVaRemoved`].
+    ///
+    /// # Safety
+    ///
+    /// * Must have been removed from a [`GpuVm<T>`].
+    /// * It must not be a `gpuvm->kernel_alloc_node` va.
+    pub(super) unsafe fn from_raw(ptr: *mut bindings::drm_gpuva) -> Self {
+        // SAFETY: Since it used to be a VA in a `GpuVm<T>` and it's not a kernel_alloc_node, this
+        // pointer references a `GpuVa<T>` with a valid `T::VaData`. Since it has been removed, we
+        // can take ownership of the allocation.
+        GpuVaRemoved(unsafe { KBox::from_raw(ptr.cast()) })
+    }
+
+    /// Take ownership of the VA data.
+    pub fn into_inner(self) -> T::VaData
+    where
+        T::VaData: Unpin,
+    {
+        KBox::into_inner(self.0).data
+    }
+}
+
+impl<T: DriverGpuVm> Deref for GpuVaRemoved<T> {
+    type Target = T::VaData;
+    fn deref(&self) -> &T::VaData {
+        &self.0.data
+    }
+}
+
+impl<T: DriverGpuVm> DerefMut for GpuVaRemoved<T>
+where
+    T::VaData: Unpin,
+{
+    fn deref_mut(&mut self) -> &mut T::VaData {
+        &mut self.0.data
+    }
+}
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
index 65f03f93bd21..05fd7998f4bd 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -114,7 +114,6 @@ impl<T: DriverGpuVm> GpuVmBo<T> {
     /// For the duration of `'a`, the pointer must reference a valid `drm_gpuvm_bo` associated with
     /// a [`GpuVm<T>`]. The BO must also be present in the GEM list.
     #[inline]
-    #[expect(dead_code)]
     pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::drm_gpuvm_bo) -> &'a Self {
         // SAFETY: `drm_gpuvm_bo` is first field and `repr(C)`.
         unsafe { &*ptr.cast() }

-- 
2.53.0.1213.gd9a14994de-goog

