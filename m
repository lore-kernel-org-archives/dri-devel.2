Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C2606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O56W9w0m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9C010F0D9;
	Mon,  2 Nov 2026 18:05:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362C910F0D9;
 Mon,  2 Nov 2026 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793642718; x=1825178718;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UqtGetrbrkil/gK1g9r8+25rWujc9kVbr/dtxdfrl6g=;
 b=O56W9w0mjqqCB5NLSEgx1BFi5icSoCUywvRkcG68FtXGxPsjd0ceO8fI
 OpaKhiUt1JjPvaIG6f6/ODjY4tv6/jKmTFCWeCSR25mJMIr9nwKVQ3CPS
 ieiLvFtSqIbH6FWef/ONFW354evfqmaaRR0KNebw6wI/YU2kDjyattjXq
 hJ53pZK7Mx5Gzdze1xcYEloQcaOrfuyKqvjMhW7cxbIXKTuotobUmQa1A
 BsoOAL6Rq80yc9wIYyetMsoiDRlW31ecVeylEwIGUZQUpaNhGlvkcnDI1
 BCSFoC3Y9iSfu4tZ+k2+ga9glk8QLpYy+G9wx7XD1ZpQbyAFFp1WoLCOU Q==;
X-CSE-ConnectionGUID: mEYwpunSQpOY1dGZGcBRTg==
X-CSE-MsgGUID: UKuE+bPiTJapan6+JWUhgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2246121"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2246121"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 10:05:18 -0800
X-CSE-ConnectionGUID: iWJle9Q6Q+O4884NrP2xSA==
X-CSE-MsgGUID: iK+H67SFSamTAfTcA9iWSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6346540"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2026 10:05:17 -0800
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH 1/1] drm/xe: Add support for Wa_14028250015
Date: Mon,  2 Nov 2026 10:05:16 -0800
Message-ID: <20261102180516.1551869-2-alan.previn.teres.alexis@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The WA is implemented by the GuC, so we just need to enable it via the
dedicated KLV. It makes the GuC complete page reclaim requests that
end in an error, instead of leaving them pending. It is only needed
when the page reclaim HW assist is in use. This WA only applies to
graphics version 3510.

v2: Update "Wa" tag to align with others. Don't gate against value of
    has_page_reclaim_hw_assist. Change the #define name to match GuC
    specs. (Gustavo).

Assisted-by: LLM
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h | 1 +
 drivers/gpu/drm/xe/xe_guc_ads.c       | 5 +++++
 drivers/gpu/drm/xe/xe_wa_oob.rules    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
index 4bcdc1a96785..4103de0b1c97 100644
--- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
@@ -526,6 +526,7 @@ enum xe_guc_klv_ids {
 	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
 	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
 	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
+	GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT					= 0x9012,
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index c3ce3c8c905a..1927b595ad67 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -389,6 +389,11 @@ static void guc_waklv_init(struct xe_guc_ads *ads)
 		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
 				 GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB);
 
+	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */
+	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78))
+		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
+				 GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT);
+
 	/*
 	 * On GuC firmware 70.66 and above, use the Feature KLV (shared with the
 	 * WA KLV buffer); older firmware uses GUC_CTL_DISABLE_MULTI_QUEUE in
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 61aa50a63764..fde91192bd46 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -78,3 +78,4 @@
 		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
 16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
 14028709524	GRAPHICS_VERSION(3510)
+14028250015	GRAPHICS_VERSION(3510)

base-commit: 2cd78713d917a02987f21b437561a5e1e13ddda2
-- 
2.43.0

