Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C02CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 20:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9386910F33F;
	Thu, 14 May 2026 20:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W+hZZmf5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C1A10F33F;
 Thu, 14 May 2026 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778790750; x=1810326750;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1VC1B2RAvzn9ZQoz+DQ/B8ks7B9GzKt+q0uKGsBrdjA=;
 b=W+hZZmf5nhh5E6c/6oy9HxZXZYfY9MfAKyigr2sc7/Int/FC69omuPkW
 CgYoo2Xt9syZeHV0tshZCjAd2vhtV3hhEEKmHAfRCDZuKPVn0iYuPMXDj
 R18NSFR2gL3kzS1Bl0XKxZYPeK5JfKUnTblKIwpW5Vy3RG+cfmjV4MkRv
 SiI88uujJk+CTOcAi1oq0Up+MOU60lsdH00J0ELyy6f0yLGoSP34TmyJE
 S39AWQPnIeLi2hApJyxlY44H0z9c1kXiMM2rQEBUGldhYJRmkoXGdYPWm
 Y2ILtZyjQf8VYSvVHUbK0UL9wX4YhyhRbaztYjhXHC6eEuSbzq2Owyi3Z g==;
X-CSE-ConnectionGUID: ceNpdCKySvSYDZoSgWlm/Q==
X-CSE-MsgGUID: KjbOtputSjqDdFHV7iU/vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880206"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="78880206"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 13:32:30 -0700
X-CSE-ConnectionGUID: jdXHFsA+TGyFGLdSaClHLA==
X-CSE-MsgGUID: 3nlGhDmsTQCJOtQ3OMHlcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="238361194"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:27 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, maarten@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/3] drm/xe/drm_ras: Add per node cleanup action
Date: Fri, 15 May 2026 01:58:18 +0530
Message-ID: <20260514202839.1888688-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514202839.1888688-1-raag.jadav@intel.com>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
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

cleanup_node_param() is not registered in case of counter allocation
failure, which results in stale memory of previous node that isn't
cleaned up on unwind. Add per node cleanup action which guarantees
cleanup on unwind and also simplifies the cleanup logic.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 42 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 89640ffb1c33..40abde29a26f 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -131,14 +131,20 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	return 0;
 }
 
-static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
+static void cleanup_node_param(struct drm_ras_node *node)
 {
-	struct drm_ras_node *node = &ras->node[severity];
-
 	kfree(node->device_name);
 	node->device_name = NULL;
 }
 
+static void cleanup_node(struct drm_device *drm, void *arg)
+{
+	struct drm_ras_node *node = arg;
+
+	drm_ras_node_unregister(node);
+	cleanup_node_param(node);
+}
+
 static int register_nodes(struct xe_device *xe)
 {
 	struct xe_drm_ras *ras = &xe->ras;
@@ -150,13 +156,19 @@ static int register_nodes(struct xe_device *xe)
 
 		ret = assign_node_params(xe, node, i);
 		if (ret) {
-			cleanup_node_param(ras, i);
+			cleanup_node_param(node);
 			return ret;
 		}
 
 		ret = drm_ras_node_register(node);
 		if (ret) {
-			cleanup_node_param(ras, i);
+			cleanup_node_param(node);
+			return ret;
+		}
+
+		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+		if (ret) {
+			cleanup_node(&xe->drm, node);
 			return ret;
 		}
 	}
@@ -164,20 +176,6 @@ static int register_nodes(struct xe_device *xe)
 	return 0;
 }
 
-static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
-{
-	struct xe_device *xe = arg;
-	struct xe_drm_ras *ras = &xe->ras;
-	int i;
-
-	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
-
-		drm_ras_node_unregister(node);
-		cleanup_node_param(ras, i);
-	}
-}
-
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
@@ -204,11 +202,5 @@ int xe_drm_ras_init(struct xe_device *xe)
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

