Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42E606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YSMzCaGE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFD11127EB;
	Thu, 19 Nov 2026 23:44:35 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F331127EE;
 Thu, 19 Nov 2026 23:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795131870; x=1826667870;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WA1keZtPPyT5DAM+cYD53Hy97zVENbPrSgF0A2XcbC8=;
 b=YSMzCaGEc5DPtv1KTO5vjrWd+oo7EioORPci1kNtFjF9K+O36vo5R3M+
 ojYB3PeFyHXYqk+ezmODo1pDpaIF9pFh7ltDsac1y5agV37jguuRmw5W8
 pfpoxW3tywHHsFCDz2a41Vk/b/T50yX07gHjcde/MOXz4t99p8zcB5RkS
 XGhb0qO9+U/cGVwioz56Zt9Gd6X5zsgNoY7Y/Z4/dP7k0jizyKtiqKI0F
 GqjAQVpGJX8TObfgfjBMGbFxwn0GpNY47fUbGlxcIK06RCuyaf0ZrnzuT
 P6TCycf1U5PAzb8VHJdXxWA5KxG46eyzgY0Kaqc4+o6s9oiknzhVnleHL Q==;
X-CSE-ConnectionGUID: ooAPLxB0T2WnIE1Ekv81cw==
X-CSE-MsgGUID: HZqvdSgqSYeOoyY158EM6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3994298"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3994298"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 15:44:29 -0800
X-CSE-ConnectionGUID: fo1oyaaPTKKEzGLlT154Fg==
X-CSE-MsgGUID: H0fq8dW4QhmJwSmhOQl0AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10485125"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.202])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 15:44:27 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 1/2] drm/atomic: Add the state->checked WARN to colorop state
Date: Fri, 20 Nov 2026 01:44:22 +0200
Message-ID: <20261119234423.11666-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

drm_atomic_get_colorop_state() didn't get the memo on
commit 0a0e79a2d9ed ("drm/atomic: WARN about invalid
drm_foo_get_state() usage"). Add the missing warning.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_atomic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 81591173265d..b0843e5a9e4d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -742,6 +742,7 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
 	struct drm_colorop_state *colorop_state;
 
 	WARN_ON(!state->acquire_ctx);
+	drm_WARN_ON(state->dev, state->checked);
 
 	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
 	if (colorop_state)
-- 
2.56.0

