Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD1C43327
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA2210F5EB;
	Fri,  3 Jul 2026 03:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="ue0t2DV1";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9B510F5FD
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:48 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so268625e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047707; x=1783652507;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DO10bahdwhwvl3OteTgaG/ReLzyVlHiXZrXAAYDCZ/0=;
 b=ue0t2DV1M8eAJrxqO99KxzkmL3kooqniNeHeOKUA6ZuVWrEUrfvW2JyniItwj/gTEX
 Zda/b8s2IbcZgyKTacKRorfJO/mXeLkgjV11afuSsAC2BGHDZ/BSwMyZOzWe55ovNE5T
 aimKRfyC4OTjHNnnzZAPlMeFjt833yurHQ1XlV36UvGjhEKm66PvlsHGdeKtLIiJppXI
 wC89305UFDRAsVd+R1YCeY22m2atjGtr2hZvvsdqs+PoKZshZHI3cQRe4M1YcCvDhJSD
 tVVACS6TsrWv2xCgm9dC+IDckyeDBlADLtJWULMXMgRm3vLwC1qqasB1D+WLUQEf4Myt
 ULlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047707; x=1783652507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DO10bahdwhwvl3OteTgaG/ReLzyVlHiXZrXAAYDCZ/0=;
 b=nACVWd8MRYNOTds9tUuWbSpNZ9VmWLcF0QIB1ADbaqAFta30cMUZBk/CQkcdNSuYie
 ClbOZ/GTSRA/pxPYs4auXn/ZzTtKbxDZfDeCPeIdNA8kxRlXLkHLn1hcDHOAmSlMyx3I
 lqFT8F4FbYDvxulWp1wYS1KiNN4xCQbN91JhUwU/ET1K+XsAAHGTmVBmBQ2Mk4eA2s+1
 7QZh4XX5M4A6zoaeAjPcA6pZ7u5UJp6fTBHlEAtCWE918xkUUE8B8IwGBWIy5Pdljxnz
 J+6JnPHNm0x2SH5RzWuYRzWGq1miCW571TRtjykRicHbv5zssssm7a8rU+vU6n1s9abi
 6Niw==
X-Gm-Message-State: AOJu0YyyP3U9fskFO+jb4qq8NRwVqlk5ITrYC9DxxpU3EEVknp9ijIk0
 TCpWuqWrXchrUud4z2mVZy6E0bimXNZc6nGjOrN1fq9ge1XtFh8QXhEdNQ52fsVl7A==
X-Gm-Gg: AfdE7ckvfZVv65xLtY2ePUPTO8GIdRtaY66B3N/EnAzLIME177xmzaVpJBY/MwqOpjN
 JuIfiwSQdLuvJSttgsnll0gvafYe5BhfIY5bNt12W+nYbEB1n5jsiTOKZCGc9P9Q+FGW1kFJQ7f
 0/zC6bOH+aJFk3i7Pw6+3FsGEh4DQDxy/dLI+WvELaEb9c9VWt0Mv3+O0eprYG29EsEOfBUe6NX
 /gX4wEDEC3IYPMlIQ7ATudgHkpFH1FobbRGCBbTWK1mY168qJYdDcQeHeLajZEe/ZCwDKB3aJb0
 R90phYl2Mk0QDWJqKexBu5dhE659KM9ZwrgWwAMBAEfNsUCNW29nxcVIhTIiYMu4e7uqor31ea4
 2/8dV6MbToHD1rGdYUoqvRdAdYGKjxqCr5oj+LIPq2aUu+g3KgQz1RrZUlMHYEUFO4fs0xukPM7
 xQtwAY4qbkY5sfd+YLjn/LxYkIGOGQVLTosuQVFj9dO0LMRu7TXrvx93JJ
X-Received: by 2002:a05:6000:5c5:b0:474:530:9d with SMTP id
 ffacd0b85a97d-47757797bf8mr13513555f8f.13.1783047706825; 
 Thu, 02 Jul 2026 20:01:46 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:45 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/18] rust: drm: kms: add a Framebuffer::vmap() guard
Date: Fri,  3 Jul 2026 04:00:53 +0100
Message-ID: <20260703030123.2814-7-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
MIME-Version: 1.0
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

