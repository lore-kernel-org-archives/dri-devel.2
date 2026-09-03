Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F57C79F80
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF2010F61C;
	Thu,  3 Sep 2026 13:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKB1rV0a";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4AE10F621
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:26 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-484374f54d0so1485801f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443064; x=1789047864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZDZwxrcvycJHj1eGUeoFp0vnof78SH0cq5rrlezlWVM=;
 b=BKB1rV0a7yl55cpVCgViSJEsZkUw65ckvP2BOcULB5Rxx82jNR7sxXMnmunyMeM66w
 wXX8ErM+6EVJFAaJ+wC1Iohv6aJX10u2quQdupMyuaWM4X4hlxeeSize3r4tqAaDG73e
 6vOmXyH/mXCT9oALgNXFDwAgyt+qzsgq4Ilz5AsJJUhJ7dki8VqO0SnK6xNr1m9VAyih
 9sswggTqe6lGZ7jOtWwQEovoDXLTBTJJiJc4OACLqcsHMCplZw2WRPJaToBgYZlYz4Ya
 QvRw2On1q2DYl1quqMjg5+tNkLSnR+E/ZvK9Atf64EkonU13MgZQkCPX0dX2cLiMY1OI
 iSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443064; x=1789047864;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZDZwxrcvycJHj1eGUeoFp0vnof78SH0cq5rrlezlWVM=;
 b=Eve4FavsCWWaDVnm7i0Fybe+HojNzQQq1RCTpwAcHAH5rXgvpPB2QHcTRv0grDj0xm
 9b+70rbw8Vxs4LZND2qPm9J903TVcC61V5kRcp91iPDX4N4chng0ZpEYC3xftwP/TCBG
 WHka59Kcix6QxonV8Z/jD/nF3KkutW9QhB5dwIPMT0sDSlRlq7U6A1lu6ziBteURzHI5
 gkUf8Qkvot+r24OWhFnhqVKbzufDvIBnHiVSMKQEcmDDQNAlwoHGcocTP3n5VFgjWzf/
 UhVlMDRv0lFlgjoHnAgWvS253ax7fMWxA2lRqBr+LmQB3iv2ZDZZXOs8N6uS4VlCSBqf
 Tyjw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKZzBdYAxxpjJPluriwSmlIVtoacfNSMqNqAP3NCGURtaeRbAPki7RiLdjBnjN0rXXFOz+QG10N9w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mdVEiKNchWvOI9VbJaU6PRYnyr3x5IXldjb20vGFIO+DJHI+Rh
 CqFewJRoB7+LRY0QqgPyb33/z7eozx1YOpYvLrhcYKRALJIOvFjilRUo
X-Gm-Gg: AYBFou1AN1xsbTry9ii4z23WWhC8zgzlVBOavyxR2KcVXYx+LD7qbS39RJKy6gy2wcO
 b/RcWRlRBc+uQpd0GXnOSHGJgZxVvnKwyaHhX+5DDS+2zfoc0QyGGj8gGOrDEmkbcE4B8I5UHWJ
 gq5liJsBJ57d5t3+xtfKhRS02/PRFXgYRVPyaNn1A5HTpHLStzA/CdB/znj7EkR/6ZVen1144AY
 oHmjp/nXEVFvi7dh5NHIyaaFV8DMpJgKm7VB7GpZjaeCQpbrDY2JgxUot+CmcAJ/suG4lVBXsYb
 Cbq3UG1Y84KuLME2E3KlaBzP5OyyKRSautPiQuFQ3EXJDsFTQLlZmuTv8fNrqroo5lw/9hA6Fk9
 /11pnmJNVyE0fOcQ+/vvX1xaow1iRurSNOj0qWXU4sXsS7HgSuCJpcC2PUDbNOKnNUdMDcNIKJK
 xxU3nH37GlwFG1zTGCO37xHPMnHfn2Y2sRquN+MnL5e+RPI9Asziw12t6y8oDspktUakapzVfHZ
 g==
X-Received: by 2002:a05:6000:4548:b0:485:8542:fee3 with SMTP id
 ffacd0b85a97d-4858542fffdmr2777779f8f.16.1788443064234; 
 Thu, 03 Sep 2026 06:44:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] dma-buf: Inline dma_resv_init and remove allocated flag
Date: Thu,  3 Sep 2026 15:28:06 +0200
Message-ID: <20260903134408.105317-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
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

Now that all users have migrated to dma_resv_alloc(), inline the
initialization code directly into dma_resv_alloc() and remove the
dma_resv_init() function entirely.

Additionally, remove the 'allocated' flag from struct dma_resv since
all dma_resv objects are now dynamically allocated. This simplifies
the reference counting logic - dma_resv_release() now always frees
the object unconditionally.

