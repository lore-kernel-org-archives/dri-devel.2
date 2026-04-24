Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3012FF885E
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0C210F709;
	Fri, 24 Apr 2026 23:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="GEZ2N3b2";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACA310F6FD
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073971; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q8vN/+ThAcpOZe824iUfQdMVdaVI6DTRFsO/6/HzULl8QYdvRvS2gIyv9Qhq8wPyXtEQ4o0rnkxqW349CRt2ZuHxhHvJxtYT4WSpALuhnAyT9G8hSQEOGwsaUv1ee6swMmql/aQnXNnjLKCZNvV3AvMObLyZ3iIPMHJn8DqJNWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073971;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RUqLI28yo3oTGrENvimVHEDD6lDvBVJ/RxaKotmgahE=; 
 b=XYKuvA3tJrDVcVOYOBa356KGzcUSqfbJoXfW22FvdJegX1d7F6Dx9bXVZ3+auyPbDgXihmprYdvUPs+MRS5EeN0X0n5QltfBvcDWGJgsCGhr55aNdZhVSWjbhv8/nZq+b0hGxLC6VGLYKKuYHL9EssNCOVS+u6ZElmzqw/1q4k8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073971; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=RUqLI28yo3oTGrENvimVHEDD6lDvBVJ/RxaKotmgahE=;
 b=GEZ2N3b2DmX40vgOwfNgui/KE2/ysBqDSNpZCKU1P+XtJhEz64Pp+ARmHfVhZTXQ
 MZADOCtNUeBSqFl4IlIjnY2uBC3sbUyDzoWHy2iEoEbw7PX0Msbg6Kb8+YK0epfjWaF
 Qv8cfz29yzszczrt6rcMtkORrWepm6dAxNvLWdMc=
Received: by mx.zohomail.com with SMTPS id 1777073969000380.8615097673767;
 Fri, 24 Apr 2026 16:39:29 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:05 -0700
Subject: [PATCH v4 11/20] drm/tyr: add a kernel buffer object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-11-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5962;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=rurOKa1tcEIzVJaZcuiDfiEdNQDEfvlVGxqqYMOCT8g=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/ys8fmYtvjdVcp2+7YeAu3xtjb57WqvMGYInKGz66
 a11l9e/o5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIkIFjD8r3ixQUc27fVjEdPO
 QM2f2s1TXQt4L6h3hc2tcP5guzHlLMP/zP/rVl0S+7mL7e4vflZFo76DDX8C2xMdeo1U5oX9Oaf
 KAQA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Introduce a buffer object type (KernelBo) for internal driver allocations
that are managed by the kernel rather than userspace.

KernelBo wraps a GEM shmem object and automatically handles GPU virtual
address space mapping during creation and unmapping on drop. This provides
a safe and convenient way for the driver to both allocate and clean up
internal buffers for kernel-managed resources.

Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/gem.rs | 124 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 111acf33993f..d032a8ae543f 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -4,6 +4,8 @@
 //! This module provides buffer object (BO) management functionality using
 //! DRM's GEM subsystem with shmem backing.
 
+use core::ops::Range;
+
 use kernel::{
     drm::{
         gem,
@@ -11,23 +13,41 @@
         DeviceContext, //
     },
     prelude::*,
-    sync::aref::ARef, //
+    sync::{
+        aref::ARef,
+        Arc,
+        ArcBorrow, //
+    },
 };
 
