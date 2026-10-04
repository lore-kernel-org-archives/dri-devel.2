Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA026CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50EA10E113;
	Sun,  4 Oct 2026 09:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a355yBC4";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0220710E113
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 09:48:32 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34bffc8105eso1009148eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791107312; x=1791712112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G/M/uzbIn435hHdgJL6sjcq8jBzkdOxqOZH69iw0GIc=;
 b=a355yBC4E0xu+eiyzlZHQ9LI9x2UPeAshb8/oJ0EETZ/la08Zw30m1xEEZK9INNbz+
 iKhI29K+R0BetNVN+HK/M0VIyJMwdtV3KR94MTfOHNYJnwECBrBSBN5Z7yQERSFyJARq
 9t4WEnjLhEVl42PN5Kwxst6Zwl35vtlx7BWOT4yLvwjWAGEORQD0K+HsPd9yrZwztsvB
 fi915y/y901foFS3AFJ7mmcEp/mK5Okc1UMcJe0fhEP0A3uCS3nqTWkhDAyV2hazQ4pr
 R2CqxQvWXg51sPcvGitXan1MW1rXz1wEenrJTV+IWv1YkViMjEiV+XDLrYL4QC3+iAaA
 fNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791107312; x=1791712112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G/M/uzbIn435hHdgJL6sjcq8jBzkdOxqOZH69iw0GIc=;
 b=JJRUP7o9EaosCjdUdlqBYFJFvJFhXLI1sDTioVS9X6RPElEZcFjyvhq/uixBqFUwl3
 U+ydMOleKzpe2zMW815ROfSznsud8d8WrlO1nvHI2nF1XhuM0PZNTwleu/kW/HcDzcWg
 CXu7VkB5afiBMRfdQFfbaI3opWxdzRaWVD6Igj+pQtD5t1nr3BrFP5ITh/k2OQXx9VtH
 taQBLt8A/4S5pbri4CTXrQCT+CZxKrDXMNlXasFgY7XnGY6wnmWh1IUbTUF5wHNdwOSn
 xLCArT9DS6WTV6Kc8/8Pe8bsnQ6kUzrk3N6qn73wLfLPZscdT16QneIH1M28J1YuY1Xk
 KREQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwE24RXhUrogtpqksXgu+fCNWY46s3fL9u6Xiu98R713sDB4C2lB6IPb/BLkUB252o9oi4pP2dRAA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKhuhkwj2JOqNktwFv6oXBlml1Ok6olihMdiUY31bxneQ1N48gZ
 2x64QazJeUK7yhKNcExLz8fZ4PLHsYQRKa7XCVdkVs3GPmcPMLbJBAFn
X-Gm-Gg: AYBFou2fb8ZunTBUts2PXBBj+BX2xvXiQb6BX4p5pRumy1tM/CzUDq0WbUk6uT0jHUt
 zW1AvU4stsk0YsilmRJJy1E3QTMEy1Mno1AQKxAeWariq7cRo2MfIvT/QZiw3goo9bM19IlBnCP
 2ndIUoqwrw3xM7GyprIfgb4y+O1xqB2leJ+NZIQQcvqvzAGznm2/APEwc3Fr6aLbG/Q00PgSOrG
 l2W3GuV8rd7EEmIEIDk2Szrb4TQQ8+b8qJm+YjVpR0D+9+mt3f8A685rc/Vh3/be2KlR33tjac4
 w9NUmFbY0bF4usQYaJNv27+GUyg5qW3OwmD9+voJ+1waHw0Wc8iEdjZfgFtMJMGD0v9wsyKQhpW
 K7ainzzutq9PP8jCQCIgiB4GSOZNlmYGSAI6RhHMMoViRwYoocs6tHcel6FPuxS9cvvU7eCLiwQ
 BnxictIQX0AJ9MOVKvvYW/U2SEMbMStP8gbiKQix4rzeLKDXmbNzpwSQHLBxqygDWgs6gyTU6rc
 EBQpH4Kgcn7S8AQDFOjiLSpebnE03WbnuA+oKeaCrIvUiqQhg2i9HnbzBeXkJ/2+vZ27afsLckQ
 367mAlHHmxoKQgQ+hYh+Zyw6db/tWqzNEibDT/l8RQYyoAnNA/h8Jvbdaas=
X-Received: by 2002:a05:693c:87d5:10b0:34b:e2cf:43b6 with SMTP id
 5a478bee46e88-34f14f2b9edmr9396416eec.2.1791107311900; 
 Sun, 04 Oct 2026 02:48:31 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127136b8esm3623589eec.6.2026.10.04.02.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 02:48:31 -0700 (PDT)
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
Subject: [PATCH v2] drm/i915: look up shmem folios by index for writeback
Date: Sun,  4 Oct 2026 17:48:27 +0800
Message-ID: <20261004094827.174193-1-matthias.goergens@gmail.com>
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

