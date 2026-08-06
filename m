Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC5CC5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E468110F264;
	Thu,  6 Aug 2026 17:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="WvV4EiP8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4233510E9BE
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:09:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C4DC64408A;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D958C4AF1A;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1786036195; bh=phGE6qAgWSFcQKcf7QAsD69tXR0oqZJVFj7Q1uQQc88=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WvV4EiP8VZvkBwAFIAsGPWwnSExdFcw7G40EANVIQPVezn0a4ZVnzgGBvQ8+QeXxo
 W/ih3noYy9EPf0enHRNh5dMMNrpdVRVn2ePSUBEOCDUzxWfjWsjAskza0lON25xUO2
 HzJNVeXmug5J/uXfOtLE1MxdXaE4mvyjg7X2JEOo=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 88E7FC5AC81;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Fri, 07 Aug 2026 01:07:29 +0800
Subject: [PATCH v3 7/8] drm/tyr: track VMs in a registry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tyr-debugfs-v2-v3-7-ff5595ac66ae@linux.dev>
References: <20260807-tyr-debugfs-v2-v3-0-ff5595ac66ae@linux.dev>
In-Reply-To: <20260807-tyr-debugfs-v2-v3-0-ff5595ac66ae@linux.dev>
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
 Greg Kroah-Hartman <gregkh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786036192; l=5211;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=phGE6qAgWSFcQKcf7QAsD69tXR0oqZJVFj7Q1uQQc88=;
 b=VNMj1FO6LKaxO8oV+bwyly5M+GvJGBrjn+KIvm0d03AEvo4GSMcHLg+PVuSkaPLCH7b3c5YEb
 nN7iwUwcLC2DmqnDWeevHSIxfl/cHjk8FT/6RHf1c3T9FFllvufeh2q
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Add VmRegistry to track all VMs for debugfs enumeration. VMs are
explicitly registered and unregistered to keep the list in sync.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/driver.rs |  6 +++++-
 drivers/gpu/drm/tyr/fw.rs     | 18 +++++++++++++++---
 drivers/gpu/drm/tyr/vm.rs     | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index a6694400be659..f26c3bb332e70 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -57,7 +57,8 @@
     gpu,
     gpu::GpuInfo,
     mmu::Mmu,
-    regs::gpu_control::*, //
+    regs::gpu_control::*,
+    vm::VmRegistry, //
 };
 
 pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;
@@ -167,11 +168,14 @@ fn probe<'bound>(
 
         let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
 
+        let registry = Arc::pin_init(VmRegistry::new(), GFP_KERNEL)?;
+
         let firmware = Firmware::new(
             pdev.as_ref(),
             iomem.clone(),
             &unreg_dev,
             mmu.as_arc_borrow(),
+            registry.clone(),
             &gpu_info,
         )?;
 
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 65ac18b92b4f2..8b09ea6c7c6d2 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -64,7 +64,6 @@
         KernelBoVaAlloc, //
     },
     gpu::GpuInfo,
-
     mmu::Mmu,
     regs::{
         gpu_control::{
@@ -76,7 +75,8 @@
         }, //
         job_control::JOB_IRQ_CLEAR,
     },
-    vm::Vm, //
+    vm::Vm,
+    vm::VmRegistry, //
 };
 
 mod interfaces;
@@ -174,6 +174,9 @@ pub(crate) struct Firmware<'drm> {
     /// MCU VM.
     vm: Arc<Vm<'drm>>,
 
+    /// VM registry, used to unregister `vm` on drop.
+    vm_registry: Arc<VmRegistry<'drm>>,
+
     /// List of firmware sections.
     sections: KVec<Section<'drm>>,
 
@@ -195,6 +198,7 @@ fn drop(self: Pin<&mut Self>) {
         let _ = self.stop();
 
         // AS slots retain a VM ref, we need to kill the circular ref manually.
+        self.vm_registry.unregister(&self.vm);
         self.vm.kill();
     }
 }
@@ -251,12 +255,18 @@ pub(crate) fn new(
         iomem: Arc<IoMem<'drm>>,
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
+        vm_registry: Arc<VmRegistry<'drm>>,
         gpu_info: &GpuInfo,
     ) -> Result<Arc<Firmware<'drm>>> {
         let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
-        vm.activate()?;
+        if let Err(e) = vm_registry.register(vm.clone()) {
+            dev_warn!(dev, "failed to register VM: {e:?}\n");
+        }
+        let registry = vm_registry.clone();
 
         let result = (|| {
+            vm.activate()?;
+
             let vm = &vm;
             let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
             let mut sections = KVec::new();
@@ -291,6 +301,7 @@ pub(crate) fn new(
                 try_pin_init!(Firmware {
                     iomem,
                     vm: vm.clone(),
+                    vm_registry: registry,
                     sections,
                     global_iface <- new_mutex!(GlobalInterface::new()?),
                     job_irq_wait: Arc::pin_init(new_waitqueue!(), GFP_KERNEL)?,
@@ -301,6 +312,7 @@ pub(crate) fn new(
         })();
 
         if result.is_err() {
+            vm_registry.unregister(&vm);
             vm.kill();
         }
 
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 74c3d6c8efc49..690d08b8aa901 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -311,6 +311,34 @@ pub(crate) struct GpuVmData<'drm> {
     _phantom: PhantomData<&'drm ()>,
 }
 
+/// Tracks all VMs for this device.
+#[pin_data]
+pub(crate) struct VmRegistry<'drm> {
+    #[pin]
+    vms: Mutex<KVec<Arc<Vm<'drm>>>>,
+}
+
+impl<'drm> VmRegistry<'drm> {
+    pub(crate) fn new() -> impl PinInit<Self> {
+        pin_init!(Self { vms <- new_mutex!(KVec::new()) })
+    }
+
+    pub(crate) fn register(&self, vm: Arc<Vm<'drm>>) -> Result {
+        Ok(self.vms.lock().push(vm, GFP_KERNEL)?)
+    }
+
+    pub(crate) fn unregister(&self, vm: &Vm<'drm>) {
+        self.vms.lock().retain(|v| !core::ptr::eq(&**v, vm));
+    }
+
+    pub(crate) fn for_each(&self, mut f: impl FnMut(&Vm<'drm>) -> Result) -> Result {
+        for vm in self.vms.lock().iter() {
+            f(vm)?;
+        }
+        Ok(())
+    }
+}
+
 /// GPU virtual address space.
 ///
 /// Each VM can be mapped into a hardware address space slot.
@@ -401,6 +429,11 @@ pub(crate) fn activate(&self) -> Result {
             })
     }
 
+    /// Dumps GPU VA space info into a seq_file.
+    pub(crate) fn dump_gpuva_info(&self, m: &kernel::seq_file::SeqFile) -> Result {
+        self.gpuvm_unique.lock().dump_gpuva_info(m)
+    }
+
     /// Deactivate the VM by evicting it from its address space slot.
     fn deactivate(&self) -> Result {
         self.mmu.deactivate_vm(&self.as_data).inspect_err(|e| {

-- 
2.43.0


