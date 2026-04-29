Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D11FF886F
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 03:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B365E10E3A8;
	Wed, 29 Apr 2026 03:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fpACxcMJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEB410E3A8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 03:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777431621; x=1808967621;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dfl9nC1Exc3AqWuntxQXKXMjbEeUtj6NKVJat3VsSDE=;
 b=fpACxcMJuTSNA7cJKA3JXG5mQZkJgpyQ/IG/UQYHijZzKnltV7okKhC8
 ut4bH8neGW64od5HaORmJ8NoqqM1WRiXbMtyEN94wOx2T7v1qExzx/I14
 C70RHtfs9rWqJAHKWw65WfWFbbEcOjRi18TK+6BdKfSu2EMhf+uh+ma9T
 t+9fDsRUTUbPrEPbnOEC0D77lKEhxev28oyW9uxEcm3O35bgbcr7YfNud
 S3QKi4g4UbJ94M43SBDSP/2CXddTz6A7J6SaA8xwFLQaJ7NHxJUfxz4M/
 Coy4AuX8lFvrtB72pMGI68qG/lef0buUgcxf9lArdx+6LWTuxvOgR3Q5L A==;
X-CSE-ConnectionGUID: EkVsZbzQQy6sp7RjyYKvpg==
X-CSE-MsgGUID: 72HNmhqTSqurDa0h7oQGlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95770103"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="95770103"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 20:00:21 -0700
X-CSE-ConnectionGUID: PPQeXzXOQemupcDdHZN1lw==
X-CSE-MsgGUID: 662p2jXDTBKgxCNA8rNirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="257690521"
Received: from otc-chromeosbuild-8.ostc.intel.com (HELO
 otc-chromeosbuild-8.intel.com) ([10.54.29.153])
 by fmviesa001.fm.intel.com with ESMTP; 28 Apr 2026 20:00:20 -0700
From: george.d.sworo@intel.com
To: maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH] drm/modeset_lock: add NULL check for ctx before WARN_ON
Date: Tue, 28 Apr 2026 19:59:52 -0700
Message-Id: <20260429025952.1202080-1-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.34.1
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

From: George D Sworo <george.d.sworo@intel.com>

modeset_lock() and drm_modeset_drop_locks() do not validate
the ctx pointer before dereferencing it in WARN_ON(ctx->contended),
which can lead to a NULL pointer dereference if ctx is NULL.

Add a NULL check to prevent this.

Signed-off-by: George D Sworo <george.d.sworo@intel.com>
---
 drivers/gpu/drm/drm_modeset_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index beb91a13a312..2052bb9bb9e5 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -295,7 +295,7 @@ static inline int modeset_lock(struct drm_modeset_lock *lock,
 {
 	int ret;
 
-	if (WARN_ON(ctx->contended))
+	if (ctx && WARN_ON(ctx->contended))
 		__drm_stack_depot_print(ctx->stack_depot);
 
 	if (ctx->trylock_only) {
-- 
2.34.1