Go back to looking up the folios of the object by index, in batches
with filemap_get_folios(), and reschedule between batches, as
writeback_iter() does.  Mapped folios are still skipped.  Unlike the old
loop, do not wait for a folio lock, since this also runs from the OOM
notifier; a locked folio is left to reclaim.  shmem_write_folio()
returns with the folio unlocked except for AOP_WRITEPAGE_ACTIVATE, so
unlock it only in that case.  It may also split a large folio and leave
the rest of it dirty, so look the rest up again.

I came across this while measuring an earlier patch of mine to this
loop, which changed nothing because the loop never visits a folio.
This patch was measured without Intel hardware, with a test-only mock
selftest in a QEMU guest with swap.  Dirty, unpinned objects of 1 to
256 MiB, with and without THP, went through i915_gem_shrink() with
I915_SHRINK_WRITEBACK.  Before this patch, no page was written in any
case; with it, every page that was not mmapped was, also when swap-out
split the large folios.  The contents read back intact after swap-in,
and the mock selftests give the same results as before.  This has not
been tested on hardware.

Fixes: 776a853a43c9 ("i915: Use writeback_iter()")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
v1: https://lore.kernel.org/all/20261002073107.2209644-1-matthias.goergens@gmail.com/

Changes in v2:
- Look the folios up in batches with filemap_get_folios() and call
  cond_resched() between batches, instead of one __filemap_get_folio()
  call per index with no rescheduling, which Sashiko pointed out:
  https://lore.kernel.org/all/20261002091439.59C611F00899@smtp.kernel.org/
  Measured with the same test-only harness in the same guest, v1 against
  v2: on a fully populated 1 GiB object, the longest time the walk ran
  without reaching cond_resched() went from about 85 ms to under 0.1 ms;
  on a 3 GiB object (786432 pages) with 1% of its pages present and the
  rest holes or swapped out, one call made 255 filemap_get_folios()
  calls instead of 786432 __filemap_get_folio() calls.  A run of swap
  entries is still stepped over inside a single filemap_get_folios()
  call: about 2 ms for a fully swapped-out 3 GiB object.  I did not split
  the range further, since every page of the object was in memory until
  just before this runs, so holes and swap entries are the exception.
- A batch is looked up ahead of the writes, so if writing splits a
  large folio, look the rest of it up again (v1 got this by reading the
  folio size after the write).

This replaces my two earlier patches to this loop, which can be dropped:
the loop they change never visits a folio.

https://lore.kernel.org/all/20260915062924.2410550-1-matthias.goergens@gmail.com/
https://lore.kernel.org/all/20260914105606.3997649-1-matthias.goergens@gmail.com/

In 6.18.y and 7.2.y, the maintained stable trees that have
776a853a43c9, the call is shmem_writeout(folio, NULL, NULL) instead of
shmem_write_folio(folio), with the same return convention.

In review of 776a853a43c9, Christoph asked for this loop to move behind
a shmem API instead of living in drivers, and Matthew agreed:

https://lore.kernel.org/all/Z--XtaM7Z3zbjzAu@infradead.org/
https://lore.kernel.org/all/Z-_hQwNeiOnNYJVp@casper.infradead.org/

I kept this fix inside i915 so that it is one patch for stable.

The test harness is not part of the patch; I can post it if that helps.
Testing on Intel hardware under memory pressure would be very welcome.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 70 ++++++++++++++++++-----
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ef9440166295..d2077b823b1b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -304,28 +304,72 @@ shmem_truncate(struct drm_i915_gem_object *obj)
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
+	pgoff_t last = (size >> PAGE_SHIFT) - 1;	/* last page, inclusive */
+	struct folio_batch fbatch;
+	pgoff_t index = 0;
+	unsigned int i;
 
 	/*
+	 * shmem marks folios dirty with noop_dirty_folio(), which does not
+	 * set PAGECACHE_TAG_DIRTY, so writeback_iter() would find none of
+	 * them.  Look up the folios of the object in batches and write out
+	 * the dirty ones.
+	 *
 	 * Leave mmapings intact (GTT will have been revoked on unbinding,
 	 * leaving only CPU mmapings around) and add those folios to the LRU
 	 * instead of invoking writeback so they are aged and paged out
 	 * as normal.
 	 */
-	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
-		if (folio_mapped(folio))
-			folio_redirty_for_writepage(&wbc, folio);
-		else
-			error = shmem_write_folio(folio);
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(mapping, &index, last, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
+			long nr_pages = folio_nr_pages(folio);
+
+			/*
+			 * Leave locked folios to reclaim: this runs from the
+			 * shrinker and the OOM notifier, so do not wait for a
+			 * lock.
+			 */
+			if (!folio_trylock(folio))
+				continue;
+
+			if (folio->mapping != mapping || folio_mapped(folio) ||
+			    !folio_clear_dirty_for_io(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
+			shmem_writeback_folio(folio);
+
+			/*
+			 * Writing may have split the folio and left the rest
+			 * of it dirty; look the rest up again.
+			 */
+			if (folio_nr_pages(folio) != nr_pages) {
+				index = folio_next_index(folio);
+				break;
+			}
+		}
+		folio_batch_release(&fbatch);
+		cond_resched();
 	}
 }
 

base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
-- 
2.56.0

