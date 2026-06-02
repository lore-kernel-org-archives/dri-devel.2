Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F47CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B7D10EBB9;
	Tue,  2 Jun 2026 04:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LMXKRQQW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C6A410EBB8;
 Tue,  2 Jun 2026 04:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780376008; x=1811912008;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tsvQCH73Wyi2zeslZOLlyP9kVbT4M3dBOFVXyyISIz8=;
 b=LMXKRQQWoosGZ38SahBOqNL8h4sUOiWnTSKZfL2lKm6a666cwi4pkn6w
 aItXYEFwCwU1YTwRedDXPcIckbWIAebP1lUqH282D6Gd5DwISoymxAyXH
 s994Fe5nFD/zjnyO04nZkR3RuOxYE0/wFxMBi7Sd5E313gkLHWM2QVlDr
 ZiiLxPC11S4taZp30nqtMvP5u+wk6/PQUDGYP5nDoq+ap0cLiCSuV7vqo
 db8kkSRLMlOwVVBMTUchwQx9zFH5SdYnm9+u97w7lqadp3VPw0kqVj7XT
 6UOxfKJPTRFazM5QzFcfYdjSo35qclRItiRAsogrwD1xOniEJiY70olP+ g==;
X-CSE-ConnectionGUID: ZYVaYceKSOqCDyDQ7Bi9wQ==
X-CSE-MsgGUID: gXBpVUvBRMKeJx4Cvfik3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120473"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="81120473"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 21:53:27 -0700
X-CSE-ConnectionGUID: oxPirwg4Sdm3L9Dv3kFd/A==
X-CSE-MsgGUID: YjJiSmBaRJilT9jLZXwq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="245604117"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:24 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 2/4] drm/xe/drm_ras: Make counter allocation drm managed
Date: Tue,  2 Jun 2026 10:18:42 +0530
Message-ID: <20260602044919.702209-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602044919.702209-1-raag.jadav@intel.com>
References: <20260602044919.702209-1-raag.jadav@intel.com>
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

cleanup_node_param() is not registered for previous node in case of counter
allocation failure, which results in stale memory of previous node that
isn't cleaned up on unwind. Fix this using drm managed allocation, which is
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

