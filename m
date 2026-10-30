Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C69606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bqyJY6FQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DA11127AD;
	Fri, 30 Oct 2026 12:04:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D161127AD;
 Fri, 30 Oct 2026 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361848; x=1824897848;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cdZgDrBnHy78bVy5sJJw+CjUsKEMPSJ+E+2fn+6L0cg=;
 b=bqyJY6FQl1vxiQ6+gEADWlcUDk90GX+Ir36cvrfA06B+eouoO/Dl/dpQ
 lwi+xUu22OS+5bjQnLw8z6MF7oTzy9ED9mU9Pvv2NTHM4zawLglYqnkOI
 z8InSN6IaxQX3+vFmrhITHzPKd2LpQ1GfnCwHvLz62CJeXaSZjIE0yD2w
 cszeZYUPW+/Ph1KeLlZMKk49I519pHSvu7a9cV7/QGlY7c/ay0Ex/iqKJ
 9l1GsIqQmAC6887AePqFciY5qms8Bmwd4zeZUfiHS4frICtkz6ERgbUaS
 elMZbXY08qlvLuxZORraEEVR0PrSE8hCLK8ByD/LkkgEp+MpFy7zi4sKc A==;
X-CSE-ConnectionGUID: pVGqjAcVTo2zH7bV674lQA==
X-CSE-MsgGUID: TpBoWPgEQ0qeoU+hp9x3og==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2155619"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2155619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:08 -0700
X-CSE-ConnectionGUID: BjN2tXqhR1WZeDxqvt7mzQ==
X-CSE-MsgGUID: zMq2UNgZRVKNAfIgBrP4XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5382540"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:05 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 11/13] drm/i915/debugfs: refactor intel_seq_print_mode() into
 intel_print_mode()
Date: Fri, 30 Oct 2026 14:03:14 +0200
Message-ID: <c5101216d34e868aaa3b50bb5f0835c6ee367e78.1793361738.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793361738.git.jani.nikula@intel.com>
References: <cover.1793361738.git.jani.nikula@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass struct drm_printer to intel_seq_print_mode() and rename to
intel_print_mode(). Use drm_printf_indent() instead of
hand-rolling. Also pass struct drm_printer to intel_panel_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 442912a1fc02..3844c909efc6 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -165,15 +165,10 @@ static int i915_power_domain_info(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static void intel_seq_print_mode(struct seq_file *m, int tabs,
-				 const struct drm_display_mode *mode)
+static void intel_print_mode(struct drm_printer *p, int indent,
+			     const struct drm_display_mode *mode)
 {
-	int i;
-
-	for (i = 0; i < tabs; i++)
-		seq_putc(m, '\t');
-
-	seq_printf(m, DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
+	drm_printf_indent(p, indent, DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 }
 
 static void intel_encoder_info(struct drm_printer *p,
@@ -200,7 +195,7 @@ static void intel_encoder_info(struct drm_printer *p,
 	drm_connector_list_iter_end(&conn_iter);
 }
 
-static void intel_panel_info(struct seq_file *m,
+static void intel_panel_info(struct drm_printer *p,
 			     struct intel_connector *connector)
 {
 	const struct drm_display_mode *fixed_mode;
@@ -208,10 +203,10 @@ static void intel_panel_info(struct seq_file *m,
 	if (list_empty(&connector->panel.fixed_modes))
 		return;
 
-	seq_puts(m, "\tfixed modes:\n");
+	drm_puts(p, "\tfixed modes:\n");
 
 	list_for_each_entry(fixed_mode, &connector->panel.fixed_modes, head)
-		intel_seq_print_mode(m, 2, fixed_mode);
+		intel_print_mode(p, 2, fixed_mode);
 }
 
 static void intel_dp_info(struct drm_printer *p, struct intel_connector *connector)
@@ -289,11 +284,11 @@ static void intel_connector_info(struct seq_file *m,
 
 	seq_printf(m, "\tmax bpc: %u\n", connector->display_info.bpc);
 
-	intel_panel_info(m, intel_connector);
+	intel_panel_info(&p, intel_connector);
 
 	seq_printf(m, "\tmodes:\n");
 	list_for_each_entry(mode, &connector->modes, head)
-		intel_seq_print_mode(m, 2, mode);
+		intel_print_mode(&p, 2, mode);
 }
 
 static const char *plane_type(enum drm_plane_type type)
-- 
2.47.3

