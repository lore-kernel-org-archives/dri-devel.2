Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ADD606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GgCgaVpC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AEA10E6E9;
	Wed, 18 Nov 2026 01:52:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E7810E6E9;
 Wed, 18 Nov 2026 01:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794966742; x=1826502742;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JzvAYy+mMgwCByAroYj9N8rDne/Z6sbblIq4Fe1MpRs=;
 b=GgCgaVpC8IFJbkd8qYEHQJJbBdx4ERZk00zupOrrH2ZeN9qOgpz0MnH1
 tBAjnee40gFiA8bgRTzY3YxOAPuy9go0quHLxRs6QQOMASpaXev5x/MBH
 NhOY6XvnuHfz6HXbzfB+Knn6/kvo3CuX5dmV3TncLMjav7l5LjGisofiG
 3/CPvaMmskLfZMHRpAo8tEIts3QgnXqKvUcYctB6c2LTI+BTzY+CHN5Ti
 A4k6Oj9rsQgqhsMT6LZL7reRn+Q2f9SksIqvTzzXTwJ79FDI0QZ5HMm5L
 wK8Cte6LRFfl6G/CR8/H9lmxlP5RTmh7q9nARW2z9zo1JFHulqx28oMse Q==;
X-CSE-ConnectionGUID: XVn+2jaFRdyLPrijQFl53A==
X-CSE-MsgGUID: YhRKKBAnQACGn+ozAigBLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3777424"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3777424"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 17:52:21 -0800
X-CSE-ConnectionGUID: IHmTfrMeRRGkZVF1+ha2cg==
X-CSE-MsgGUID: /vNDjvkrTpyMqpQemnh5+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10172462"
Received: from fred-panther-lake-client-platform.sh.intel.com
 ([10.239.144.227])
 by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2026 17:52:18 -0800
From: Fred Gao <fred.gao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, ville.syrjala@linux.intel.com,
 Fred Gao <fred.gao@intel.com>, Chenchen Wang <chenchen.wang@intel.com>
Subject: [PATCH v2] drm/i915/panel: Restrict highest mode to DRRS-compatible
 modes
Date: Wed, 18 Nov 2026 09:49:49 +0800
Message-ID: <20261118014949.399026-1-fred.gao@intel.com>
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

intel_dp_mode_clock() uses intel_panel_highest_mode() when seamless M/N
updates are supported so the link configuration can accommodate every
seamless DRRS refresh rate.

The panel fixed mode list can also contain modes with the same active
size but different blanking timings. Such modes require a full modeset
and cannot participate in a seamless M/N switch. Letting them affect the
highest clock can unnecessarily reduce the selected bpp.

On a 5120x2160 panel, the preferred DisplayID mode uses 717260 kHz, while a
CTA mode with different blanking uses 742500 kHz. HBR2 x4 can carry the
preferred mode at 24 bpp, but not the CTA clock. The latter therefore makes
the link configuration fall back to 18 bpp. The firmware state is 24 bpp,
so the mismatch forces a full modeset and an eDP backlight and panel power
cycle during driver takeover.

Use is_alt_drrs_mode() to consider only fixed modes whose timings and flags
match the adjusted mode. This preserves bandwidth reservation for genuine
seamless DRRS alternatives while excluding modes that would require a full
modeset.

Fixes: 74d6f31fa427 ("drm/i915: Add intel_panel_highest_mode()")
Signed-off-by: Fred Gao <fred.gao@intel.com>
Reviewed-by: Chenchen Wang <chenchen.wang@intel.com>
---
v2:
 - Resubmit as requested by the CI team to trigger a fresh CI run.
   No code changes. The previous IGT failures were caused by unrelated
   patches.

 drivers/gpu/drm/i915/display/intel_panel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81e638d0c7b3..e82082adb4c0 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -192,7 +192,8 @@ intel_panel_highest_mode(struct intel_connector *connector,
 
 	/* pick the fixed_mode that has the highest clock */
 	list_for_each_entry(fixed_mode, &connector->panel.fixed_modes, head) {
-		if (fixed_mode->clock > best_mode->clock)
+		if (is_alt_drrs_mode(fixed_mode, adjusted_mode) &&
+		    fixed_mode->clock > best_mode->clock)
 			best_mode = fixed_mode;
 	}
 
-- 
2.43.0

