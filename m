Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D27606A33A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO4ZEgKo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0E210E442;
	Mon,  9 Nov 2026 00:37:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D113410E472
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 00:37:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10D11450D2;
 Mon,  9 Nov 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794184627;
 b=QDCKBZLo3kU1Yak3rtIENf305VSWXAK57ZUAe6BiZUDQwl043oRB9i4jIjn16gppaF9O
 DkwU7ZEUupXflDcGOdcZD8eqMCiD/AZtVCoEPxHlBNqDe1BvTxpnepBUXezFvU4dfVOuS
 E2cHGBsX+e0tAo0xMkoAjJrwpzjD62Et88P0e+1BdGYv+yHw2Q9y1PpmOH1DiRcgHrGmw
 f4Ee48sK0yyzUXhyUJOJRpYUzwjS5zo7t+JozDCOIz0XzYsuaZyQ0UOpPstxpHxMVICLX
 gmz+SXzu0vJce+7sXIugmgiK1ppdlaC1AYg2sG3ENx+mYyOpmwhrvi72CD5vJPw2Fqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794184627;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=eOWqZN2vW2kC8QQcwq92WRb+QnG24MxoJUzMmXz3TKY=;
 b=bMZ7lRk+Xnx3P7KFHH8aWuOZdNP0S+Cbx4t0EFNjU2kT2llkDIGwDbsdEx1yGRTVs5W9
 Q/Gyk3861LzhrMrpTHEMZQaCziHLmjZcJFOW4AaxVZ6AClKC+VFnZoNqTiqxeMbJWjjCI
 9zCZeJWtiEMVzuyWumnfAuN5sPDmdpzCh1nFFlVedJDzFa/nlsovKKqSMYSFFao012W9Y
 om/KXimPjCihTkJPuqlQaVbme9EWMKppmBmt1S1HsrvH4v35S3166s5vY2B/0vLzCksHt
 MNAT1WpH9gyN1VPy/f2sQfboUlp+Dg2e8MOOYVNj/XNNmIsldOOCTpPvNbf9ntrTs0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8510F1F0089F;
 Mon,  9 Nov 2026 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794184626;
 bh=eOWqZN2vW2kC8QQcwq92WRb+QnG24MxoJUzMmXz3TKY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=HO4ZEgKoyUxhMQmw/r6qWBDWBs9UuHq6TJwX/dugMKswBS3g9N6sGVLHZrYh4lqfN
 wgWxgOw7m9bz1jGRIvnHJeg0txQRpluQL/QDmczNhKt9gddNfmI48Af9/tjvci6i17
 50XIYSdrISzWz/78zdAAF/wKq1WTCqAZcbEixpMrkc+2Jo2DwfFvFvR1IVERSyV8U2
 02ua8daMbjGsd3f90Q9WB8VFXSim/t9L3hGp/FqXPTzfjA1G7UExVaOnigRgGxHfhH
 3jspGeU6wZpUqweOwkfLdamU2di98vtO/3yxWrSgH+Pha5tkOErcHRXXYBKXSpKOyK
 REqdZGx6XWK+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9C33E481C4;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Mon, 09 Nov 2026 08:36:52 +0800
Subject: [PATCH v6 09/10] drm/tyr: support write-combine BO mappings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-tyr-ioctls-v6-9-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
In-Reply-To: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184620; l=10160;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=5wWt26iAyWLWMAGjPpMaEoEP5nCYGY3PH94v69tzFyw=;
 b=KgWsx8S2vfcef68MJkD6Y98zUIZcMp7F7tSkCs5dTKXrCwYzMYyTOlCGAoUVTYAGmm2Pp/rLy
 JCHo1z57PIPC0pnnL1p4fyLmEsH2s3veUKjRQwH2g7ouze0YrbgaaYt
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sami Tolvanen <samitolvanen@google.com>

Tyr maps shmem-backed buffers write-combine, but on a coherent device
they are mapped write-back. Cache the coherence at probe and thread it
through to every shmem::ObjectConfig::map_wc site.

Userspace can opt out with DRM_PANTHOR_BO_WB_MMAP, which maps the
buffer cached instead.

