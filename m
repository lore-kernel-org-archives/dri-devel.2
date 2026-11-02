Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4D606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hhR9a+/e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421B310F26D;
	Mon,  2 Nov 2026 22:32:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B0410E712;
 Mon,  2 Nov 2026 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793658752; x=1825194752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3KhDVYngxlU6LdfIVKc3pqs6RfDVe80tNN30bSb/N78=;
 b=hhR9a+/eItVzhiu8YQ65lEGphLSqqMNTzmwCDp9vNGjcDfTrC+rCKLgH
 PB8nciS+5ZqrcNvNdyqrT8vIEsVYAIF/0UDYT03efC/tBplS+ozWtdPjj
 uc+b0A8d+6047mSW99uABlQ26NRvBSppf30aeestIAYp3lwWOJm6AarvC
 uoFYC/7x2SHeLItr6KxAqN2PnuK6LtjO/BHKOpXR8OHjVjiZt4ka1345S
 Sq9LLBQ181Abk+3qXKsH/j5d9vMuvWLhXm+3CmB4g2Nw6VXHCqEXpPF6b
 ciqRAVW34EluspBh1ufXavDqOPg5XeMXzX/4xuHyFtlxWBsMAtXVxZiMa A==;
X-CSE-ConnectionGUID: 4fUcRppgRmSRXyWEdILDnw==
X-CSE-MsgGUID: 8dU3kc06RF6BhfbL1kinFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2268431"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2268431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:32:26 -0800
X-CSE-ConnectionGUID: 2aLN61LeQkqYKCi+X6xXCA==
X-CSE-MsgGUID: umGEhBHmR6Kojj9Z9wl6nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6628962"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:32:26 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v7 2/3] drm/ttm: Allow skipping to the next priority in the bo
 LRU cursor
Date: Mon,  2 Nov 2026 14:32:19 -0800
Message-Id: <20261102223220.1411858-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102223220.1411858-1-matthew.brost@intel.com>
References: <20261102223220.1411858-1-matthew.brost@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drivers walking a manager's LRU with ttm_bo_lru_for_each_reserved_guarded()
may decide that the rest of the current priority isn't worth walking,
for example when the priority is roughly age ordered and the walk hit
a BO that is still too hot to evict. Today the only option is to stop
the walk altogether, which also gives up on the remaining priorities.

Add ttm_resource_cursor_skip_priority(), which parks the cursor hitch at
the end of the current priority. The iteration already copes with that:
it finds nothing left in the priority and moves on to the next one, or
ends if there is none. Wrap it in ttm_bo_lru_cursor_skip_priority() for
users of the bo LRU cursor.

While at it, stop incrementing the cursor priority past the last valid
priority once the iteration is done, as it is now used to index the lru
array outside of the iteration itself.

Assisted-by: LLM
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

---
v7:
 - Drop extra bool rather just advance hitch (Natalie)
---
 drivers/gpu/drm/ttm/ttm_bo_util.c  | 19 +++++++++++++++++
 drivers/gpu/drm/ttm/ttm_resource.c | 33 ++++++++++++++++++++++++++----
 include/drm/ttm/ttm_bo.h           |  2 ++
 include/drm/ttm/ttm_resource.h     |  1 +
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f9458a4d5a09..d81dd3738dc0 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -955,6 +955,25 @@ void ttm_bo_lru_cursor_fini(struct ttm_bo_lru_cursor *curs)
 }
 EXPORT_SYMBOL(ttm_bo_lru_cursor_fini);
 
+/**
+ * ttm_bo_lru_cursor_skip_priority() - Skip the rest of the current priority
+ * @curs: The cursor.
+ *
+ * Make the next ttm_bo_lru_cursor_next() skip the remaining buffer objects
+ * of the current LRU priority and continue at the next one, for example
+ * when the caller decides the rest of the priority isn't worth walking.
+ * If the current priority is the last one, the iteration ends.
+ */
+void ttm_bo_lru_cursor_skip_priority(struct ttm_bo_lru_cursor *curs)
+{
+	struct ttm_device *bdev = curs->res_curs.man->bdev;
+
+	spin_lock(&bdev->lru_lock);
+	ttm_resource_cursor_skip_priority(&curs->res_curs);
+	spin_unlock(&bdev->lru_lock);
+}
+EXPORT_SYMBOL(ttm_bo_lru_cursor_skip_priority);
+
 /**
  * ttm_bo_lru_cursor_init() - Initialize a struct ttm_bo_lru_cursor
  * @curs: The ttm_bo_lru_cursor to initialize.
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 4e6d3d658d85..2db5d9bbfbe7 100644
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
@@ -723,16 +734,30 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
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
+ * ttm_resource_cursor_skip_priority() - Skip the rest of the current priority
+ * @cursor: cursor to record the position
+ *
+ * Make the next ttm_resource_manager_next() continue at the next priority,
+ * or end the iteration if the current priority is the last one. Done by
+ * parking the hitch at the end of the current priority, which the iteration
+ * already handles.
+ */
+void ttm_resource_cursor_skip_priority(struct ttm_resource_cursor *cursor)
+{
+	lockdep_assert_held(&cursor->man->bdev->lru_lock);
+
+	list_move_tail(&cursor->hitch.link, &cursor->man->lru[cursor->priority]);
+	ttm_resource_cursor_clear_bulk(cursor);
+}
+
 /**
  * ttm_lru_first_res_or_null() - Return the first resource on an lru list
  * @head: The list head of the lru list.
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..e430b643d7f4 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -513,6 +513,8 @@ struct ttm_bo_lru_cursor {
 
 void ttm_bo_lru_cursor_fini(struct ttm_bo_lru_cursor *curs);
 
+void ttm_bo_lru_cursor_skip_priority(struct ttm_bo_lru_cursor *curs);
+
 struct ttm_bo_lru_cursor *
 ttm_bo_lru_cursor_init(struct ttm_bo_lru_cursor *curs,
 		       struct ttm_resource_manager *man,
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 714c533622c2..d90e1cffa862 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -499,6 +499,7 @@ struct ttm_resource *
 ttm_resource_manager_first(struct ttm_resource_cursor *cursor);
 struct ttm_resource *
 ttm_resource_manager_next(struct ttm_resource_cursor *cursor);
+void ttm_resource_cursor_skip_priority(struct ttm_resource_cursor *cursor);
 
 struct ttm_resource *
 ttm_lru_first_res_or_null(struct list_head *head);
-- 
2.34.1

