Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11DEF531CE
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB30210E54B;
	Mon, 13 Apr 2026 22:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="IZlyODWH";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1C910E549
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119525; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nS8JpQ5lktb/ycb7T3y7W1J8eIpPonhLF/NAO1zZbZuWK27fyvbZXtbDyllHsWEbOTUqSOplB2JJs483res2MrZIFrBP8T/J4jtJ4QsSJGT72ZlCtQ7zM89xHpw08Lh9lRxucxVoyL/5IOmf0IBMwVmoZaNC4L+J0nbuTwLCQfQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119525;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RUqLI28yo3oTGrENvimVHEDD6lDvBVJ/RxaKotmgahE=; 
 b=RIZqimn3jbN73CHjiwmTipVPcYsnSUL8McKG3AQvOL69SD/0k3oXBSCUr9ELohvHh3H4nySEtF+g9Qj654w6cLboVhAxvbf4nOnpNKkLmduu0haltvlS16Yo6QXy/jUsb540kpcrWa4DCwrgzHhGconuJjeqJUbFurjaQkNmZyU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119525; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=RUqLI28yo3oTGrENvimVHEDD6lDvBVJ/RxaKotmgahE=;
 b=IZlyODWHhFUsOjhGjdF1yiTa2khkp/X04tPOfXwo2OOVZwh0rZogWgJrsDiVExey
 ZV91GtW6cVClfaABiiCSCK61xU6S19nRLda7eqrGLU1icj6VfGDCR0nyRhCFUZv0oAP
 GJmnWnnfT4qXVQw5hHpa92o6hLFX4lozJ4UuNqb8=
Received: by mx.zohomail.com with SMTPS id 1776119524708844.0388974740306;
 Mon, 13 Apr 2026 15:32:04 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Apr 2026 15:31:46 -0700
Subject: [PATCH v3 11/13] drm/tyr: add a kernel buffer object
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-fw-boot-v3-v3-11-b422f3c03885@collabora.com>
References: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
In-Reply-To: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5962;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=rurOKa1tcEIzVJaZcuiDfiEdNQDEfvlVGxqqYMOCT8g=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl3867OTz+/3bqa4110tPbbkgoBr/bZpc5vHv53TD0yr
 3JFjMD1jlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACZS+ouRoUl71/8TJxab7fvi
 u0hZ2r/gq+SUzwXlKzw27pzy92lz1kKG36xno7+6MinK6gisX5HlHFAT7nje/jVbVCD7Ltd9m0N
 dmAE=
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

