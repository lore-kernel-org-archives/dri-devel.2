Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A58BC54F4D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D681A10E7E7;
	Tue, 28 Jul 2026 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ggcpjy9Z";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0922010E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 21:14:22 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8485b358552so3336830b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785186861; x=1785791661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aTwGwys18fLpJ9xlKbE47qZQ9XXoD+aeMygdr9DdQKQ=;
 b=Ggcpjy9ZvcculEEgap9pdpXYklvMio4yfviX7IKQqZlF8h3BoiyZ1lGvCGFGFEqpbC
 XJPHr9qIdwNnTrCgdBXqeBdsjy/4WkcPRaQFcu0E3A8ZeVzNd7rd/xZsO2b8LkI7vdC2
 HPjT2z85QLcSlopPyv/OHB9uOGY3+PMKghnQTGowrrjtM2bjRWUN68ju/4VcWp4eH8Uw
 APUQb52JfoXn5JNPmRJhQ3dOwu3gM5taFI9SZy8IQXz4+e204b4M64fnTzSoxLrazyuG
 vi1xz4N6WYL9Ug+Y7uxXXxC6QG6AchdRzdPzTPLE9hWM4TNuuwsUnl1/D80P7mlRKoON
 i2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785186861; x=1785791661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aTwGwys18fLpJ9xlKbE47qZQ9XXoD+aeMygdr9DdQKQ=;
 b=iCMIiX2oISfIoVPFZL5KlSsmXQZdcInzJ7Pn00uluP8KM7ugBOPvE2cF91RIrxJSRD
 LLJYkpZIhz7VJqdypj8poCymbh1U2Z5Bne2PPMyxp/L43eUSdZbLNxkWMlmD2tDakGHh
 DyoiX2toNJ2fVSn0JXnaq2K59Cl7ORXuVj655eMqEMgCIxQYp/nOtNyiIAkP4Rjh5vPU
 c/NSUSinYR/9mo8M2DOfc+SaJYTO29TXrLz3jeT8OGNzdPH2KWqgrMYeLIF6DOtzgRmm
 xTFsNhl30gSnw1+b3JlFI3lamWEfWKZYdfxjXc5bHl5VkqLHNZVxcxGhnUR1C4fs7cQE
 9Fvw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuzZuylcLN+pu8g05yDOcBY+yqzgXosiCeEYehco+zpp98JUIPDFxBAUzjlBoLRvSkZOMeWiXoq5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWhB+GbloO7A0EEpH1RoFFO8FAw9E6uZx2xnqIaDbQC1N6mkbF
 oCm7UWrrqLJ1dNljyPbwxYx7tx7dBm8uaiUr3ajlfeY5aBg96WXRR5uj
X-Gm-Gg: AR+sD12k965lrn99thfq2hjKTP/a108fbWJ5ERBRWUmizmIqvJ+I5jB8KmBKUN80THV
 FM2gSwyCgrwcraJ6akuYN2JMn40tyta7QA/kkwq4HRinPOMCb7keil3b1MRMBGGEY+lK06ds3lv
 JXDCikHbiRrmeAmXBKUDNtdLxobi8Cmt9+Emo8HWDVkf1oMGnTuA3c14uKlPTfwsx/JBFBvgZ86
 fJuyB3zsM73cGYOx5rB3k8HS0NISx6PDHwHCpsmSQjsQ72Fdh/gQiulbIr8fTuv47Nk3U2vlbmF
 QT9aav8Jr1UnIzEv8aybEpJMf7qhbZS/tdpAafOoaooFe2SHL7pD2tJxUVt/StQpVAcTGM2kvpD
 Q8sih57pA2Ne72FgdRrVNRysw3yVJuKBjEIp3LYKbNRmHKBcGjVo/LfYNSTJH3qZz3YXeKNw=
X-Received: by 2002:a05:6a21:70c8:b0:3c3:a1e6:a624 with SMTP id
 adf61e73a8af0-3c6c7b921edmr1333695637.29.1785186861417; 
 Mon, 27 Jul 2026 14:14:21 -0700 (PDT)
Received: from archd ([2601:640:8c00:a:1544:c19e:8a1c:4058])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e127asm58456645eec.2.2026.07.27.14.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 14:14:21 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/gpuvm: export drm_gpuvm_bo_destroy_not_in_lists()
Date: Mon, 27 Jul 2026 07:11:20 -0700
Message-ID: <20260727141121.11975-2-danny.pesic@gmail.com>
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

drm_gpuvm_bo_obtain_prealloc() currently calls this function directly to
destroy a losing preallocated drm_gpuvm_bo. Export it and promote its
comment to kernel-doc so the upcoming Rust GpuVmBoAlloc binding can call
it the same way.

Signed-off-by: Daniel Pesic <danny.pesic@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 5 +++--
 include/drm/drm_gpuvm.h     | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d1c80ad3dead..30c134455547 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1608,7 +1608,7 @@ drm_gpuvm_bo_create(struct drm_gpuvm *gpuvm,
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_bo_create);
 
-/*
+/**
  * drm_gpuvm_bo_destroy_not_in_lists() - final part of drm_gpuvm_bo cleanup
  * @vm_bo: the &drm_gpuvm_bo to destroy
  *
@@ -1619,7 +1619,7 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_bo_create);
  * object if the refcount reaches zero. It's illegal for this to happen if the
  * caller holds the GEMs gpuva mutex because it would free the mutex.
  */
-static void
+void
 drm_gpuvm_bo_destroy_not_in_lists(struct drm_gpuvm_bo *vm_bo)
 {
 	struct drm_gpuvm *gpuvm = vm_bo->vm;
@@ -1634,6 +1634,7 @@ drm_gpuvm_bo_destroy_not_in_lists(struct drm_gpuvm_bo *vm_bo)
 	drm_gpuvm_put(gpuvm);
 	drm_gem_object_put(obj);
 }
+EXPORT_SYMBOL_GPL(drm_gpuvm_bo_destroy_not_in_lists);
 
 static void
 drm_gpuvm_bo_destroy_not_in_lists_kref(struct kref *kref)
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 38221d83285b..d014a389405c 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -760,6 +760,8 @@ bool drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo);
 bool drm_gpuvm_bo_put_deferred(struct drm_gpuvm_bo *vm_bo);
 void drm_gpuvm_bo_deferred_cleanup(struct drm_gpuvm *gpuvm);
 
+void drm_gpuvm_bo_destroy_not_in_lists(struct drm_gpuvm_bo *vm_bo);
+
 struct drm_gpuvm_bo *
 drm_gpuvm_bo_find(struct drm_gpuvm *gpuvm,
 		  struct drm_gem_object *obj);
-- 
2.55.0

