Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2E2CD98E1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 02:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFCE110EDC2;
	Wed, 17 Jun 2026 02:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f8Yw6qlq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C47B10E902;
 Wed, 17 Jun 2026 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781662974; x=1813198974;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=45uF6n/VZ+dbGp7B0HwEr/0X+qLKMtsft3m9nq2+/1I=;
 b=f8Yw6qlqX4j5SgdsVm70xdn5YWgkH+viuSQtzEetca47v+sqZSQfxnLB
 vR+Pe9LpgIDIvWdzK4qmiWXh4L5FYX4J93vTQbCrxHIBli7rv7KTDwXOT
 baB4nWhXWQbHsw4WhZl0YOsNsL9eRgUKo5t7PskQmhAyW0WfFgeQG9eu2
 ZT0IJIPZCAQhN34vVd3QDR7DDv09Toa4CiqEWtoLRIPqi4RgbrYPgHMcA
 TnBF4wejeY/AT+rzNbgAAR+PuqJxBsTKPRoK+vQ5duKz6vsCBqInWkYsC
 3J1uSppFBNACULZH/DRZEdtEfHte7w+vXJYwr2XM8vMa5WtPIg710msQD Q==;
X-CSE-ConnectionGUID: dGC2vmzOTqu4elF4o4b6zQ==
X-CSE-MsgGUID: PVihrWF4QkSVt2I2O9ILEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81576678"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="81576678"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 19:22:53 -0700
X-CSE-ConnectionGUID: c82pWy48T+69qdidkxU0pQ==
X-CSE-MsgGUID: LuevtLjdQl6zOm7ZGtUlPg==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 19:22:53 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH] drm/ttm/pool: Try harder for beneficial orders
Date: Tue, 16 Jun 2026 19:22:48 -0700
Message-Id: <20260617022248.1165101-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

When a driver specifies a beneficial order, TTM should make a reasonable
effort to allocate pages at that order.

Use __GFP_RETRY_MAYFAIL instead of __GFP_NORETRY when allocating at the
beneficial order. This allows reclaim to try harder before falling back to
smaller orders, at the cost of longer allocation setup time.

That tradeoff is acceptable for beneficial-order allocations: higher-order
backing pages can improve TLB hit rates and reduce the number of TLB
invalidations needed when moving memory.

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
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

Together with other Xe/core shrinker changes currently under development,
this change significantly improved performance under memory fragmentation
on PTL. In 3DMark Wild Life Extreme, performance improved by up to 120%
compared to the baseline fragmented-memory case. GravityMark also showed
approximately a 20% improvement under similar conditions.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 9f0ab99eb289..682ae4f40424 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -168,6 +168,11 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	if (order && beneficial_order && order != beneficial_order)
 		gfp_flags &= ~__GFP_RECLAIM;
 
+	if (beneficial_order && order == beneficial_order) {
+		gfp_flags &= ~__GFP_NORETRY;
+		gfp_flags |= __GFP_RETRY_MAYFAIL;
+	}
+
 	if (!ttm_pool_uses_dma_alloc(pool)) {
 		p = alloc_pages_node(pool->nid, gfp_flags, order);
 		if (p) {
-- 
2.34.1

