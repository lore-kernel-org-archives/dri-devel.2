Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BB606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ds91mDRD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C37610E204;
	Thu, 26 Nov 2026 20:46:55 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E1810E0E1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795726006; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LJMlbpytMkIyPev2CDE2n1g89s8TKpLiiaXHOrCPCLdqfEUdGeg4lFNi97n6GF/pKewDodXH+oJvtIJNpCQnviSyiERsujRGBw4pZHYSAcwLpIU5w81FsaElFCU7zdcIUfS28QPMx7JYnvAroUjqmMd8tSy1yqJZlrpq9JT11k8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795726006;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7skOuYzYPTry/TblpYJR9UAACaIhegaKxC50HTc/l38=; 
 b=Cn46JgpsOtaK0NN/shdfZXr0OMUmVXLjIeY0JGipQ4eXXUoXSTR6TCLtx0ocgj3wR6lzeWLTlr+2348taENoIPPiKNnL3+oqI+j/nIr3mOhid/g7MvyjR76AnCs2QVDbv7ZYfBieD+8LsC8cTICRmWSwtvD9cilzYSZrA4oGi1o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Ds91mDRDQmnDJYklSX21AT3u9i8jv8tNbnuMxmAegeCzPQBx3zcaR6NTdeo1nufRBfoWZ/6zVSSA8qcOrajCCoa8g9ZkCz24Ms9Znt2r2Pkcf6BhWXZQMoLcekZhfcnHeFHDdvd5PH1zUSHtjzxiZqDuR2bmXIojutFfViRYDSI=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=7skOuYzYPTry/TblpYJR9UAACaIhegaKxC50HTc/l38=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179572600353920.21911314558963;
 Thu, 26 Nov 2026 12:46:43 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 26 Nov 2026 17:44:40 -0300
Subject: [PATCH] rust: drm: gpuvm: store the driver data in UniqueRefGpuVm
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-gpuvm-data-in-handle-v1-1-47b1e9928f20@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1gZMkSy8yuCittGJOFVaFUG8u
 3VcfvDef0KSqJKgKU6IsmvSOWRQWYD72jAIqs8GUxkmMozDsu0/9Ha1qAHzxE+CrqurmiwzCUO
 +LlF6Pf7ZT/s6bd0obn1acF03PoS2IngAAAA=
X-Change-ID: 20261126-gpuvm-data-in-handle-cb4041a661e6
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthew Leach <matthew.leach@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GpuVm<T> keeps the driver data in an UnsafeCell<T> inside the
refcounted allocation, and UniqueRefGpuVm hands it out through unsafe
accessors. Only UniqueRefGpuVm accesses the data, so it does not need
to live in the shared allocation.

Move the data into UniqueRefGpuVm, which turns data() and data_mut()
into plain field accesses. GpuVm<T> keeps a PhantomData<*mut T> so that
it stays invariant in T without the UnsafeCell.

The data is now dropped with UniqueRefGpuVm rather than when the last
reference to the GpuVm goes away, and UniqueRefGpuVm is Unpin only if T
is.

