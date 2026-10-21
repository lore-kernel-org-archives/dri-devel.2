Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA49606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B8X4Qa+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95BC10E1AE;
	Wed, 21 Oct 2026 02:47:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A37610E1AE
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 02:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792550871; x=1824086871;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Nd0Os7Q8rPkbwG0hvjQbf1iNQs4hOxLH7qJyUkhWMHY=;
 b=B8X4Qa+GaQrh4p5ClXYRwW3I+pIBRBXRjNrU8xsrp0u36dZL5WzF43uR
 lYC3evpRDyJZvAqXRFy2S9jRbSD+rO8MEk8IRPMOcb/OKKWIRD3q1uciJ
 NuEI0bu7AmR2FbD7f2ShYlqmnnELapsChAsb5U91d1zFR9KhXrC5JPhME
 Mo5LrI4aQ5WSSpjJnTEr4B2PCevYhuG/umjzHdOix9B7MztHh6VLcj1au
 GGDU1pDWLuF8oGw4Bw2HBE4JzG+f8doWpNunC2scFuiu9aVtxNrhaTRh0
 ehUBEfSL0Oq99eS9FlugFjoeXetGHPSlXn9W/WorXxaQY5VH3PZDCAdaM Q==;
X-CSE-ConnectionGUID: lC7LlInXQ5iT8pX6LK04Vg==
X-CSE-MsgGUID: ySa+V1eMQJWKk2wKPBksRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1155409"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1155409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 19:47:51 -0700
X-CSE-ConnectionGUID: z8baBu9/R/e5JqX2BaX6SQ==
X-CSE-MsgGUID: rq2WVixCQJSBdGr/qLgYfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3075574"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 19:47:48 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: riana.tauro@intel.com, mallesh.koujalagi@intel.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, christian.koenig@amd.com,
 andrealmeid@igalia.com, Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3] drm: Log recovery method with wedged event
Date: Wed, 21 Oct 2026 08:17:26 +0530
Message-ID: <20261021024726.250487-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, drm_dev_wedged_event() logs a basic message of device being
wedged, but doesn't print the recovery method used by the caller. Log it
for easier bug report analysis.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Distinguish between recovery and no recovery cases (Christian, Rodrigo)
v3: Retain drm_info() (Christian)
---
 drivers/gpu/drm/drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index cb53baa70995..43125d655f64 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -598,8 +598,8 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 		/* Caller is unsure about recovery, do the best we can at this point. */
 		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
 
-	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
-		 "but no recovery needed" : "needs recovery");
+	drm_info(dev, "device wedged with method %#lx, %s\n", method,
+		 method == DRM_WEDGE_RECOVERY_NONE ? "no recovery needed" : "needs recovery");
 
 	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
 		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
-- 
2.43.0

