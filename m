Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6E6F31E28
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1362B10E821;
	Thu,  9 Apr 2026 15:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fzrBwc0U";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7018510E822
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:26:25 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-488be33b7a6so8423025e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775748384; x=1776353184;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hFJ1KsbIXhy8rx1cz/BnphR0Bwoj8EJEYS1k3FyY134=;
 b=fzrBwc0UNBbWCwmJi/LSToVQVD8IX9V1qQKjZ59qJXXr7xljNWHwMGoDoqaC82TEOi
 YI2j7aC5Bf/qjKtfTKTY7LfiKbvLjkb78MWYbgrHt8Z2Xemtg6GdoA4LieEZSyHTuRsI
 qjjfDkSC6Mt9NjlQuMWuFtJuqvtky5SL5impjLKwkT4ZOu562pn2svxF3HC+UqcYIA4+
 dyXKE1xLohhocmGvaR2XaCPeM8RPwBlvzLiVAATKtpBDR7wWIczUZBZmgrP08hcA7BBu
 0S6G9wNBV9VvtSCy2F9yyKBQ/vYxmUssLX7QO/lWWQ2GzBWpMmUwj/A8Kkcsd+ya7mO9
 CqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775748384; x=1776353184;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hFJ1KsbIXhy8rx1cz/BnphR0Bwoj8EJEYS1k3FyY134=;
 b=WSFUfAkS17zWnfLiIHUg4bQvJj9RIDgAOBkYlMEUDBU1q8UrT051kUAXzHICLXYepN
 Hfsu4B94ophw9D8cIoizLigZ99poloZB5U+ZeQZdJVqK6UEtEgyG+KSmSa4xKA9vXTRl
 bT/HFztnvUJM4ki8f3V/DcVlVfqNse+49oKCWFtV0ULys8CfryhRZY9Q8DfKgWYLDlNB
 rqydMBOHz/LMCDqTYauURlmG24qgpCeRXRJdX+8dszoZA/t+gW8lPZoxcc76TqI0rZfs
 2cknk/Q4U34uFSqF0fJK72As+E/Tuum8mCRjwFJvGBaeCi9JaHAQYjEpGw+c1OzakgVv
 r1QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbIFlnbuN6Y+mfihpFnzQnykSFOvp6K7D8Pihp3IXasJXak3IlfeewodnOsFTksFB1ioWnE3josX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxHV8iKm7H/RUu+Vvwi+eQIlQYKsorCTHSB9vucwSplA0Y1qvF
 W/6/crYg42WDGG4gPp+qVTdQ12nQtB5rH8DiU5gjbYDwhrypOx9maWZrNwhYujTJ4MgcMrDM+nd
 uZsWWAZmcu4Yes25QmQ==
