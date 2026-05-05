Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBABBFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C16010E442;
	Tue,  5 May 2026 13:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="B54WZbvR";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35BBC10E43F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:29:54 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-672a22b0cd3so4569444a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777987793; x=1778592593;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=CpepGuKXgfvFMmQ+T342/Rhe0BYRQCqXBCcIl4WlfVw=;
 b=B54WZbvRioPt25p77+U3dHa/xQa0hb8Uwf1V0ML2JqRnF+rdrXayHkcV7gA7CsMqtH
 w32JXn+HmXAYhA4SCNEbyFi1cRe9jyFIwL48ZbcqRuoxJgDR06BegUg8eATw0sZ/wTCG
 y2vuscJueCWBgAQknnPATvWfGMsZY9ybPj7jKMbDwsqMMMiIayvWQ5VZejXM3BSkqC17
 WhOwjEorwx5qmIljaQ8QNnL627buix4bS3dxUrRKK0Yff31HcjjsqwlWyBmKSxi6PjbQ
 lSyom0DkhEkQysS9bYdQKQK5dfsqO0WKGr9vcGDmv6f6ZWCFcxSF8Eks04/1mbAN9Kjl
 tcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987793; x=1778592593;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CpepGuKXgfvFMmQ+T342/Rhe0BYRQCqXBCcIl4WlfVw=;
 b=U5wu4nRTyuqlEK6zb3zIzPojmzpHFWLkddMfsLUgn5tq3T2Bb7xo+2SvG/Dvjs5dcO
 /f3vKHCxSW5iV4E1uQ5dpy2xNiflbNVi17llwVCELMpDkjcpjG1GNH60gSwyoxIZAs9W
 RsCIMmRSzJ+ogJxh01u3sWNYvuUsX182Y6SPNu7x079oEl+DLKsaJErasYjgnNdWDIAI
 ZvUwgkth6mZSi+LRe/ImUqgNOwgmaftLP9SM/vofedE6ErQWT7IaSJ3g2u0A9YWqhKOY
 dslFk7BFpf9dklVOZ5rZLqXxNpEHL9PFKe2Hd8LYHHXWLh/2ySWnzVJXCfIn2CCUSq3f
 921A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Qg7rlpQ6ctc+b19nLIttez69cSAlztMi4E5nuLKqP7NZnD0bY90r9dXgqwAAuUReG2Kl0y1KG4So=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsvasDmZ79bRz/eobNdp64yBfUDKsvQUcj+VXKclpok+bNars2
 8fsLYmoLTKZeJSSw3l0Qg1q7g+TMwrOT28M8gU/0njSUH8mCOMwMOqZLyfHeU6R/tdDnih24koE
 3rx7H6VdME+GnzPzlzQ==
