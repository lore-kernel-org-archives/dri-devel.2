Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BD9C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C5810F956;
	Fri, 10 Jul 2026 19:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mbakxcOC";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD7810F939
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:06 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso5492885e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710485; x=1784315285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yBVaMK4L9gyjT+EoEO4978A5AdaqzcXPIfWDlt2pVck=;
 b=mbakxcOCk7i2neame4DhEP3io9L9dO0btd1e8r1DoUds3+rsUqWopP5TanobREO250
 m2N7mngPAFoXJTDtFVdRRwEkrtjpY3cSg/GmqMeUYkH42t4Topf3JKlYTa1DA5AlAh6B
 iAy1aCKwNz2nGPMAibkHDjapsfMyvg/NGS8SLUG5tN9jFWIBArJUgLQyBA/XLTiuMRir
 pm8un0V4ae+EhSKKnANVqiG7h8aNXW4iHmphiurG6rVhwUocgHr9AveudRx9k2Xg2xEQ
 kB799CEmW1viN+M9lGTtHOz5IGm1PqVWY26P33Cqz4F/7YNattuhN7nfmw+MfOyGm3pq
 L6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710485; x=1784315285;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yBVaMK4L9gyjT+EoEO4978A5AdaqzcXPIfWDlt2pVck=;
 b=O1UgtD838hXY/gm+M0YrOFr8flPc0G9ZiwkTn80JpMR4gUccl4VVpT6jQ3x7DXTBWV
 a8XkENrUtei+8vZuS3b7nvGKu8f70tgvAsHBaOTAOAl3IAoGhG5vyCQtnlPQJvUkukjz
 +D8gSvZzl1xdUsrRqhn3KksoEaDrYvgp7Oy1CfncqUEXL6znMMVSpCpcdaduv+Omgh9U
 oGox5daax3O60st3R27pqqCYtFKuOJKG7PJVtbW62AclF94KmKHyv9ShxahRbsNJDBG4
 l+9ApQnwmdaEwU2iCrPd77okPGX/pw6BJgRnwmlcS9In1qF8SmthR1TPlm3RKJmwkkUJ
 BV/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmTc6hM0o/12roPppRWNzmI/lJSVLVovC1ogvBdnjRIJp2kcxX+SGtNNYMTf5SskqpxZDgjMn/lF4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6ESKk6usD9aTBMuSlVtroMPqSXVzNyVqhP7jUv5Pxxmg5ejfW
 pwIPHX6DGhIuX0h/bHyNi2z54dFgZgDzZ0VCEvPcr+KDM5ZHc6SUme8J
X-Gm-Gg: AfdE7clYKgmKBq8h8w/n5UgSwFZJ3s3UWDM8bErl68veyQVKJqwcYOdzoJ2GHpDGGGS
 /ostdiZjBy5TplYlOBbaFWSQ7FBBpfuH+QoAU1xIyFNB3NHV/nphcHBlj22uvfQLb5cNAiF8eD+
 0dO86RUC2NqPCXovT0iLsrrbUOGkqiIIpFK6GEvC8SaBn0W8nFggf2fo56z5WcqFweRG9hrqbre
 MOwy2PqoJBUDBJZbEF7dWinGadWQHLQmCCi0GPodMlY9wBbHlwneLlXC0BKBnpIVssgjrXW50HQ
 eoBiDoSQ4NfSvEeNpeg23/1CNdbQLScsKLBQbWUJoBJWvLuYOae+K+N5QCHAz3uzlCStbwhkNNj
 HV77JL0fJcZHUJFZ+v4C1dd2G0rhhuOar4pOwNB1VQIBrKLAf3UnZEuiYmE2ba33E/DqRd3xjs2
 G3iKWwHjrwDJ7e1vGaPQt/E9s1uBF1GhcE8Kop
X-Received: by 2002:a05:600c:564b:b0:493:e79e:da98 with SMTP id
 5b1f17b1804b1-493f8837fdbmr510375e9.39.1783710484544; 
 Fri, 10 Jul 2026 12:08:04 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:08:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/12] drm/exec: add drm_exec_lock_resv function
Date: Fri, 10 Jul 2026 20:52:50 +0200
Message-ID: <20260710190752.2355-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
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

Restructure the drm_exec object to work with dma_resv references instead
of GEM object references.

Add the new function dma_exec_lock_resv() to lock individual dma_resv
objects and so allow higher level implementations to handle contention
purely on dma_resv objects.

WIP! Don't commit like that!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_exec.c | 75 ++++++++++++++++++++++----------------
 drivers/gpu/drm/drm_gem.c  |  2 +
 include/drm/drm_exec.h     |  9 +++--
 3 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index fa923852fae45..382bf7bcd5ff3 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -58,8 +58,11 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
 		drm_gem_object_put(obj);
 	}
 
