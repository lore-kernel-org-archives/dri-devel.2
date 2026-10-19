Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87466CCF2D4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E031510E196;
	Mon, 19 Oct 2026 02:59:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA2D10E196
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792378773; x=1823914773;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R9jlFt+d+z3wIKHEfSYFEvPUaPi4enFVW1xcvUPSrqk=;
 b=Aj1JDFRrOsi70hd71+Zd7ps/MoD1EsEAaTzVmV0tNTzX28OkP3fUIWG2
 h+ctQMwwhgTDaHKMlni6UifcCRxsMhrFxBjdJs+oMT1GMFsIF/4LYddIE
 tB2utgjQNrAbONU16KTKIXCYFHneQS/Ka5sEFvSW4ux3rA6kII9zGbyLM
 QLvYpmUip4EanywWgVngBaSCmWfdkYza/NWy00MFyHF2LGCwbprcyWBVc
 itpwAHoJRB905A07o4/nW37U2B2okxZ7wojMbzKrcKk0SZ+y/fcZmTvDO
 q9KuPETtStZz0V2dNeGPN+Bs6maGsZWcoS4orpoMGgf+NKhw4DcBfwV7O Q==;
X-CSE-ConnectionGUID: Zb6XS2BOT5K3krB0NMKSHQ==
X-CSE-MsgGUID: 2RKshiPrRAaJj2NPy5vYFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="941726"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="941726"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 19:59:33 -0700
X-CSE-ConnectionGUID: ekEGd/pmTK2ZSVIq9+dkBQ==
X-CSE-MsgGUID: 3zEmvfRFQDCFYsmGP+NBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2475091"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa003.fm.intel.com with ESMTP; 18 Oct 2026 19:59:30 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: riana.tauro@intel.com, mallesh.koujalagi@intel.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, christian.koenig@amd.com,
 andrealmeid@igalia.com, Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] drm: Log recovery method with wedged event
Date: Mon, 19 Oct 2026 08:28:52 +0530
Message-ID: <20261019025853.140747-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
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

Currently, drm_dev_wedged_event() logs a basic message of device being
wedged, but doesn't print the recovery method used by the caller. Log it
for easier bug report analysis.

While at it, as the device wedging is a catastrophic event, raise its log
level to drm_warn().

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index cb53baa70995..1a1213f4235c 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -598,8 +598,8 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 		/* Caller is unsure about recovery, do the best we can at this point. */
 		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
 
-	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
-		 "but no recovery needed" : "needs recovery");
+	drm_warn(dev, "device wedged with method %#lx, %s\n", method,
+		 method == DRM_WEDGE_RECOVERY_NONE ? "no recovery needed" : "needs recovery");
 
 	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
 		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
-- 
2.43.0

