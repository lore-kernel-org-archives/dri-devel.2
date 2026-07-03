Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70798C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C677410F605;
	Fri,  3 Jul 2026 03:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="po8Jxzcj";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7867C10F605
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:03 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so52533f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047722; x=1783652522;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUgBn6zBfsTbi2CLsMgn9qh9uhx+O3ZRcBIzQDpiX/c=;
 b=po8JxzcjH26RcqD6SiAGRJ/G+4ryp4Vl3fQVGwjJ7pTwkP8Niuivnntt/tdahBrFUA
 Nor9UQKNVIFlzhCGQfVPYH6TW6OtqfSWRcIhYFdbhpQI3WajM8j9qttXZo39Pb2ZzpFC
 OxkBR6AXvy+nSwzLvAJGhehFuaWpYWqCz4Qk6hbjjohnNMkFxivR6vTToFOJ8d+KgVdo
 IDM8x9F/I4HZimjapgZ3pim2DElJQ+C1l7lNhsjVEjBwfiR8n45VQWjoRIDl/P89RazK
 Hlo0sqT5MuqOYWq9Yu+4PKbAIEoTx69SijLxS06T/pRb0Iym7aAJeR+1aVMHwjdcmNpE
 WTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047722; x=1783652522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LUgBn6zBfsTbi2CLsMgn9qh9uhx+O3ZRcBIzQDpiX/c=;
 b=n/vcLFUPabAeBmlz2hG7fxcq9hGxkebA3nnko1MaYbw0oLheoF/0nzu3EFbaY4aiDQ
 jOn9TQJumO+Lv3t60C0DC2Q87MTSygnWAKuPcRjZW1SvLOGjbia61G0Tpz+7r6r6fMEP
 nzgZgTJuLN22X8+JgmxgAS1b80X+EL+7EpdSCZmIemLaJ/o6UrBHveS7Tddzrtq+Sxbw
 etXlNBrbCijNb/Ow7Oh8M5C6yQReBg/fX7rVEiRyUlS5mIsmwjAfBkFwJKXJ2kwyKF69
 3Gco9zA8rlez2S6QOkeUZfyO41esZmy1tT073Dgexdha0f/of4I25gcv94NgdiOB53Se
 jK+Q==
X-Gm-Message-State: AOJu0Yzy8zDDFXVxL+w+cBtnTNvjpEeT/9i79ez/bai5QXR0dcEci/d5
 +bEiQePNJAoUmW5Vz5m0ZgadnUG5TZzoH1oHLQQTIKoAmw8RIGHynypeTM7uf7s0TA==
X-Gm-Gg: AfdE7cmc7vdPLvqqkMAeluip1fH1LsUYaXZvb8zjkHiVQuOr9PHkzqoJpBnUaMX1j2B
 OmoxYuhBnCVcxy2+ZK6QsAcwVmNgJD8PHeTxziE++W5UBBR6oRgh2e6Z4brPqbwQsKiLrGrriRX
 sJmpkPNb+gjjmc5LIF3U/nYB2pmLxlS0OQcrn+dyBmruv8cvJqBejzVQu/EIkgPsVOv55xrCqIM
 2ZHMdm/9O5Og7tzKz4c2oJYwRwDueVGRIaqqsBHd83RofAN6RlYQy2BWikChv3o2FB0WZo/hqM2
 av5VzmKklljSU7J/opKT6GxvjRXY6c1X9/Q2FaS7P3P8vdLqS+CitJ43Qhk7OOy3BqYWiKGo06X
 IYr2LScPRR26sahKWiLGLUkKWgxJlCiGkgSs4yNzdmnlGcUtXnKvnz33ywQRLcOvlUxOJLpnHjp
 ewLZI3kE4BGLJ8MnzqDPOaHL260i6e2dzjmJkkb90hVwdy4PtP09PCP0VF
X-Received: by 2002:a5d:5f54:0:b0:472:3090:d878 with SMTP id
 ffacd0b85a97d-477571cb785mr12685227f8f.4.1783047721804; 
 Thu, 02 Jul 2026 20:02:01 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:59 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 12/18] rust: drm: framebuffer: add geometry accessors,
 refcounting and a byte-slice vmap
Date: Fri,  3 Jul 2026 04:00:59 +0100
Message-ID: <20260703030123.2814-13-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

A driver that reads back a framebuffer's pixels (e.g. DisplayLink's evdi, whose
scanout is pulled by userspace via a GRABPIX ioctl rather than pushed to
hardware) needs three things the Framebuffer binding did not provide:

  - width()/height()/pitch() geometry accessors;

  - reference counting, so the framebuffer flipped in during an atomic commit can
    be held (ARef<Framebuffer>) and mapped later from an ioctl -- add
    AlwaysRefCounted backed by new drm_framebuffer_get()/put() helpers;

  - a way to read the mapping without unsafe in the driver -- add
    FramebufferVmap::as_bytes(), returning the plane-0 mapping as a &[u8] of
    height * pitch(0) bytes, valid for the guard's lifetime.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/helpers/drm/drm.c             |  1 +
 rust/helpers/drm/framebuffer.c     | 13 +++++++
 rust/kernel/drm/kms/framebuffer.rs | 54 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 rust/helpers/drm/framebuffer.c

