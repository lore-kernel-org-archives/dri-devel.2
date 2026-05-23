Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04881CD4F54
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 05:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6581E10E59D;
	Sat, 23 May 2026 05:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kozssqpE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A7610E59D;
 Sat, 23 May 2026 05:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779512758; x=1811048758;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pF/TIbDvvyTDflo+TREt8z0N3GWmn0HA7LV7P+DENy4=;
 b=kozssqpEXOtyrnP+qBwxWOtT+f9SNCLg+WzWSkQRpo6UmLDwqroFZyfS
 Wd8oIwNwp3UAPe9KSnB+LZGX0qsyIIz8L8dPyzBMXRwABnu7AcdvoxeH8
 oiTJQPn/Ib2L3AAXZZw4pSY3oXzkxQw5LcCerdpMSI9GbxqLxDq0BKT4Q
 /o4OyNmiSFuF6aB5weNugL2uBu34z4FqTkEfWefqyK/l1iL6/0WekM6cy
 UDYVTPlPTZjOqyRGKluxagz3tOWExMRfLd5NLZmtOZLFfvTu/5EG3zh6X
 j0PgD6rvflWbwvnnuX5uBEXmEZyD2CK2kHIZyJR103LC11m11PcjfuJlG w==;
X-CSE-ConnectionGUID: i8JJ5ibSQ6eXVnVuy5bS6A==
X-CSE-MsgGUID: X+cCvBtkRL+qPi0d18AIJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013554"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="83013554"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 22:05:57 -0700
X-CSE-ConnectionGUID: AusxtXPxS6KEfAAZkbz4PA==
X-CSE-MsgGUID: UrrlWrWiQbKeeT3RIfjkSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="279199765"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:55 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
Date: Sat, 23 May 2026 10:30:22 +0530
Message-ID: <20260523050212.557292-5-raag.jadav@intel.com>
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

Hardware errors should be logged with HW_ERR prefix. Make them
consistent with existing logs.

Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 5135e8e4093f..4b72959b2276 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
 	struct xe_device *xe = tile_to_xe(tile);
 
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
+		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
 	else
-		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
+		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
 }
 
 static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
@@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
 	struct xe_device *xe = tile_to_xe(tile);
 
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
+		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
 			 name, severity_str, i, err);
 	else
-		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
+		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
 				    name, severity_str, i, err);
 }
 
@@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
 
 	if (strcmp(name, "Undefined")) {
 		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
+			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
 		else
-			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
+			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
 		atomic_inc(&info[index].counter);
 	}
 }
-- 
2.43.0

