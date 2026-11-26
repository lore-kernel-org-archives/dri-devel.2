Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B9606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Aqgn6SLe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E465D112388;
	Thu, 26 Nov 2026 11:49:55 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E42E11238B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=7kJr9hfFhzXF8OsOop1Rsx4ZuRKtliqzLdtKPpw1haQ=; t=1795693789; x=2111053789; 
 b=Aqgn6SLeW52B1j/mH3i8Rl/rfAlkN645PAtg6R6L96S8RWOZ6LkvYKUNNsMS+fXzFY1/fS1q45A
 Fm75sqzg/9NImFZTnjaiBHSGM0QpiikP/ZTG49kukjrOT2vTNR46fS/NyDXK6QFkZYtqYWgMZdJ0/
 kHWRK+NeWhWLno38HXN18VS1SXeVgB/0KSX/k+CSHc9yVw8Mb+3KUmoUfmXB3dwQRNC9Tt+cJW5xo
 7mJkGGu9m7DZhrV/6OtZnfd0czvAd2eKlPbeeSWQAOHdiiAzi1wndGH1A89g7ENLOYXJzp/15Igfy
 VSYh5IbQp1N2+Vrgi2o42mgVWG+3o2zIgKAA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXz1-00000004NIO-0hVO; Thu, 26 Nov 2026 12:49:47 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 7/7] drm/syncobj: Add temporary array allocation fast paths
Date: Thu, 26 Nov 2026 11:49:45 +0000
Message-ID: <20261126114945.67886-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126111117.67342-8-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-8-tvrtko.ursulin@igalia.com>
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

Running the Cyberpunk 2077 benchmark we can observe that waiting on DRM
sycobjs (drm_syncobj_array_wait_timeout) is relatively hot, but that the
96% of the calls are for a single object, ~4% for two points, and never
more than three points. The lookup helper (drm_syncobj_array_find) many
other ioctls go through is in the similar situation with 97% of the calls
being for a single object, ~3% for two points, and never more than three
points. A more trivial workload like vkmark under KDE Plasma is even more
skewed to single point lookups.

Therefore lets add a fast path to bypass the temporary array allocation
and use a pre-allocated stack array for those cases.

We do this by adding two macros for declaring and initializing those
arrays. Because we have previously converted all impacted functions to
fully use scoped cleanup this is now quite easy to do.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Maíra Canal <mcanal@igalia.com>
---
v2:
 * Use fast path in drm_syncobj_array_find itself!
---
 drivers/gpu/drm/drm_syncobj.c | 179 +++++++++++++++++++++-------------
 1 file changed, 113 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 6b4df322b12a..1f918959bbe5 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -214,6 +214,53 @@
 
 #include "drm_internal.h"
 
+/*
+ * Empirically vast majority of ioctls pass in a single syncobj (96%) and never
+ * more than three points. Therefore implement a fast path with a small stack
+ * array to avoid going into the allocator sometimes several times per
+ * userspace rendered frame.
+ */
+#define DRM_SYNCOBJ_FAST_PATH_ENTRIES 4
+
+#define DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(_type, _name)	\
+	_type _name##_stack[DRM_SYNCOBJ_FAST_PATH_ENTRIES];	\
+	_type * _name##_heap __free(kvfree) = NULL;		\
+	_type * _name
+
+#define DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(_name, _src, _count) ({		\
+	int __ret = 0;							\
+									\
+	if ((_count) > ARRAY_SIZE(_name##_stack)) {			\
+		if (_src) {						\
+			_name##_heap = vmemdup_array_user((_src),	\
+							  (_count),	\
+							  sizeof(*(_name))); \
+			if (IS_ERR(_name##_heap)) {			\
+				__ret = PTR_ERR(no_free_ptr(_name##_heap)); \
+			} else {					\
+				_name = _name##_heap;			\
+			}						\
+		} else {						\
+			_name##_heap = kvzalloc_objs(*(_name), (_count)); \
+			if (!_name##_heap)				\
+				__ret = -ENOMEM;			\
+			else						\
+				_name = _name##_heap;			\
+		}							\
+	} else {							\
+		size_t __size = (_count) * sizeof(*(_name));		\
+									\
+		_name = _name##_stack;					\
+		if (_src) {						\
+			if (copy_from_user(_name, (_src), __size))	\
+				__ret = -EFAULT;			\
+		} else {						\
+			memset(_name, 0, __size);			\
+		}							\
+	}								\
+	__ret;								\
+})
+
 struct syncobj_wait_entry {
 	struct list_head node;
 	struct task_struct *task;
@@ -1062,8 +1109,6 @@ static void syncobj_wait_entries_free(struct syncobj_wait_entries *e)
 						  &e->entries[i].fence_cb);
 		dma_fence_put(e->entries[i].fence);
 	}
-
-	kvfree(e->entries);
 }
 
 DEFINE_FREE(syncobj_wait_entries, struct syncobj_wait_entries,
@@ -1077,11 +1122,12 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  uint32_t *idx,
 						  ktime_t *deadline)
 {
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct syncobj_wait_entry, entries);
 	struct syncobj_wait_entries cleanup __free(syncobj_wait_entries) = {};
