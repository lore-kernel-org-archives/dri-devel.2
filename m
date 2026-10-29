Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281C606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KHV7Iv8F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDE010E7CB;
	Thu, 29 Oct 2026 18:10:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A554610E6CD;
 Thu, 29 Oct 2026 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793297441; x=1824833441;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wE1KGWMISXCmcbgsNe7cfzhFrAj048pU9Cp+38MQjm8=;
 b=KHV7Iv8FferkmhEsx9kCh1P8YBGsyBf7fTAY53tpJDESQgFP1rc0nxx1
 5YD9hlwgd5JYb+zUhbQss3faou+5Ac1/Ofl4QLlLoTWBmptq3agkKXYMu
 uVpDBPvQa/64Ls+R/GyAr+4L3WsIioxMBCmRbAoqIwCx0/YuK8tkymUPc
 p3RCtcV1cXMUWT6t5W8cOTFoaJVNKaOL6wY9Y1BO+ld4FHpIJRxSgHfIv
 hyvzaL1QdCY3lOt45YmrsjnQpJ9MNSmAvb7BiW1e5eVVxj1fOkhf/uPjV
 iZTJRp8RNEgbjYy+a/V5564h7b74y+inQNLSJyQ2wR2q76ZEKzsmUakfb Q==;
X-CSE-ConnectionGUID: MXr30K7kSyKKaEiD766Aug==
X-CSE-MsgGUID: 0sYCYtb4Q3i+XcX7rQ5INg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2078522"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2078522"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 11:10:40 -0700
X-CSE-ConnectionGUID: ODDC9JcyTteGp2++ZtiZUA==
X-CSE-MsgGUID: k80JnlDZRZi89NV/AMCcjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5544265"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2026 11:10:40 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH 1/1] drm/xe: Add support for WA 14028250015
Date: Thu, 29 Oct 2026 11:10:33 -0700
Message-ID: <20261029181039.598756-2-alan.previn.teres.alexis@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The WA is implemented by the GuC, so we just need to enable it via the
dedicated KLV. It makes the GuC complete page reclaim requests that
end in an error, instead of leaving them pending. It is only needed
when the page reclaim HW assist is in use. This WA only applies to
Nova Lake (graphics version 3510).

Assisted-by: LLM
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h | 1 +
 drivers/gpu/drm/xe/xe_guc_ads.c       | 6 ++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules    | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
index 4bcdc1a96785..9357bb925f11 100644
--- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
@@ -526,6 +526,7 @@ enum xe_guc_klv_ids {
 	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
 	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
 	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
+	GUC_WA_KLV_ENABLE_PAGE_RECLAIM_ERROR_COMPLETION					= 0x9012,
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 43a2951a66d6..7d7b44293a08 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -389,6 +389,12 @@ static void guc_waklv_init(struct xe_guc_ads *ads)
 		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
 				 GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB);
 
+	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */
+	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78) &&
+	    gt_to_xe(gt)->info.has_page_reclaim_hw_assist)
+		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
+				 GUC_WA_KLV_ENABLE_PAGE_RECLAIM_ERROR_COMPLETION);
+
 	/*
 	 * On GuC firmware 70.66 and above, use the Feature KLV (shared with the
 	 * WA KLV buffer); older firmware uses GUC_CTL_DISABLE_MULTI_QUEUE in
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 96132c6e3340..c73694aa40ca 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -77,3 +77,4 @@
 14025941587	GRAPHICS_VERSION_RANGE(2001, 3511), FUNC(xe_rtp_match_not_sriov_vf)
 		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
 16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
+14028250015	GRAPHICS_VERSION(3510)

base-commit: d8a353e238652bec29fd452babdaae0044d30b9b
-- 
2.43.0

