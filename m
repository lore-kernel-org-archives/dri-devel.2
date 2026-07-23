Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF11C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E92110EFAE;
	Thu, 23 Jul 2026 06:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="nGFeH2q9";
	dkim-atps=neutral
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B25810EFAE
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:47:17 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784789224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ei6WH7j/Rd5ujPseL0Qyo0hJQuI83ztbNpCUwfAke+o=;
 b=nGFeH2q9NPC13eOROsQ1BqaRcc8yOYnyYPtZGPbx3QSrUdn0S+Ve3dEUwN2bTELDHvj95Q
 9NCjK46zDekQSKKhAOIIPC/Q4UBFYj57hUM7BO8QH1XZoq8p06xLynZXmdRdk4shFJdJoC
 RXmHGAUuk1yLIEjsXnQ9Ofbq9VsWwQs=
From: Hongfu Li <hongfu.li@linux.dev>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, kees@kernel.org, tzimmermann@suse.de
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, hongfu.li@linux.dev,
 Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] drm/i915/userptr: Convert page APIs to folio equivalents in
 put_pages
Date: Thu, 23 Jul 2026 14:46:51 +0800
Message-ID: <20260723064651.4100-1-hongfu.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Hongfu Li <lihongfu@kylinos.cn>

Cache the folio with page_folio() at the start of the sg_table loop,
then use folio helpers directly to eliminate repeated compound_head()
lookups inside page API wrappers.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 043095f93ac6..0ae68c52cc12 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -160,6 +160,7 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
 			   struct sg_table *pages)
 {
 	struct sgt_iter sgt_iter;
 	struct page *page;
+	struct folio *folio;
 
 	if (!pages)
@@ -177,7 +178,9 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
 		obj->mm.dirty = false;
 
 	for_each_sgt_page(page, sgt_iter, pages) {
-		if (obj->mm.dirty && trylock_page(page)) {
+		folio = page_folio(page);
+
+		if (obj->mm.dirty && folio_trylock(folio)) {
 			/*
 			 * As this may not be anonymous memory (e.g. shmem)
 			 * but exist on a real mapping, we have to lock
@@ -193,14 +196,14 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
 			 * on the folio. Such a try_to_unmap() will result
 			 * in us calling put_pages() and so recursively try
 			 * to lock the page. We avoid that deadlock with
-			 * a trylock_page() and in exchange we risk missing
+			 * a folio_trylock() and in exchange we risk missing
 			 * some page dirtying.
 			 */
-			set_page_dirty(page);
-			unlock_page(page);
+			folio_mark_dirty(folio);
+			folio_unlock(folio);
 		}
 
-		mark_page_accessed(page);
+		folio_mark_accessed(folio);
 	}
 	obj->mm.dirty = false;
 
-- 
2.54.0

