Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E49CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3334F10E73A;
	Mon, 12 Oct 2026 04:15:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DA310E4C6;
 Mon, 12 Oct 2026 04:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778535; x=1823314535;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aeNHcM8VXFNrBsFL4cs2jQNAA/CuoHy1u6KOV9yR9Ng=;
 b=djbOvEBVYa+/gAw5qiUBU/xAtYE09gjSA4dLkcayY5/Qfd6nc8w97MaX
 mDJCQQSVXMksHdJC5KVSsv/FY0kD3X2YAQJ50iOb6VRU+NRKnv2DF993/
 6McuslbX6YSUftIkOUofY0WSfkRhShSc3KaF9LZln9nYTuPriU8r7BYHA
 RaolNHlOcnfoiDKC03Xnt5YwhUBuZrUuJzk9mJLjv5D7s2XyFd5xdkzwd
 5cGWSD7DWq2eWYjl7dMa9WdZsgW2KjaXuaBpDv6ozcC6aGVN9bfO+abNJ
 BFSxAk1Bw1CsgyKvGEtqr36SPmb91fo7aV0sUFA/V0jE+XapcFWUzGAjv g==;
X-CSE-ConnectionGUID: r3RTOSxCTgu+S0XLw3Irsw==
X-CSE-MsgGUID: J3p3IWnxSEOm7VyIqTPs4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380925"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380925"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:33 -0700
X-CSE-ConnectionGUID: +GcnYX5DTcGQOBtNA6Ur9Q==
X-CSE-MsgGUID: KQonNTMjTsW+c0U22zzoHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256592"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:32 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 35/56] drm/i915/hdmi: Rename mode clock valid to specify
 tmds clock
Date: Mon, 12 Oct 2026 09:27:44 +0530
Message-ID: <20261012035806.3361439-36-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

The existing mode clock valid function takes care of the TMDS mode of
transmission. Specify the mode clock valid type explicitly as tmds.
This will pave way to add a separate mode clock valid function for
FRL mode.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 01476f659717..67228b538e81 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1985,9 +1985,9 @@ static bool intel_hdmi_sink_bpc_possible(struct drm_connector *_connector,
 }
 
 static enum drm_mode_status
-intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
-			    bool has_hdmi_sink,
-			    enum intel_output_format sink_format)
+intel_hdmi_tmds_mode_clock_valid(struct drm_connector *_connector, int clock,
+				 bool has_hdmi_sink,
+				 enum intel_output_format sink_format)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
 	struct intel_display *display = to_intel_display(connector);
@@ -2063,7 +2063,7 @@ intel_hdmi_mode_valid_format(struct intel_connector *connector,
 	if (status != MODE_OK)
 		return status;
 
-	return intel_hdmi_mode_clock_valid(&connector->base, clock, has_hdmi_sink, sink_format);
+	return intel_hdmi_tmds_mode_clock_valid(&connector->base, clock, has_hdmi_sink, sink_format);
 }
 
 static enum drm_mode_status
-- 
2.50.1

