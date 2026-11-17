Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB2606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=B0bR4zx+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B0110F5B4;
	Tue, 17 Nov 2026 10:39:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3029410F5EF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=aO0YSt0MS8ic3QQQx8ddZlNRd8M7qlHhEKlOZUAvDls=; t=1794911961; x=2110271961; 
 b=B0bR4zx+spJr+GePo7+Ke/YlrzolmI+x3te0ZVpAQsaoiay3H+23uGs7/H5NF/A8vTHvEI6doQu
 HAcH8efYiFXtqMjEzVPV9239mHLBpGuMttwRvl36JmdAODWZgCsi0U7kPrfctzaX812lHT68/TYS+
 soAKB/Lk+PQqksfarc4DiDb2Hl6I8n1UH8a8+ewKpVc0gwmxxcgE6aZVO0IrdvXRy5/QQDI4YPYeq
 491PnAmtjef/mYTwU58L2S/n4F5rhJmVx0/Avxl2Alsz+U5speXlK0oX8RSD7mxXk0tIWEGAXX0iH
 eALsGGFb5wBWtXWeBEcFttSBJqNpOehsiIyA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTGat-00000000XyS-2LtH; Tue, 17 Nov 2026 11:39:19 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/syncobj: Add a fast path to
 drm_syncobj_array_wait_timeout
Date: Tue, 17 Nov 2026 10:39:15 +0000
Message-ID: <20261117103916.9101-3-tvrtko.ursulin@igalia.com>
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

Running the Cyberpunk 2077 benchmark we can observe that waiting on DRM
sycobjs is relatively hot, but the 96% of the calls are for a single
object. (~4% for two points, and never more than three points. While
a more trivial workload like vkmark under Plasma is even more skewed
to single point waits.)

Therefore lets add a fast path to bypass the kcalloc/kfree and use a pre-
allocated stack array for those cases.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com> # v3
Cc: Fei Yu <fei.yu@intel.com>
Cc: Christian König <christian.koenig@amd.com>
---
v2:
 * Document rationale for stack array in a comment.

v3:
 * Added DRM_SYNCOBJ_FAST_PATH_ENTRIES to avoid hardcoding fast path array
   size.

v4:
 * Rebased to be standalone.

v5:
 * Rebased for kzalloc_objs.

v6:
 * Rebased for kvmalloc_objs and kvzalloc_objs.
---
 drivers/gpu/drm/drm_syncobj.c | 44 ++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 663d6cb8dbf8..b76b957b1fff 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -248,6 +248,14 @@ static void
 syncobj_eventfd_entry_func(struct drm_syncobj *syncobj,
 			   struct syncobj_eventfd_entry *entry);
 
+/*
+ * Empirically vast majority of ioctls pass in a single syncobj (96%) and never
+ * more than three points. Therefore implement a fast path with a small stack
+ * array to avoid going into the allocator sometimes several times per
+ * userspace rendered frame.
+ */
+#define DRM_SYNCOBJ_FAST_PATH_ENTRIES 4
+
 /**
  * drm_syncobj_find - lookup and reference a sync object.
  * @file_private: drm file private pointer
@@ -1051,10 +1059,12 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  uint32_t *idx,
 						  ktime_t *deadline)
 {
+	struct syncobj_wait_entry stack_entries[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
+	u64 stack_points[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
 	struct syncobj_wait_entry *entries;
 	struct dma_fence *fence;
-	uint64_t *points;
 	uint32_t signaled_count, i;
+	uint64_t *points;
 
 	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
 		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
@@ -1062,24 +1072,33 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		lockdep_assert_none_held_once();
 	}
 
-	points = kvmalloc_objs(*points, count);
-	if (points == NULL)
-		return -ENOMEM;
+	if (count > ARRAY_SIZE(stack_points)) {
+		points = kvmalloc_objs(*points, count);
+		if (!points)
+			return -ENOMEM;
+	} else {
+		points = stack_points;
+	}
 
 	if (!user_points) {
 		memset(points, 0, count * sizeof(uint64_t));
-
 	} else if (copy_from_user(points, user_points,
 				  sizeof(uint64_t) * count)) {
 		timeout = -EFAULT;
 		goto err_free_points;
 	}
 
-	entries = kvzalloc_objs(*entries, count);
-	if (!entries) {
-		timeout = -ENOMEM;
-		goto err_free_points;
+	if (count > ARRAY_SIZE(stack_entries)) {
+		entries = kvzalloc_objs(*entries, count);
+		if (!entries) {
+			timeout = -ENOMEM;
+			goto err_free_points;
+		}
+	} else {
+		memset(stack_entries, 0, sizeof(stack_entries));
+		entries = stack_entries;
 	}
+
 	/* Walk the list of sync objects and initialize entries.  We do
 	 * this up-front so that we can properly return -EINVAL if there is
 	 * a syncobj with a missing fence and then never have the chance of
@@ -1196,10 +1215,13 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  &entries[i].fence_cb);
 		dma_fence_put(entries[i].fence);
 	}
-	kvfree(entries);
+
+	if (entries != stack_entries)
+		kvfree(entries);
 
 err_free_points:
-	kvfree(points);
+	if (points != stack_points)
+		kvfree(points);
 
 	return timeout;
 }
-- 
2.56.0

