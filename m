Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505BEC88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D7B10E9D5;
	Sun, 13 Sep 2026 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ed6Vk1jq";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3346710E0B9
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:38:04 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so1394807a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789324684; x=1789929484; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F1ucxwCu9RQD4D679j8zHYPWIOfpF32/a1fvobfc1os=;
 b=ed6Vk1jqZn2zI3trit6TSCofbZvquIotJ4FETwvUxb7ATiwU+OfUUK0z6Drrrl5b/h
 /h1u8EjyfQwWSLY2CTrDWdtYw3bgpmsZF7xuzYUrNrN8B0yiCGHatYK/e26t0/xkZk61
 t2JeBNl9fFPApAXyzaTvLEj2HBrRCIC5GItTMSptVNjSrd05R7IM5RaCHJuiuH77uVAk
 kzNtbKACf9PijkKzTIh6uVccrdZVsSrQIdh/VVXsT8ZWv81U6PXxUWCL1cmtQK2srv41
 G+p8FOR/oR9OiUlOCL0zHB+T+P7OUVTZOsuAMPjrertxhKoiBMlf22DUJY/pf8wpN+Bb
 b4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789324684; x=1789929484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F1ucxwCu9RQD4D679j8zHYPWIOfpF32/a1fvobfc1os=;
 b=ko/lAuXUHRgJqEdy8709ygh2rsGJLiB/Vi9fdQ5xfyGlHkvfB1c7ndlXX3WTh6i5Vi
 GJE9YwrF+YSA9nFWbEyRRzqq6qYWfV+fcOc3WLYv65lwoPGNmPy7h9lb6JKMEyqHkaYn
 bGUq9IyoTjZgVpDJUccsbQc/Cs0okpNkZqyfGsKh/zMppDnJ86B+brNqjdMh7TZiPMG5
 QEaBMQzV5+v9gZElmmi6pY4cWWUCC85uNwJAOqxk38+EnN7rJ/jQEHyQXoVncsa3/3Mi
 BZGpQKz/qG5tzeWX2wKXx+eB1/JB35Wrjv3duhJYg4S4gnwAqzny8pghcW+uAFZGhNf2
 rQvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlwBbqYxkX8OZnTcOgS6upiWTbtPzS1jvREVyP7V2HiVu6/NVbpFyyHRNr3JHh/o4vosXznbjVASE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntPnPdzDT90kmMQdLSNVZimkYlWDQMohsRA3SkvdFsysRMeZTX
 4ycto/Wx3Ip46yfIrkaVG1Ao1vBzpJw6Wzo2GwdUvR83z2c9JuR4Cni0
X-Gm-Gg: AYBFou3sX2k8WBwYQBkme6SYFY9XcuS7JKEVvMi7PJY7XAVLB1MP/ha65AoawIDVpiw
 8xXLEK/EpX3yYMYkil3BejWGkHJwvg8zIbTK+HJbpwRca9L9QKO1x2Pb+NZOV2CixryK5uJa6hc
 CBCkgA//77CpU4yCJ72e7tTeKaVetgbMsmEvH/oV5Rdg4TDlfUeWYCDxWN96zk9Vso1iA/HCMlf
 hRthTVjyq930EeqfgAyw0oDUk4olsujNRv5NTt8lwqrFQKcmmBxFRudAbXSM1yKrnHjJFtDjaY9
 bk5mi50nJUZIS7kb/ehXyLSSXXDeCWuKlPVVtdP3e00r+wR5ue1QQwQyilivwR3k0FWSTFvlyTC
 NKAMC+2/Qpov2BWusC0qgb5KI9cC3Xzk6cETH3Oxy9u2YZ2+fKZ3AKmKeP6Es/i1BO4VomubPW9
 1Ib2jDAQdqHzPvZBvvHgeAlm3/eL3buMlHxSsQ75CVSiYKMqRt78IqU2vTogKdFDvk5qS6u1LvC
 2K/ag==
X-Received: by 2002:a17:90b:3a0c:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-39d9c1dbb33mr27898773a91.16.1789324683339; 
 Sun, 13 Sep 2026 11:38:03 -0700 (PDT)
