Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906AAC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B2210E822;
	Tue, 25 Aug 2026 09:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AjL0j8qz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4768A10E822;
 Tue, 25 Aug 2026 09:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787650557; x=1819186557;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dVmusFmNosE0q4+P8QypnqQyz1/BdpEQ1D1Kf5PrQak=;
 b=AjL0j8qzyEVefvbtHzqPvTYE8FLWAaLjROwxM0WUJ2JNRUUWAV9uy9xX
 2okdxcm1g8POvma8dJBx6/HNunDwB8E/gIdSCMsw9huSyJZSzdz9iL+kX
 qBkNGoY7m3mYwJnn56mMLVRVJa02d4IimR8hLtPuZUrkpl6JMKia96raQ
 dQSavqZ6Bu5xUME12U8edjIXXnNU7ROgP14uRvk/NjTapbr8SzgYE4ozV
 MNdVDuqabCI2yLg/Gw/quNmkAG7xFCF1NAIjHjG0N0ZqPkrgINYLHtMiI
 rL1Olf7995DYy5pA5nMC+I1OsYgqCCm/oEoE4uKbi+jIiFjObBNkQQBEg Q==;
X-CSE-ConnectionGUID: Y+ybdFk+SKK0v2jQiwa2xg==
X-CSE-MsgGUID: npwAoYKiRgm/41cWnAkzMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="75647832"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="75647832"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 02:35:57 -0700
X-CSE-ConnectionGUID: wcU2V+7OThKXYHLHvD63uw==
X-CSE-MsgGUID: xHRxiteTSiyRZyYzW6+WBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="290767930"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP; 25 Aug 2026 02:35:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 5650899; Tue, 25 Aug 2026 11:35:53 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/i915/gem: Use simpler versions of min*()
Date: Tue, 25 Aug 2026 11:35:52 +0200
Message-ID: <20260825093552.4088094-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Instead of harder to read min_array() and prone to mistakes min_t()
use min3() and min(). No functional changes intended. The types of
the values are unsigned, no side-effects are expected.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ef9440166295..bf9e7480f0f5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -153,11 +153,8 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			}
 		} while (1);
 
-		nr_pages = min_array(((unsigned long[]) {
-					folio_nr_pages(folio),
-					page_count - i,
-					max_segment / PAGE_SIZE,
-				      }), 3);
+		nr_pages = min3(folio_nr_pages(folio),
+				page_count - i, max_segment / PAGE_SIZE);
 
 		if (!i ||
 		    sg->length >= max_segment ||
@@ -168,8 +165,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			st->nents++;
 			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
 		} else {
-			nr_pages = min_t(unsigned long, nr_pages,
-					 (max_segment - sg->length) / PAGE_SIZE);
+			nr_pages = min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
 
 			sg->length += nr_pages * PAGE_SIZE;
 		}
-- 
2.50.1

