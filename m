Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE861099B3B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A42310EC12;
	Fri, 20 Mar 2026 19:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m0TQqxrA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F289710EC11;
 Fri, 20 Mar 2026 19:46:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D5CC24034E;
 Fri, 20 Mar 2026 19:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED350C2BC9E;
 Fri, 20 Mar 2026 19:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774036013;
 bh=+gN5RwGnaQSMZxMY/xHZRgUoqJ9A7H33p/A6H++uu+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m0TQqxrAiJ2ko/8lyY+apyFbcQwBGhgd/kyPlfzTBCNxT3fRY3NRgtj8hol892lJy
 LAg8spl6UfGZd33v6OKys/zmq7I5FpoYMg/+F36D8FjyQHThzDBu5dy27ZxE8JiUkS
 u5g4sWr/dUdcXzrA4g/07bTWFoBx7P0fy5j+EljWrKHHpL1VwW0zUNcfrL6DR+OYK0
 55yMcISG7hDa23wvIppSGTX4mUI6k8mNSKSJunV7iHc6Fy3pv95n1xjvpIPp1JC70/
 CKp0bodrdNpIvydELXoS4eLRNMAc4RjlFbQF80BK8FiWuZRzNJJDWRHzlROU2hhjyz
 BVodYOfpgdWHQ==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 3/8] rust: dma: add zeroed constructor to `Coherent`
Date: Fri, 20 Mar 2026 20:45:38 +0100
Message-ID: <20260320194626.36263-4-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320194626.36263-1-dakr@kernel.org>
References: <20260320194626.36263-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Gary Guo <gary@garyguo.net>

These constructors create a coherent container of a single object
instead of slice. They are named `zeroed` and `zeroed_with_attrs` to
emphasis that they are created initialized zeroed. It is intended that
there'll be new constructors that take `PinInit` instead of zeroing.

Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/dma.rs       | 81 ++++++++++++++++++++++++++++++++++++----
 samples/rust/rust_dma.rs |  8 ++--
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index ff3e147f1a23..db645b01bdd0 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -47,7 +47,7 @@ pub trait Device: AsRef<device::Device<Core>> {
     /// # Safety
     ///
     /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`CoherentAllocation::alloc_attrs`].