Received: from localhost ([95.190.112.239]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d9b08165fsm4118447a91.1.2026.09.13.11.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 11:38:02 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v4 2/3] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Date: Mon, 14 Sep 2026 01:37:33 +0700
Message-ID: <20260913183734.134307-3-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913183734.134307-1-vladazaharova2018@gmail.com>
References: <20260913183734.134307-1-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The GSP-RM log buffers are exposed through debugfs, but the Scope that
owns them lives in Gsp, inside GspResources, inside the Gpu built by
probe(). They are DMA allocations of the device and cannot outlive it,
so the entries go away as soon as the GPU is unbound - and, more to the
point, as soon as probe() fails, which is exactly when the log of a GSP
that did not come up is the thing one wants to read.

Add a gsp_keep_logs module parameter. When it is set, dropping the log
buffers copies whatever the GSP wrote into memory owned by the module
and exposes the copies until the module is unloaded. A buffer whose
"put" pointer is still zero was never written to and is skipped.

The GSP has normally been stopped by the time the buffers are dropped,
but a boot that timed out can leave it still appending, so a DMA read
barrier orders the read of the "put" pointer before the copy.

The copies belong to the module data next to the debugfs root, and live
in a "retained" directory created during module init rather than on
first use, which keeps the teardown path of a device from having to
create anything. Keeping them out of the directory used by bound GPUs
also means a device coming back does not find its debugfs name taken by
its own history; nouveau, which recreates the entries under the name of
the GPU that just went away, has that problem.

While at it, move the log buffer code out of gsp.rs into gsp/logbuffer.rs.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 drivers/gpu/nova-core/gsp.rs           |  97 ++--------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 253 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |  29 ++-
 3 files changed, 300 insertions(+), 79 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index f29e601e6753..1a1eb7f37075 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -12,11 +12,7 @@
         CoherentView,
         DmaAddress, //
     },
-    io::{
-        io_project,
-        io_write,
-        Io, //
-    },
+    io::io_write,
     pci,
     prelude::*, //
 };
@@ -24,9 +20,13 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+mod logbuffer;
 mod regs;
 mod sequencer;
 
+use logbuffer::LogBuffers;
+pub(crate) use logbuffer::RetainedLogs;
+
 pub(crate) use fw::{
     GspFmcBootParams,
     GspFwWprMeta,
@@ -77,10 +77,6 @@ pub(crate) fn dev(&self) -> &'gpu device::Device<device::Bound> {
     }
 }
 
-/// Number of GSP pages to use in a RM log buffer.
-const RM_LOG_BUFFER_NUM_PAGES: usize = 0x10;
-const LOG_BUFFER_SIZE: usize = RM_LOG_BUFFER_NUM_PAGES * GSP_PAGE_SIZE;
-
 /// Array of page table entries, as understood by the GSP bootloader.
 #[repr(C)]
 #[derive(FromBytes, IntoBytes)]
@@ -101,49 +97,6 @@ fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
     }
 }
 
-/// The logging buffers are byte queues that contain encoded printf-like
-/// messages from GSP-RM.  They need to be decoded by a special application
-/// that can parse the buffers.
-///
-/// The 'loginit' buffer contains logs from early GSP-RM init and
-/// exception dumps.  The 'logrm' buffer contains the subsequent logs. Both are
-/// written to directly by GSP-RM and can be any multiple of GSP_PAGE_SIZE.
-///
-/// The physical address map for the log buffer is stored in the buffer
-/// itself, starting with offset 1. Offset 0 contains the "put" pointer (pp).
-/// Initially, pp is equal to 0. If the buffer has valid logging data in it,
-/// then pp points to index into the buffer where the next logging entry will
-/// be written. Therefore, the logging data is valid if:
-///   1 <= pp < sizeof(buffer)/sizeof(u64)
-struct LogBuffer<'a>(Coherent<'a, [u8; LOG_BUFFER_SIZE]>);
-
-impl<'a> LogBuffer<'a> {
-    /// Creates a new `LogBuffer` mapped on `dev`.
-    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
-        let obj = Self(Coherent::zeroed(dev, GFP_KERNEL)?);
-
-        let start_addr = obj.0.dma_address();
-
-        let pte_view = io_project!(
-            obj.0,
-            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
-        )
-        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
-        PteArray::init(pte_view, start_addr)?;
-
-        Ok(obj)
-    }
-}
-
-struct LogBuffers<'a> {
-    /// Init log buffer.
-    loginit: LogBuffer<'a>,
-    /// Interrupts log buffer.
-    logintr: LogBuffer<'a>,
-    /// RM log buffer.
-    logrm: LogBuffer<'a>,
-}
-
 /// GSP runtime data.
 #[pin_data]
 pub(crate) struct Gsp<'gsp> {
