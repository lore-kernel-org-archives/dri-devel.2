Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E54CD4F54
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 05:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A4110E2D6;
	Sat, 23 May 2026 05:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SW+/RkA4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E7410E2D6;
 Sat, 23 May 2026 05:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779512751; x=1811048751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z0JSRgi8ZG+H3pLN2O+lpzD2J6BaOOw05NkXHK6uLA0=;
 b=SW+/RkA4JIv3Tvgwubme70OcL+nwP9vrGJ2Cub3jAn1R0TY/8qtjgp9Y
 rR8t5VE191G3nMbKX7qXC7B+8wmA5qVORfHKbB3WfgSgARyYfbeFuvt4F
 ZWlN2JtieXaFFkN1jb0faa59zKcUKz5shZvPjp0iMwBKFYtS5j4HK+s+y
 Ju0xHrBH5RJWIxcjQGIKzmLFegd8HxuZUKDlphblDvZPPfENjY0dlXaGf
 w/pOvlyhoXWpTbiXw97khZQT186eW3eVRmHb6N6em22EhlsjNebi7Y8Nx
 W2k611VM5hJzmo7g2JH8MlXbuCyw8zhLrjsU4lHZ4zzDV4HfqZKYYrOv3 g==;
X-CSE-ConnectionGUID: 89VFqjaHTyiXc/g0YCWSzQ==
X-CSE-MsgGUID: peCHXLmMSvuOFWXUwUuAHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013539"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="83013539"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 22:05:51 -0700
X-CSE-ConnectionGUID: 76rYmPt6SXeDKs6wv8E2VQ==
X-CSE-MsgGUID: L2W/Y+D4RL2a3CwPoprc5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="279199756"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:48 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/4] drm/xe/drm_ras: Make counter allocation drm managed
Date: Sat, 23 May 2026 10:30:20 +0530
Message-ID: <20260523050212.557292-3-raag.jadav@intel.com>
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

cleanup_node_param() is not registered in case of counter allocation
failure, which results in stale memory of previous node that isn't
cleaned up on unwind. Fix this using drm managed allocation, which is
guaranteed to be cleaned up on unwind.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Retain info as NULL on failure (Riana)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c21c8b428de6..c1d5ac198a7c 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
 	struct xe_drm_ras_counter *counter;
 	int i;
 
-	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
+	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
 	if (!counter)
 		return ERR_PTR(-ENOMEM);
 
@@ -135,7 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
 {
 	struct drm_ras_node *node = &ras->node[severity];
 
-	kfree(ras->info[severity]);
 	ras->info[severity] = NULL;
 
 	kfree(node->device_name);
-- 
2.43.0

