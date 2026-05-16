Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14970CD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1169B10E36E;
	Sat, 16 May 2026 11:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kQjBxazS";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1540A10E4A4
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:55 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso5345195e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929614; x=1779534414; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6GkkTkJJ4gPDTN90NOOy2Oe9JOnAG88gTd5YGKnZHEk=;
 b=kQjBxazSvOuUEc0I15BCUVSMUtp9ZY6UPN43prpvpcnhxT8Imw1k/HGCB9fMFtg723
 XqdPBw++XN4cxhC5N1OqIi69OPfBOly298tmGajZjQLu7YS6hU0uXJQQVdS34ON4lOdM
 SidijE9MFrftBzPDe7AYgs/+JoFI6UMfFddgIXp+slgvjz5oDdtpQsqkqIHyTlnzhs7C
 MOYRRH19gt2YZbVWNe3bHoeKftfUUB4+gQtPxLAbMJw98I+5/AVEhM/B05jj2siOAtyR
 oIWAvSm5hpfCgyCAal87oz6v656ryUosMNC67grVDxKr6AMCLh8cF56kAAZce22DsMLO
 6I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929614; x=1779534414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6GkkTkJJ4gPDTN90NOOy2Oe9JOnAG88gTd5YGKnZHEk=;
 b=aRVmdMjmVvfFzfAd1P4AewK/aBonmMcld0IUlBFFbO6MABuyeSszyDs6QSL33l/Ldj
 gH2RL85fwDPHc0BFWKnNYDqIyuVewNdx+F1HTQNg3W5JWyQegqPFcs61lP76ExIKjbmH
 KWr76BgEcnkdf2dTsLLd6uDh4bbGzv4IOq05qSJ0WQQfOd72Dw/elpMuOcP1DDA2mdZX
 kk25z3YUh37PO4Gcu6OlRzk+FH/8OR5SA5f+/isRq1WIwpAIVaTXRN6qImhezp0mj4nQ
 yhUsravOHGFeIwFfSbxe/EqWoI+yoG1nqGhayVda9zzaZfzQQHp0B1meWHGI020737yA
 iPiw==
X-Gm-Message-State: AOJu0Yyh8s+MDDf/YFcH/sJddKPRIS/pWAdXMIPtZTxu+Y3Z5u4HEZsr
 8mZysih8YQqhO599Xjc2qXIsP4Mk0rg897XWIEc7ZDynkRnnLoEmNyCI
X-Gm-Gg: Acq92OEgpTF1xtOgKOkyEu8uxzg6JSNB1xDdfkHnSr6gymG3uqh0BJaX62tUbE+MN+8
 5v+IsQv7weQVuvhoCDAUqyjG4FByk6LRpDDxGbZt9+VKuqasx0V6g6/OwhVPLlQ+5lOGYcyKE7N
 e6H6wSvKkhGD55ysG7uu3roBQ74smPPrVj/6yYUED+nWr17jCCMXaPQezzb/eSSuH82CaxZ1mqZ
 z/HuScofK6lLAfpwRas8M8UWRkS6GLosgwRV/0b8z7LBGlft5tK21vMTPRZ7gxiGw5VGoTtthvH
 aWha2h24BGOQCBT1V1JKmVweU6M+qEAy+8nnzT2MTIMo0/2Xj8lQrmXYLhJQZqJ/5fnvnaqXmUp
 YU27Z6ZfyC7Hn1YpTrAsDD3Z8o+c1pn+McSW3TxxwpSsEeIIrTDCeme4C4dLpBQKbzR8GL+aRr8
 MlyEOpPAVRBlSrZa5t23yampG6wO4kuRXAqWETKhujxuiL8/rBk1EW45O28vBMJJXVeE2t+eLJn
 vsi0YDAO8KK7jF9ow==
X-Received: by 2002:a05:600c:8b18:b0:48f:e230:1d13 with SMTP id
 5b1f17b1804b1-48fe632a17cmr113820945e9.32.1778929613501; 
 Sat, 16 May 2026 04:06:53 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:53 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:10 +0200
Subject: [PATCH 07/12] drm/syncobj: add drm_syncobj_timeline_signal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-7-88ede9d98a81@gmail.com>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
In-Reply-To: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 ju.orth@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=4123;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=GBWZLpTSQKwI1OU9IPw5ePXafftNdAo847uKMqv9qQs=;
 b=0gZo9A/tA5EbfMN54peF660OcWHUpqWJdekS7fQjA+fGOVO86M7bIbAQu7ODFDJVVH0bdcsvX
 oBVYQt/E6R0BsJf+sfH3PTEAIAKrD2RH29Jg6VWUMm3yc+y9LG9cMif
