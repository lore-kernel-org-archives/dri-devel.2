Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C645DFD874D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F76F10E620;
	Tue, 17 Mar 2026 12:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="GsXFthx3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103D710E620
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:05:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 59B1E600AD;
 Tue, 17 Mar 2026 12:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFCB1C2BC86;
 Tue, 17 Mar 2026 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1773749104; bh=1cQPW0r6BS+eEjsyt0XQrJVhTMBdg77G847AwAAPoC0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GsXFthx3981WkPcU81gMe2b5lwdU2tTbrQO6TDA909fUYNnRpDUfYLztkqptsS6zM
 Mlmg6I3r3IsVU8mkza/Oef5nVPY0H4D0gFDTX+ib2W0SpfCOPDWnxGNztpzIHENxks
 mFs3HK7qik6r1ExxPpme5afRyn/AbHqmALjYhwA8=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DFC20FD874D;
 Tue, 17 Mar 2026 12:05:03 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 17 Mar 2026 20:03:40 +0800
Subject: [PATCH 1/2] drm/gpuvm: add name(), RawGpuVa and kernel_alloc_va()
 for debugfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-gpuvm-helpers-v1-1-00198fc6eeea@linux.dev>
References: <20260317-gpuvm-helpers-v1-0-00198fc6eeea@linux.dev>
In-Reply-To: <20260317-gpuvm-helpers-v1-0-00198fc6eeea@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773749102; l=3053;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=1cQPW0r6BS+eEjsyt0XQrJVhTMBdg77G847AwAAPoC0=;
 b=hh3kP7Y+s26EUoQhcpPxRgdgkUcG/PQdcv6jvZUjcOpTa4Z89lKBGQWiaxADRQ+xtqmq3Ho8t
 Iz8745X0a90DQLQpljwK0yppC3Y2hiOl/ca4gWzihv26LqfunalJSZx
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

Expose GPU VM name and kernel-reserved VA so drivers can dump GPU VA
state in debugfs.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/drm/gpuvm/mod.rs | 14 ++++++++++++++
 rust/kernel/drm/gpuvm/va.rs  | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index 20e512842dfc6..3186df9f740cf 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -165,6 +165,13 @@ pub fn as_raw(&self) -> *mut bindings::drm_gpuvm {
         self.vm.get()
     }
 
+    /// Returns the name of this GpuVm.
+    #[inline]
+    pub fn name(&self) -> &CStr {
+        // SAFETY: The `name` field is immutable and points to a NUL-terminated string.
+        unsafe { CStr::from_char_ptr((*self.as_raw()).name) }
+    }
+
     /// The start of the VA space.
     #[inline]
     pub fn va_start(&self) -> u64 {
@@ -188,6 +195,13 @@ pub fn va_range(&self) -> Range<u64> {
         Range { start, end }
     }
 
+    /// Returns the kernel-allocated VA for this GpuVm.
+    #[inline]
+    pub fn kernel_alloc_va(&self) -> &RawGpuVa {
+        // SAFETY: The `self.as_raw()` is guaranteed to be a valid pointer to a drm_gpuvm.
+        unsafe { RawGpuVa::from_raw(&raw mut (*self.as_raw()).kernel_alloc_node) }
+    }
+
     /// Get or create the [`GpuVmBo`] for this gem object.
     #[inline]
     pub fn obtain(
diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
index a31122ff22282..8b8fd500b3c5f 100644
--- a/rust/kernel/drm/gpuvm/va.rs
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -81,6 +81,43 @@ pub fn vm_bo(&self) -> &GpuVmBo<T> {
     }
 }
 
+/// Represents that a range of a GEM object is mapped in the kernel.
+#[repr(transparent)]
+pub struct RawGpuVa(Opaque<bindings::drm_gpuva>);
+
+impl RawGpuVa {
+    /// Access this [`RawGpuVa`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// For the duration of `'a`, the pointer must reference a valid `drm_gpuva`.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_gpuva) -> &'a Self {
+        // SAFETY: `drm_gpuva` and `RawGpuVa` have the same layout.
+        unsafe { &*(ptr.cast()) }
+    }
+
+    /// Returns a raw pointer to underlying C value.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::drm_gpuva {
+        self.0.get()
+    }
+
+    /// Returns the address of this mapping in the GPU virtual address space.
+    #[inline]
+    pub fn addr(&self) -> u64 {
+        // SAFETY: `self.as_raw()` is guaranteed to be a valid pointer to a `drm_gpuva`.
+        unsafe { (*self.as_raw()).va.addr }
+    }
+
+    /// Returns the length of this mapping.
+    #[inline]
+    pub fn length(&self) -> u64 {
+        // SAFETY: `self.as_raw()` is guaranteed to be a valid pointer to a `drm_gpuva`.
+        unsafe { (*self.as_raw()).va.range }
+    }
+}
+
 /// A pre-allocated [`GpuVa`] object.
 ///
 /// # Invariants

-- 
2.43.0


