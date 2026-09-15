Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D2D10FA7D;
	Tue, 15 Sep 2026 10:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CToUZsrj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AC710F404
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469926;
 bh=RYam+s9Kgd5lvNnILOHmMbDFLyGmaCpMwz6u/InFJ7I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CToUZsrjZgAMkBmJRtHwkLk9Hl3Lgk44U1VuYGwOOQ9xVp/dnDI27kt17V5MVTmza
 S+VKtgIiGKUyeb88IVPSdK5g7gtmsPmecyO8lu+g6EdOhiMZGdCwRVNiPbYw8sL8Oj
 HNJDpn3DRdl2Vq9dAFuqIPnACM/c+T+IgQBBPZ5T/lR6KDBBTjK2Jc89kEeq1d8Yp5
 0Hv20UPsGY7UyWjRN0OFcnh4ZFM2upD9qE9RTR0rT6eEpIFHRcXs5ylm1qasP9rZS9
 To/OxdDzb4Y/ltG+2ZPH71vqir5Y3bylFG3fCWux4JFJTn2wRt4e7JcJ48ZDMS3ZBM
 gBxhO5masr51w==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C4F817E0CFC;
 Tue, 15 Sep 2026 12:58:45 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Tue, 15 Sep 2026 12:57:37 +0200
Subject: [PATCH 4/9] drm/tyr: add McuVa and claim-checked MappedBo views
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-tyr-interfaces-v1-4-5d28f1f75aca@collabora.com>
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

MappedBo currently hands out its CPU vmap directly, so any code writing
into it does its own bounds checking (or none), and there is no way to
express a validated window without leaking the raw mapping.

