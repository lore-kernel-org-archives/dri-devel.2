Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C8BF99C6A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B0710EAB2;
	Fri, 17 Apr 2026 21:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ihs1zBhm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88AA210EAB1;
 Fri, 17 Apr 2026 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776460930; x=1807996930;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YUSqL9DlAf/n46deV+1A69QjiVg/CWd6tIqN/O+vudE=;
 b=ihs1zBhmKXSLPsip1eSHq0L0dFitok22l1FoW5Bs7/GsaiTkjfeaaiJj
 bDo6XSSVApaiIHrGeIW109/YyvxHgYtszlqg29xKBWnToTO8v3xzy3rt2
 HNYUbyrhliKtsh+LnupAN/b6DQR8FvflmE7XCQzg0gJBnsfVA7w/yzrj3
 8bwEd3eaY+SA24AH8zbAlHYa5N1VhALC3OsdlZUYei5B7rd2AP0w6UyPI
 /plrrV4khoZp1+khC0a0JNiHC+6F1iJhyCRjKBzfYvFyRFuY6BPRFvDNm
 M0qXQNrHM3pD9OzBOJVLGKM8wQ3TeNAAwqRmFTsmtKUamVjH4HaStYOaL Q==;
X-CSE-ConnectionGUID: xcQnF/NoQWSQovUSSaYdcg==
X-CSE-MsgGUID: tt1dve6IRqyf1aZYKEM4gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046247"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="95046247"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 14:22:10 -0700
X-CSE-ConnectionGUID: VkUmDxybRiifmcHBXL+6aw==
X-CSE-MsgGUID: U+8CMBnhSs608EmIiTWmBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="235503943"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:22:04 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 11/11] drm/xe/ras: Add flag for Xe RAS
Date: Sat, 18 Apr 2026 02:46:46 +0530
Message-ID: <20260417211730.837345-12-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
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

From: Riana Tauro <riana.tauro@intel.com>

Add a flag for RAS. If enabled, XE driver registers with
drm_ras and exposes supported counters.

Currently this is enabled for PVC and CRI.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h | 2 ++
 drivers/gpu/drm/xe/xe_hw_error.c     | 2 +-
 drivers/gpu/drm/xe/xe_pci.c          | 3 +++
 drivers/gpu/drm/xe/xe_pci_types.h    | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 31df9debcbb0..7a8afd06e6b8 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -191,6 +191,8 @@ struct xe_device {
 		u8 has_ctx_tlb_inval:1;
 		/** @info.has_range_tlb_inval: Has range based TLB invalidations */
 		u8 has_range_tlb_inval:1;
+		/** @info.has_ras: Device supports RAS (Reliability, Availability, Serviceability) */
+		u8 has_ras:1;
 		/** @info.has_soc_remapper_sysctrl: Has SoC remapper system controller */
 		u8 has_soc_remapper_sysctrl:1;
 		/** @info.has_soc_remapper_telem: Has SoC remapper telemetry support */
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 2a31b430570e..3ab0fceb151f 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -520,7 +520,7 @@ void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 master_ctl)
 
 static int hw_error_info_init(struct xe_device *xe)
 {
-	if (xe->info.platform != XE_PVC)
+	if (!xe->info.has_ras)
 		return 0;
 
 	return xe_drm_ras_init(xe);
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 278c2860a4f6..10ff207affa9 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -365,6 +365,7 @@ static const __maybe_unused struct xe_device_desc pvc_desc = {
 	.vm_max_level = 4,
 	.vram_flags = XE_VRAM_FLAGS_NEED64K,
 	.has_mbx_power_limits = false,
+	.has_ras = true,
 };
 
 static const struct xe_device_desc mtl_desc = {
@@ -472,6 +473,7 @@ static const struct xe_device_desc cri_desc = {
 	.require_force_probe = true,
 	.va_bits = 57,
 	.vm_max_level = 4,
+	.has_ras = true,
 };
 
 static const struct xe_device_desc nvlp_desc = {
@@ -761,6 +763,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_page_reclaim_hw_assist = desc->has_page_reclaim_hw_assist;
 	xe->info.has_pre_prod_wa = desc->has_pre_prod_wa;
 	xe->info.has_pxp = desc->has_pxp;
+	xe->info.has_ras = desc->has_ras;
 	xe->info.has_soc_remapper_sysctrl = desc->has_soc_remapper_sysctrl;
 	xe->info.has_soc_remapper_telem = desc->has_soc_remapper_telem;
 	xe->info.has_sriov = xe_configfs_primary_gt_allowed(to_pci_dev(xe->drm.dev)) &&
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index 5b85e2c24b7b..70a9d4995cbd 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -54,6 +54,7 @@ struct xe_device_desc {
 	u8 has_pre_prod_wa:1;
 	u8 has_page_reclaim_hw_assist:1;
 	u8 has_pxp:1;
+	u8 has_ras:1;
 	u8 has_soc_remapper_sysctrl:1;
 	u8 has_soc_remapper_telem:1;
 	u8 has_sriov:1;
-- 
2.43.0

