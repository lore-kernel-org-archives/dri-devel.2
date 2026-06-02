Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C82CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EDA10EBBE;
	Tue,  2 Jun 2026 04:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LweYaMTA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE5610EBBB;
 Tue,  2 Jun 2026 04:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780376011; x=1811912011;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BsCP7ctx6l0Ln/OQfgG9XoaYhdWNrFR8mj3q8d2KZ5A=;
 b=LweYaMTA76MDM2mtM+TXzHDMnps/r8genU5+HysM/gu69jChoSEnOWzK
 O02XasNL0scIqjXWZCaxYS83kLqoFW2k7DjngW/GFDYNe6HuyGvXuVGCx
 Thwg2oJD/HAXwLupfocLsp+e5i+Y63BYSTN46PHsyTGmsE0La1lM85sSC
 kzFIXD5BXCp6CC2vBqNqDTCAXiZQ24Vlk8H7tOFZCoifbyNSEkxysaJ3s
 Kzmb8ehjq7tGixDlmLyc/ctVDl0aP6NZN7gTeaEAIL3B8N2ORouY4uZlp
 NZjSAftpeAIZ8sj4PpCQRL704zxrrem2rzulfKHoaA6AEostwLXzPvkRz A==;
X-CSE-ConnectionGUID: pB3V9XRtTiqCNnuIJ2G3iw==
X-CSE-MsgGUID: cIZqGTnqQB2Mo0NxbCa9Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120480"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="81120480"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 21:53:30 -0700
X-CSE-ConnectionGUID: PshtVZZfQayor2JSflQoEQ==
X-CSE-MsgGUID: l5QpDHUvS8aIrf/2ONWIig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="245604125"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:27 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 3/4] drm/xe/drm_ras: Add per node cleanup action
Date: Tue,  2 Jun 2026 10:18:43 +0530
Message-ID: <20260602044919.702209-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602044919.702209-1-raag.jadav@intel.com>
References: <20260602044919.702209-1-raag.jadav@intel.com>
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
v3: Prevent double free on drmm_add_action_or_reset() failure (Riana)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 58 +++++++++++++--------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c1d5ac198a7c..cd236f53699e 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -131,53 +131,47 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
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
+			goto free_param;
 
 		ret = drm_ras_node_register(node);
-		if (ret) {
-			cleanup_node_param(ras, i);
-			return ret;
-		}
+		if (ret)
+			goto free_param;
+
+		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+		if (ret)
+			goto null_info;
 	}
 
 	return 0;
-}
 
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
+free_param:
+	cleanup_node_param(node);
+null_info:
+	ras->info[i] = NULL;
+	return ret;
 }
 
 /**
@@ -206,11 +200,5 @@ int xe_drm_ras_init(struct xe_device *xe)
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

