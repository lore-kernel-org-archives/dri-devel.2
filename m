Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8863C44500
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8811410E044;
	Sat,  4 Jul 2026 08:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bwaSH5S7";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3AA10E044
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:41:36 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47640541585so822513f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783154495; x=1783759295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2PKlx1RZlE0eFooFNfeW6nXm/sxrhaIM7NVbZ8hGbT4=;
 b=bwaSH5S7ScSlXWbVAi7YvVF0xLPhrct/NBRUoP+Kq2p23q2e8ur8Icw8v1Mqfr2tW0
 enwlndg2YMU1v+LXteHyz1kzT+9tXviL2Vg0wQ5BLKTwQDFFiHD5FYZGyLGtKkDBaYKS
 WKKZ8Ofu90/6HbBX1pGXLoTZCopDqef8PD2LHncdR7HUeFWbP7v1anDsYskT4dJ0TLDb
 xTs35qElmsXlST9ee4lVXLmVTmzYF4kVVZzO6W93qXQvnR2elmeX11ZYuoQIFloTURst
 Spn/lQY65CtKMRhVDM2T+OQ1fxhuTYXzgfauz/SC83ibUYjn0bDE2n6S6U/JV74VfXgz
 PpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783154495; x=1783759295;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PKlx1RZlE0eFooFNfeW6nXm/sxrhaIM7NVbZ8hGbT4=;
 b=Wdk79ucZuU7XKgIbxQAMUfzLQvSpcgy36LeDht03Rjxe5HmimZduSg7DUHDO6e3HNR
 +6nFAZ2j+lCoEGDh9lRJaO5M08l91dRBduN+j95y4wjP5Oz4hkW9DrmOUgcNVHyUaCW9
 RV0nPzcPCNVTPuSkUIwWGLmzLKPpLj29m+s2jEeyG/Ak9G2F/0DugBer9cyzWYiOYywg
 rZiPWyq/1d9zDO+73Z5V2qiE9yiqTmn1UpBcWL1+IFi60u/bV30yllyXFFbqHKO/ATA9
 6hdyOfRjonCrLf8u/QpdwtCGPRRQiUYOGVMkX6iYVYZ3EpUQahSLOIWhiByFEF+tkTHE
 BVKA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3QuWGTh4m/djgIh3M0b2GZ0+v4dQdqstX5c2g+d+QroUK/PIgYb69S/y5EkR+M1gjBnv+8K4Lh0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzCjC5ZqicLYL4H5gPbO5DyeKY/+QUdLRznrItTsBpnMAflEBV
 Dna5hQVw7nhMA8sOW/Ilo/rSOJqkgd6a0S5E96xPQvc3q8lZVqIuGIoa
X-Gm-Gg: AfdE7cl1nnXfm/C1b9ESLKLPbBH1W/K3D4Z3uK/8iIjdEWDXOoNvTz7JLcAVdKILeSJ
 WNiKGUoky02yuFJRoOCWl7bOKK5JIFcpscT0sJXn9Sg+hDDUL4y+y6joG5xaqGBLuLJ+0jC9d/f
 /71oRxLCGyrkHky7i23QpPWyI1M/yYDn6q/cVPlPoq8Msp+gLIdAn9j+GFqJcU8RFRHSMleCCDX
 Mj5pzPz9Q4CokG5iE1lxGmqjfNnZsT/Rh4pLFxAtNY2o+zRpGtBJ+/tgq8hOLbsHzm7dI/eei4T
 vOKLT4E54mZH19NAhGeDkHmes1DnoJ8tY4XUCkn/Y0nvbXqO3J/ILthcsm4qs3UJQtivZUJ2Om7
 bvMeBsTn3f9ATzHgnsBkNM8zRqWpDtvDGthwDAEvMyuKgKmdvRvkHyKFsbgtc42VGDj5CgkLPyn
 xke/P9xuSXyj7/CGCbg9RW5mEHyA==
X-Received: by 2002:a05:6000:469b:b0:46e:624e:3c2f with SMTP id
 ffacd0b85a97d-47aab77082bmr1649075f8f.47.1783154494914; 
 Sat, 04 Jul 2026 01:41:34 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15be:2e00:3669:f2aa:a674:f340])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm6519563f8f.21.2026.07.04.01.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 01:41:34 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: mikhail.v.gavrilov@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, peterz@infradead.org, jpoimboe@kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/drm_exec: avoid indirect goto
Date: Sat,  4 Jul 2026 10:41:33 +0200
Message-ID: <20260704084133.122053-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The drm_exec component uses a variable with scope limited to the for() and
an indirect goto to allow instantiating multiple macros in the same
function.

This unfortunately doesn't work well with certain compilers when the
indirect goto can't be lowered to a direct jump.

