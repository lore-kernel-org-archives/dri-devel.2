Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30357C61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 19:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8F310E216;
	Sun, 30 Aug 2026 19:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+eTYAz4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA17610E1E8
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 19:39:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D19B60202;
 Sun, 30 Aug 2026 19:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8F11F000E9;
 Sun, 30 Aug 2026 19:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788118757;
 bh=3x/qToZnk87itygyDDaFN2+N/ncBKy4g9fZJpLaoNvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m+eTYAz4zffrFGfBz8T9fzYKB8BeS3guPlWaXtedlfJ2mXXQtEtLXuwDNLdPuAWP8
 8FeCM7WorTkhwoz5gBUF0UMwPziGmq4Kxne4ZHZUQ6RboSlqSJ7k2/oZHM2gic2cb8
 yhku6inBU/DXDr58ze2vO84r4KNFczHRn1K7Rs6SDlJGxe/4KUyP+G9btEr6O0CK1s
 W8GgQpH6f0ZyZL/ionFT7b2E663fm/xUma6gaY/Qltg6Em7peHHobgW/7RG3gBoXf6
 A3tmfXDIOrsuZTJ8N2FWwOIol3d4hqE5XonATZTHTPxVhjztqGCFe+3dmGyK4m+DQC
 tJmQyRK+qBgRw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, mmaurer@google.com
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 2/4] rust: dma: tie CoherentHandle to the device's bound
 lifetime
Date: Sun, 30 Aug 2026 21:37:14 +0200
Message-ID: <20260830193824.471089-3-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830193824.471089-1-dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
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

Add a lifetime parameter to CoherentHandle that ties the DMA allocation
to the device's bound scope, ensuring it is freed before the device is
unbound.

DMA allocations carry device resources (e.g. IOMMU mappings) that must
not outlive the device's bound lifetime. Without a lifetime parameter,
there was no compile-time enforcement that a CoherentHandle is dropped
before the device is unbound.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/fb.rs |  2 +-
 rust/kernel/dma.rs          | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 1576399389b1..9ef232a73dee 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -49,7 +49,7 @@ pub(crate) struct SysmemFlush<'sys> {
     device: &'sys device::Device,
     bar: Bar0<'sys>,
     /// Keep the page alive as long as we need it.
-    page: CoherentHandle,
+    page: CoherentHandle<'sys>,
 }
 
 impl<'sys> SysmemFlush<'sys> {
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2ce09f8e90c6..79f453e9ec0b 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -996,15 +996,15 @@ fn write_to_slice(
 /// - `size` is the allocation size in bytes as passed to `dma_alloc_attrs`.
 /// - `dma_attrs` contains the attributes used for the allocation, always including
 ///   `DMA_ATTR_NO_KERNEL_MAPPING`.
-pub struct CoherentHandle {
-    dev: ARef<device::Device>,
+pub struct CoherentHandle<'a> {
+    dev: &'a device::Device<Bound>,
     dma_addr: DmaAddress,
     cpu_handle: NonNull<c_void>,
     size: usize,
     dma_attrs: Attrs,
 }
 
-impl CoherentHandle {
+impl<'a> CoherentHandle<'a> {
     /// Allocates `size` bytes of coherent DMA memory without creating a kernel virtual mapping.
     ///
     /// Additional DMA attributes may be passed via `dma_attrs`; `DMA_ATTR_NO_KERNEL_MAPPING` is
@@ -1012,7 +1012,7 @@ impl CoherentHandle {
     ///
     /// Returns `EINVAL` if `size` is zero, `ENOMEM` if the allocation fails.
     pub fn alloc_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         size: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -1038,9 +1038,9 @@ pub fn alloc_with_attrs(
 
         // INVARIANT: `cpu_handle` is the opaque handle from a successful `dma_alloc_attrs` call
         // with `DMA_ATTR_NO_KERNEL_MAPPING`, `dma_addr` is the corresponding DMA address,
-        // and we hold a refcounted reference to the device.
+        // and `dev` is a valid reference to a bound device that outlives this allocation.
         Ok(Self {
-            dev: dev.into(),
+            dev,
             dma_addr,
             cpu_handle,
             size,
@@ -1051,7 +1051,7 @@ pub fn alloc_with_attrs(
     /// Allocates `size` bytes of coherent DMA memory without creating a kernel virtual mapping.
     #[inline]
     pub fn alloc(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         size: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<Self> {
@@ -1073,7 +1073,7 @@ pub fn size(&self) -> usize {
     }
 }
 
-impl Drop for CoherentHandle {
+impl Drop for CoherentHandle<'_> {
     fn drop(&mut self) {
         // SAFETY: All values are valid by the type invariants on `CoherentHandle`.
         // `cpu_handle` is the opaque handle from `dma_alloc_attrs` and is passed back unchanged.
@@ -1091,12 +1091,12 @@ fn drop(&mut self) {
 
 // SAFETY: `CoherentHandle` only holds a device reference, a DMA address, an opaque CPU handle,
 // and a size. None of these are tied to a specific thread.
-unsafe impl Send for CoherentHandle {}
+unsafe impl Send for CoherentHandle<'_> {}
 
 // SAFETY: `CoherentHandle` provides no CPU access to the underlying allocation. The only
 // operations on `&CoherentHandle` are reading the DMA address and size, both of which are
 // plain `Copy` values.
-unsafe impl Sync for CoherentHandle {}
+unsafe impl Sync for CoherentHandle<'_> {}
 
 /// View type for `Coherent`.
 ///
-- 
2.55.0

