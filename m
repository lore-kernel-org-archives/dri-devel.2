Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BF606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ky4DvDkA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E957C10E963;
	Fri, 27 Nov 2026 18:58:02 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7364210E512
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795805873; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ic8O5ek6uhBGxRPS/P7cgl9ddcp+1l3QWrXbZ3PHyb0hWaZY+x+nulGS+pHwRYaBcPBb29vNNAvqi/jj2zLk1lPdjDvPNgUYsR8xc4pjUBUGq0DDIx3X4+jbHSrqjSkRq6yNB5dT7vHVmdqzvSbw53d35CA8iLdkK5LiGZB6cyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795805873;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pcIA7yNtdSv4ODO4Q44pRru7yd7KZ91x7RtnWUq1Rhg=; 
 b=PV96wTjBIp/vQ0JPsgwzbCRCkEwaZzQLo/neVdK3pPRTEQy1bBMxjqCz02dzz5tL+xrGb+pvfSLKrZ3JSvUAeXgsaB+HW9NiRNZnl67Z5TO9qOG/wzyIgYkgNXrA6EHE5sd5NY5eESg7pW59Xujg6V0y6o/2ucrVIpIDuyCnrX0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=ky4DvDkAEc/EZfdEnQqsOMgVKmNHK+wwm/CJMA7TxepLn0JnNdoZp2wgStqviXs1huFB1XWNGtMEsr8a/AqkUcEjyATwgJA5DvFFtkzi7bsVue5NATWDCY/GmGVa8+A97c1niJwqjFH0qAaYJg9pCHUw0N6hTej0LqIQlWcfoYQ=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=pcIA7yNtdSv4ODO4Q44pRru7yd7KZ91x7RtnWUq1Rhg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795805868900911.1464793688865;
 Fri, 27 Nov 2026 10:57:48 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 15:57:38 -0300
Subject: [PATCH] rust: workqueue: add DmaFenceQueue and DmaFenceWork
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-dma-fence-work-v1-1-4a4f55ce51b5@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OyU7DMABEfyXyGaN4iWNHCPEfqAcv42DIQu0kI
 FX9d9KUAweOI828NxdSkBMK6aoLydhSSfO0B/ZQEf9mpx40hT0TXnPFGG9pGC2NmDzo15w/aHQ
 CClyoxoDso8+MmL4P4Ovpnsvq3uGXG+W3kXFed9Nyr5ERpdjD1FVPdxEzNK9lORznFSvoJmlN2
 7r1Shsjjaxf+nnuBzz6eXwmf+921T9nS+onOwxp6qm3EAHRWGvabmO3rbMFdAeNaekq66JTsnZ
 ctBJcBegYNQtSay9M0LyRwTVCg5yu1x+yAEfMQAEAAA==
X-Change-ID: 20261127-dma-fence-work-fb3e6e23659e
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
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

Work on a dma-fence signalling path must run on a workqueue with
WQ_MEM_RECLAIM, since memory reclaim can wait for dma-fences. It must
also run in a signalling section, so that lockdep can check it.

Add DmaFenceQueue, an OwnedQueue that is always created with
WQ_MEM_RECLAIM, and DmaFenceWork, a ScopedWork that can only be bound
to a DmaFenceQueue and whose work function runs in a
SignallingSection. The work function receives the section, so it can
signal fences with DriverFence::signal().

There are no users yet. Tyr will use them.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
DmaFenceWork is built on ScopedWork, so this depends on the workqueue
series that adds OwnedQueue and ScopedWork [1]. It also needs
SignallingSection from [2].

This is based on drm-rust-next.

[1] https://lore.kernel.org/r/20261119-rust-workqueue-v4-0-707c68994940@google.com
[2] https://lore.kernel.org/r/20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com
---
 rust/kernel/workqueue/dma_fence.rs | 211 +++++++++++++++++++++++++++++++++++++
 rust/kernel/workqueue/mod.rs       |  10 ++
 2 files changed, 221 insertions(+)

