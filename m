Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE29C54F53
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523BA10E7E1;
	Tue, 28 Jul 2026 07:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKX7P3TW";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0385B10E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 21:14:25 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so2266253a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785186864; x=1785791664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kjy5MK4aAcCv+w38WsNjg39N/6ew3Hf2N4qUhAbHfKM=;
 b=YKX7P3TWyIdubjdkwMoOfvvcyC7mwwYMgpt/o+KWZCYxodzJ/4mCvi+srgsstbpCR8
 dpHAGf6tbewBl7KehDkJo0wgp47AGtH4aaifKgV1KL+FU4sdPeMoxOhQWVGwPBjwQLdQ
 zNWb1wB4uF2G81GV/Cjap0XSBOwtKqn8FIheyDsK+JRCDs8rx9FrKhUSsm12beuPWFpz
 yGrP1aRxbygTHcUEXG6Ie7PAuiRz8qBHp0omXq5ELZ58Cl7/ytc3Wt3id6YDzbyVTgsj
 xZTfsgMqwItXB12u8XLNJi9SZPc0RHea26kJkAm3Wa7n2DT1fEESv0+JVMdSmaYglCom
 k6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785186864; x=1785791664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kjy5MK4aAcCv+w38WsNjg39N/6ew3Hf2N4qUhAbHfKM=;
 b=U1rZNtM2U8vs2+aLImFS4lNIK9B8SCE7teXZpU9WVkto85V8LmW3aYnJmPXOUI2H43
 6qKj+Y7i+VCzfs/zx/ygUaydCZGAbhR8weIjSbph29q1E+gqblMbduCq5+T/8vLwBhKs
 AQVwSBdmZbfxjqTNf9/xnCbXlYdLDMfqk8eC1ogrgSul1tQ3kWtDmhl5yuwCgqPKmLAp
 rLMF+ecuig0HJgBowefUyVwA21HuijQnvJOGT55FsMDoD2sWOD9nW29CWb0obx+S2o+R
 Bhwny3jruWr+b769rDuWfnKx1DbCzzLF15opMWRwEbqzjtVpafSywqEFxEUf8csThFEQ
 jlow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2qIPh1MHsLf/hnvkrSXkWJfUOBKc/EeKfj/0WA+8AHndBR78I1Oz6Vtj6dpMf6WF/ufdTty1bBws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynTVjlfyM+kygpkV1jPont/5Um6tKaqehoHAVBuWOYL9fa85sd
 gJB7srnuZsaroSAD4ZaIK4BuX9CCFyhOocoFwaQcuQZ1eqeoo8Ja/sDi
X-Gm-Gg: AR+sD12LfEvFemE4HULn2wr8WBtlGaf9F6bkfWBWuPjYFYkOUIXVQ3Doy5GHjuo2oMD
 +0OcQCyLH14+AKyZK+jz2iTv1nn/Rpfw2xuYTu9bf2bAQewLYD/3nFz2SVBwvIl1SP/WdCope1l
 L/uJw4uIRA6+lyHhJTLsMniJkd1czgV/TzFVzejMhkptNgEvVysEUiTsgpM/f/rT64VO9McFucQ
 kFY82gCE5//kmFcGlT8+/mxayNkbvkrUdXx3JXQcomNSOFHsckCpsXnbi8Iq4LPMNhUyEs9gYvf
 wX5v6hz/9EG0OeX0ar5BmaEVwdS8+08MV3B47tIaSFu0xapkR5hBaxqzBAyowmW/Ltv81Y8hQ4p
 Gd9PRFnnkZjgpSSZlABG1uOvfjQg2cHFYsbaW97Z8n1VC9Dk2EuRHaerSEJUT1PHQwWfEaIWeGE
 15PcEb0SHd8c7X3VOuQZOtZiWwx5ieRqaYlWR3+PYS6bsMDQqyto+I+Q==
X-Received: by 2002:a05:6a21:9d95:b0:3c0:9c19:65c2 with SMTP id
 adf61e73a8af0-3c67e0727f2mr8884194637.74.1785186864472; 
 Mon, 27 Jul 2026 14:14:24 -0700 (PDT)
Received: from archd ([2601:640:8c00:a:1544:c19e:8a1c:4058])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e127asm58456645eec.2.2026.07.27.14.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 14:14:24 -0700 (PDT)
From: Daniel Pesic <danny.pesic@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Daniel Pesic <danny.pesic@gmail.com>
Subject: [PATCH 2/2] rust: drm: gpuvm: call
 drm_gpuvm_bo_destroy_not_in_lists() in Drop
Date: Mon, 27 Jul 2026 07:11:21 -0700
Message-ID: <20260727141121.11975-3-danny.pesic@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727141121.11975-1-danny.pesic@gmail.com>
References: <20260727141121.11975-1-danny.pesic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

GpuVmBoAlloc's type invariant guarantees a refcount of one and absence
from the gem, extobj, and evict lists for as long as the value exists as
itself. The only way to consume it is via obtain(), which moves it out
via ManuallyDrop, so the invariant holds when Drop::drop runs. Since
this is the required precondition for
drm_gpuvm_bo_destroy_not_in_lists(), call it directly rather than going
through the deferred put, and drop the TODO.

The GEM's gpuva lock must not be held when this runs, since freeing the
last reference to the GEM object would free the lock embedded in it.
Drop::drop has a fixed safe signature, so this precondition cannot be
enforced by the type system and is documented instead, matching the
existing note on GpuVmBoAlloc::obtain(). It currently holds as
lock_gpuva()'s two call sites, in sm_ops.rs, operate on a GpuVmBo that
is already obtained and never construct or drop a GpuVmBoAlloc.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Pesic <danny.pesic@gmail.com>
---
 rust/kernel/drm/gpuvm/vm_bo.rs | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
index a30f838c11b8..7c0f5846cf39 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -249,10 +249,14 @@ fn deref(&self) -> &GpuVmBo<T> {
 }
 
 impl<T: DriverGpuVm> Drop for GpuVmBoAlloc<T> {
+    /// Must not be dropped while holding the `drm_gem_object` gpuva lock.
     #[inline]
     fn drop(&mut self) {
-        // TODO: Call drm_gpuvm_bo_destroy_not_in_lists() directly.
-        // SAFETY: It's safe to perform a deferred put in any context.
-        unsafe { bindings::drm_gpuvm_bo_put_deferred(self.as_raw()) };
+        // SAFETY: By the type invariant, `drm_gpuvm_bo` has a refcount
+        // of one and is absent from the gem, extobj, and evict lists.
+        // Per the precondition documented in impl, the caller does not
+        // hold the object's gpuva lock. Therefore, the preconditions of
+        // `drm_gpuvm_bo_destroy_not_in_lists()` are satisfied.
+        unsafe { bindings::drm_gpuvm_bo_destroy_not_in_lists(self.as_raw()) };
     }
 }
-- 
2.55.0

