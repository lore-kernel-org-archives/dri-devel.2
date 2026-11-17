Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=eh6FKfRD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE3510F5EE;
	Tue, 17 Nov 2026 10:39:36 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE1810F607
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=FGYvzO/Fvu62ibE6DcEwcaZkrX9wGtHc4dba5a52vZQ=; t=1794911961; x=2110271961; 
 b=eh6FKfRDFE5pLvm/cvPwPmi82oojoBtm6ishBTR+aQH1JA1qeaC/w/CpewkjSypf9HPrw/oDJ/X
 G87xU5C6b3Jm8/ZAOmGSSiECNxBwEdl2a57Gwx6YskvU7a2N6GmGGsGPkbYi9gB1D1EnrOb8fUq+a
 P5w3VPhPKGnWCJNoAArnkbiR0q44wW4SuMRqmsqnC77+DT5tuDH1dckTIe6s/DOleeaq0iEMIgYQg
 nsgnYFntI2oFW7MuBsFkgQpX8X+Yv6xKCc2wFk/Q2jDQkFvvg4Baee9wlLY3o42JtD8SAJ59wrsWY
 Tou3cW5bq1Vv/BKyUxwTMVDVA3Hs8D3zMsfg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTGau-00000000Xya-0rRF; Tue, 17 Nov 2026 11:39:20 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/syncobj: Add a fast path to drm_syncobj_array_find
Date: Tue, 17 Nov 2026 10:39:16 +0000
Message-ID: <20261117103916.9101-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
References: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
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

Running the Cyberpunk 2077 benchmark we can observe that the lookup helper
is relatively hot, but the 97% of the calls are for a single object. (~3%
for two points, and never more than three points. While a more trivial
workload like vkmark under Plasma is even more skewed to single point
lookups.)

Therefore lets add a fast path to bypass the kmalloc_array/kfree and use a
pre-allocated stack array for those cases.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com> # v2
Cc: Fei Yu <fei.yu@intel.com>
Cc: Christian König <christian.koenig@amd.com>
---
v2:
 * Added comments describing how the fast path arrays were sized.
 * Make container freeing criteria clearer by using a boolean.

v3:
 * Rebased to be standalone.

v4:
 * Rebased for kmalloc_objs.

v5:
 * Rebased for vmemdup_array_user and kvmalloc_objs.
