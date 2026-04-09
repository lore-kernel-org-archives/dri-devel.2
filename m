Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3681F31E27
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DF810E823;
	Thu,  9 Apr 2026 15:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kDEe8V0n";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E800E10E81F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:26:23 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-4362197d1easo782660f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775748382; x=1776353182;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=SsvvT/ajEX6uKhiIbhIMJ4UO0Dt37j/GL0F977LH8ug=;
 b=kDEe8V0nQGzeuGndZVvffgVIwnkilrsWKT1xFs+bCntgtzfgmyj1i/4m0Gi3aeugjC
 iPKuR+R8b3lr8MUOsqiSV05cALmhjBw+IDH9jAcLoHLthLi6QAJupLzHhcm35MpTGZNG
 N6tP4K8F5lHdOnU7WO7PWon42zxIYmxqb0VeTqniCiGQYsgOEuK2ceCaJqyCVT3u05Du
 BAx/nP9IS9BBA9bub5OLdluriJ15vhEoX1BSksHNnWU1PlFMPYqubvtEXQ7LSRR3jlpZ
 tnE/otvRK8R+mdCHn35uCxmqwYPjhElr+mRRMaDlMchPgkk8lEppp3A8HErK2hbUnzu0
 O/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775748382; x=1776353182;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SsvvT/ajEX6uKhiIbhIMJ4UO0Dt37j/GL0F977LH8ug=;
 b=BmUZD+kqCbhuhWVSoVDK8sz6p8x8iZGG8XIzYsXE8up4WZdZhUWUehQyVZPMx1ab2Y
 AtoRpXRNDRtS6xAlgNyEoEfZiAeUEzRUuOeukGdjsLuXhIpAc1CqJnWhuBd5deUgIjy5
 ZNP78SmAQjn092JjeYvA6s9x3n95DNtmsXn7fNV4/nBI0zwEpQkmtp/s8hI8wtWLGtHk
 4Wq1pvK2W8XR0+tRtq10dNM23orL3IyKscUSXUjlz66Gbc13R0PlEjtSQsElXAba63Tj
 q8QMYhNYNBa9rd7jO1drIQqphKpRx7Omwxn8KzH7mYq7oQTtw95+b7jJ92uDdqxGFdyN
 smSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzvuEVVI5ISTg5qHGdmWUoAl3deuDQIYYgy3v50VH42JQYVzZZogL73RvaCmcyqEKFOO0yCAxRzJI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUiVh4j1QtaebxUOtm+g5bLWBHy6pjuRn6t0pnd174RII/0RCo
 OjmuuHpuQz1vqyH36XUi6PwnHqyLhKOysO1eJllIQ6sKt3HJ6iLii6szDM/pMdvPJhtEkTFYT7e
 q1Kid+RvedqN/fnLp7Q==
