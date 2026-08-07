Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B72C5ACA8
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6664A10F366;
	Fri,  7 Aug 2026 04:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SW/XuCqo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E1210F36A;
 Fri,  7 Aug 2026 04:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077110; x=1817613110;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CY2einlHtiAZUIsNM8j8KEHPwJI1TxlvLppK80GQraQ=;
 b=SW/XuCqoF9wMSXqW0txzJCSYL/JvbmdtyApH9syON26sm/4SpwWcbd+6
 pws4DCVAoGpROn5c/TTDnxMi8rW0gZzI7Ce+NHvQO0RE+QERyfpOs1wXu
 zH0qGfrsZf+4wQk7EsUq7eayq1W0S/jDOtOlOJxhskTjRo9O1Gfszhz9i
 dPSYm2A8oqHtvZZkDBKAqaLZbMbewoChEnLa+mcYBONY03UUiIPHLsuEW
 PUsn4qJI8K446ipgHmZsUYOpkkX9SJzPY78PrrTC1CNuWQEw+ImtloUlN
 4fRa5Ute974WZGz3DqhyRLjXqOfgaiuOZzbbfZ06zQZCWpLp+hG+Xyx+I w==;
X-CSE-ConnectionGUID: S6yzUlxUSCKTsTNP/t+qRw==
X-CSE-MsgGUID: K/iuD9nsQA+YxadcZTejaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619258"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619258"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:50 -0700
X-CSE-ConnectionGUID: bCGCKvwlTwmrsGwFFEPkfg==
X-CSE-MsgGUID: 0ZQOre/KT1OUeIhUsTNmmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666110"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:47 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 09/44] drm/i915/hdmi: Enable Scrambling only for TMDS mode
Date: Fri,  7 Aug 2026 09:43:54 +0530
Message-ID: <20260807041430.229038-10-ankit.k.nautiyal@intel.com>
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

Enable scrambling in SCDC only for TMDS mode. For FRL mode scrambling
is handled as part of the FRL protocol and should not be configured
via the TMDS scrambling path.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 18d4e79ac54c..b0534fba4e5f 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2430,7 +2430,8 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 
 	pipe_config->lane_count = 4;
 
-	if (scdc->scrambling.supported && source_supports_scrambling(encoder)) {
+	if (scdc->scrambling.supported && source_supports_scrambling(encoder) &&
+	    !pipe_config->frl.enable) {
 		if (scdc->scrambling.low_rates)
 			pipe_config->hdmi_scrambling = true;
 
-- 
2.50.1