diff --git a/rust/kernel/workqueue/dma_fence.rs b/rust/kernel/workqueue/dma_fence.rs
new file mode 100644
index 000000000000..066eff3250ce
--- /dev/null
+++ b/rust/kernel/workqueue/dma_fence.rs
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Work items and a workqueue for the dma-fence signalling path.
+
+use crate::{
+    alloc::AllocError,
+    container_of,
+    dma_buf::SignallingSection,
+    prelude::*,
+    sync::LockClassKey, //
+};
+
+use super::{
+    OwnedQueue,
+    Queue,
+    ScopedWork,
+    ScopedWorkItem, //
+};
+
+use core::{
+    ops::Deref,
+    ptr, //
+};
+
+/// A workqueue for work done on a [dma-fence signalling path].
+///
+/// Memory reclaim can wait for a dma-fence, and signalling that fence can depend on work queued
+/// here, so the queue is created with `WQ_MEM_RECLAIM`. That flag reserves one execution context
+/// per queue, so work items that depend on each other need separate queues.
+///
+/// [dma-fence signalling path]: https://docs.kernel.org/driver-api/dma-buf.html#dma-fence-signalling-annotations
+pub struct DmaFenceQueue(OwnedQueue);
+
+impl DmaFenceQueue {
+    /// Allocates a new unbound workqueue.
+    #[inline]
+    pub fn new_unbound(name: &CStr) -> Result<Self, AllocError> {
+        Ok(Self(Queue::new_unbound().mem_reclaim().build(name)?))
+    }
+
+    /// Allocates a new ordered workqueue, which runs one work item at a time, in the order they
+    /// were queued.
+    #[inline]
+    pub fn new_ordered(name: &CStr) -> Result<Self, AllocError> {
+        Ok(Self(Queue::new_ordered().mem_reclaim().build(name)?))
+    }
+}
+
+/// Trait for types that can be used as [`DmaFenceWork`] items.
+///
+/// Like [`ScopedWorkItem`], except that the work function runs in a [`SignallingSection`], which
+/// it receives.
+pub trait DmaFenceWorkItem: Sized + Sync {
+    /// Called when the work item is executed.
+    fn run(work: &DmaFenceWork<'_, Self>, section: &SignallingSection);
+}
+
+/// The data of the [`ScopedWork`] inside a [`DmaFenceWork`].
+///
+/// # Invariants
+///
+/// An `Inner<T>` only ever exists inside the `work` field of a [`DmaFenceWork<'_, T>`].
+#[pin_data]
+struct Inner<T> {
+    #[pin]
+    data: T,
+}
+
+impl<T: DmaFenceWorkItem> ScopedWorkItem for Inner<T> {
+    fn run<'a, 'wq>(work: &'a ScopedWork<'wq, Self>) {
+        let section = SignallingSection::begin();
+
+        // SAFETY: An `Inner<T>` only ever exists inside the `work` field of a
+        // `DmaFenceWork<'wq, T>` (type invariant), so `work` is the `work` field of a live
+        // `DmaFenceWork<'wq, T>`.
+        let work: &'a DmaFenceWork<'wq, T> =
+            unsafe { &*container_of!(ptr::from_ref(work).cast_mut(), DmaFenceWork<'wq, T>, work) };
+
+        T::run(work, &section);
+    }
+}
+
+/// A work item on a [dma-fence signalling path].
+///
+/// Wraps a [`ScopedWork`] that is bound to a [`DmaFenceQueue`] and whose work function runs in a
+/// [`SignallingSection`].
+///
+/// [dma-fence signalling path]: https://docs.kernel.org/driver-api/dma-buf.html#dma-fence-signalling-annotations
+///
+/// # Examples
+///
+/// ```
+/// use kernel::{
+///     dma_buf::SignallingSection,
+///     workqueue::{
+///         new_dma_fence_work,
+///         DmaFenceQueue,
+///         DmaFenceWork,
+///         DmaFenceWorkItem, //
+///     },
+/// };
+///
+/// struct MyWork {
+///     value: u32,
+/// }
+///
+/// impl DmaFenceWorkItem for MyWork {
+///     fn run(work: &DmaFenceWork<'_, Self>, _section: &SignallingSection) {
+///         pr_info!("value = {}\n", work.value);
+///     }
+/// }
+///
+/// #[pin_data]
+/// struct MyData {
+///     #[pin]
+///     work: DmaFenceWork<'wq, MyWork>,
+///     wq: DmaFenceQueue,
+/// }
+///
+/// fn init_data() -> impl PinInit<MyData, Error> {
+///     // Define `my_work` outside the `unsafe` block.
+///     let my_work = MyWork { value: 7 };
+///     try_pin_init!(MyData {
+///         wq: DmaFenceQueue::new_unbound(c"my-wq")?,
+///         // SAFETY: `MyData` is only ever pin-initialized, and `work` is declared before `wq`,
+///         // so `work` is dropped before `wq`.
+///         work <- unsafe { new_dma_fence_work!(wq, "MyWork", my_work) },
+///     })
+/// }
+/// # pin_init::stack_try_pin_init!(let data =? init_data());
+/// # data.work().enqueue();
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data]
+#[repr(transparent)]
+pub struct DmaFenceWork<'wq, T: DmaFenceWorkItem> {
+    #[pin]
+    work: ScopedWork<'wq, Inner<T>>,
+}
+
+impl<'wq, T: DmaFenceWorkItem> DmaFenceWork<'wq, T> {
+    /// Creates a pin-initializer for a new work item bound to `queue`.
+    ///
+    /// Use [`new_dma_fence_work!`] to automatically provide the lock class key.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the destructor of the initialized `DmaFenceWork<'wq, T>` runs
+    /// before the memory it lives in is reused and before `'wq` or any lifetime in `T` expires.
+    /// In particular, the value must not be leaked, e.g. via [`core::mem::forget`] or by leaking
+    /// the allocation that contains it.
+    #[inline]
+    pub unsafe fn new<E>(
+        queue: &'wq DmaFenceQueue,
+        name: &'static CStr,
+        key: Pin<&'static LockClassKey>,
+        init: impl PinInit<T, E>,
+    ) -> impl PinInit<Self, E> {
+        let data = try_pin_init!(Inner { data <- init }? E);
+
+        // INVARIANT: The `Inner<T>` is created inside the `work` field of this `DmaFenceWork`.
+        try_pin_init!(Self {
+            // SAFETY: Dropping a `DmaFenceWork` drops its `work` field, and `Inner<T>` has the
+            // lifetimes of `T`, so the caller's guarantee covers the requirements of
+            // `ScopedWork::new`.
+            work <- unsafe { ScopedWork::new(&queue.0, name, key, data) },
+        }? E)
+    }
+
+    /// Enqueues this work item on its bound workqueue.
+    ///
+    /// Returns `false` if the work item is already pending on the workqueue.
+    ///
+    /// The work item will be submitted using `WORK_CPU_UNBOUND`.
+    #[inline]
+    pub fn enqueue(&self) -> bool {
+        self.work.enqueue()
+    }
+}
+
+impl<T: DmaFenceWorkItem> Deref for DmaFenceWork<'_, T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &T {
+        &self.work.data
+    }
+}
+
+/// Creates a [`DmaFenceWork`] pin-initializer with a new lock class.
+///
+/// This macro expands to a call to [`DmaFenceWork::new`], which is `unsafe`, so the invocation
+/// must be wrapped in an `unsafe` block.
+///
+/// # Safety
+///
+/// The caller must uphold the safety requirements of [`DmaFenceWork::new`]: the destructor of the
+/// initialized `DmaFenceWork` must run before the memory it lives in is reused and before the
+/// bound [`DmaFenceQueue`]'s lifetime or any lifetime in the inner type expires.
+#[macro_export]
+macro_rules! new_dma_fence_work {
+    ($queue:expr, $name:literal, $init:expr $(,)?) => {
+        $crate::workqueue::DmaFenceWork::new(
+            $queue,
+            $crate::c_str!($name),
+            $crate::static_lock_class!(),
+            $init,
+        )
+    };
+}
+pub use new_dma_fence_work;
diff --git a/rust/kernel/workqueue/mod.rs b/rust/kernel/workqueue/mod.rs
index d80fced7f333..328a6fce4d8d 100644
--- a/rust/kernel/workqueue/mod.rs
+++ b/rust/kernel/workqueue/mod.rs
@@ -219,6 +219,16 @@
     ScopedWorkItem, //
 };
 
