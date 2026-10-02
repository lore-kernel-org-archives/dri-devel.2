Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487CBCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B7510F026;
	Fri,  2 Oct 2026 07:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvjsSOgY";
	dkim-atps=neutral
Received: from mail-dy2-f21.google.com (mail-dy2-f21.google.com
 [74.125.229.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEC110F026
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:31:14 +0000 (UTC)
Received: by mail-dy2-f21.google.com with SMTP id
 5a478bee46e88-33e46a156f4so4235502eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790926274; x=1791531074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xsLYGjShPtiiH52PUv85LU1cMxKjqepVYNFiRNQ0vZw=;
 b=IvjsSOgYXr5Hqn51LqW/SBUTBk1jeJ40ECfksXwACcL8fwKhitfF8/BMoyXlM6aghL
 RkmCApeV5ATdm4ICqzLTakRa+yY2vC60r5PmgZ0y9nhg8T95zbG9+NB9tGRqKsMWDXjc
 unVuvPwB43uc2ezt+XOAPEihkXYgyANJn+ZfbgNhG1PvZ9VPqwFaVn2ztHf/sEBcDvq+
 WvgWF8hBP2zueIQyq7Pkyty61OhyP3M8BaTzyQ4PoP/83efZx0wniUC9swBFZWStaip4
 t+9MUMfHvkXc+U87F3eCvvRIlLEIJ6gUhw2rsaOlrys+0xhvnYp9tCpMu6rXBF/vEx83
 TETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926274; x=1791531074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xsLYGjShPtiiH52PUv85LU1cMxKjqepVYNFiRNQ0vZw=;
 b=1TqKxWLJXLzWGCbtpAh8N9dld1kPqyV5xuxuEXuPEtTkQuJ5en4jX5AiJuXVQT2ogl
 J0TySTUEsp12alhb8QMuJOomNvlrsqOtjSkywbBqzq2/+rKX87lcYx1ANgNpaSGskj8C
 5bYPRpA7wM7ZJkaeJFXa1FCEgVv85gxfEfsxh0+/OBxBCqWjtxsfPtRaAkP4Nr+tCsWm
 WFHJsNrLlHm+XGtL9ZP9qO0Sw0RsLRITnWD8srYCPQTkq8QcvlRC94qX6dneue5G8J53
 vSkJGKcjQ//EcfxYjWUUOVxt86j0fUV0CnsrENw2Zio8OZTr6j+BXw7X4+JC4kjQhV59
 K/uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxMEdu9KsrUi1RW4aps+XdAC1plwinaTAfNwbZFoWhD0LDR/SxgsEXHXegy0iDONYxlFXE1gBGoZk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLsSrOYdllkzJqOZj2oTRrxdL6+lYsWkBIv5ZBYZePPCQcdveQl
 2XE5PvcBkTXywA1vSEXYvzwWR2jFGDBNdJrkjR3lZIO/eumUUsR9HLXo
X-Gm-Gg: AYBFou3qc85KA7eQ+EWNwbh6aaIveO19ZFzwXGrFey/lEESzPbEp0JD0Hk1qPG9so9q
 OWIG2F26wJ2k6pInM/+Gl7UAHjOQ6+oipzm7hTRLiDLZTavXx/+cySrYBiMdensHhPOLvzueR8A
 vweXbyeNPX+pRDBSCp3A6z7UFv1zVPPPRPH3hfIgP/KKPpKgXa7bPY2hKLH6QTBivV7kF3DebNA
 7Lxo8lpwnmTKgWiMYtKzKxITV61LFdV5sttDq3Dc2BugUk0FisdvnxTBDTox+XFUxrrWQgrGf0I
 YOuOY2VbdL0f++Xpn/pVHf9xC0tP+N9ltKYzmZC4TVxx69LiTePlMGoMNU6KracLq1MeVfKalRw
 NQniBXFZB39YS/cUdi7y4cOLXPla814FdnGNn4Z5hOLphPwL14rrCbNGMGQ1ihaeCEOzLIbW/mN
 fSxol9/J0O8QZQ+XC/xTHkBlb1NOjodO6HHsYN9ux5BQUA3eTeQwVo5xM9oYi/xk/zQ1UrrMSPw
 xE+mixlW6ZZ3gyZhOw4q5na/gz8lp7AunUHDiFyVwVS1BWJ6SEWzmv4mujHHEgB3yDM7LLusDZD
 Qu9Em2uJhGwS5aJFcRbR+SDGVBv5RyZD1ecCj3kR23JgRiBk+y3h30n4zm8=
X-Received: by 2002:a05:7301:1a11:b0:327:c036:1c7a with SMTP id
 5a478bee46e88-34f15077dcfmr1779187eec.10.1790926272837; 
 Fri, 02 Oct 2026 00:31:12 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fdb478sm3912341eec.22.2026.10.02.00.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:31:12 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Andi Shyti <andi.shyti@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/i915: look up shmem folios by index for writeback
Date: Fri,  2 Oct 2026 15:31:07 +0800
Message-ID: <20261002073107.2209644-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
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

Since commit 776a853a43c9 ("i915: Use writeback_iter()"),
__shmem_writeback() starts writeback on no folios at all.  In
WB_SYNC_NONE mode writeback_iter() only returns folios tagged
PAGECACHE_TAG_DIRTY, and shmem never sets that tag: it dirties folios
with noop_dirty_folio(), because shmem relies on LRU-based swap writeout
rather than on the dirty tag (see the comment in __folio_mark_dirty() in
mm/page-writeback.c).  The loop before that commit looked pages up by
index and tested the page dirty flag, so it did write.

This affects the shrinker's I915_SHRINK_WRITEBACK pass and the i915 TTM
backend, which both call __shmem_writeback().  The pages stay dirty and
on the LRU, so reclaim still swaps them out later; what is lost is the
early writeback.

Go back to walking the object by index, with the folio API.  Mapped
folios are still skipped.  Unlike the old loop, do not wait for a folio
lock, since this also runs from the OOM notifier; a locked folio is left
to reclaim.  shmem_write_folio() returns with the folio unlocked except
for AOP_WRITEPAGE_ACTIVATE, so unlock it only in that case.  It may
also split a large folio, so read the folio size only after writing, to
find the next index.

I came across this while measuring an earlier patch of mine to this
loop, which changed nothing because the loop never visits a folio.
This patch was measured without Intel hardware, with a test-only mock
selftest in a QEMU guest with swap.  Dirty, unpinned objects of 1 to
256 MiB, with and without THP, went through i915_gem_shrink() with
I915_SHRINK_WRITEBACK.  Before this patch, no page was written in any
case; with it, every page that was not mmapped was.  The contents read
back intact after swap-in, and the mock selftests give the same results
as before.  This has not been tested on hardware.

Fixes: 776a853a43c9 ("i915: Use writeback_iter()")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This replaces my two earlier patches to this loop, which can be dropped:
the loop they change never visits a folio.

https://lore.kernel.org/all/20260915062924.2410550-1-matthias.goergens@gmail.com/
https://lore.kernel.org/all/20260914105606.3997649-1-matthias.goergens@gmail.com/

In 6.18.y and 7.2.y the call is shmem_writeout(folio, NULL, NULL)
instead of shmem_write_folio(folio), with the same return convention.

In review of 776a853a43c9, Christoph asked for this loop to move behind
a shmem API instead of living in drivers, and Matthew agreed:

https://lore.kernel.org/all/Z--XtaM7Z3zbjzAu@infradead.org/
https://lore.kernel.org/all/Z-_hQwNeiOnNYJVp@casper.infradead.org/

I kept this fix inside i915 so that it is one patch for stable.

The test harness is not part of the patch; I can post it if that helps.
Testing on Intel hardware under memory pressure would be very welcome.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 56 ++++++++++++++++++-----
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ef9440166295..54424e434f3b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -304,28 +304,60 @@ shmem_truncate(struct drm_i915_gem_object *obj)
 	return 0;
 }
 
+/* Start writing a locked folio to swap.  It is unlocked on return. */
+static void shmem_writeback_folio(struct folio *folio)
+{
+	int ret;
+
+	folio_set_reclaim(folio);
+	ret = shmem_write_folio(folio);
+	if (!folio_test_writeback(folio))
+		folio_clear_reclaim(folio);
+
+	/* shmem_write_folio() unlocks the folio unless it returns this. */
+	if (ret == AOP_WRITEPAGE_ACTIVATE)
+		folio_unlock(folio);
+}
+
 void __shmem_writeback(size_t size, struct address_space *mapping)
 {
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_NONE,
-		.nr_to_write = SWAP_CLUSTER_MAX,
-		.range_start = 0,
-		.range_end = LLONG_MAX,
-	};
-	struct folio *folio = NULL;
-	int error = 0;
+	pgoff_t nr_pages = size >> PAGE_SHIFT;
+	pgoff_t index = 0;
 
 	/*
+	 * shmem marks folios dirty with noop_dirty_folio(), which does not
+	 * set PAGECACHE_TAG_DIRTY, so writeback_iter() would find none of
+	 * them.  Look up each folio of the object by index and test its
+	 * dirty flag.
+	 *
 	 * Leave mmapings intact (GTT will have been revoked on unbinding,
 	 * leaving only CPU mmapings around) and add those folios to the LRU
 	 * instead of invoking writeback so they are aged and paged out
 	 * as normal.
 	 */
-	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
-		if (folio_mapped(folio))
-			folio_redirty_for_writepage(&wbc, folio);
+	while (index < nr_pages) {
+		struct folio *folio;
+
+		/*
+		 * Skip folios that are absent or locked: this runs from the
+		 * shrinker and the OOM notifier, so do not wait for a lock.
+		 */
+		folio = __filemap_get_folio(mapping, index,
+					    FGP_LOCK | FGP_NOWAIT, 0);
+		if (IS_ERR(folio)) {
+			index++;
+			continue;
+		}
+
+		index = folio->index;
+		if (!folio_mapped(folio) && folio_clear_dirty_for_io(folio))
+			shmem_writeback_folio(folio);
 		else
-			error = shmem_write_folio(folio);
+			folio_unlock(folio);
+
+		/* Writing may have split the folio, so read its size only now. */
+		index += folio_nr_pages(folio);
+		folio_put(folio);
 	}
 }
 

base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
-- 
2.56.0