-	struct syncobj_wait_entry *entries;
-	u64 *points __free(kvfree) = NULL;
-	struct dma_fence *fence;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(u64, points);
 	uint32_t signaled_count, i;
+	struct dma_fence *fence;
+	int ret;
 
 	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
 		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
@@ -1089,18 +1135,13 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		lockdep_assert_none_held_once();
 	}
 
-	points = kvmalloc_objs(*points, count);
-	if (!points)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(points, user_points, count);
+	if (ret)
+		return ret;
 
-	if (!user_points)
-		memset(points, 0, count * sizeof(u64));
-	else if (copy_from_user(points, user_points, sizeof(u64) * count))
-		return -EFAULT;
-
-	entries = kvzalloc_objs(*entries, count);
-	if (!entries)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(entries, NULL, count);
+	if (ret)
+		return ret;
 
 	/* After this the entries cleanup is fully automatic. */
 	cleanup.syncobjs = syncobjs;
@@ -1269,12 +1310,16 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
 				  void __user *user_handles, unsigned int count,
 				  struct syncobj_array *array)
 {
-	u32 *handles __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(u32, handles);
 	unsigned int i;
+	int ret;
 
-	handles = vmemdup_array_user(user_handles, count, sizeof(*handles));
-	if (IS_ERR(handles))
-		return PTR_ERR(no_free_ptr(handles));
+	if (!user_handles)
+		return -EFAULT; /* Preserve ABI error code */
+
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(handles, user_handles, count);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < count; i++) {
 		array->syncobjs[i] = drm_syncobj_find(file_private, handles[i]);
@@ -1291,7 +1336,7 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *file_private)
 {
 	struct drm_syncobj_wait *args = data;
-	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct drm_syncobj *, syncobjs);
 	struct syncobj_array array __free(syncobj_array) = {};
 	unsigned int possible_flags;
 	ktime_t t, *tp = NULL;
@@ -1312,9 +1357,10 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
 	else if (args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
-	if (!syncobjs)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(syncobjs, NULL,
+					      args->count_handles);
+	if (ret)
+		return ret;
 
 	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
@@ -1339,11 +1385,11 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_wait *args = data;
-	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct drm_syncobj *, syncobjs);
 	struct syncobj_array array __free(syncobj_array) = {};
 	unsigned int possible_flags;
 	ktime_t t, *tp = NULL;
-	int ret = 0;
+	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
 		return -EOPNOTSUPP;
@@ -1361,9 +1407,10 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
 	else if (args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
-	if (!syncobjs)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(syncobjs, NULL,
+					      args->count_handles);
+	if (ret)
+		return ret;
 
 	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
@@ -1491,7 +1538,7 @@ drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_private)
 {
 	struct drm_syncobj_array *args = data;
-	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct drm_syncobj *, syncobjs);
 	struct syncobj_array array __free(syncobj_array) = {};
 	uint32_t i;
 	int ret;