X-Developer-Key: i=ju.orth@gmail.com; a=ed25519;
 pk=uM2SS4lelkuIoYHc7v9N9bgBZ3hS632zJS2xjRJLPLI=
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

This makes the logic from drm_syncobj_timeline_signal_ioctl available to
callers that already have an array of drm_syncobj.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 50 ++++++++++++++++++++++++++++++++-----------
 include/drm/drm_syncobj.h     |  2 ++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 8ccfbd972191..948084f56c32 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1675,9 +1675,6 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_syncobj_timeline_array *args = data;
 	struct drm_syncobj **syncobjs;
-	struct dma_fence_chain **chains;
-	uint64_t *points;
-	uint32_t i, j;
 	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
@@ -1696,26 +1693,55 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 	if (ret < 0)
 		return ret;
 
-	points = kmalloc_array(args->count_handles, sizeof(*points),
+	ret = drm_syncobj_timeline_signal(syncobjs, args->points, args->count_handles);
+
+	drm_syncobj_array_free(syncobjs, args->count_handles);
+
+	return ret;
+}
+
+/**
+ * drm_syncobj_timeline_signal - signal timeline points on syncobjs
+ * @syncobjs: array of syncobjs
+ * @user_points: user pointer to array of timeline points
+ * @count: number of syncobjs
+ *
+ * Signals each syncobj at the corresponding timeline point.
+ *
+ * Returns 0 on success or a negative error value on failure.
+ */
+int
+drm_syncobj_timeline_signal(struct drm_syncobj **syncobjs,
+			    u64 user_points, u32 count)
+{
+	struct dma_fence_chain **chains;
+	uint64_t *points;
+	uint32_t i, j;
+	int ret = 0;
+
+	if (count == 0)
+		return -EINVAL;
+
+	points = kmalloc_array(count, sizeof(*points),
 			       GFP_KERNEL);
 	if (!points) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (!u64_to_user_ptr(args->points)) {
-		memset(points, 0, args->count_handles * sizeof(uint64_t));
-	} else if (copy_from_user(points, u64_to_user_ptr(args->points),
-				  sizeof(uint64_t) * args->count_handles)) {
+	if (!u64_to_user_ptr(user_points)) {
+		memset(points, 0, count * sizeof(uint64_t));
+	} else if (copy_from_user(points, u64_to_user_ptr(user_points),
+				  sizeof(uint64_t) * count)) {
 		ret = -EFAULT;
 		goto err_points;
 	}
 
-	chains = kmalloc_array(args->count_handles, sizeof(void *), GFP_KERNEL);
+	chains = kmalloc_array(count, sizeof(void *), GFP_KERNEL);
 	if (!chains) {
 		ret = -ENOMEM;
 		goto err_points;
 	}
-	for (i = 0; i < args->count_handles; i++) {
+	for (i = 0; i < count; i++) {
 		chains[i] = dma_fence_chain_alloc();
 		if (!chains[i]) {
 			for (j = 0; j < i; j++)
@@ -1725,7 +1751,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	for (i = 0; i < args->count_handles; i++) {
+	for (i = 0; i < count; i++) {
 		struct dma_fence *fence = dma_fence_get_stub();
 
 		drm_syncobj_add_point(syncobjs[i], chains[i],
@@ -1737,10 +1763,10 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 err_points:
 	kfree(points);
 out:
-	drm_syncobj_array_free(syncobjs, args->count_handles);
 
 	return ret;
 }
+EXPORT_SYMBOL(drm_syncobj_timeline_signal);
 
 int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_private)
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index ec8042d61466..a9216ea07946 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -139,6 +139,8 @@ int drm_syncobj_register_eventfd(struct drm_syncobj *syncobj,
 int drm_syncobj_transfer(struct drm_syncobj *src, u64 src_point,
 			 struct drm_syncobj *dst, u64 dst_point,
 			 u32 flags);
+int drm_syncobj_timeline_signal(struct drm_syncobj **syncobjs,
+				u64 user_points, u32 count);
 void drm_syncobj_free(struct kref *kref);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);

-- 
2.54.0