X-Received: from wrbgl27-n2.prod.google.com
 ([2002:a05:6000:299b:20b0:43c:f8a2:96a5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1d:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-4889977600bmr347224445e9.15.1775748383869; 
 Thu, 09 Apr 2026 08:26:23 -0700 (PDT)
Date: Thu, 09 Apr 2026 15:26:10 +0000
In-Reply-To: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
Mime-Version: 1.0
References: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9988; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=zt4LPgEp/Y1M8Naq1Vpctg8BC24Qm5hP/wZncaeqwu4=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp18UXBxDUIwi4bYaDXeeInwGWa38rJJmBQ0V/q
 Y9iAYYdLJqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadfFFwAKCRAEWL7uWMY5
 RqoBEACmNL866m/jhSVtFlJnvTwwVOK2r6pWSCLmciJKNB33T4A6sb7XOYJ91yjA4th6DuMAz3n
 UJJ5EP6oQ02DcwrPfoGuaviyACW712e91/UZl6FGhMF5EjHc3RFRHCt4z/Jx9tPQPvkGLSX0Mpt
 SI0lBOvzO55JEduXPjEKu6RqBeK8kmjcyiQopiVBQ8Se8b3oZEoHVH2ZbIp75HBTbx5wXzb/Vz8
 /5igmgYWeXKJpl4wrFhVv7J3wCZgW0NmitLtsV2Cc0mMwHVIyqNVJgjkO4Q++OVDAmsnhFeRjL3
 YO7lUszRaBe0ITUnjcNNP6oF6e6XNblrRU70SYZvn22Skhmeb4bI7pXRJP8lHe2tNF8YV2dykHB
 wsZ4h7u4Ji1ZtR5ycBlounzxcxJtIvDrqk+QUj2hZC/ivbOFxQfpcQIdLa68uvMQ4Y64t+lGqxe
 L8yUNH/P42A5X3+4Y4mKj/q419f5huYetIFXSqKVsXkwG+hS2KBmS0cas2c7eYqUOX2VjpN7E3D
 QZw1sb6Iwq6P3pykYaemlqZegrBdMMVk95oIeZvHDaqGB4u8T/BTPzPjgK6eWsVDaVgjPqzVqjo
 P2xBatBbY/xuzKQnUy2BLLLycTHqx1jv1g6KANZ34fpDYrCXp77pkG97pnuPyTt21KmUFUKd06I
 rvO6i5B+gTQeimg==
X-Mailer: b4 0.14.3
Message-ID: <20260409-gpuvm-rust-v6-5-b16e6ada7261@google.com>
Subject: [PATCH v6 5/5] rust: gpuvm: add GpuVmCore::sm_map()
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

Finally also add the operation for creating new mappings. Mapping
operations need extra data in the context since they involve a vm_bo
coming from the outside.

Co-developed-by: Asahi Lina <lina+kernel@asahilina.net>
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/gpuvm/mod.rs    |   9 ++-
 rust/kernel/drm/gpuvm/sm_ops.rs | 167 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 170 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index a6436abd0f9c..dc755f248143 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -108,7 +108,7 @@ const fn vtable() -> &'static bindings::drm_gpuvm_ops {
             vm_bo_alloc: GpuVmBo::<T>::ALLOC_FN,
             vm_bo_free: GpuVmBo::<T>::FREE_FN,
             vm_bo_validate: None,
-            sm_step_map: None,
+            sm_step_map: Some(Self::sm_step_map),
             sm_step_unmap: Some(Self::sm_step_unmap),
             sm_step_remap: Some(Self::sm_step_remap),
         }
@@ -266,6 +266,13 @@ pub trait DriverGpuVm: Sized + Send {
     /// The private data passed to callbacks.
     type SmContext<'ctx>;
 
+    /// Indicates that a new mapping should be created.
+    fn sm_step_map<'op, 'ctx>(
+        &mut self,
+        op: OpMap<'op, Self>,
+        context: &mut Self::SmContext<'ctx>,
+    ) -> Result<OpMapped<'op, Self>, Error>;
+
     /// Indicates that an existing mapping should be removed.
     fn sm_step_unmap<'op, 'ctx>(
         &mut self,
diff --git a/rust/kernel/drm/gpuvm/sm_ops.rs b/rust/kernel/drm/gpuvm/sm_ops.rs
index 05f81c638aef..69a8e5ab2821 100644
--- a/rust/kernel/drm/gpuvm/sm_ops.rs
+++ b/rust/kernel/drm/gpuvm/sm_ops.rs
@@ -8,6 +8,108 @@ struct SmData<'a, 'ctx, T: DriverGpuVm> {
     user_context: &'a mut T::SmContext<'ctx>,
 }
 
+/// Adds an extra field to `SmData` for `sm_map()` callbacks.
+///
+/// # Invariants
+///
+/// `self.vm_bo.gpuvm() == self.sm_data.gpuvm`.
+#[repr(C)]
+struct SmMapData<'a, 'ctx, T: DriverGpuVm> {
+    sm_data: SmData<'a, 'ctx, T>,
+    vm_bo: &'a GpuVmBo<T>,
+}
+
+/// The argument for [`UniqueRefGpuVm::sm_map`].
+pub struct OpMapRequest<'a, 'ctx, T: DriverGpuVm> {
+    /// Address in GPU virtual address space.
+    pub addr: u64,
+    /// Length of mapping to create.
+    pub range: u64,
+    /// Offset in GEM object.
+    pub gem_offset: u64,
+    /// The GEM object to map.
+    pub vm_bo: &'a GpuVmBo<T>,
+    /// The user-provided context type.
+    pub context: &'a mut T::SmContext<'ctx>,
+}
+
+impl<'a, 'ctx, T: DriverGpuVm> OpMapRequest<'a, 'ctx, T> {
+    fn raw_request(&self) -> bindings::drm_gpuvm_map_req {
+        bindings::drm_gpuvm_map_req {
+            map: bindings::drm_gpuva_op_map {
+                va: bindings::drm_gpuva_op_map__bindgen_ty_1 {
+                    addr: self.addr,
+                    range: self.range,
+                },
+                gem: bindings::drm_gpuva_op_map__bindgen_ty_2 {
+                    offset: self.gem_offset,
+                    obj: self.vm_bo.obj().as_raw(),
+                },
+            },
+        }
+    }
+}
+
+/// Represents an `sm_step_map` operation that has not yet been completed.
+pub struct OpMap<'op, T: DriverGpuVm> {
+    op: &'op bindings::drm_gpuva_op_map,
+    // Since these abstractions are designed for immediate mode, the VM BO needs to be
+    // pre-allocated, so we always have it available when we reach this point.
+    vm_bo: &'op GpuVmBo<T>,
+    // This ensures that 'op is invariant, so that `OpMap<'long, T>` does not
+    // coerce to `OpMap<'short, T>`. This ensures that the user can't return
+    // the wrong `OpMapped` value.
+    _invariant: PhantomData<*mut &'op mut T>,
+}
+
+impl<'op, T: DriverGpuVm> OpMap<'op, T> {
+    /// The base address of the new mapping.
+    pub fn addr(&self) -> u64 {
+        self.op.va.addr
+    }
+
+    /// The length of the new mapping.
+    pub fn length(&self) -> u64 {
+        self.op.va.range
+    }
+
+    /// The offset within the [`drm_gem_object`](DriverGpuVm::Object).
+    pub fn gem_offset(&self) -> u64 {
+        self.op.gem.offset
+    }
+
+    /// The [`drm_gem_object`](DriverGpuVm::Object) to map.
+    pub fn obj(&self) -> &T::Object {
+        // SAFETY: The `obj` pointer is guaranteed to be valid.
+        unsafe { <T::Object as IntoGEMObject>::from_raw(self.op.gem.obj) }
+    }
+
+    /// The [`GpuVmBo`] that the new VA will be associated with.
+    pub fn vm_bo(&self) -> &GpuVmBo<T> {
+        self.vm_bo
+    }
+
+    /// Use the pre-allocated VA to carry out this map operation.
+    pub fn insert(self, va: GpuVaAlloc<T>, va_data: impl PinInit<T::VaData>) -> OpMapped<'op, T> {
+        let va = va.prepare(va_data);
+        // SAFETY: By the type invariants we may access the interval tree.
+        unsafe { bindings::drm_gpuva_map(self.vm_bo.gpuvm().as_raw(), va, self.op) };
+
+        let _gpuva_guard = self.vm_bo().lock_gpuva();
+        // SAFETY: The va is prepared for insertion, and we hold the GEM lock.
+        unsafe { bindings::drm_gpuva_link(va, self.vm_bo.as_raw()) };
+
+        OpMapped {
+            _invariant: self._invariant,
+        }
+    }
+}
+
+/// Represents a completed [`OpMap`] operation.
+pub struct OpMapped<'op, T> {
+    _invariant: PhantomData<*mut &'op mut T>,
+}
+
 /// Represents an `sm_step_unmap` operation that has not yet been completed.
 pub struct OpUnmap<'op, T: DriverGpuVm> {
     op: &'op bindings::drm_gpuva_op_unmap,