Switch the indirect goto to a direct goto, the drawback is that we now
can't use the dma_exec_until_all_locked() macro in the same function
multiple times.

The is currently only one user of this and only as a hacky workaround
which is about to be removed.

So document that the __label__ statement should be used when the macro is
used multiple times and fix the tests and the only use case where that is
necessary.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  2 ++
 drivers/gpu/drm/tests/drm_exec_test.c  | 24 ++++++++++++------
 include/drm/drm_exec.h                 | 34 ++++++++++++++------------
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fee4c94c2585..fc28d0fdad37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3011,6 +3011,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	is_compute_context = vm->is_compute_context;
 
 	if (is_compute_context) {
+		__label__ drm_exec_retry;
+
 		/* Release the root PD lock since svm_range_restore_pages
 		 * might try to take it.
 		 * TODO: rework svm_range_restore_pages so that this isn't
diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
index 2fc47f3b463b..7a374e462348 100644
--- a/drivers/gpu/drm/tests/drm_exec_test.c
+++ b/drivers/gpu/drm/tests/drm_exec_test.c
@@ -180,19 +180,27 @@ static void test_multiple_loops(struct kunit *test)
 {
 	struct drm_exec exec;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
-	drm_exec_until_all_locked(&exec)
 	{
-		break;
+		__label__ drm_exec_retry;
+
+		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+		drm_exec_until_all_locked(&exec)
+		{
+			break;
+		}
+		drm_exec_fini(&exec);
 	}
-	drm_exec_fini(&exec);
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
-	drm_exec_until_all_locked(&exec)
 	{
-		break;
+		__label__ drm_exec_retry;
+
+		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+		drm_exec_until_all_locked(&exec)
+		{
+			break;
+		}
+		drm_exec_fini(&exec);
 	}
-	drm_exec_fini(&exec);
 	KUNIT_SUCCEED(test);
 }
 
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index 8725ba92ff91..cc2937185a9f 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -101,17 +101,6 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
 	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
 
-/*
- * Helper to drm_exec_until_all_locked(). Don't use directly.
- *
- * Since labels can't be defined local to the loop's body we use a jump pointer
- * to make sure that the retry is only used from within the loop's body.
- */
-#define __drm_exec_until_all_locked(exec, _label)			 \
-_label:									 \
-	for (void *const __maybe_unused __drm_exec_retry_ptr = &&_label; \
-	     drm_exec_cleanup(exec);)
-
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked
  * @exec: drm_exec object
@@ -119,9 +108,18 @@ _label:									 \
  * Core functionality of the drm_exec object. Loops until all GEM objects are
  * locked and no more contention exists. At the beginning of the loop it is
  * guaranteed that no GEM object is locked.
+ *
+ * A global label name drm_exec_retry is used, if you need to use more than one
+ * instance of this macro in the same function the label needs to be made local
+ * to the block with the __label__ keyword.
  */
 #define drm_exec_until_all_locked(exec)					\
-	__drm_exec_until_all_locked(exec, __UNIQUE_ID(drm_exec))
+	for (bool const __maybe_unused __drm_exec_loop = false;		\
+	     drm_exec_cleanup(exec);)					\
+		if (false) {						\
+drm_exec_retry: __maybe_unused;						\
+			continue;					\
+		} else
 
 /**
  * drm_exec_retry_on_contention - restart the loop to grap all locks
@@ -129,12 +127,14 @@ _label:									 \
  *
  * Control flow helper to continue when a contention was detected and we need to
  * clean up and re-start the loop to prepare all GEM objects.
+ * The __drm_exec_loop check exists to prevent usage outside of an
+ * drm_exec_until_all_locked() loop.
  */
 #define drm_exec_retry_on_contention(exec)			\
 	do {							\
 		if (unlikely(drm_exec_is_contended(exec)))	\
-			goto *__drm_exec_retry_ptr;		\
-	} while (0)
+			goto drm_exec_retry;			\
+	} while (__drm_exec_loop)
 
 /**
  * drm_exec_is_contended - check for contention
@@ -154,12 +154,14 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
  *
  * Unconditionally retry the loop to lock all objects. For consistency,
  * the exec object needs to be newly initialized.
+ * The __drm_exec_loop check exists to prevent usage outside of an
+ * drm_exec_until_all_locked() loop.
  */
 #define drm_exec_retry(_exec)					\
 	do {							\
 		WARN_ON((_exec)->contended != DRM_EXEC_DUMMY);	\
-		goto *__drm_exec_retry_ptr;			\
-	} while (0)
+		goto drm_exec_retry;				\
+	} while (__drm_exec_loop)
 
 /**
  * drm_exec_ticket - return the ww_acquire_ctx for this exec context
-- 
2.43.0

