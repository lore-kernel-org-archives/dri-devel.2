Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D23606A331
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFdmRN4g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3BE10E508;
	Sat, 14 Nov 2026 04:43:47 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367F510E508
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 04:43:41 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b09c07b3d2so1002869a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794631421; x=1795236221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nxr3ZDwtaNU21THfRnV8s6g2DT3nrxzbQYYuGLe80eg=;
 b=GFdmRN4g/kA8xLtYOxFUKSnZ0RLIscj6vcqOGT2bTSzFIOceMKjjAP52XN+6XuLWJf
 MjeUoPlUUwoCfupR4XKvkdgRj3OuwVsflfWuO+z33owzAxwTeiRRbCbz1otM3kSMwFF3
 nsUvfY0sfD/+DduMbHM43jKajtUJsYgtOL+FTwUikeiI2g1EgaLeUhTcqz2RHauKJHRR
 ya8CUsnpli24Pjr/S3qQM2FvUoPDSGDoA9k0zCwBSaGUEzDRApVVtlyd6K+es6pqUAii
 g9gd4+6LPROaLk2DHOjTYinOV4APZBmbq9U8pkpuO31LcYZMv/RD8lLwau87vOpIxAMq
 wKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794631421; x=1795236221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nxr3ZDwtaNU21THfRnV8s6g2DT3nrxzbQYYuGLe80eg=;
 b=fbKIPjzv3X/GvNHIIWC/39y3hwKEtfwx/C5WAYIjtsAXHcGlBbfeK8kp8zESAUYiDx
 KinhLGaooS0e0mNM5cA+GiF0dawC6QupGDsQuaykYJdDwnAccWpbifqhq8J2cQRUrzCe
 4pkoObqbpb3eiXxo/pid9TQA3V8gSP3PVvl/hmT/9z3GqTUqoQNlJgrJOK+AK4w4yjZt
 Bx3NxBc0Zl99mG9AkgORjf98TgS3uk253z6QWuXJS/RpujykhuDSPOy1Tmen2HtOk6gb
 BCU8UjYskta24NaeaEvK2dTWyBHXNmPRr/KvTbkWZvwb8QBG/CcLnfpvNYCR6RtNiPuh
 KKDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEpQKP26aUX2S6sgatvLsNLk6j15JyUF7LC6emc2q1mj/BwIDJma8Pnu/O7CJz2SkZ1EE0lwRk4D9Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ge9K9Dm0xIQsCYrUN66UYhE0/jNqh2xj/pT63J3IlCkYMg1/w
 rchtOFJAheLZ5fG8mcFfM7XgIoJ1BgdBL45YjgICGnq9M5bGjR0VQBEt
X-Gm-Gg: AYBFou3j9KTRKx31QUQ8hN6PYsSIU3R1n6g40YU79myyxbSr1jzO2vKSG8M3QMyP4bb
 tvM6kEaYx5hud3rS1jvfEx+qFgSdUxApbaD/kKnOYN7yQVw2JYeaYOGsySOMm9pLzdQt94pf2v8
 178SH5dJk57VHasVcgVfPwvG1SVXYSpPCcC/MTkQdkGGE7/wHnpCDTLWPzQRcXdGEouCeP0OThs
 yiEoVexav6WBeTLxV/Nf/HAirSWtKi/PSHa6xcn3Wcb6OXUHF1bMwF/chdrYJRNnP9B6iM3i3nO
 8QEVfzjx+HF65Opvqgz1WchTqmoxpFOSdkCnRreK+M+X8N5/kxVAPaaRH4lPiddyUHhjnZo2bbF
 zvz9xbobkd+inun62RkN2BR5Zcsop4K+lqUy3WgTksP7h3CKHquwAMGXLEuC3fPXWOLtsvn9My9
 WrMWnPII7Bp9jZKOZCx/N2jxu3YddRkUPJErfSEZ8bvKmbfn3dbmONSea2mo6JNOrhFwPjSX9+c
 zklJWd/GT3hRGQFPC3U4SwEd4iOXahp5n5cFGw2RU9jTV3jaQbhuyKIbDhwI7f/CSZoVYjXVcad
 dudqTIZ3g9VCHG8HQcSbCJwXuN0VZoBLk20=
X-Received: by 2002:a17:90b:2692:b0:3b0:9941:8d41 with SMTP id
 98e67ed59e1d1-3b1b0b4b1f7mr4115419a91.28.1794631420458; 
 Fri, 13 Nov 2026 20:43:40 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3eaf732sm3230685a91.3.2026.11.13.20.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:43:40 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v8 3/4] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Date: Sat, 14 Nov 2026 11:43:03 +0700
Message-ID: <20261114044304.245684-4-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114044304.245684-1-vladazaharova2018@gmail.com>
References: <20261114044304.245684-1-vladazaharova2018@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GSP-RM log buffers are DMA allocations of the device, so their
debugfs files go away when the GPU is unbound, including when probe()
fails. That is when the logs are most needed.

