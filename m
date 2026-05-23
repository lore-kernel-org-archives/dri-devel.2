Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E963CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 05:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E664810E2CB;
	Sat, 23 May 2026 05:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hb70Nokm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36D210E59C;
 Sat, 23 May 2026 05:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779512754; x=1811048754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EhIhubh9Rh0xfO3OovAjCUxMlnj9bya8XxpBsuwv5sI=;
 b=hb70NokmWcdspicCAH+Uj0SMWcggLUbKOEeGjQaJD6SCJw/UXtnOxqK+
 5pPZHCAWKV50pysyaVQNi6ifwBeFhaz0RjnF+Dfx2VZ6YnimG+nUhC4G1
 rlIijvHieG1p1ulG51oAeSCkM9ZVdTX1uNzZVhHwJDg6jUwVqlXwzRzVO
 mQ8AVMuiBFHLO8rsniqXsm+D0ofroCRur0uIW6ptn30VPz6jstK0f+9ei
 YNB+HwFsmoBjO/7L1MogwviHIdsO1/f3oeI0WKFBQgUve4423M3QJ2fsh
 Vi4gBkqZ33T1PyKUk4x6HfoGrc4gv8jN/bAXE9+9jJdycM9LrUKgVcjXY A==;
X-CSE-ConnectionGUID: V1fAF0ccRQSaLFz0GgAU8Q==
X-CSE-MsgGUID: HrQkrfOoTIKP1wDqQi91Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013547"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="83013547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 22:05:54 -0700
X-CSE-ConnectionGUID: euMoS4AbT+OXXNVuI8g8Yg==
X-CSE-MsgGUID: 9NT2x0N+SIaTipOjfajB4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="279199761"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:51 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 3/4] drm/xe/drm_ras: Add per node cleanup action
Date: Sat, 23 May 2026 10:30:21 +0530
Message-ID: <20260523050212.557292-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523050212.557292-1-raag.jadav@intel.com>
References: <20260523050212.557292-1-raag.jadav@intel.com>
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

cleanup_node_param() is not registered for previous node in case of counter
allocation failure, which results in stale memory of previous node that
isn't cleaned up on unwind. Add per node cleanup action which guarantees
cleanup on unwind and also simplifies the cleanup logic.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 59 +++++++++++++--------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c1d5ac198a7c..b901976203fc 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -131,53 +131,46 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	return 0;
 }
 
-static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
+static void cleanup_node_param(struct drm_ras_node *node)
 {
-	struct drm_ras_node *node = &ras->node[severity];
-
-	ras->info[severity] = NULL;
-
 	kfree(node->device_name);
 	node->device_name = NULL;
 }
 
+static void cleanup_node(struct drm_device *drm, void *node)
+{
+	drm_ras_node_unregister(node);
+	cleanup_node_param(node);
+}
+
 static int register_nodes(struct xe_device *xe)
 {
 	struct xe_drm_ras *ras = &xe->ras;
-	int i;
+	struct drm_ras_node *node;
+	int i, ret;
 
 	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
-		int ret;
+		node = &ras->node[i];
 
 		ret = assign_node_params(xe, node, i);
-		if (ret) {
-			cleanup_node_param(ras, i);
-			return ret;
-		}
+		if (ret)
+			break;
 
 		ret = drm_ras_node_register(node);
-		if (ret) {
-			cleanup_node_param(ras, i);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
-{
-	struct xe_device *xe = arg;
-	struct xe_drm_ras *ras = &xe->ras;
-	int i;
+		if (ret)
+			break;
 
-	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
+		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+		if (ret)
+			break;
+	}
 
-		drm_ras_node_unregister(node);
-		cleanup_node_param(ras, i);
+	if (ret) {
+		cleanup_node_param(node);
+		ras->info[i] = NULL;
 	}
+
+	return ret;
 }
 
 /**
@@ -206,11 +199,5 @@ int xe_drm_ras_init(struct xe_device *xe)
 		return err;
 	}
 
-	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
-	if (err) {
-		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
-		return err;
-	}
-
 	return 0;
 }
-- 
2.43.0

