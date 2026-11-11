Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C360A3806
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsFwQou3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F4D10FC30;
	Wed, 11 Nov 2026 16:19:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED76E10EA5E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:19:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D50AA46928;
 Wed, 11 Nov 2026 16:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F191F00A08;
 Wed, 11 Nov 2026 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794413986;
 bh=lGLmK5dw4SpXx2ZnUwOnF7DJKetT8Q6/Wf0ECSIHbMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MsFwQou3JJylY8p+5sJ8/TyxGF1Vcnk2S/XzUX5JtxWrdX1B6XW1MNIHBOzHcMhDP
 3ijVBGtGps+wx2EgDp81Das4IFzG+lcVxXtoUrLJEO8Ci+G5Ul/D5dBw84Tx2Jiu3E
 QTlwOG/6N9fLiOKp7oW5pN5utIytwu5SGh0R093NjRRoKuUPMPp8bxzKsgFzgUdHKH
 4gmnKYV1HjwFuBkjYZKqI5sQynjWluoq6xObw3Q0WcpzF1BQKLlZLCvHkpbf4FS0Y3
 nleXy+PLY1AK/WSo9dWQ0sO+zNT5HvG7LlWeEcOew6kaQUwvCLr9gEz9BO5gwiNtOJ
 8ml2u63bIPnTg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gpu: nova-core: use pin-init self-referential support
Date: Wed, 11 Nov 2026 17:19:03 +0100
Message-ID: <20261111161935.750047-2-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111161935.750047-1-dakr@kernel.org>
References: <20261111161935.750047-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Express all self-referential borrows through pin-init's self-referential
support [1], replacing unsafely derived references.

Cc: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/all/20261008-dev-selfref-v2-0-e280b3c8fba5@garyguo.net/ [1]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Changes in v2:
  - Make `Cmdq` lifetime covariant using existential lifetimes.
---
 drivers/gpu/nova-core/driver.rs       | 53 +++++++++------------------
 drivers/gpu/nova-core/gpu.rs          | 24 ++++--------
 drivers/gpu/nova-core/gsp/cmdq.rs     | 16 ++++++--
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs |  9 +++--
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs | 11 +++---
 5 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 2376d960eb6b..d6bc972d47c7 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -33,9 +33,11 @@
 #[pin_data]
 pub(crate) struct NovaCore<'bound> {
     #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
+    #[uses('gpu: invariant)]
+    _reg: auxiliary::Registration<'gpu, ForLt!(NovaCoreApi<'_>)>,
     #[pin]
-    pub(crate) gpu: Gpu<'bound>,
+    #[uses('bar1)]
+    pub(crate) gpu: Gpu<'bar>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
     bar1: pci::Bar<'bound>,
 }
@@ -129,44 +131,25 @@ fn probe<'bound>(
                 crate::irq::doorbell_test::run_selftest(pdev, bar, spec.chipset)?;
             },
 
