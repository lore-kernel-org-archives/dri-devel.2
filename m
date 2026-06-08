Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADAACD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6612410F018;
	Mon,  8 Jun 2026 15:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="a3jDMIG/";
	dkim-atps=neutral
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com
 [74.125.82.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CAF10F587
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:09:34 +0000 (UTC)
Received: by mail-dy1-f202.google.com with SMTP id
 5a478bee46e88-304f1820babso5478349eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780931374; x=1781536174;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/tNv8jqkNUUf3JceaHwSaBzHJupOjs95cWpd7WmLwOI=;
 b=a3jDMIG/HUoXBlfQW4PVzK2vBESoGcD/VlX0pU1sHYwL0NbmGbTzbz16zg/S3sS3EI
 r+V5njYEYaAxjw7HJQOhbU8s/MAACZgY81Dk8D7dgJ3sULfuNu5iIl7I+18CjhyET6mE
 Z7fdUOKWbUTQrQF5n/oIrQDh98VCfav/o29wMI739znlPDEl7kcKtbgAB+6L9FI+gV5+
 l1JqA3nrnzBs1ULCQNcIV1BuAPWlXLrGnUaVY0srWUReXy+PD9TFEb/rv4F4Yl7xTWzF
 VcUvRcB80VY7G6JlbefCYmJg2lni3Sda9wcZCLwJToKhLZmqNQCiPuWHwFHkpN3zgSt0
 HOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780931374; x=1781536174;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/tNv8jqkNUUf3JceaHwSaBzHJupOjs95cWpd7WmLwOI=;
 b=QH94IfAWwGvi88h80Hd0sK9Ri5BgQ9/t9cG8HDznoqczYus3aG8+Vk/pWuVK0ajuR8
 f9qEWpJDjcRuEoKhf2SHO2fRN7/uFo9N4HP6BsODBRdwtNnPfHPYGABLMpao5TudgcZZ
 RQ1eiQ1MrxXBm3yU/KO9CotuniqNJHAlxsjOBX+9QYZ/vbH0lY2wbWOkMNLhjq6j6Lnv
 ByvX74EpOHFImKbGuP+JA3xYO/HNQSajYdf5up/9xVNwK7mXKxdeyK7L3tBZ7bM9ei5E
 GZxAj7PU5dkTfqfmRBhhu8mp5lHTHYNxlBmuEvGk0T3p86LDYVrMA5uj8d4KA7e6JZ8f
 TK1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/J7gHVXTOiK3Q53vfBWvBbfoi2qmtgZO3LwMI3cWCACM8L4wec2DWihcIjqWwVkVOiLPINe8SVio=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSFggLReaUbZbdiSQYBiIup0TCB/9RDYwYJIGFcK3psowqFw2/
 mIqlvD9mSXitcwdKrN1Ef7HAhv1TlzOO7GtyMjYpI/GJRLfo+eu5xeG92p6fNyTA+x4sSHR8FNH
 2IizMTBaJ3fqeoe38FfYlN7XSjjD42w==
X-Received: from dybb4.prod.google.com ([2002:a05:693c:6084:b0:2f9:af7:5041])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:5713:b0:304:d788:ac5 with SMTP id
 5a478bee46e88-3077b7efba5mr9343499eec.35.1780931373632; 
 Mon, 08 Jun 2026 08:09:33 -0700 (PDT)
Date: Mon,  8 Jun 2026 15:09:30 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp;
 fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3142; i=samitolvanen@google.com;
 h=from:subject; bh=y42Ay00B2+j5wggV7SYlJuqrvsTXuZL1/72NkndXCOY=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDFlqtzXv71mktXpS/oGui2YS//oVvrzmc2+bpnByW2ZBy
 OutZfyPO0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBE1uxhZFhw/ZKaoR5Pe07R
 onlRzJNrVk0IVp5x+tmiGo9Oe+HnEq6MDBd9bJs+MFr/z+/uX8w8m1XnuHji9MMfwrs0uFa57p3
 VzAMA
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260608150929.1327394-2-samitolvanen@google.com>
Subject: [PATCH v2] rust: drm: gpuvm: implement Send and Sync for GpuVaAlloc
 and GpuVmBo
From: Sami Tolvanen <samitolvanen@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: Sami Tolvanen <samitolvanen@google.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Moving a GpuVaAlloc or GpuVmBo between threads currently forces drivers
to write their own unsafe Send and Sync impls. Provide the markers in
the abstraction instead.

GpuVaAlloc wraps only uninitialised memory and exposes none of it, so it
is unconditionally Send and Sync. GpuVmBo is an atomically refcounted
handle whose accessors hand out the driver data and GEM object by shared
reference and whose deferred put drops them, so its Send and Sync impls
are bounded on T::VmBoData and T::Object.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
Changes in v2:
- Added a missing T::Object: Send + Sync bound pointed out by Sashiko.

---
 rust/kernel/drm/gpuvm/va.rs    |  8 ++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
index 0b09fe44ab39..dcb2dec4fbdf 100644
--- a/rust/kernel/drm/gpuvm/va.rs
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -104,6 +104,14 @@ pub fn vm_bo(&self) -> &GpuVmBo<T> {
 /// The memory is zeroed.
 pub struct GpuVaAlloc<T: DriverGpuVm>(KBox<MaybeUninit<GpuVa<T>>>);
 
+// SAFETY: A [`GpuVaAlloc`] is an owned, uninitialised allocation with no live `T::VaData` and no
+// thread-bound state.
+unsafe impl<T: DriverGpuVm> Send for GpuVaAlloc<T> {}
+
+// SAFETY: A [`GpuVaAlloc`] has no `&self` method that reaches its contents, so a shared
+// `&GpuVaAlloc` cannot access the allocation.
+unsafe impl<T: DriverGpuVm> Sync for GpuVaAlloc<T> {}
+
 impl<T: DriverGpuVm> GpuVaAlloc<T> {
     /// Pre-allocate a [`GpuVa`] object.
     pub fn new(flags: AllocFlags) -> Result<GpuVaAlloc<T>, AllocError> {
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
index c064ac63897b..fa183f6306ff 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -19,6 +19,27 @@ pub struct GpuVmBo<T: DriverGpuVm> {
     data: T::VmBoData,
 }
 
+// SAFETY: The refcount in `self.inner` is atomic, so `dec_ref`'s deferred put is sound from any
+// thread. `drm_gpuvm_bo_deferred_cleanup` drops `data` and the last GEM-object reference on
+// whichever thread drains the queue, hence the `T::VmBoData: Send` and `T::Object: Send` bounds.
+// [`Self::obj`] hands out `&T::Object` for a shared object, so the move needs `T::Object: Sync`.
+unsafe impl<T: DriverGpuVm> Send for GpuVmBo<T>
+where
+    T::VmBoData: Send,
+    T::Object: Send + Sync,
+{
+}
+
+// SAFETY: The fields of `inner` read by shared-reference methods are immutable after construction.
+// [`Self::data`] hands out `&T::VmBoData` and [`Self::obj`] hands out `&T::Object`, so sharing
+// `&Self` across threads requires both to be `Sync`.
+unsafe impl<T: DriverGpuVm> Sync for GpuVmBo<T>
+where
+    T::VmBoData: Sync,
+    T::Object: Sync,
+{
+}
+
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
 unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
     fn inc_ref(&self) {

base-commit: fea3a2dd7d3fc1936211ced5f84420e610435730
-- 
2.54.0.1032.g2f8565e1d1-goog

