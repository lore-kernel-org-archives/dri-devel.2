Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632F60A2617
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Elal+QSu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69A610F87C;
	Tue, 27 Oct 2026 22:49:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8285110E0AE;
 Tue, 27 Oct 2026 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793141352; x=1824677352;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q+a0KRkWbPKPPXbj5S0Roto3SXW+vy8mMj3iYqdK9kM=;
 b=Elal+QSuMFFKIXLXMkhUscM5NeuX8nMZaJEzDXonqcjMuIZ9P8za7I0y
 TxTlYvjkjjR2YKRlDSpyYYBi8alc+e6MAJVfM+2GxgJZowTXsejuAMoLB
 MYm3vhrikO3KyHsCJu9sGwyNkKc87Ex8qMvSO1TNGcFxnN5zUEQtu05K3
 lKMZAU3NAttG5scBjf8lYpQqdKRtmK3TlfspeuJiek0NtbOvZ9z4ZDADM
 6yplDthTZFdRH0CW0LOU9rYWKWP2nZ4ZRQqaD3FMnHMUV26QHfgixu1E3
 TRoO8M3ErMSNNfJdeJoT1r1mAghYECmWEuA8zX+qL2DmJa2HwyR9G6aMo w==;
X-CSE-ConnectionGUID: YfGrrNBpQHecsJA3Lg2uvQ==
X-CSE-MsgGUID: Mh502NpuTw6QgkdUWuHssw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1842032"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1842032"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 15:49:07 -0700
X-CSE-ConnectionGUID: /NMtqngoS8uTxVEU31yNwg==
X-CSE-MsgGUID: eOFKBTYdSn2RNmM+QXJCIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5056295"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 15:49:07 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v6 2/3] drm/ttm: Allow skipping to the next priority in the bo
 LRU cursor
Date: Tue, 27 Oct 2026 15:49:01 -0700
Message-Id: <20261027224902.1085762-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027224902.1085762-1-matthew.brost@intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drivers walking a manager's LRU with ttm_bo_lru_for_each_reserved_guarded()
may decide that the rest of the current priority isn't worth walking,
for example when the priority is roughly age ordered and the walk hit
a BO that is still too hot to evict. Today the only option is to stop
the walk altogether, which also gives up on the remaining priorities.

Add ttm_resource_manager_next_priority() to move a resource cursor to
the start of the next priority, and ttm_bo_lru_cursor_skip_priority()
to make the next ttm_bo_lru_cursor_next() use it.

While at it, stop incrementing the cursor priority past the last valid
priority once the iteration is done.

Assisted-by: LLM
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c  |  3 +++
 drivers/gpu/drm/ttm/ttm_resource.c | 35 ++++++++++++++++++++++++++----
 include/drm/ttm/ttm_bo.h           | 19 ++++++++++++++++
 include/drm/ttm/ttm_resource.h     |  2 ++
 4 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f9458a4d5a09..d626f014e61f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -997,6 +997,9 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
 		if (first) {
 			res = ttm_resource_manager_first(&curs->res_curs);
 			first = false;
+		} else if (curs->skip_priority) {
+			res = ttm_resource_manager_next_priority(&curs->res_curs);
+			curs->skip_priority = false;
 		} else {
 			res = ttm_resource_manager_next(&curs->res_curs);
 		}
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 4e6d3d658d85..e631507d7aa1 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -674,6 +674,17 @@ ttm_resource_cursor_check_bulk(struct ttm_resource_cursor *cursor,
 	}
 }
 
+static bool ttm_resource_cursor_next_priority(struct ttm_resource_cursor *cursor)
+{
+	if (cursor->priority + 1 >= TTM_MAX_BO_PRIORITY)
+		return false;
+
+	list_move(&cursor->hitch.link, &cursor->man->lru[++cursor->priority]);
+	ttm_resource_cursor_clear_bulk(cursor);
+
+	return true;
+}
+
 /**
  * ttm_resource_manager_first() - Start iterating over the resources
  * of a resource manager
@@ -723,16 +734,32 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
 			}
 		}
 
-		if (++cursor->priority >= TTM_MAX_BO_PRIORITY)
+		if (!ttm_resource_cursor_next_priority(cursor))
 			break;
-
-		list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
-		ttm_resource_cursor_clear_bulk(cursor);
 	}
 
 	return NULL;
 }
 
+/**
+ * ttm_resource_manager_next_priority() - Skip the rest of the current
+ * priority and continue iterating at the next one
+ * @cursor: cursor to record the position
+ *
+ * Return: the first resource of the next non-empty priority, or NULL if
+ * there is none.
+ */
+struct ttm_resource *
+ttm_resource_manager_next_priority(struct ttm_resource_cursor *cursor)
+{
+	lockdep_assert_held(&cursor->man->bdev->lru_lock);
+
+	if (!ttm_resource_cursor_next_priority(cursor))
+		return NULL;
+
+	return ttm_resource_manager_next(cursor);
+}
+
 /**
  * ttm_lru_first_res_or_null() - Return the first resource on an lru list
  * @head: The list head of the lru list.
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..2fc517dbf03d 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -507,10 +507,29 @@ struct ttm_bo_lru_cursor {
 	 * unlock before the next iteration or after loop exit.
 	 */
 	bool needs_unlock;
+	/**
+	 * @skip_priority: Continue at the next LRU priority on the next
+	 * iteration. See ttm_bo_lru_cursor_skip_priority().
+	 */
+	bool skip_priority;
 	/** @arg: Pointer to common BO LRU walk arguments. */
 	struct ttm_lru_walk_arg *arg;
 };
 
+/**
+ * ttm_bo_lru_cursor_skip_priority() - Skip the rest of the current priority
+ * @curs: The cursor.
+ *
+ * Make the next ttm_bo_lru_cursor_next() skip the remaining buffer objects
+ * of the current LRU priority and continue at the next priority, for
+ * example when the caller decides the rest of the priority isn't worth
+ * walking.
+ */
+static inline void ttm_bo_lru_cursor_skip_priority(struct ttm_bo_lru_cursor *curs)
+{
+	curs->skip_priority = true;
+}
+
 void ttm_bo_lru_cursor_fini(struct ttm_bo_lru_cursor *curs);
 
 struct ttm_bo_lru_cursor *
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 714c533622c2..8cd70d1e5481 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -499,6 +499,8 @@ struct ttm_resource *
 ttm_resource_manager_first(struct ttm_resource_cursor *cursor);
 struct ttm_resource *
 ttm_resource_manager_next(struct ttm_resource_cursor *cursor);
+struct ttm_resource *
+ttm_resource_manager_next_priority(struct ttm_resource_cursor *cursor);
 
 struct ttm_resource *
 ttm_lru_first_res_or_null(struct list_head *head);
-- 
2.34.1

