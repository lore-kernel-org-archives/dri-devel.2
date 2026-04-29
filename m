Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F93FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C758710EE64;
	Wed, 29 Apr 2026 06:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IpxbhmZr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D908E10EE64
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777442686; x=1808978686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K5FLQvf1ktzHuF8i12gIzU0mZ4t59UFwJnvlYzeS+v4=;
 b=IpxbhmZrC58nr/tdQcrSKEvlmBLsJXFKgJrgLUif9fbn3bc96m7LP4IM
 xfa7I08t/Q3lwdOOEH/rqghvizYj3b7OeFaBbrdI8IM4zekDuYiiu096X
 3jPCmDvE+iAORpUNLMVRWAUFJuxHTQy6LjaisDxh6t59Jt1h+rWouTqhK
 +WB29YgXgIz7LgYYAMUpokHm/LpwRztJN3Be6PmJF7+TSahWkN+8nY1Pd
 fzsWzSMjDQha47qD+QSg5Ro6ZtJTJCUqW942qadW/lGja9bgSubHPUhR6
 v5Vb0U18LWgW2OKEPA1yDvrO1oVF7Fden3iVK6GIeiT+FihAR3fDed7Ko A==;
X-CSE-ConnectionGUID: QU1l3v4sSRCmJJeMmdgOYA==
X-CSE-MsgGUID: A8buC/gySfysj8xhF7+xEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88672090"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="88672090"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 23:04:45 -0700
X-CSE-ConnectionGUID: 4DqkoY9eRtGBhef4zWsZ2g==
X-CSE-MsgGUID: nXZMcHK4Td+rhv6u3ShbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="264562071"
Received: from otc-chromeosbuild-8.ostc.intel.com (HELO
 otc-chromeosbuild-8.intel.com) ([10.54.29.153])
 by orviesa002.jf.intel.com with ESMTP; 28 Apr 2026 23:04:45 -0700
From: george.d.sworo@intel.com
To: maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH v2 2/2] drm/modeset: harden modeset_lock() against NULL ctx
Date: Tue, 28 Apr 2026 23:04:31 -0700
Message-Id: <20260429060431.1462589-3-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429060431.1462589-1-george.d.sworo@intel.com>
References: <20260429025952.1202080-1-george.d.sworo@intel.com>
 <20260429060431.1462589-1-george.d.sworo@intel.com>
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

modeset_lock() dereferences ctx unconditionally. Add a defensive NULL
guard to avoid NULL dereference if a buggy internal caller passes a NULL
acquire context.

For NULL ctx, fall back to plain ww_mutex locking semantics:
- interruptible path uses ww_mutex_lock_interruptible(..., NULL)
- non-interruptible path uses ww_mutex_lock(..., NULL)

This keeps wait behavior consistent with the helper arguments.

Signed-off-by: George D Sworo <george.d.sworo@intel.com>
---
 drivers/gpu/drm/drm_modeset_lock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 2052bb9bb9e5..5bee424805c3 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -294,6 +294,18 @@ static inline int modeset_lock(struct drm_modeset_lock *lock,
 		bool interruptible, bool slow)
 {
 	int ret;
+	/*
+	 * Defensive fallback: this helper is expected to be called with a
+	 * valid acquire context, but if a NULL ctx slips through, preserve
+	 * the lock wait semantics and avoid NULL dereference.
+	 */
+	if (unlikely(!ctx)) {
+		if (interruptible)
+			return ww_mutex_lock_interruptible(&lock->mutex, NULL);
+
+		ww_mutex_lock(&lock->mutex, NULL);
+		return 0;
+	}
 
 	if (ctx && WARN_ON(ctx->contended))
 		__drm_stack_depot_print(ctx->stack_depot);
-- 
2.34.1

