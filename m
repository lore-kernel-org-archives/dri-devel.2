Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064E2C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5450110E48F;
	Sun, 23 Aug 2026 09:27:23 +0000 (UTC)
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8CF10F286
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:29:14 +0000 (UTC)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 759F01EAA5E; Fri, 21 Aug 2026 17:19:34 +0800 (AWST)
Received: from shelley.lan (unknown [IPv6:2001:8003:8802:7000::41b])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 772631EAA4D;
 Fri, 21 Aug 2026 17:19:29 +0800 (AWST)
From: David Gow <david@ingeniumdigital.com>
To: Jim Cromie <jim.cromie@gmail.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Gow <david@davidgow.net>
Subject: [PATCH 2/2] drm_buddy: fix power-of-2 rounding errs
Date: Fri, 21 Aug 2026 17:19:15 +0800
Message-ID: <20260821091918.1902032-2-david@ingeniumdigital.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821091918.1902032-1-david@ingeniumdigital.com>
References: <20260821091918.1902032-1-david@ingeniumdigital.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

From: Jim Cromie <jim.cromie@gmail.com>

The standard roundup_pow_of_two() and rounddown_pow_of_two() macros use
unsigned long internally, which on 32-bit architectures (like arm32) is
a 32-bit type.

drm_test_buddy_alloc_exceeds_max_order() uses these on a u64 value,
where they silently truncate the 10GB allocation, giving unexpected
success in DRM-CI.  (see below the snip).

Fix this by replacing the those macros with the safe 64-bit power-of-two
equivalents added in the previous patch.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: David Gow <david@davidgow.net>
---

This should actually be version 13, I think, as it's just a rebase of v12
here, where it was part of a large series of fixups:
https://lore.kernel.org/all/20260326185413.1205870-40-jim.cromie@gmail.com/

The major changes since that version are:
- Add the helper functions rounddown_pow_of_two64() and
  roundup_pow_of_two64() (see patch 1) instead of open-coding them
- Rebase now that the buddy allocator lives in drivers/gpu/buddy.c
  instead of drivers/gpu/drm/drm_buddy.c

This is still breaking the gpu_test_buddy_alloc_exceeds_max_order
KUnit test on 32-bit systems:
[09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: EXPECTATION FAILED at drivers/gpu/tests/gpu_buddy_test.c:1429
[09:01:26]     Expected err == -22, but
[09:01:26]         err == 0 (0x0)
[09:01:26] WARNING: drivers/gpu/buddy.c:508 at gpu_buddy_fini+0x244/0x2e0, CPU#0: kunit_try_catch/1595
[09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:508: gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
[09:01:26] WARNING: drivers/gpu/buddy.c:516 at gpu_buddy_fini+0x284/0x2e0, CPU#0: kunit_try_catch/1595
[09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:508: gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
[09:01:26] WARNING: drivers/gpu/buddy.c:516 at gpu_buddy_fini+0x284/0x2e0, CPU#0: kunit_try_catch/1595
[09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:519: gpu_buddy_assert(!mm->used_scoreboard[i])
[09:01:26] [FAILED] gpu_test_buddy_alloc_exceeds_max_order

Cheers,
-- David

---
 drivers/gpu/buddy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index a5553fcec28c..64f41f1fe908 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1193,7 +1193,7 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 	u64 modify_size;
 	int err;
 
-	modify_size = rounddown_pow_of_two(size);
+	modify_size = rounddown_pow_of_two64(size);
 	order = ilog2(modify_size) - ilog2(mm->chunk_size);
 	if (order == 0)
 		return -ENOSPC;
@@ -1440,7 +1440,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	/* Roundup the size to power of 2 */
 	if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
-		size = roundup_pow_of_two(size);
+		size = roundup_pow_of_two64(size);
 		min_block_size = size;
 		/*
 		 * Normalize the requested size to min_block_size for regular allocations.
-- 
2.55.0

