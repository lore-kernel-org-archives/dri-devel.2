Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED524606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=nT1gdq3V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508FC1122D3;
	Thu, 26 Nov 2026 11:12:14 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74F11122D3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=E17XSV7FNhTHZSsxH0WE8mUdS6h3VG6kiDkreOpsqMw=; t=1795691494; x=2111051494; 
 b=nT1gdq3VEFJFcxItHP9o3/S85MtGo32gh+CKhvnQ2IlpUXMYYhK6eSxny/xWkXhKfNcPdzqpxl3
 sbW+pGEqK/9WUUnzQKvUI8YExhB+1+olRlrJXhjXEE8BXphV9DElFYf6PhW7pd+JC2SQNo0WMYfCE
 EtJnGTRg+8rsW0DpkyV8uneZDZ9N2HsfAGoCfsGylT7tEUBIBegfDc6FSkbESM7ika/KiHRsLS3La
 H6qLBsW9irEp4qqo3VUXLRWHGOH8hIktlmb1fx3KMQlynp3FpMa6fYgvoQBb7sJLzS5Nv38Li8YYB
 oCdjhl/8Rh6YTa8kdOLxgAO0YgcyvUwmKYAA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXO1-00000004MQa-1SoT; Thu, 26 Nov 2026 12:11:33 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6/7] drm/syncobj: Use scoped cleanup in drm_syncobj_array_find
 and callers
Date: Thu, 26 Nov 2026 11:11:16 +0000
Message-ID: <20261126111117.67342-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use scoped cleanup in drm_syncobj_array_find and its callers for simpler
error handling and easier extending with a fast path in the future.

Arrays which hold the drm_syncobj objects are now allocated by the
callers, removing the output parameter.

Maximum number of handles check is moved to the callers as well.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_syncobj.c | 195 +++++++++++++++++-----------------
 1 file changed, 97 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index da90ae11382e..6b4df322b12a 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1252,59 +1252,38 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
 	return 0;
 }
 
+struct syncobj_array {
+	struct drm_syncobj **syncobjs;
+	unsigned int count;
+};
+
+static void syncobj_array_free(struct syncobj_array *a)
+{
+	for (unsigned int i = 0; i < a->count; i++)
+		drm_syncobj_put(a->syncobjs[i]);
+}
+
+DEFINE_FREE(syncobj_array, struct syncobj_array, syncobj_array_free(&_T))
+
 static int drm_syncobj_array_find(struct drm_file *file_private,
-				  void __user *user_handles,
-				  uint32_t count_handles,
-				  struct drm_syncobj ***syncobjs_out)
+				  void __user *user_handles, unsigned int count,
+				  struct syncobj_array *array)
 {
-	uint32_t i, *handles;
-	struct drm_syncobj **syncobjs;
-	int ret;
+	u32 *handles __free(kvfree) = NULL;
+	unsigned int i;
 
-	if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
-		return -EINVAL;
-
-	handles = vmemdup_array_user(user_handles, count_handles,
-				     sizeof(*handles));
+	handles = vmemdup_array_user(user_handles, count, sizeof(*handles));
 	if (IS_ERR(handles))
-		return PTR_ERR(handles);
+		return PTR_ERR(no_free_ptr(handles));
 
-	syncobjs = kvmalloc_objs(*syncobjs, count_handles);
-	if (syncobjs == NULL) {
-		ret = -ENOMEM;
-		goto err_free_handles;
+	for (i = 0; i < count; i++) {
+		array->syncobjs[i] = drm_syncobj_find(file_private, handles[i]);
+		if (!array->syncobjs[i])
+			return -ENOENT;
+		array->count++;
 	}
 
-	for (i = 0; i < count_handles; i++) {
-		syncobjs[i] = drm_syncobj_find(file_private, handles[i]);
-		if (!syncobjs[i]) {
-			ret = -ENOENT;
-			goto err_put_syncobjs;
-		}
-	}
-
-	kvfree(handles);
-	*syncobjs_out = syncobjs;
 	return 0;
-
-err_put_syncobjs:
-	while (i-- > 0)
-		drm_syncobj_put(syncobjs[i]);
-	kvfree(syncobjs);
-err_free_handles:
-	kvfree(handles);
-
-	return ret;
-}
-
-static void drm_syncobj_array_free(struct drm_syncobj **syncobjs,
-				   uint32_t count)
-{
-	uint32_t i;
-
-	for (i = 0; i < count; i++)
-		drm_syncobj_put(syncobjs[i]);
-	kvfree(syncobjs);
 }
 
 int
@@ -1312,10 +1291,11 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *file_private)
 {
 	struct drm_syncobj_wait *args = data;
-	struct drm_syncobj **syncobjs;
+	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	struct syncobj_array array __free(syncobj_array) = {};
 	unsigned int possible_flags;
 	ktime_t t, *tp = NULL;
-	int ret = 0;
+	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
 		return -EOPNOTSUPP;
@@ -1329,11 +1309,17 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 
 	if (args->count_handles == 0)
 		return 0;
+	else if (args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
+		return -EINVAL;
 
+	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
+	if (!syncobjs)
+		return -ENOMEM;
+
+	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
-				     args->count_handles,
-				     &syncobjs);
+				     args->count_handles, &array);
 	if (ret < 0)
 		return ret;
 
@@ -1345,8 +1331,6 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_wait(dev, file_private,
 				     args, NULL, syncobjs, false, tp);
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
-
 	return ret;
 }
 
