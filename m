Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE1606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDMWFg11
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C14210E3B6;
	Tue, 27 Oct 2026 22:59:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8D510E3B6;
 Tue, 27 Oct 2026 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793141974; x=1824677974;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EIbFAeSjRAQfntQmVjRWLxsMGMOqy4PbMnghhVcKLBI=;
 b=VDMWFg11g4Ym3EfHolgqqAZVIuo5kTrlKi/vV5oSwf718pgll9FoA1nm
 J8t1PI6dmqc363/miHp3D21HlxD4sB5zGDNfUxEGzNlSIozHxeg60eSFJ
 Tfxytv9qZxfx+x2ReYkhxC1BNXTB6lFzu2FNfuZeLXf0LHskyjmEQPFy/
 XgKVljv/mULJv35VvcSia6pw4WuhBJfTgTMmvtBSunsgP4qrEtCXaabV0
 vgnR/m+pqIJP9RjU5mxthdstqDRxrboePqfh8fEaBz2Wke9CUVMXYXfyk
 YRm6OuRTNBMLALsRpkUJsid+Alc3ze15M7XVdFbObeVLk3b/AVfYbTVFC Q==;
X-CSE-ConnectionGUID: FFvkzV2/TTi0+3xwjYkkew==
X-CSE-MsgGUID: c7+4wEHBTlCdfGK4nKZuTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1843012"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1843012"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 15:59:34 -0700
X-CSE-ConnectionGUID: F24MA8+rQX6X18VsYehDbg==
X-CSE-MsgGUID: 7ne9XpyWS4OuBAiex7Ku0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5013321"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa001.fm.intel.com with ESMTP; 27 Oct 2026 15:59:34 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Subject: [PATCH 1/1] drm/xe/guc: Add WA 14028709524 to disable PRL from VF
Date: Tue, 27 Oct 2026 15:59:29 -0700
Message-ID: <20261027225932.337738-2-alan.previn.teres.alexis@intel.com>
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

For NVL-P, hardware and firmware support for Page Reclaim
List assistance is disabled when running in VF mode.

Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c        | 8 ++++++--
 drivers/gpu/drm/xe/xe_wa_oob.rules | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index b1f4e132fa0c..613ea9b073c8 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -795,8 +795,12 @@ int xe_guc_init(struct xe_guc *guc)
 	if (!xe_uc_fw_is_enabled(&guc->fw))
 		return 0;
 
-	/* Disable page reclaim if GuC FW does not support */
-	if (GUC_SUBMIT_VER(guc) < MAKE_GUC_VER(1, 14, 0))
+	/*
+	 * Disable page reclaim hw assist if GuC FW does not support it
+	 * yet or a hw WA requires disabling it in VF mode.
+	 */
+	if (GUC_SUBMIT_VER(guc) < MAKE_GUC_VER(1, 14, 0) ||
+	    (IS_SRIOV_VF(xe) && XE_GT_WA(gt, 14028709524)))
 		xe->info.has_page_reclaim_hw_assist = false;
 
 	/* Disable indirect_ring_state if missing GuC 70.53+ WA 14025515070. */
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 63d695f40214..2971dd5b372c 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -76,3 +76,4 @@
 14025941587	GRAPHICS_VERSION_RANGE(2001, 3511), FUNC(xe_rtp_match_not_sriov_vf)
 		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
 16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
+14028709524	GRAPHICS_VERSION(3510)

base-commit: adaeb3881f12295309596acf2387c3f00b3050bb
-- 
2.43.0

