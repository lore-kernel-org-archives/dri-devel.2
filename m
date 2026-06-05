Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2807ACD6E7E
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9C610E275;
	Fri,  5 Jun 2026 22:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rG7+fLKG";
	dkim-atps=neutral
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com
 [74.125.82.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8503810E275
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 22:25:22 +0000 (UTC)
Received: by mail-dy1-f202.google.com with SMTP id
 5a478bee46e88-30762d67a64so3515233eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780698322; x=1781303122;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hDhseaqiPSLPqHYwXpS4zasRBSNprmSrggrhgGRfur0=;
 b=rG7+fLKGLleibaSylRG6n7r6rz5vIanlkER0QPISJ0Ff80Z1hvaE5TExxEBYv1N6Ov
 cOJdX3SUvrxTEUa4MbZppTgGId+QldmIrZ4dJeeEKHAX6SX5ug2n7P63qtExSOn9x5cY
 HNXgQTcrqlY6uXakidMOqxga7dGUwm104xEN6WJ7B8MTdpR5e9MYQcv2V0Umk+xv+u+X
 wFxkUuDFoPobK6fDQWiAYQeg9rRS8b5mfuOj40H48x1oRmwc7kO23va+xXM6DasZy0TK
 XLRMDIT3Atco3PoL+S/osrIicFxl6exwxYIcrrMPwYvwjBC6HM6vBfA8Fx1qihrIqhK2
 kuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780698322; x=1781303122;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDhseaqiPSLPqHYwXpS4zasRBSNprmSrggrhgGRfur0=;
 b=hjO4XtgLwdQ8iMdboXElfDbTfHjhJujilTcl65q0ya04tfoiH+qDiAd5t08wG/EdXO
 Wwo6K0QLX8IxmDrft2h9SsgefPh5K6lB86Br8D1aUcPV4yxp2YiM5ZRkWvGqlbevUeOO
 1Vy2EmjO9wpCBoQlW3W0Rw6moc5WewA/bHH5YEVsS7A6aKDXlrLFzcjz8ttlDIzsDGvG
 6jGZLZOx+sUYMrcOJHPUJ89CMqeEAGiqbe4Rfuye2sYVlwChq0VKuEPGM9VOn2KPzytA
 7fTvcP0QNeOsYVkog845zq6PB/38OXMyAOVAMJqT4VAejHrAmdDZPVyogV7fIOaj9ojQ
 USag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YqyepKJq86SsauABmjPaPhNAl+8dPASP3OLSQMpCP4p+QAByOCMyl0iorlL+296+PnMR93YyyPzI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoV8fol5D1R76DPnVqcQ6q3NXIBc4JiKh4Y/YU5e6+6vgiT/PI
 ryq4eFFFDENId/r3Gv70EgpWmQ2UThiPFJJaJ6sCJQO8s3U4dJedFu6vc42yuNF9vsxSOpMwBE7
 X6mnGOZocrPv1n1IAt2GvDPurvfUt8A==
X-Received: from dld33.prod.google.com ([2002:a05:7022:321:b0:138:50e:5095])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:204:b0:137:edc4:a5e6 with SMTP id
 a92af1059eb24-138066fa2ddmr2765989c88.29.1780698321542; 
 Fri, 05 Jun 2026 15:25:21 -0700 (PDT)
Date: Fri,  5 Jun 2026 22:25:16 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp;
 fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2979; i=samitolvanen@google.com;
 h=from:subject; bh=juvCzx+9b+PGWwUmEGsN7DzOR8HGiGuIxADYptuBz70=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDFnKPmecKlLkM7SP6/yoqTW79djb0/zolau+05P0V4Uc+
 /TmxpX3HaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAiX2MYGU4JWCy8o7mz7Ow7
 +/wN4ZNnC/RsLTtzQUNP8u+jT4WJsq8ZGa7MKfR7PdPj7MJfcubTJX93rmrZM21b3+QbmsduPVq
 X1s4FAA==
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605222516.3138740-2-samitolvanen@google.com>
Subject: [PATCH] rust: drm: gpuvm: implement Send and Sync for GpuVaAlloc and
 GpuVmBo
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

A GpuVaAlloc holds only uninitialised memory with no live VaData and
hands out no reference to its contents, so it is Send and Sync
unconditionally. A GpuVmBo is refcounted atomically and its deferred put
is sound from any thread.

Implement the markers in the abstraction so drivers can move these
objects between threads without an unsafe impl of their own. Send for
GpuVmBo requires VmBoData: Send because the data is dropped during
deferred cleanup, on whichever thread drains the queue. Sync requires
both VmBoData: Sync and Object: Sync because the &self data() and obj()
accessors hand out &VmBoData and &Object.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 rust/kernel/drm/gpuvm/va.rs    |  8 ++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

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
index c064ac63897b..016b10e3305b 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -19,6 +19,21 @@ pub struct GpuVmBo<T: DriverGpuVm> {
     data: T::VmBoData,
 }
 
+// SAFETY: The refcount in `self.inner` is atomic, so `dec_ref`'s deferred put is sound from any
+// thread. `data` is dropped later by `drm_gpuvm_bo_deferred_cleanup`, on whichever thread drains
+// the queue, hence the `T::VmBoData: Send` bound.
+unsafe impl<T: DriverGpuVm> Send for GpuVmBo<T> where T::VmBoData: Send {}
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

