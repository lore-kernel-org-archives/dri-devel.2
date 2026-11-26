Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F240606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LGs31Giz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B66710E96A;
	Thu, 26 Nov 2026 11:11:50 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED6C8112215
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=fUCRSyEo5ryAWrtfk0hGWy+cooObOYllnkoNXrZOqgE=; t=1795691492; x=2111051492; 
 b=LGs31GizC86oMFMoR5iW130UwqDDtgy3doDuSNYwnLI+cpJ3cdK+usTsdbmkE+ooSAjvwqe/mgx
 SC6ontQ6UKX4ox9ctN7ck8bN9qHM5xXQP6XhZiV7M6z0LcnPKbs5MWM8yGDmwMrleEzmO7zCVNoHc
 v+Tw/oWpnFQPft/MU4v1VZ2z5MJry+ax6lVblSTXFlYbduuWhmjQObM7Bk0ysuUr/OQ330m6IBLik
 34NOY1KqRvJfUXt6RLVJi+POPr4gu/HNCnEI64yJNMbygqtHyY3gNfivZx/A0LD3Vmh/G0cYeWjtL
 wKpuSNclE2/F+LRurhQj8C5VLBpI6tFpfSpQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXNz-00000004MQ5-1VE9; Thu, 26 Nov 2026 12:11:31 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 3/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_array_wait_timeout syncobjs
Date: Thu, 26 Nov 2026 11:11:13 +0000
Message-ID: <20261126111117.67342-4-tvrtko.ursulin@igalia.com>
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

Use scoped cleanup for drm_syncobj_array_wait_timeout entries array
allocation and syncobj cleanup.

This converts the remaining parts of the function resulting in simpler
error handling and easier extending with a fast path in the future.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_syncobj.c | 61 +++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index bd3f9e74e678..7d5c4e4e29b2 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1044,6 +1044,31 @@ static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
 	list_del_init(&wait->node);
 }
 
+struct syncobj_wait_entries {
+	struct drm_syncobj **syncobjs;
+	struct syncobj_wait_entry *entries;
+	unsigned int count;
+};
+
+static void syncobj_wait_entries_free(struct syncobj_wait_entries *e)
+{
+	if (!e->entries)
+		return;
+
+	for (unsigned int i = 0; i < e->count; i++) {
+		drm_syncobj_remove_wait(e->syncobjs[i], &e->entries[i]);
+		if (e->entries[i].fence_cb.func)
+			dma_fence_remove_callback(e->entries[i].fence,
+						  &e->entries[i].fence_cb);
+		dma_fence_put(e->entries[i].fence);
+	}
+
+	kvfree(e->entries);
+}
+
+DEFINE_FREE(syncobj_wait_entries, struct syncobj_wait_entries,
+	    syncobj_wait_entries_free(&_T))
+
 static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  void __user *user_points,
 						  uint32_t count,
@@ -1052,6 +1077,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 						  uint32_t *idx,
 						  ktime_t *deadline)
 {
+	struct syncobj_wait_entries cleanup __free(syncobj_wait_entries) = {};
 	struct syncobj_wait_entry *entries;
 	u64 *points __free(kvfree) = NULL;
 	struct dma_fence *fence;
@@ -1076,6 +1102,11 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	if (!entries)
 		return -ENOMEM;
 
+	/* After this the entries cleanup is fully automatic. */
+	cleanup.syncobjs = syncobjs;
+	cleanup.entries = entries;
+	cleanup.count = count;
+
 	/* Walk the list of sync objects and initialize entries.  We do
 	 * this up-front so that we can properly return -EINVAL if there is
 	 * a syncobj with a missing fence and then never have the chance of
@@ -1091,12 +1122,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		if (!fence || dma_fence_chain_find_seqno(&fence, points[i])) {
 			dma_fence_put(fence);
 			if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
-				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
+				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
 				continue;
-			} else {
-				timeout = -EINVAL;
-				goto cleanup_entries;
-			}
+
+			return -EINVAL;
 		}
 
 		if (fence)
@@ -1115,7 +1144,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	if (signaled_count == count ||
 	    (signaled_count > 0 &&
 	     !(flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)))
-		goto cleanup_entries;
+		return timeout;
 
 	/* There's a very annoying laxness in the dma_fence API here, in
 	 * that backends are not required to automatically report when a
@@ -1160,40 +1189,30 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 				} else {
 					if (idx)
 						*idx = i;
-					goto done_waiting;
+					__set_current_state(TASK_RUNNING);
+					return timeout;
 				}
 			}
 		}
 
 		if (signaled_count == count)
-			goto done_waiting;
+			break;
 
 		if (timeout == 0) {
 			timeout = -ETIME;
-			goto done_waiting;
+			break;
 		}
 
 		if (signal_pending(current)) {
 			timeout = -ERESTARTSYS;
-			goto done_waiting;
+			break;
 		}
 
 		timeout = schedule_timeout(timeout);
 	} while (1);
 
-done_waiting:
 	__set_current_state(TASK_RUNNING);
 
-cleanup_entries:
-	for (i = 0; i < count; ++i) {
-		drm_syncobj_remove_wait(syncobjs[i], &entries[i]);
-		if (entries[i].fence_cb.func)
-			dma_fence_remove_callback(entries[i].fence,
-						  &entries[i].fence_cb);
-		dma_fence_put(entries[i].fence);
-	}
-	kvfree(entries);
-
 	return timeout;
 }
 
-- 
2.56.0