-            // TODO: Use self-referential pin-init syntax once available.
-            gpu <- Gpu::new(
-                pdev,
-                // SAFETY: `bar` is initialized above, pinned, and outlives `gpu`.
-                unsafe { &*core::ptr::from_ref(bar) },
-                // SAFETY: `bar1` is initialized above, pinned, and outlives `gpu`.
-                unsafe { &*core::ptr::from_ref(bar1) },
-            ).pin_chain(|_gpu| {
+            gpu <- Gpu::new(pdev, bar, bar1).pin_chain(|_gpu| {
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
                 _gpu.run_selftests(pdev);
                 Ok(())
             }),
 
-            _reg: {
-                // TODO: Use `&gpu` self-referential pin-init syntax once available.
-                //
-                // SAFETY: `gpu` is initialized before this expression is evaluated
-                // (`try_pin_init!()` initializes fields in initializer order), lives at
-                // a pinned stable address, and is dropped after `_reg` (struct field
-                // drop order).
-                let gpu = unsafe {
-                    Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_ref().get_ref()))
-                };
-
-                // SAFETY: `NovaCore` is dropped when the device is unbound;
-                // i.e. `mem::forget()` is never called on it.
-                unsafe {
-                    auxiliary::Registration::new_with_lt(
-                        pdev.as_ref(),
-                        c"nova-drm",
-                        // TODO[XARR]: Use XArray or perhaps IDA for proper ID
-                        // allocation/recycling. For now, use a simple atomic counter that
-                        // never recycles IDs.
-                        AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
-                        crate::MODULE_NAME,
-                        NovaCoreApi::new(pdev, gpu),
-                    )?
-                }
+            // SAFETY: `NovaCore` is dropped when the device is unbound; i.e. `mem::forget()` is
+            // never called on it.
+            _reg: unsafe {
+                auxiliary::Registration::new_with_lt(
+                    pdev.as_ref(),
+                    c"nova-drm",
+                    // TODO[XARR]: Use XArray or perhaps IDA for proper ID
+                    // allocation/recycling. For now, use a simple atomic counter that
+                    // never recycles IDs.
+                    AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
+                    crate::MODULE_NAME,
+                    NovaCoreApi::new(pdev, gpu),
+                )?
             },
         })
     }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index d185e927233f..d35b686732b4 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -383,7 +383,8 @@ pub(crate) struct Gpu<'gpu> {
     /// any in-flight run of it has finished, before the command queue that it drains and the
     /// falcon that it reads are freed, and before the GSP is unloaded.
     #[pin]
-    _gsp_subtree: GspSubtree<'gpu>,
+    #[uses('tree)]
+    _gsp_subtree: GspSubtree<'gsp_resources>,
     /// Static GPU information as provided by the GSP.
     pub(crate) gsp_static_info: GetGspStaticInfoReply,
     /// GPU memory manager owning memory management resources.
@@ -403,9 +404,6 @@ pub(crate) struct Gpu<'gpu> {
     /// Must be kept declared *after* `gsp_resources`, as the latter's `PinnedDrop` implementation
     /// requires the sysmem flush page to be in place.
     sysmem_flush: SysmemFlush<'gpu>,
-    /// Borrow of `tree` that `_gsp_subtree` holds. A field that borrows a sibling field is
-    /// self-referential, which `pin_init` cannot express, so the borrow is taken by hand.
-    tree_ref: &'gpu Tree<'gpu>,
     /// The GIN CPU interrupt tree and the PCI vectors that deliver it.
     ///
     /// Must be kept declared *after* `_gsp_subtree`, which holds a borrow of it.
@@ -456,10 +454,6 @@ pub(crate) fn new<'a>(
 
             tree: Tree::new(pdev, bar, spec.chipset, irq::gsp::GSP_SUBTREE.into())?,
 
-            // SAFETY: `tree` is initialized above, is pinned at a stable address, and is dropped
-            // after every field that uses `tree_ref` (struct field drop order).
-            tree_ref: unsafe { &*core::ptr::from_ref(tree.as_ref().get_ref()) },
-
             _: {
                 let dma_mask = hal::gpu_hal(spec.chipset).dma_mask();
 
@@ -513,19 +507,17 @@ pub(crate) fn new<'a>(
             }),
 
             _: {
-                irq::gsp::quiesce(tree_ref, &gsp_resources.gsp_falcon);
+                irq::gsp::quiesce(tree.get_ref(), &gsp_resources.gsp_falcon);
             },
 
