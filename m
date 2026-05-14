Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC14CD4F41
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 20:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE68810F339;
	Thu, 14 May 2026 20:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g5rte9so";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117E110F330;
 Thu, 14 May 2026 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778790747; x=1810326747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7JBmUG8ehsuocF61vBqXNEb6j3hGEs0RGiPNnDhI9pQ=;
 b=g5rte9sottrcBO1FAnwkQU9jwaetuUY2mlDB9WxRUPCV4AagR/Fmucpt
 eIlSAvHT85dGzYKDRvrj0m9czK0CA7ugwFocpKQj72TiIYHyn6hdat8U4
 a1EA8fRUufdGuL73DDmfbTVCzDtgVcft98+7nLQHy7r99e+hkGPiDo4T5
 W8yA3OmPG7GGuVQ2rtKlX3q+UTy1dhj5JyKY4q4hyDq1pjbATkmzvA/Z7
 nOfg567lkONt6MVrvXPbdkMLkjFZ+/wEV5vgaYa13VL1u/Fh1bC4sSYh4
 CMgc9ADpZy40vImmJohkfh7xXFQqry3LOTEd1itmxItQQ8C4pzJdelhHy A==;
X-CSE-ConnectionGUID: xL30N6thQj+L3LslZHwjWg==
X-CSE-MsgGUID: f+B83MK4TjmUdUtzChsDTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880199"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="78880199"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 13:32:26 -0700
X-CSE-ConnectionGUID: Iume43g7Q7ezp9Nz/fK29A==
X-CSE-MsgGUID: cN9zE9QIRJ+mLXvdj0/Big==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="238361190"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:24 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, maarten@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/3] drm/xe/drm_ras: Make counter allocation drm managed
Date: Fri, 15 May 2026 01:58:17 +0530
Message-ID: <20260514202839.1888688-3-raag.jadav@intel.com>
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
cleaned up on unwind. Fix this using drm managed allocation, which is
guaranteed to be cleaned up on unwind.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c21c8b428de6..89640ffb1c33 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
 	struct xe_drm_ras_counter *counter;
 	int i;
 
-	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
+	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
 	if (!counter)
 		return ERR_PTR(-ENOMEM);
 
@@ -135,9 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
 {
 	struct drm_ras_node *node = &ras->node[severity];
 
-	kfree(ras->info[severity]);
-	ras->info[severity] = NULL;
-
 	kfree(node->device_name);
 	node->device_name = NULL;
 }
-- 
2.43.0

