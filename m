Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9CE606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=msulunQd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B211127A9;
	Fri, 30 Oct 2026 12:04:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354FD1127A9;
 Fri, 30 Oct 2026 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361838; x=1824897838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lXYxZW1Avb9EOMjZyM77MoFGOm7HhFnqYintNhkQo08=;
 b=msulunQd8y+lD4vVDoTZh9VHyCuTYQH2unR21Q9P9ohYGadoJahHomkB
 /AObViyc7JuLi4p6SNXmBgnqy7QsS3vOLsse9E/LPhVCorV41mhebHp2p
 NLUrkBjONDcNK+axeTjtnr/Qel7zFui/5P0i1/5kFFZZ3qXPiQU158I0E
 4SgaYlrsX+BH1AGhv9Cvu08/5QxKm4Q1KXSJbsNv/QOC7iOEiO3yiQDis
 XhHtFXHOGb1TSb9IzDKEQjT+N664KZsvPY5eOrURlqs/+Yr0msnhQUCPR
 e2J13+4cv1HNIL3fWfpdR6wHYLbWmZfAm4HER27wGxQeHLyTyFsJztf5w A==;
X-CSE-ConnectionGUID: sdh+Q5itSTWAAKpnGqtG/Q==
X-CSE-MsgGUID: wqzzs7txTUeO3DliUhTLlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2155592"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2155592"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:57 -0700
X-CSE-ConnectionGUID: LXRw/SDiS1qEo9jlYXhrFg==
X-CSE-MsgGUID: CgH2zfvsTriBsnxeWj4j7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5382438"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:56 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 09/13] drm/i915/debugfs: pass struct drm_printer to intel_{dp,
 dp_mst, hdmi}_crtc_info()
Date: Fri, 30 Oct 2026 14:03:12 +0200
Message-ID: <fbe87ba2285dcc3c03b462202b3c66468c40ad3d.1793361738.git.jani.nikula@intel.com>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass struct drm_printer to intel_dp_info(), intel_dp_mst_info(), and
intel_hdmi_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 3faee47e5854..3378e95ab948 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -214,34 +214,33 @@ static void intel_panel_info(struct seq_file *m,
 		intel_seq_print_mode(m, 2, fixed_mode);
 }
 
-static void intel_dp_info(struct seq_file *m, struct intel_connector *connector)
+static void intel_dp_info(struct drm_printer *p, struct intel_connector *connector)
 {
 	struct intel_encoder *intel_encoder = intel_attached_encoder(connector);
 	struct intel_dp *intel_dp = enc_to_intel_dp(intel_encoder);
-	struct drm_printer p = drm_seq_file_printer(m);
 
-	seq_printf(m, "\tDPCD rev: %x\n", intel_dp->dpcd[DP_DPCD_REV]);
-	seq_printf(m, "\taudio support: %s\n",
+	drm_printf(p, "\tDPCD rev: %x\n", intel_dp->dpcd[DP_DPCD_REV]);
+	drm_printf(p, "\taudio support: %s\n",
 		   str_yes_no(connector->base.display_info.has_audio));
 
-	drm_dp_downstream_debug(&p, intel_dp->dpcd, intel_dp->downstream_ports,
+	drm_dp_downstream_debug(p, intel_dp->dpcd, intel_dp->downstream_ports,
 				connector->detect_edid, &intel_dp->aux);
 }
 
-static void intel_dp_mst_info(struct seq_file *m,
+static void intel_dp_mst_info(struct drm_printer *p,
 			      struct intel_connector *connector)
 {
 	bool has_audio = connector->base.display_info.has_audio;
 
-	seq_printf(m, "\taudio support: %s\n", str_yes_no(has_audio));
+	drm_printf(p, "\taudio support: %s\n", str_yes_no(has_audio));
 }
 
-static void intel_hdmi_info(struct seq_file *m,
+static void intel_hdmi_info(struct drm_printer *p,
 			    struct intel_connector *connector)
 {
 	bool has_audio = connector->base.display_info.has_audio;
 
-	seq_printf(m, "\taudio support: %s\n", str_yes_no(has_audio));
+	drm_printf(p, "\taudio support: %s\n", str_yes_no(has_audio));
 }
 
 static void intel_connector_info(struct seq_file *m,
@@ -270,13 +269,13 @@ static void intel_connector_info(struct seq_file *m,
 	case DRM_MODE_CONNECTOR_DisplayPort:
 	case DRM_MODE_CONNECTOR_eDP:
 		if (intel_connector->mst.dp)
-			intel_dp_mst_info(m, intel_connector);
+			intel_dp_mst_info(&p, intel_connector);
 		else
-			intel_dp_info(m, intel_connector);
+			intel_dp_info(&p, intel_connector);
 		dig_port = dp_to_dig_port(intel_attached_dp(intel_connector));
 		break;
 	case DRM_MODE_CONNECTOR_HDMIA:
-		intel_hdmi_info(m, intel_connector);
+		intel_hdmi_info(&p, intel_connector);
 		dig_port = hdmi_to_dig_port(intel_attached_hdmi(intel_connector));
 		break;
 	default:
-- 
2.47.3

