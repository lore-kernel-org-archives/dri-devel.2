Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE5FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9756D10EE68;
	Wed, 29 Apr 2026 06:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ivAxYj6v";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9FB10EE64
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777442684; x=1808978684;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dfl9nC1Exc3AqWuntxQXKXMjbEeUtj6NKVJat3VsSDE=;
 b=ivAxYj6vfqHwJdu1aDTdUeOYWAQV7c6abH+ePNEC13I62gneTvsEGvpu
 IStjVNmW+UcFGazvWd8f89Iim0BF/zyStD1hxrQ7QL6Kg+GsAamHOf18z
 We3ouymCDswiKDaP7xC9W4ZIFnXIl1pR77dpH9+hT15GOGccY+P5dSTgW
 m/QTf290HphuxUG/nTjabrvj0yeRaRdNvczdI9fpWVe+/vrF/RR6NT995
 ridXtnaTSJn1soxn1jNVx7ebg2Q92dzS/FYExepE/8zFeLsKN7T+qAJle
 L/BJyH17MzOvl/ODR5mKwWzXSfAqwbK4fef8KlPNf3pMacgAHlKeIGc0A w==;
X-CSE-ConnectionGUID: +WS2ORtPRiiseaxgqa0z/A==
X-CSE-MsgGUID: xgqR8RDTSaGuCSeVbfAONg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88672086"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="88672086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 23:04:44 -0700
X-CSE-ConnectionGUID: +wEHzoxDR5Kcb3xowzXUkg==
X-CSE-MsgGUID: Jz6154WlSNuaWGw8DWSRew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="264562062"
Received: from otc-chromeosbuild-8.ostc.intel.com (HELO
 otc-chromeosbuild-8.intel.com) ([10.54.29.153])
 by orviesa002.jf.intel.com with ESMTP; 28 Apr 2026 23:04:43 -0700
From: george.d.sworo@intel.com
To: maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH v2 1/2] drm/modeset_lock: add NULL check for ctx before WARN_ON
Date: Tue, 28 Apr 2026 23:04:30 -0700
Message-Id: <20260429060431.1462589-2-george.d.sworo@intel.com>
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

