Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511C606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3867A10E117;
	Sun,  1 Nov 2026 08:20:35 +0000 (UTC)
X-Greylist: delayed 380 seconds by postgrey-1.36 at gabe;
 Sun, 01 Nov 2026 08:20:33 UTC
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 196FC10E050
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:20:33 +0000 (UTC)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 57F74200A41; Sun,  1 Nov 2026 16:14:09 +0800 (AWST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from shelley.lan (unknown [IPv6:2001:8003:8802:7000::41b])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 2AE6A200A3D;
 Sun,  1 Nov 2026 16:14:06 +0800 (AWST)
From: David Gow <david@davidgow.net>
To: Jim Cromie <jim.cromie@gmail.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: David Gow <david@davidgow.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm_buddy: Fix power-of-two rounding errors
Date: Sun,  1 Nov 2026 16:11:19 +0800
Message-ID: <20261101081121.3273967-2-david@davidgow.net>
X-Mailer: git-send-email 2.56.0
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

The standard roundup_pow_of_two() and rounddown_pow_of_two() macros use
unsigned long internally, which on 32-bit architectures (such as i386 and
arm32) is only 32-bit. Similarly, is_power_of_2() operates on an unsigned
long.

drm_test_buddy_alloc_exceeds_max_order() uses these on a u64 value,
where they silently truncate the 10GB allocation, causing the KUnit tests
to fail:
[17:49:27]     # gpu_test_buddy_alloc_exceeds_max_order: EXPECTATION FAILED at drivers/gpu/tests/gpu_buddy_test.c:1540
[17:49:27]     Expected err == -22, but
[17:49:27]         err == 0 (0x0)
[17:49:27]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:973: gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
[17:49:27]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:978: gpu_buddy_assert(mm->avail == mm->size)
[17:49:27]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:981: gpu_buddy_assert(!mm->used_scoreboard[i])
[17:49:27] # gpu_buddy: pass:13 fail:1 skip:0 total:14

Ultimately, the correct fix here is to make the various power-of-two
functions handle u64 better, but since this is a large treewide change,
provide u64-specific helpers for the buddy allocator, and use these.

Also update the page count ('pages') to be a u64 instead of an unsigned
long, in case this overflows on 32-bit systems. This doesn't actually
trigger the test failure -- and it's very unlikely a 32-bit system will
have enough VRAM to need that many pages -- but it's still theoretically
possible.

Fixes: 14d1b9a6247c ("drm/i915: buddy allocator")
Co-developed-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: David Gow <david@davidgow.net>
---

This began as a rebase of patch 39 of v12 of this series:
https://lore.kernel.org/all/20260326185413.1205870-40-jim.cromie@gmail.com/
previously sent out as v3:
https://lore.kernel.org/all/20260913084907.520877-2-david@davidgow.net/

However, it's had basically a complete rewrite:
- The Fixes tag has been updated to point to the original introduction of
  the buddy allocator. I don't expect this to actually get backported,
  but that was the commit that introduced the various power_of_two uses.
- Instead of open-coding the round{up,down}_pow_of_two implementations,
  we provide our own copies of the functions, adjusted for _u64 support.
  These will be replaced with a tree-wide implementation in a follow-up.
  (Thanks, Dave!)
- The calls to is_power_of_2 are similarly replaced. While these didn't
  cause the test to fail, they're similarly wrong on 32-bit systems.
- The 'page' counts are moved from unsigned long to u64, and code is
  updated accordingly. I think it's incredibly unlikely that we're going
  to see GPUs with enough memory for more than 2^32 _pages_ on a 32-bit
  system, but I can't see any reason it shouldn't theoretically work.
  Let me know if this is a terrible idea, and I'll revert it in the next
  version.

The test failures can be reproduced with:
./tools/testing/kunit/kunit.py run --arch i386 gpu_drm_buddy

(or with any other 32-bit arch. For 32-bit UML, use --arch um --kconfig_add CONFIG_64BIT=n)

Cheers,
-- David


---
 drivers/gpu/buddy.c | 55 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 503f7d5934e4..98764ee786d7 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -36,6 +36,35 @@
 #define gpu_buddy_assert(condition) WARN_ON(!(condition))
 #endif
 
+/**
+ * Implementations of pow_of_2 functions targeting u64:
+ *
+ * The various pow_of_2 functions in log2.h work on longs, which are 32-bit on
+ * 32-bit systems. Since the GPU address space is 64-bit even on systems with
+ * a 32-bit CPU, this causes needless truncation. Work is underway to improve
+ * the general implementations to support 64-bit types on 32-bit systems, but
+ * in the meantime, we implement our own here.
+ */
+
+static __always_inline __attribute_const__
+bool is_power_of_2_u64(u64 n)
+{
+	return n - 1 < (n ^ (n - 1));
+}
+
+static inline __attribute_const__
+u64 roundup_pow_of_two_u64(u64 n)
+{
+	return 1ULL << fls64(n - 1);
+}
+
+static inline __attribute_const__
+u64 rounddown_pow_of_two_u64(u64 n)
+{
+	return 1ULL << (fls64(n) - 1);
+}
+
+
 static struct kmem_cache *slab_blocks;
 static struct kmem_cache *slab_extents;
 
@@ -414,7 +443,7 @@ gpu_dirty_tracker_find(struct gpu_dirty_tracker *dirty_tracker,
 	struct gpu_dirty_extent *root_extent;
 	struct rb_node *parent;
 
-	if (!min_size || !is_power_of_2(min_size))
+	if (!min_size || !is_power_of_2_u64(min_size))
 		return NULL;
 
 	if (!rb)
@@ -864,7 +893,7 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 	if (chunk_size < SZ_4K)
 		return -EINVAL;
 
-	if (!is_power_of_2(chunk_size))
+	if (!is_power_of_2_u64(chunk_size))
 		return -EINVAL;
 
 	size = round_down(size, chunk_size);
@@ -1465,7 +1494,7 @@ alloc_from_freetree(struct gpu_buddy *mm,
 static bool
 gpu_buddy_can_offset_align(u64 size, u64 min_block_size)
 {
-	return size < min_block_size && is_power_of_2(size);
+	return size < min_block_size && is_power_of_2_u64(size);
 }
 
 static bool gpu_buddy_subtree_can_satisfy(struct rb_node *node,
@@ -1519,12 +1548,12 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
 {
 	struct gpu_buddy_block *block = NULL;
 	unsigned int order, tmp, alignment;
-	unsigned long pages;
+	u64 pages;
 	int err;
 
 	alignment = ilog2(min_block_size);
 	pages = size >> ilog2(mm->chunk_size);
-	order = fls(pages) - 1;
+	order = fls64(pages) - 1;
 
 	/*
 	 * Offset-aligned allocation is a strict address-placement policy: the
@@ -1708,14 +1737,14 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 	struct gpu_buddy_block *block;
 	struct rb_root *root;
 	struct rb_node *iter;
-	unsigned long pages;
+	u64 pages;
 	unsigned int order;
 	u64 modify_size;
 	int err;
 
-	modify_size = rounddown_pow_of_two(size);
+	modify_size = rounddown_pow_of_two_u64(size);
 	pages = modify_size >> ilog2(mm->chunk_size);
-	order = fls(pages) - 1;
+	order = fls64(pages) - 1;
 	if (order == 0)
 		return -ENOSPC;
 
@@ -1970,7 +1999,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 	u64 original_size, original_min_size;
 	unsigned int min_order, order;
 	LIST_HEAD(allocated);
-	unsigned long pages;
+	u64 pages;
 	int err;
 
 	gpu_buddy_driver_lock_held(mm);
@@ -1981,7 +2010,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 	if (min_block_size < mm->chunk_size)
 		return -EINVAL;
 
-	if (!is_power_of_2(min_block_size))
+	if (!is_power_of_2_u64(min_block_size))
 		return -EINVAL;
 
 	if (!IS_ALIGNED(start | end | size, mm->chunk_size))
@@ -2006,7 +2035,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	/* Roundup the size to power of 2 */
 	if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
-		size = roundup_pow_of_two(size);
+		size = roundup_pow_of_two_u64(size);
 		min_block_size = size;
 		/*
 		 * Normalize the requested size to min_block_size for regular allocations.
@@ -2017,7 +2046,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 	}
 
 	pages = size >> ilog2(mm->chunk_size);
-	order = fls(pages) - 1;
+	order = fls64(pages) - 1;
 	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
 
 	if (order > mm->max_order || size > mm->size) {
@@ -2031,7 +2060,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 	}
 
 	do {
-		order = min(order, (unsigned int)fls(pages) - 1);
+		order = min(order, (unsigned int)fls64(pages) - 1);
 		BUG_ON(order > mm->max_order);
 		/*
 		 * Regular allocations must not allocate blocks smaller than min_block_size.
-- 
2.56.0