Add a gsp_keep_logs module parameter. When it is set, the buffers are
copied into module memory when they are dropped, and the copies are
exposed in the same files until the GPU is bound again or the module is
unloaded.

Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 drivers/gpu/nova-core/debugfs.rs       |  18 ++-
 drivers/gpu/nova-core/gsp.rs           |  42 +++----
 drivers/gpu/nova-core/gsp/logbuffer.rs | 150 ++++++++++++++++++++++++-
 drivers/gpu/nova-core/nova_core.rs     |   6 +
 4 files changed, 184 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/nova-core/debugfs.rs b/drivers/gpu/nova-core/debugfs.rs
index 6c6ed129f0da..79e8fab945a3 100644
--- a/drivers/gpu/nova-core/debugfs.rs
+++ b/drivers/gpu/nova-core/debugfs.rs
@@ -4,12 +4,21 @@
 
 use kernel::{
     debugfs,
-    prelude::*, //
+    new_mutex,
+    prelude::*,
+    sync::Mutex, //
 };
 
+use crate::gsp::RetainedLogs;
+
 /// Debugfs data the module shares with every GPU it drives.
 #[pin_data]
 pub(crate) struct DebugfsData {
+    /// Copies of the GSP-RM log buffers of GPUs that are no longer bound.
+    ///
+    /// Declared before `root`, as the copies live below it.
+    #[pin]
+    retained_logs: Mutex<RetainedLogs>,
     /// Root directory of the driver in debugfs.
     root: debugfs::Dir,
 }
