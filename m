Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0140606A334
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cNU0XM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0008310E51D;
	Sat, 14 Nov 2026 23:43:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546BC10E51D
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 23:43:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EDC360F39;
 Sat, 14 Nov 2026 23:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3671F000C6;
 Sat, 14 Nov 2026 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794699814;
 bh=MxgAUxz8lITz4H+mvvbKLXgHIWwjdp7/ARMhyf/aP2k=;
 h=From:To:Cc:Subject:Date;
 b=S0cNU0XMTNWkFYuMguUbH6TECNztbe39I8DWNsRF75NLOPbbknrJT2eKguKaTNcHp
 ibLbh5zBRE76xkPqKclnz5p8HDDskfYQvuk8r/YylSnF3fN4Xm5/BKewx50ETD1hB9
 B+905+TQ+qWrO5vGxQDziFEuNuTUk6sYQIXJnKYFWgRds8aZi1XI0W5hqLFrmy8TgI
 slHcAePZyMxPNOPgOEeRMN+yqHk/gRdCP525aRtXqvzvtI3Ehs7JlATzwVOLC9SYbR
 LS9RgWLRplCLmI791pfaqyQlOS+6lnAu/hM+PPBWrqoXUJ5xl3QGfIrAL4ZfUWKB00
 bnL7QqU9kpMCA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 1/2] rust: scatterlist: tie owned tables to the device's bound
 lifetime
Date: Sun, 15 Nov 2026 00:42:53 +0100
Message-ID: <20261114234324.82387-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a lifetime parameter to Owned that ties owned scatter-gather tables
to the device's bound scope, ensuring their DMA mappings are released
before the device is unbound.

The DMA mapping currently holds a pointer into Owned, requiring the
table to stay at a fixed address and its cleanup to be ordered around
the device-managed mapping.

Let DmaMappedSgt own RawSGTable and borrow Device<Bound>. Its destructor
unmaps the entries before RawSGTable frees them, and Owned releases the
backing pages last. This removes the internal pointer and makes the
mapping constructor safe without a self-reference.

Carry the device lifetime through Owned and its users. Remove pin
initialization from Owned and SGTable, return tables by value, and update
the callers accordingly.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/firmware/radix3.rs |  29 +++--
 rust/kernel/scatterlist.rs               | 141 ++++++++---------------
 samples/rust/rust_dma.rs                 |  11 +-
 3 files changed, 62 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/radix3.rs b/drivers/gpu/nova-core/firmware/radix3.rs
index 94235bd1209d..a3e43fc8ec86 100644
--- a/drivers/gpu/nova-core/firmware/radix3.rs
+++ b/drivers/gpu/nova-core/firmware/radix3.rs
@@ -35,14 +35,11 @@
 #[pin_data]
 pub(crate) struct Radix3<'a> {
     /// The mapped data.
-    #[pin]
-    data: SGTable<Owned<VVec<u8>>>,
+    data: SGTable<Owned<'a, VVec<u8>>>,
     /// Level 2: one entry per page of `data`.
-    #[pin]
-    level2: SGTable<Owned<VVec<u8>>>,
+    level2: SGTable<Owned<'a, VVec<u8>>>,
     /// Level 1: one entry per page of `level2`.
-    #[pin]
-    level1: SGTable<Owned<VVec<u8>>>,
+    level1: SGTable<Owned<'a, VVec<u8>>>,
     /// Level 0: one page, whose single entry is the DMA address of the first `level1` page.
     level0: Coherent<'a, [u64]>,
     /// Length of `data`, in bytes.
