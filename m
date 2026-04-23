Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89544FAD41C
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCB410EB10;
	Thu, 23 Apr 2026 05:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CntZfouJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5C310E2F2;
 Thu, 23 Apr 2026 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776923823; x=1808459823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nVOUkLdsj8RJ1DjsnEJi+cY0atKBV6a2oIgaHL0ZpK4=;
 b=CntZfouJPtc9arDWZTqrONpBZt5Tddq4huJbjd57CGgrJEQ9PpbmYZIR
 buWEG80lZ8ChrrebXcFmlms7Xl5SYQyREWoGtU+NF0NPld3SrD7FUl8M+
 D5OyJsYOoubu9VRVmSbDGVw3z+Q4XGUiz6vLRQNumNckNaYX/pzV06mWH
 cFKssO8Fm/3VYpZv5+8/7kIYaub/5k2mg2yyWBSFBdJpxiMKBXDIJXzuZ
 PyvN1xAqy2oN5pRq0nAQk21ElaymhD3ciQNSq2n7eP01uPVcy4v+7R9bV
 tyO8ACcQtWghzwvWbdalbNlxqQYS8p4XPcAcGH0Mw5bWLQmN8Yhyvl0+G w==;
X-CSE-ConnectionGUID: pVMH5ZpnTFO6iir2yTw0eQ==
X-CSE-MsgGUID: LMGtH+pORiG5AaPu0ixZfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89273770"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="89273770"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:03 -0700
X-CSE-ConnectionGUID: IFJJlujeRIiqh+UKjfZbDw==
X-CSE-MsgGUID: FERO1WVyS12S05OWCMyxPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="255853893"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>
Subject: [PATCH v2 2/5] drm/ttm: Issue direct reclaim at beneficial_order
Date: Wed, 22 Apr 2026 22:56:53 -0700
Message-Id: <20260423055656.1696379-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423055656.1696379-1-matthew.brost@intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
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

Triggering kswap at an order higher than beneficial_order makes little
sense, as the driver has already indicated the optimal order at which
reclaim is effective. Similarly, issuing direct reclaim or triggering
kswap at a lower order than beneficial_order is ineffective, since the
driver does not benefit from reclaiming lower-order pages.

As a result, direct reclaim should only be issued with __GFP_NORETRY at
exactly beneficial_order, or as a fallback, direct reclaim without
__GFP_NORETRY at order 0 when failure is not an option.

Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
CC: dri-devel@lists.freedesktop.org
Cc: Daniel Colascione <dancol@dancol.org>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 26a3689e5fd9..8425dbcc6c68 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	 * Do not add latency to the allocation path for allocations orders
 	 * device tolds us do not bring them additional performance gains.
 	 */
-	if (beneficial_order && order > beneficial_order)
-		gfp_flags &= ~__GFP_DIRECT_RECLAIM;
+	if (order && beneficial_order && order != beneficial_order)
+		gfp_flags &= ~__GFP_RECLAIM;
 
 	if (!ttm_pool_uses_dma_alloc(pool)) {
 		p = alloc_pages_node(pool->nid, gfp_flags, order);
-- 
2.34.1