diff --git a/rust/helpers/drm/drm.c b/rust/helpers/drm/drm.c
index 5d700d75c0c9..24c531841ba1 100644
--- a/rust/helpers/drm/drm.c
+++ b/rust/helpers/drm/drm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "atomic.c"
+#include "framebuffer.c"
 #include "gem.c"
 #include "vma_manager.c"
 #include "vblank.c"
diff --git a/rust/helpers/drm/framebuffer.c b/rust/helpers/drm/framebuffer.c
new file mode 100644
index 000000000000..280538ffb82c
--- /dev/null
+++ b/rust/helpers/drm/framebuffer.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <drm/drm_framebuffer.h>
+
+void rust_helper_drm_framebuffer_get(struct drm_framebuffer *fb)
+{
+	drm_framebuffer_get(fb);
+}
+
+void rust_helper_drm_framebuffer_put(struct drm_framebuffer *fb)
+{
+	drm_framebuffer_put(fb);
+}
diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
index 1ec6779ba7de..c7089b12d0d1 100644
--- a/rust/kernel/drm/kms/framebuffer.rs
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -9,6 +9,7 @@
     drm::device::Device,
     error::{code::EINVAL, to_result},
     prelude::*,
+    sync::aref::AlwaysRefCounted,
     types::*,
 };
 use bindings;
@@ -46,6 +47,23 @@ fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
 }
 
 // SAFETY: References to framebuffers are safe to be accessed from any thread
+// SAFETY: `struct drm_framebuffer` is refcounted via `drm_framebuffer_get()`/`drm_framebuffer_put()`,
+// which are the correct increment/decrement operations for it.
+unsafe impl<T: KmsDriver> AlwaysRefCounted for Framebuffer<T> {
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees the refcount is non-zero.
+        unsafe { bindings::drm_framebuffer_get(self.as_raw()) };
+    }
+
+    #[inline]
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee the refcount is non-zero; `Framebuffer<T>` has
+        // the same layout as `struct drm_framebuffer`.
+        unsafe { bindings::drm_framebuffer_put(obj.as_ptr().cast()) };
+    }
+}
+
 unsafe impl<T: KmsDriver> Send for Framebuffer<T> {}
 // SAFETY: References to framebuffers are safe to be accessed from any thread
 unsafe impl<T: KmsDriver> Sync for Framebuffer<T> {}
@@ -79,6 +97,30 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_framebuffer {
         self.0.get()
     }
 
+    /// The framebuffer's width in pixels.
+    #[inline]
+    pub fn width(&self) -> u32 {
+        // SAFETY: `as_raw()` is a valid framebuffer; `width` is set at creation and immutable.
+        unsafe { (*self.as_raw()).width }
+    }
+
+    /// The framebuffer's height in pixels.
+    #[inline]
+    pub fn height(&self) -> u32 {
+        // SAFETY: `as_raw()` is a valid framebuffer; `height` is set at creation and immutable.
+        unsafe { (*self.as_raw()).height }
+    }
+
+    /// The byte stride (pitch) of colour plane `index`.
+    ///
+    /// A `drm_framebuffer` has at most four colour planes; `index` is masked into `0..=3`.
+    #[inline]
+    pub fn pitch(&self, index: usize) -> u32 {
+        // SAFETY: `pitches` has four elements; `index & 3` keeps the access in bounds. The pitches
+        // are set at creation and immutable.
+        unsafe { (*self.as_raw()).pitches[index & 3] }
+    }
+
     /// Map this framebuffer's plane-0 backing pages into the kernel address space for CPU
     /// access, for the duration of the returned guard.
     ///
@@ -123,6 +165,18 @@ pub fn as_ptr(&self) -> *const u8 {
         // SAFETY: set non-null in `Framebuffer::vmap`; `vaddr` is the active union member.
         (unsafe { self.map[0].__bindgen_anon_1.vaddr }) as *const u8
     }
+
+    /// Plane 0's mapped pixels as a byte slice.
+    ///
+    /// The slice covers `height * pitch(0)` bytes — the full extent of colour plane 0 — and is
+    /// valid for the guard's lifetime. This lets callers read the scanout buffer without `unsafe`.
+    #[inline]
+    pub fn as_bytes(&self) -> &[u8] {
+        let len = self.fb.height() as usize * self.fb.pitch(0) as usize;
+        // SAFETY: `drm_gem_fb_vmap` mapped colour plane 0 contiguously at `as_ptr()` for at least
+        // `height * pitch(0)` bytes, and the mapping is live for `self`'s lifetime.
+        unsafe { core::slice::from_raw_parts(self.as_ptr(), len) }
+    }
 }
 
 impl<'a, T: KmsDriver> Drop for FramebufferVmap<'a, T> {
-- 
2.55.0

