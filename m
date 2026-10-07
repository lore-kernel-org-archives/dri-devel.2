Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE20DCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FAE810E574;
	Wed,  7 Oct 2026 12:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GqfI5SiN";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8508110E5A2
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:47:01 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso2344392f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791377220; x=1791982020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pw9oOm89VS3pKxM7huEG/FH/rlcTt1EJ1qu86BiIZks=;
 b=GqfI5SiNHpDoYJvMOQbnRZxr3+jY6pYopJLoAP/AabJZfbxrxP3ZwbKE008Gj8ZI72
 3KgyWqsMbuspA3wjfMfsGTfJjNhWPpiphFL7JD/WBFVaaqYOYywVJNn6ZUCuv202XABl
 y+fqiVjMMh2U6pJjBCyu6rKjKdqE1uy/fWsvkFJyGA4uuHo1rczljH1BvJt+1OoDMJQj
 YN3ehsyJxHN8wJRAOxix0IPzx1m9fa74tywCQzJBr/TUoE+tU8eHD3VepSXXG11AlGIL
 vSLT+mVo119X+eJTc6ze/v4g3KufoicPDQOj7HVZG8DabAjsoCnTGAnDoH7B/jbH0/fw
 eT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791377220; x=1791982020;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pw9oOm89VS3pKxM7huEG/FH/rlcTt1EJ1qu86BiIZks=;
 b=fKubYSNNhr2xWHVofhxXdWZNQpk4urvACGjZOtj5ofX/NGvMZQu/fMagODD64q5e9k
 07Lrf0fjpLNbLlWJ66e0xKWLG4tvE7iufbZ80pETR3ioA0EFQ2ph84EIGOp0E5p5nTGt
 tNG6ALhypgiBkK7trP+2NB2tcUmzHhuRRfwad4QDNlp59n1eyHRTal6seDGgFtKbymIj
 eaIYxQp3UIcx7lYuQ+TeWGzr3fkXP3WlIS4bXkA4h5pFBkYypV3LpIt7AlrwKx6YH+TX
 7KEDUVfN7eWqpUX/b0u9ckJeG7NxTSKyC+A0r99UhYFeSDLnxP9SIk1gUdMkG0t38jiW
 xOPA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCDjGEhSiAlvAPNY5FxeZnEftRbti5SWhPJGVbKoItGiQvvaIV69sCeTcSZDwn0qXry9GIpNI5ngg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJE+yUraeU8fJ3rd1HLKv6YOjxH4KNDVjGYePmNd6iGAWQCn7vM
 0cCfPNML48otAKGqn2KfwAs0qI8BcU3c45BQI6xAhRB7le9+vPQfUZJt
X-Gm-Gg: AYBFou1Q7tDejpPWmU14NOErIwSWolcL9NkTkmrfVy1IwlNflK/Bd0ERkdTy/Y+z5Xh
 2lq8SV6gqBNXBY8+1kacGqbElAT2Dnhx6QhW3M9fkDuw6OTKQvtOeIVX6a8SCoBuegdZDMBFWzR
 BcIxeMHvxlpmFSB9JNmZ6WU5fHyiKVvDwPcXTcHHaHHfURc1pJNZ93Y+7hsuwvMmKeaw2YC0/nW
 PzBcHRFOPEIg65mQ+uiHGGT+bUKVlNifwb3PhP7NBsJi3Epp7OB7tCiB/WDaJLyMwxFndY3HVFs
 6R/nUtkGjPiPxZCgOQq+v5l2sdTL1u6QDm5dsbYxM8hmNmWB1zm2RhHUg9wKmYH4NuB5qn/F/jp
 lBBG0g/pD2a6QHZBcTjtudt+jFH65CKcNSx/f1gWSOjScjgWB0iZ3bl8iIOOcrTMndmjb75pQ/k
 lu5F5p36EpSL6jYocFiKQjKQvMT2o1E+6RF4aRhblLuX6u6A/QmydXUv5agNIanVbuFBbpL7U0n
 S2f9JV6bn0=
X-Received: by 2002:a05:6000:25c2:b0:48b:ec8:b0d8 with SMTP id
 ffacd0b85a97d-48c72896f2bmr4602766f8f.32.1791377219486; 
 Wed, 07 Oct 2026 05:46:59 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:150a:df00:dcdc:55f8:fa06:622a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d3050asm5011285f8f.50.2026.10.07.05.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 05:46:58 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/exec: don't immediately add prelocked obj to array of
 locked objs
Date: Wed,  7 Oct 2026 14:46:57 +0200
Message-ID: <20261007124657.9664-1-christian.koenig@amd.com>
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

When a contention is detected the drm_exec object grabs a reference to
the contended object, unlocks all other objects and pre-locks the
contended one before anything else.

The problem is that it is possible that this pre-locked object was about
to be destroyed and drm_exec is now holding the last reference to it.

So we never actually see this pre-locked object again to be explicitly
locked and so also never reserve a slot for a dma_fence object on it.

Should the driver now use drm_exec_for_each_locked_object() to add a new
fence to all locked objects we eventually see a warning or even a
BUG_ON() to prevent random memory corruption.

Fix this by keeping the prelocked object of the array of locked objs
until it was explicitly mentioned by the driver again.