@@ -1506,9 +1553,10 @@ drm_syncobj_reset_ioctl(struct drm_device *dev, void *data,
 	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
-	if (!syncobjs)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(syncobjs, NULL,
+					      args->count_handles);
+	if (ret)
+		return ret;
 
 	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
@@ -1528,7 +1576,7 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_private)
 {
 	struct drm_syncobj_array *args = data;
-	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct drm_syncobj *, syncobjs);
 	struct syncobj_array array __free(syncobj_array) = {};
 	uint32_t i;
 	int ret;
@@ -1543,9 +1591,9 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
-	if (!syncobjs)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(syncobjs, NULL, args->count_handles);
+	if (ret)
+		return ret;
 
 	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
@@ -1575,8 +1623,6 @@ static void syncobj_chains_free(struct syncobj_chains *c)
 
 	for (unsigned int i = 0; i < c->count; i++)
 		dma_fence_chain_free(c->chains[i]);
-
-	kvfree(c->chains);
 }
 
 DEFINE_FREE(syncobj_chains, struct syncobj_chains, syncobj_chains_free(&_T))
@@ -1586,10 +1632,11 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_array *args = data;
-	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct drm_syncobj *, syncobjs);
 	struct syncobj_array array __free(syncobj_array) = {};
-	struct syncobj_chains chains __free(syncobj_chains) = {};
-	u64 *points __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct dma_fence_chain *, chains);
+	struct syncobj_chains cleanup_chains __free(syncobj_chains) = {};
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(u64, points);
 	unsigned int i;
 	int ret;
 
@@ -1603,9 +1650,10 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
-	if (!syncobjs)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(syncobjs, NULL,
+					      args->count_handles);
+	if (ret)
+		return ret;
 
 	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
@@ -1614,33 +1662,31 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
 	if (ret < 0)
 		return ret;
 
-	points = kvmalloc_objs(*points, args->count_handles);
-	if (!points)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(points,
+					      u64_to_user_ptr(args->points),
+					      args->count_handles);
+	if (ret)
+		return ret;
 
-	if (!u64_to_user_ptr(args->points))
-		memset(points, 0, args->count_handles * sizeof(u64));
-	else if (copy_from_user(points, u64_to_user_ptr(args->points),
-				sizeof(u64) * args->count_handles))
-		return -EFAULT;
-
-	chains.chains = kvmalloc_objs(*chains.chains, args->count_handles);
-	if (!chains.chains)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(chains, NULL,
+					      args->count_handles);
+	if (ret)
+		return ret;
 
+	cleanup_chains.chains = chains;
 	for (i = 0; i < args->count_handles; i++) {
-		chains.chains[i] = dma_fence_chain_alloc();
-		if (!chains.chains[i])
+		chains[i] = dma_fence_chain_alloc();
+		if (!chains[i])
 			return -ENOMEM;
-		chains.count++;
+		cleanup_chains.count++;
 	}
 
 	for (i = 0; i < args->count_handles; i++) {
 		struct dma_fence *fence = dma_fence_get_stub();
 
-		drm_syncobj_add_point(syncobjs[i], chains.chains[i],
+		drm_syncobj_add_point(syncobjs[i], chains[i],
 				      fence, points[i]);
-		chains.chains[i] = NULL; /* Ownership transferred to syncobj */
+		chains[i] = NULL; /* Ownership transferred to syncobj */
 		dma_fence_put(fence);
 	}
 
@@ -1651,7 +1697,7 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_private)
 {
 	struct drm_syncobj_timeline_array *args = data;
-	struct drm_syncobj **syncobjs __free(kvfree) = NULL;
+	DRM_SYNCOBJ_DECLARE_FASTPATH_ARRAY(struct drm_syncobj *, syncobjs);
 	struct syncobj_array array __free(syncobj_array) = {};
 	uint64_t __user *points = u64_to_user_ptr(args->points);
 	uint32_t i;
@@ -1667,9 +1713,10 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 	    args->count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	syncobjs = kvmalloc_objs(*syncobjs, args->count_handles);
-	if (!syncobjs)
-		return -ENOMEM;
+	ret = DRM_SYNCOBJ_INIT_FASTPATH_ARRAY(syncobjs, NULL,
+					      args->count_handles);
+	if (ret)
+		return ret;
 
 	array.syncobjs = syncobjs;
 	ret = drm_syncobj_array_find(file_private,
-- 
2.56.0