-            // SAFETY: the GSP falcon and the command queue are fields of `gsp_resources`, which
-            // is initialized above and pinned, so both references outlive the registration. The
-            // registration is a field of `Gpu` and is never leaked, so its `Drop` runs, and field
-            // drop order runs it before either is freed.
+            // SAFETY: The registration is owned by `Gpu`, which is dropped when the device is
+            // unbound, so the registration's `Drop` runs.
             _gsp_subtree <- unsafe {
                 GspSubtree::new(
                     pdev,
-                    tree_ref,
-                    &*core::ptr::from_ref(&gsp_resources.gsp_falcon),
-                    &*core::ptr::from_ref(&gsp_resources.gsp.cmdq),
+                    tree.get_ref(),
+                    &gsp_resources.get_ref().gsp_falcon,
+                    &gsp_resources.get_ref().gsp.cmdq,
                 )
             },
 
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 5f3de456042e..22a073233362 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -451,10 +451,15 @@ fn log(&self, dev: &device::Device) {
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
 /// area.
 #[pin_data]
-pub(crate) struct Cmdq<'cmdq> {
+pub(crate) struct Cmdq<'cmdq>
+where
+    // Hide the mutex's invariant resource lifetime so `Cmdq` remains covariant.
+    exists<'gpu>: 'cmdq,
+{
     /// Inner mutex-protected state.
     #[pin]
-    inner: Mutex<CmdqInner<'cmdq>>,
+    #[uses('gpu: invariant)]
+    inner: Mutex<CmdqInner<'gpu>>,
     /// DMA address of the command queue's shared memory region.
     pub(super) dma_addr: DmaAddress,
 }
@@ -498,6 +503,11 @@ pub(crate) fn new(
         })
     }
 
+    /// Runs `f` with the command queue locked.
+    fn with_inner_locked<R>(&self, f: impl FnOnce(&mut CmdqInner<'_>) -> R) -> R {
+        self.with_inner(|inner| f(&mut inner.lock()))
+    }
+
     /// Computes the checksum for the message pointed to by `it`.
     ///
     /// A message is made of several parts, so `it` is an iterator over byte slices representing
@@ -522,7 +532,7 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
     ///
     /// `EIO` if a message fails framing or checksum validation.
     pub(crate) fn drain(&self) -> Result {
-        self.inner.lock().drain()
+        self.with_inner_locked(|inner| inner.drain())
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index 04033c64ca72..f6db7ce62f39 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -302,10 +302,11 @@ pub(crate) fn send_gmc_command<C>(
         Error: From<C::InitError>,
         Error: From<<C::Reply as MessageFromGsp>::InitError>,
     {
-        let mut inner = self.inner.lock();
-        let seq = inner.send_gmc_command(command)?;
+        self.with_inner_locked(|inner| {
+            let seq = inner.send_gmc_command(command)?;
 
-        inner.await_gmc_reply::<C>(seq, on_event)
+            inner.await_gmc_reply::<C>(seq, on_event)
+        })
     }
 
     /// Sends `command` to the GSP without waiting for a reply.
@@ -323,7 +324,7 @@ pub(crate) fn send_gmc_command_no_wait<C>(&self, command: C) -> Result
         C: CommandToGsp<Reply = NoReply>,
         Error: From<C::InitError>,
     {
-        self.inner.lock().send_gmc_command(command).map(|_| ())
+        self.with_inner_locked(|inner| inner.send_gmc_command(command).map(|_| ()))
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 10d3f68b2f61..2a332e2f2450 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -273,10 +273,11 @@ pub(crate) fn send_rpc_command<M>(&self, command: M) -> Result<M::Reply>
         Error: From<M::InitError>,
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
-        let mut inner = self.inner.lock();
-        inner.send_rpc_command(command)?;
+        self.with_inner_locked(|inner| {
+            inner.send_rpc_command(command)?;
 
-        inner.await_rpc_msg()
+            inner.await_rpc_msg()
+        })
     }
 
     /// Sends `command` to the GSP without waiting for a reply.
@@ -293,7 +294,7 @@ pub(crate) fn send_rpc_command_no_wait<M>(&self, command: M) -> Result
         M: CommandToGsp<Reply = NoReply>,
         Error: From<M::InitError>,
     {
-        self.inner.lock().send_rpc_command(command)
+        self.with_inner_locked(|inner| inner.send_rpc_command(command))
     }
 
     /// Waits for an unsolicited GSP event of type `M`. Events that arrive before it are logged and
@@ -314,7 +315,7 @@ pub(crate) fn await_rpc_msg<M: MessageFromGsp>(&self) -> Result<M>
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        self.inner.lock().await_rpc_msg()
+        self.with_inner_locked(|inner| inner.await_rpc_msg())
     }
 }
 
-- 
2.56.0

