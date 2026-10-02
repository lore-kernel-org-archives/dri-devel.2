Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EC0CA5FCE
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 00:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B53910E110;
	Fri,  2 Oct 2026 00:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M0pQ1Cvb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B7C10E09F;
 Fri,  2 Oct 2026 00:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790901503; x=1822437503;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=J3utxBYWapNuzsgJiM2xNv+dVDyB6qQmcrEPJ8HMbxI=;
 b=M0pQ1CvbVsDvpXouWVML7cE7hMFkmGxN6VRmVIA1G0pyj+FYrd/xWmeb
 u3praDIxfrps5pDaeZZNNIIpiJO/PL5aa17AHf/QLmMZi5ZdkGK/TYw6R
 pPLI58QcinuGisq5l16O9fZMuOI8qHRrID0rjqE3DZuhtoErI/ob/KQ5B
 EmIgAOKSqQXe8hKdlKthYh7XkAVSoAebXD+11IR0cnigaKpCqvog2jQE3
 UYhPRODStusy9RW7nfO8ZFETrrkaC9wTeLIh+J0atXwFoNnZdBsuZz6HX
 DK7hznOwHF7/knfYR/SguGcRvZp6yZ6x1c16P6+uH8Nh3Zqnfsbma4hFz g==;
X-CSE-ConnectionGUID: g67UicQrQJKiDmxoM0601g==
X-CSE-MsgGUID: cuRLrA06TKS+oy78/qNEow==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91693215"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="91693215"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 17:38:22 -0700
X-CSE-ConnectionGUID: Z84WhmAaTLKXie5L8J0qHA==
X-CSE-MsgGUID: +tr2yjb+TpSNbehLerEgEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="276240069"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 17:38:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/exec: track the first few locked objects inline
Date: Thu,  1 Oct 2026 17:38:16 -0700
Message-Id: <20261002003816.3233277-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

drm_exec_init() always allocates the table of locked objects, a whole
page of it unless the caller asks for a specific size. Many users only
ever lock a handful of objects, often just a VM's common dma-resv and
one BO, yet still pay for an allocation, and any of them can fail with
-ENOMEM. That is awkward on paths which can't fail, such as dropping
what may be the last reference of a drm_gpuvm_bo, which needs both the
VM's and the BO's dma-resv held; drivers end up open coding the ww_mutex
dance instead.

Keep room for DRM_EXEC_INLINE_OBJECTS (8) objects within struct drm_exec
itself and track the first locked objects there. Only once more are
locked does the table move to an allocation, which then grows as before.
A caller passing nr larger than that still gets an allocated table of
that size up front, falling back to the inline one should that fail.

As a result, locking up to DRM_EXEC_INLINE_OBJECTS objects never
allocates memory and cannot fail with -ENOMEM, and callers passing
nr == 0 no longer allocate a page they mostly don't need. The cost is
64 bytes more of struct drm_exec, which typically lives on the stack.

Since objects may now point into the struct itself, a struct drm_exec
must not be moved or copied after drm_exec_init(); no user does so.

Add a KUnit test which locks one object more than fits inline, checking
that the table moves out of the struct only then, that every object is
tracked across the move, and that a large nr skips the inline table.

Cc: Christian König <christian.koenig@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: LLM

---
This came out of a Sashiko review of the two-pass GPUVM series [1],
which flagged a nouveau cleanup path dropping a drm_gpuvm_bo with
drm_exec and silently carrying on if locking failed with -ENOMEM.
Grabbing a small number of locks on paths which cannot fail is quite
common, and drm_exec should provide a ww transaction wrapper for that
which can't fail, rather than drivers open coding the ww_mutex dance.

[1] https://sashiko.dev/#/patchset/20261001220632.3190896-1-matthew.brost%40intel.com
---
 drivers/gpu/drm/drm_exec.c            | 39 +++++++++++++------
 drivers/gpu/drm/tests/drm_exec_test.c | 55 +++++++++++++++++++++++++++
 include/drm/drm_exec.h                | 18 ++++++++-
 3 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 2453ec41360f..bdc9c79359b3 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -70,19 +70,26 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
  *
  * Initialize the object and make sure that we can track locked objects.
  *
