Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5560606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0q8+/Ky
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2104D10F047;
	Mon, 26 Oct 2026 16:41:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B0C10F026
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10D5743E89;
 Mon, 26 Oct 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032876;
 b=K/2+4WteYFoa9x0RNxrobp37kQW31SPse+GHey3WcW89jXMADLj13aMos/2HMb10BmCD
 SIuSXu/g8Xo09eEsnsS09wVn5nXhd8tZx5KcHxpf5SZtvuwL/bX5o9dbuPCfCUcdlOGhn
 CAVml4EAjwJZdYTVi3HpRtXjsDETZbW4ASyDv912gpdldyqiIJG48n3Y+wOoOjQT7YnP4
 3Wnqs/jgmIquw016qDsHMzTwKf/Drsqs/Ad8pQ1N5vkttKsMpoASkBvWbV6Nyt/8f4crP
 HWfqWMQQMw6u6LDgfi8+KHzaSCJtbTZaHMiidlTWr2SqWO5gXbfWfu6dR0MUR+PyJ8A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032876;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=C4ui3ORThMFxPt8Bo17MA+gAJwjFqVq/g0tnD9iPMVE=;
 b=AdHV8PSwQY9SZIXrR+UVoxAF0N4UiYqVlZtOG2KgewWJomiXErbkcGQWVWnU/is4maeO
 Ykx/Mzck/AOPOtQASWXu9ZvzRJg9I+a65D1DJBg3M2zZdSC3FRgLZeB0KK1QG1y1C03X0
 fe10Un8bkhHPmGXsK0vFWfRYAROF1dMW7+9P8eAh79ZDSICl0aTYOH60YJhms5EDDD1jA
 gJ8uu88WHo+69fp82CcKJBoz1xsRga6IlcepNnjj0gX/voyilLPVeGxzaTjjmckkyqiCA
 eXv94YLMToYKShpps0cWjHRxBBD5jEXpXvgZK4KCDkmTOvdVEAsqcR/GKwIhJNixYow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A7BCB1F031EE;
 Mon, 26 Oct 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032876;
 bh=C4ui3ORThMFxPt8Bo17MA+gAJwjFqVq/g0tnD9iPMVE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Y0q8+/KyM5p3aD1Jq4+GzM9CiIGpP2JhLhlDpCXJwuiIHZPmry0P0yf6hLYmWknz9
 C5mHYuyivp4j6CAzX5Y6hMGUwO2X4oN6++feB6Z13Kg4cUa9cVett7Ov5U0M74sI0x
 CQW/ufevGWV580gBZ4Z/8ELtDE59Ashq+UcdO8hSItX83JUlJX6YNnbf2s1Ipscx1e
 w0hrte08T/yJ4kODTTXFxlSB088DoPplYWA1uB48EN3RDEdGyIFzMQzWe8u5dknLTq
 CXUk4pdprSb/liTJWIuAWivitIGnwxLGwY2xy3Ai1//8YCyhIq+EqBD/MFBg5wUWlR
 AWvJ1w1dfbCbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id AEB9244DE9;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 27 Oct 2026 00:41:03 +0800
Subject: [PATCH v5 10/11] drm/tyr: gem: flush write-combine BOs from
 probe-time coherence
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tyr-ioctls-v5-10-59dfe98cb003@kylinos.cn>
References: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
In-Reply-To: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
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
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=9726;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=WTCCiW45KNyulvM4+A7xNmlcKjm/jh90uXe+LDeJ+2g=;
 b=qZFdthzUHROr6eAi7JzFBQ6H492moXwX5AjdC6T5QxRkLvvrlf5xUmwP37xTsvl8PbGh/bCl8
 EqXie58rx2ZAgQun3wo0E/MS1523YzdcBf7o96i+bWdcBiKOIdvB+yK
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sami Tolvanen <samitolvanen@google.com>

Tyr maps shmem-backed buffers write-combine, but the shmem layer
zero-inits new pages through a cached mapping. On a non-coherent device
those stale cache lines can land over later uncached writes, so the GPU
or userspace reads a freshly written value back as zero.

Read the device's coherence once at probe and map buffers write-back
when it's coherent, write-combine otherwise. BO_CREATE fetches the
sgtable at creation time so dma_map_sgtable() flushes the zeroed pages
before anyone accesses them uncached.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[ Drop the map_wc-conditional sg_table call, now fetched
  unconditionally in BO_CREATE. - Alvin ]
Co-developed-by: Alvin Sun <alvin.sun@linux.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/driver.rs | 10 ++++++++++
 drivers/gpu/drm/tyr/file.rs   |  5 +++--
 drivers/gpu/drm/tyr/fw.rs     |  4 +++-
 drivers/gpu/drm/tyr/gem.rs    | 34 +++++++++++++++++++++++++---------
 drivers/gpu/drm/tyr/vm.rs     |  9 ++++++---
 5 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index f4f31b24180b4..633d1cab3cea9 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -88,6 +88,12 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
 
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
@@ -152,6 +158,8 @@ fn probe<'bound>(
             // other threads of execution.
             unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
 
