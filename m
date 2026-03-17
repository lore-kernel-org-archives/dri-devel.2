Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F79FD8777
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B8F10E66C;
	Tue, 17 Mar 2026 14:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Npf4sjCd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1AB10E674;
 Tue, 17 Mar 2026 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773757167; x=1805293167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0K6Ph3bJoAhgXeJQ/xLzevkk2eibpDETYN3Jmhkk6j4=;
 b=Npf4sjCdAAbJ5AG2LOyrQueKciAAK16qyQJ1SrYiIbOzz7aN7t0koOPy
 jcRMTC+puTLpcOxN6LZY13gUYkylHOSJiO2y+aSAjqzf8nHbRplnGcbE1
 yKjIdbwhcs6ym6nwPp9+XzaNgKbH5Q815TKw7XVpAtt98kpvQ5+ou91mw
 gnipvRJBeHMLSpozD73tkppFbMgpOvsO7M/MH7cIvzbhu7ritLSkMsAG5
 UfCmw5kzqqquypU4utGID4QuSZfu0LxPlqmRcAdgnmNXn6luKSG63J0UH
 O8Bf9yyGb82E9dPDJYPO1ytOjA89axcL6AEcmst2ewhV1glqgxCHqVlFf Q==;
X-CSE-ConnectionGUID: eznosEJfQ3eySVaBxkcYyQ==
X-CSE-MsgGUID: vOiuglDSQJCdSeZ+Eb7mWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74973140"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74973140"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:27 -0700
X-CSE-ConnectionGUID: /y5uuFuSSvurW3TIUsBOpg==
X-CSE-MsgGUID: qznoJMPEQ9ee7gu6YSjcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="260184985"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO fedora)
 ([10.245.245.163])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:25 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/ttm: Avoid invoking the OOM killer when reading
 back swapped content
Date: Tue, 17 Mar 2026 15:18:55 +0100
Message-ID: <20260317141856.237876-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
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

In situations where the system is very short on RAM, the shmem
readback from swap-space may invoke the OOM killer.

However, since this might be a recoverable situation where the caller
is indicating this by setting
struct ttm_operation_ctx::gfp_retry_mayfail to true, adjust the gfp
value used by the allocation accordingly.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/ttm/ttm_backup.c | 6 ++++--
 drivers/gpu/drm/ttm/ttm_pool.c   | 5 ++++-
 include/drm/ttm/ttm_backup.h     | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 6bd4c123d94c..81df4cb5606b 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -44,18 +44,20 @@ void ttm_backup_drop(struct file *backup, pgoff_t handle)
  * @dst: The struct page to copy into.
  * @handle: The handle returned when the page was backed up.
  * @intr: Try to perform waits interruptible or at least killable.
+ * @additional_gfp: GFP mask to add to the default GFP mask if any.
  *
  * Return: 0 on success, Negative error code on failure, notably
  * -EINTR if @intr was set to true and a signal is pending.
  */
 int ttm_backup_copy_page(struct file *backup, struct page *dst,
-			 pgoff_t handle, bool intr)
+			 pgoff_t handle, bool intr, gfp_t additional_gfp)
 {
 	struct address_space *mapping = backup->f_mapping;
 	struct folio *from_folio;
 	pgoff_t idx = ttm_backup_handle_to_shmem_idx(handle);
 
-	from_folio = shmem_read_folio(mapping, idx);
+	from_folio = shmem_read_folio_gfp(mapping, idx, mapping_gfp_mask(mapping)
+					  | additional_gfp);
 	if (IS_ERR(from_folio))
 		return PTR_ERR(from_folio);
 
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 8fa9e09f6ee5..aa41099c5ecf 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -530,6 +530,8 @@ static int ttm_pool_restore_commit(struct ttm_pool_tt_restore *restore,
 		p = first_page[i];
 		if (ttm_backup_page_ptr_is_handle(p)) {
 			unsigned long handle = ttm_backup_page_ptr_to_handle(p);
+			gfp_t additional_gfp = ctx->gfp_retry_mayfail ?
+				__GFP_RETRY_MAYFAIL | __GFP_NOWARN : 0;
 
 			if (IS_ENABLED(CONFIG_FAULT_INJECTION) && ctx->interruptible &&
 			    should_fail(&backup_fault_inject, 1)) {
@@ -543,7 +545,8 @@ static int ttm_pool_restore_commit(struct ttm_pool_tt_restore *restore,
 			}
 
 			ret = ttm_backup_copy_page(backup, restore->alloced_page + i,
-						   handle, ctx->interruptible);
+						   handle, ctx->interruptible,
+						   additional_gfp);
 			if (ret)
 				break;
 
diff --git a/include/drm/ttm/ttm_backup.h b/include/drm/ttm/ttm_backup.h
index c33cba111171..29b9c855af77 100644
--- a/include/drm/ttm/ttm_backup.h
+++ b/include/drm/ttm/ttm_backup.h
@@ -56,7 +56,7 @@ ttm_backup_page_ptr_to_handle(const struct page *page)
 void ttm_backup_drop(struct file *backup, pgoff_t handle);
 
 int ttm_backup_copy_page(struct file *backup, struct page *dst,
-			 pgoff_t handle, bool intr);
+			 pgoff_t handle, bool intr, gfp_t additional_gfp);
 
 s64
 ttm_backup_backup_page(struct file *backup, struct page *page,
-- 
2.53.0

