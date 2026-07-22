Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD737C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 23:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1615410E3CB;
	Wed, 22 Jul 2026 23:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="JPPKgPRv";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C11310E358
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784764460; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=heaV99LMyhzEh3hIfmThoe4UCy3EVNS/zg8Yu/YUGFYlXNEfHQw++0LMSncTOzI4jzHmxhmzEghOkwbEImbWRCUm6bxUGecz4Q+nkGyiYTdKCS8y3z780RnFsGv3lepC8p0AmcCUeqxZC0z4t6+X5+f8nDKDfkcxpi6QQWGv1Ys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784764460;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kPxZcOCFJQSkWCGVRwm4EoZkxurlyOvE1JwNp6QWYAw=; 
 b=HTki6I9oS5S3Cy3QG5eY2nEGfEWtuLfR8JMmuxHWoy74q07D+9F+m+IRygllNV+bd0D7bwE4mqX0EkMjOuSdjfXn2Qw5k7JiYt1EvqAelzFqk2DEydiY7OJl5lwDS5qVnaU6h1pw78rgwRgJ0x83hjZk6im/mv4uHhdapaJYKX4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784764460; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=kPxZcOCFJQSkWCGVRwm4EoZkxurlyOvE1JwNp6QWYAw=;
 b=JPPKgPRv2/nFwfhn/E4jtQgLJnGC8Rgq8FTfU1ZB8v/rjLzf4rZZ+nurlJyT6q08
 VAkgBTcr1B7gahc6uZLpPx3Q3RSRkIK+OGlogIKbazTJF9Edk3uHbRKuPZzsMAesjxP
 1j9HRmTkvmePSetvWxbRdrih42JkcpQsqF7hhKOU=
Received: by mx.zohomail.com with SMTPS id 1784764458290601.0817471702306;
 Wed, 22 Jul 2026 16:54:18 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 22 Jul 2026 16:54:11 -0700
Subject: [PATCH v9 5/7] drm/tyr: add a kernel buffer object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-fw-boot-b4-v9-5-8669d2a02590@collabora.com>
References: <20260722-fw-boot-b4-v9-0-8669d2a02590@collabora.com>
In-Reply-To: <20260722-fw-boot-b4-v9-0-8669d2a02590@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, samitolvanen@google.com, 
 lyude@redhat.com, boris.brezillon@collabora.com, steven.price@arm.com, 
 alvin.sun@linux.dev, laura.nao@collabora.com, beata.michalska@arm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4887;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=zHbLWiZ8WMuIDU4aejBoOrp0PLyfIMFgjgGvjWHbUzM=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmJEcrS5+4kzto2b3LDwy+pJwvaXb86VB1ZF+vzPLJ7/
 yxBZ9NXHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAEzERp+R4X2n2rTtEz/qfd1S
 +ljqt/uEmXPWnf2aFfnMUspSWdPmiQ4jw7KrBhItn6+LJyjrdnlMZom6IJr1/A3PvW6hba+Vmp4
 e4AUA
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
 drivers/gpu/drm/tyr/gem.rs | 113 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index c28be61a01bb..b371299028d6 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -4,18 +4,29 @@
 //! This module provides buffer object (BO) management functionality using
 //! DRM's GEM subsystem with shmem backing.
 
+use core::ops::Range;
+
 use kernel::{
     drm::gem::{
         self,
         shmem, //
     },
     prelude::*,
-    sync::aref::ARef, //
+    sync::{
+        aref::ARef,
+        Arc, //
+    }, //
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
 
 /// Tyr's DriverObject type for GEM objects.
@@ -56,3 +67,97 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> Result<ARef<Bo>> {
 
     Ok(bo)
 }
+
+/// Specifies how to choose a GPU virtual address for a [`KernelBo`].
+/// An automatic VA allocation strategy will be added in the future.
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
+pub(crate) struct KernelBo<'bound> {
+    /// The underlying GEM buffer object.
+    bo: ARef<Bo>,
+    /// The GPU VM this buffer is mapped into.
+    vm: Arc<Vm<'bound>>,
+    /// The GPU VA range occupied by this buffer.
+    va_range: Range<u64>,
+}
+
+impl<'bound> KernelBo<'bound> {
+    /// Creates a new kernel-owned buffer object and maps it into GPU VA space.
+    ///
+    /// This function allocates a new shmem-backed GEM object and immediately maps
+    /// it into the specified GPU virtual memory space. The mapping is automatically
+    /// cleaned up when the [`KernelBo`] is dropped.
+    #[expect(dead_code)]
+    pub(crate) fn new(
+        ddev: &TyrDrmDevice,
+        vm: Arc<Vm<'bound>>,
+        size: u64,
+        va_alloc: KernelBoVaAlloc,
+        flags: VmMapFlags,
+    ) -> Result<Self> {
+        if size == 0 {
+            dev_err!(vm.dev(), "Cannot create KernelBo with size 0");
+            return Err(EINVAL);
+        }
+
+        let KernelBoVaAlloc::Explicit(va) = va_alloc;
+
+        let bo_size = usize::try_from(size).map_err(|_| EOVERFLOW)?;
+        let va_end = va.checked_add(size).ok_or(EINVAL)?;
+
+        let bo = Bo::new(
+            ddev,
+            bo_size,
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
+            vm,
+            va_range: va..va_end,
+        })
+    }
+
+    #[expect(dead_code)]
+    pub(crate) fn bo(&self) -> &Bo {
+        &self.bo
+    }
+}
+
+impl Drop for KernelBo<'_> {
+    fn drop(&mut self) {
+        let va = self.va_range.start;
+        let size = self.va_range.end - self.va_range.start;
+
+        if let Err(e) = self.vm.unmap_range(va, size) {
+            // If unmap_range fails, it is still safe to drop the
+            // KernelBo and its ARef to the GEM buffer object because
+            // GPUVM also holds a reference to the GEM buffer object.
+            // The physical pages won't be freed or reallocated.
+            dev_err!(
+                self.vm.dev(),
+                "Failed to unmap KernelBo range {:#x}..{:#x}: {:?}",
+                self.va_range.start,
+                self.va_range.end,
+                e
+            );
+        }
+    }
+}

-- 
2.55.0

