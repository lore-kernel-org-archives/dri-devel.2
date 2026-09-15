Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B23C88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3BF10F412;
	Tue, 15 Sep 2026 10:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oPTvglxf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD9110F404
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469924;
 bh=sBlK784vZ/oqRMvO5qMK02PMD1Gt0+oIJw0QmxBvQ2A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oPTvglxf1y1Q5InX+Qtm4qblgd5bYGkk/CBKck5i5h0bb1eIQi5EkqiOdxBQtxLus
 KpkBNnHPvBecAmROpFK3kKYz3SvRS51+nmJZMf/bUR+K1HF23Z7RfERzlsMoADFlE+
 L4IEYMO/Q6+s1Imgj4xRuvb9lJkOEufpKML/typHwrOj1RtrXLDfUTfUpKn+ehd67M
 x58/UJ6BuQmNa34V7R2c3cIUU/8uJS8OrOVUuxfgW4vvw9VPrnsgjN+scMG1OwCmTK
 ZGiONEJ1SMVfdFGVL/rhsG0YUeofmpUFfCSmpV+G5veyjErwKgIQhiIgaPMfFZ1Bme
 V/VNc8dPg28pQ==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0053617E0A27;
 Tue, 15 Sep 2026 12:58:43 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Tue, 15 Sep 2026 12:57:36 +0200
Subject: [PATCH 3/9] drm/tyr: add MappedBo, a kernel BO with an
 always-valid CPU mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-tyr-interfaces-v1-3-5d28f1f75aca@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.14.3
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

From: Daniel Almeida <daniel.almeida@collabora.com>

Firmware sections need CPU access at well-defined points: once at load
time to copy the section payload in, and, for the shared section, for
the lifetime of the driver to talk to the CSF interface blocks.

Introduce MappedBo, which pairs a KernelBo with one persistent vmap so
the GPU mapping and the CPU mapping share a single lifetime, and hold it
in Section instead of the bare KernelBo. Section payload initialization
now writes through the persistent mapping.

This is the foundation for resolving firmware-reported MCU virtual
addresses into validated views of the shared section: the object that
owns both mappings is the natural place for those checks to live.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/fw.rs  | 14 ++++++-------
 drivers/gpu/drm/tyr/gem.rs | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 19bdeee858ce..fb4d47ab35a3 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -144,7 +144,7 @@ struct Section<'drm> {
     // Keep the BO backing this firmware section so that both the
     // GPU mapping and CPU mapping remain valid until the Section is dropped.
     #[expect(dead_code)]
-    mem: gem::KernelBo<'drm>,
+    mem: Arc<gem::MappedBo<'drm>>,
 }
 
 /// Loaded firmware with sections mapped into MCU VM.
@@ -171,13 +171,13 @@ fn drop(&mut self) {
 }
 
 impl<'drm> Firmware<'drm> {
-    fn init_section_mem(dev: &Device, mem: &mut KernelBo<'drm>, data: &KVec<u8>) -> Result {
+    fn init_section_mem(dev: &Device, mem: &gem::MappedBo<'drm>, data: &KVec<u8>) -> Result {
         if data.is_empty() {
             return Ok(());
         }
 
-        let vmap = mem.bo().vmap::<0>()?;
-        let size = mem.bo().size();
+        let vmap = mem.vmap();
+        let size = mem.size();
 
         if data.len() > size {
             dev_err!(dev, "fw section {} bigger than BO {}", data.len(), size);
@@ -235,13 +235,13 @@ pub(crate) fn new(
 
                 let va = u64::from(parsed.va.start);
 
-                let mut mem = KernelBo::new(
+                let mem = gem::MappedBo::new(KernelBo::new(
                     ddev,
                     vm.clone(),
                     size,
                     KernelBoVaAlloc::Explicit(va),
                     parsed.vm_map_flags,
-                )?;
+                )?)?;
 
                 let section_start = parsed.data_range.start as usize;
                 let section_end = parsed.data_range.end as usize;
@@ -252,7 +252,7 @@ pub(crate) fn new(
                 let bytes = fw_data.get(section_start..section_end).ok_or(EINVAL)?;
                 data.extend_from_slice(bytes, GFP_KERNEL)?;
 
-                Self::init_section_mem(dev, &mut mem, &data)?;
+                Self::init_section_mem(dev, &mem, &data)?;
 
                 sections.push(Section { data, mem }, GFP_KERNEL)?;
             }
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 3bf3787f5c3f..4763b5b2cd80 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -136,6 +136,12 @@ pub(crate) fn new(
     pub(crate) fn bo(&self) -> &Bo {
         &self.bo
     }
+
+    /// Returns the GPU virtual address range occupied by this buffer.
+    #[expect(dead_code)]
+    pub(crate) fn va_range(&self) -> Range<u64> {
+        self.va_range.clone()
+    }
 }
 
 impl Drop for KernelBo<'_> {
@@ -158,3 +164,46 @@ fn drop(&mut self) {
         }
     }
 }
+
+/// A kernel-owned buffer object with an always-valid kernel (CPU) mapping.
+///
+/// This pairs a [`KernelBo`] with a persistent vmap of its backing GEM object,
+/// so the GPU mapping and the CPU mapping share one lifetime. Consumers that
+/// need CPU access to the buffer contents (e.g. the firmware interface blocks
+/// in the CSF shared section) hold an `Arc<MappedBo>` instead of creating
+/// short-lived vmaps at every use site.
+pub(crate) struct MappedBo<'drm> {
+    /// Persistent CPU mapping of `kernel_bo`'s backing object.
+    ///
+    /// Declared before `kernel_bo` so the mapping is dropped first.
+    vmap: shmem::VMapOwned<BoData>,
+    /// The underlying kernel-owned buffer object.
+    #[expect(dead_code)]
+    kernel_bo: KernelBo<'drm>,
+}
+
+impl<'drm> MappedBo<'drm> {
+    /// Wraps `kernel_bo` together with a persistent CPU mapping of its buffer.
+    pub(crate) fn new(kernel_bo: KernelBo<'drm>) -> Result<Arc<Self>> {
+        let vmap = kernel_bo.bo.owned_vmap::<0>()?;
+        Ok(Arc::new(Self { vmap, kernel_bo }, GFP_KERNEL)?)
+    }
+
+    /// Returns the persistent CPU mapping of the buffer.
+    pub(crate) fn vmap(&self) -> &shmem::VMapOwned<BoData> {
+        &self.vmap
+    }
+
+    /// Returns the GPU virtual address range occupied by the buffer.
+    pub(crate) fn va_range(&self) -> Range<u64> {
+        self.kernel_bo.va_range()
+    }
+}
+
+impl core::ops::Deref for MappedBo<'_> {
+    type Target = Bo;
+
+    fn deref(&self) -> &Bo {
+        self.vmap.owner()
+    }
+}

-- 
2.39.5