@@ -213,6 +315,35 @@ pub struct OpRemapped<'op, T> {
 }
 
 impl<T: DriverGpuVm> UniqueRefGpuVm<T> {
+    /// Create a mapping, removing or remapping anything that overlaps.
+    ///
+    /// Internally calls the [`DriverGpuVm`] callbacks similar to [`Self::sm_unmap`], except that
+    /// the [`DriverGpuVm::sm_step_map`] is called once to create the requested mapping.
+    #[inline]
+    pub fn sm_map(&mut self, req: OpMapRequest<'_, '_, T>) -> Result {
+        if req.vm_bo.gpuvm() != &**self {
+            return Err(EINVAL);
+        }
+
+        let gpuvm = self.as_raw();
+        let raw_req = req.raw_request();
+        // INVARIANT: Checked above that `vm_bo.gpuvm() == self`.
+        let mut p = SmMapData {
+            sm_data: SmData {
+                gpuvm: self,
+                user_context: req.context,
+            },
+            vm_bo: req.vm_bo,
+        };
+        // SAFETY:
+        // * raw_request() creates a valid request.
+        // * The private data is valid to be interpreted as both SmData and SmMapData since the
+        //   first field of SmMapData is SmData.
+        to_result(unsafe {
+            bindings::drm_gpuvm_sm_map(gpuvm, (&raw mut p).cast(), &raw const raw_req)
+        })
+    }
+
     /// Remove any mappings in the given region.
     ///
     /// Internally calls [`DriverGpuVm::sm_step_unmap`] for ranges entirely contained within the
@@ -226,19 +357,45 @@ pub fn sm_unmap(&mut self, addr: u64, length: u64, context: &mut T::SmContext<'_
         };
         // SAFETY:
         // * raw_request() creates a valid request.
-        // * The private data is valid to be interpreted as SmData.
+        // * The private data is a valid SmData.
         to_result(unsafe { bindings::drm_gpuvm_sm_unmap(gpuvm, (&raw mut p).cast(), addr, length) })
     }
 }
 
 impl<T: DriverGpuVm> GpuVm<T> {
     /// # Safety
-    /// Must be called from `sm_unmap` with a pointer to `SmData`.
+    /// Must be called from `sm_map` with a pointer to `SmMapData`.
+    pub(super) unsafe extern "C" fn sm_step_map(
+        op: *mut bindings::drm_gpuva_op,
+        p: *mut c_void,
+    ) -> c_int {
+        // SAFETY: If we reach `sm_step_map` then we were called from `sm_map` which always passes
+        // an `SmMapData` as private data.
+        let p = unsafe { &mut *p.cast::<SmMapData<'_, '_, T>>() };
+        let op = OpMap {
+            // SAFETY: sm_step_map is called with a map operation.
+            op: unsafe { &(*op).__bindgen_anon_1.map },
+            vm_bo: p.vm_bo,
+            _invariant: PhantomData,
+        };
+        match p
+            .sm_data
+            .gpuvm
+            .data()
+            .sm_step_map(op, p.sm_data.user_context)
+        {
+            Ok(OpMapped { .. }) => 0,
+            Err(err) => err.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// Must be called from `sm_map` or `sm_unmap` with a pointer to `SmMapData` or `SmData`.
     pub(super) unsafe extern "C" fn sm_step_unmap(
         op: *mut bindings::drm_gpuva_op,
         p: *mut c_void,
     ) -> c_int {
-        // SAFETY: The caller provides a pointer to `SmData`.
+        // SAFETY: The caller provides a pointer that can be treated as `SmData`.
         let p = unsafe { &mut *p.cast::<SmData<'_, '_, T>>() };
         let op = OpUnmap {
             // SAFETY: sm_step_unmap is called with an unmap operation.
@@ -252,12 +409,12 @@ impl<T: DriverGpuVm> GpuVm<T> {
     }
 
     /// # Safety
-    /// Must be called from `sm_unmap` with a pointer to `SmData`.
+    /// Must be called from `sm_map` or `sm_unmap` with a pointer to `SmMapData` or `SmData`.
     pub(super) unsafe extern "C" fn sm_step_remap(
         op: *mut bindings::drm_gpuva_op,
         p: *mut c_void,
     ) -> c_int {
-        // SAFETY: The caller provides a pointer to `SmData`.
+        // SAFETY: The caller provides a pointer that can be treated as `SmData`.
         let p = unsafe { &mut *p.cast::<SmData<'_, '_, T>>() };
         let op = OpRemap {
             // SAFETY: sm_step_remap is called with a remap operation.

-- 
2.53.0.1213.gd9a14994de-goog

