Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DD606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ESRZje5o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EE410EBDA;
	Fri, 13 Nov 2026 07:53:53 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C45910EBDA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:53:47 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3b0b3438540so691624a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794556426; x=1795161226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MJx2VhkDwAThYqH3qA0MncZOWZgXmJc1U/NyauJfUPQ=;
 b=ESRZje5oB6dBByrQWflcr+EAxTgEMDTkWjEGTlStBjlW0usPtgRJOFH3EepYP/F/D6
 6JJPe4VGsNkMv1GZaxoFeh781GDyo0LgcXbBpmYPeaXIMzH+wwaL+rboW6/+4GDEsfAh
 zqxHFahqu5QzQ/EVFbIHBQyCEPnk6+eLtnO7NLtUHA/SE/UHkrfWW2LbAILM/EcSZ5MG
 AY7nMLVb9h3qhtr0JBN4AqSMEkNVkG/RX3QEPiiALJrUHsTZhyh5AamaeRJcihz0CjuE
 EXwQTIooJckZ0QUxwILxjLmbjLQYOQReqK0nL/VQzdi/4gIthHQlsdO+x7XRqvGBLwIy
 Zr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556426; x=1795161226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MJx2VhkDwAThYqH3qA0MncZOWZgXmJc1U/NyauJfUPQ=;
 b=LdYh5uE0xR2vfmsVg+AgtJMOFdH3eOuxcmrmDKxKCsD0WTpBR4Z/qNKF1CgiFMSoTX
 get+MnlweYOXemhnpniZ/rxTlgNUczki/7fG6hR2/WUWNUWo8GL18ms41yZdcnz9BRJY
 Eww1jfglyW9/ffzq73MvLg7f8BqsrHtiltRYlP9c6sQnjHCEQhbFyORRAPCgQDI4Budr
 PkPxjcnSb8RduRECciKWKQz7b5Khutg49eI/h9PhGi5FjNUaKZqLXuGxWixdRj9ubDIj
 b+4DQA9iy8/Zywrg8OBfwX2tMQuhjrw5/G+hppjqKpk7NY+tZM1lmBBL/gktq+CxU8/F
 dQqg==
X-Forwarded-Encrypted: i=1;
 AL+hErFjU+rAu58k4tO1S4lsyAgflWLrKg7bWJQxBxixkJ1NwmqYejW+fE3KQeN6k35gOBwB+5FGJGG45p0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/AbBrI+MokFakiBUG+A/d2jtB4wYN+fekd8La6J5xd44I2S4cM
 UHaptD/36cK6jjcwoa81+08CTnXtvifqf2x1jYG9AeYCu3+K+P3jJqZz
X-Gm-Gg: AYBFou1gslBqprKUMooRvC5Pjq7DnSXmJsnE35RMoJLcxmpI0Dxz+xz2QmLtnqcK5nn
 Iso0C6+fe+IAzOpLlLvZY3pdkVSq6bYcqf4vdPTxpnPcO27FJpHvxv5K1FZq//9q61pyBIywR+b
 HIfafnBvxoxQrBBnjCwA3Uh/eb+3d/ylIVk+KiMWxGbL/MsltWqKgHvnONm9wBNdvKQzxXrMLNL
 3l9U6XQCeSCBAM27yckw5Ky3tt7R1NDCGsIEwkx+/LnoZCm5RLzOfWehfqIFhinkyVjj0sqUiLl
 aQDAN6glg5qBwIamk65BTM7yUAVpeHT10ebTNaR4PgENd5Bky4x0/EHA1hsBQ3rulsKj8m1FTGZ
 fNg0WU2IZiNG5g+44qcwRoXRRLJd7DNFsUVZ79kdy+l63MCKqBH6oy1ofo9rg+QMEHlkFqoWqYY
 GmUjhhcKzMz2g0HbdFdvzJbORBA+b/6nLuQS+XQpIVlxXT/F5D1ez5gJqLDAFAwVpYawB/ejF5O
 4fc9M77hVMf9YulPVK3KHcdQFYKk6hr00XCD6pJPnWsg5Pd8qJn0q1txNYoxO+/KusK6CdXnaPp
 irPqbS0tlx2NU10vEjNuqbDYIHRi9gvQfFc=
X-Received: by 2002:a17:90b:1dc4:b0:3ab:b39f:41cd with SMTP id
 98e67ed59e1d1-3b1b0b5e500mr1447942a91.60.1794556426358; 
 Thu, 12 Nov 2026 23:53:46 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3b708adsm993234a91.4.2026.11.12.23.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:53:45 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v7 2/4] gpu: nova-core: gsp: move the log buffers into their
 own file
Date: Fri, 13 Nov 2026 14:53:15 +0700
Message-ID: <20261113075317.934264-3-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113075317.934264-1-vladazaharova2018@gmail.com>
References: <20261113075317.934264-1-vladazaharova2018@gmail.com>
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

Move the GSP-RM log buffer code from gsp.rs into gsp/logbuffer.rs, ahead
of extending it. No functional change.

Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 drivers/gpu/nova-core/gsp.rs           | 59 +++--------------------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 65 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 52 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 79ee74a0a16f..43df95406d35 100644
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
@@ -24,10 +20,16 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+mod logbuffer;
 mod nvkv;
 mod regs;
 mod sequencer;
 
+use logbuffer::{
+    LogBuffer,
+    LogBuffers, //
+};
+
 pub(crate) use fw::{
     GspFmcBootParams,
     GspFwWprMeta,
@@ -78,10 +80,6 @@ pub(crate) fn dev(&self) -> &'gpu device::Device<device::Bound> {
     }
 }
 
-/// Number of GSP pages to use in a RM log buffer.
-const RM_LOG_BUFFER_NUM_PAGES: usize = 0x10;
-const LOG_BUFFER_SIZE: usize = RM_LOG_BUFFER_NUM_PAGES * GSP_PAGE_SIZE;
-
 /// Array of page table entries, as understood by the GSP bootloader.
 #[repr(C)]
 #[derive(FromBytes, IntoBytes)]
@@ -102,49 +100,6 @@ fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
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
diff --git a/drivers/gpu/nova-core/gsp/logbuffer.rs b/drivers/gpu/nova-core/gsp/logbuffer.rs
new file mode 100644
index 000000000000..1fb411ce6d01
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/logbuffer.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! GSP-RM log buffers.
+
+use kernel::{
+    device,
+    dma::Coherent,
+    io::{
+        io_project,
+        Io, //
+    },
+    prelude::*, //
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
+    pub(super) fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
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
+}
+
+pub(super) struct LogBuffers<'a> {
+    /// Init log buffer.
+    pub(super) loginit: LogBuffer<'a>,
+    /// Interrupts log buffer.
+    pub(super) logintr: LogBuffer<'a>,
+    /// RM log buffer.
+    pub(super) logrm: LogBuffer<'a>,
+}
-- 
2.56.0