Suggested-by: Matthew Leach <matthew.leach@collabora.com>
Suggested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/drm/gpuvm/mod.rs | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index 23e73da865fb..d3b11e2a39d5 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -28,7 +28,6 @@
 };
 
 use core::{
-    cell::UnsafeCell,
     marker::PhantomData,
     mem::{
         ManuallyDrop,
@@ -62,22 +61,21 @@
 /// # Invariants
 ///
 /// * Stored in an allocation managed by the refcount in `self.vm`.
-/// * Access to `data` and the gpuvm interval tree is controlled via the [`UniqueRefGpuVm`] type.
+/// * Access to the gpuvm interval tree is controlled via the [`UniqueRefGpuVm`] type.
 /// * Does not contain any sparse [`GpuVa<T>`] instances.
 #[pin_data]
 pub struct GpuVm<T: DriverGpuVm> {
     #[pin]
     vm: Opaque<bindings::drm_gpuvm>,
-    /// Accessed only through the [`UniqueRefGpuVm`] reference.
-    data: UnsafeCell<T>,
+    _invariant: PhantomData<*mut T>,
 }
 
 // SAFETY: It is safe to send a `GpuVm<T>` to another thread: all data reachable through it
-// (`T`, `T::VmBoData`, and the GEM `T::Object`) is `Send` by the `DriverGpuVm` bounds.
+// (`T::VmBoData` and the GEM `T::Object`) is `Send` by the `DriverGpuVm` bounds.
 unsafe impl<T: DriverGpuVm> Send for GpuVm<T> {}
 // SAFETY: It is safe to share a `&GpuVm<T>` between threads: `&self` methods only alias data
-// that is `Sync` by the `DriverGpuVm` bounds, and any thread may drop that data, or upgrade the
-// reference and ultimately drop `T`, which the same bounds make `Send`.
+// that is `Sync` by the `DriverGpuVm` bounds, and any thread may drop that data, which the same
+// bounds make `Send`.
 unsafe impl<T: DriverGpuVm> Sync for GpuVm<T> {}
 
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.vm`.
@@ -132,7 +130,7 @@ pub fn new<E, Ctx: drm::DeviceContext>(
     {
         let obj = KBox::try_pin_init::<E>(
             try_pin_init!(Self {
-                data: UnsafeCell::new(data),
+                _invariant: PhantomData,
                 vm <- Opaque::ffi_init(|vm| {
                     // SAFETY: These arguments are valid. `vm` is valid until refcount drops to
                     // zero. The `vm` is zeroed before calling this method by `__GFP_ZERO` flag
@@ -163,7 +161,7 @@ pub fn new<E, Ctx: drm::DeviceContext>(
             )))
         };
         // INVARIANT: This reference is unique.
-        Ok(UniqueRefGpuVm(aref))
+        Ok(UniqueRefGpuVm { vm: aref, data })
     }
 
     /// Access this [`GpuVm`] from a raw pointer.
@@ -298,29 +296,28 @@ fn sm_step_remap<'op, 'ctx>(
 
 /// The core of the DRM GPU VA manager.
 ///
-/// This object is a unique reference to the VM that can access the interval tree and the Rust
-/// `data` field.
+/// This object is a unique reference to the VM that can access the interval tree. It also owns
+/// the Rust `data` field.
 ///
 /// # Invariants
 ///
 /// Each `GpuVm` instance has at most one `UniqueRefGpuVm` reference.
-// `Send`/`Sync` derive from `ARef<GpuVm<T>>`; the trait bounds make them correct for the unique
-// handle's `&mut T` access.
-pub struct UniqueRefGpuVm<T: DriverGpuVm>(ARef<GpuVm<T>>);
+pub struct UniqueRefGpuVm<T: DriverGpuVm> {
+    vm: ARef<GpuVm<T>>,
+    data: T,
+}
 
 impl<T: DriverGpuVm> UniqueRefGpuVm<T> {
     /// Access the data owned by this `UniqueRefGpuVm` immutably.
     #[inline]
     pub fn data(&self) -> &T {
-        // SAFETY: By the type invariants we may access `data`.
-        unsafe { &*self.0.data.get() }
+        &self.data
     }
 
     /// Access the data owned by this `UniqueRefGpuVm` mutably.
     #[inline]
     pub fn data_mut(&mut self) -> &mut T {
-        // SAFETY: By the type invariants we may access `data`.
-        unsafe { &mut *self.0.data.get() }
+        &mut self.data
     }
 }
 
@@ -329,6 +326,6 @@ impl<T: DriverGpuVm> Deref for UniqueRefGpuVm<T> {
 
     #[inline]
     fn deref(&self) -> &GpuVm<T> {
-        &self.0
+        &self.vm
     }
 }

---
base-commit: 94c9ad2fd7a15f58782c50e471397d1efe6b6363
change-id: 20261126-gpuvm-data-in-handle-cb4041a661e6

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