---
 drivers/gpu/drm/drm_syncobj.c | 85 +++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index b76b957b1fff..c4514f186d50 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1265,6 +1265,9 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
 static int drm_syncobj_array_find(struct drm_file *file_private,
 				  void __user *user_handles,
 				  uint32_t count_handles,
+				  uint32_t *stack_handles,
+				  struct drm_syncobj **stack_syncobjs,
+				  u32 stack_count,
 				  struct drm_syncobj ***syncobjs_out)
 {
 	uint32_t i, *handles;
@@ -1274,15 +1277,23 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
 	if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	handles = vmemdup_array_user(user_handles, count_handles,
-				     sizeof(*handles));
-	if (IS_ERR(handles))
-		return PTR_ERR(handles);
+	if (count_handles > stack_count) {
+		handles = vmemdup_array_user(user_handles, count_handles,
+					     sizeof(*handles));
+		if (IS_ERR(handles))
+			return PTR_ERR(handles);
 
-	syncobjs = kvmalloc_objs(*syncobjs, count_handles);
-	if (syncobjs == NULL) {
-		ret = -ENOMEM;
-		goto err_free_handles;
+		syncobjs = kvmalloc_objs(*syncobjs, count_handles);;
+		if (!syncobjs) {
+			ret = -ENOMEM;
+			goto err_free_handles;
+		}
+	} else {
+		handles = stack_handles;
+		syncobjs = stack_syncobjs;
+		if (copy_from_user(handles, user_handles,
+				   count_handles * sizeof(*handles)))
+			return -EFAULT;
 	}
 
 	for (i = 0; i < count_handles; i++) {
@@ -1293,34 +1304,42 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
 		}
 	}
 
-	kvfree(handles);
+	if (handles != stack_handles)
+		kvfree(handles);
 	*syncobjs_out = syncobjs;
 	return 0;
 
 err_put_syncobjs:
 	while (i-- > 0)
 		drm_syncobj_put(syncobjs[i]);
-	kvfree(syncobjs);
+	if (syncobjs != stack_syncobjs)
+		kvfree(syncobjs);
 err_free_handles:
-	kvfree(handles);
+	if (handles != stack_handles)
+		kvfree(handles);
 
 	return ret;
 }
 
 static void drm_syncobj_array_free(struct drm_syncobj **syncobjs,
-				   uint32_t count)
+				   uint32_t count,
+				   struct drm_syncobj **stack_syncobjs)
 {
 	uint32_t i;
 
 	for (i = 0; i < count; i++)
 		drm_syncobj_put(syncobjs[i]);
-	kvfree(syncobjs);
+
+	if (syncobjs != stack_syncobjs)
+		kvfree(syncobjs);
 }
 
 int
 drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *file_private)
 {
+	struct drm_syncobj *stack_syncobjs[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
+	uint32_t stack_handles[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
 	struct drm_syncobj_wait *args = data;
 	struct drm_syncobj **syncobjs;
 	unsigned int possible_flags;
@@ -1343,6 +1362,9 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
 				     args->count_handles,
+				     stack_handles,
+				     stack_syncobjs,
+				     ARRAY_SIZE(stack_syncobjs),
 				     &syncobjs);
 	if (ret < 0)
 		return ret;
@@ -1355,7 +1377,7 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_wait(dev, file_private,
 				     args, NULL, syncobjs, false, tp);
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
+	drm_syncobj_array_free(syncobjs, args->count_handles, stack_syncobjs);
 
 	return ret;
 }
@@ -1364,6 +1386,8 @@ int
 drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_private)
 {
+	struct drm_syncobj *stack_syncobjs[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
+	uint32_t stack_handles[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
 	struct drm_syncobj_timeline_wait *args = data;
 	struct drm_syncobj **syncobjs;
 	unsigned int possible_flags;
@@ -1387,6 +1411,9 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
 				     args->count_handles,
+				     stack_handles,
+				     stack_syncobjs,
+				     ARRAY_SIZE(stack_syncobjs),
 				     &syncobjs);
 	if (ret < 0)
 		return ret;
@@ -1399,7 +1426,7 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_wait(dev, file_private,
 				     NULL, args, syncobjs, true, tp);
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
+	drm_syncobj_array_free(syncobjs, args->count_handles, stack_syncobjs);
 
 	return ret;
 }
@@ -1511,6 +1538,8 @@ int
 drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_private)
 {
+	struct drm_syncobj *stack_syncobjs[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
+	uint32_t stack_handles[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
 	struct drm_syncobj_array *args = data;
 	struct drm_syncobj **syncobjs;
 	uint32_t i;
@@ -1528,6 +1557,9 @@ drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
 				     args->count_handles,
+				     stack_handles,
+				     stack_syncobjs,
+				     ARRAY_SIZE(stack_syncobjs),
 				     &syncobjs);
 	if (ret < 0)
 		return ret;
@@ -1535,7 +1567,7 @@ drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
 	for (i = 0; i < args->count_handles; i++)
 		drm_syncobj_replace_fence(syncobjs[i], NULL);
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
+	drm_syncobj_array_free(syncobjs, args->count_handles, stack_syncobjs);
 
 	return 0;
 }
@@ -1544,6 +1576,8 @@ int
 drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_private)
 {
+	struct drm_syncobj *stack_syncobjs[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
+	uint32_t stack_handles[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
 	struct drm_syncobj_array *args = data;
 	struct drm_syncobj **syncobjs;
 	uint32_t i;
@@ -1561,6 +1595,9 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
 				     args->count_handles,
+				     stack_handles,
+				     stack_syncobjs,
+				     ARRAY_SIZE(stack_syncobjs),
 				     &syncobjs);
 	if (ret < 0)
 		return ret;
@@ -1571,7 +1608,7 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 			break;
 	}
 
-	drm_syncobj_array_free(syncobjs, args->count_handles);
+	drm_syncobj_array_free(syncobjs, args->count_handles, stack_syncobjs);
 
 	return ret;
 }
@@ -1580,6 +1617,8 @@ int
 drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *file_private)
 {
+	struct drm_syncobj *stack_syncobjs[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
+	uint32_t stack_handles[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
 	struct drm_syncobj_timeline_array *args = data;
 	struct drm_syncobj **syncobjs;
 	struct dma_fence_chain **chains;
@@ -1599,6 +1638,9 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
 				     args->count_handles,
+				     stack_handles,
+				     stack_syncobjs,
+				     ARRAY_SIZE(stack_syncobjs),
 				     &syncobjs);
 	if (ret < 0)
 		return ret;
@@ -1643,7 +1685,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 err_points:
 	kvfree(points);
 out:
-	drm_syncobj_array_free(syncobjs, args->count_handles);
+	drm_syncobj_array_free(syncobjs, args->count_handles, stack_syncobjs);
 
 	return ret;
 }
@@ -1651,6 +1693,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_private)
 {
+	struct drm_syncobj *stack_syncobjs[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
+	uint32_t stack_handles[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
 	struct drm_syncobj_timeline_array *args = data;
 	struct drm_syncobj **syncobjs;
 	uint64_t __user *points = u64_to_user_ptr(args->points);
@@ -1669,6 +1713,9 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 	ret = drm_syncobj_array_find(file_private,
 				     u64_to_user_ptr(args->handles),
 				     args->count_handles,
+				     stack_handles,
+				     stack_syncobjs,
+				     ARRAY_SIZE(stack_syncobjs),
 				     &syncobjs);
 	if (ret < 0)
 		return ret;
@@ -1712,7 +1759,7 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 		if (ret)
 			break;
 	}
-	drm_syncobj_array_free(syncobjs, args->count_handles);
+	drm_syncobj_array_free(syncobjs, args->count_handles, stack_syncobjs);
 
 	return ret;
 }
-- 
2.56.0