Introduce two types, in preparation for the CSF firmware interface,
which will resolve MCU-address register fields into typed windows of a
MappedBo:
- McuVa: a newtype over u32 marking that the integer is an address in
the MCU's 32-bit address space. This is what register fields will store
and what the hardware is handed. MappedBo construction rejects buffers
extending past the 32-bit MCU space, guaranteeing that a validated
window's address always fits back into a McuVa.
- MappedBoView / MappedBoViewMut: the resolved form. Created by
MappedBo::try_view()/try_view_mut(), which validate a (va, len) window
in one place: the window must be non-empty, fit within both the GPU VA
range and the CPU mapping (so the safety argument stays local to
MappedBo), and have a properly aligned CPU address (since the vmap base
is already page-aligned per VMap's invariants, this just comes down to
checking the offset's alignment). A window's reach may exceed its length
when a consumer's type carries alignment tail padding: the padding must
be mapped, but it doesn't count toward the VA-range bounds or the write
claims. A malformed address is rejected with EINVAL at resolve time.

MappedBoView is the read-side view: it's freely cloneable, since
overlapping readers on a block are harmless. MappedBoViewMut is the
write-side view: it takes an exclusive claim on its byte range at
construction (EBUSY on overlap, released on drop) and is deliberately
not Clone, since the value it holds is the write capability. Together
with &mut-based writer methods, this is meant to make "at most one
writer per window" a property enforced across the whole driver at
discovery time, so coarse locking around future firmware interface won't
be required.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/fw.rs  |  19 +--
 drivers/gpu/drm/tyr/gem.rs | 306 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 308 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index fb4d47ab35a3..76d19667d23a 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -171,12 +171,11 @@ fn drop(&mut self) {
 }
 
 impl<'drm> Firmware<'drm> {
-    fn init_section_mem(dev: &Device, mem: &gem::MappedBo<'drm>, data: &KVec<u8>) -> Result {
+    fn init_section_mem(dev: &Device, mem: &Arc<gem::MappedBo<'drm>>, data: &KVec<u8>) -> Result {
         if data.is_empty() {
             return Ok(());
         }
 
-        let vmap = mem.vmap();
         let size = mem.size();
 
         if data.len() > size {
@@ -184,11 +183,17 @@ fn init_section_mem(dev: &Device, mem: &gem::MappedBo<'drm>, data: &KVec<u8>) ->
             return Err(EINVAL);
         }
 
-        for (i, &byte) in data.iter().enumerate() {
-            vmap.try_write8(byte, i)?;
-        }
-
-        Ok(())
+        // Claim the payload extent for the duration of the copy. No
+        // interface views exist yet at this point, and the claim releases
+        // on drop, so this cannot conflict; it just keeps every write in
+        // the driver on the exclusive, claim-checked path.
+        let mut view = mem.try_view_mut(
+            mem.va_range().start.try_into()?,
+            data.len() as u64,
+            data.len() as u64,
+        )?;
+
+        view.write_bytes(0, data)
     }
 
     fn request(ddev: &TyrDrmDevice, gpu_info: &GpuInfo) -> Result<kernel::firmware::Firmware> {
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 4763b5b2cd80..6ae4e71d3cbf 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -9,12 +9,21 @@
 use kernel::{
     drm::gem::{
         self,
-        shmem, //
+        shmem,
+        BaseObject, //
     },
+    io::{
+        Io,
+        IoBase,
+        Region,
+        SysMem, //
+    },
+    new_mutex,
     prelude::*,
     sync::{
         aref::ARef,
-        Arc, //
+        Arc,
+        Mutex, //
     }, //
 };
 
@@ -138,7 +147,6 @@ pub(crate) fn bo(&self) -> &Bo {
     }
 
     /// Returns the GPU virtual address range occupied by this buffer.
-    #[expect(dead_code)]
     pub(crate) fn va_range(&self) -> Range<u64> {
         self.va_range.clone()
     }
@@ -165,6 +173,35 @@ fn drop(&mut self) {
     }
 }
 
+/// A virtual address in the MCU's address space.
+///
+/// The MCU address space is 32 bits wide. A value of this type is only a
+/// claim: it carries no proof of validity. Resolve it against a [`MappedBo`]
+/// with [`MappedBo::try_view`] or [`MappedBo::try_view_mut`] before use;
+/// past that point, code should carry the resulting view, not the address.
+#[derive(Clone, Copy, PartialEq, Eq, Debug)]
+pub(crate) struct McuVa(u32);
+
+impl From<u32> for McuVa {
+    fn from(va: u32) -> Self {
+        Self(va)
+    }
+}
+
+impl From<McuVa> for u64 {
+    fn from(va: McuVa) -> u64 {
+        u64::from(va.0)
+    }
+}
+
+impl TryFrom<u64> for McuVa {
+    type Error = Error;
+
+    fn try_from(va: u64) -> Result<Self> {
+        Ok(Self(u32::try_from(va).map_err(|_| EINVAL)?))
+    }
+}
+
 /// A kernel-owned buffer object with an always-valid kernel (CPU) mapping.
 ///
 /// This pairs a [`KernelBo`] with a persistent vmap of its backing GEM object,
@@ -172,32 +209,176 @@ fn drop(&mut self) {
 /// need CPU access to the buffer contents (e.g. the firmware interface blocks
 /// in the CSF shared section) hold an `Arc<MappedBo>` instead of creating
 /// short-lived vmaps at every use site.
+///
+/// `MappedBo` is also the resolver for firmware-reported MCU virtual
+/// addresses: [`MappedBo::try_view`] and [`MappedBo::try_view_mut`]
+/// validate a `(va, len)` window once. It checks bounds against both
+/// mappings, alignment, and (for write views) non-overlap with every other
+/// write view and return a proof-carrying view, so no unvalidated address
+/// circulates past this point.
+#[pin_data]
 pub(crate) struct MappedBo<'drm> {
     /// Persistent CPU mapping of `kernel_bo`'s backing object.
     ///
     /// Declared before `kernel_bo` so the mapping is dropped first.
     vmap: shmem::VMapOwned<BoData>,
     /// The underlying kernel-owned buffer object.
-    #[expect(dead_code)]
     kernel_bo: KernelBo<'drm>,
+    /// Byte ranges (in MCU VA space) handed out as exclusive write views.
+    ///
+    /// Touched only when views are created (discovery) and dropped
+    /// (teardown), never on an access path, so a plain mutex around a
+    /// linearly-scanned vector is sufficient.
+    #[pin]
+    claims: Mutex<KVec<Range<u64>>>,
 }
 
+// SAFETY: `MappedBo` may move between threads: the CPU mapping's address is
+// valid from any thread; `KernelBo`'s teardown (GPU unmap through `Arc<Vm>`
+// and the GEM object release) goes through thread-safe C APIs; and the only
+// interior mutability (`claims`) is mutex-protected.
+unsafe impl Send for MappedBo<'_> {}
+// SAFETY: `&MappedBo` exposes the mutex-protected claims table, the `Deref`
+// surface to the GEM object (thread-safe C APIs), and the mapping itself,
+// whose contents are only ever accessed through volatile operations. The
+// memory is shared with the MCU by design, so concurrent access is part of
+// the model rather than a race the type system must rule out.
+unsafe impl Sync for MappedBo<'_> {}
+
 impl<'drm> MappedBo<'drm> {
     /// Wraps `kernel_bo` together with a persistent CPU mapping of its buffer.
     pub(crate) fn new(kernel_bo: KernelBo<'drm>) -> Result<Arc<Self>> {
-        let vmap = kernel_bo.bo.owned_vmap::<0>()?;
-        Ok(Arc::new(Self { vmap, kernel_bo }, GFP_KERNEL)?)
-    }
+        // The MCU address space is 32 bits wide; every window resolved from
+        // this buffer reports its address as a `McuVa`, so the whole range
+        // must fit (`gpu_va()` on the views relies on this).
+        if kernel_bo.va_range().end > u64::from(u32::MAX) + 1 {
+            return Err(EINVAL);
+        }
 
-    /// Returns the persistent CPU mapping of the buffer.
-    pub(crate) fn vmap(&self) -> &shmem::VMapOwned<BoData> {
-        &self.vmap
+        let vmap = kernel_bo.bo.owned_vmap::<0>()?;
+        Arc::pin_init(
+            try_pin_init!(Self {
+                vmap,
+                kernel_bo,
+                claims <- new_mutex!(KVec::new()),
+            }),
+            GFP_KERNEL,
+        )
     }
 
     /// Returns the GPU virtual address range occupied by the buffer.
     pub(crate) fn va_range(&self) -> Range<u64> {
         self.kernel_bo.va_range()
     }
+
+    /// Returns the CPU address of the mapping's start.
+    pub(crate) fn cpu_base(&self) -> usize {
+        (&self.vmap).as_view().as_ptr() as *const u8 as usize
+    }
+
+    /// Validates that `va..va + len` is a well-formed window of this buffer.
+    ///
+    /// On success the returned range is in bounds of both the GPU VA range
+    /// and the CPU mapping, and its CPU address is at least 4-byte aligned.
+    fn resolve(&self, va: McuVa, len: u64, reach: u64) -> Result<Range<u64>> {
+        let start = u64::from(va);
+        let end = start.checked_add(len).ok_or(EINVAL)?;
+        let buf = self.va_range();
+
+        if len == 0 || reach < len {
+            return Err(EINVAL);
+        }
+
+        if start < buf.start || end > buf.end {
+            pr_err!(
+                "MCU VA window [{:#x}..{:#x}) outside the buffer [{:#x}..{:#x})\n",
+                start,
+                end,
+                buf.start,
+                buf.end
+            );
+            return Err(EINVAL);
+        }
+
+        // Also ground the invariant in the CPU mapping itself: the backing
+        // GEM object can only be page-rounded up from the mapped size, but
+        // checking here keeps the views' safety argument local to this type.
+        //
+        // `reach` may exceed `len` when the consumer's *type* has alignment
+        // tail padding past the architectural window (e.g. a layout struct
+        // with 64-bit registers): the padding bytes must be mapped so a
+        // typed view over the window is valid, but they participate in
+        // neither the VA-range bounds above nor the write claims.
+        let offset = start - buf.start;
+        if offset.checked_add(reach).ok_or(EINVAL)? > self.size() as u64 {
+            return Err(EINVAL);
+        }
+
+        // The vmap base is page-aligned per `VMap`'s type invariants, so the
+        // CPU-address alignment of the window reduces to the offset's.
+        if offset % 4 != 0 {
+            pr_err!("MCU VA window {:#x} is not register-aligned\n", start);
+            return Err(EINVAL);
+        }
+
+        Ok(start..end)
+    }
+
+    /// Resolves a firmware-reported window into a shared (read-side) view.
+    ///
+    /// Intended for blocks the firmware writes and the host only reads;
+    /// read-read overlap is harmless, so these views are freely cloneable
+    /// and no claim is taken.
+    #[expect(dead_code)]
+    pub(crate) fn try_view(
+        self: &Arc<Self>,
+        va: McuVa,
+        len: u64,
+        reach: u64,
+    ) -> Result<MappedBoView<'drm>> {
+        let range = self.resolve(va, len, reach)?;
+
+        Ok(MappedBoView {
+            bo: self.clone(),
+            range,
+        })
+    }
+
+    /// Resolves a firmware-reported window into an exclusive (write-side)
+    /// view.
+    ///
+    /// At most one write view exists per byte of the buffer at any time:
+    /// overlap with a live write view fails with `EBUSY`. This is what makes
+    /// `&mut`-based writer discipline a whole-driver property rather than a
+    /// per-object one.
+    pub(crate) fn try_view_mut(
+        self: &Arc<Self>,
+        va: McuVa,
+        len: u64,
+        reach: u64,
+    ) -> Result<MappedBoViewMut<'drm>> {
+        let range = self.resolve(va, len, reach)?;
+        let mut claims = self.claims.lock();
+
+        if claims
+            .iter()
+            .any(|c| c.start < range.end && range.start < c.end)
+        {
+            pr_err!(
+                "MCU VA window [{:#x}..{:#x}) overlaps an existing write view\n",
+                range.start,
+                range.end
+            );
+            return Err(EBUSY);
+        }
+
+        claims.push(range.clone(), GFP_KERNEL)?;
+
+        Ok(MappedBoViewMut {
+            bo: self.clone(),
+            range,
+        })
+    }
 }
 
 impl core::ops::Deref for MappedBo<'_> {
@@ -207,3 +388,108 @@ fn deref(&self) -> &Bo {
         self.vmap.owner()
     }
 }
+
+/// A validated, shared (read-side) window into a [`MappedBo`], addressed in
+/// MCU VA space.
+///
+/// # Invariants
+///
+/// `range` lies within the buffer's GPU VA range and its CPU mapping, and
+/// the CPU address of `range.start` is at least 4-byte aligned (established
+/// by [`MappedBo::resolve`]).
+#[derive(Clone)]
+pub(crate) struct MappedBoView<'drm> {
+    bo: Arc<MappedBo<'drm>>,
+    range: Range<u64>,
+}
+
+/// A validated, exclusive (write-side) window into a [`MappedBo`].
+///
+/// Deliberately not `Clone`: the value is the write capability for its
+/// window. The claim taken at construction is released on drop.
+///
+/// # Invariants
+///
+/// As for [`MappedBoView`]; additionally, no other `MappedBoViewMut`
+/// overlapping `range` exists.
+pub(crate) struct MappedBoViewMut<'drm> {
+    bo: Arc<MappedBo<'drm>>,
+    range: Range<u64>,
+}
+
+macro_rules! impl_view_accessors {
+    ($ty:ident) => {
+        impl<'drm> $ty<'drm> {
+            /// Returns the MCU virtual address of the window: the value to
+            /// hand to the firmware or GPU when it must address this memory.
+            #[expect(dead_code)]
+            pub(crate) fn gpu_va(&self) -> McuVa {
+                // Cannot overflow u32: `MappedBo::new` rejects buffers
+                // extending past the 32-bit MCU address space, and this
+                // window lies within the buffer.
+                McuVa(self.range.start as u32)
+            }
+
+            /// Returns the length of the window in bytes.
+            #[allow(dead_code)]
+            pub(crate) fn len(&self) -> u64 {
+                self.range.end - self.range.start
+            }
+
+            /// Returns the window's byte offset within the CPU mapping.
+            #[allow(dead_code)]
+            pub(crate) fn cpu_offset(&self) -> usize {
+                (self.range.start - self.bo.va_range().start) as usize
+            }
+
+            /// Returns the I/O view of the whole underlying mapping, for
+            /// projection to this window.
+            #[expect(dead_code)]
+            pub(crate) fn parent_view(&self) -> SysMem<'_, Region<0>> {
+                (&self.bo.vmap).as_view()
+            }
+
+            /// Returns the CPU address of the window's start.
+            #[expect(dead_code)]
+            pub(crate) fn cpu_addr(&self) -> usize {
+                self.bo.cpu_base() + self.cpu_offset()
+            }
+        }
+    };
+}
+
+impl_view_accessors!(MappedBoView);
+impl_view_accessors!(MappedBoViewMut);
+
+impl MappedBoViewMut<'_> {
+    /// Writes `data` at `offset` within the window.
+    ///
+    /// This is the only byte-level write path to the buffer, so every write
+    /// in the driver goes through an exclusive, claim-checked capability.
+    pub(crate) fn write_bytes(&mut self, offset: usize, data: &[u8]) -> Result {
+        let end = offset.checked_add(data.len()).ok_or(EINVAL)?;
+
+        if end as u64 > self.len() {
+            return Err(EINVAL);
+        }
+
+        let base = self.cpu_offset().checked_add(offset).ok_or(EINVAL)?;
+        for (i, &byte) in data.iter().enumerate() {
+            self.bo.vmap.try_write8(byte, base + i)?;
+        }
+
+        Ok(())
+    }
+}
+
+impl Drop for MappedBoViewMut<'_> {
+    fn drop(&mut self) {
+        let mut claims = self.bo.claims.lock();
+
+        if let Some(i) = claims.iter().position(|c| *c == self.range) {
+            // Removing from the claim vector does not allocate, so this is
+            // safe on any drop path.
+            let _ = claims.remove(i);
+        }
+    }
+}

-- 
2.39.5

