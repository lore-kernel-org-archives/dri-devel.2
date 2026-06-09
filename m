Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981CFCD8C9D
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 00:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF17F10E023;
	Tue,  9 Jun 2026 00:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kaemfrm/";
	dkim-atps=neutral
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com
 [74.125.82.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EC010E023
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 00:33:04 +0000 (UTC)
Received: by mail-dy1-f202.google.com with SMTP id
 5a478bee46e88-304ea1eea05so12703889eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780965184; x=1781569984;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3NwTNRDsniHBH4tORYSdA8veyCw89xtbdOmrzMR2cyk=;
 b=kaemfrm/8p34YRF7V5O/SMZBmRmSpISxMFILxyAdhmAQyNtXAOHAQpY94yqzG348ZT
 fBrtu5shykuDkHUgk3nIgFDlSb/xM4Uyrz6q5sbNBJ8HG3ThtdmvVjYCs7U7MM4l89gT
 ZDTPIL1cOIv6sk0PdbFptCL/kDaiPxjQhM9ATRk3jUhOMT/IhsK1VLLbVeDWn838KRMo
 MJysQOG+bOaZ9Bp5wcBJprNtaIFdAG3I8UH273NtAfSbH6qIEEvxMcHVzpKnlQXxhOVu
 o+KaxCVqWz6aKch36me6Bw86K0pvV+plPEh+w2fM4cnwJ1nvyXG5ilGRFfjDRGDr6y64
 R/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780965184; x=1781569984;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3NwTNRDsniHBH4tORYSdA8veyCw89xtbdOmrzMR2cyk=;
 b=hWsVCISYJaXzfLphSk+8/6SZY24WGb7rnBIRAK63sfvUILf2RaX4v2fOsPfvHI3+NO
 YBSeeETIuXc5JffYGHNhZ14edfhZhipBwJEpvAV0cuG44Tjs1+yV0Qp7McZTgBxu6jvT
 GSmnMqc1zocYXMoY0tYy/k5qAOrEctwvtwS1OYkDNnsTgsCuf2KWoBW7IZK8HNHazeJC
 Qpq+AL8glokEWMBYxLGjUoAuUjy1Chb3nc56KYd1FyAXG/Py2c68tiTNA5NxQsegEXeb
 V0D/L1X0Gvc6TwdXwQMr7zfLIBF35odWtOCV6350hT4juW0wd5Yk/SLmvsYslRygG1Cs
 Ij8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ90TgzCBzi205C9r+s1n1wQDkLaFxZb9yachGHuAwgXsozuSTkIrGyC7KuE9vHEueRqcKBQIFPgulY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpAcN36izJ5zD1A5G7r1GJfIMNoTDwj4+8w8h7YMDLlXmAiI04
 KKNo/aX1Zt1uqo8RUIhmxE1bJHPGQ8L6rkXbAjNjyUOvxV44OjI8SwU7ngB+NroBnEQQTiiv+Z3
 jl8mWTvmQswJUVzmHYK27/Ec5ohQAYA==
X-Received: from dyrv26.prod.google.com ([2002:a05:7300:8a9a:b0:304:dc2f:9939])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2d82:b0:304:e865:f7d1 with SMTP id
 5a478bee46e88-3077b2641bcmr8410594eec.25.1780965183480; 
 Mon, 08 Jun 2026 17:33:03 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:32:58 +0000
In-Reply-To: <20260609003256.1829625-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20260609003256.1829625-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp;
 fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070; i=samitolvanen@google.com;
 h=from:subject; bh=B4OjrrcnDYmB2A/CCa8JFe9KRhC+GkfGzpAW5HRDuY0=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDFnq8VbXBNmSevwPL7FX+BrxRIplLee0NUUzXjBu9zr3X
 0SJb2lcRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZjIinaGv0JCKu/uyHQnHTp9
 zVGbc1ryN+2M2XpHljBrLOp+85VLzo2RYfGxh1F3t9zZduenT8nEyXvOZuoGPwsXsZ1Z07llYeB
 +VkYA
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609003256.1829625-5-samitolvanen@google.com>
Subject: [PATCH v3 1/2] rust: drm: gpuvm: implement Send and Sync for
 GpuVaAlloc and GpuVmBo
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
 rust/kernel/drm/gpuvm/va.rs    |  8 ++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
index 0b09fe44ab39..b108ec7aa1bc 100644
--- a/rust/kernel/drm/gpuvm/va.rs
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -104,6 +104,14 @@ pub fn vm_bo(&self) -> &GpuVmBo<T> {
 /// The memory is zeroed.
 pub struct GpuVaAlloc<T: DriverGpuVm>(KBox<MaybeUninit<GpuVa<T>>>);
 
+// SAFETY: A `GpuVaAlloc` is an owned, uninitialised allocation with no live `T::VaData` and no
+// thread-bound state.
+unsafe impl<T: DriverGpuVm> Send for GpuVaAlloc<T> {}
+
+// SAFETY: A `GpuVaAlloc` has no `&self` method that reaches its contents, so a shared
+// `&GpuVaAlloc` cannot access the allocation.
+unsafe impl<T: DriverGpuVm> Sync for GpuVaAlloc<T> {}
+
 impl<T: DriverGpuVm> GpuVaAlloc<T> {
     /// Pre-allocate a [`GpuVa`] object.
     pub fn new(flags: AllocFlags) -> Result<GpuVaAlloc<T>, AllocError> {
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
index c064ac63897b..c5e3bb44a2ee 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -19,6 +19,28 @@ pub struct GpuVmBo<T: DriverGpuVm> {
     data: T::VmBoData,
 }
 
+// SAFETY: It is safe to send a `GpuVmBo<T>` to another thread when `T::VmBoData` and `T::Object`
+// are `Sync` because `data()` and `obj()` share `&T::VmBoData` and `&T::Object`; they must also be
+// `Send` because the last reference drop runs their destructors on whichever thread drains the
+// deferred-cleanup queue.
+unsafe impl<T: DriverGpuVm> Send for GpuVmBo<T>
+where
+    T::VmBoData: Send + Sync,
+    T::Object: Send + Sync,
+{
+}
+
+// SAFETY: It is safe to send `&GpuVmBo<T>` to another thread when `T::VmBoData` and `T::Object` are
+// `Sync` because `data()` and `obj()` share `&T::VmBoData` and `&T::Object`; they must also be
+// `Send` because any thread with a `&GpuVmBo<T>` can clone it via `ARef::from`, whose last drop
+// runs their destructors on whichever thread drains the deferred-cleanup queue.
+unsafe impl<T: DriverGpuVm> Sync for GpuVmBo<T>
+where
+    T::VmBoData: Send + Sync,
+    T::Object: Send + Sync,
+{
+}
+
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
 unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
     fn inc_ref(&self) {
-- 
2.54.0.1099.g489fc7bff1-goog