-use crate::driver::{
-    TyrDrmDevice,
-    TyrDrmDriver, //
+use crate::{
+    driver::{
+        TyrDrmDevice,
+        TyrDrmDriver, //
+    },
+    vm::{
+        Vm,
+        VmMapFlags, //
+    },
 };
 
-/// Tyr's DriverObject type for GEM objects.
+/// Driver-specific data for Tyr GEM buffer objects.
+///
+/// This structure contains Tyr-specific metadata associated with each GEM object.
+/// It implements [`gem::DriverObject`] to provide driver-specific behavior for
+/// buffer object creation and management.
 #[pin_data]
 pub(crate) struct BoData {
+    /// Buffer object creation flags (currently unused).
     flags: u32,
 }
 
-/// Provides a way to pass arguments when creating BoData
-/// as required by the gem::DriverObject trait.
+/// Arguments for creating a [`BoData`] instance.
+///
+/// This structure is used to pass creation parameters when instantiating
+/// a new buffer object, as required by the [`gem::DriverObject`] trait.
 pub(crate) struct BoCreateArgs {
+    /// Buffer object creation flags (currently unused).
     flags: u32,
 }
 
@@ -35,6 +55,12 @@ impl gem::DriverObject for BoData {
     type Driver = TyrDrmDriver;
     type Args = BoCreateArgs;
 
+    /// Constructs a new [`BoData`] instance for a GEM object.
+    ///
+    /// This function is called by the GEM subsystem when creating a new buffer
+    /// object. It initializes the driver-specific data with the provided flags.
+    /// The device and size parameters are currently unused but required by the
+    /// [`gem::DriverObject`] trait.
     fn new<Ctx: DeviceContext>(
         _dev: &TyrDrmDevice<Ctx>,
         _size: usize,
@@ -61,3 +87,87 @@ pub(crate) fn new_dummy_object<Ctx: DeviceContext>(ddev: &TyrDrmDevice<Ctx>) ->
 
     Ok(bo)
 }
+
+/// VA allocation strategy for kernel buffer objects.
+///
+/// Specifies how the GPU virtual address should be determined when creating
+/// a [`KernelBo`]. An automatic VA allocation strategy will be added in the future.
+pub(crate) enum KernelBoVaAlloc {
+    /// Explicit VA address specified by the caller.
+    #[expect(dead_code)]
+    Explicit(u64),
+}
+
+/// A kernel-owned buffer object with automatic GPU virtual address mapping.
+///
+/// This structure represents a buffer object that is created and managed entirely
+/// by the kernel driver, as opposed to userspace-created GEM objects. It combines
+/// a GEM object with automatic GPU virtual address (VA) space mapping and cleanup.
+///
+/// When dropped, the buffer is automatically unmapped from the GPU VA space.
+pub(crate) struct KernelBo {
+    /// The underlying GEM buffer object.
+    #[expect(dead_code)]
+    pub(crate) bo: ARef<Bo>,
+    /// The GPU VM this buffer is mapped into.
+    vm: Arc<Vm>,
+    /// The GPU VA range occupied by this buffer.
+    va_range: Range<u64>,
+}
+
+impl KernelBo {
+    /// Creates a new kernel-owned buffer object and maps it into GPU VA space.
+    ///
+    /// This function allocates a new shmem-backed GEM object and immediately maps
+    /// it into the specified GPU virtual memory space. The mapping is automatically
+    /// cleaned up when the [`KernelBo`] is dropped.
+    #[expect(dead_code)]
+    pub(crate) fn new<Ctx: DeviceContext>(
+        ddev: &TyrDrmDevice<Ctx>,
+        vm: ArcBorrow<'_, Vm>,
+        size: u64,
+        va_alloc: KernelBoVaAlloc,
+        flags: VmMapFlags,
+    ) -> Result<Self> {
+        if size == 0 {
+            pr_err!("Cannot create KernelBo with size 0\n");
+            return Err(EINVAL);
+        }
+
+        let KernelBoVaAlloc::Explicit(va) = va_alloc;
+
+        let bo = gem::shmem::Object::<BoData>::new(
+            ddev,
+            size as usize,
+            shmem::ObjectConfig {
+                map_wc: true,
+                parent_resv_obj: None,
+            },
+            BoCreateArgs { flags: 0 },
+        )?;
+
+        vm.map_bo_range(&bo, 0, size, va, flags)?;
+
+        Ok(KernelBo {
+            bo,
+            vm: vm.into(),
+            va_range: va..(va + size),
+        })
+    }
+}
+
+impl Drop for KernelBo {
+    fn drop(&mut self) {
+        let va = self.va_range.start;
+        let size = self.va_range.end - self.va_range.start;
+
+        if let Err(e) = self.vm.unmap_range(va, size) {
+            pr_err!(
+                "Failed to unmap KernelBo range {:#x}..{:#x}: {:?}\n",
+                self.va_range.start,
+                self.va_range.end,
+                e
+            );
+        }
+    }
+}

-- 
2.53.0

