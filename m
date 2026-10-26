Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268D8606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4AwGPZ3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522B810F026;
	Mon, 26 Oct 2026 16:41:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF5A10F040
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F2F140C16;
 Mon, 26 Oct 2026 16:41:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032875;
 b=hKcNThT+VeJ5HHRKNUn4OjPO36nlCLnXWk7tSi2ybcIu5FPx/HuhuwoGiMUarv+7XyfE
 enc7k2nK5swamxUNTyNhByIAU2y117FmbDvHeQ3y/5BqYIwdz1a6mVyvEkdg1+74brQua
 9Am6FHGDK4ikxnVQyJhWQ819BKDCFAhyypfLnmMg348knUmmE/ERgbPRbDi2pCSt8nn1Y
 1MfArNePATO0yJvDa9FrHmkSQuqXyCPNpy/e+gOWJ+StYFIsXIR/ra7s3cSPvnjlKQ08f
 4LwONVwto6qriJy5i9IfVX1F6CfuXP2t1iy1KbA1l+cybOZj9ZV2cB67UuaoimytzYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032875;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=ysKNZ1fLk05dgw7IfewdnzuzrTzPYh3xPW1z8eBNmAc=;
 b=rvRxNXAP76GbQGv0V76Wj16hekLfviBvFqpIb5HAe3EU7ROdjXbk+j2qocmAvnlhE1Hp
 20tWAb3hF/YlZYrDQIyaivVvx8jicM1uZ2d39qy/xe93ONY7sO0TVgIMrMlgbeFCD+dxu
 v3IlGkOMiLFP4FI14+J4+Lal/Ys8ok6LksZj/iFfglkjddIMTSzhMebc+DLttmEOOGUG8
 qytd2/atTSkTw2OMiw8lmxV4+GBGrf6DbVJ4Eg6YBLPyaJ+KTxpZLlUq5dlZS0GMVHLqJ
 FM0NfEIkHhTiAiJxq4k10pgo631XnoeeuBdi75eefTapELKEvrp8Vybd/Kz5Qf2SLcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0972B1F031E2;
 Mon, 26 Oct 2026 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032875;
 bh=ysKNZ1fLk05dgw7IfewdnzuzrTzPYh3xPW1z8eBNmAc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=O4AwGPZ3GGIllYL3b5SiV7GRf/E11fHDEhsKVRL/XVJsQRljdNc4R5Ip6UWNR51PJ
 SGayfKkv1zRAhz6OaGd7Ov1u2fMkN3xdFmhbO+4jtx4b40muLgiziCz/U+UtEUH0Hk
 8ERhtii9/F8pfe/4FXI3c8Miqhk5fsqDJwg5Vy8NO7kyPvECTOx678hggQc6qQjoeG
 5UkOJoaNXmB+ypyTjUmgRZ2kpgph93+zYSJ9UrbOY6ECeVM4Bx+TwfYchmvTSK7HbY
 9qZqfUAjnJ0fCWvFY9u+LIsA8UNNWAxf6CeGZnAzMi5ymMYNHrS/yF+KgP/7J6iaWq
 VDirAmk3LeWBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 774AF44DD5;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 27 Oct 2026 00:40:58 +0800
Subject: [PATCH v5 05/11] drm/tyr: add user and MCU VM specifications
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tyr-ioctls-v5-5-59dfe98cb003@kylinos.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=10738;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=5olk0wPkluu5YrzX/YLAGBRncbBGNyGmwbWvc52l7lc=;
 b=HCfAzgOxz+WFiH6lasSIiQDCIefcZdzFCV27nBSS8inkBVnBjH0mZc5ri89ZwzamZNViA4Goe
 q/llvYbDStuDovJmo6J2FwdbOQ0OkI0Z3DjFPDyHaFdpCIrrSk8NBJN
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

From: Alvin Sun <alvin.sun@linux.dev>

The MCU and user VMs need different VA layouts. Give each a dedicated
constructor: new_for_fw() builds the kernel-only 4G layout, while
new_for_user() splits the address space by task_size or a user-provided
size, rejecting oversized requests rather than clamping. The resulting
user range is what VM_CREATE reports back as user_va_range.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/fw.rs |  19 +++---
 drivers/gpu/drm/tyr/vm.rs | 157 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 151 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index aea151ff1f934..81e8103368bc2 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -51,7 +51,6 @@
         KernelBoVaAlloc, //
     },
     gpu::GpuInfo,