+            let coherent = pdev.as_ref().dma_attr().is_coherent();
+
             let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
             let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
@@ -162,6 +170,7 @@ fn probe<'bound>(
                 &unreg_dev,
                 mmu.as_arc_borrow(),
                 &gpu_info,
+                coherent,
             )?;
 
             firmware.boot()?;
@@ -187,6 +196,7 @@ fn probe<'bound>(
                         }),
                         iomem,
                         gpu_info,
+                        coherent,
                     }),
                 )},
                 _: { dev_dbg!(pdev, "Tyr initialized correctly.") },
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9ffb42f0d8851..d4d6a6742b2e1 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -113,6 +113,7 @@ pub(crate) fn vm_create(
                 pfile.reg.mmu.as_arc_borrow(),
                 &pfile.reg.gpu_info,
                 UserVaRequest::from_uapi(vmcreate.user_va_range),
+                pfile.reg.coherent,
             )?;
             let user_va_range = vm.layout.user.end;
             let id = pfile.vm_pool.add(vm).map_err(|e| {
@@ -253,7 +254,7 @@ pub(crate) fn vm_get_state(
 
     pub(crate) fn bo_create(
         ddev: &TyrDrmDevice<Registered>,
-        _reg_data: &TyrDrmRegistrationData<'_>,
+        reg_data: &TyrDrmRegistrationData<'_>,
         bocreate: &mut uapi::drm_panthor_bo_create,
         file: &TyrDrmFile,
     ) -> Result<u32> {
@@ -284,7 +285,7 @@ pub(crate) fn bo_create(
             );
             EINVAL
         })?;
-        let bo = crate::gem::new_object(ddev, size, bocreate.flags)?;
+        let bo = crate::gem::new_object(ddev, size, bocreate.flags, reg_data.coherent)?;
         bocreate.handle = bo.create_handle(file)?;
         bocreate.size = bo.size() as u64;
 
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 81e8103368bc2..b24560ae10a4e 100644
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
 
         let sections = (|| -> Result<KVec<Section<'drm>>> {
@@ -235,6 +236,7 @@ pub(crate) fn new(
                     size,
                     KernelBoVaAlloc::Explicit(va),
                     parsed.vm_map_flags,
+                    coherent,
                 )?;
 
                 let section_start = parsed.data_range.start as usize;
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 14f3e182b98e2..fad0720ce7123 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -63,19 +63,35 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Se
 /// Type alias for Tyr GEM buffer objects.
 pub(crate) type Bo = gem::shmem::Object<BoData>;
 
+/// Returns whether a BO should be mapped write-combine given the device's
+/// DMA coherence.
+pub(crate) fn should_map_wc(coherent: bool) -> bool {
+    if coherent {
+        return false;
+    }
+
+    true
+}
+
 /// Create a new GEM buffer object.
-pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result<ARef<Bo>> {
+pub(crate) fn new_object(
+    ddev: &TyrDrmDevice,
+    size: usize,
+    flags: u32,
+    coherent: bool,
+) -> Result<ARef<Bo>> {
     if size == 0 {
         return Err(EINVAL);
     }
 
     let aligned_size = size.checked_next_multiple_of(PAGE_SIZE).ok_or(EINVAL)?;
 
+    let map_wc = should_map_wc(coherent);
     let bo = Bo::new(
         ddev,
         aligned_size,
         shmem::ObjectConfig {
-            map_wc: true,
+            map_wc,
             parent_resv_obj: None,
         },
         BoCreateArgs { flags },
@@ -94,18 +110,17 @@ pub(crate) fn lookup_handle(file: &TyrDrmFile, handle: u32) -> Result<ARef<Bo>>
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
+            map_wc: should_map_wc(coherent),
             parent_resv_obj: None,
         },
         BoCreateArgs { flags: 0 },
-    )?;
-
-    Ok(bo)
+    )
 }
 
 /// Specifies how to choose a GPU virtual address for a [`KernelBo`].
@@ -143,6 +158,7 @@ pub(crate) fn new(
         size: u64,
         va_alloc: KernelBoVaAlloc,
         flags: VmMapFlags,
+        coherent: bool,
     ) -> Result<Self> {
         if size == 0 {
             dev_err!(vm.dev(), "Cannot create KernelBo with size 0");
@@ -158,7 +174,7 @@ pub(crate) fn new(
             ddev,
             bo_size,
             shmem::ObjectConfig {
-                map_wc: true,
+                map_wc: should_map_wc(coherent),
                 parent_resv_obj: None,
             },
             BoCreateArgs { flags: 0 },
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 5c3be79b2c595..fc034514c2ce9 100644
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


