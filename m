Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124E9CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E7310E4A0;
	Mon, 12 Oct 2026 04:15:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544BF10E497;
 Mon, 12 Oct 2026 04:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778509; x=1823314509;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9j6D9JaPkCNYO1vqiMmN0HFZeVy0Pu5V3GEdGeziUwI=;
 b=MtlvID0CMkbmdAtcCMhbrdC1Pxt1vJNAmy3RYEigtgbebQwKFI7o+Z+e
 m/rat8oRtgPkkCjGUF16UsxcE3/VmmZjF6ExJC1gdUW5tnCq/STvXlR/S
 aiQ5sQPMbH9cBq0x979mwdeR+510wCKdKgygFO+tDL4lxjTiaO/2f5b5i
 ULDZ7uyo5Gtt6dyIc6Q8REc3n6nc7xTJIyazSHTHmqXylA8QE6D5rFWsI
 4j/titx8e7qi5Xq4oEGHk2viWe0AKoW57WDimXpV1CaNpUmgg+79a0yEe
 +3Lzw9UBuQzi7mpuAmSd3ECnXkgSknnzLght1ShiizT7XtC/QCj4cLw3W Q==;
X-CSE-ConnectionGUID: IOQeS6L+RY2mKEwfekjLRw==
X-CSE-MsgGUID: ncC+cVcNTxqZC3/mU07CDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380892"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380892"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:04 -0700
X-CSE-ConnectionGUID: xyf88hp5SX+8sWZSVbGWjA==
X-CSE-MsgGUID: BOSUgDWBSL6b3r/1XsiBpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256465"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:03 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 22/56] drm/i915/ltphy: Verify HDMI FRL tables
Date: Mon, 12 Oct 2026 09:27:31 +0530
Message-ID: <20261012035806.3361439-23-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
index 7ac0888cdf45..4223d806ffd7 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2630,6 +2630,9 @@ static void intel_lt_phy_pll_verify_params(struct intel_display *display,
 	if (!pll_params->is_hdmi)
 		return;
 
+	if (intel_hdmi_is_frl(pll_params->clock_rate))
+		return;
+
 	if (intel_lt_phy_calculate_hdmi_state(&pll_state, pll_params->clock_rate) != 0)
 		return;
 
-- 
2.50.1

