Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E14CD13DF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E16010F405;
	Thu, 30 Apr 2026 18:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bOagU7kb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02DC10E484;
 Thu, 30 Apr 2026 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777573423; x=1809109423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zEHdxcWSGKIgRFynMhNMN4pR3cJWvroQqSO422pNkjk=;
 b=bOagU7kbCRV4OzaWw89YaTnPU++U/T7lyu483cQV5VPLPQoOimhVn1oH
 t4gE61s0ZZnu90A3QNQH6aGH+/CPJtCcuB/W35mdVKDBmZotDLaHmKHT7
 xa9p7vMKFpM5kDkfcEsO97y8iRIC3aVChbj15tF1Z8uwTnxwipyPh2BPo
 F9Ha8BjParK21VRN9NStr4O+ncLKpjd7uhI0vXO23ekQ/MRAtvaDftweo
 cY/vZtc7zNFg/5CQiPrDYFM7Xo6rcU/69Nz2TvOQpoA9MG0c7xQbPsaUJ
 TfmSideSiiqiFnQBmjxanwDhMH1ctBHtmpne+8I4WjLd+5PCr//Lh7SaP A==;
X-CSE-ConnectionGUID: 5GH7CFNFT7yfGntQdA/kjw==
X-CSE-MsgGUID: 5ZjvfXlwR8uIQHz/c4cwUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="82389005"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="82389005"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 11:23:42 -0700
X-CSE-ConnectionGUID: WxAV99YWTs2ipdl5sIrZEg==
X-CSE-MsgGUID: GlhMidk7RFWlt4o37DMnJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="231532221"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 11:23:41 -0700
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
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>,
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 3/6] drm/ttm: Issue direct reclaim at beneficial_order
Date: Thu, 30 Apr 2026 11:23:32 -0700
Message-Id: <20260430182335.2132382-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430182335.2132382-1-matthew.brost@intel.com>
References: <20260430182335.2132382-1-matthew.brost@intel.com>
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
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
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