X-Received: from wrsv2.prod.google.com ([2002:a5d:4a42:0:b0:43d:21c:e7e0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4201:b0:43c:f95c:3e66 with SMTP id
 ffacd0b85a97d-43d29294b62mr39038591f8f.21.1775748382210; 
 Thu, 09 Apr 2026 08:26:22 -0700 (PDT)
Date: Thu, 09 Apr 2026 15:26:09 +0000
In-Reply-To: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
Mime-Version: 1.0
References: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14341; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=dbTc61MvZi+51ZExIE6njd6Wlmv7IPUMeb2BmCuJreg=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp18UX/2YIhPghe6mJmtJF6PkwmDrX8DG7baGiF
 tNeuGzoPhmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadfFFwAKCRAEWL7uWMY5
 RgwnEACnWUDSj/KzVph18Kl1Jk0OjWRAxPK0DqickJkb60PfWLQMzs+VTzOF7JOi5fx+ieGToj5
 NGShh+fQ4w5j8wNiUx8waltWPVQByNax25ojIzc1iTA7OVF1ST2qjOs8bJeISqMByFVtMFDUfgl
 Wh4M6TnMRtmRTJmPsgjSd6S7zcLcp9+Bq89w4CwMxhCr9/csRNKS3dkdnq3qFTGClXsIN5qTquK
 BocWnv7JUvxUT8/Fdf3XhFXlnkM83KUgbXghVUfFAoLnohktqHZLZt8bf528wM6Ag1RCVcbIlor
 J6DdItO0rT8tJMLP/2sHZGxvmrGsV0KuZPsxUSK9lSy4Ftsua+db69w2+PL2kUWHHaN7LTE/l1y
 faZdkS1t0qWs5UUj5JaQvaWIDQdY16e7Zy5KGmta2wwxCbklha1E1ZNVWADhIMsUaaR31N3/4V7
 NVPkbV0Mbvv9UYbJRF/JH5SBi/uAw8+9cADCVllOvXSQBNvt1sh5Eh67YDir5KeBoxTWkiTkACH
 5yGBncIxdxuEzVZyf3vlPEGhO40CJQHhvoCY43NY3utAUtLeidNPEVxk2krGyTW0PE6fkH5ltZ6
 oD5Ny9yJ/WfLvQJ4goGE5SuAC963c63qT0NOZczNsZEwi+il2P1Garnu6+beO39uadzZozpHlLk
 qit6eHlcU0a2YWA==
X-Mailer: b4 0.14.3
Message-ID: <20260409-gpuvm-rust-v6-4-b16e6ada7261@google.com>
Subject: [PATCH v6 4/5] rust: gpuvm: add GpuVmCore::sm_unmap()
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

Add the entrypoint for unmapping ranges in the GPUVM, and provide
callbacks and VA types for the implementation.

Co-developed-by: Asahi Lina <lina+kernel@asahilina.net>
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/gpuvm/mod.rs    |  30 ++++-
 rust/kernel/drm/gpuvm/sm_ops.rs | 272 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/drm/gpuvm/va.rs     |   1 -
 rust/kernel/drm/gpuvm/vm_bo.rs  |   8 ++
 4 files changed, 306 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index 78951e8aa5d3..a6436abd0f9c 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -18,6 +18,7 @@
     bindings,
     drm,
     drm::gem::IntoGEMObject,
+    error::to_result,
     prelude::*,
     sync::aref::{
         ARef,
@@ -28,6 +29,7 @@
 
 use core::{
     cell::UnsafeCell,
+    marker::PhantomData,
     mem::{
         ManuallyDrop,
         MaybeUninit, //
@@ -43,12 +45,15 @@
     }, //
 };
 
-mod va;
-pub use self::va::*;
+mod sm_ops;
+pub use self::sm_ops::*;
 
 mod vm_bo;
 pub use self::vm_bo::*;
 
+mod va;
+pub use self::va::*;
+
 /// A DRM GPU VA manager.
 ///
 /// This object is refcounted, but the locations of mapped ranges may only be accessed or changed
@@ -104,8 +109,8 @@ const fn vtable() -> &'static bindings::drm_gpuvm_ops {
             vm_bo_free: GpuVmBo::<T>::FREE_FN,
             vm_bo_validate: None,
             sm_step_map: None,
-            sm_step_unmap: None,
-            sm_step_remap: None,
+            sm_step_unmap: Some(Self::sm_step_unmap),
+            sm_step_remap: Some(Self::sm_step_remap),
         }
     }
 
@@ -257,6 +262,23 @@ pub trait DriverGpuVm: Sized + Send {
 
     /// Data stored with each [`struct drm_gpuvm_bo`](struct@GpuVmBo).
     type VmBoData;
+
+    /// The private data passed to callbacks.
+    type SmContext<'ctx>;
+
+    /// Indicates that an existing mapping should be removed.
+    fn sm_step_unmap<'op, 'ctx>(
+        &mut self,
+        op: OpUnmap<'op, Self>,
+        context: &mut Self::SmContext<'ctx>,
+    ) -> Result<OpUnmapped<'op, Self>, Error>;
+
+    /// Indicates that an existing mapping should be split up.
+    fn sm_step_remap<'op, 'ctx>(
+        &mut self,
+        op: OpRemap<'op, Self>,
+        context: &mut Self::SmContext<'ctx>,
+    ) -> Result<OpRemapped<'op, Self>, Error>;
 }
 
 /// The core of the DRM GPU VA manager.
diff --git a/rust/kernel/drm/gpuvm/sm_ops.rs b/rust/kernel/drm/gpuvm/sm_ops.rs
new file mode 100644
index 000000000000..05f81c638aef
--- /dev/null
+++ b/rust/kernel/drm/gpuvm/sm_ops.rs
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+use super::*;
+
+/// The actual data that gets threaded through the callbacks.
+struct SmData<'a, 'ctx, T: DriverGpuVm> {
+    gpuvm: &'a mut UniqueRefGpuVm<T>,
+    user_context: &'a mut T::SmContext<'ctx>,
+}
+
+/// Represents an `sm_step_unmap` operation that has not yet been completed.
+pub struct OpUnmap<'op, T: DriverGpuVm> {
+    op: &'op bindings::drm_gpuva_op_unmap,
+    // This ensures that 'op is invariant, so that `OpUnmap<'long, T>` does not
+    // coerce to `OpUnmap<'short, T>`. This ensures that the user can't return the
+    // wrong`OpUnmapped` value.
+    _invariant: PhantomData<*mut &'op mut T>,
+}
+
+impl<'op, T: DriverGpuVm> OpUnmap<'op, T> {
+    /// Indicates whether this [`GpuVa`] is physically contiguous with the
+    /// original mapping request.
+    ///
+    /// Optionally, if `keep` is set, drivers may keep the actual page table
+    /// mappings for this `drm_gpuva`, adding the missing page table entries
+    /// only and update the `drm_gpuvm` accordingly.
+    pub fn keep(&self) -> bool {
+        self.op.keep
+    }
+
+    /// The range being unmapped.
+    pub fn va(&self) -> &GpuVa<T> {
+        // SAFETY: This is a valid va. It's not the `kernel_alloc_node` because you can't unmap it,
+        // and it's not sparse by the `GpuVm<T>` type invariants.
+        unsafe { GpuVa::<T>::from_raw(self.op.va) }
+    }
+
+    /// Remove the VA.
+    pub fn remove(self) -> (OpUnmapped<'op, T>, GpuVaRemoved<T>) {
+        // SAFETY: The op references a valid drm_gpuva in the GPUVM.
+        unsafe { bindings::drm_gpuva_unmap(self.op) };
+        // SAFETY: The va is no longer in the interval tree so we may unlink it.
+        unsafe { bindings::drm_gpuva_unlink_defer(self.op.va) };
+
+        // SAFETY: We just removed this va from the `GpuVm<T>`.
+        let va = unsafe { GpuVaRemoved::from_raw(self.op.va) };
+
+        (
+            OpUnmapped {
+                _invariant: self._invariant,
+            },
+            va,
+        )
+    }
+}
+
+/// Represents a completed [`OpUnmap`] operation.
+pub struct OpUnmapped<'op, T> {
+    _invariant: PhantomData<*mut &'op mut T>,
+}
+
+/// Represents an `sm_step_remap` operation that has not yet been completed.
+pub struct OpRemap<'op, T: DriverGpuVm> {
+    op: &'op bindings::drm_gpuva_op_remap,
+    // This ensures that 'op is invariant, so that `OpRemap<'long, T>` does not
+    // coerce to `OpRemap<'short, T>`. This ensures that the user can't return the
+    // wrong`OpRemapped` value.
+    _invariant: PhantomData<*mut &'op mut T>,
+}
+
+impl<'op, T: DriverGpuVm> OpRemap<'op, T> {
+    /// The preceding part of a split mapping.
+    #[inline]
+    pub fn prev(&self) -> Option<&OpRemapMapData> {
+        // SAFETY: We checked for null, so the pointer must be valid.
+        NonNull::new(self.op.prev).map(|ptr| unsafe { OpRemapMapData::from_raw(ptr) })
+    }
+
+    /// The subsequent part of a split mapping.
+    #[inline]
+    pub fn next(&self) -> Option<&OpRemapMapData> {
+        // SAFETY: We checked for null, so the pointer must be valid.
+        NonNull::new(self.op.next).map(|ptr| unsafe { OpRemapMapData::from_raw(ptr) })
+    }
+
+    /// Indicates whether the `drm_gpuva` being removed is physically contiguous with the original
+    /// mapping request.
+    ///
+    /// Optionally, if `keep` is set, drivers may keep the actual page table mappings for this
+    /// `drm_gpuva`, adding the missing page table entries only and update the `drm_gpuvm`
+    /// accordingly.
+    #[inline]
+    pub fn keep(&self) -> bool {
+        // SAFETY: The unmap pointer is always valid.
+        unsafe { (*self.op.unmap).keep }
+    }
+
+    /// The range being unmapped.
+    #[inline]
+    pub fn va_to_unmap(&self) -> &GpuVa<T> {
+        // SAFETY: This is a valid va. It's not the `kernel_alloc_node` because you can't unmap it,
+        // and it's not sparse by the `GpuVm<T>` type invariants.
+        unsafe { GpuVa::<T>::from_raw((*self.op.unmap).va) }
+    }
+
+    /// The [`drm_gem_object`](DriverGpuVm::Object) whose VA is being remapped.
+    #[inline]
+    pub fn obj(&self) -> &T::Object {
+        self.va_to_unmap().obj()
+    }
+
+    /// The [`GpuVmBo`] that is being remapped.
+    #[inline]
+    pub fn vm_bo(&self) -> &GpuVmBo<T> {
+        self.va_to_unmap().vm_bo()
+    }
+
+    /// Update the GPUVM to perform the remapping.
+    pub fn remap(
+        self,
+        va_alloc: [GpuVaAlloc<T>; 2],
+        prev_data: impl PinInit<T::VaData>,
+        next_data: impl PinInit<T::VaData>,
+    ) -> (OpRemapped<'op, T>, OpRemapRet<T>) {
+        let [va1, va2] = va_alloc;
+
+        let mut unused_va = None;
+        let mut prev_ptr = ptr::null_mut();
+        let mut next_ptr = ptr::null_mut();
+        if self.prev().is_some() {
+            prev_ptr = va1.prepare(prev_data);
+        } else {
+            unused_va = Some(va1);
+        }
+        if self.next().is_some() {
+            next_ptr = va2.prepare(next_data);
+        } else {
+            unused_va = Some(va2);
+        }
+
+        // SAFETY: the pointers are non-null when required
+        unsafe { bindings::drm_gpuva_remap(prev_ptr, next_ptr, self.op) };
+
+        let gpuva_guard = self.vm_bo().lock_gpuva();
+        if !prev_ptr.is_null() {
+            // SAFETY: The prev_ptr is a valid drm_gpuva prepared for insertion. The vm_bo is still
+            // valid as the not-yet-unlinked gpuva holds a refcount on the vm_bo.
+            unsafe { bindings::drm_gpuva_link(prev_ptr, self.vm_bo().as_raw()) };
+        }
+        if !next_ptr.is_null() {
+            // SAFETY: The next_ptr is a valid drm_gpuva prepared for insertion. The vm_bo is still
+            // valid as the not-yet-unlinked gpuva holds a refcount on the vm_bo.
+            unsafe { bindings::drm_gpuva_link(next_ptr, self.vm_bo().as_raw()) };
+        }
+        drop(gpuva_guard);
+
+        // SAFETY: The va is no longer in the interval tree so we may unlink it.
+        unsafe { bindings::drm_gpuva_unlink_defer((*self.op.unmap).va) };
+
+        (
+            OpRemapped {
+                _invariant: self._invariant,
+            },
+            OpRemapRet {
+                // SAFETY: We just removed this va from the `GpuVm<T>`.
+                unmapped_va: unsafe { GpuVaRemoved::from_raw((*self.op.unmap).va) },
+                unused_va,
+            },
+        )
+    }
+}
+
+/// Part of an [`OpRemap`] that represents a new mapping.
+#[repr(transparent)]
+pub struct OpRemapMapData(bindings::drm_gpuva_op_map);
+
+impl OpRemapMapData {
+    /// # Safety
+    /// Must reference a valid `drm_gpuva_op_map` for duration of `'a`.
+    unsafe fn from_raw<'a>(ptr: NonNull<bindings::drm_gpuva_op_map>) -> &'a Self {
+        // SAFETY: ok per safety requirements
+        unsafe { ptr.cast().as_ref() }
+    }
+
+    /// The base address of the new mapping.
+    pub fn addr(&self) -> u64 {
+        self.0.va.addr
+    }
+
+    /// The length of the new mapping.
+    pub fn length(&self) -> u64 {
+        self.0.va.range
+    }
+
+    /// The offset within the [`drm_gem_object`](DriverGpuVm::Object).
+    pub fn gem_offset(&self) -> u64 {
+        self.0.gem.offset
+    }
+}
+
+/// Struct containing objects removed or not used by [`OpRemap::remap`].
+pub struct OpRemapRet<T: DriverGpuVm> {
+    /// The `drm_gpuva` that was removed.
+    pub unmapped_va: GpuVaRemoved<T>,
+    /// If the remap did not split the region into two pieces, then the unused `drm_gpuva` is
+    /// returned here.
+    pub unused_va: Option<GpuVaAlloc<T>>,
+}
+
+/// Represents a completed [`OpRemap`] operation.
+pub struct OpRemapped<'op, T> {
+    _invariant: PhantomData<*mut &'op mut T>,
+}
+
+impl<T: DriverGpuVm> UniqueRefGpuVm<T> {
+    /// Remove any mappings in the given region.
+    ///
+    /// Internally calls [`DriverGpuVm::sm_step_unmap`] for ranges entirely contained within the
+    /// given range, and [`DriverGpuVm::sm_step_remap`] for ranges that overlap with the range.
+    #[inline]
+    pub fn sm_unmap(&mut self, addr: u64, length: u64, context: &mut T::SmContext<'_>) -> Result {
+        let gpuvm = self.as_raw();
+        let mut p = SmData {
+            gpuvm: self,
+            user_context: context,
+        };
+        // SAFETY:
+        // * raw_request() creates a valid request.
+        // * The private data is valid to be interpreted as SmData.
+        to_result(unsafe { bindings::drm_gpuvm_sm_unmap(gpuvm, (&raw mut p).cast(), addr, length) })
+    }
+}
+
+impl<T: DriverGpuVm> GpuVm<T> {
+    /// # Safety
+    /// Must be called from `sm_unmap` with a pointer to `SmData`.
+    pub(super) unsafe extern "C" fn sm_step_unmap(
+        op: *mut bindings::drm_gpuva_op,
+        p: *mut c_void,
+    ) -> c_int {
+        // SAFETY: The caller provides a pointer to `SmData`.
+        let p = unsafe { &mut *p.cast::<SmData<'_, '_, T>>() };
+        let op = OpUnmap {
+            // SAFETY: sm_step_unmap is called with an unmap operation.
+            op: unsafe { &(*op).__bindgen_anon_1.unmap },
+            _invariant: PhantomData,
+        };
+        match p.gpuvm.data().sm_step_unmap(op, p.user_context) {
+            Ok(OpUnmapped { .. }) => 0,
+            Err(err) => err.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// Must be called from `sm_unmap` with a pointer to `SmData`.
+    pub(super) unsafe extern "C" fn sm_step_remap(
+        op: *mut bindings::drm_gpuva_op,
+        p: *mut c_void,
+    ) -> c_int {
+        // SAFETY: The caller provides a pointer to `SmData`.
+        let p = unsafe { &mut *p.cast::<SmData<'_, '_, T>>() };
+        let op = OpRemap {
+            // SAFETY: sm_step_remap is called with a remap operation.
+            op: unsafe { &(*op).__bindgen_anon_1.remap },
+            _invariant: PhantomData,
+        };
+        match p.gpuvm.data().sm_step_remap(op, p.user_context) {
+            Ok(OpRemapped { .. }) => 0,
+            Err(err) => err.to_errno(),
+        }
+    }
+}
diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
index 227c259f7db9..0b09fe44ab39 100644
--- a/rust/kernel/drm/gpuvm/va.rs
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 
-#![expect(dead_code)]
 use super::*;
 
 /// Represents that a range of a GEM object is mapped in this [`GpuVm`] instance.
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
index 05fd7998f4bd..c064ac63897b 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -144,6 +144,14 @@ pub fn obj(&self) -> &T::Object {
     pub fn data(&self) -> &T::VmBoData {
         &self.data
     }
+
+    pub(super) fn lock_gpuva(&self) -> crate::sync::MutexGuard<'_, ()> {
+        // SAFETY: The GEM object is valid.
+        let ptr = unsafe { &raw mut (*self.obj().as_raw()).gpuva.lock };
+        // SAFETY: The GEM object is valid, so the mutex is properly initialized.
+        let mutex = unsafe { crate::sync::Mutex::from_raw(ptr) };
+        mutex.lock()
+    }
 }
 
 /// A pre-allocated [`GpuVmBo`] object.

-- 
2.53.0.1213.gd9a14994de-goog