The shmem layer zero-inits pages through a cached mapping, and those
stale lines can land over later uncached writes, so fetch the sg_table
at creation to flush them via dma_map_sgtable() before anyone accesses
them uncached. Taking the bound device keeps the unsafe
as_bound() call out of BO creation.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Co-developed-by: Alvin Sun <alvin.sun@linux.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/driver.rs | 13 ++++++++-
 drivers/gpu/drm/tyr/file.rs   |  1 +
 drivers/gpu/drm/tyr/fw.rs     |  4 ++-
 drivers/gpu/drm/tyr/gem.rs    | 61 ++++++++++++++++++++++++++++++++++---------
 drivers/gpu/drm/tyr/vm.rs     |  9 ++++---
 5 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index ba03cc4c52539..6869ab345d8fd 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -9,7 +9,8 @@
         Bound,
         Core,
         Device,
-        DeviceContext, //
+        DeviceContext,
+        DmaAttr, //
     },
     dma::{
         Device as DmaDevice,
@@ -87,6 +88,12 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
 
     /// GPU information read from hardware during probe.
     pub(crate) gpu_info: GpuInfo,
+
+    /// Whether the device is reported as DMA-coherent by firmware.
+    ///
+    /// Cached at probe via `device_get_dma_attr()`. Drives the BO
+    /// cacheability policy in `crate::gem::should_map_wc`.
+    pub(crate) coherent: bool,
 }
 
 fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
@@ -151,6 +158,8 @@ fn probe<'bound>(
             // other threads of execution.
             unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
 
+            let coherent = pdev.as_ref().dma_attr() == DmaAttr::COHERENT;
+
             let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
             let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
@@ -161,6 +170,7 @@ fn probe<'bound>(
                 &unreg_dev,
                 mmu.as_arc_borrow(),
                 &gpu_info,
+                coherent,
             )?;
 
             firmware.boot()?;
@@ -186,6 +196,7 @@ fn probe<'bound>(
                         }),
                         iomem,
                         gpu_info,