@@ -59,14 +56,14 @@ pub(crate) fn new(
 
         pin_init::pin_init_scope(move || {
             Ok(try_pin_init!(Self {
-                data <- SGTable::new(dev, data, DataDirection::ToDevice, GFP_KERNEL),
-                level2 <- {
-                    build_lvl(&data)
-                        .map(|l2| SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL))?
+                data: SGTable::new(dev, data, DataDirection::ToDevice, GFP_KERNEL)?,
+                level2: {
+                    let l2 = build_lvl(data)?;
+                    SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL)?
                 },
-                level1 <- {
-                    build_lvl(&level2)
-                        .map(|l1| SGTable::new(dev, l1, DataDirection::ToDevice, GFP_KERNEL))?
+                level1: {
+                    let l1 = build_lvl(level2)?;
+                    SGTable::new(dev, l1, DataDirection::ToDevice, GFP_KERNEL)?
                 },
                 level0: {
                     // Allocate the level 0 page table as a device-visible DMA object, and map the
@@ -81,7 +78,7 @@ pub(crate) fn new(
                     let mut level0 = CoherentBox::<'_, [u64]>::zeroed_slice(
                         dev,
                         GSP_PAGE_SIZE / size_of::<u64>(),
-                        GFP_KERNEL
+                        GFP_KERNEL,
                     )?;
                     level0[0] = level1_entry_addr.to_le();
 
@@ -105,7 +102,7 @@ pub(crate) fn size(&self) -> usize {
 
 /// Returns the size of the level that maps `sg_table`: one `u64` entry per [`GSP_PAGE_SIZE`]
 /// page of each DMA-mapped region, rounded up to whole pages.
-fn lvl_size(sg_table: &SGTable<Owned<VVec<u8>>>) -> usize {
+fn lvl_size(sg_table: &SGTable<Owned<'_, VVec<u8>>>) -> usize {
     let entries: usize = sg_table
         .iter()
         .map(|sg_entry| usize::from_safe_cast(sg_entry.dma_len()).div_ceil(GSP_PAGE_SIZE))
@@ -122,7 +119,7 @@ fn lvl_size(sg_table: &SGTable<Owned<VVec<u8>>>) -> usize {
 ///
 /// - `ENOMEM` if the level cannot be allocated.
 /// - `EINVAL` if `sg_table` yields more entries than [`lvl_size`] sized the level for.
-fn build_lvl(sg_table: &SGTable<Owned<VVec<u8>>>) -> Result<VVec<u8>> {
+fn build_lvl(sg_table: &SGTable<Owned<'_, VVec<u8>>>) -> Result<VVec<u8>> {
     let mut dst = VVec::<u8>::zeroed(lvl_size(sg_table), GFP_KERNEL).map_err(|_| ENOMEM)?;
     let mut entries = dst.chunks_exact_mut(size_of::<u64>());
 
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 6379a8748117..93f431d7f548 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -19,7 +19,8 @@
 //! The main entry point is the [`SGTable`] type, which represents a complete scatter-gather table.
 //! It can be either:
 //!
-//! - An owned table ([`SGTable<Owned<P>>`]), created from a Rust memory buffer (e.g., [`VVec`]).
+//! - An owned table ([`SGTable<Owned<'a, P>>`]), created from a Rust memory buffer (e.g.,
+//!   [`VVec`]) and tied to the [`Device<Bound>`] lifetime.
 //!   This type manages the allocation of the `struct sg_table`, the DMA mapping of the buffer, and
 //!   the automatic cleanup of all resources.
 //! - A borrowed reference (&[`SGTable`]), which provides safe, read-only access to a table that was
@@ -33,15 +34,13 @@
     alloc::allocator::VmallocPageIter,
     bindings,
     device::{Bound, Device},
-    devres::Devres,
     dma,
     error,
     page,
     prelude::*,
-    sync::aref::ARef,
     types::Opaque, //
 };
-use core::{ops::Deref, ptr::NonNull};
+use core::ops::Deref;
 
 /// A single entry in a scatter-gather list.
 ///
@@ -123,9 +122,7 @@ unsafe impl Sync for Borrowed {}
 ///
 /// All [`SGTable`] variants can be iterated over the individual [`SGEntry`]s.
 #[repr(transparent)]
-#[pin_data]
 pub struct SGTable<T: private::Sealed = Borrowed> {
-    #[pin]
     inner: T,
 }
 
@@ -177,63 +174,41 @@ pub fn iter(&self) -> SGTableIter<'_> {
 ///
 /// # Invariants
 ///
-/// - `sgt` is a valid pointer to a `struct sg_table` for the entire lifetime of the
-///   [`DmaMappedSgt`].
 /// - `sgt` is always DMA mapped.
-struct DmaMappedSgt {
-    sgt: NonNull<bindings::sg_table>,
-    dev: ARef<Device>,
+struct DmaMappedSgt<'a> {
+    dev: &'a Device<Bound>,
+    sgt: RawSGTable,
     dir: dma::DataDirection,
 }
 
-// SAFETY: `DmaMappedSgt` can be sent to any task.
-unsafe impl Send for DmaMappedSgt {}
-
-// SAFETY: `DmaMappedSgt` has no interior mutability and can be accessed concurrently.
-unsafe impl Sync for DmaMappedSgt {}
-
-impl DmaMappedSgt {
-    /// # Safety
-    ///
-    /// - `sgt` must be a valid pointer to a `struct sg_table` for the entire lifetime of the
-    ///   returned [`DmaMappedSgt`].
-    /// - The caller must guarantee that `sgt` remains DMA mapped for the entire lifetime of
-    ///   [`DmaMappedSgt`].
-    unsafe fn new(
-        sgt: NonNull<bindings::sg_table>,
-        dev: &Device<Bound>,
-        dir: dma::DataDirection,
-    ) -> Result<Self> {
+impl<'a> DmaMappedSgt<'a> {
+    /// Takes ownership of `sgt` and maps it for DMA.
+    fn new(dev: &'a Device<Bound>, sgt: RawSGTable, dir: dma::DataDirection) -> Result<Self> {
         // SAFETY:
         // - `dev.as_raw()` is a valid pointer to a `struct device`, which is guaranteed to be
         //   bound to a driver for the duration of this call.
-        // - `sgt` is a valid pointer to a `struct sg_table`.
+        // - `sgt.as_raw()` is a valid pointer to a `struct sg_table`.
         error::to_result(unsafe {
-            bindings::dma_map_sgtable(dev.as_raw(), sgt.as_ptr(), dir.into(), 0)
+            bindings::dma_map_sgtable(dev.as_raw(), sgt.as_raw(), dir.into(), 0)
         })?;
 
-        // INVARIANT: By the safety requirements of this function it is guaranteed that `sgt` is
-        // valid for the entire lifetime of this object instance.
-        Ok(Self {
-            sgt,
-            dev: dev.into(),
-            dir,
-        })
+        // INVARIANT: `sgt` was successfully DMA mapped and is owned by this object until drop.
+        Ok(Self { dev, sgt, dir })
     }
 }
 
-impl Drop for DmaMappedSgt {
+impl Drop for DmaMappedSgt<'_> {
     #[inline]
     fn drop(&mut self) {
         // SAFETY:
         // - `self.dev.as_raw()` is a pointer to a valid `struct device`.
         // - `self.dev` is the same device the mapping has been created for in `Self::new()`.
-        // - `self.sgt.as_ptr()` is a valid pointer to a `struct sg_table` by the type invariants
-        //   of `Self`.
+        // - `self.sgt.as_raw()` is a valid pointer to a `struct sg_table` for the lifetime of
+        //   `self`.
         // - `self.dir` is the same `dma::DataDirection` the mapping has been created with in
         //   `Self::new()`.
         unsafe {
-            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sgt.as_ptr(), self.dir.into(), 0)
+            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sgt.as_raw(), self.dir.into(), 0)
         };
     }
 }
@@ -308,38 +283,27 @@ fn drop(&mut self) {
 ///
 /// - The backing memory pages.
 /// - The `struct sg_table` allocation (`sgt`).
-/// - The DMA mapping, managed through a [`Devres`]-managed `DmaMappedSgt`.
+/// - The DMA mapping, released before the table and backing pages are freed.
 ///
 /// Users interact with this type through the [`SGTable`] handle and do not need to manage
 /// [`Owned`] directly.
-#[pin_data]
-pub struct Owned<P> {
+pub struct Owned<'a, P> {
     // Note: The drop order is relevant; we first have to unmap the `struct sg_table`, then free the
     // `struct sg_table` and finally free the backing pages.
-    #[pin]
-    dma: Devres<DmaMappedSgt>,
-    #[pin]
-    sgt: RawSGTable,
+    dma: DmaMappedSgt<'a>,
     _pages: P,
 }
 
-// SAFETY: `Owned` can be sent to any task if `P` can be send to any task.
-unsafe impl<P: Send> Send for Owned<P> {}
-
-// SAFETY: `Owned` has no interior mutability and can be accessed concurrently if `P` can be
-// accessed concurrently.
-unsafe impl<P: Sync> Sync for Owned<P> {}
-
-impl<P> Owned<P>
+impl<'a, P> Owned<'a, P>
 where
-    for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+    for<'b> P: page::AsPageIter<Iter<'b> = VmallocPageIter<'b>> + 'static,
 {
     fn new(
-        dev: &Device<Bound>,
+        dev: &'a Device<Bound>,
         mut pages: P,
         dir: dma::DataDirection,
         flags: alloc::Flags,
-    ) -> Result<impl PinInit<Self, Error> + '_> {
+    ) -> Result<Self> {
         let page_iter = pages.page_iter();
         let size = page_iter.size();
 
@@ -367,34 +331,22 @@ fn new(
 
         let max_segment = max_mapping_size.min(max_seg_size);
 
-        Ok(try_pin_init!(&this in Self {
-            // SAFETY:
-            // - `page_vec` is a `KVec` of valid `struct page *` obtained from `pages`.
-            // - The pages contained in `pages` remain valid for the entire lifetime of the
-            //   `RawSGTable`.
-            sgt: unsafe { RawSGTable::new(&mut page_vec, size, max_segment, flags) }?,
-            dma <- {
-                // SAFETY: `this` is a valid pointer to uninitialized memory.
-                let sgt = unsafe { &raw mut (*this.as_ptr()).sgt }.cast();
-
-                // SAFETY: `sgt` is guaranteed to be non-null.
-                let sgt = unsafe { NonNull::new_unchecked(sgt) };
-
-                // SAFETY:
-                // - It is guaranteed that the object returned by `DmaMappedSgt::new` won't out-live
-                //   `sgt`.
-                // - `sgt` is never DMA unmapped manually.
-                // - `sgt` is structurally pinned and therefore cannot move.
-                Devres::new(dev, unsafe { DmaMappedSgt::new(sgt, dev, dir) })
-            },
+        // SAFETY:
+        // - `page_vec` is a `KVec` of valid `struct page *` obtained from `pages`.
+        // - The pages contained in `pages` remain valid for the entire lifetime of the
+        //   `RawSGTable`.
+        let sgt = unsafe { RawSGTable::new(&mut page_vec, size, max_segment, flags) }?;
+
+        Ok(Self {
+            dma: DmaMappedSgt::new(dev, sgt, dir)?,
             _pages: pages,
-        }))
+        })
     }
 }
 
-impl<P> SGTable<Owned<P>>
+impl<'a, P> SGTable<Owned<'a, P>>
 where
-    for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+    for<'b> P: page::AsPageIter<Iter<'b> = VmallocPageIter<'b>> + 'static,
 {
     /// Allocates a new scatter-gather table from the given pages and maps it for DMA.
     ///
@@ -403,8 +355,7 @@ impl<P> SGTable<Owned<P>>
     /// pages of `P`, and maps the table for DMA with the specified [`Device`] and
     /// [`dma::DataDirection`].
     ///
-    /// The DMA mapping is managed through [`Devres`], ensuring that the DMA mapping is unmapped
-    /// once the associated [`Device`] is unbound, or when the [`SGTable<Owned>`] is dropped.
+    /// The table is tied to the [`Device<Bound>`] lifetime and unmaps the DMA mapping when dropped.
     ///
     /// # Parameters
     ///
@@ -428,38 +379,38 @@ impl<P> SGTable<Owned<P>>
     ///     let size = 4 * page::PAGE_SIZE;
     ///     let pages = VVec::<u8>::with_capacity(size, GFP_KERNEL)?;
     ///
-    ///     let sgt = KBox::pin_init(SGTable::new(
+    ///     let sgt = SGTable::new(
     ///         dev,
     ///         pages,
     ///         dma::DataDirection::ToDevice,
     ///         GFP_KERNEL,
-    ///     ), GFP_KERNEL)?;
+    ///     )?;
     ///
     ///     Ok(())
     /// }
     /// ```
     pub fn new(
-        dev: &Device<Bound>,
+        dev: &'a Device<Bound>,
         pages: P,
         dir: dma::DataDirection,
         flags: alloc::Flags,
-    ) -> impl PinInit<Self, Error> + '_ {
-        try_pin_init!(Self {
-            inner <- Owned::new(dev, pages, dir, flags)?
+    ) -> Result<Self> {
+        Ok(Self {
+            inner: Owned::new(dev, pages, dir, flags)?,
         })
     }
 }
 
-impl<P> Deref for SGTable<Owned<P>> {
+impl<P> Deref for SGTable<Owned<'_, P>> {
     type Target = SGTable;
 
     #[inline]
     fn deref(&self) -> &Self::Target {
         // SAFETY:
-        // - `self.inner.sgt.as_raw()` is a valid pointer to a `struct sg_table` for the entire
+        // - `self.inner.dma.sgt.as_raw()` is a valid pointer to a `struct sg_table` for the entire
         //   lifetime of `self`.
         // - The backing `struct sg_table` is not modified for the entire lifetime of `self`.
-        unsafe { SGTable::from_raw(self.inner.sgt.as_raw()) }
+        unsafe { SGTable::from_raw(self.inner.dma.sgt.as_raw()) }
     }
 }
 
@@ -467,7 +418,7 @@ mod private {
     pub trait Sealed {}
 
     impl Sealed for super::Borrowed {}
-    impl<P> Sealed for super::Owned<P> {}
+    impl<P> Sealed for super::Owned<'_, P> {}
 }
 
 /// An [`Iterator`] over the DMA mapped [`SGEntry`] items of an [`SGTable`].
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index ffb693544673..844e137cddc8 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -35,8 +35,7 @@
 struct DmaSampleData<'bound> {
     pdev: &'bound pci::Device<Bound>,
     ca: Coherent<'bound, [MyStruct]>,
-    #[pin]
-    sgt: SGTable<Owned<VVec<u8>>>,
+    sgt: SGTable<Owned<'bound, VVec<u8>>>,
 }
 
 const TEST_VALUES: [(u32, u32); 5] = [
@@ -96,13 +95,9 @@ fn probe<'bound>(
             let size = 4 * page::PAGE_SIZE;
             let pages = VVec::with_capacity(size, GFP_KERNEL)?;
 
-            let sgt = SGTable::new(pdev.as_ref(), pages, DataDirection::ToDevice, GFP_KERNEL);
+            let sgt = SGTable::new(pdev.as_ref(), pages, DataDirection::ToDevice, GFP_KERNEL)?;
 
-            Ok(try_pin_init!(Self::Data {
-                pdev,
-                ca,
-                sgt <- sgt,
-            }))
+            Ok(try_pin_init!(Self::Data { pdev, ca, sgt }))
         })
     }
 }

base-commit: 2268cf8e3d7b4192629e4beff4a413efe5501f11
-- 
2.56.1