The last remaining use of dma_resv_init() in dma_resv_lockdep() has
been converted to use dma_resv_alloc() instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/dma-buf/dma-resv.c | 43 +++++++++++++++-----------------------
 include/linux/dma-resv.h   | 10 ---------
 2 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 5ae5a4b40ae6..4a421b08cd98 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -132,26 +132,13 @@ static void dma_resv_list_free(struct dma_resv_list *list)
 	kfree_rcu(list, rcu);
 }
 
-/**
- * dma_resv_init - initialize a reservation object
- * @obj: the reservation object
- */
-void dma_resv_init(struct dma_resv *obj)
-{
-	kref_init(&obj->refcount);
-	obj->allocated = false;
-	ww_mutex_init(&obj->lock, &reservation_ww_class);
-
-	RCU_INIT_POINTER(obj->fences, NULL);
-}
-EXPORT_SYMBOL(dma_resv_init);
-
 /*
  * dma_resv_release - release function for kref
  * @kref: the kref inside the dma_resv object
  *
  * This is called when the last reference to a dma_resv object is released.
- * Cleans up the object and frees it if it was allocated by dma_resv_alloc().
+ * All dma_resv objects are now dynamically allocated, so this always frees
+ * the object after cleanup.
  */
 static void dma_resv_release(struct kref *kref)
 {
@@ -163,10 +150,7 @@ static void dma_resv_release(struct kref *kref)
 	 */
 	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
 	ww_mutex_destroy(&obj->lock);
-
-	/* TODO: Only as temporary workaround till dma_fence_init() is removed */
-	if (obj->allocated)
-		kfree(obj);
+	kfree(obj);
 }
 
 /**
@@ -187,8 +171,9 @@ struct dma_resv *dma_resv_alloc(void)
 	if (!obj)
 		return NULL;
 
-	dma_resv_init(obj);
-	obj->allocated = true;
+	kref_init(&obj->refcount);
+	ww_mutex_init(&obj->lock, &reservation_ww_class);
+	RCU_INIT_POINTER(obj->fences, NULL);
 
 	return obj;
 }
@@ -844,23 +829,28 @@ static int __init dma_resv_lockdep(void)
 {
 	struct mm_struct *mm = mm_alloc();
 	struct ww_acquire_ctx ctx;
-	struct dma_resv obj;
+	struct dma_resv *obj;
 	struct address_space mapping;
 	int ret;
 
 	if (!mm)
 		return -ENOMEM;
 
-	dma_resv_init(&obj);
+	obj = dma_resv_alloc();
+	if (!obj) {
+		mmput(mm);
+		return -ENOMEM;
+	}
+
 	address_space_init_once(&mapping);
 
 	mmap_read_lock(mm);
 	ww_acquire_init(&ctx, &reservation_ww_class);
-	ret = dma_resv_lock(&obj, &ctx);
+	ret = dma_resv_lock(obj, &ctx);
 	if (ret) {
 		/* Only EDEADLK from the error injection is possible here */
 		WARN_ON(ret != -EDEADLK);
-		dma_resv_lock_slow(&obj, &ctx);
+		dma_resv_lock_slow(obj, &ctx);
 	}
 	fs_reclaim_acquire(GFP_KERNEL);
 	/* for unmap_mapping_range on trylocked buffer objects in shrinkers */
@@ -874,10 +864,11 @@ static int __init dma_resv_lockdep(void)
 	__dma_fence_might_wait();
 #endif
 	fs_reclaim_release(GFP_KERNEL);
-	ww_mutex_unlock(&obj.lock);
+	ww_mutex_unlock(&obj->lock);
 	ww_acquire_fini(&ctx);
 	mmap_read_unlock(mm);
 
+	dma_resv_put(obj);
 	mmput(mm);
 
 	return 0;
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index 4d12519df34e..cf689d3d4ba6 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -162,15 +162,6 @@ struct dma_resv {
 	 */
 	struct kref refcount;
 
-	/**
-	 * @allocated:
-	 *
-	 * True if this object was allocated by dma_resv_alloc(), false if
-	 * embedded in another structure. Used to determine whether to free
-	 * the object memory in the release function.
-	 */
-	bool allocated;
-
 	/**
 	 * @lock:
 	 *
@@ -482,7 +473,6 @@ static inline void dma_resv_unlock(struct dma_resv *obj)
 	ww_mutex_unlock(&obj->lock);
 }
 
-void dma_resv_init(struct dma_resv *obj);
 struct dma_resv *dma_resv_alloc(void);
 struct dma_resv *dma_resv_get(struct dma_resv *obj);
 void dma_resv_put(struct dma_resv *obj);
-- 
2.43.0

