Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E87C5ACA8
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77E410F3A0;
	Fri,  7 Aug 2026 04:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DIiKq8K3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D5D10F39A;
 Fri,  7 Aug 2026 04:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077145; x=1817613145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F8hkHDd44mYgxaOg10xNkf+mn+1pLvUSikpQWKibZcM=;
 b=DIiKq8K3MuMrkmh+5LnhDnqYiGWKTbK8Qzg8qumyKU+zpSXvMETs0py7
 GK6cFvgViqQtLKsZ23sQXpvpTGeQyG556EL1E8NOcbcFVgoK9qoAqdB3i
 cUEstGal5RjLu8uu+QEs3aRaGJr7Uy2f/dZzPU9XgvBi1rXDk6DB+0hRC
 8OIy2rUZRSbRKVR/xVIvPVeCz8DbP8aq+Vy3OkS9HmxgVaTiynwV2QAOX
 +Yb2hQTEd6ocAYoOBjKp62U0e9mpJwYXdnTGOkQHf+ObaMgYJ+J09qOnd
 oNnuEc5bWyQ9FWWPFOU5pRZVyB+puCnvqlyLZRqm4BZiDOTa0sU9qkmSk w==;
X-CSE-ConnectionGUID: B2OTvrzXTZG1kMaa4IHjEw==
X-CSE-MsgGUID: os9Ikj8nTSaWiBg61wTucw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619341"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619341"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:24 -0700
X-CSE-ConnectionGUID: pBiE1XWrR+m+8w+u5VKnzg==
X-CSE-MsgGUID: B4EX1UtXSBiMsM2oFwuj2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666315"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:22 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 22/44] drm/i915/ltphy: Verify HDMI FRL tables
Date: Fri,  7 Aug 2026 09:44:07 +0530
Message-ID: <20260807041430.229038-23-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

From: Suraj Kandpal <suraj.kandpal@intel.com>

Verify the HDMI FRL tables now that they are defined.
Also skip recalculating the HDMI state via port clock for HDMI
FRL use case.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lt_phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 918ecb14fb5c..2c1da689fe00 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2628,6 +2628,9 @@ static void intel_lt_phy_pll_verify_params(struct intel_display *display,
 	if (!pll_params->is_hdmi)
 		return;
 
+	if (intel_hdmi_is_frl(pll_params->clock_rate))
+		return;
+
 	if (intel_lt_phy_calculate_hdmi_state(&pll_state, pll_params->clock_rate) != 0)
 		return;
 
-- 
2.50.1