-	drm_gem_object_put(exec->prelocked);
-	exec->prelocked = NULL;
+	if (exec->prelocked) {
+		dma_resv_unlock(exec->prelocked);
+		dma_resv_put(exec->prelocked);
+		exec->prelocked = NULL;
+	}
 }
 
 /**
@@ -101,7 +104,7 @@ void drm_exec_fini(struct drm_exec *exec)
 	drm_exec_unlock_all(exec);
 	kvfree(exec->objects);
 	if (exec->contended != DRM_EXEC_DUMMY) {
-		drm_gem_object_put(exec->contended);
+		dma_resv_put(exec->contended);
 		ww_acquire_fini(&exec->ticket);
 	}
 }
@@ -158,50 +161,41 @@ static int drm_exec_obj_locked(struct drm_exec *exec,
 /* Make sure the contended object is locked first */
 static int drm_exec_lock_contended(struct drm_exec *exec)
 {
-	struct drm_gem_object *obj = exec->contended;
+	struct dma_resv *resv = exec->contended;
 	int ret;
 
-	if (likely(!obj))
+	if (likely(!resv))
 		return 0;
 
 	/* Always cleanup the contention so that error handling can kick in */
 	exec->contended = NULL;
 	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT) {
-		ret = dma_resv_lock_slow_interruptible(obj->resv,
-						       &exec->ticket);
+		ret = dma_resv_lock_slow_interruptible(resv, &exec->ticket);
 		if (unlikely(ret))
 			goto error_dropref;
 	} else {
-		dma_resv_lock_slow(obj->resv, &exec->ticket);
+		dma_resv_lock_slow(resv, &exec->ticket);
 	}
 
-	ret = drm_exec_obj_locked(exec, obj);
-	if (unlikely(ret))
-		goto error_unlock;
-
-	exec->prelocked = obj;
+	exec->prelocked = resv;
 	return 0;
 
-error_unlock:
-	dma_resv_unlock(obj->resv);
-
 error_dropref:
-	drm_gem_object_put(obj);
+	dma_resv_put(resv);
 	return ret;
 }
 
 /**
- * drm_exec_lock_obj - lock a GEM object for use
+ * drm_exec_lock_resv - lock a dma_resv object
  * @exec: the drm_exec object with the state
- * @obj: the GEM object to lock
+ * @resv: the dma_resv object to lock
  *
- * Lock a GEM object for use and grab a reference to it.
+ * Lock a dma_resv object for use or grab a reference to it on contention.
  *
  * Returns: -EDEADLK if a contention is detected, -EALREADY when object is
- * already locked (can be suppressed by setting the DRM_EXEC_IGNORE_DUPLICATES
- * flag), -ENOMEM when memory allocation failed and zero for success.
+ * already locked, -ENOMEM when memory allocation failed and zero for success.
  */
-int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
+int drm_exec_lock_resv(struct drm_exec *exec, struct dma_resv *resv)
 {
 	int ret;
 
@@ -209,22 +203,39 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
 	if (unlikely(ret))
 		return ret;
 
-	if (exec->prelocked == obj) {
-		drm_gem_object_put(exec->prelocked);
+	if (exec->prelocked == resv) {
+		dma_resv_put(exec->prelocked);
 		exec->prelocked = NULL;
 		return 0;
 	}
 
 	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
-		ret = dma_resv_lock_interruptible(obj->resv, &exec->ticket);
+		ret = dma_resv_lock_interruptible(resv, &exec->ticket);
 	else
-		ret = dma_resv_lock(obj->resv, &exec->ticket);
+		ret = dma_resv_lock(resv, &exec->ticket);
 
-	if (unlikely(ret == -EDEADLK)) {
-		drm_gem_object_get(obj);
-		exec->contended = obj;
-		return -EDEADLK;
-	}
+	if (unlikely(ret == -EDEADLK))
+		exec->contended = dma_resv_get(resv);
+	return ret;
+}
+EXPORT_SYMBOL(drm_exec_lock_resv);
+
+/**
+ * drm_exec_lock_obj - lock a GEM object for use
+ * @exec: the drm_exec object with the state
+ * @obj: the GEM object to lock
+ *
+ * Lock a GEM object for use and grab a reference to it.
+ *
+ * Returns: -EDEADLK if a contention is detected, -EALREADY when object is
+ * already locked (can be suppressed by setting the DRM_EXEC_IGNORE_DUPLICATES
+ * flag), -ENOMEM when memory allocation failed and zero for success.
+ */
+int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
+{
+	int ret;
+
+	ret = drm_exec_lock_resv(exec, obj->resv);
 
 	if (unlikely(ret == -EALREADY) &&
 	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index bbcbd25f014f0..f5cf9ad596a67 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -229,6 +229,8 @@ void drm_gem_private_object_init(struct drm_device *dev,
 	obj->size = size;
 	mutex_init(&obj->gpuva.lock);
 	dma_resv_init(&obj->_resv);
+
+	/* TODO: This needs to go away for drm_exec to work correctly!!! */
 	if (!obj->resv)
 		obj->resv = dma_resv_get(&obj->_resv);
 
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index 8725ba92ff916..9daedb676d7b1 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -47,14 +47,14 @@ struct drm_exec {
 	struct drm_gem_object	**objects;
 
 	/**
-	 * @contended: contended GEM object we backed off for
+	 * @contended: contended dma_resv object we backed off for
 	 */
-	struct drm_gem_object	*contended;
+	struct dma_resv		*contended;
 
 	/**
-	 * @prelocked: already locked GEM object due to contention
+	 * @prelocked: already locked dma_resv object due to contention
 	 */
-	struct drm_gem_object *prelocked;
+	struct dma_resv		*prelocked;
 };
 
 /**
@@ -175,6 +175,7 @@ static inline struct ww_acquire_ctx *drm_exec_ticket(struct drm_exec *exec)
 void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr);
 void drm_exec_fini(struct drm_exec *exec);
 bool drm_exec_cleanup(struct drm_exec *exec);
+int drm_exec_lock_resv(struct drm_exec *exec, struct dma_resv *resv);
 int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj);
 void drm_exec_unlock_obj(struct drm_exec *exec, struct drm_gem_object *obj);
 int drm_exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
-- 
2.43.0