@@ -18,6 +27,7 @@ impl DebugfsData {
     /// Creates the debugfs data of the module.
     pub(crate) fn new() -> impl PinInit<Self> {
         pin_init!(Self {
+            retained_logs <- new_mutex!(RetainedLogs::new()),
             root: debugfs::Dir::new(c"nova-core"),
         })
     }
@@ -26,4 +36,10 @@ pub(crate) fn new() -> impl PinInit<Self> {
     pub(crate) fn root(&self) -> &debugfs::Dir {
         &self.root
     }
+
+    /// Returns the copies of the GSP-RM log buffers of GPUs that are no longer bound.
+    #[inline]
+    pub(crate) fn retained_logs(&self) -> &Mutex<RetainedLogs> {
+        &self.retained_logs
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 43df95406d35..43945f5c09c9 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -25,10 +25,8 @@
 mod regs;
 mod sequencer;
 
-use logbuffer::{
-    LogBuffer,
-    LogBuffers, //
-};
+use logbuffer::LogBuffers;
+pub(crate) use logbuffer::RetainedLogs;
 
 pub(crate) use fw::{
     GspFmcBootParams,
@@ -124,9 +122,7 @@ pub(crate) fn new(
         pin_init::pin_init_scope(move || {
             let dev = pdev.as_ref();
 
-            let loginit = LogBuffer::new(dev)?;
-            let logintr = LogBuffer::new(dev)?;
-            let logrm = LogBuffer::new(dev)?;
+            let log_buffers = LogBuffers::new(dev)?;
 
             // Initialise the logging structures. The OpenRM equivalents are in:
             // _kgspInitLibosLoggingStructures (allocates memory for buffers)
@@ -141,29 +137,23 @@ pub(crate) fn new(
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
-                    let log_parent: &debugfs::Dir =
-                        crate::NovaCoreModule::debugfs_data(dev).root();
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
index 1fb411ce6d01..79dcd85c125b 100644
--- a/drivers/gpu/nova-core/gsp/logbuffer.rs
+++ b/drivers/gpu/nova-core/gsp/logbuffer.rs
@@ -2,19 +2,30 @@
 
 //! GSP-RM log buffers.
 
+use core::convert::Infallible;
+
 use kernel::{
+    debugfs,
     device,
     dma::Coherent,
     io::{
         io_project,
         Io, //
     },
-    prelude::*, //
+    prelude::*,
+    str::CString,
+    sync::barrier::{
+        dma_mb,
+        Read, //
+    }, //
 };
 
-use crate::gsp::{
-    PteArray,
-    GSP_PAGE_SIZE, //
+use crate::{
+    gsp::{
+        PteArray,
+        GSP_PAGE_SIZE, //
+    },
+    NovaCoreModule, //
 };
 
 /// Number of GSP pages to use in a RM log buffer.
@@ -39,7 +50,7 @@
 
 impl<'a> LogBuffer<'a> {
     /// Creates a new `LogBuffer` mapped on `dev`.
-    pub(super) fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
         let obj = Self(Coherent::zeroed(dev, GFP_KERNEL)?);
 
         let start_addr = obj.0.dma_address();
@@ -53,9 +64,33 @@ pub(super) fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
 
         Ok(obj)
     }
+
+    /// Copies the buffer, or returns an empty vector if the GSP never wrote to it.
+    fn snapshot(&self) -> Result<VVec<u8>> {
+        let put = io_project!(self.0, [build: ..size_of::<u64>()])
+            .try_cast::<u64>()?
+            .read_val();
+        if put == 0 {
+            return Ok(VVec::new());
+        }
+
+        // ORDERING: LOAD->LOAD ordering needed to order the "put" read before the data read, as a
+        // GSP that failed to boot may still be writing.
+        dma_mb(Read);
+
+        let mut snapshot = VVec::zeroed(LOG_BUFFER_SIZE, GFP_KERNEL)?;
+        io_project!(self.0, [build: ..]).copy_to_slice(&mut snapshot);
+
+        // The copy reads "put" again, unordered against the data, so keep the value read above.
+        snapshot[..size_of::<u64>()].copy_from_slice(&put.to_ne_bytes());
+
+        Ok(snapshot)
+    }
 }
 
 pub(super) struct LogBuffers<'a> {
+    /// Device the buffers belong to.
+    dev: &'a device::Device<device::Bound>,
     /// Init log buffer.
     pub(super) loginit: LogBuffer<'a>,
     /// Interrupts log buffer.
@@ -63,3 +98,108 @@ pub(super) struct LogBuffers<'a> {
     /// RM log buffer.
     pub(super) logrm: LogBuffer<'a>,
 }
+
+impl<'a> LogBuffers<'a> {
+    /// Allocates the log buffers of `dev`.
+    pub(super) fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+        Ok(Self {
+            dev,
+            loginit: LogBuffer::new(dev)?,
+            logintr: LogBuffer::new(dev)?,
+            logrm: LogBuffer::new(dev)?,
+        })
+    }
+
+    /// Exposes the buffers in debugfs, in a directory named after their device.
+    pub(super) fn scope(self) -> impl PinInit<debugfs::Scope<Self>, Infallible> + 'a {
+        let dev = self.dev;
+        let data = NovaCoreModule::debugfs_data(dev);
+
+        // Retained copies of an earlier run use the same directory.
+        data.retained_logs().lock().remove(dev.name());
+
+        data.root().scope(self, dev.name(), |logs, dir| {
+            dir.read_binary_file(c"loginit", &logs.loginit.0);
+            dir.read_binary_file(c"logintr", &logs.logintr.0);
+            dir.read_binary_file(c"logrm", &logs.logrm.0);
+        })
+    }
+
+    /// Exposes copies of the buffers in their place, if `gsp_keep_logs` is set.
+    fn retain(&self) -> Result {
+        if !crate::module_parameters::gsp_keep_logs.value() {
+            return Ok(());
+        }
+
+        let logs = RetainedLogBuffers {
+            name: CString::try_from_fmt(fmt!("{}", self.dev.name()))?,
+            loginit: self.loginit.snapshot()?,
+            logintr: self.logintr.snapshot()?,
+            logrm: self.logrm.snapshot()?,
+        };
+
+        if logs.loginit.is_empty() && logs.logintr.is_empty() && logs.logrm.is_empty() {
+            return Ok(());
+        }
+
+        let scope = KBox::<debugfs::Scope<RetainedLogBuffers>>::new_uninit(GFP_KERNEL)?;
+        let data = NovaCoreModule::debugfs_data(self.dev);
+        let root = data.root();
+        let mut retained = data.retained_logs().lock();
+        retained.remove(self.dev.name());
+
+        let scope = scope.write_pin_init(root.scope(logs, self.dev.name(), |logs, dir| {
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
+        retained.push(scope)
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
+/// Copies of the log buffers of a GPU that is no longer bound.
+struct RetainedLogBuffers {
+    /// Name of the device, which also names the debugfs directory.
+    name: CString,
+    /// Init log buffer, empty if never written to.
+    loginit: VVec<u8>,
+    /// Interrupts log buffer, empty if never written to.
+    logintr: VVec<u8>,
+    /// RM log buffer, empty if never written to.
+    logrm: VVec<u8>,
+}
+
+/// Copies of the log buffers of all GPUs that are no longer bound.
+pub(crate) struct RetainedLogs(KVec<Pin<KBox<debugfs::Scope<RetainedLogBuffers>>>>);
+
+impl RetainedLogs {
+    pub(crate) const fn new() -> Self {
+        Self(KVec::new())
+    }
+
+    /// Drops the copies of the device named `name`, if any.
+    fn remove(&mut self, name: &CStr) {
+        self.0.retain(|gpu| *gpu.name != *name);
+    }
+
+    /// Adds the copies of a device.
+    fn push(&mut self, gpu: Pin<KBox<debugfs::Scope<RetainedLogBuffers>>>) -> Result {
+        self.0.push(gpu, GFP_KERNEL)?;
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index f5d08de8a212..1671e260dfb4 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -91,6 +91,12 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
     description: "Nova Core GPU driver",
     license: "GPL v2",
     firmware: [],
+    params: {
+        gsp_keep_logs: bool {
+            default: false,
+            description: "Keep the GSP-RM log buffers in debugfs after their GPU is unbound",
+        },
+    },
 }
 
 kernel::module_firmware!(firmware::ModInfoBuilder);
-- 
2.56.0