Framebuffer::vmap() maps a framebuffer's plane-0 backing pages into the
kernel address space via drm_gem_fb_vmap()/vunmap(), returning an RAII
FramebufferVmap guard that unmaps on drop. Only single-CPU-visible-plane
framebuffers are supported (packed formats backed by GEM-shmem/CMA;
multi-plane YUV or an unmapped imported dma-buf return EINVAL). This is
the driver-side FbVmap guard the v1 series carried, moved into the layer
proper so every KMS driver gets it instead of hand-rolling the same
map/use/unmap dance.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 rust/kernel/drm/kms/framebuffer.rs | 67 +++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
index 54d0391388a9..1ec6779ba7de 100644
--- a/rust/kernel/drm/kms/framebuffer.rs
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -5,7 +5,12 @@
 //! C header: [`include/drm/drm_framebuffer.h`](srctree/include/drm/drm_framebuffer.h)
 
 use super::{KmsDriver, ModeObject, Sealed};
-use crate::{drm::device::Device, types::*};
+use crate::{
+    drm::device::Device,
+    error::{code::EINVAL, to_result},
+    prelude::*,
+    types::*,
+};
 use bindings;
 use core::{marker::*, ptr};
 
@@ -67,4 +72,64 @@ pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_framebuffer) -> &'a
         // SAFETY: Our data layout is identical to drm_framebuffer
         unsafe { &*ptr.cast() }
     }
+
+    /// Return the raw `bindings::drm_framebuffer` for this framebuffer.
+    #[inline]
+    pub(crate) fn as_raw(&self) -> *mut bindings::drm_framebuffer {
+        self.0.get()
+    }
+
+    /// Map this framebuffer's plane-0 backing pages into the kernel address space for CPU
+    /// access, for the duration of the returned guard.
+    ///
+    /// Only framebuffers with a single, CPU-visible plane are supported (i.e. packed formats
+    /// backed by GEM-shmem/CMA memory, not multi-plane YUV or an IMPORTED dma-buf without a
+    /// CPU mapping); other cases return `EINVAL`.
+    pub fn vmap(&self) -> Result<FramebufferVmap<'_, T>> {
+        // SAFETY: `iosys_map` is POD (a pointer union plus a bool); all-zero is a valid
+        // "not mapped" value that `drm_gem_fb_vmap` overwrites for present planes.
+        let mut map: [bindings::iosys_map; 4] = unsafe { core::mem::zeroed() };
+        let mut data_map: [bindings::iosys_map; 4] = unsafe { core::mem::zeroed() };
+        // SAFETY: `self.as_raw()` is a valid, GEM-backed framebuffer for the lifetime of `self`.
+        to_result(unsafe {
+            bindings::drm_gem_fb_vmap(self.as_raw(), map.as_mut_ptr(), data_map.as_mut_ptr())
+        })?;
+        // SAFETY: `map[0]` was just filled in by `drm_gem_fb_vmap` above.
+        let vaddr = unsafe { map[0].__bindgen_anon_1.vaddr };
+        if vaddr.is_null() {
+            // SAFETY: balances the vmap just done, with the same `map`.
+            unsafe { bindings::drm_gem_fb_vunmap(self.as_raw(), map.as_mut_ptr()) };
+            return Err(EINVAL);
+        }
+        Ok(FramebufferVmap { fb: self, map, _p: PhantomData })
+    }
+}
+
+/// An RAII guard over a CPU mapping of a [`Framebuffer`]'s plane-0 backing pages, created by
+/// [`Framebuffer::vmap`].
+///
+/// The mapping is torn down when this guard is dropped, so an early return between mapping and
+/// use can never leak it.
+pub struct FramebufferVmap<'a, T: KmsDriver> {
+    fb: &'a Framebuffer<T>,
+    map: [bindings::iosys_map; 4],
+    _p: PhantomData<T>,
+}
+
+impl<'a, T: KmsDriver> FramebufferVmap<'a, T> {
+    /// Plane 0's CPU virtual base address (guaranteed non-null for the guard's lifetime).
+    #[inline]
+    pub fn as_ptr(&self) -> *const u8 {
+        // SAFETY: set non-null in `Framebuffer::vmap`; `vaddr` is the active union member.
+        (unsafe { self.map[0].__bindgen_anon_1.vaddr }) as *const u8
+    }
+}
+
+impl<'a, T: KmsDriver> Drop for FramebufferVmap<'a, T> {
+    fn drop(&mut self) {
+        // SAFETY: `self.fb.as_raw()`/`self.map` are exactly the pair passed to
+        // `drm_gem_fb_vmap` in `Framebuffer::vmap`, and the mapping has not been released
+        // since.
+        unsafe { bindings::drm_gem_fb_vunmap(self.fb.as_raw(), self.map.as_mut_ptr()) };
+    }
 }
-- 
2.55.0