@@ -1355,7 +1339,8 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_wait *args = data;
-	struct drm_syncobj **syncobjs;
+	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	struct syncobj_array array __free(syncobj_array) = {};
 	unsigned int possible_flags;
 	ktime_t t, *tp = NULL;
 	int ret = 0;
@@ -1373,11 +1358,17 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 
 	if (args->count_handles == 0)
 		return 0;
+	else if (args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
+		return -EINVAL;
 
+	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
+	if (!syncobjs)
+		return -ENOMEM;
+
+	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
-				     args->count_handles,
-				     &syncobjs);
+				     args->count_handles, &array);
 	if (ret < 0)
 		return ret;
 
@@ -1389,8 +1380,6 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_wait(dev, file_private,
 				     NULL, args, syncobjs, true, tp);
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
-
 	return ret;
 }
 
@@ -1502,7 +1491,8 @@ drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_private)
 {
 	struct drm_syncobj_array *args = data;
-	struct drm_syncobj **syncobjs;
+	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	struct syncobj_array array __free(syncobj_array) = {};
 	uint32_t i;
 	int ret;
 
@@ -1512,21 +1502,24 @@ drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
 	if (args->pad != 0)
 		return -EINVAL;
 
-	if (args->count_handles == 0)
+	if (args->count_handles == 0 ||
+	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
+	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
+	if (!syncobjs)
+		return -ENOMEM;
+
+	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
-				     args->count_handles,
-				     &syncobjs);
+				     args->count_handles, &array);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < args->count_handles; i++)
 		drm_syncobj_replace_fence(syncobjs[i], NULL);
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
-
 	return 0;
 }
 
@@ -1535,7 +1528,8 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_private)
 {
 	struct drm_syncobj_array *args = data;
-	struct drm_syncobj **syncobjs;
+	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	struct syncobj_array array __free(syncobj_array) = {};
 	uint32_t i;
 	int ret;
 
@@ -1545,13 +1539,18 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 	if (args->pad != 0)
 		return -EINVAL;
 
-	if (args->count_handles == 0)
+	if (args->count_handles == 0 ||
+	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
+	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
+	if (!syncobjs)
+		return -ENOMEM;
+
+	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
-				     args->count_handles,
-				     &syncobjs);
+				     args->count_handles, &array);
 	if (ret < 0)
 		return ret;
 
@@ -1561,8 +1560,6 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 			break;
 	}
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
-
 	return ret;
 }
 
@@ -1589,9 +1586,10 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_array *args = data;
+	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	struct syncobj_array array __free(syncobj_array) = {};
 	struct syncobj_chains chains __free(syncobj_chains) = {};
 	u64 *points __free(kvfree) = NULL;
-	struct drm_syncobj **syncobjs;
 	unsigned int i;
 	int ret;
 
@@ -1601,40 +1599,39 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 	if (args->flags != 0)
 		return -EINVAL;
 
-	if (args->count_handles == 0)
+	if (args->count_handles == 0 ||
+	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
+	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
+	if (!syncobjs)
+		return -ENOMEM;
+
+	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
-				     args->count_handles,
-				     &syncobjs);
+				     args->count_handles, &array);
 	if (ret < 0)
 		return ret;
 
 	points = kvmalloc_objs(*points, args->count_handles);
-	if (!points) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	if (!u64_to_user_ptr(args->points)) {
+	if (!points)
+		return -ENOMEM;
+
+	if (!u64_to_user_ptr(args->points))
 		memset(points, 0, args->count_handles * sizeof(u64));
-	} else if (copy_from_user(points, u64_to_user_ptr(args->points),
-				  sizeof(u64) * args->count_handles)) {
-		ret = -EFAULT;
-		goto out;
-	}
+	else if (copy_from_user(points, u64_to_user_ptr(args->points),
+				sizeof(u64) * args->count_handles))
+		return -EFAULT;
 
 	chains.chains = kvmalloc_objs(*chains.chains, args->count_handles);
-	if (!chains.chains) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!chains.chains)
+		return -ENOMEM;
+
 	for (i = 0; i < args->count_handles; i++) {
 		chains.chains[i] = dma_fence_chain_alloc();
-		if (!chains.chains[i]) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!chains.chains[i])
+			return -ENOMEM;
 		chains.count++;
 	}
 
@@ -1647,9 +1644,6 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 		dma_fence_put(fence);
 	}
 
-out:
-	drm_syncobj_array_free(syncobjs, args->count_handles);
-
 	return ret;
 }
 
@@ -1657,7 +1651,8 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_array *args = data;
-	struct drm_syncobj **syncobjs;
+	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	struct syncobj_array array __free(syncobj_array) = {};
 	uint64_t __user *points = u64_to_user_ptr(args->points);
 	uint32_t i;
 	int ret;
@@ -1668,13 +1663,18 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 	if (args->flags & ~DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED)
 		return -EINVAL;
 
-	if (args->count_handles == 0)
+	if (args->count_handles == 0 ||
+	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
+	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
+	if (!syncobjs)
+		return -ENOMEM;
+
+	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
-				     args->count_handles,
-				     &syncobjs);
+				     args->count_handles, &array);
 	if (ret < 0)
 		return ret;
 
@@ -1717,7 +1717,6 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 		if (ret)
 			break;
 	}
-	drm_syncobj_array_free(syncobjs, args->count_handles);
 
 	return ret;
 }
-- 
2.56.0

