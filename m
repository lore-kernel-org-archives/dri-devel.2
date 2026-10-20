Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148D606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JFgFSb8L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5398C10E221;
	Tue, 20 Oct 2026 02:22:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440C710E221
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 02:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792462918; x=1823998918;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U0sIqFNIh2pg5F9fvd2q+lowHItw9R7820eTpQ1HshA=;
 b=JFgFSb8LhWzZ4o/3cb8HN67JpGagMwTwMUy1YpOlbOXY48yVJbicNuib
 z19iprWvgpc+Rg7VQgzdn/UHQ7IRyNH4U49tm4fo/nuAznV5WJ05o5tBk
 gOtK00cqfLGIWa0+fmZo5N2zy/RuFudJ9YqGRx5AINshMyeR1BuFBI662
 rdQa5hF43/IkmV+Vu68h6fWXmL3rwtWSVueeHGDYefQsrHeIcVDkE8U9p
 0PBeSut4X8NgloS+MDpMNg39qnNEtC4zBXgLyJeuEPHG71GKfa+3olamx
 2OvdWhkjHw3UzE5L6ewAj0bYjIsgIwid9kef9MFyEidZSBhlKJwmb7uTe w==;
X-CSE-ConnectionGUID: 9Tnt66XlQQCDardoF0GL5g==
X-CSE-MsgGUID: I3vFoTE+T+yyjcnDIAGNyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1039821"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1039821"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 19:21:57 -0700
X-CSE-ConnectionGUID: BKyfb+8TTPqalZfLDp4lRw==
X-CSE-MsgGUID: lUpl/P2DQVe+ZSDMfNZZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2746734"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa005.fm.intel.com with ESMTP; 19 Oct 2026 19:21:55 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: riana.tauro@intel.com, mallesh.koujalagi@intel.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, christian.koenig@amd.com,
 andrealmeid@igalia.com, Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2] drm: Log recovery method with wedged event
Date: Tue, 20 Oct 2026 07:51:17 +0530
Message-ID: <20261020022117.199831-1-raag.jadav@intel.com>
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

While at it, as device wedging is a catastrophic event for the cases that
do need recovery, distinguish them and raise their log level to drm_warn().

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Distinguish between recovery and no recovery cases (Christian, Rodrigo)
---
 drivers/gpu/drm/drm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index cb53baa70995..7f8abb72f548 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -598,8 +598,10 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 		/* Caller is unsure about recovery, do the best we can at this point. */
 		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
 
-	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
-		 "but no recovery needed" : "needs recovery");
+	if (method == DRM_WEDGE_RECOVERY_NONE)
+		drm_info(dev, "device wedged, but no recovery needed\n");
+	else
+		drm_warn(dev, "device wedged with method %#lx, needs recovery\n", method);
 
 	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
 		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
-- 
2.43.0

