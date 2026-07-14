Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969B1C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED6710EBC4;
	Tue, 14 Jul 2026 03:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="O/xYyVQR";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C8810E0AE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783999142; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vc8bI+TkKx5JBcQ4mTMY0JBaIplMm6VgELxc89uTaB7QbYak+KZG2uxrfFLTd3B5mp4im3bHtHYd2PNvs1VUrDBUph3M69HAn/vtPSIfii3uVq13oH4YD53s7TFYXfpukefH0LLbBVEZfyoaiKhghLJ9ezlAZ+/GGG2yYp0Z/SI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783999142;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qpo1GpV6sk1WVtPptJhiq2FiJGO1cXEHyZJCt5K62l4=; 
 b=LAuMmQ9JG/X5SrFsgvR+0uBHrTpWf3h+epHqinDpVwvC1VdAx7KPl9tI2GcJYANQCobpzrzn1TuEugZBo4zFSPME7R6VpB/2A+Iowi50zHR0GwgksWfsZM5lBnTPISP8UXuBNzXotkGDmrIEm+zGskbwlJmUNcg4qt09yLqmOUo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783999142; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=qpo1GpV6sk1WVtPptJhiq2FiJGO1cXEHyZJCt5K62l4=;
 b=O/xYyVQR6oOkBjJ2CkUj0PKjAXLVXGNFc6ktP5gPkWyePo9V55IudLJVCws/91aS
 w6uY1D30LTzyCzgn84ALRcx06FZfZ8YzTuK5+OMgmMrsJO0hzGYMDzj8Q6J1VG99kjG
 MHuZ0FN3m1HTnsJbuqrqIntTgyNbheNRDmsRXs9I=
Received: by mx.zohomail.com with SMTPS id 1783999141548159.4252948460678;
 Mon, 13 Jul 2026 20:19:01 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Jul 2026 20:18:49 -0700
Subject: [PATCH v7 5/7] drm/tyr: add a kernel buffer object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-fw-boot-b4-v7-5-afd8dc1494dd@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
In-Reply-To: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, samitolvanen@google.com, work@onurozkan.dev, 
 acourbot@nvidia.com, lyude@redhat.com, laura.nao@collabora.com, 
 beata.michalska@arm.com, alvin.sun@linux.dev, steven.price@arm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4385;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=/lTl3P86QqfKk1OWhpH8vkka1+Hljs1sOLic8azDb5M=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmhqxY8+a/yckJjf4juvrPL70TOW7Pg++KWZr9n4io83
 5Wm+ib5d5SyMIhxMciKKbKctTfqEa96b6Q7/38zzBxWJpAhDFycAjCRf4cY/pdpvyrX7Tjf9u2t
 fG6wo6z2UidTSabzE0yXv15vIprv85aRYbl4a2pA4T+LWfnz8j65tIus+hCr9tM18U58Y7Xvj8c
 TOAA=
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
 drivers/gpu/drm/tyr/gem.rs | 101 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index c28be61a01bb..47a05a33388e 100644
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
@@ -56,3 +67,85 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> Result<ARef<Bo>> {
 
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
+    #[expect(dead_code)]
+    pub(crate) bo: ARef<Bo>,
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
+            pr_err!("Cannot create KernelBo with size 0\n");
+            return Err(EINVAL);
+        }
+
+        let KernelBoVaAlloc::Explicit(va) = va_alloc;
+
+        let bo = Bo::new(
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
+            vm,
+            va_range: va..(va + size),
+        })
+    }
+}
+
+impl Drop for KernelBo<'_> {
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
2.54.0