+                        coherent,
                     }),
                 )},
                 _: { dev_dbg!(pdev, "Tyr initialized correctly.") },
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 49b22e7ee4179..b982e8db2c4c1 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -109,6 +109,7 @@ pub(crate) fn vm_create(
                 pfile.reg.mmu.as_arc_borrow(),
                 &pfile.reg.gpu_info,
                 UserVaRequest::from_uapi(vmcreate.user_va_range),
+                pfile.reg.coherent,
             )?;
             let user_va_range = vm.layout.user.end;
             let id = pfile.vm_pool.add(vm).map_err(|e| {
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 196ffc96d9d99..1c77bf109a9be 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -217,8 +217,9 @@ pub(crate) fn new(
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
+        coherent: bool,
     ) -> Result<Firmware<'drm>> {
-        let vm = Vm::new_for_fw(dev, ddev, mmu, gpu_info)?;
+        let vm = Vm::new_for_fw(dev, ddev, mmu, gpu_info, coherent)?;
         vm.activate()?;
 
         let result = (|| {
@@ -235,6 +236,7 @@ pub(crate) fn new(
                     size,
                     KernelBoVaAlloc::Explicit(va),
                     parsed.vm_map_flags,
+                    coherent,
                 )?;
 
                 let section_start = parsed.data_range.start as usize;
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 60f6363995a5a..55e2d67b96d98 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -7,6 +7,10 @@
 use core::ops::Range;
 
 use kernel::{
+    device::{
+        Bound,
+        Device, //
+    },
     drm::gem::{
         self,
         shmem,
@@ -17,7 +21,8 @@
     sync::{
         aref::ARef,
         Arc, //
-    }, //
+    },
+    uapi, //
 };
 
 use crate::{
@@ -38,6 +43,14 @@ pub(crate) struct BoData {
     flags: u32,
 }
 
+impl BoData {
+    /// Returns the flags the BO was created with.
+    #[expect(dead_code)]
+    pub(crate) fn flags(&self) -> u32 {
+        self.flags
+    }
+}
+
 /// Provides a way to pass arguments when creating BoData
 /// as required by the gem::DriverObject trait.
 pub(crate) struct BoCreateArgs {
@@ -56,24 +69,48 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Se
 /// Type alias for Tyr GEM buffer objects.
 pub(crate) type Bo = gem::shmem::Object<BoData>;
 
+/// Returns whether a BO should be mapped write-combine.
+pub(crate) fn should_map_wc(coherent: bool, flags: u32) -> bool {
+    if coherent {
+        return false;
+    }
+
+    if flags & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_WB_MMAP != 0 {
+        return false;
+    }
+
+    true
+}
+
 /// Create a new GEM buffer object.
 #[expect(dead_code)]
-pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result<ARef<Bo>> {
+pub(crate) fn new_object(
+    ddev: &TyrDrmDevice,
+    pdev: &Device<Bound>,
+    size: usize,
+    flags: u32,
+    coherent: bool,
+) -> Result<ARef<Bo>> {
     if size == 0 {
         return Err(EINVAL);
     }
 
     let aligned_size = size.checked_next_multiple_of(PAGE_SIZE).ok_or(EINVAL)?;
 
-    Bo::new(
+    let map_wc = should_map_wc(coherent, flags);
+    let bo = Bo::new(
         ddev,
         aligned_size,
         shmem::ObjectConfig {
-            map_wc: true,
+            map_wc,
             parent_resv_obj: None,
         },
         BoCreateArgs { flags },
-    )
+    )?;
+
+    bo.sg_table(pdev)?;
+
+    Ok(bo)
 }
 
 /// Look up a GEM object by handle for a DRM file.
@@ -82,18 +119,17 @@ pub(crate) fn lookup_handle(file: &TyrDrmFile, handle: u32) -> Result<ARef<Bo>>
 }
 
 /// Creates a dummy GEM object to serve as the root of a GPUVM.
-pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> Result<ARef<Bo>> {
-    let bo = Bo::new(
+pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice, coherent: bool) -> Result<ARef<Bo>> {
+    // FIXME: use a Rust resv-object abstraction once available, rather than a real BO.
+    Bo::new(
         ddev,
         4096,
         shmem::ObjectConfig {
-            map_wc: true,
+            map_wc: should_map_wc(coherent, 0),
             parent_resv_obj: None,
         },
         BoCreateArgs { flags: 0 },
-    )?;
-
-    Ok(bo)
+    )
 }
 
 /// Specifies how to choose a GPU virtual address for a [`KernelBo`].
@@ -131,6 +167,7 @@ pub(crate) fn new(
         size: u64,
         va_alloc: KernelBoVaAlloc,
         flags: VmMapFlags,
+        coherent: bool,
     ) -> Result<Self> {
         if size == 0 {
             dev_err!(vm.dev(), "Cannot create KernelBo with size 0");
@@ -146,7 +183,7 @@ pub(crate) fn new(
             ddev,
             bo_size,
             shmem::ObjectConfig {
-                map_wc: true,
+                map_wc: should_map_wc(coherent, 0),
                 parent_resv_obj: None,
             },
             BoCreateArgs { flags: 0 },
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 11bc8e2c9d0be..6d312c3b2ccd1 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -473,13 +473,14 @@ pub(crate) fn new_for_fw(
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
+        coherent: bool,
     ) -> Result<Arc<Vm<'drm>>> {
         // As in panthor: the CSF MCU is a Cortex-M7 and can only address 4G.
         let layout = VmLayout {
             full: 0..u64::SZ_4G,
             user: 0..0u64,
         };
-        Self::new_internal(dev, ddev, mmu, gpu_info, layout)
+        Self::new_internal(dev, ddev, mmu, gpu_info, layout, coherent)
     }
 
     /// Creates a user VM, splitting the GPU VA range per `user_va`.
@@ -489,6 +490,7 @@ pub(crate) fn new_for_user(
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
         user_va: UserVaRequest,
+        coherent: bool,
     ) -> Result<Arc<Vm<'drm>>> {
         let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
         let va_bits = mmu_features.va_bits().get();
@@ -502,7 +504,7 @@ pub(crate) fn new_for_user(
                 range.end
             );
         })?;
-        Self::new_internal(dev, ddev, mmu, gpu_info, layout)
+        Self::new_internal(dev, ddev, mmu, gpu_info, layout, coherent)
     }
 
     /// Initializes a VM with the given layout.
@@ -512,6 +514,7 @@ fn new_internal(
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
         layout: VmLayout,
+        coherent: bool,
     ) -> Result<Arc<Vm<'drm>>> {
         let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
         let va_bits = mmu_features.va_bits().get();
@@ -520,7 +523,7 @@ fn new_internal(
         let reserve_range = 0..0u64;
 
         // dummy_obj is used to initialize the GPUVM tree.
-        let dummy_obj = gem::new_dummy_object(ddev).inspect_err(|e| {
+        let dummy_obj = gem::new_dummy_object(ddev, coherent).inspect_err(|e| {
             dev_err!(dev, "Failed to create dummy GEM object: {:?}", e);
         })?;
 

-- 
2.43.0


