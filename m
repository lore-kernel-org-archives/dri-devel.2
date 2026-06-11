Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6ABCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5EA10E2BD;
	Thu, 11 Jun 2026 22:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Ob35/kt5";
	dkim-atps=neutral
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com
 [74.125.82.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4022310E2BD
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 22:17:50 +0000 (UTC)
Received: by mail-dy1-f201.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so628687eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781216269; x=1781821069;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=QhNQ1we6NOoqH0cCFXtN3A1WKb9ns/XyXQCVsvCLAxo=;
 b=Ob35/kt5TjS6peVg/NLXlOb/gnw4Yt0kwgcu7ACWgfXTGONFebcfXp4Im2b2nbe3WI
 Oz+Te2baHbyf1ji8tZ10bhsSVcQ8yBljTykv/Ud1pHqj1UwUybrxiSJ4ahcfyaPmma6w
 TBpp2qVTuAs14/oVfRVlAO1BnAc4A+oiu0U4FMUg9m3fZJKYS3gILQjuT6qGX7/COrM5
 GILjZyTadnnz5tGQEuaFe0gU1uq/iN1mn5EaC6j352y4CMUdx1eT3XUYX1SricAK5XGa
 xGBURMjLqDhaARZpUUt3Q0mCocWskOgp7pmo68/KnMjdNgbB7x+Ha5KJQ0pVrOqAMmm3
 6Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781216269; x=1781821069;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QhNQ1we6NOoqH0cCFXtN3A1WKb9ns/XyXQCVsvCLAxo=;
 b=Fsk4GL3uqYHJrBzl+pD7B+CjDRLegI2rTps24DPwkXTEbUW/Us09mEUJyOt5k69Njt
 JFpBTs8RTL+bZtNsPC2w1EWM/a+zG1tJUvNlAlySaTb5ZDAKGJq6OExe4hBG6AUGyngI
 vW0fmunf0s8OAtD/OkUp9p3FLdf3JBQP6DqhLznQx+a0muwNAq6FJ6eO+eFcCNKzub1k
 T7WIYvmKmUvusBQhQ4ANGuYF4WB7gpZ+iaSvmJrAnw1Bl99xMu7DLtdnhk/vjXh3NKRC
 6YBusVLjzFKjCZPohAQfwKLR6pORohxd5DIh/E1NxjNzN/2lt4SgHKn2h0GK61pKkH9U
 tgSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9a0aPatqpF6TWxKXF07dUw2m30om9kNFPnVMx0SzqyU0iIgibs8/SipaozM6KIUHVvIm9M9VlX+GE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjNAYiK07WxvxWQqWxd1fS2QIamnFom4MQKtBWVLG5YGVBwpX9
 6bs1TF9xPzE3/Fui+YtiOTIwdhMMuWaaJQDUNZ/5UY5L+CDghhm9jhRa6t6a11YGkTCqOrwjiS0
 SkRBOAyU667bGX37TabFJhX//DLLtkg==
X-Received: from dybbs28.prod.google.com
 ([2002:a05:7300:a21c:b0:307:bbdd:4346])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3d19:b0:304:c651:bdea with SMTP id
 5a478bee46e88-308200897c1mr113782eec.21.1781216268962; 
 Thu, 11 Jun 2026 15:17:48 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:17:21 +0000
In-Reply-To: <20260611-gpuvm-sync-send-v4-0-6c7f4ab2778a@google.com>
Mime-Version: 1.0
References: <20260611-gpuvm-sync-send-v4-0-6c7f4ab2778a@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp;
 fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=GXST9+qaLqvKuvrCkRKeBSa0wUCsepCT9+RExmFeJvc=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDFnaxl+EFM+4Hze3WWenn2Py2/Dqfr6pJyJdjIyML/R1b
 /x5WH9NRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZgI+zFGhollz66/XhV/yq1O
 Y7lrpZDWBq25y9qs/iWyR0498/TWIh9GhqeL9JKtPv+8s19ofYX3i58i7ne5TW+eOHC4UmTOik4
 xGQ4A
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611-gpuvm-sync-send-v4-1-6c7f4ab2778a@google.com>
Subject: [PATCH v4 1/2] rust: drm: gpuvm: require Send + Sync for the driver's
 associated data
From: Sami Tolvanen <samitolvanen@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Asahi Lina <lina+kernel@asahilina.net>
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

DriverGpuVm permitted !Send/!Sync associated data on an abstraction whose
handles are shared and dropped across threads: obtain() runs from many
threads and the VA API performs deferred cross-thread drops. That is
unsound.

Require Send + Sync on the trait and its associated data so the GpuVm and
UniqueRefGpuVm handle impls need no per-impl bounds.

Fixes: 82b78182eacf ("rust: drm: add base GPUVM immediate mode abstraction")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 rust/kernel/drm/gpuvm/mod.rs | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index a625fcd9b5f2..70cf11346cee 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -72,10 +72,12 @@ pub struct GpuVm<T: DriverGpuVm> {
     data: UnsafeCell<T>,
 }
 
-// SAFETY: The GPUVM api does not assume that it is tied to a specific thread. The destructor will
-// drop the `data` field, which is okay because it is guaranteed `Send` by the `DriverGpuVm` trait.
+// SAFETY: It is safe to send a `GpuVm<T>` to another thread: all data reachable through it
+// (`T`, `T::VmBoData`, and the GEM `T::Object`) is `Send` by the `DriverGpuVm` bounds.
 unsafe impl<T: DriverGpuVm> Send for GpuVm<T> {}
-// SAFETY: The GPUVM api is designed to allow &self methods to be called in parallel.
+// SAFETY: It is safe to share a `&GpuVm<T>` between threads: `&self` methods only alias data
+// that is `Sync` by the `DriverGpuVm` bounds, and any thread may drop that data, or upgrade the
+// reference and ultimately drop `T`, which the same bounds make `Send`.
 unsafe impl<T: DriverGpuVm> Sync for GpuVm<T> {}
 
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.vm`.
@@ -250,18 +252,22 @@ fn raw_resv(&self) -> *mut bindings::dma_resv {
 }
 
 /// The manager for a GPUVM.
-pub trait DriverGpuVm: Sized + Send {
+pub trait DriverGpuVm: Sized + Send + Sync {
     /// Parent `Driver` for this object.
     type Driver: drm::Driver;
 
     /// The kind of GEM object stored in this GPUVM.
-    type Object: drm::driver::AllocImpl<Driver = Self::Driver>;
+    type Object: drm::driver::AllocImpl<Driver = Self::Driver> + Send + Sync;
 
     /// Data stored with each [`struct drm_gpuva`](struct@GpuVa).
-    type VaData;
+    ///
+    /// Only `Send` is required: the data has a single owner at all times, moving
+    /// between threads by value (handed back as a [`GpuVaRemoved`]) but never
+    /// accessed by two threads concurrently.
+    type VaData: Send;
 
     /// Data stored with each [`struct drm_gpuvm_bo`](struct@GpuVmBo).
-    type VmBoData;
+    type VmBoData: Send + Sync;
 
     /// The private data passed to callbacks.
     type SmContext<'ctx>;
@@ -296,12 +302,10 @@ fn sm_step_remap<'op, 'ctx>(
 /// # Invariants
 ///
 /// Each `GpuVm` instance has at most one `UniqueRefGpuVm` reference.
+// `Send`/`Sync` derive from `ARef<GpuVm<T>>`; the trait bounds make them correct for the unique
+// handle's `&mut T` access.
 pub struct UniqueRefGpuVm<T: DriverGpuVm>(ARef<GpuVm<T>>);
 
-// SAFETY: The GPUVM api is designed to allow &self methods to be called in parallel, and
-// concurrent access to `data` is safe due to the `T: Sync` requirement.
-unsafe impl<T: DriverGpuVm + Sync> Sync for UniqueRefGpuVm<T> {}
-
 impl<T: DriverGpuVm> UniqueRefGpuVm<T> {
     /// Access the data owned by this `UniqueRefGpuVm` immutably.
     #[inline]

-- 
2.54.0.1136.gdb2ca164c4-goog