@@ -165,9 +118,7 @@ pub(crate) fn new(pdev: &'gsp pci::Device<device::Bound>) -> impl PinInit<Self,
         pin_init::pin_init_scope(move || {
             let dev = pdev.as_ref();
 
-            let loginit = LogBuffer::new(dev)?;
-            let logintr = LogBuffer::new(dev)?;
-            let logrm = LogBuffer::new(dev)?;
+            let log_buffers = LogBuffers::new(dev)?;
 
             // Initialise the logging structures. The OpenRM equivalents are in:
             // _kgspInitLibosLoggingStructures (allocates memory for buffers)
@@ -182,33 +133,23 @@ pub(crate) fn new(pdev: &'gsp pci::Device<device::Bound>) -> impl PinInit<Self,
                         GFP_KERNEL,
                     )?;
 
-                    libos.init_at(0, LibosMemoryRegionInitArgument::new("LOGINIT", &loginit.0))?;
-                    libos.init_at(1, LibosMemoryRegionInitArgument::new("LOGINTR", &logintr.0))?;
-                    libos.init_at(2, LibosMemoryRegionInitArgument::new("LOGRM", &logrm.0))?;
+                    libos.init_at(
+                        0,
+                        LibosMemoryRegionInitArgument::new("LOGINIT", &log_buffers.loginit.0),
+                    )?;
+                    libos.init_at(
+                        1,
+                        LibosMemoryRegionInitArgument::new("LOGINTR", &log_buffers.logintr.0),
+                    )?;
+                    libos.init_at(
+                        2,
+                        LibosMemoryRegionInitArgument::new("LOGRM", &log_buffers.logrm.0),
+                    )?;
                     libos.init_at(3, LibosMemoryRegionInitArgument::new("RMARGS", rmargs))?;
 
                     libos.into()
                 },
-                logs <- {
-                    let log_buffers = LogBuffers {
-                        loginit,
-                        logintr,
-                        logrm,
-                    };
-
-                    // PANIC: The module data cannot be gone here. It is published before the
-                    // driver is registered and taken down after it is unregistered, so it is
-                    // there for as long as probe() can be called.
-                    let log_parent: &debugfs::Dir = crate::debugfs_data()
-                        .expect("module data not initialized")
-                        .root();
-
-                    log_parent.scope(log_buffers, dev.name(), |logs, dir| {
-                        dir.read_binary_file(c"loginit", &logs.loginit.0);
-                        dir.read_binary_file(c"logintr", &logs.logintr.0);
-                        dir.read_binary_file(c"logrm", &logs.logrm.0);
-                    })
-                },
+                logs <- log_buffers.scope(),
             }))
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/logbuffer.rs b/drivers/gpu/nova-core/gsp/logbuffer.rs
new file mode 100644
index 000000000000..890aa2f9e38e
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/logbuffer.rs
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! GSP-RM log buffers, and the debugfs entries exposing them.
+
+use core::convert::Infallible;
+
+use kernel::{
+    debugfs,
+    device,
+    dma::Coherent,
+    io::{
+        io_project,
+        Io, //
+    },
+    prelude::*,
+    str::CString,
+    sync::barrier::{
+        dma_mb,
+        Read, //
+    }, //
+};
+
+use crate::gsp::{
+    PteArray,
+    GSP_PAGE_SIZE, //
+};
+
+/// Number of GSP pages to use in a RM log buffer.
+const RM_LOG_BUFFER_NUM_PAGES: usize = 0x10;
+const LOG_BUFFER_SIZE: usize = RM_LOG_BUFFER_NUM_PAGES * GSP_PAGE_SIZE;
+
+/// The logging buffers are byte queues that contain encoded printf-like
+/// messages from GSP-RM.  They need to be decoded by a special application
+/// that can parse the buffers.
+///
+/// The 'loginit' buffer contains logs from early GSP-RM init and
+/// exception dumps.  The 'logrm' buffer contains the subsequent logs. Both are
+/// written to directly by GSP-RM and can be any multiple of GSP_PAGE_SIZE.
+///
+/// The physical address map for the log buffer is stored in the buffer
+/// itself, starting with offset 1. Offset 0 contains the "put" pointer (pp).
+/// Initially, pp is equal to 0. If the buffer has valid logging data in it,
+/// then pp points to index into the buffer where the next logging entry will
+/// be written. Therefore, the logging data is valid if:
+///   1 <= pp < sizeof(buffer)/sizeof(u64)
+pub(super) struct LogBuffer<'a>(pub(super) Coherent<'a, [u8; LOG_BUFFER_SIZE]>);
+
+impl<'a> LogBuffer<'a> {
+    /// Creates a new `LogBuffer` mapped on `dev`.
+    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+        let obj = Self(Coherent::zeroed(dev, GFP_KERNEL)?);
+
+        let start_addr = obj.0.dma_address();
+
+        let pte_view = io_project!(
+            obj.0,
+            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
+        )
+        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
+        PteArray::init(pte_view, start_addr)?;
+
+        Ok(obj)
+    }
+
+    /// Copies the contents of this buffer into memory that does not belong to the device.
+    ///
+    /// A buffer the GSP never wrote to yields an empty vector, as it holds nothing worth keeping.
+    fn snapshot(&self) -> Result<VVec<u8>> {
+        // Offset 0 holds the "put" pointer, which the GSP advances as it appends entries. It is
+        // still zero if nothing was ever logged, which is all that is tested here: a buffer that
+        // was written to is copied whole, and making sense of "put" is left to the decoder.
+        let put = io_project!(self.0, [build: ..size_of::<u64>()]).try_cast::<u64>()?;
+        if put.read_val() == 0 {
+            return Ok(VVec::new());
+        }
+
+        // ORDERING: LOAD->LOAD ordering needed to order the "put" read before the data read. The
+        // GSP has normally been stopped by the time this runs, but a boot that timed out can leave
+        // it still appending.
+        dma_mb(Read);
+
+        let mut snapshot = VVec::zeroed(LOG_BUFFER_SIZE, GFP_KERNEL)?;
+        io_project!(self.0, [build: ..]).copy_to_slice(&mut snapshot);
+
+        Ok(snapshot)
+    }
+}
+
+/// The log buffers of a GPU, for as long as it is bound to the driver.
+pub(super) struct LogBuffers<'a> {
+    /// Device the buffers belong to. Also names their debugfs directory.
+    dev: &'a device::Device<device::Bound>,
+    /// Init log buffer.
+    pub(super) loginit: LogBuffer<'a>,
+    /// Interrupts log buffer.
+    pub(super) logintr: LogBuffer<'a>,
+    /// RM log buffer.
+    pub(super) logrm: LogBuffer<'a>,
+}
+
+impl<'a> LogBuffers<'a> {
+    /// Allocates the three log buffers of `dev`.
+    pub(super) fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+        Ok(Self {
+            dev,
+            loginit: LogBuffer::new(dev)?,
+            logintr: LogBuffer::new(dev)?,
+            logrm: LogBuffer::new(dev)?,
+        })
+    }
+
+    /// Creates an initializer exposing these buffers under a directory named after their device.
+    pub(super) fn scope(self) -> impl PinInit<debugfs::Scope<Self>, Infallible> + 'a {
+        let dev = self.dev;
+
+        // PANIC: The module data cannot be gone here. It is published before the driver is
+        // registered and taken down after it is unregistered, so it is there for as long as
+        // probe() can be called.
+        let log_parent: &debugfs::Dir = crate::debugfs_data()
+            .expect("module data not initialized")
+            .root();
+
+        log_parent.scope(self, dev.name(), |logs, dir| {
+            dir.read_binary_file(c"loginit", &logs.loginit.0);
+            dir.read_binary_file(c"logintr", &logs.logintr.0);
+            dir.read_binary_file(c"logrm", &logs.logrm.0);
+        })
+    }
+
+    /// Preserves whatever the GSP logged, so it can still be read once the GPU is gone.
+    ///
+    /// The buffers are DMA allocations of the device and cannot outlive it, so their contents are
+    /// copied into memory owned by the module and exposed through fresh debugfs entries. Those
+    /// live until the module is unloaded.
+    ///
+    /// Does nothing if `gsp_keep_logs` was not set when the module was loaded, as there is then
+    /// no directory to put the copies in.
+    fn retain(&self) -> Result {
+        // Copying is only worth it if there is somewhere to put the result, but the lock is
+        // dropped right away: what follows allocates 64 KiB three times, and no other device
+        // should have to wait for that.
+        let Some(data) = crate::debugfs_data() else {
+            return Ok(());
+        };
+
+        // The directory is taken here and the lock dropped again right away: what follows
+        // allocates 64 KiB three times, and no other device should have to wait for that.
+        let Some(dir) = data.retained_logs().lock().dir.clone() else {
+            return Ok(());
+        };
+
+        let logs = RetainedLogBuffers {
+            name: CString::try_from_fmt(fmt!("{}", self.dev.name()))?,
+            loginit: self.loginit.snapshot()?,
+            logintr: self.logintr.snapshot()?,
+            logrm: self.logrm.snapshot()?,
+        };
+
+        // Nothing was ever logged, so there is nothing to keep. A copy from an earlier run of
+        // this device is deliberately left alone: logs from a run that failed are worth more
+        // than the silence of one that did not.
+        if logs.loginit.is_empty() && logs.logintr.is_empty() && logs.logrm.is_empty() {
+            return Ok(());
+        }
+
+        // Take every allocation that can fail before the previous copy of this device is
+        // dropped, so that running out of memory here cannot leave it with no logs at all.
+        let scope = KBox::<debugfs::Scope<RetainedLogBuffers>>::new_uninit(GFP_KERNEL)?;
+
+        let mut retained = data.retained_logs().lock();
+
+        retained.gpus.reserve(1, GFP_KERNEL)?;
+
+        // An earlier run of the same device may have left a copy behind, and its directory
+        // carries the name about to be used again, so it has to go first. Nothing below can
+        // fail, so the replacement is guaranteed to take its place.
+        retained.gpus.retain(|gpu| *gpu.name != *logs.name);
+
+        let scope = scope.write_pin_init(dir.scope(logs, self.dev.name(), |logs, dir| {
+            if !logs.loginit.is_empty() {
+                dir.read_binary_file(c"loginit", &logs.loginit);
+            }
+            if !logs.logintr.is_empty() {
+                dir.read_binary_file(c"logintr", &logs.logintr);
+            }
+            if !logs.logrm.is_empty() {
+                dir.read_binary_file(c"logrm", &logs.logrm);
+            }
+        }))?;
+
+        retained.gpus.push(scope, GFP_KERNEL)?;
+
+        dev_dbg!(self.dev, "GSP-RM log buffers retained\n");
+
+        Ok(())
+    }
+}
+
+impl Drop for LogBuffers<'_> {
+    fn drop(&mut self) {
+        if let Err(e) = self.retain() {
+            dev_warn!(self.dev, "failed to retain GSP-RM log buffers: {:?}\n", e);
+        }
+    }
+}
+
+/// Copies of the log buffers of a GPU that is no longer around.
+struct RetainedLogBuffers {
+    /// Name of the device the buffers came from, which also names their directory.
+    ///
+    /// A copy rather than a reference to the device, so that a GPU that is gone does not stay
+    /// allocated for as long as its logs are kept.
+    name: CString,
+    /// Contents of the init log buffer, empty if it was never written to.
+    loginit: VVec<u8>,
+    /// Contents of the interrupts log buffer, empty if it was never written to.
+    logintr: VVec<u8>,
+    /// Contents of the RM log buffer, empty if it was never written to.
+    logrm: VVec<u8>,
+}
+
+/// Log buffers of GPUs that are gone, and the debugfs entries exposing them.
+///
+/// The copies live under a `retained` directory of their own instead of next to the entries of
+/// the GPUs that are actually bound, so that a device coming back does not find its name taken.
+pub(crate) struct RetainedLogs {
+    /// Parent directory of all copies. `None` unless retaining was asked for.
+    dir: Option<debugfs::Dir>,
+    /// One entry per GPU.
+    gpus: KVec<Pin<KBox<debugfs::Scope<RetainedLogBuffers>>>>,
+}
+
+impl RetainedLogs {
+    /// Creates an empty set of retained log buffers, retaining disabled.
+    pub(crate) const fn new() -> Self {
+        Self {
+            dir: None,
+            gpus: KVec::new(),
+        }
+    }
+
+    /// Creates the directory the copies will live in, enabling retaining.
+    ///
+    /// Does nothing without `CONFIG_DEBUG_FS`, where a [`debugfs::Dir`] is a zero-sized type and
+    /// the copies could never be read back.
+    pub(crate) fn enable(&mut self, parent: &debugfs::Dir) {
+        if !cfg!(CONFIG_DEBUG_FS) {
+            return;
+        }
+
+        self.dir = Some(parent.subdir(c"retained"));
+    }
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 0f8501c26e05..1ea61a2ebf4f 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -7,6 +7,7 @@
     driver::Registration,
     pci,
     prelude::*,
+    sync::Mutex,
     InPlaceModule, //
 };
 