-
     mmu::Mmu,
     regs::{
         gpu_control::{
@@ -219,10 +218,10 @@ pub(crate) fn new(
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
     ) -> Result<Firmware<'drm>> {
-        let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
+        let vm = Vm::new_for_fw(dev, ddev, mmu, gpu_info)?;
         vm.activate()?;
 
-        let result = (|| {
+        let sections = (|| -> Result<KVec<Section<'drm>>> {
             let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
             let mut sections = KVec::new();
             for parsed in parsed_sections {
@@ -252,18 +251,18 @@ pub(crate) fn new(
                 sections.push(Section { data, mem }, GFP_KERNEL)?;
             }
 
-            Ok(Firmware {
-                iomem,
-                vm: vm.clone(),
-                sections,
-            })
+            Ok(sections)
         })();
 
-        if result.is_err() {
+        if sections.is_err() {
             vm.kill();
         }
 
-        result
+        Ok(Firmware {
+            iomem,
+            vm,
+            sections: sections?,
+        })
     }
 
     pub(crate) fn boot(&self) -> Result {
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 69b092a130883..b2fcda1e61073 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -8,6 +8,7 @@
 //! mapped into hardware address space (AS) slots for GPU execution.
 
 use core::marker::PhantomData;
+use core::num::NonZeroU64;
 use core::ops::Range;
 
 use kernel::{
@@ -45,6 +46,8 @@
     num::casts::FromSafeCast,
     prelude::*,
     sizes::{
+        LargeSizeConstants,
+        SizeConstants,
         SZ_1G,
         SZ_2M,
         SZ_4K, //
@@ -160,6 +163,90 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
     }
 }
 
+/// User VA size request for a user VM.
+pub(crate) enum UserVaRequest {
+    /// Split based on `task_size()` and the GPU VA range.
+    Auto,
+    /// Caller-specified size; construction guarantees `> 0`.
+    Fixed(NonZeroU64),
+}
+
+impl UserVaRequest {
+    /// UAPI boundary normalization: `0` -> [`Auto`](Self::Auto).
+    #[expect(dead_code)]
+    pub(crate) fn from_uapi(v: u64) -> Self {
+        match NonZeroU64::new(v) {
+            Some(size) => Self::Fixed(size),
+            None => Self::Auto,
+        }
+    }
+}
+
+/// Final user/kernel VA layout for a VM.
+pub(crate) struct VmLayout {
+    /// Full GPU VA range covered by this VM.
+    pub(crate) full: Range<u64>,
+    /// User-accessible VA range. Empty for MCU VMs.
+    pub(crate) user: Range<u64>,
+}
+
+impl VmLayout {
+    /// Kernel VA range, reserved for future kernel object allocation.
+    #[expect(dead_code)]
+    pub(crate) fn kernel(&self) -> Range<u64> {
+        self.user.end..self.full.end
+    }
+
+    /// Compute a user/kernel split for a user VM from the full GPU VA range and
+    /// a user request.
+    pub(crate) fn compute(full: Range<u64>, req: UserVaRequest) -> Result<Self> {
+        // Minimum VA space reserved for kernel objects (heaps, ring buffers, ...).
+        const MIN_KERNEL_VA: u64 = u64::SZ_256M;
+
+        if full.end <= MIN_KERNEL_VA {
+            return Err(EINVAL);
+        }
+
+        let user_max = full.end - MIN_KERNEL_VA;
+
+        let user_end = match req {
+            UserVaRequest::Fixed(v) => {
+                let user_size = v.get();
+                if user_size > user_max {
+                    return Err(EINVAL);
+                }
+                user_size
+            }
+            UserVaRequest::Auto => {
+                let task_size = current!().task_size() as u64;
+                let candidate = if task_size < full.end {
+                    task_size
+                } else {
+                    // If the range exceeds 4G, split it in two so CPU and
+                    // GPU share the same addresses (SVM).
+                    if full.end > u64::SZ_4G {
+                        full.end / 2
+                    } else {
+                        user_max
+                    }
+                };
+                candidate.min(user_max)
+            }
+        };
+
+        let delta = full.end - user_end;
+        // Pick a kernel VA range that's a power of two, to have a clear split.
+        let kernel_va_range = 1u64 << delta.ilog2();
+        let kernel_va_start = full.end - kernel_va_range;
+        let full_start = full.start;
+
+        Ok(Self {
+            full,
+            user: full_start..kernel_va_start,
+        })
+    }
+}
+
 /// Arguments for a virtual memory map operation.
 struct VmMapArgs<'drm> {
     /// Access permissions and caching behavior for the mapping.
@@ -335,26 +422,64 @@ pub(crate) struct Vm<'drm> {
     /// Non-core part of the GPUVM. Can be used for stuff that doesn't modify the
     /// internal mapping tree, like GpuVm::obtain()
     gpuvm: ARef<GpuVm<GpuVmData<'drm>>>,
-    /// VA range for this VM.
-    va_range: Range<u64>,
+    /// VA layout for this VM.
+    pub(crate) layout: VmLayout,
 }
 
 impl<'drm> Vm<'drm> {
-    /// Creates a new GPU virtual address space.
+    /// Creates the MCU/firmware VM.
     ///
-    /// The VM is initialized with a page table configured according to the GPU's
-    /// address translation capabilities and registered with the GPUVM framework.
-    pub(crate) fn new(
+    /// The MCU VM is entirely kernel-managed: it has no user-accessible range.
+    pub(crate) fn new_for_fw(
+        dev: &'drm Device<Bound>,
+        ddev: &TyrDrmDevice,
+        mmu: ArcBorrow<'_, Mmu<'drm>>,
+        gpu_info: &GpuInfo,
+    ) -> Result<Arc<Vm<'drm>>> {
+        // As in panthor: the CSF MCU is a Cortex-M7 and can only address 4G.
+        let layout = VmLayout {
+            full: 0..u64::SZ_4G,
+            user: 0..0u64,
+        };
+        Self::new_internal(dev, ddev, mmu, gpu_info, layout)
+    }
+
+    /// Creates a user VM, splitting the GPU VA range per `user_va`.
+    #[expect(dead_code)]
+    pub(crate) fn new_for_user(
         dev: &'drm Device<Bound>,
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
+        user_va: UserVaRequest,
+    ) -> Result<Arc<Vm<'drm>>> {
+        let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
+        let va_bits = mmu_features.va_bits().get();
+        let range = 0..(1u64 << va_bits);
+
+        let layout = VmLayout::compute(range.clone(), user_va).inspect_err(|_| {
+            dev_dbg!(
+                dev,
+                "Failed to split GPU VA range {:#x}..{:#x} into user and kernel regions\n",
+                range.start,
+                range.end
+            );
+        })?;
+        Self::new_internal(dev, ddev, mmu, gpu_info, layout)
+    }
+
+    /// Initializes a VM with the given layout.
+    fn new_internal(
+        dev: &'drm Device<Bound>,
+        ddev: &TyrDrmDevice,
+        mmu: ArcBorrow<'_, Mmu<'drm>>,
+        gpu_info: &GpuInfo,
+        layout: VmLayout,
     ) -> Result<Arc<Vm<'drm>>> {
         let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
         let va_bits = mmu_features.va_bits().get();
         let pa_bits = mmu_features.pa_bits().get();
 
-        let range = 0..(1u64 << va_bits);
         let reserve_range = 0..0u64;
 
         // dummy_obj is used to initialize the GPUVM tree.
@@ -366,7 +491,7 @@ pub(crate) fn new(
             c"Tyr::GpuVm",
             ddev,
             &*dummy_obj,
-            range.clone(),
+            layout.full.clone(),
             reserve_range,
             GpuVmData::<'drm> {
                 _phantom: PhantomData::<&()>,
@@ -386,7 +511,7 @@ pub(crate) fn new(
                 mmu: mmu.into(),
                 gpuvm,
                 gpuvm_unique <- new_mutex!(gpuvm_unique),
-                va_range: range,
+                layout,
             }),
             GFP_KERNEL,
         )?;
@@ -417,10 +542,12 @@ fn deactivate(&self) -> Result {
 
     /// Kills the VM by deactivating it and unmapping all regions.
     pub(crate) fn kill(&self) {
-        // TODO: Turn the VM into a state where it can't be used.
         let _ = self.deactivate();
         let _ = self
-            .unmap_range(self.va_range.start, self.va_range.end - self.va_range.start)
+            .unmap_range(
+                self.layout.full.start,
+                self.layout.full.end - self.layout.full.start,
+            )
             .inspect_err(|e| {
                 dev_err!(self.dev, "Failed to unmap range during deactivate: {:?}", e);
             });
@@ -557,14 +684,14 @@ pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
 
         let end = va.checked_add(size).ok_or(EINVAL)?;
 
-        if va < self.va_range.start || end > self.va_range.end {
+        if va < self.layout.full.start || end > self.layout.full.end {
             dev_err!(
                 self.dev,
                 "Unmap range {:#x}..{:#x} exceeds VM range {:#x}..{:#x}",
                 va,
                 end,
-                self.va_range.start,
-                self.va_range.end
+                self.layout.full.start,
+                self.layout.full.end
             );
             return Err(EINVAL);
         }
@@ -574,7 +701,7 @@ pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
             region: va..end,
         };
 
-        let full_vm = va == self.va_range.start && end == self.va_range.end;
+        let full_vm = va == self.layout.full.start && end == self.layout.full.end;
 
         let mut resources = VmOpResources {
             preallocated_gpuvas: if full_vm {

-- 
2.43.0


