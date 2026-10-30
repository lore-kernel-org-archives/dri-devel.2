Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC7606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HXOlIC3T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33491127BD;
	Fri, 30 Oct 2026 12:04:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3823F1127AA;
 Fri, 30 Oct 2026 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361852; x=1824897852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rhPHjrWbAPkEdngOM7Bdg/yE5mO56K4MEMyyzNI3bo4=;
 b=HXOlIC3Ty46cqZRDiCYrkibZaZXcKQnVxS4EBnUtanjc6RFe/A+sPTfK
 GHysYgI4r2faRZ/4D+ZlNtiLyyva2MCH1HxsumNFcInf9vDzuvUES/NzL
 SlKmE1rgKiVNqJEZUrqdxKLNod3KZsAbZNbrqF+klSjA2va23AIVyFxr2
 EdYE/hdbR6qK7ZT3c2NaEgJlzMHsP175BNmLUiYoWZruukCZ3T+JuT7jA
 pJsG8dRC6XDFK2OJA5DgLkKFq1WJvlHpxVotgtkoMc2hIIOa1eHRtNkYP
 X4I1pWglWZwRSyUdf9cS7zlwWDSbsN2TGFmmNYrq6kKcTNAYjcRXb6AWt Q==;
X-CSE-ConnectionGUID: 0RExpmdBQrym3l2zN/pKJA==
X-CSE-MsgGUID: NZRDqzBiQX+N4Ua3qUpYzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2155623"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2155623"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:11 -0700
X-CSE-ConnectionGUID: jRii74NOQmipMR3vJKMd0w==
X-CSE-MsgGUID: vQ1yBuRDShSqGx+bGMf6iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5382569"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:10 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 12/13] drm/i915/debugfs: pass struct drm_printer to
 intel_connector_info()
Date: Fri, 30 Oct 2026 14:03:15 +0200
Message-ID: <51c41802db5729d7dab73023a59ad6ee5750fce8.1793361738.git.jani.nikula@intel.com>
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

Pass struct drm_printer to intel_connector_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 3844c909efc6..a0644959d30e 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -238,39 +238,38 @@ static void intel_hdmi_info(struct drm_printer *p,
 	drm_printf(p, "\taudio support: %s\n", str_yes_no(has_audio));
 }
 
-static void intel_connector_info(struct seq_file *m,
+static void intel_connector_info(struct drm_printer *p,
 				 struct drm_connector *connector)
 {
 	struct intel_connector *intel_connector = to_intel_connector(connector);
 	const struct drm_display_mode *mode;
-	struct drm_printer p = drm_seq_file_printer(m);
 	struct intel_digital_port *dig_port = NULL;
 
-	seq_printf(m, "[CONNECTOR:%d:%s]: status: %s\n",
+	drm_printf(p, "[CONNECTOR:%d:%s]: status: %s\n",
 		   connector->base.id, connector->name,
 		   drm_get_connector_status_name(connector->status));
 
 	if (connector->status == connector_status_disconnected)
 		return;
 
-	seq_printf(m, "\tphysical dimensions: %dx%dmm\n",
+	drm_printf(p, "\tphysical dimensions: %dx%dmm\n",
 		   connector->display_info.width_mm,
 		   connector->display_info.height_mm);
-	seq_printf(m, "\tsubpixel order: %s\n",
+	drm_printf(p, "\tsubpixel order: %s\n",
 		   drm_get_subpixel_order_name(connector->display_info.subpixel_order));
-	seq_printf(m, "\tCEA rev: %d\n", connector->display_info.cea_rev);
+	drm_printf(p, "\tCEA rev: %d\n", connector->display_info.cea_rev);
 
 	switch (connector->connector_type) {
 	case DRM_MODE_CONNECTOR_DisplayPort:
 	case DRM_MODE_CONNECTOR_eDP:
 		if (intel_connector->mst.dp)
-			intel_dp_mst_info(&p, intel_connector);
+			intel_dp_mst_info(p, intel_connector);
 		else
-			intel_dp_info(&p, intel_connector);
+			intel_dp_info(p, intel_connector);
 		dig_port = dp_to_dig_port(intel_attached_dp(intel_connector));
 		break;
 	case DRM_MODE_CONNECTOR_HDMIA:
-		intel_hdmi_info(&p, intel_connector);
+		intel_hdmi_info(p, intel_connector);
 		dig_port = hdmi_to_dig_port(intel_attached_hdmi(intel_connector));
 		break;
 	default:
@@ -278,17 +277,17 @@ static void intel_connector_info(struct seq_file *m,
 	}
 
 	if (dig_port != NULL && intel_encoder_is_tc(&dig_port->base))
-		intel_tc_info(&p, dig_port);
+		intel_tc_info(p, dig_port);
 
-	intel_hdcp_info(&p, intel_connector);
+	intel_hdcp_info(p, intel_connector);
 
-	seq_printf(m, "\tmax bpc: %u\n", connector->display_info.bpc);
+	drm_printf(p, "\tmax bpc: %u\n", connector->display_info.bpc);
 
-	intel_panel_info(&p, intel_connector);
+	intel_panel_info(p, intel_connector);
 
-	seq_printf(m, "\tmodes:\n");
+	drm_printf(p, "\tmodes:\n");
 	list_for_each_entry(mode, &connector->modes, head)
-		intel_print_mode(&p, 2, mode);
+		intel_print_mode(p, 2, mode);
 }
 
 static const char *plane_type(enum drm_plane_type type)
@@ -620,7 +619,7 @@ static int i915_display_info(struct seq_file *m, void *unused)
 	seq_printf(m, "--------------\n");
 	drm_connector_list_iter_begin(display->drm, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter)
-		intel_connector_info(m, connector);
+		intel_connector_info(&p, connector);
 	drm_connector_list_iter_end(&conn_iter);
 
 	drm_modeset_unlock_all(display->drm);
-- 
2.47.3