Should the prelocked object never been mentioned again by the driver
just unlock and drop the reference at the end of the locking loop.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Fixes: 09593216bff1 ("drm: execution context for GEM buffers v7")
CC: stable@vger.kernel.org # v6.6+
---
 drivers/gpu/drm/drm_exec.c | 73 ++++++++++++++++++++++----------------
 include/drm/drm_exec.h     | 15 ++++----
 2 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 2453ec41360f4..a910b0ad17ce4 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -48,6 +48,16 @@
  * See struct dma_exec for more details.
  */
 
+/* Unlock and put the prelocked obj */
+static void drm_exec_drop_prelocked(struct drm_exec *exec)
+{
+	if (exec->prelocked) {
+		dma_resv_unlock(exec->prelocked->resv);
+		drm_gem_object_put(exec->prelocked);
+		exec->prelocked = NULL;
+	}
+}
+
 /* Unlock all objects and drop references */
 static void drm_exec_unlock_all(struct drm_exec *exec)
 {
@@ -58,8 +68,7 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
 		drm_gem_object_put(obj);
 	}
 
-	drm_gem_object_put(exec->prelocked);
-	exec->prelocked = NULL;
+	drm_exec_drop_prelocked(exec);
 }
 
 /**
@@ -118,6 +127,14 @@ EXPORT_SYMBOL(drm_exec_fini);
 bool drm_exec_cleanup(struct drm_exec *exec)
 {
 	if (likely(!exec->contended)) {
+
+		/*
+		 * The contended and prelocked object might never given to
+		 * drm_exec_lock_obj() again. This can happen when the object
+		 * is about to be cleaned up and we now hold the last reference
+		 * to it. Make sure that we don't unecessarily keep it around.
+		 */
+		drm_exec_drop_prelocked(exec);
 		ww_acquire_done(&exec->ticket);
 		return false;
 	}
@@ -175,16 +192,16 @@ static int drm_exec_lock_contended(struct drm_exec *exec)
 		dma_resv_lock_slow(obj->resv, &exec->ticket);
 	}
 
-	ret = drm_exec_obj_locked(exec, obj);
-	if (unlikely(ret))
-		goto error_unlock;
+	/*
+	 * It is perfectly possible that we see another contention before the
+	 * first one is fully handled.
+	 */
+	drm_exec_drop_prelocked(exec);
 
+	/* We move the reference from contended to prelocked here */
 	exec->prelocked = obj;
 	return 0;
 
-error_unlock:
-	dma_resv_unlock(obj->resv);
-
 error_dropref:
 	drm_gem_object_put(obj);
 	return ret;
@@ -212,35 +229,31 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
 	if (exec->prelocked == obj) {
 		drm_gem_object_put(exec->prelocked);
 		exec->prelocked = NULL;
-		return 0;
-	}
+	} else {
+		if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
+			ret = dma_resv_lock_interruptible(obj->resv,
+							  &exec->ticket);
+		else
+			ret = dma_resv_lock(obj->resv, &exec->ticket);
+
+		if (unlikely(ret == -EDEADLK)) {
+			drm_gem_object_get(obj);
+			exec->contended = obj;
+			return -EDEADLK;
+		}
 
-	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
-		ret = dma_resv_lock_interruptible(obj->resv, &exec->ticket);
-	else
-		ret = dma_resv_lock(obj->resv, &exec->ticket);
+		if (unlikely(ret == -EALREADY) &&
+		    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
+			return 0;
 
-	if (unlikely(ret == -EDEADLK)) {
-		drm_gem_object_get(obj);
-		exec->contended = obj;
-		return -EDEADLK;
+		if (unlikely(ret))
+			return ret;
 	}
 
-	if (unlikely(ret == -EALREADY) &&
-	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
-		return 0;
-
-	if (unlikely(ret))
-		return ret;
-
 	ret = drm_exec_obj_locked(exec, obj);
 	if (ret)
-		goto error_unlock;
-
-	return 0;
+		dma_resv_unlock(obj->resv);
 
-error_unlock:
-	dma_resv_unlock(obj->resv);
 	return ret;
 }
 EXPORT_SYMBOL(drm_exec_lock_obj);
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index cc2937185a9f7..c92d69a2c793d 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -73,13 +73,15 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 
 /* Helper for drm_exec_for_each_locked_object(). Internal use only. */
 #define __drm_exec_for_each_locked_object(exec, obj, __index)		\
-	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); ++__index)
+	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); \
+	     ++__index)
 /**
  * drm_exec_for_each_locked_object - iterate over all the locked objects
  * @exec: drm_exec object
  * @obj: the current GEM object
  *
- * Iterate over all the locked GEM objects inside the drm_exec object.
+ * Iterate over all the explicitly locked GEM objects inside the drm_exec
+ * container, except for the contended and implicit prelocked one.
  */
 #define drm_exec_for_each_locked_object(exec, obj)			\
 	__drm_exec_for_each_locked_object(exec, obj, __UNIQUE_ID(drm_exec))
@@ -94,12 +96,13 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
  * @exec: drm_exec object
  * @obj: the current GEM object
  *
- * Iterate over all the locked GEM objects inside the drm_exec object in
- * reverse locking order. Note that the internal index may wrap around,
- * but that will be caught by drm_exec_obj(), returning a NULL object.
+ * Iterate over all the explicitly locked GEM objects inside the drm_exec
+ * container in reverse locking order. Note that the internal index may wrap
+ * around, but that will be caught by drm_exec_obj(), returning a NULL object.
  */
 #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
-	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
+	__drm_exec_for_each_locked_object_reverse(exec, obj,		\
+						  __UNIQUE_ID(drm_exec))
 
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked
-- 
2.43.0

