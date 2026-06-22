Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1ABCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE7F10E6CC;
	Mon, 22 Jun 2026 13:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NML5yTbd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D83910E6CF;
 Mon, 22 Jun 2026 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782134328; x=1813670328;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jEGsWUVo2VheDQgbV/t+AH92apxzxBxXajTAlKhdPxk=;
 b=NML5yTbd6UtZfg0OSp8oST21wMJWAY8jnl+l3MRsVsomDb2YozJDziAH
 zstVNzPLG1abfYRoa8QkGx/F4RbULrO9dt0jPJhtST5cqWJXv1SNcJ4Se
 56lv0RA199Ii+1ltrYxqNbgH2HuiluBxAvdTKffDwy4tAleN9W2h5YX07
 odGRAOvFnxpHGn/qKjSc0uGzrRgLrSt49PjCBVZIsPV4kcgrgJAG9Qk0P
 IgaqMq8slxXDRuUI3sIoMFQLraj+WIQNS2HzxGjqCHZq1P/UGezYIeMTc
 egtJtPkHw0UkasNpdjrymekMNaKe/3rG3WfaNxxHt6m8HfD0wVkAEp69l g==;
X-CSE-ConnectionGUID: Gmij5AegTSCurQBhgSF5Mg==
X-CSE-MsgGUID: qxSCo27YQr+NlCdzKYuzLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93458814"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93458814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 06:18:48 -0700
X-CSE-ConnectionGUID: 3LhqNIWuSsG8OVW6MllF5w==
X-CSE-MsgGUID: N7k3KrBWR/GStI3CpnwBow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="245074759"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa010.fm.intel.com with ESMTP; 22 Jun 2026 06:18:44 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v9 4/6] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Mon, 22 Jun 2026 18:45:03 +0530
Message-ID: <20260622131458.144873-12-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
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

When PUNIT (power management unit) errors are detected that persist across
warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
and notify userspace that a complete device power cycle is required to
restore normal operation.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v3:
- Use PUNIT instead of PMU. (Riana)
- Use consistent wording.
- Remove log. (Raag)

v4:
- Make function static. (Raag)

v5:
- Remove kdoc for static function. (Raag)
- Remove xe_ prefix for static function.

v9:
- Remove unwanted header. (Sashiko)
---
 drivers/gpu/drm/xe/xe_ras.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index d6db0e98586f..1eb2bbaccd9b 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -256,6 +256,12 @@ static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
 	return pci_upstream_bridge(vsp);
 }
 
+static void punit_error_handler(struct xe_device *xe)
+{
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_device_declare_wedged(xe);
+}
+
 static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *xe,
 							      struct xe_ras_error_array *arr)
 {
@@ -288,7 +294,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
 			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
 			       sev_to_str(counter->common.severity),
 			       ieh_error->global_error_status);
-			/* TODO: Add PUNIT error handling */
+			punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
-- 
2.34.1

