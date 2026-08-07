Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BC7C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8018D10F3DF;
	Fri,  7 Aug 2026 04:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eoCvWHx1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD9E10F3DF;
 Fri,  7 Aug 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077184; x=1817613184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cWpXR0D92UHH8pNdJEE/BM1n+ase1elILYHN+SF2ouA=;
 b=eoCvWHx1rG7HP7pY8dA766NIUAJCWw7sBZ+tLyIMcu+JQB0JA43jrpcz
 CS/y3X0CNrcLOPL1c7R6NHf2GUpndoSkcn93ETcQoFn+odFUJhm0sy3rF
 UItJ2RsAiwI84RzrCkocP83w+b5RCpHfVw19S/IdWQvOBIUfkt2T4fSf0
 ZuocYtebdKoA68PQb8okMVOC7nEJV9aRzmPPZILCRZha6ErVoBOXUuaz6
 sRRMgXtbOlJP7lg6l2qgxoWGkfnH9J9CGOsu17ePwinyfjv7ALodqR2qM
 vpzXE5RtrM9RA8UDM7v3FQFPQaEO1u3mi0asmv8bJcKBLpN45jUu4zFHO w==;
X-CSE-ConnectionGUID: YYSL9hbgTC+ziL23+QQ4Ag==
X-CSE-MsgGUID: anHaM1xNR328i1ZByH43FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619384"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619384"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:04 -0700
X-CSE-ConnectionGUID: k5YWus4fS1+I/63kKC/6BQ==
X-CSE-MsgGUID: jsQiFSySSc2cucnPO3FX7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666562"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:02 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 38/44] drm/i915/hdmi: Add support for sending uevent to user
 for FRL training failure
Date: Fri,  7 Aug 2026 09:44:23 +0530
Message-ID: <20260807041430.229038-39-ankit.k.nautiyal@intel.com>
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

In case of HDMI FRL training failure for a given mode, the user
should be sent a uevent signalling Link failure.

Add support for sending uevent to userspace in case of link training
failure.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 0977c7011dd3..e30adda6dac2 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -71,6 +71,8 @@
 #include "intel_snps_phy.h"
 #include "intel_vrr.h"
 
+#define HAS_HDMI_FRL(__display)		(DISPLAY_VER((__display)) >= 14)
+
 bool intel_hdmi_is_frl(u32 clock)
 {
 	static const u32 rates[] = { 300000, 600000, 800000, 1000000, 1200000 };
@@ -3363,6 +3365,31 @@ void intel_infoframe_init(struct intel_digital_port *dig_port)
 	}
 }
 
+/* Common code with DP, need to put in a common place */
+static void intel_hdmi_modeset_retry_work_fn(struct work_struct *work)
+{
+	struct intel_connector *intel_connector;
+	struct drm_connector *connector;
+
+	intel_connector = container_of(work, typeof(*intel_connector),
+				       modeset_retry_work);
+	connector = &intel_connector->base;
+	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id,
+		      connector->name);
+
+	/* Grab the locks before changing connector property*/
+	mutex_lock(&connector->dev->mode_config.mutex);
+	/*
+	 * Set connector link status to BAD and send a Uevent to notify
+	 * userspace to do a modeset.
+	 */
+	drm_connector_set_link_status_property(connector,
+					       DRM_MODE_LINK_STATUS_BAD);
+	mutex_unlock(&connector->dev->mode_config.mutex);
+	/* Send Hotplug uevent so userspace can reprobe */
+	drm_kms_helper_hotplug_event(connector->dev);
+}
+
 bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 			       struct intel_connector *intel_connector)
 {
@@ -3436,6 +3463,11 @@ bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 	if (!intel_hdmi->cec_notifier)
 		drm_dbg_kms(display->drm, "CEC notifier get failed\n");
 
+	/* Initialize the work for modeset in case of link train failure */
+	if (HAS_HDMI_FRL(display))
+		INIT_WORK(&intel_connector->modeset_retry_work,
+			  intel_hdmi_modeset_retry_work_fn);
+
 	return true;
 }
 
-- 
2.50.1

