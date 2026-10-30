Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32290606A332
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gv6Quera
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7566A112786;
	Fri, 30 Oct 2026 12:04:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72F2112786;
 Fri, 30 Oct 2026 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361842; x=1824897842;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BnmPByeo+Wvu12Ms567731UvLqfj2LzBYiiTGkG5L/I=;
 b=gv6Quera8DRXUGTK6zxjt5ZQ8/1lXmyOM2j0GEZ0AOoFAN5Cf7w4iJkp
 F6lsehDS7vpiV1C6nPAN1T9wqkhCoVTBYlBYjOQp5/nJOXXR8pS0mKPcO
 Mt9VSOFWjnQ8IDMyaK0fFpIFNZ8lD/55ZsLwztqXirqgtNPNgsRGz9rxn
 vgqZNXZ036PQkdmuRMAFFabqEpeQDVFpCPFa5Lkki9MjiWPlS7ZVZt1Gu
 LxWnK0qgm73gYkQxyMAQ86sm7M6t8BnXUIpq4Y2OSIrysz97LoQdA7gNv
 wO+Bc3G+XRi+mkmcozFlvqzhfTm2vIG3re0XI76sM+ETP+sC3nCuTNqS4 w==;
X-CSE-ConnectionGUID: Zo4yBG2pRxyAScsUqx14/g==
X-CSE-MsgGUID: 7ZYmU8RCSmCiLlbjTBB71Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2155603"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2155603"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:02 -0700
X-CSE-ConnectionGUID: VGvCDpHxSOqipuZ5/NDUCw==
X-CSE-MsgGUID: AP/fMLfZR5O9D0tQ8P+YtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5382466"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:00 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 10/13] drm/i915/debugfs: pass struct drm_printer to
 intel_hdcp_info()
Date: Fri, 30 Oct 2026 14:03:13 +0200
Message-ID: <4b9eca0b32cff393e07ed66b89768b0dedaf712a.1793361738.git.jani.nikula@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass struct drm_printer to intel_hdcp_info() and __intel_hdcp_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  |  2 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c     | 27 ++++++++++---------
 drivers/gpu/drm/i915/display/intel_hdcp.h     |  4 +--
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 3378e95ab948..442912a1fc02 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -285,7 +285,7 @@ static void intel_connector_info(struct seq_file *m,
 	if (dig_port != NULL && intel_encoder_is_tc(&dig_port->base))
 		intel_tc_info(&p, dig_port);
 
-	intel_hdcp_info(m, intel_connector);
+	intel_hdcp_info(&p, intel_connector);
 
 	seq_printf(m, "\tmax bpc: %u\n", connector->display_info.bpc);
 
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e56df337dc6d..dad0c854e4fa 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -2746,13 +2746,13 @@ void intel_hdcp_handle_cp_irq(struct intel_connector *connector)
 	queue_delayed_work(display->wq.unordered, &hdcp->check_work, 0);
 }
 
-static void __intel_hdcp_info(struct seq_file *m, struct intel_connector *connector,
+static void __intel_hdcp_info(struct drm_printer *p, struct intel_connector *connector,
 			      bool remote_req)
 {
 	bool hdcp_cap = false, hdcp2_cap = false;
 
 	if (!connector->hdcp.shim) {
-		seq_puts(m, "No Connector Support");
+		drm_puts(p, "No Connector Support");
 		goto out;
 	}
 
@@ -2764,31 +2764,32 @@ static void __intel_hdcp_info(struct seq_file *m, struct intel_connector *connec
 	}
 
 	if (hdcp_cap)
-		seq_puts(m, "HDCP1.4 ");
+		drm_puts(p, "HDCP1.4 ");
 	if (hdcp2_cap)
-		seq_puts(m, "HDCP2.2 ");
+		drm_puts(p, "HDCP2.2 ");
 
 	if (!hdcp_cap && !hdcp2_cap)
-		seq_puts(m, "None");
+		drm_puts(p, "None");
 
 out:
-	seq_puts(m, "\n");
+	drm_puts(p, "\n");
 }
 
-void intel_hdcp_info(struct seq_file *m, struct intel_connector *connector)
+void intel_hdcp_info(struct drm_printer *p, struct intel_connector *connector)
 {
-	seq_puts(m, "\tHDCP version: ");
+	drm_puts(p, "\tHDCP version: ");
 	if (connector->mst.dp) {
-		__intel_hdcp_info(m, connector, true);
-		seq_puts(m, "\tMST Hub HDCP version: ");
+		__intel_hdcp_info(p, connector, true);
+		drm_puts(p, "\tMST Hub HDCP version: ");
 	}
-	__intel_hdcp_info(m, connector, false);
+	__intel_hdcp_info(p, connector, false);
 }
 
 static int intel_hdcp_sink_capability_show(struct seq_file *m, void *data)
 {
 	struct intel_connector *connector = m->private;
 	struct intel_display *display = to_intel_display(connector);
+	struct drm_printer p = drm_seq_file_printer(m);
 	int ret;
 
 	ret = drm_modeset_lock_single_interruptible(&display->drm->mode_config.connection_mutex);
@@ -2801,9 +2802,9 @@ static int intel_hdcp_sink_capability_show(struct seq_file *m, void *data)
 		goto out;
 	}
 
-	seq_printf(m, "%s:%d HDCP version: ", connector->base.name,
+	drm_printf(&p, "%s:%d HDCP version: ", connector->base.name,
 		   connector->base.base.id);
-	__intel_hdcp_info(m, connector, false);
+	__intel_hdcp_info(&p, connector, false);
 
 out:
 	drm_modeset_unlock(&display->drm->mode_config.connection_mutex);
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.h b/drivers/gpu/drm/i915/display/intel_hdcp.h
index efe86808e17e..00f2b265ab4a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.h
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.h
@@ -12,6 +12,7 @@
 
 struct drm_connector;
 struct drm_connector_state;
+struct drm_printer;
 struct intel_atomic_state;
 struct intel_connector;
 struct intel_crtc_state;
@@ -19,7 +20,6 @@ struct intel_digital_port;
 struct intel_display;
 struct intel_encoder;
 struct intel_hdcp_shim;
-struct seq_file;
 enum port;
 
 void intel_hdcp_atomic_check(struct drm_connector *connector,
@@ -44,7 +44,7 @@ void intel_hdcp_component_fini(struct intel_display *display);
 void intel_hdcp_cleanup(struct intel_connector *connector);
 void intel_hdcp_handle_cp_irq(struct intel_connector *connector);
 
-void intel_hdcp_info(struct seq_file *m, struct intel_connector *connector);
+void intel_hdcp_info(struct drm_printer *p, struct intel_connector *connector);
 void intel_hdcp_connector_debugfs_add(struct intel_connector *connector);
 
 #endif /* __INTEL_HDCP_H__ */
-- 
2.47.3