- * If nr is non-zero then it is used as the initial objects table size.
- * In either case, the table will grow (be re-allocated) on demand.
+ * The first %DRM_EXEC_INLINE_OBJECTS locked objects are tracked within @exec
+ * itself, so locking no more than that never allocates memory. If nr is larger
+ * than that, it is used as the initial size of an allocated objects table
+ * instead. In either case, the table will grow (be re-allocated) on demand.
  */
 void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr)
 {
-	if (!nr)
-		nr = PAGE_SIZE / sizeof(void *);
+	exec->objects = NULL;
+	if (nr > DRM_EXEC_INLINE_OBJECTS)
+		exec->objects = kvmalloc_objs(*exec->objects, nr);
 
-	exec->flags = flags;
-	exec->objects = kvmalloc_objs(*exec->objects, nr);
+	/* If allocation here fails, just delay that till it is needed */
+	if (exec->objects) {
+		exec->max_objects = nr;
+	} else {
+		exec->objects = exec->inline_objects;
+		exec->max_objects = DRM_EXEC_INLINE_OBJECTS;
+	}
 
-	/* If allocation here fails, just delay that till the first use */
-	exec->max_objects = exec->objects ? nr : 0;
+	exec->flags = flags;
 	exec->num_objects = 0;
 	exec->contended = DRM_EXEC_DUMMY;
 	exec->prelocked = NULL;
@@ -99,7 +106,8 @@ EXPORT_SYMBOL(drm_exec_init);
 void drm_exec_fini(struct drm_exec *exec)
 {
 	drm_exec_unlock_all(exec);
-	kvfree(exec->objects);
+	if (exec->objects != exec->inline_objects)
+		kvfree(exec->objects);
 	if (exec->contended != DRM_EXEC_DUMMY) {
 		drm_gem_object_put(exec->contended);
 		ww_acquire_fini(&exec->ticket);
@@ -140,9 +148,16 @@ static int drm_exec_obj_locked(struct drm_exec *exec,
 {
 	if (unlikely(exec->num_objects == exec->max_objects)) {
 		size_t size = exec->max_objects * sizeof(void *);
-		void *tmp;
-
-		tmp = kvrealloc(exec->objects, size + PAGE_SIZE, GFP_KERNEL);
+		struct drm_gem_object **tmp;
+
+		if (exec->objects == exec->inline_objects) {
+			tmp = kvmalloc(size + PAGE_SIZE, GFP_KERNEL);
+			if (tmp)
+				memcpy(tmp, exec->objects, size);
+		} else {
+			tmp = kvrealloc(exec->objects, size + PAGE_SIZE,
+					GFP_KERNEL);
+		}
 		if (!tmp)
 			return -ENOMEM;
 
diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
index 7a374e462348..434ab9c59878 100644
--- a/drivers/gpu/drm/tests/drm_exec_test.c
+++ b/drivers/gpu/drm/tests/drm_exec_test.c
@@ -204,6 +204,60 @@ static void test_multiple_loops(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
+static void test_inline_objects(struct kunit *test)
+{
+	struct drm_exec_priv *priv = test->priv;
+	const unsigned int count = DRM_EXEC_INLINE_OBJECTS + 1;
+	DECLARE_BITMAP(seen, DRM_EXEC_INLINE_OBJECTS + 1) = {};
+	struct drm_gem_object *gobj, *obj;
+	struct drm_exec exec;
+	unsigned int i;
+	int ret = 0;
+
+	gobj = kunit_kcalloc(test, count, sizeof(*gobj), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, gobj);
+
+	for (i = 0; i < count; i++)
+		drm_gem_private_object_init(priv->drm, &gobj[i], PAGE_SIZE);
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	KUNIT_EXPECT_PTR_EQ(test, exec.objects, &exec.inline_objects[0]);
+	drm_exec_until_all_locked(&exec) {
+		for (i = 0; i < count; i++) {
+			ret = drm_exec_lock_obj(&exec, &gobj[i]);
+			drm_exec_retry_on_contention(&exec);
+			if (ret)
+				break;
+
+			/* Only spills out of the struct past the inline ones */
+			if (exec.num_objects <= DRM_EXEC_INLINE_OBJECTS)
+				KUNIT_EXPECT_PTR_EQ(test, exec.objects,
+						    &exec.inline_objects[0]);
+			else
+				KUNIT_EXPECT_PTR_NE(test, exec.objects,
+						    &exec.inline_objects[0]);
+		}
+	}
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, exec.num_objects, count);
+	/* Contention may reorder them, but each must be tracked once */
+	drm_exec_for_each_locked_object(&exec, obj) {
+		KUNIT_ASSERT_TRUE(test, obj >= gobj && obj < gobj + count);
+		KUNIT_EXPECT_FALSE(test, test_and_set_bit(obj - gobj, seen));
+	}
+	KUNIT_EXPECT_TRUE(test, bitmap_full(seen, count));
+	drm_exec_fini(&exec);
+
+	/* A larger initial size skips the inline objects altogether */
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, count);
+	KUNIT_EXPECT_PTR_NE(test, exec.objects, &exec.inline_objects[0]);
+	KUNIT_EXPECT_EQ(test, exec.max_objects, count);
+	drm_exec_fini(&exec);
+
+	for (i = 0; i < count; i++)
+		drm_gem_private_object_fini(&gobj[i]);
+}
+
 static struct kunit_case drm_exec_tests[] = {
 	KUNIT_CASE(sanitycheck),
 	KUNIT_CASE(test_lock),
@@ -212,6 +266,7 @@ static struct kunit_case drm_exec_tests[] = {
 	KUNIT_CASE(test_prepare),
 	KUNIT_CASE(test_prepare_array),
 	KUNIT_CASE(test_multiple_loops),
+	KUNIT_CASE(test_inline_objects),
 	{}
 };
 
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index cc2937185a9f..ddbdd745efd9 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -15,6 +15,12 @@
  */
 #define DRM_EXEC_DUMMY ((void *)~0)
 
+/*
+ * Number of locked objects tracked inside &struct drm_exec itself. Locking at
+ * most this many objects never allocates memory for tracking them.
+ */
+#define DRM_EXEC_INLINE_OBJECTS	8
+
 struct drm_gem_object;
 
 /**
@@ -42,7 +48,8 @@ struct drm_exec {
 	unsigned int		max_objects;
 
 	/**
-	 * @objects: array of the locked objects
+	 * @objects: array of the locked objects, either @inline_objects or
+	 * allocated once more objects need tracking than it can hold
 	 */
 	struct drm_gem_object	**objects;
 
@@ -55,6 +62,15 @@ struct drm_exec {
 	 * @prelocked: already locked GEM object due to contention
 	 */
 	struct drm_gem_object *prelocked;
+
+	/**
+	 * @inline_objects: storage for the first %DRM_EXEC_INLINE_OBJECTS
+	 * locked objects, so that locking only a few objects does not need to
+	 * allocate memory, and therefore cannot fail with -ENOMEM. As @objects
+	 * may point here, a &struct drm_exec must not be moved or copied after
+	 * drm_exec_init().
+	 */
+	struct drm_gem_object	*inline_objects[DRM_EXEC_INLINE_OBJECTS];
 };
 
 /**
-- 
2.34.1

