Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA66C44515
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1958710F9DE;
	Sat, 11 Jul 2026 02:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c581oboN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378E610E70D;
 Sat, 11 Jul 2026 02:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738594; x=1815274594;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hYd1Lq30qlGWAVOQ06EYvQko8gF54W6NPuSPx63DMGI=;
 b=c581oboNFBdkltpuDQg7pf2fhI6RgKT8VXfJaCDHQ01VqfxEgNelLHL7
 ZvO7H3CeTH5OmQXgLJJ/coq1IhI/kWTb2All6sSV14IQmHO/4uuT6zZKu
 n0MV5ZmrhbYq1+sgNeHzeL/FWFw8DtdVHoI1+QY4iy+L2/TqyhZxAyggO
 bD9dO8zsmvYgn/xjpJuJD7QRc6jIlUVx3XyeWxrbs94+O5F2PX0mWSdA5
 NNcgrfq9qpvLU06kZvaXCid7h3moNyapJl2TwEMdn5cPwQMbj+TOLg38D
 XO9kbNhH8zJdtyVty07J9ctGPIBmiHftxjofCNUlmmTP92TzI7hy/n17Q g==;
X-CSE-ConnectionGUID: aNx3+VsMTwCNLidH2FiMkQ==
X-CSE-MsgGUID: AR7InXK6Q1O/U9j5m799jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986390"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986390"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:34 -0700
X-CSE-ConnectionGUID: bxrgIos8Rs2wyvyuQ1nZIw==
X-CSE-MsgGUID: 0Eu8f0BjSp+oQB9faBuJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987796"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 30/33] drm/xe: Add packed copy-step IOVA mapping for defrag
Date: Fri, 10 Jul 2026 19:56:16 -0700
Message-Id: <20260711025619.2540575-31-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

Add machinery to map only changed pages during defrag when the
destination TT is IOVA-mapped. Only the non-borrowed (freshly
allocated) pages need copying; borrowed pages are aliases from
the old TT.

Add xe_tt_iova_copy_init() to diff new vs old TT folios and
record changed-page runs. Add xe_tt_map_iova_copy() to link
those changed pages packed contiguously at the front of the
new TT's IOVA reservation, synced and ready for GPU blits.

No users yet; wired up in later patches.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 364 +++++++++++++++++++++++++++++++++++++
 1 file changed, 364 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index c5022c16411f..c087f17ad6db 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -531,6 +531,31 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
 		}
 	}
 }
+
+/*
+ * xe_tt_account_iova_pages - account a tt's pages from a full folio walk
+ * @xe: the xe device
+ * @xe_tt: the xe_ttm_tt to account (its @iova_dma_pages must start zeroed)
+ *
+ * Walk @xe_tt's pages one folio at a time (the same head-page order walk used
+ * by xe_tt_map_iova()) and account each into xe->mem.dma_mapped_pages[] and
+ * @xe_tt->iova_dma_pages[]. Used to (re)derive accounting that exactly matches
+ * the pages a tt is actually mapped with.
+ */
+__maybe_unused
+static void xe_tt_account_iova_pages(struct xe_device *xe,
+				     struct xe_ttm_tt *xe_tt)
+{
+	struct ttm_tt *tt = &xe_tt->ttm;
+	unsigned long i = 0;
+
+	while (i < tt->num_pages) {
+		unsigned int order = ttm_pool_page_order_nodma(tt->pages[i]);
+
+		xe_tt_account_iova_add(xe, xe_tt, order);
+		i += 1UL << order;
+	}
+}
 #else
 static void xe_tt_account_iova_add(struct xe_device *xe,
 				   struct xe_ttm_tt *xe_tt, unsigned int order)
@@ -541,6 +566,12 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
 				 struct xe_ttm_tt *xe_tt)
 {
 }
+
+__maybe_unused
+static void xe_tt_account_iova_pages(struct xe_device *xe,
+				     struct xe_ttm_tt *xe_tt)
+{
+}
 #endif
 
 static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
@@ -714,6 +745,339 @@ void xe_res_first_tt(struct ttm_tt *tt, u64 start, u64 size,
 		xe_res_first_sg(xe_tt->sg, start, size, cur);
 }
 
