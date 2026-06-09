Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89865CD8C9D
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 00:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E613F10E025;
	Tue,  9 Jun 2026 00:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="tnGwVyxc";
	dkim-atps=neutral
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE8410E025
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 00:33:06 +0000 (UTC)
Received: by mail-dl1-f74.google.com with SMTP id
 a92af1059eb24-137f3465368so6426904c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780965185; x=1781569985;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lyc7dOjOxSnLkSSxtBX+U+kb5dWselTPkf54g63ocWU=;
 b=tnGwVyxcMXmkTt35ekirZGKRRrQOVhaJ7pv/5Vkxmz0KXS6L0FPC14n9pHQRmfqx17
 Ps7uVKR0U6lBszGJSYPdaBIyhFr2KNIVNqFMGZOgcTZRmDq7Jz+ZElZTdpPQ2jJprR45
 0E5UlnmgQXc8i24FYxMQ51OV3kG+9iJ8CC8HgFYOvGizMn4iO3kAeAIkaVToYqweQgcO
 1jqHOEkcmMaWZgh2AFxy/bikAwbC4fPVXbaIId+9hTKOMFxf0xYUzkxJVx/yXoTkLBLw
 MV1/bYX9AbttEasEmVLyhryPJmneDDck1vZL0RkQGe0bNLvPHjtvxkPeRpl4DykqnfOI
 Rxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780965185; x=1781569985;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lyc7dOjOxSnLkSSxtBX+U+kb5dWselTPkf54g63ocWU=;
 b=SC/QbwuGkYSm82xJHcp7f0cLNRHxtskDeI31XybM0aC5tJkWWosO+nXMptIVLFz8t3
 eOodsON55XjM0WnsnpjDgrtSDWPfhepvgza5d9ouACDbXkKLbfUiSdRSB3b+w+x64ip1
 S0Tc0kmB8/cRsJDor3gkksgmWoh6xEj/qUp7fQoswbq4xfXxyMAi7/8FaZE1bsncSo5s
 ckQGjAZpX7jeWHRYn3cuaHOm7UDfquq+d2HIWk39vIBUWNt8WdQx1MxYWkdTboQkxTVh
 nxIcmt2Yeamx9jqu9Cj8CmBfeuNc4SLcc/7SbevARm32trzu9f881YViK4y4ACdKeRFG
 17HQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UriM4qApnbJhdtXdJWj18SCfjut3RfeXwFsw5lRzcE662MgFIe4fRDSJMZ2MjDrDRMz+b9N+OpZI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJqTo73PNyLLf+Ww/vCQYh/g8GUev8CIs2D6G/ZpYD2FGXe/Hx
 wJIgi/7gk7RozXmvjyfiw4fCYzyQduY5IIme5oWU9SuZ4d326ArlRrCUByRcPCceAhFSp91BXhm
 zt5W3QaHfJI4AMlp0ha/ZYKxnleHYxA==
X-Received: from dlea1-n1.prod.google.com
 ([2002:a05:701b:4201:10b0:138:62a:280c])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2213:b0:137:ec47:8fef with SMTP id
 a92af1059eb24-138066a55ecmr4620265c88.14.1780965185131; 
 Mon, 08 Jun 2026 17:33:05 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:32:59 +0000
In-Reply-To: <20260609003256.1829625-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20260609003256.1829625-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp;
 fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=samitolvanen@google.com;
 h=from:subject; bh=/3G9s6EsR953QarWQ4gV7h6JpniJsvtQoDHD7H7aFZQ=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDFnq8db/190/2uMtcSN4NUdsy5mvxctmHa7sCxU1SAwsy
 dgvckepo5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAExkUg0jw1Gp5xGLXeoKl7Vt
 M2Fjn/qk2DvqhZpNlpqkfbbzB92Si4wMTVtWXuH9v7jIbsWO+VaaJpNKTxq8vXnU1vLgvLuZa7e
 6MwEA
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609003256.1829625-6-samitolvanen@google.com>
Subject: [PATCH v3 2/2] rust: drm: gpuvm: require Send and Sync for GpuVm's
 shared data
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

GpuVm implements Send and Sync unconditionally, but it shares and drops
T::VmBoData and T::Object across threads: obtain() can return ARefs to
the same bo on several threads, and deferred_cleanup() drops them on
whichever thread calls it. This is unsound unless both are Send + Sync,
so bound both impls accordingly.

Fixes: 82b78182eacf ("rust: drm: add base GPUVM immediate mode abstraction")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 rust/kernel/drm/gpuvm/mod.rs | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index ae58f6f667c1..398068f2eb4f 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -74,9 +74,25 @@ pub struct GpuVm<T: DriverGpuVm> {
 
 // SAFETY: The GPUVM api does not assume that it is tied to a specific thread. The destructor will
 // drop the `data` field, which is okay because it is guaranteed `Send` by the `DriverGpuVm` trait.
-unsafe impl<T: DriverGpuVm> Send for GpuVm<T> {}
-// SAFETY: The GPUVM api is designed to allow &self methods to be called in parallel.
-unsafe impl<T: DriverGpuVm> Sync for GpuVm<T> {}
+// `obtain()` called from several threads can return `ARef`s to the same bo, aliasing `T::VmBoData`
+// and `T::Object`, and `deferred_cleanup()` can drop them from any thread, so both must be
+// `Send + Sync`.
+unsafe impl<T: DriverGpuVm> Send for GpuVm<T>
+where
+    T::VmBoData: Send + Sync,
+    T::Object: Send + Sync,
+{
+}
+// SAFETY: The GPUVM api is designed to allow &self methods to be called in parallel. `obtain()`
+// called from several threads can return `ARef`s to the same bo, aliasing `T::VmBoData` and
+// `T::Object`, and `deferred_cleanup()` can drop them from any thread, so both must be
+// `Send + Sync`.
+unsafe impl<T: DriverGpuVm> Sync for GpuVm<T>
+where
+    T::VmBoData: Send + Sync,
+    T::Object: Send + Sync,
+{
+}
 
 // SAFETY: By type invariants, the allocation is managed by the refcount in `self.vm`.
 unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVm<T> {
-- 
2.54.0.1099.g489fc7bff1-goog