X-Received: from edt4.prod.google.com ([2002:a05:6402:4544:b0:674:91ac:5f8d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d549:0:b0:67c:89f2:ae27 with SMTP id
 4fb4d7f45d1cf-67cc392dd47mr1230899a12.9.1777987792212; 
 Tue, 05 May 2026 06:29:52 -0700 (PDT)
Date: Tue, 05 May 2026 13:29:36 +0000
In-Reply-To: <20260505-gpuvm-drm-exec-v1-0-958306ded36e@google.com>
Mime-Version: 1.0
References: <20260505-gpuvm-drm-exec-v1-0-958306ded36e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=qNt2YdF4x2/LkeE3v0aanKcghsBitoEfdGwCtuzYJG8=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+fDN5yfDPclhyo9aW/ZKlIgjXm3Vd+w2m/7ka
 jLF9JvKgy2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafnwzQAKCRAEWL7uWMY5
 RtbXD/9h1m28gW+XzDUCixlmkFA9bVKmREih8TMXWDOjzdNd64jBqUuL7J0kBuPnFTOR2e/BQgs
 56VQrHNqszkoPsZ55YDJZ9Abk7+3Zv8CTNL/lQG6KSFQDZ9CG3MJ30VTUZq94BBbKVsC/D9tf44
 MlMgbxRQWEOyM7YAlzO2nouLO1zVG0lip/j/UFiFbktLb8o16a/eTtikKYhR7zw+fPfprLnqNSR
 zh+w18CDNl9aL2T+/8ba4NZxvaZ/gFHPMD6jr34ORM/jGHN6P39kUe4iZgqIp93OC527T6+AuhY
 6kowv1GJx7/uQ/+T8RfnPCsL2rTWLe+7MXv6CKu+VE7bzSHR1MPi678g+SNAETbk47xGGF5MRbz
 j6u4Vs9vzeJ4u84Q5f4uN16zzxRx+RV8/clqcOzRCsCXFr0T0EFaSHEQ8xsPu880DSu37lVTX6J
 Lh2VsMV6fTByQpYSU+8sFQRwhkKu4hVPvSHNaL8hIxtTmHL9ikQ4CDj74y2sGKeWKea0bIaZbSv
 FwvtauuGjX461Xw7NaS+xQguhgvXvAQWgGCc1fSfwc01LLg+9dU8l9BCNTzxhI2OQ7nhsFAda9v
 URTWkLpyAspRgQ4unH6xm4eOe7HkCr7tnTEzAvE9K4trHFjVGLOQvTwhGnl7lRuO9nsMiaWoMfG
 ah5N6vB46gV7/qg==
X-Mailer: b4 0.14.3
Message-ID: <20260505-gpuvm-drm-exec-v1-1-958306ded36e@google.com>
Subject: [PATCH 1/2] rust: dma_buf: add stub dma_fence abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>,
 Philipp Stanner <pstanner@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Alice Ryhl <aliceryhl@google.com>
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

From: Philipp Stanner <pstanner@redhat.com>

This adds a trivial DMA Fence type for use in other abstractions that
need to take a DMA fence as a parameter. For now, the type is a stub,
but may be used with fences defined by C.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This stub is included only for completeness. Most likely we will land
this on top of the Philipp's patch that actually adds Fence for real,
and this stub commit will not be necessary.

Taken from:
https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/merge_requests/1
---
 rust/kernel/dma_buf/dma_fence.rs | 32 ++++++++++++++++++++++++++++++++
 rust/kernel/dma_buf/mod.rs       |  7 +++++++
 rust/kernel/lib.rs               |  1 +
 3 files changed, 40 insertions(+)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
new file mode 100644
index 000000000000..135df74013db
--- /dev/null
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2025, 2026 Red Hat Inc.:
+//   - Philipp Stanner <pstanner@redhat.com>
+
+//! DMA Fence support.
+//!
+//! Reference: <https://docs.kernel.org/driver-api/dma-buf.html#c.dma_fence>
+//!
+//! C header: [`include/linux/dma-fence.h`](srctree/include/linux/dma-fence.h)
+
+use crate::{
+    bindings,
+    prelude::*,
+    types::Opaque, //
+};
+
+/// A dma fence.
+#[pin_data]
+#[repr(transparent)]
+pub struct Fence {
+    #[pin]
+    inner: Opaque<bindings::dma_fence>,
+}
+
+impl Fence {
+    /// Access the raw dma fence.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::dma_fence {
+        self.inner.get()
+    }
+}
diff --git a/rust/kernel/dma_buf/mod.rs b/rust/kernel/dma_buf/mod.rs
new file mode 100644
index 000000000000..b66e747c35ad
--- /dev/null
+++ b/rust/kernel/dma_buf/mod.rs
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DMA-buf subsystem abstractions.
+
+pub mod dma_fence;
+
+pub use self::dma_fence::Fence;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b72b2fbe046d..a05ccaa7598c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -63,6 +63,7 @@
 pub mod device_id;
 pub mod devres;
 pub mod dma;
+pub mod dma_buf;
 pub mod driver;
 #[cfg(CONFIG_DRM = "y")]
 pub mod drm;

-- 
2.54.0.545.g6539524ca2-goog