+#[cfg(CONFIG_DMA_SHARED_BUFFER)]
+mod dma_fence;
+#[cfg(CONFIG_DMA_SHARED_BUFFER)]
+pub use self::dma_fence::{
+    new_dma_fence_work,
+    DmaFenceQueue,
+    DmaFenceWork,
+    DmaFenceWorkItem, //
+};
+
 /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
 macro_rules! new_work {

---
base-commit: abfb640b2374e26de8ff81d488c39d8254db538e
change-id: 20261127-dma-fence-work-fb3e6e23659e
prerequisite-message-id: <20261119-rust-workqueue-v4-0-707c68994940@google.com>
prerequisite-patch-id: 2423b22dfde216dce30af3deb7eb7177505f5b96
prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78
prerequisite-patch-id: 0bf6ae4abcef7090d0e48921d6ec627a59dc6a7a
prerequisite-patch-id: cba4cd096a4df20f4597e9ea639881213c18a41b
prerequisite-patch-id: 97b26feddfa5b675204c9e8e75f3ad2958ec268a
prerequisite-change-id: 20261127-dma-fence-signalling-cae3def9aa97:v1
prerequisite-patch-id: 0c6f8b7108a5757d863b43508c42b57b132a42c7
prerequisite-patch-id: 82b6ae2b11186087986a05bd8a98f1c79c46ea2d

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