@@ -44,6 +45,11 @@
 /// driver registration.
 #[pin_data(PinnedDrop)]
 pub(crate) struct DebugfsData {
+    /// Copies of the log buffers of GPUs that are gone.
+    ///
+    /// Declared before `root`, as the copies live below it.
+    #[pin]
+    retained_logs: Mutex<gsp::RetainedLogs>,
     /// Root directory of the driver in debugfs.
     root: debugfs::Dir,
 }
@@ -51,8 +57,18 @@ pub(crate) struct DebugfsData {
 impl DebugfsData {
     /// Creates the shared data and publishes it, so that [`debugfs_data()`] can hand it out.
     fn new() -> impl PinInit<Self> {
+        let root = debugfs::Dir::new(c"nova-core");
+
+        // Deciding here, rather than when the first GPU goes away, keeps the teardown path of a
+        // device from having to create anything.
+        let mut retained_logs = gsp::RetainedLogs::new();
+        if module_parameters::gsp_keep_logs.value() {
+            retained_logs.enable(&root);
+        }
+
         pin_init!(&this in Self {
-            root: debugfs::Dir::new(c"nova-core"),
+            retained_logs <- kernel::new_mutex!(retained_logs),
+            root,
             _: {
                 // SAFETY: Module initialization runs once and before the driver is registered, so
                 // nothing can be reading `DEBUGFS_DATA` while it is written here. `this` is where
@@ -66,6 +82,11 @@ fn new() -> impl PinInit<Self> {
     pub(crate) fn root(&self) -> &debugfs::Dir {
         &self.root
     }
+
+    /// Returns the copies of the log buffers of GPUs that are gone.
+    pub(crate) fn retained_logs(&self) -> &Mutex<gsp::RetainedLogs> {
+        &self.retained_logs
+    }
 }
 
 #[pinned_drop]
@@ -119,6 +140,12 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
     description: "Nova Core GPU driver",
     license: "GPL v2",
     firmware: [],
+    params: {
+        gsp_keep_logs: bool {
+            default: false,
+            description: "Keep the GSP-RM log buffers in debugfs after their GPU is gone",
+        },
+    },
 }
 
 kernel::module_firmware!(firmware::ModInfoBuilder);
-- 
2.55.0

