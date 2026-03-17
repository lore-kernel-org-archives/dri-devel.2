Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDACAFD877D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1284710E674;
	Tue, 17 Mar 2026 14:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aUL6WoIi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966F910E66B;
 Tue, 17 Mar 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773757165; x=1805293165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+RZc3wuyNfgehWG47RKM6xRWZOHv3jtVEC2Rfk08LZo=;
 b=aUL6WoIiN84g9fAYUH4eGhSZrEV0JM0Fon5IW53L48N9Nvnr0JeTrNXC
 /5DlbZbk5tZdhocBrQVk1RUnAc32CkA1F240naApm0qFyhHasKINB4PTn
 2kmhGGHluki4ln2oG89GhlK2CzIyV5D2JqUCQz1SpHM17iT2fGIH/pBvw
 LDfFxlq5tZrj47rI+09YdWFrZzo5H9+XHkkpBY9MIBGN1ZICgA2BzQfZ8
 eLvIYmuPEh7Kizh1p10yrU0vVPZw02Wh1PU6ED7PjgSjgoFSmOJUHhYQ3
 kCS8JqJ5wMMyKY0z8p/5UNDmEWQoONY/8hEmno/eKmwDyIxkDqcQqvvO0 g==;
X-CSE-ConnectionGUID: nKZjnO/TQWmwBUoTknidrQ==
X-CSE-MsgGUID: ua0MJxoYRXeM+twcioX6kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74973136"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74973136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:25 -0700
X-CSE-ConnectionGUID: UmWw7/eZRRGftXZ4M9Kw6A==
X-CSE-MsgGUID: kuDPV5mQRUqaRF5H7Uhqww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="260184981"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO fedora)
 ([10.245.245.163])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:23 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/3] drm/ttm: Don't spam the log on buffer object backing
 store allocation failure
Date: Tue, 17 Mar 2026 15:18:54 +0100
Message-ID: <20260317141856.237876-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
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

If the struct ttm_operation_ctx::gfp_retry_mayfail is true,
buffer object backing store allocation failures are expected to
silently fail with an error code to the caller. But currently an
elaborate warning is printed to the system log.

Don't spam the log in this way.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index c0d95559197c..8fa9e09f6ee5 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -726,7 +726,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		gfp_flags |= __GFP_ZERO;
 
 	if (ctx->gfp_retry_mayfail)
-		gfp_flags |= __GFP_RETRY_MAYFAIL;
+		gfp_flags |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
 	if (ttm_pool_uses_dma32(pool))
 		gfp_flags |= GFP_DMA32;
-- 
2.53.0