+    /// such as [`Coherent::zeroed`].
     unsafe fn dma_set_mask(&self, mask: DmaMask) -> Result {
         // SAFETY:
         // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
@@ -64,7 +64,7 @@ unsafe fn dma_set_mask(&self, mask: DmaMask) -> Result {
     /// # Safety
     ///
     /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`CoherentAllocation::alloc_attrs`].
+    /// such as [`Coherent::zeroed`].
     unsafe fn dma_set_coherent_mask(&self, mask: DmaMask) -> Result {
         // SAFETY:
         // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
@@ -83,7 +83,7 @@ unsafe fn dma_set_coherent_mask(&self, mask: DmaMask) -> Result {
     /// # Safety
     ///
     /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`CoherentAllocation::alloc_attrs`].
+    /// such as [`Coherent::zeroed`].
     unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMask) -> Result {
         // SAFETY:
         // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
@@ -102,7 +102,7 @@ unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMask) -> Result {
     /// # Safety
     ///
     /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`CoherentAllocation::alloc_attrs`].
+    /// such as [`Coherent::zeroed`].
     unsafe fn dma_set_max_seg_size(&self, size: u32) {
         // SAFETY:
         // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
@@ -202,12 +202,12 @@ pub const fn value(&self) -> u64 {
 ///
 /// ```
 /// # use kernel::device::{Bound, Device};
-/// use kernel::dma::{attrs::*, CoherentAllocation};
+/// use kernel::dma::{attrs::*, Coherent};
 ///
 /// # fn test(dev: &Device<Bound>) -> Result {
 /// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
-/// let c: CoherentAllocation<u64> =
-///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
+/// let c: Coherent<[u64]> =
+///     Coherent::zeroed_slice_with_attrs(dev, 4, GFP_KERNEL, attribs)?;
 /// # Ok::<(), Error>(()) }
 /// ```
 #[derive(Clone, Copy, PartialEq)]
@@ -492,7 +492,6 @@ pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
 
 impl<T: AsBytes + FromBytes> Coherent<T> {
     /// Allocates a region of `T` of coherent memory.
-    #[expect(unused)]
     fn alloc_with_attrs(
         dev: &device::Device<Bound>,
         gfp_flags: kernel::alloc::Flags,
@@ -529,6 +528,35 @@ fn alloc_with_attrs(
         })
     }
 
+    /// Allocates a region of type `T` of coherent memory.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::device::{Bound, Device};
+    /// use kernel::dma::{attrs::*, Coherent};
+    ///
+    /// # fn test(dev: &Device<Bound>) -> Result {
+    /// let c: Coherent<[u64; 4]> =
+    ///     Coherent::zeroed_with_attrs(dev, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    #[inline]
+    pub fn zeroed_with_attrs(
+        dev: &device::Device<Bound>,
+        gfp_flags: kernel::alloc::Flags,
+        dma_attrs: Attrs,
+    ) -> Result<Self> {
+        Self::alloc_with_attrs(dev, gfp_flags | __GFP_ZERO, dma_attrs)
+    }
+
+    /// Performs the same functionality as [`Coherent::zeroed_with_attrs`], except the
+    /// `dma_attrs` is 0 by default.
+    #[inline]
+    pub fn zeroed(dev: &device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
+        Self::zeroed_with_attrs(dev, gfp_flags, Attrs(0))
+    }
+
     /// Allocates a region of `[T; len]` of coherent memory.
     fn alloc_slice_with_attrs(
         dev: &device::Device<Bound>,
@@ -572,6 +600,43 @@ fn alloc_slice_with_attrs(
             dma_attrs,
         })
     }
+
+    /// Allocates a zeroed region of type `T` of coherent memory.
+    ///
+    /// Unlike `Coherent::<[T; N]>::zeroed_with_attrs`, `Coherent::<T>::zeroed_slices` support
+    /// a runtime length.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::device::{Bound, Device};
+    /// use kernel::dma::{attrs::*, Coherent};
+    ///
+    /// # fn test(dev: &Device<Bound>) -> Result {
+    /// let c: Coherent<[u64]> =
+    ///     Coherent::zeroed_slice_with_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    #[inline]
+    pub fn zeroed_slice_with_attrs(
+        dev: &device::Device<Bound>,
+        len: usize,
+        gfp_flags: kernel::alloc::Flags,
+        dma_attrs: Attrs,
+    ) -> Result<Coherent<[T]>> {
+        Coherent::alloc_slice_with_attrs(dev, len, gfp_flags | __GFP_ZERO, dma_attrs)
+    }
+
+    /// Performs the same functionality as [`Coherent::zeroed_slice_with_attrs`], except the
+    /// `dma_attrs` is 0 by default.
+    #[inline]
+    pub fn zeroed_slice(
+        dev: &device::Device<Bound>,
+        len: usize,
+        gfp_flags: kernel::alloc::Flags,
+    ) -> Result<Coherent<[T]>> {
+        Self::zeroed_slice_with_attrs(dev, len, gfp_flags, Attrs(0))
+    }
 }
 
 impl<T> Coherent<[T]> {
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index ce39b5545097..314ef51cd86c 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -6,7 +6,7 @@
 
 use kernel::{
     device::Core,
-    dma::{CoherentAllocation, DataDirection, Device, DmaMask},
+    dma::{Coherent, DataDirection, Device, DmaMask},
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -16,7 +16,7 @@
 #[pin_data(PinnedDrop)]
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
-    ca: CoherentAllocation<MyStruct>,
+    ca: Coherent<[MyStruct]>,
     #[pin]
     sgt: SGTable<Owned<VVec<u8>>>,
 }
@@ -64,8 +64,8 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let ca: CoherentAllocation<MyStruct> =
-                CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            let ca: Coherent<[MyStruct]> =
+                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
                 kernel::dma_write!(ca, [i]?, MyStruct::new(value.0, value.1));
-- 
2.53.0

