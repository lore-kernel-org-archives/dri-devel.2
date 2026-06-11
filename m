Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08158CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334F910E8B3;
	Thu, 11 Jun 2026 22:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="NocUgsLF";
	dkim-atps=neutral
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com
 [74.125.82.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF59110E2BD
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 22:17:51 +0000 (UTC)
Received: by mail-dy1-f202.google.com with SMTP id
 5a478bee46e88-3080bb0267dso775767eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781216271; x=1781821071;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qbvuNTpE/5/jucgEEn1bO0TMcbBFU2GHmZcATaLZr0I=;
 b=NocUgsLF0m9Bmb7f+QPMDioSZY3oZM+LGvpoNqq9z36Hkf8/UahhceDtP1gKkps4c6
 FnQvrny9vx3BCdI5C52jP9okSfonR9nBswjYmFw9eIFuqx8BcKkwhG++hRXAhNVVHY9S
 CUJpJOXuqgHdDkLGECLOYgx72gIHhIlsgmoA2bsi/4/ZNTKi+PbEZ49TfqpYEwKseHns
 wNKORMbLW9tfl0yD7K2ETwZ++WXGqQr8qSvUQ92it28ynvsfyTB191hRqmT7/MQ6eaYK
 AVPopA9+B4BonJfrMwrRxndNSEV6nqMfwInpeZLiEy+E/QDNxq0ACCw8g5mv86DHzG3j
 Se3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781216271; x=1781821071;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbvuNTpE/5/jucgEEn1bO0TMcbBFU2GHmZcATaLZr0I=;
 b=n20fJ+cx/APXwBUMcNCnDwt9Z3uw/q27R15PRM7OSpY5JjcTQxTWDxzi+8sYcP+GSF
 nS9p31HeZ61K3lFd3zTg47WJaqhNX7rKnb21S4+2JvmX04Qe9F70rI2BPjMkJuYQqurR
 +v1lHqsLzaPKkf2jIBlrdxTnmFDj+r2hf0O9ppoFZNiNYwyVauQgcfDaNfDpDzL8brpJ
 gEuB2esO2QUuk7HCUnycfQ0kZTLyKRvJJhfM6f+c+IMUaJG7dhKeF9RxnhI5Pgn03TwY
 kmsjAr0QM2+g+XgdAlpVG9twviNFv0XPyIe0jHX48c9fx7341wLak1OPr0IF8eRtXkVk
 5piQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cQiFRlRnrnmmrfysxH+3Ue8gde/WCrfqlM7zAmVnd8IXv8OLAOewSaETSxd+AC9m4sMNwWue0QXw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW64f9kry6y/3I3j+WUYaseXAwxXe8cG9VmbJIjIj+9q1YSJkz
 LuGURnwE1ViuWB7T14K2afCmBv6jRpfAfFXkWk+QIjlZqGWAkWVsdOttjBTt6T7Hq+IQtdee7md
 5mVbmL5ooUTrdvYkh1nMNxRpXHrFHOQ==
X-Received: from dlbrh10.prod.google.com
 ([2002:a05:7022:f30a:b0:137:f748:fdbf])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:b86:b0:136:b67e:93e6 with SMTP id
 a92af1059eb24-1384bbae290mr82798c88.37.1781216270647; 
 Thu, 11 Jun 2026 15:17:50 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:17:22 +0000
In-Reply-To: <20260611-gpuvm-sync-send-v4-0-6c7f4ab2778a@google.com>
Mime-Version: 1.0
References: <20260611-gpuvm-sync-send-v4-0-6c7f4ab2778a@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp;
 fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=aIlZgMUNKNufC7lHnIBNKRRC1i9doObz8JqJqJCXUFM=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDFnaxl93/9u237n8FQfTprXa9wpn6mo8mpt7svblCRW+/
 OI22YjdHaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAid44zMjySvLxORzDi6A62
 7Eu2HMY71h2b+pzntl2vyI3nDRc3/JvPyNA4LThjyyG5m6ttN6b869104bJV3dcLU63W3J5vdOj
 grQ88AA==
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611-gpuvm-sync-send-v4-2-6c7f4ab2778a@google.com>
Subject: [PATCH v4 2/2] rust: drm: gpuvm: implement Send and Sync for
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
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>,
 Sami Tolvanen <samitolvanen@google.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

GpuVaAlloc wraps only uninitialised memory and exposes none of it.
GpuVmBo hands out the driver data and GEM object by shared reference and
drops them in its deferred put; the DriverGpuVm trait already guarantees
both are Send + Sync, so both impls are unconditional.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 rust/kernel/drm/gpuvm/va.rs    | 8 ++++++++
 rust/kernel/drm/gpuvm/vm_bo.rs | 9 +++++++++
 2 files changed, 17 insertions(+)

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
index c064ac63897b..a30f838c11b8 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -19,6 +19,15 @@ pub struct GpuVmBo<T: DriverGpuVm> {
     data: T::VmBoData,
 }
 
+// SAFETY: It is safe to send a `GpuVmBo<T>` to another thread: dropping it there drops
+// `T::VmBoData` and the GEM `T::Object`, both `Send` by the `DriverGpuVm` bounds.
+unsafe impl<T: DriverGpuVm> Send for GpuVmBo<T> {}
+
+// SAFETY: It is safe to share a `&GpuVmBo<T>` between threads: it effectively shares
+// `&T::VmBoData` and the GEM `&T::Object` (both `Sync`), and any thread may upgrade to an
+// `ARef` and ultimately drop them (both `Send`), per the `DriverGpuVm` bounds.
+unsafe impl<T: DriverGpuVm> Sync for GpuVmBo<T> {}
+
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.inner`.
 unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
     fn inc_ref(&self) {

-- 
2.54.0.1136.gdb2ca164c4-goog