+/**
+ * struct xe_tt_iova_run - A contiguous run of changed pages in a defrag move
+ * @start: First page offset (natural ttm_tt index) of the run.
+ * @count: Number of pages in the run.
+ *
+ * Runs are folio aligned: defrag borrows whole beneficial-order chunks, so a
+ * folio is either entirely borrowed (unchanged) or entirely freshly allocated
+ * (changed), never split across the boundary.
+ */
+struct xe_tt_iova_run {
+	pgoff_t start;
+	pgoff_t count;
+};
+
+/**
+ * struct xe_tt_iova_link - A snapshot folio link descriptor for defrag relink
+ * @phys: Physical address of the folio's head page.
+ * @offset: Natural byte offset into the reservation to link the folio at.
+ * @len: Byte length of the folio (PAGE_SIZE << order).
+ *
+ * Captured at copy-init time while the destination tt's page array is valid and
+ * stable under the BO lock. The post-copy finalize job runs asynchronously,
+ * after TTM may have mutated (or torn down) the destination tt page array, so
+ * it relinks purely from these snapshots and never dereferences that array.
+ */
+struct xe_tt_iova_link {
+	phys_addr_t phys;
+	size_t offset;
+	size_t len;
+};
+
+/**
+ * struct xe_tt_iova_copy - Changed-page subset of an IOVA defrag move
+ * @runs: Array of changed-page runs, in ascending natural tt offset.
+ * @nr_runs: Number of entries in @runs.
+ * @links: Per-folio link snapshots covering the changed runs, in ascending
+ *         natural offset. Drives the asynchronous finalize relink so it never
+ *         touches the destination tt's (possibly mutated) page array.
+ * @nr_links: Number of entries in @links.
+ * @nr_changed: Total number of changed pages (sum of the run counts). This is
+ *              also the size, in pages, of the packed copy-step IOVA mapping
+ *              produced by xe_tt_map_iova_copy().
+ */
+struct xe_tt_iova_copy {
+	struct xe_tt_iova_run *runs;
+	unsigned int nr_runs;
+	struct xe_tt_iova_link *links;
+	unsigned int nr_links;
+	pgoff_t nr_changed;
+};
+
+/*
+ * xe_tt_iova_walk_changed - Walk a defrag move's changed-page runs.
+ *
+ * Iterate @new_tt one folio at a time (folio order read from TTM via
+ * ttm_pool_page_order_nodma()) and compare each folio's head page against
+ * @old_tt at the same natural offset. Pages the new backing borrowed from the
+ * old tt alias the same struct page and are unchanged; freshly allocated pages
+ * differ. Coalesce contiguous changed folios into runs and, for each run,
+ * invoke @fn. Returns the total number of changed pages.
+ */
+__maybe_unused
+static pgoff_t xe_tt_iova_walk_changed(struct ttm_tt *new_tt,
+				       struct ttm_tt *old_tt,
+				       void (*fn)(pgoff_t start, pgoff_t count,
+						  void *arg),
+				       void *arg)
+{
+	pgoff_t i = 0, n = new_tt->num_pages;
+	pgoff_t run_start = 0, nr_changed = 0;
+	bool in_run = false;
+
+	while (i < n) {
+		unsigned int order = ttm_pool_page_order_nodma(new_tt->pages[i]);
+		pgoff_t nr = 1UL << order;
+		bool changed = new_tt->pages[i] != old_tt->pages[i];
+
+		if (changed) {
+			if (!in_run) {
+				run_start = i;
+				in_run = true;
+			}
+			nr_changed += nr;
+		} else if (in_run) {
+			if (fn)
+				fn(run_start, i - run_start, arg);
+			in_run = false;
+		}
+
+		i += nr;
+	}
+
+	if (in_run && fn)
+		fn(run_start, n - run_start, arg);
+
+	return nr_changed;
+}
+
+struct xe_tt_iova_run_collect {
+	struct ttm_tt *new_tt;
+	struct xe_tt_iova_run *runs;
+	unsigned int nr_runs;
+	unsigned int runs_cap;
+	struct xe_tt_iova_link *links;
+	unsigned int nr_links;
+	unsigned int links_cap;
+	int err;
+};
+
+/* Geometrically grow @arr (element size @elem) to hold at least @need slots. */
+__maybe_unused
+static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
+			   size_t elem)
+{
+	unsigned int new_cap;
+	void *p;
+
+	if (need <= *cap)
+		return 0;
+
+	new_cap = *cap ? *cap * 2 : 64;
+	if (new_cap < need)
+		new_cap = need;
+
+	p = krealloc_array(*arr, new_cap, elem, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	*arr = p;
+	*cap = new_cap;
+	return 0;
+}
+
+__maybe_unused
+static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
+{
+	struct xe_tt_iova_run_collect *c = arg;
+	pgoff_t i = start, end = start + count;
+
+	if (c->err)
+		return;
+
+	if (xe_tt_iova_grow((void **)&c->runs, &c->runs_cap, c->nr_runs + 1,
+			    sizeof(*c->runs))) {
+		c->err = -ENOMEM;
+		return;
+	}
+	c->runs[c->nr_runs].start = start;
+	c->runs[c->nr_runs].count = count;
+	c->nr_runs++;
+
+	while (i < end) {
+		struct page *page = c->new_tt->pages[i];
+		unsigned int order = ttm_pool_page_order_nodma(page);
+
+		if (xe_tt_iova_grow((void **)&c->links, &c->links_cap,
+				    c->nr_links + 1, sizeof(*c->links))) {
+			c->err = -ENOMEM;
+			return;
+		}
+		c->links[c->nr_links].phys = page_to_phys(page);
+		c->links[c->nr_links].offset = (size_t)i << PAGE_SHIFT;
+		c->links[c->nr_links].len = PAGE_SIZE << order;
+		c->nr_links++;
+
+		i += 1UL << order;
+	}
+}
+
+/**
+ * xe_tt_iova_copy_init() - Compute the changed-page subset of a defrag move
+ * @new_tt: The freshly (re)allocated destination tt.
+ * @old_tt: The stashed source tt (bo->defrag_old_tt).
+ * @copy: Output description of the changed pages.
+ *
+ * Diff @new_tt against @old_tt and record the runs of changed (non-borrowed)
+ * pages into @copy, along with a per-folio snapshot of their physical
+ * addresses, natural offsets and lengths. The result drives both the packed
+ * copy-step IOVA mapping (xe_tt_map_iova_copy()) and the post-copy finalize
+ * that relinks the new backing into the IOVA reservation. The finalize runs
+ * asynchronously, after TTM may have mutated @new_tt->pages, so it consumes the
+ * snapshot rather than re-reading the page array. @new_tt and @old_tt must
+ * describe the same BO (equal num_pages) and both be populated.
+ *
+ * The caller owns @copy and must release it with xe_tt_iova_copy_fini().
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+__maybe_unused
+static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
+				struct xe_tt_iova_copy *copy)
+{
+	struct xe_tt_iova_run_collect c = { .new_tt = new_tt };
+
+	memset(copy, 0, sizeof(*copy));
+
+	/*
+	 * Single pass: collect the changed runs and per-folio link snapshots
+	 * directly, growing the arrays on demand. Changed runs are few (the
+	 * borrowed majority is skipped), so the geometric reallocs are rare and
+	 * this avoids a second full O(num_pages) walk just to size the arrays.
+	 */
+	copy->nr_changed = xe_tt_iova_walk_changed(new_tt, old_tt,
+						   xe_tt_iova_store_run, &c);
+	if (c.err) {
+		kfree(c.runs);
+		kfree(c.links);
+		return c.err;
+	}
+	if (!c.nr_runs)
+		return 0;
+
+	copy->runs = c.runs;
+	copy->nr_runs = c.nr_runs;
+	copy->links = c.links;
+	copy->nr_links = c.nr_links;
+
+	return 0;
+}
+
+/**
+ * xe_tt_iova_copy_fini() - Release a struct xe_tt_iova_copy
+ * @copy: The copy description to release.
+ */
+__maybe_unused
+static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
+{
+	kfree(copy->runs);
+	kfree(copy->links);
+	copy->runs = NULL;
+	copy->links = NULL;
+	copy->nr_runs = 0;
+	copy->nr_links = 0;
+	copy->nr_changed = 0;
+}
+
+/**
+ * xe_tt_map_iova_copy() - DMA map the changed-page subset for a defrag copy
+ * @xe: The xe device.
+ * @new_tt: The destination tt (must be IOVA eligible, use_iova == true).
+ * @copy: The changed-page description from xe_tt_iova_copy_init().
+ *
+ * Link only the changed pages of @new_tt into its IOVA reservation, packed
+ * contiguously at the front of the range ([0, @copy->nr_changed) pages). This
+ * provides a compact, contiguous destination for the GPU defrag copy without
+ * mapping the (majority) borrowed pages, and lets the whole temporary mapping
+ * later be torn down with a single dma_iova_destroy().
+ *
+ * The reservation's remaining tail is left unlinked. This does not establish
+ * the tt's final mapping (@iova_linked stays false); the post-copy finalize is
+ * responsible for that.
+ *
+ * Return: 0 on success, negative error code on failure (any partial linkage is
+ * unwound).
+ */
+__maybe_unused
+static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
+			       const struct xe_tt_iova_copy *copy)
+{
+	struct xe_ttm_tt *xe_tt = container_of(new_tt, struct xe_ttm_tt, ttm);
+	struct device *dev = xe->drm.dev;
+	size_t mapped = 0;
+	unsigned int r;
+	int ret;
+
+	xe_assert(xe, xe_tt->use_iova);
+	xe_assert(xe, !xe_tt->iova_linked);
+
+	for (r = 0; r < copy->nr_runs; r++) {
+		pgoff_t i = copy->runs[r].start;
+		pgoff_t end = i + copy->runs[r].count;
+
+		while (i < end) {
+			struct page *page = new_tt->pages[i];
+			unsigned int order = ttm_pool_page_order_nodma(page);
+			size_t len = PAGE_SIZE << order;
+
+			ret = dma_iova_link(dev, &xe_tt->iova,
+					    page_to_phys(page), mapped, len,
+					    DMA_BIDIRECTIONAL,
+					    DMA_ATTR_SKIP_CPU_SYNC);
+			if (ret)
+				goto err_unlink;
+
+			mapped += len;
+			i += 1UL << order;
+		}
+	}
+
+	ret = dma_iova_sync(dev, &xe_tt->iova, 0, mapped);
+	if (ret)
+		goto err_unlink;
+
+	return 0;
+
+err_unlink:
+	if (mapped)
+		dma_iova_unlink(dev, &xe_tt->iova, 0, mapped,
+				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+	return ret;
+}
+
+/*
+ * xe_tt_iova_transfer - Transfer a full IOVA reservation old_tt -> new_tt.
+ *
+ * Move the (fully linked) IOVA reservation from the old tt to the new tt,
+ * leaving the old tt without a reservation so its destroy path does not double
+ * free. The new tt keeps its existing reservation snapshotted in the finalize
+ * job for teardown. Called at the defrag finalize job's point of no failure.
+ *
+ * Also rebalance the per-order DMA-page accounting: drop the old tt's
+ * accounting and account the pages the new tt actually ends up mapped with.
+ * The finalize relink leaves the new tt's mapping equal to new_tt->pages
+ * (borrowed pages alias the old tt; changed runs use the new pages, which may
+ * have a different order distribution), so deriving the accounting from a full
+ * folio walk of the new tt keeps xe->mem.dma_mapped_pages[] exact while the new
+ * mapping lives, rather than carrying the old tt's stale distribution.
+ */
+__maybe_unused
+static void xe_tt_iova_transfer(struct xe_device *xe,
+				struct xe_ttm_tt *new_tt,
+				struct xe_ttm_tt *old_tt)
+{
+	new_tt->iova = old_tt->iova;
+	new_tt->iova_linked = true;
+
+	xe_tt_unaccount_iova(xe, old_tt);
+	xe_tt_account_iova_pages(xe, new_tt);
+
+	old_tt->iova_linked = false;
+	old_tt->use_iova = false;
+}
+
 /*
  * Account ttm pages against the device shrinker's shrinkable and
  * purgeable counts.
-- 
2.34.1

